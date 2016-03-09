module JSONAPI
  MIMETYPE = "application/vnd.api+json"

  module MimeTypes
    class << self
      def install
        Mime::Type.register(JSONAPI::MIMETYPE, :api_json)

        parsers = ActionDispatch::Request.parameter_parsers.merge(
          Mime::Type.lookup(JSONAPI::MIMETYPE).symbol => parser
        )
        ActionDispatch::Request.parameter_parsers = parsers
      end

      def parser
        lambda do |body|
          data = JSON.parse(body)
          data = {_json: data} unless data.is_a?(Hash)
          data.with_indifferent_access
        end
      end
    end
  end

  MimeTypes.install
end
