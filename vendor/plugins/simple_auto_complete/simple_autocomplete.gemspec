# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simple_autocomplete}
  s.version = "0.3.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Grosser"]
  s.date = %q{2011-03-11}
  s.email = %q{grosser.michael@gmail.com}
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "Rakefile",
    "Readme.md",
    "VERSION",
    "example_js/javascripts/application.js",
    "example_js/javascripts/jquery.autocomplete.js",
    "example_js/javascripts/jquery.js",
    "example_js/stylesheets/jquery.autocomplete.css",
    "init.rb",
    "lib/simple_autocomplete.rb",
    "simple_autocomplete.gemspec",
    "spec/setup_test_model.rb",
    "spec/simple_autocomplete_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/grosser/simple_autocomplete}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{Rails: Simple, customizable, unobstrusive - auto complete}
  s.test_files = [
    "spec/setup_test_model.rb",
    "spec/simple_autocomplete_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

