$(document).ready( function () {

  var lists = $("select")
console.log('1')
  lists.change( function (event) {
    console.log('2')
    var id = $("select option:selected").val()
    window.location.href = "/selectlist/"+id
  })

})
