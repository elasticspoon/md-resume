require "webrick"

class Server
  attr_reader :opts

  def initialize(opts)
    @opts = opts
  end

  def start
    if opts.dev_server
      foreman_start
    else
      start_local_server
    end
  end

  def foreman_start
    exec "foreman start"
  end

  def start_local_server
    root = File.expand_path "./output/#{opts.output_name}.html"
    server = WEBrick::HTTPServer.new Port: 8000, DocumentRoot: root

    trap "INT" do server.shutdown end

    server.start
  end
end
