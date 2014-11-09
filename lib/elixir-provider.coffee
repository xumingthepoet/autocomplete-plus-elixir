Provider = require "./provider"
Suggestion = require "./suggestion"
path = require 'path'
http = require 'http'
minimatch = require 'minimatch'

module.exports =
class ElixirProvider extends Provider
  #wordRegex: /\b\w*[a-zA-Z_-]+\w*\b/g
  wordRegex: /([a-zA-Z]|:[a-z])[a-zA-Z0-9\._]*/g
  localhost: 'localhost'
  localport: 3000

  asyncBuildSuggestions: (preSuggestions, restProvders, finalCallback) ->
    return @postAsyncBuildSuggestions([], preSuggestions, restProvders, finalCallback) unless @currentFileWhitelisted()

    selection = @editor.getSelection()
    prefix = @prefixOfSelection selection
    return @postAsyncBuildSuggestions([], preSuggestions, restProvders, finalCallback) unless prefix.length

    words = ''

    get = http.get {host: "localhost", port: 3000, path: "/"+prefix}, (res) =>
            res.on 'data', (chunk) ->
              words += chunk.toString()
            res.on 'end', () =>
              if words is ''
                suggestions = []
              else
                words = words.split(',').map((s) -> s.trim())
                suggestions =
                  for word in words
                    [show, word] = word.split(';').map((s) -> s.trim())
                    new Suggestion this, word: word, prefix: prefix, label: 'elixir', show: show
              @postAsyncBuildSuggestions(suggestions, preSuggestions, restProvders, finalCallback)
    get.end()

  currentFileWhitelisted: ->
    whitelist = ("*.ex,*.exs")
      .split ','
      .map (s) -> s.trim()

    fileName = path.basename @editor.getBuffer().getPath()
    for whitelistGlob in whitelist
      if minimatch fileName, whitelistGlob
        return true

    return false
