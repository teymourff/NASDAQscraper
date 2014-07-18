require 'open-uri'


class Stocks

  attr_accessor :companynames, :dv, :percentage, :pcp, :webpagefiles

  def initialize(companynames)
    @companynames = companynames
    @companynames.reject! { |c| c.empty? } #looks for empty elements in the array and deletes them
    @usernumber = 19177542295
    @substantialdrop = 0.00000000000000000000002
    @updateinterval = 1 * 10
    @lastupdate = Time.now - @updateinterval
    @stockpages = []
    @webpagefiles = []
    @dv = []
    @percentage = []
    @pcp = []
    

    repeat = 0
    while repeat < @companynames.size #will create nasdaq url's for the user's companies
      beginningofurl = "http://www.nasdaq.com/symbol/"
      endofurl = "/real-time"
      fullurl = beginningofurl + @companynames[repeat].downcase + endofurl
      @stockpages[repeat] = fullurl
      repeat += 1
    end #while loop end
  end #initialize end

  def scrape
    repeat = 0
    while repeat < @companynames.size
      html = open(@stockpages[repeat]) #this will go to the page of the users stock to scrape the data
      @webpagefiles[repeat] = Nokogiri::HTML(html)
      if @webpagefiles[repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.nil?
        @companynames.delete_at(repeat) # if the page is invalid, the item is removed from the string
        repeat -= 1 #when you delete the element in the array, everything goes back so you have to go back one too
      else
        #dollar value:
        @dv[repeat] = @webpagefiles[repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.text.gsub("$", "").to_f
        #percentage up or down:
        @percentage[repeat] = @webpagefiles[repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_percent").children.last.text.to_f
        #previous closing price:
        @pcp[repeat] = @webpagefiles[repeat].css("#quotes_content_left__PreviousClose").children.last.text.to_f
        if Time.now - @lastupdate >= @updateinterval #checks if its been an hour fdv was updated
          @fdv = @dv
          @lastupdate = Time.now
        end
      end

      repeat += 1
    end #while loop end
  end #scrape

  # def upordown #calculates whether a stock has gone up or since the previous close; useful for daily updates
  #   change = (1 - (@pcp.to_i / @dv.to_i))
  #   @up = false
  #   if change > 0
  #     @up = true
  #   else change < 0
  #     @up = false
  #   end
  # end #upordown end

  def trigger_textif
    repeat = 0
    while repeat < @dv.size #gets second value
      if (1 - (@dv[repeat] / @fdv[repeat])) > @substantialdrop
        percentdrop = 1 - (@dv[repeat] / @fdv[repeat])
        textifdown(@companynames[repeat], percentdrop)
      end
    end #while loop end
  end #trigger_textif 


  # def textifup(companydown, percentdrop)

  def textifdown #texts user if their stocks are dropping substantially
        account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
        auth_token = '2008ea097713e401a16c54029058da82'

        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new account_sid, auth_token
        
        textmessage = "Alert:" + "\n" + companydown.upcase + " is down " + percentdrop + "% in the last hour."

        @client.account.messages.create(
          :from => '+18152642023',
          :to => @usernumber,
          :body => textmessage
        ) 

  end #text if down end

  def diagnostic
      account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
      auth_token = '2008ea097713e401a16c54029058da82'

      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token

      companynames.each_index do |i|
        textmessage = @companynames[i] + " dv:" + @dv[i].to_s + " percentage:" + @percentage[i].to_s + " Pcp:" + @pcp[i].to_s

        @client.account.messages.create(
          :from => '+18152642023',
          :to => @usernumber,
          :body => textmessage
          )
      end
  end

end #class end

# mystocks = Stocks.new




