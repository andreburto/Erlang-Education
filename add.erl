-module(add).
-export([one/1]).
-export([two/1]).
-export([two/2]).

one(X) ->
    X + 1.

two(X) ->
    two(X, 2).

two(X, Y) ->
    X + Y.
