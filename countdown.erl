-module(countdown).
-export([countdown/2]).

countdown(M, X) when X > 0 ->
    io:format("~w~n", [X]),
    countdown(M, X - 1);
countdown(M, X) ->
    io:format("~w... ~s!~n", [X, M]).
