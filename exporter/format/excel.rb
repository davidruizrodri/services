require 'spreadsheet'

module Exporter
  module Excel
    class Base < ::Exporter::Format::Base
      def extension
        'xls'
      end

      def to_file
        book  = Spreadsheet::Workbook.new
        sheet = book.create_worksheet

        sheet.row(0).concat(headers)
        build_rows { |row, index| sheet.row(index + 1).concat(row) }

        book.write(outfile_path)
      end
    end
  end
end
