module CustomException
  class CourseNotFound < StandardError; end
  class CourseScheduleAlreadyExists < StandardError; end
  class WrongFileFormat < StandardError; end
end