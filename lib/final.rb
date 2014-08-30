require 'open-uri'

class Stocks

  attr_accessor :companyname, :dv, :percentage, :pcp, :webpagefiles #makes reader and writer methods

  def initialize(companyname)
    @companyname = companyname
    # @up = false
    @fullurl =  "http://www.nasdaq.com/symbol/" + @companyname.downcase + "/real-time"

  end #initialize end

  def scrape
      html = open(@fullurl) #this will go to the page of the users stock to scrape the data
      @doc = Nokogiri::HTML(html)
      if @doc.css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.nil?
        puts "This isn't a company symbol" #when you delete the element in the array, everything moves back so you have to go move back one as well
      else
        # #dollar value:
        # binding.pry
        @dv = @doc.css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.text.gsub("$", "").to_f
        
        #percentage up or down:
        @percentage = @doc.css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_percent").children.last.text.to_f
        
        #previous closing price:
        # @pcp[@repeat] = @webpagefiles[@repeat].css("#quotes_content_left__PreviousClose").children.last.text.to_f

    end #while loop end
  end 

  # def writefdv
  #   @fdv[@repeat] = @dv[@repeat] #fdv = first dollar value, will be compared to dollar vallue later observe change
  # end

  # def upordown #calculates whether a stock has gone up or down
  #   change = (@fdv[@repeat] / @dv[@repeat])
  #   if change > 1
  #     @up = false
  #     # @downhowmuch = 1 - (@dv[@repeat]/@fdv[@repeat])
  #   else change < 1
  #     @up = true
  #     # @uphowmuch = (@dv[@repeat]/@fdv[@repeat]) - 1
  #   end
  # end #upordown end

  # def trigger_textif
  #   repeat = 0
  #   while repeat < @dv.size
  #     percentdrop = (1 - (@dv[repeat] / @fdv[repeat])) #percentdrop and dv[repeat] are automatically floats
  #     if percentdrop >= @substantialdrop
  #       textifdown(@companynames[repeat], percentdrop)
  #     else
  #     end
  #     repeat += 1
  #   end #while loop end
  # end #trigger_textif end

  # # def textifup(companydown, percentdrop)

  # def textifdown(companydown, percentdrop) #texts user if their stocks are dropping substantially
  #       account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
  #       auth_token = '2008ea097713e401a16c54029058da82'

  #       # set up a client to talk to the Twilio REST API
  #       @client = Twilio::REST::Client.new account_sid, auth_token
        
  #       textmessage = "Alert:" + "\n" + companydown.upcase.to_s + " is down " + percentdrop.to_s + "% in the last hour."

  #       @client.account.messages.create(
  #         :from => '+18152642023',
  #         :to => @usernumber,
  #         :body => textmessage
  #       ) 
  # require 'final.rb'
  # def diagnostic
  #       account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
  #       auth_token = '2008ea097713e401a16c54029058da82'

  #         textmessage = "'textupdate' has been run."
          
  #         @client.account.messages.create(
  #           :from => '+18152642023',
  #           # :to => @usernumber,
  #           :to => '+19177542295',
  #           :body => textmessage
  #           )
  # end #def end
  # end #text if down end
end #class end