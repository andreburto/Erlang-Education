-module(heroine).
-export([loop/0, loop/1, setup/2, whois/1, quit/1, start/0, control/1]).

loop() ->
    loop("None").

loop(Name) ->
    receive
        {set, From, Who} ->
            From ! "set",
            loop(Who);
        {get, From} ->
            From ! Name,
            loop(Name);
        _ ->
            io:format("Goodbye~n"),
            exit({heroine,die,at,erlang:time()})
    end.

setup(To, Who) ->
    To ! {set, self(), Who},
    receive
        _ -> "set" %Heroine
    end.

whois(To) ->
    To ! {get, self()},
    receive
        Heroine ->
            %io:format("She is ~s.~n", [Heroine]),
            Heroine
    end.

quit(To) ->
    To ! {}.

start() ->
    Srv = spawn(fun heroine:loop/0),
    control(Srv).

control(Srv) ->
    {ok, [Opt]} = io:fread("What? ", "~s"),
    case Opt of
        "whois" ->
            Who = heroine:whois(Srv),
            io:format("She is: ~s.~n", [Who]),
            heroine:control(Srv);
        "setup" ->
            {ok, [N]} = io:fread("Who? ", "~s"),
            SetYet = setup(Srv, N),
            case SetYet of
                "set" -> io:format("Name set.~n");
                _ -> io:format("Name not set.~n")
            end,
            heroine:control(Srv);
        "quit" ->
            heroine:quit(Srv);
        _ ->
            io:format("No such command.~nTry: whois, setup, quit~n"),
            heroine:control(Srv)
    end.
