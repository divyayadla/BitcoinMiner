defmodule Remote.Helper do
    
    defp start_gen_server(args) do
        pids = Helper.solve_start(Enum.at(args, 0), Enum.at(args, 1), Enum.at(args, 2), Enum.at(args,3), Enum.at(args,4))
        :ets.insert(:mem_cache, {"gen", pids})
    end
    def restart_gen_server(args) do
        Process.flag(:trap_exit, true)
        if length(:ets.lookup(:mem_cache, "gen")) > 0 do
            pids = elem(Enum.at(:ets.lookup(:mem_cache, "gen"), 0),1)
            Helper.kill_each_process(pids)
    
        end
        start_gen_server(args)
    end
end