TO DO:
DATABASING FOR MULTIPLE USERS
add checks for all input
have textboxes generate as you type (maybe start with 3 or so) (could be made easily with a limit of 20 or so if the textboxes already existed and were just hidden from the user)
add input for what time you should receive updates
add support for full company names

git push heroku master  =>  updates the page on heroku
shotgun app.rb  =>  to create server on the computer

https://github.com/flatiron-school-students/hs-summer-sinatra-refactor-summer14-001
https://github.com/flatiron-school-students/heroku_deploy-summer14-001
https://devcenter.heroku.com/articles/scheduler
http://limitless-escarpment-7709.herokuapp.com/
https://scheduler.heroku.com/dashboard
http://stocks.tradingcharts.com/  =>  good for adding support for full company names

QUESTIONS:
How to have ruby communicate to the .erb

Why doesn't this work?
onblur = "resetField()"
onfucus = "resetField()"
<script type="text/javascript">
//   function resetField() {
//   var fieldValue = document.getElementById("subdrop"); //+ ".value"/".innerHTML")
//   innerHTML(fieldValue.value=='')fieldValue.value='(percentage)';
//   if(fieldValue.value=='(percentage)')fieldValue.value='';
//   }
</script>

Why doesnt this work? (would be implemented to check phone number field and others)
def checkforchar(input)
  begin
    number = false
    if input.is_a? Numeric {
      number = true
    else
      raise “Not a number"
    }
  rescue
    #def to reload the page
  end
end

Be able to type a number as a variable, have the javascript loop through until it reaches that number for the textboxes visible to the user upon entering the page. Every time the user clicks "add more", more textboxes could be generated. The total number of textboxes generated would be saved and sent into app.rb where the ruby would loop through and create that many variables.