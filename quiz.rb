require 'mechanize'
require 'nokogiri'
require_relative 'page_parser'

class Quiz

  def initialize
    page_html = PageScraper.new
    @all_table_rows = page_html.get_all_table_rows
    @array_colum_names = page_html.get_values_by_tags('th.text-right')
    @array_rows_values = page_html.get_values_by_tags('td.text-right')
    @array_date_column_values = page_html.get_values_by_tags('td.date')
  end

  def run
    data = array_date_column_values.reduce({}) do |result, key|
      result.merge!("#{key}" => Hash[compose_names_and_values.shift])
    end
    data
  end

  private

  attr_reader :all_table_rows, :array_colum_names, :array_rows_values, :array_date_column_values

  def compose_names_and_values
    @arr ||= []
    return @arr unless @arr.empty?
    all_table_rows[1..-1].size.times do
      @arr << array_colum_names.map { |i| [i.downcase.to_sym, array_rows_values.shift] }
    end
    @arr
  end
end

Quiz.new.run
