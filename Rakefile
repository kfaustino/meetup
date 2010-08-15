require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "meetup"
    gem.summary = %Q{A wrapper for the meetup api}
    gem.description = %Q{A wrapper for the meetup api}
    gem.email = "kevin.faustino@gmail.com"
    gem.homepage = "http://github.com/kfaustino/meetup"
    gem.authors = ["Kevin Faustino"]
    gem.add_dependency 'faraday', '~> 0.4.6'
    gem.add_dependency 'hashie', '~> 0.3.0'
    gem.add_dependency 'multi_json', '~> 0.0.4'
    gem.add_dependency 'faraday-middleware', '~> 0.0.1'
    gem.add_development_dependency "rspec", ">= 1.3.0"
    gem.add_development_dependency "webmock", '~> 1.3.4' 
    gem.add_development_dependency "yard", ">= 0"    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
