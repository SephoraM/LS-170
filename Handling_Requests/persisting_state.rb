require 'socket'

def parse_request(line)
  parcels = line.split(/[\s?&]+/)
  [parcels.shift, parcels.shift, parcels.shift.split('=')]
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

  params = { 'number' => params[1] || '' }
  client.puts "<html>"
  client.puts '<body>'
  client.puts '<pre>'
  client.puts http_method
  client.puts path
  client.puts params.size
  client.puts '</pre>'

  client.puts "<h1>Counter</h1>"

  number = params['number'].to_i
  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts '</body>'
  client.puts '</html>'
  client.close
end
