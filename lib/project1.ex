defmodule MN do

  def main(args) do
    if length(args) == 1 do
      val = List.first(args)
      Process.flag(:trap_exit, true)
      :ets.new(:mem_cache, [:public, :named_table])
      if String.length(val) < 3 do
        {k, _} = val |> Integer.parse
        start_distributed_node("master")
        actors = 7
        params = [actors,16,k]
        {:ok, pid} = Server.MailBox.start_mailbox(params)
        send pid, {:setup, pid}

      else 
        ip_addr = val
        start_distributed_node("client")
        connect_to_cluster("master@"<>val)
        Enum.at(Node.list, 0) |> Node.spawn(Helper, :pt, [])
      end
      # time = 30
      # loop(time)
      master_loop()
    end
  end
  def master_loop() do
    master_loop()
  end
  def loop(t) do 
    if t > 0 do
      :timer.sleep(1000)
      loop(t-1)
    else
      System.halt(0)
    end
  end
  def start_distributed_node(name) do
    unless Node.alive?() do
      str = "@" <> get_ip_address()
      {:ok, _} = Node.start(String.to_atom(name<>str), :longnames)
    end
    cookie = :bitcoins
    Node.set_cookie(cookie)
  end
  def get_ip_address do
    ips = :inet.getif() |> elem(1)
    [head | tail] = ips
    valid_ips = check_if_valid(head, tail, [])
    ip =
      if valid_ips == [] do
        elem(head, 0)
      else 
        Enum.at(valid_ips, 0)
      end
    # ip = Enum.at(valid_ips, 0)
    val = to_string(elem(ip, 0)) <> "." <> to_string(elem(ip, 1)) <> "." <> to_string(elem(ip, 2)) <> "." <> to_string(elem(ip, 3))
    val
  end

  def check_if_valid(head, tail, ipList) do
    ip_tuple = elem(head, 0)

    ipList =
      if !isLocalIp(ip_tuple) do
        if elem(ip_tuple, 0) == 192 || elem(ip_tuple, 0) == 10 || elem(ip_tuple, 0) == 128 do
          [ ip_tuple| ipList]
        else 
          ipList
        end
      else 
        ipList
      end
    
    if tail == [] do
      ipList
    else 
      [new_head | new_tail] = tail
      check_if_valid(new_head, new_tail, ipList)
    end
  end

  def isLocalIp(ip_tuple) do
    if elem(ip_tuple, 0) == 127 && elem(ip_tuple, 1) == 0 && elem(ip_tuple, 2) == 0 && elem(ip_tuple, 3) == 1 do
      true
    else 
      false
    end
  end

  def connect_to_cluster(name) do
    Node.connect String.to_atom(name)
  end
end
