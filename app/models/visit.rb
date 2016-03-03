class Visit < ActiveRecord::Base
  searchkick text_start: [:country]
end
