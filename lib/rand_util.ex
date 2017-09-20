defmodule RandUtil do
    def random_string(n, pool \\ "0123456789abcdefghijklmnopqrstuvwxyz") do 
        random_string_util("", n, pool)
    end
    def random_string_util(s, n, pool) do
        if n <= 0 do 
            s 
        else 
            size = byte_size(pool)
            random_number = :rand.uniform(size)
            str = s <> String.at(pool, random_number-1)
            random_string_util(str, n-1, pool)
        end
    end
end