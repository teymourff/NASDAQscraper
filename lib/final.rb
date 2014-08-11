require 'open-uri'
# => FEATURES <= 
# DATABASING FOR MULTIPLE USERS
# have textboxes generate as you type (maybe start with 3 or so)
# add input for what time you should receive updates
# add support for full company names

#git push heroku master  =>  updates the page on heroku
#shotgun app.rb  =>  to create server on the computer

# https://github.com/flatiron-school-students/hs-summer-sinatra-refactor-summer14-001
# https://github.com/flatiron-school-students/heroku_deploy-summer14-001
# https://devcenter.heroku.com/articles/scheduler
# http://limitless-escarpment-7709.herokuapp.com/
# https://scheduler.heroku.com/dashboard
# http://stocks.tradingcharts.com/  =>  good for adding support for full company names


class Stocks

  attr_accessor :companynames, :dv, :percentage, :pcp, :webpagefiles #makes reader and writer methods

  def initialize(companynames, usernumber)
    @companynames = companynames
    @companynames.reject! { |c| c.empty? } #looks for empty elements in the array and deletes them
    @usernumber = usernumber 
    @substantialdrop = 0.02
    @updateinterval = 1 * 10
    @lastupdate = Time.now - @updateinterval
    @stockpages = []
    @webpagefiles = []
    @fdv = []
    @dv = []
    @percentage = []
    @pcp = []
    @up = false
    

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
    @repeat = 0
    while @repeat < @companynames.size
      html = open(@stockpages[@repeat]) #this will go to the page of the users stock to scrape the data
      @webpagefiles[@repeat] = Nokogiri::HTML(html)
      if @webpagefiles[@repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.nil?
        @companynames.delete_at(@repeat) # if the page is invalid, the item is removed from the string
        @repeat -= 1 #when you delete the element in the array, everything moves back so you have to go move back one as well
      else
        #dollar value:
        @dv[@repeat] = @webpagefiles[@repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_lastsale").children.last.text.gsub("$", "").to_f
        
        #percentage up or down:
        @percentage[@repeat] = @webpagefiles[@repeat].css("div#content .quotebar-wrap .header-wrap .quote-wrap .quote-data-wrap #qwidget-quote-wrap #qwidget_quote #qwidget_percent").children.last.text.to_f
        
        #previous closing price:
        @pcp[@repeat] = @webpagefiles[@repeat].css("#quotes_content_left__PreviousClose").children.last.text.to_f
      end #else end
      @repeat += 1
    end #while loop end
  end #scrape end

  def writefdv
    @fdv[@repeat] = @dv[@repeat] #fdv = first dollar value, will be compared to dollar vallue later to see the change
  end

  def upordown #calculates whether a stock has gone up or since the previous close; useful for daily updates
    change = (@pcp.to_i / @dv.to_i)
    if change > 1
      @up = false
    else change < 1
      @up = true
    end
  end #upordown end

  def trigger_textif
    repeat = 0
    while repeat < @dv.size
      percentdrop = (1 - (@dv[repeat] / @fdv[repeat])) #percentdrop/dv[repeat] are automatically floats
      if percentdrop >= @substantialdrop
        textifdown(@companynames[repeat], percentdrop)
      else
      end
      repeat += 1
    end #while loop end
  end #trigger_textif end


  # def textifup(companydown, percentdrop)

  def textifdown(companydown, percentdrop) #texts user if their stocks are dropping substantially
        account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
        auth_token = '2008ea097713e401a16c54029058da82'

        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new account_sid, auth_token
        
        textmessage = "Alert:" + "\n" + companydown.upcase.to_s + " is down " + percentdrop.to_s + "% in the last hour."

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

      # companynames.each_index do |i|
      #   textmessage = @companynames[i] + "\nDollar Value:" + @dv[i].to_s + "\nPercentage:" + @percentage[i].to_s + "\nPrevious Closing Price:" + @pcp[i].to_s + @fdv[0].to_s
        textmessage = "heroku seems to be working"
        @client.account.messages.create(
          :from => '+18152642023',
          # :to => @usernumber,
          :to => '+19177542295'
          :body => textmessage
          )
      end
  end

end #class end

