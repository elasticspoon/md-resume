require "optparse"
require "pathname"

class Parser
  class ScriptOptions
    attr_accessor :chrome_path, :html, :pdf, :css_path, :output_name, :verbose, :input_path, :dev_server

    def initialize
      self.chrome_path = nil
      self.html = true
      self.pdf = true
      self.input_path = "input/resume.md"
      self.css_path = "input/resume.css"
      self.output_name = "resume"
      self.verbose = false
      self.dev_server = false
    end

    def define_options(parser)
      parser.banner = "Usage: resume.rb command [options...]"
      parser.separator ""
      # TODO: fill this in
      # maybe base it on jekyll's help output?
      parser.separator "Commands:"
      parser.separator ""
      parser.separator ""
      parser.separator "Specific options:"

      # add additional options
      boolean_pdf_option(parser)
      boolean_html_option(parser)
      boolean_dev_server_option(parser)
      boolean_verbosity_option(parser)
      specify_chrome_path_option(parser)
      specify_css_path_option(parser)
      specify_input_path_option(parser)
      specify_output_option(parser)
      parser.separator ""
      parser.separator "Common options:"
      # No argument, shows at tail.  This will print an options summary.
      # Try it and see!
      parser.on_tail("-h", "--help", "Show this message") do
        puts parser
        exit
      end
    end

    def specify_chrome_path_option(parser)
      # Specifies an optional option argument
      parser.on("--chrome-path=PATH", "Path to Chrome executable") do |path|
        full_path = Pathname.new(path).expand_path
        self.chrome_path = full_path
      end
    end

    def specify_input_path_option(parser)
      # Specifies an optional option argument
      parser.on("-i PATH", "--input-path=PATH", "Path to Markdown input") do |path|
        full_path = Pathname.new(path).expand_path
        self.input_path = full_path
      end
    end

    def specify_css_path_option(parser)
      # Specifies an optional option argument
      parser.on("-css PATH", "--css-path=PATH", "Path to CSS stylesheet") do |path|
        full_path = Pathname.new(path).expand_path
        self.css_path = full_path
      end
    end

    def specify_output_option(parser)
      # Specifies an optional option argument
      parser.on("-o NAME", "--output=NAME", "Name of output file", "\tEx: --output=resume will output resume.html and resume.pdf") do |name|
        self.output_name = name
      end
    end

    def boolean_verbosity_option(parser)
      parser.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        self.verbose = v
      end
    end

    def boolean_dev_server_option(parser)
      # Boolean switch.
      parser.on("--dev-server", "Start a live dev-server using foreman", "This rebuild your html output and use livereload to refresh your browser",
        "You will need the livereload browser extension for the reloading to work") do |v|
        self.dev_server = v
      end
    end

    def boolean_pdf_option(parser)
      # Boolean switch.
      parser.on("--no-pdf", "Do not write pdf output") do |v|
        self.pdf = v
      end
    end

    def boolean_html_option(parser)
      # Boolean switch.
      parser.on("--no-html", "Do not write html output") do |v|
        self.html = v
      end
    end
  end

  #
  # Return a structure describing the options.
  #
  def parse(args)
    # The options specified on the command line will be collected in
    # *options*.

    @options = ScriptOptions.new
    @args = OptionParser.new do |parser|
      @options.define_options(parser)
      parser.parse!(args)
    rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
      puts e
      puts
      puts parser
      exit
    end
    @options
  end

  attr_reader :parser, :options
end
