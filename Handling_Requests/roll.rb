require 'socket'

def parse_request(line)
  parcels = line.split(/[\s?&]+/)
  [parcels.shift, parcels.shift, [parcels.shift.split('='),
                                  parcels.shift.split('=')].to_h]
end

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept
  client.puts "HTTP/1.1 200 OK\r\n\r\n"

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  http_method, path, params = parse_request(request_line)
  puts http_method
  puts path

  client.puts request_line
  params['rolls'].to_i.times do
    client.puts rand(1..params['sides'].to_i)
  end

  client.close
end
