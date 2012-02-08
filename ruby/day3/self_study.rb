module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    attr_accessor :headers, :csv_contents
    def initialize
      read
    end

    def each
      csv_contents.each_index do |row|
        yield CsvRow.new headers, csv_contents[row]
      end
    end
  end

  class CsvRow
    def initialize(headers, contents)
      @headers = headers
      @contents = contents
    end

    def method_missing name, *args
      name = name.to_s
      if @headers.include? name
        index = @headers.index name
        @contents[index]
      end
    end
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end
