Welcome to Whittaker-Blocmetrics

Heroku: whittaker-blocmetrics.herokuapp.com




wrap this in $(document) whatever and make it on click or whatever==>

.ajax({
    type: "POST",
    url: "Servicename.asmx/DoSomeCalculation", 
  data: "{param1ID:"+ param1Val+"}",
    contentType: "application/json; charset=utf-8",
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
    }
});