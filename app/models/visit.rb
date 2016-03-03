class Visit < ActiveRecord::Base
  searchkick autocomplete:['country']
end
