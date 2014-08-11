require 'bundler' #require bundler
require './lib/final.rb'
Bundler.require #require everything in bundler in gemfile

get '/' do
  erb :index
end

post '/' do
    name1 = params[:companysymbol1] #takes the value from the form named companysymbol1
    name2 = params[:companysymbol2]
    name3 = params[:companysymbol3]
    name4 = params[:companysymbol4]
    name5 = params[:companysymbol5]
    name6 = params[:companysymbol6]
    name7 = params[:companysymbol7]
    name8 = params[:companysymbol8]
    name9 = params[:companysymbol9]
    name10 = params[:companysymbol10]
    name11 = params[:companysymbol11]
    name12 = params[:companysymbol12]
    name13 = params[:companysymbol13]
    name14 = params[:companysymbol14]
    name15 = params[:companysymbol15]
    names = [name1, name2, name3, name4, name5, name6, name7, name8, name9, name10, name11, name12, name13, name14, name15] 
    usernumber = params[:usernumber]
    @mystocks = Stocks.new(names, usernumber) #feeds in name1 as an array to final.rb (new runs initialize)
    @mystocks.scrape
    @mystocks.writefdv
    # @mystocks.diagnostic
    erb :index #display original page again
end