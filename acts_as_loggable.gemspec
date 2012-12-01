Gem::Specification.new do |s|
  s.name = "acts_as_loggable"
  s.homepage = "http://github.com/spacemunkay/acts_as_loggable"
  s.license = "MIT"
  s.version  = "0.0.2"
  s.date     = "2012-12-01"
  s.summary = %Q{Make any actions performed on a model logged. Rails 3+ only}
  s.email = "jasondenney@gmail.com"
  s.authors = ["Jason Denney"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 1.3'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'rails', '~> 3.0'

  s.add_dependency 'activerecord', '>= 3.0'
  s.add_dependency 'activesupport', '~> 3.0'
end

