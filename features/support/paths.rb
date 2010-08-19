module NavigationHelpers
  def path_to(page_name)
    
    'http://localhost:4567' +

    case page_name
    
    when /the index page/
      '/'
    when /the form page/
      '/form'
    when /the table page/
      '/table'
    when /the upload page/
      '/upload'
    when /the protected page/
      '/protected'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
