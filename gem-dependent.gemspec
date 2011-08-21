# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{gem-dependent}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Grosser"]
  s.date = %q{2011-08-21}
  s.email = %q{grosser.michael@gmail.com}
  s.files = [
    "Gemfile",
     "Gemfile.lock",
     "Rakefile",
     "Readme.md",
     "VERSION",
     "gem-dependent.gemspec",
     "lib/rubygems/commands/dependent_command.rb",
     "lib/rubygems/dependent.rb",
     "lib/rubygems/dependent_parallel.rb",
     "lib/rubygems_plugin.rb",
     "spec/dependent_spec.rb",
     "spec/fixtures/gemcutter_specs.yml"
  ]
  s.homepage = %q{http://github.com/grosser/gem-dependent}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{See which gems depend on your gems}
  s.test_files = [
    "spec/dependent_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

