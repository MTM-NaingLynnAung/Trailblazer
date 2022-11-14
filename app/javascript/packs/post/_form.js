$("#public_schedule").on("click", function(){
  document.getElementById("private_schedule").value = null;
})
$("#private_schedule").on("click", function(){
  document.getElementById("public_schedule").value = null;
})
