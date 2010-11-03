require 'parallel'
require 'rubygems/spec_fetcher'

module Gem
  class Dependent
    VERSION = File.read( File.join(File.dirname(__FILE__),'..','..','VERSION') ).strip

    def self.find(gem, options={})
      specs_and_sources = all_specs_and_sources

      if options[:fetch_limit]
        specs_and_sources = specs_and_sources.first(options[:fetch_limit])
      end

      # fetch dependencies
      gem_names_and_dependencies = Parallel.map(specs_and_sources, :in_processes => 20) do |spec_tuple, source_uri|
        name = spec_tuple.first
        dependencies = dependencies(spec_tuple, source_uri)
        [name, dependencies]
      end

      # select those that depend on #{gem}
      gem_names_and_dependencies.map do |_, dependencies|
        found = dependencies.select{|d| d.name == gem}
        next if found.empty?
        [_, found]
      end.compact
    end

    private

    # dependencies for given gem
    def self.dependencies(spec_tuple, source_uri)
      begin
        fetcher = Gem::SpecFetcher.fetcher
        fetcher.fetch_spec(spec_tuple, URI.parse(source_uri)).dependencies
      rescue Gem::RemoteFetcher::FetchError, Zlib::DataError => e
        $stderr.puts e
        []
      end
    end

    def self.all_specs_and_sources
      fetcher = Gem::SpecFetcher.fetcher
      all = true
      matching_platform = false
      prerelease = false
      name = Gem::Dependency.new(//i, Gem::Requirement.default)
      specs_and_sources = fetcher.find_matching name, all, matching_platform, prerelease
      uniq_by(specs_and_sources){|a|a.first.first} 
    end

    # get unique elements from an array (last found is used)
    # http://drawohara.com/post/146659159/ruby-enumerable-uniq-by
    def self.uniq_by(array, &block)
      uniq = {}
      array.each_with_index do |val, idx|
        key = block.call(val)
        uniq[key] = [idx, val]
      end
      values = uniq.values
      values.sort!{|a,b| a.first <=> b.first}
      values.map!{|pair| pair.last}
      values
    end
  end
end