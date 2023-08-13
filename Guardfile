guard 'livereload' do

  # file types LiveReload may optimize refresh for
  watch(%r{output/.+\.html})
end

# This is an example with all options that you can specify for guard-process
# guard 'process', :name => 'name of your process', :command => 'ruby path/to/your/file.rb', :env => {"ENV1" => "value 1", "ENV2" => "value 2"}, :stop_signal => "KILL"  do
#   watch('Gemfile.lock')
# end

guard 'process', :name => 'Rebuild Dev Site', :command => 'bundle exec ruby resume.rb --no-pdf', :stop_signal => "KILL"  do
  watch(%r{input/.+\.md})
  watch(%r{input/.+\.css})
end
