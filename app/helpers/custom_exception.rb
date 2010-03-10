module CustomException
  class CourseNotFound < StandardError; end
  class CourseScheduleAlreadyExists < StandardError; end
end