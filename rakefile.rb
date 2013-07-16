require 'fileutils'

APP_DIR = File.dirname(__FILE__)
APP_NAME = "MOAILauncher.app"
SOURCE_DIR = "#{APP_DIR}/src"
OUTPUT_DIR = "#{APP_DIR}/bin"
RESOURCE_DIR = "#{APP_DIR}/Resources"
APP_RESOURCE_DIR = "#{OUTPUT_DIR}/#{APP_NAME}/Contents/Resources"

task :clean do
	puts "clean output folder: #{OUTPUT_DIR}"
	FileUtils.rm_rf("#{OUTPUT_DIR}/*")
end

task :compile do
	puts "compile script"
	sh "osacompile -o #{OUTPUT_DIR}/#{APP_NAME} #{SOURCE_DIR}/main.applescript"
end

task :copy_resources do
	puts "copy resources"
	FileUtils.cp_r(Dir["#{RESOURCE_DIR}/*"],APP_RESOURCE_DIR)
end

task :default => [:clean,:compile,:copy_resources] do
	puts "finish!"
end