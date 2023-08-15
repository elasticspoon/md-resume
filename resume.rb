require_relative "lib/resume"
require_relative "lib/parser"
require_relative "lib/local-server"

opts = Parser.new.parse(ARGV)
resume = ResumeGenerator.new(opts)
server = Server.new(opts)

case ARGV
when ["serve"]
  server.start
when ["build"]
  resume.write
else
  raise StandardError, "Please specify a command"
end
