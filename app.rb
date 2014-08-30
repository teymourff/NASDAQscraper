require 'bundler' #require bundler
require './lib/final.rb'
Bundler.require #require everything in bundler in gemfile

get '/' do
  erb :index
end

post '/stocks' do
    @mystocks1 = Stocks.new(params[:companysymbol1]) #takes the value from the form named companysymbol1
    @mystocks2 = Stocks.new(params[:companysymbol2])
    @mystocks3 = Stocks.new(params[:companysymbol3])
    @mystocks4 = Stocks.new(params[:companysymbol4])
    @mystocks5 = Stocks.new(params[:companysymbol5])
    @mystocks6 = Stocks.new(params[:companysymbol6])
    @mystocks7 = Stocks.new(params[:companysymbol7])
    @mystocks8 = Stocks.new(params[:companysymbol8])
    @mystocks9 = Stocks.new(params[:companysymbol9])
    @mystocks10 = Stocks.new(params[:companysymbol10])
    @mystocks11 = Stocks.new(params[:companysymbol11])
    @mystocks12 = Stocks.new(params[:companysymbol12])
    @mystocks13 = Stocks.new(params[:companysymbol13])
    @mystocks14 = Stocks.new(params[:companysymbol14])
    @mystocks15 = Stocks.new(params[:companysymbol15])
    # usernumber = params[:usernumber]
    
    # substantialdrop = params[:subdrop].chomp("%")
    # if substantialdrop == "2"
    #     substantialdrop = 0.02
    # elsif substantialdrop.to_f > 0
    #     substantialdrop = substantialdrop.to_f  / 100
    # else
    #     erb :index
    # end

    @mystocks1.scrape
    @mystocks2.scrape
    @mystocks3.scrape
    @mystocks4.scrape
    @mystocks5.scrape
    @mystocks6.scrape
    @mystocks7.scrape
    @mystocks8.scrape
    @mystocks9.scrape
    @mystocks10.scrape
    @mystocks11.scrape
    @mystocks12.scrape
    @mystocks13.scrape
    @mystocks14.scrape
    @mystocks15.scrape
    #@mystocks.writefdv
    #@mystocks.textupdate
    # erb :index #display original page again
    erb :stocks
end