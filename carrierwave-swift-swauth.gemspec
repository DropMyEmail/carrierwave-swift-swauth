Gem::Specification.new do |s|
  s.name = 'carrierwave-swift-swauth'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Wong Liang Zan']
  s.email = ['zan@liangzan.net']
  s.homepage = 'https://github.com/DropMyEmail/carrierwave-swift-swauth'
  s.summary = 'Carrierwave store for openstack swift with swauth authentication'
  s.description = 'A store for carrierwave that uses openstack swift. Authenication is assumed to be swauth.'
  s.required_rubygems_version = '>= 1.3.6'

#  s.add_dependency 'openstack'
  s.add_dependency 'carrierwave'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'shoulda'

  s.files = Dir.glob("lib/**/*") + %w(LICENSE README.md)
  s.require_path = 'lib'
end
