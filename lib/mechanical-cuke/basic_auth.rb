module MechanicalCuke
  module BasicAuth
    def basic_auth(username,password)
      page.driver.basic_auth(username, password)
    end
  end
end
