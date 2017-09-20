defmodule Helper do
    def solve_start(start_pool, c1, actors, n, k) do
        solve(start_pool, c1, actors, n, k, 0, div(36,actors), [])
    end

    def solve(start_pool, c1, actors, n, k, p, len, pids, pool \\ "0123456789abcdefghijklmnopqrstuvwxyz") do
        if actors == 1 do
            {:ok, pid} = Task.start(Solver, :find_bitcoins, [start_pool, String.slice(pool, p..-1), c1,1, n,k, "", 0])
            [pid | pids]
        else
            {:ok, pid} = Task.start(Solver, :find_bitcoins, [start_pool, String.slice(pool, p , len), c1, 1, n, k, "", 0])
            solve(start_pool, c1, actors-1, n, k, p+len, len, [pid | pids])
        end
    end
    
    def pt() do
        pid = elem(Enum.at(:ets.lookup(:mem_cache, "mailbox_pid"), 0),1)
        send pid, {:ready, pid}
    end
    def redistribute(args) do
        list = [Node.self | Node.list]
        total_nodes = length(list)
        # spawn service in all nodes
        pids = spawn_services(list, [], args, 0, div(36, total_nodes), total_nodes)

        # store pids in ets
        :ets.insert(:mem_cache, {"pids", pids})
    end

    def kill_each_process(pids) do
        if pids != [] do
            [pid | tail] = pids
            Process.exit(pid, :kill)
            kill_each_process(tail)
        end
    end

    def spawn_services(nodes, pids, args, p, len, rem_nodes, pool \\ "0123456789abcdefghijklmnopqrstuvwxyz") do
        if nodes != [] do
            [node | tail] = nodes
            new_args = [1 | args]
            new_args = 
                if rem_nodes == 1 do
                    [String.slice(pool, p..-1) | new_args]
                else
                    [String.slice(pool, p, len) | new_args]
                end
            pid = 1
            if node == Node.self do
                Remote.Helper.restart_gen_server(new_args)
            else
                pid = Node.spawn(node, Remote.Helper, :restart_gen_server, [new_args])
            end
            spawn_services(tail, [pid | pids], args, p+len, len, rem_nodes-1)
        else
            pids
        end
    end

end