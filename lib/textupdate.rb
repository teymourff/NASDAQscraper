require 'final.rb'
class TextUpdate
  def textupdate
        account_sid = 'ACe330ba04d082392df4cb3511dcb72cec'
        auth_token = '2008ea097713e401a16c54029058da82'

        # set up a client to talk to the Twilio REST API
        @client = Twilio::REST::Client.new account_sid, auth_token

        if @up == true
          companynames.each_index do |i|
            textmessage = @companynames[i].upcase + " is worth $" + @dv[i].to_s + ", up:" + @percentage[i].to_s + "." #+ " Its previous closing price is" + @pcp[i].to_s + "."
          end #do loop end
        elsif @up == false
          companynames.each_index do |i|
            textmessage = @companynames[i].upcase + " is worth $" + @dv[i].to_s + ", down:" + @percentage[i].to_s + "." #+ "Its previous closing price is" + @pcp[i].to_s + "."
          end #do loop end
        end

          # textmessage = "'textupdate' has been run."
          @client.account.messages.create(
            :from => '+18152642023',
            # :to => @usernumber,
            :to => '+19177542295',
            :body => textmessage
            )
  end #def end
end