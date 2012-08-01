class Tag < ActiveRecord::Base
  def self.get_tag_names_cached(center_id)
    Rails.cache.fetch('tag_names_' + center_id) {
    @tags = find(:all,:conditions => ["center_id=?", center_id])
    @tag_names = []
    @tags.each do |tg|
       @tag_names << tg.name
    end
    @tg = @tag_names.map {|element|
        "'#{element}'"
      }.join(',');
      }
  end
end
