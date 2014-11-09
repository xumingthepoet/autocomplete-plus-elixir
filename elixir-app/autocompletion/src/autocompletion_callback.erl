-module(autocompletion_callback).
-export([handle/2, handle_event/3]).

-include_lib("elli/include/elli.hrl").

handle(Req, _Args) ->
    handle(Req#req.method, elli_request:path(Req), Req).

handle('GET', Message, _Req) ->
    Hints = autocompletion:getCompletion('Elixir.String':to_char_list(hd(Message))),
    {ok, [], Hints};

handle(_, _, _Req) ->
    {404, [], <<"Not Found">>}.

handle_event(_Event, _Data, _Args) ->
    ok.
