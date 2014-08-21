module Exporter
  module Model
    module User
      def columns
        [
          :id,
          :full_name,
          :email,
          { created_at: ->(user) { I18n.l(user.created_at, format: :compact) } }
        ]
      end
    end
  end

  module Csv
    class User < ::Exporter::Csv::Base
      include Model::User
    end
  end

  module Excel
    class User < ::Exporter::Excel::Base
      include Model::User
    end
  end
end
