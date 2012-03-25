# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "overlook/version"

Gem::Specification.new do |s|
  s.name        = "overlook"
  s.version     = Overlook::VERSION
  s.authors     = ["Jim Neath"]
  s.email       = ["jimneath@googlemail.com"]
  s.homepage    = ""
  s.summary     = "Generators"
  s.description = "Generators"

  s.rubyforge_project = "overlook"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'simple_form'
  s.add_dependency 'kaminari'
  s.add_dependency 'searchy'
  s.add_dependency 'sorty'
end
