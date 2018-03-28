module S3lite::Parse
  class << self
    def json(txt)
      case txt.class.to_s
      when 'String' then JSON.parse(txt, symbolize_names: true)
      when 'Hash', 'Array' then json(txt.to_json)
      end
    end
  end
end
