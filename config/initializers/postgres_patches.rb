module ActiveRecord
  class Base
    def PGconn.quote_ident(name)
    %("#{name}")
    end
  end
end
