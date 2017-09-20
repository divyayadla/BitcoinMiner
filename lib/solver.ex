defmodule Solver do
    def find_bitcoins(start_pool, task_pool, c1, c2, n, k, op_val, count) do
        val = "suryayalla;" 
            <> RandUtil.random_string(c1, start_pool) 
            <> RandUtil.random_string(c2, task_pool) <> RandUtil.random_string(n-c1-c2) |> is_bitcoin(k) 
        if val do
            # IO.puts op_val
    #            op_val = op_val <> val
    #            count = count + 1
    #            if count == 25 do
    #                IO.puts op_val
    #                count = 0
    #                op_val = ""
    #            else
    #                op_val = op_val <> "\n"
    #            end
            IO.puts val
        end

        find_bitcoins(start_pool, task_pool, c1, c2, n, k, op_val, count)
    end
    def is_bitcoin(str, k) do
        hash_value = hash_sha256(str)
        zero_string = String.pad_trailing("", k, "0")
        if String.slice(hash_value, 0, k) == zero_string do
            str <>"\t"<> hash_value |> String.downcase
        else
            false
        end
    end
    def hash_sha256(str) do
        :crypto.hash(:sha256, str) |> Base.encode16
    end

end