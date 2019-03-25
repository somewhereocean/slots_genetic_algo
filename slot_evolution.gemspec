
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "slot_evolution/version"

Gem::Specification.new do |spec|
  spec.name          = "slot_evolution"
  spec.version       = SlotEvolution::VERSION
  spec.authors       = ["Lana Bugaiova"]
  spec.email         = ["lana.bugaiova@gmail.com"]

  spec.summary       = "Genetic algorithm for slot machine RTP calculations."
  spec.description   = "It works."
  spec.homepage      = "http://homepage.com"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = ""

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "http://homepage.com"
    spec.metadata["changelog_uri"] = "http://homepage.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
