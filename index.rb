require 'json'
require 'mustache'
require 'net/http'

class Index < Mustache
  def timestamp
    json['updated']
  end

  def domain_names
    domains.map(&:name)
  end

  def domains
    json['domains'].to_a.map do |domain|
      Domain.new(domain)
    end
  end

  def count
    domains.count
  end

  private

  def uri
    URI("https://raw.githubusercontent.com/codeandclay/goodi.sh-names/main/available_sh_domains.json")
  end

  def json
    @json ||= JSON.parse(Net::HTTP.get_response(uri).body)
  end
end

class Domain
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def dictionary_word
    name.delete('.')
  end

  def buy_url
    "https://google.com/#{name}"
  end

  def to_h
    {
      dictionary_word: dictionary_word,
      buy_url: buy_url,
      name: name
    }
  end
end
