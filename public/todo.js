$(document).ready( function () {

  var lists = $("select")

  lists.change( function (event) {
    var id = $("select option:selected").val();
    window.location.href = "/selectlist/"+id;
  });

  $("#btn-upd").click( function (e) {
    var params = { "del_ids" : [], "done_ids" : [], "undone_ids" : [] };
    var deletes = $("[id^=delete]:checked");
    var dones = $("[id^=done]");
    deletes.each(function (idx, val) {
      params["del_ids"].push( val.value )
    });
    dones.each(function (idx, val) {
      if ( val.checked ) {
        params["done_ids"].push( val.value )
      } else {
        params["undone_ids"].push( val.value )
      }
    });

    $.ajax({
      type: "POST",
      url: "/updtask",
      data: params
    })
    .done(function() {
      deletes.each ( function (idx, val) {
        $("#task-row-" + val.value ).remove();
      })
      dones.each ( function ( idx, val) {
        if ( val.checked ) {
          $("#task-row-" + val.value ).addClass("box-checked");
        } else {
          $("#task-row-" + val.value ).removeClass("box-checked");
        }
      })
   });
 });

})
