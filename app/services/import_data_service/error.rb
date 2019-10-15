class ImportDataService
  class Error < StandardError
    # Unable to locate file inside `lib/data` directory.
    class NoFile < Error
    end
  end
end
