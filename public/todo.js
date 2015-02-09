$(document).ready( function () {

  var lists = $("select")

  lists.change( function (event) {
    var id = $("select option:selected").val();
    window.location.href = "/selectlist/"+id;
  });

  $("#btn-upd").click( function (e) {
    var params = { "del_ids" : [], "done_ids" : [] };
    var deletes = $("[id^=delete]:checked");
    var dones = $("[id^=done]:checked");
    deletes.each(function (idx, val) {
      params["del_ids"].push( val.value )
    });
    dones.each(function (idx, val) {
      params["done_ids"].push( val.value )
    });
    window.location.href = "/updtasks"+id;    
  });

})
