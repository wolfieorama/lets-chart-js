class Visit < ActiveRecord::Base
  searchkick text_start: [:country], suggest: [:country]
end
