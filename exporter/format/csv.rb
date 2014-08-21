require 'csv'

module Exporter
  module Csv
    class Base < ::Exporter::Format::Base
      def extension
        'csv'
      end

      def to_file
        file = File.open(outfile_path, 'wb')
        generator(file)
        file.close
      end

      def to_string
        StringIO.new.tap { |output| generator(output) }.string
      end

    protected

      def generator(output)
        CSV::Writer.generate(output) do |csv|
          csv << headers
          build_rows { |row| csv << row }
        end
      end
    end
  end
end
