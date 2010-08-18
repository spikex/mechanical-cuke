require 'pathname'

def save_page(page)
  return nil unless File.directory?(directory = save_pages_dir)
  filename = "#{directory}/mechanize-#{Time.now.to_i}.html"
  page.save_as(filename)
  filename
end

def open_in_browser(path) # :nodoc
  require "launchy"
  Launchy::Browser.run(path)
rescue LoadError
  warn "Sorry, you need to install launchy to open pages: `gem install launchy`"
end
  
private

def save_pages_dir
  tmp_dir = Pathname.new(Dir.pwd).join("tmp")
  tmp_dir.exist? ? tmp_dir : Dir.pwd
end
