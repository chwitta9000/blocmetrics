Welcome to Whittaker-Blocmetrics

Heroku: whittaker-blocmetrics.herokuapp.com




wrap this in $(document) whatever and make it on click or whatever==>
--insert into application.js



$(document).ready(
  function(){
    $(".blocmetrics").click(
      function(event){
        .ajax({
            type: "POST",
            url: "http://localhost:4567/tracking-hit",
          data: {
            parameter_1: "Blocmetrics is awesome!"
            parameter_2: "Hello everyone!"
        }    
        });
      });
});








.ajax({
    type: "POST",
    url: "whittaker-blocmetrics.herokuapp.com/tracking-hit", 
  data: {
            parameter_1: "Blocmetrics is awesome!"
            parameter_2: "Hello everyone!"
          }
<!--     contentType: "application/json; charset=utf-8",
    dataType: "json",
    success: function(msg) {
      UseReturnedData(msg.d);
    },
    error: function(err) {
        alert(err.toString());
      if (err.status == 200) {
        ParseResult(err);
      }
      else { alert('Error:' + err.responseText + '  Status: ' + err.status); }
    } -->
});