# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nullalign/version"

Gem::Specification.new do |s|
  s.name        = "nullalign"
  s.version     = Nullalign::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tom Copeland"]
  s.email       = ["tom@thomasleecopeland.com.com"]
  s.homepage    = "http://github.com/tcopeland/nullalign"
  s.summary     = %q{A tool to detect missing non-null constraints}
  s.description = <<-EOF
If you have a validates_presence_of, you'll probably want a
non-null constraint to go with it.
EOF
  s.license = "MIT"

  s.add_development_dependency "activerecord", "~>3.0"
  s.add_development_dependency "sqlite3", "~>1.3"
  s.add_development_dependency "rspec", "~>3.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
