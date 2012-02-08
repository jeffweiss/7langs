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
      if @headers.include? name.to_s
        index = @headers.index name.to_s
        puts "dynamically creating methods"
        @headers.each do |header|
          self.class.send(:define_method, header) do
            index = @headers.index header
            @contents[index]
          end
        end
        send(name)
      else
        super
      end   
    end
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end
