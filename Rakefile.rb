begin
  require 'nokogiri'
rescue LoadError
  puts "============ note ============="
  puts "looks like you don't have nokogiri installed, you'll need to run the command 'gem install nokogiri'"
  puts "================================"
  puts ""
end

task :add_class, [:name] do |t, args|
  raise "name parameter required, example: rake add_class[Person]" if args[:name].nil?
  verify_file_name args[:name]
  save model_template(args[:name]), "__NAME__/#{args[:name]}.cs"
  add_compile_node :root, args[:name], "__NAME__/__NAME__.csproj"
end

task :add_test, [:name] do |t, args|
  raise "name parameter required, example: rake add_test[decribe_Person]" if args[:name].nil?
  verify_file_name args[:name]
  save test_template(args[:name]), "__NAME__Tests/#{args[:name]}.cs"
  add_compile_node :root, args[:name], "__NAME__Tests/__NAME__Tests.csproj"
end

task :ctags do
  sh "ctags --recurse"
end

def verify_file_name name
  raise "You cant use #{name} as the name. No spaces or fancy characters please." if name =~ /[\x00\/\\:\*\?\"<>\|]/ || name =~ / /
end

def model_template name
return <<template
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace __NAME__
{
    public class #{name}
    {
    }
}
template
end

def test_template name
return <<template
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NSpec;

namespace __NAME__Tests
{
    class #{name} : nspec
    {
    }
}
template
end

def save content, file_path
  raise "#{file_path} already exists, cancelling" if File.exists? file_path

  File.open(file_path, "w") { |f| f.write(content) }
end

def add_compile_node folder, name, project = nil
  to_open = project || proj_file
  doc = Nokogiri::XML(open(to_open))
  if folder == :root
    add_include doc, :Compile, "#{name}.cs"
  else
    add_include doc, :Compile, "#{folder.to_s}\\#{name}.cs"
  end
  File.open(to_open, "w") { |f| f.write(doc) }
end
