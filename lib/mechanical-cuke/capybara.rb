require 'mechanize'
require 'capybara'
require 'capybara/driver/base'
require 'capybara/node'
require 'mechanical-cuke'
require 'mechanical-cuke/basic_auth'

World(MechanicalCuke::BasicAuth)

class Capybara::Driver::MechanicalCuke < Capybara::Driver::Base
  include MechanicalCuke
  class Node < Capybara::Node

    def text
      node.text
    end

    def [](name)
      if name == :value
        node.value
      else
        node.attribute(name.to_s)
      end
    end

    def value
      driver.form.field_with(:node => node).value
    end

    def set(value)
      case self.node['type']
      when 'radio'
        radio = driver.form.radiobutton_with(:node => node)
        if (value)
          radio.check
        else
          radio.uncheck
        end
      when 'checkbox'
        driver.form.checkbox_with(:node => node).checked = value
      when 'file'
        driver.form.file_upload_with(:node => node).file_name = value
      else
        driver.form.field_with(:node => node).value = value
      end          
    end

    def select(option)
      field = driver.form.field_with(:node => node)
      if field_option = field.option_with(:value => option)
        field_option.select
      else
        raise Capybara::OptionNotFound, "No such option '#{option}' in this select box. Available options: TODO" 
      end
    end

    def click
      if tag_name == 'a'
        link = driver.current_page.link_with(:node => self.node)
        link.click
      elsif self.node['type'] == 'submit'
        button = driver.form.button_with(:node => self.node)
        driver.form.click_button(button)
      else
        nil
      end
    end

    def tag_name
      node.node_name
    end
  end

  def visit(path)
    get path
  end

  def body
    current_page.body
  end

  alias_method :source, :body

  def current_url
    current_page.uri.to_s
  end

  def initialize(app)
  end

  def find(locator)
    current_page.search(locator).map { |node| Node.new(self, node) }
  end

  def form
    current_page.forms.first
  end
end
