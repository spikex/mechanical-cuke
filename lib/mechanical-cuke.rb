require 'mechanize'
require 'mechanical-cuke/web_steps'
require 'mechanical-cuke/save_and_open'

module MechanicalCuke
  class << self
    attr_accessor :save_and_open_page_path
    def configure
      yield self
    end
  end

  def mechanize
    @mechanize ||= Mechanize.new
  end

  def get(url)
    mechanize.get(url)
  end

  def current_page
    mechanize.current_page
  end

  def response_body
    current_page.body
  end
end

World(MechanicalCuke)

private
 
def form
  current_page.forms.first
end

def find_by_id(id)
  node = current_page.search("##{id}")
  node.first
end

def find_by_label(field)
  label = current_page.labels.find { |l| l.text == field }
  !label.nil? ? label.for.first : nil
end
    
def find_field(field)
  # Search by id
  if (node = find_by_id(field))
    return form.field_with(:node => node)
  end
  
  # Then by name
  if (f = form.field_with(:name => field))
    return f
  end

  # And finally by label
  if (node = find_by_label(field))
    return form.field_with(:node => node)
  end

  return nil
end

def find_radiobutton(field)
  # Search by id
  if (node = find_by_id(field))
    return form.radiobutton_with(:node => node.first)
  end
  
  # And by label
  if (node = find_by_label(field))
    return form.radiobutton_with(:node => node)
  end

  return nil
end
