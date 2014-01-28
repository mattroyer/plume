require 'fileutils'

class FileTools
  def initialize(path, filename = '', content = '')
    @path = path
    @filename = filename
    @content = content
  end

  def create_file
    if File.exist? "#{@path}/#{@filename}"
      puts "The file #{@filename} already exists."
    else
      begin
      File.open("#{@path}/#{@filename}", "w") do |file|
        @content.each do |line|
          file.puts line
        end
      end
      rescue Exception => e
        if e.message =~ /Permission Denied/i
          FileUtils.mkdir_p("#{ENV['USERPROFILE']}/Desktop/MoveManually")
          File.open("#{ENV['USERPROFILE']}/Desktop/MoveManually/#{@filename}", "w") do |file|
            @content.each do |line|
              file.puts line
            end
          end
        else
          puts e.message
        end
      end
    end
  end

  def create_folder
    FileUtils.mkdir_p(@path)
  end
end
