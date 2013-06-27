begin
  require 'nokogiri'
  require './StackTracePreview/stack_trace_preview.rb'
rescue LoadError
  puts "============ note ============="
  puts "looks like you don't have nokogiri installed, you'll need to run the command 'gem install nokogiri'"
  puts "================================"
  puts ""
end

task :default do
  msbuild_path = "#{ENV['SystemRoot']}\\Microsoft.NET\\Framework\\v4.0.30319\\msbuild.exe"
  sh "\"#{msbuild_path}\" \"__NAME__.sln\" /verbosity:quiet /nologo"
end

task :tests => :default do
  sh "./packages/nspec.0.9.66/tools/NSpecRunner.exe __NAME__Tests/bin/debug/__NAME__Tests.dll"
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

task :stacktrace do
  gen_preview "stacktrace.txt" 
end

def gen_preview from_file
  puts "reading last error from #{from_file}"

  stacktrace = File.readlines(from_file).join()

  working_directory = pwd.gsub("/", "\\")

  StackTracePreview.new(stacktrace, working_directory).generate "StackTracePreview/stacktrace.html"

  puts "done, navigate to file:///#{pwd}/StackTracePreview/stacktrace.html#/toc in your browser for the results"
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
using __NAME__;

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

def add_compile_node folder, name, project
  to_open = project || proj_file
  doc = Nokogiri::XML(open(to_open))
  if folder == :root
    add_include doc, :Compile, "#{name}.cs"
  else
    add_include doc, :Compile, "#{folder.to_s}\\#{name}.cs"
  end
  File.open(to_open, "w") { |f| f.write(doc) }
end

def add_include doc, type, value
  doc.xpath("//xmlns:ItemGroup[xmlns:#{type.to_s}]").first << "<#{type.to_s} Include=\"#{value}\" />"
end
