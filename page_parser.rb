class PageScraper
  
  def initialize
    mechanize = Mechanize.new
    mechanize.get('https://staqresults.herokuapp.com/')
    page = submit_and_get_html(mechanize.page.forms.first)
    @data_html = Nokogiri::HTML(page)
  end  
   
  def get_all_table_rows
    all_rows
  end

  def get_values_by_tags(str_tags)
    all_rows.css(str_tags).map(&:text)
  end

  private 

  attr_reader :data_html

  def submit_and_get_html(form)
    form['email'] = 'test@example.com'
    form['password'] = 'secret'
    form.submit.body
  end

  def all_rows
    data_html.xpath('//table//tr')
  end  
end  