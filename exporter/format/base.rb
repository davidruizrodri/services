module Exporter
  module Format
    class Base
      attr_reader :collection, :outfile_path, :locale, :file

      def initialize(collection, outfile_path, options = {})
        options.reverse_merge!(locale: 'ca')

        @collection   = collection
        @outfile_path = outfile_path.include?('.') ? outfile_path : "#{outfile_path}.#{extension}"
        @locale       = options[:locale]
      end

      def to_file
        nil
      end

      def to_string
        ''
      end

    protected

      def extension
        fail "Method 'extension' must be defined in '#{class_name}' format"
      end

      def class_name
        ActiveSupport::Inflector.demodulize(self.class)
      end

      def klass
        class_name.constantize
      end

      def headers
        columns.map do |column|
          field = column.is_a?(Hash) ? column.keys.first : column
          klass.human_attribute_name(field, locale: locale)
        end
      end

      def build_rows
        collection.each_with_index do |record, index|
          row = columns.map do |column|
            get_value = column.is_a?(Hash) ? column.values.first : column
            get_value.is_a?(Proc) ? get_value.call(record) : record.send(get_value)
          end

          yield(row, index)
        end
      end

      def columns
        []
      end
    end
  end
end
