require 'socket'

def parse_request(line)
  parcels = line.split(/[\s?&]+/)
  [parcels.shift, parcels.shift, [parcels.shift.split('='),
                                  parcels.shift.split('=')].to_h]
end

server = TCPServer.new('localhost', 3003)
loop do
  client = server.accept
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  next unless request_line # dealing with empty requests

  http_method, path, params = parse_request(request_line)

  client.puts "<html>"
  client.puts '<body>'
  client.puts '<pre>'
  client.puts http_method
  client.puts path
  client.puts params
  client.puts '</pre>'

  client.puts '<h1>Rolls!</h1>'

  rolls = params['rolls'].to_i
  sides = params['sides'].to_i

  rolls.times do
    client.puts "<p>#{rand(1..sides)}</p>"
  end

  client.puts '</body>'
  client.puts '</html>'
  client.close
end
