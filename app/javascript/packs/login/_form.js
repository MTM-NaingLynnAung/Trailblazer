document.getElementById("failed").value = localStorage.getItem('failed_attempts');
$(".submit").on('click', function(){

  let number = document.getElementById("failed").value;
    number ++;
    localStorage.setItem('failed_attempts', number);
})

if (document.getElementById('failed').value > 5) {
  $(".submit").prop("disabled", true);
  setTimeout(function(){
    $(".submit").prop("disabled", false);
    document.getElementById('failed').value = 0;
    localStorage.removeItem('failed_attempts');
    localStorage.setItem('failed_attempts', 0)
  }, 60000);
}
