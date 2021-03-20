require 'json'
require 'mustache'
require 'net/http'

class Index < Mustache
  def timestamp
    json['updated']
  end

  def domains
    json['domains']
  end

  private

  def uri
    URI("https://raw.githubusercontent.com/codeandclay/goodi.sh-names/main/available_sh_domains.json")
  end

  def json
    @json ||= JSON.parse(Net::HTTP.get_response(uri).body)
  end
end

