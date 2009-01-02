class Profile < ActiveResource::Base
  self.site = "http://localhost:3000/"
  def to_param
    idNo
  end

  def fullname
    "#{givenName} #{middlename} #{familyName}"
  end

  def yrcourse
    "#{course} #{yearLevel}"
  end
end
