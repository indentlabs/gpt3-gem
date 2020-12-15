class GPT3
  # TODO do these need to declared as dependencies somewhere in the gemspec?
  require 'net/http'
  require 'uri'
  require 'json'

  API_VERSION = 1
  ENGINE      = 'davinci'
  BASE_URL    = "https://api.openai.com/v#{API_VERSION}/engines/#{ENGINE}"
  SECRET_KEY  = ENV.fetch('OPENAI_SK')

  class Completion
    DEFAULT_TEMPERATURE = 0.5
    # defaults:
    # {
    #   "prompt": "Once upon a time",
    #   "max_tokens": 5,
    #   "temperature": 1,
    #   "top_p": 1,
    #   "n": 1,
    #   "stream": false,
    #   "logprobs": null,
    #   "stop": "\n"
    # }

    attr_accessor :data
    def initialize(*params)
      self.data = params
    end

    def self.create(prompt, max_tokens: 512, engine: ENGINE, temperature: DEFAULT_TEMPERATURE, n: 1, stop: nil, verbose: false)
      endpoint = URI.parse("#{GPT3::BASE_URL}/completions")
      header   = {
        'Content-Type':  'application/json',
        'Authorization': 'Bearer ' + SECRET_KEY
      }
      data     = {
        'prompt':      prompt,
        'max_tokens':  max_tokens,
        'temperature': temperature,
        'stop':        stop,
        'n':           n
      }

      if verbose
        puts "+ Creating GPT-3 Completion for the following prompt (with temperature=#{temperature}):"
        puts "| " + prompt.gsub("\n", "\n| ")
        puts "+" + ("-" * 50)
      end

      # Create the HTTP objects
      https         = Net::HTTP.new(endpoint.host, endpoint.port)
      https.use_ssl = true
      request       = Net::HTTP::Post.new(endpoint.request_uri, header)
      request.body  = data.to_json

      # Send the request
      response = https.request(request)

      # Parse it and return formatted API results
      JSON.parse(response.body)
    end

    def self.search
      raise "Not Implemented"
    end
  end

  class Engine
    def self.list
      raise "Not Implemented"
    end

    def self.retrieve(engine)
      raise "Not Implemented"
    end
  end
end
