module.exports =
class Suggestion
  constructor: (@provider, options) ->
    @word = options.word if options.word?
    @show = @word
    @show = options.show if options.show?
    @prefix = options.prefix if options.prefix?
    @label = options.label if options.label?
    @data = options.data if options.data?
    @renderLabelAsHtml = options.renderLabelAsHtml if options.renderLabelAsHtml?
    @className = options.className if options.className?
