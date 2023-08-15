require_relative "lib/resume"
require_relative "lib/parser"
require_relative "lib/local-server"

opts = Parser.new.parse(ARGV)
resume = ResumeGenerator.new(opts)
server = Server.new(opts)

begin
  File.write("output/#{opts.output_name}.html", resume.to_html) if opts.html
  resume.to_pdf if opts.pdf
  server.start if opts.live_server
rescue Errno::ENOENT
  # create a directory call output if it doesnt exist
  Dir.mkdir "output"
  retry
end
