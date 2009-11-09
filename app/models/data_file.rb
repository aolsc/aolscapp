class DataFile < ActiveRecord::Base
  def self.save( upload )
    name = upload['datafile'].original_path
    dirictory = 'public/data'
    # create the file path
    path = File.join( dirictory, name )
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
  end
end
