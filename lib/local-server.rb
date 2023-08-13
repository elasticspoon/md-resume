require 'webrick'

class Server

  attr_reader :opts
  
  def initialize(opts)
    @opts = opts
  end

  def start
    root = File.expand_path "./output/#{opts.output_name}.html"
    server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

    trap 'INT' do server.shutdown end

    server.start
  end
end
