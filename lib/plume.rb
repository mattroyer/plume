require 'yaml'
require 'erb'
%w(file_tools registry).each { |lib| require_relative "plume/#{lib}" }

# Load example YAML settings file
settings = YAML::load_file("../example/settings.yml")

# Create all folders from settings.yml
settings['folders'].each do |folder|
  current_folder = ERB.new(folder[1]['path']).result
  subs = folder[1]['sub_folders']
  subs.each do |sub|
    current_sub = FileTools.new "#{current_folder}/#{sub}"
    current_sub.create_folder
  end
end

# Create all files from settings.yml
settings['files'].each do |file|
  current_file = FileTools.new ERB.new(file[1]['path']).result, file[1]['filename'], file[1]['content']
  current_file.create_file
end

# Create/edit all entries from settings.yml
# Warning: No error checking yet. Registry will change
settings['registry'].each do |registry|
  reg = Registry.new registry[1]['base'], registry[1]['location'], registry[1]['key'], registry[1]['value']
  reg.set_registry
end
