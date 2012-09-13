-module(simple_crawler).
-define(BASE_URL, "http://46.4.117.69/").
-define(SAVE_FILE, true).
-export([start/0, send_reqs/2, do_send_req/2]).

start() ->
  ibrowse:start(),
  Ref = make_ref(),
  proc_lib:spawn(?MODULE, send_reqs, [self(), Ref]),
  receive_by_ref(Ref).

to_url(Id) ->
  ?BASE_URL ++ integer_to_list(Id).

fetch_ids() ->
  lists:seq(1, 500).

send_reqs(Pid, Ref) ->
  spawn_workers(fetch_ids()),
  Pid ! {Ref, done}.

spawn_workers(Ids) ->
  %% collect reference to each worker
  Refs = [ do_spawn(Id) || Id <- Ids ],
  %% wait for response from each worker
  wait_workers(Refs).

wait_workers(Refs) ->
  lists:foreach(fun receive_by_ref/1, Refs).

receive_by_ref(Ref) ->
  %% receive message only from worker with specific reference
  receive
{Ref, done} ->
    done
  end.

do_spawn(Id) ->
  Ref = make_ref(),
  proc_lib:spawn_link(?MODULE, do_send_req, [Id, {self(), Ref}]),
  Ref.

do_send_req(Id, {Pid, Ref}) ->
  io:format("Requesting ID ~p ... ~n", [Id]),
  Result = (catch ibrowse:send_req(to_url(Id), [], get, [], [{save_response_to_file, ?SAVE_FILE}], 5000)),
  case Result of
  {ok, Status, _H, B} ->
    io:format("OK -- ID: ~2..0w -- Status: ~p -- Content length: ~p~n", [Id, Status, length(B)]),
    %% send message that work is done
    Pid ! {Ref, done};
  Err ->
    io:format("ERROR -- ID: ~p -- Error: ~p~n", [Id, Err]),
    %% repeat request if there was error while fetching a page, 
    do_send_req(Id, {Pid, Ref})
    %% or - if you don't want to repeat request, put there:
    %% Pid ! {Ref, done}
end.
