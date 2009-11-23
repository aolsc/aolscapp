require 'csv'


class DataFile < ActiveRecord::Base


 

  def self.save( upload )
    name = upload['datafile'].original_path
    dirictory = 'public/data'
    # create the file path
    path = File.join( dirictory, name )
    data = upload['datafile'].read;
    puts '************************************************'
    #puts data;
    puts '************************************************'
    File.open(path, "wb") { |f| f.write( data ) }

      rowCount = 1
     CSV.open( path , 'r', ',') do |row|
       if rowCount > 2

        t =  Hash[
          'firstname',row[0].split(' ')[0],
          'lastname',row[0].split(' ')[1],
          'address1',row[1],
          'address2',row[2],
          'city',row[3],
          'state',row[4],
          'zip',row[5],
          'country',row[6],
          'emailid',row[8],
          'homephone',row[9],

        ];


        #row.each(','){|x| puts x }

        @member = Member.new(t)
        @validatemember = Member.find(:all, :conditions => ["firstname = ? AND lastname = ? AND emailid = ?", @member.firstname, @member.lastname, @member.emailid
          ])
        if @validatemember.length == 0
          @validateemail = Member.find(:all, :conditions => ["emailid = ? ", @member.emailid])
          if @validateemail.length == 0
            @member.save

          end
        end

    #@member_course.course_schedule_id = params[:id]
    #@member_course.member_id = params[:member_id]
    #@member = Member.find(params[:member_id])
    #@validatecoursescheduleid = MemberCourse.find(:all, :conditions => ["course_schedule_id = ?", @member_course.course_schedule_id] )


       end
       rowCount = rowCount +1
     end
  end

  
end
