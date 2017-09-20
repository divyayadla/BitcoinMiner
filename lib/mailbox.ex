defmodule Server.MailBox do
    def start_mailbox(args) do
        m1 = %{:arg_list=> args}
        Task.start_link(fn -> receive_messages(m1) end)
    end

    def receive_messages(map) do
        receive do
            {:setup, pid} -> 
                :ets.insert(:mem_cache, {"pids", []})
                :ets.insert(:mem_cache, {"mailbox_pid", self()})
                send self(), {:ready, self()}
                receive_messages(map)
            {:ready, caller_pid} ->
                Helper.redistribute(Map.get(map, :arg_list))
                receive_messages(map)
        end
    end
end