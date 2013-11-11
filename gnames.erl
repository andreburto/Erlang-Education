-module(gnames).

-export([get_names_from_file/1]).

get_names_from_file(Name) ->
    {ok, Device} = file:open(Name, [read]),
    {ok, L} = re:split(get_names(Device), ","),
    lists:sublist(L, length(L) - 1).

get_names(Device) ->
    case io:get_line(Device, "") of
        eof -> file:close(Device);
        Line -> lists:concat([lists:subtract(Line, "\n"), ",", get_names(Device)])
    end.