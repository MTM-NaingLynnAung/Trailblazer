document.getElementById("failed").value = localStorage.getItem('failed_attempts');
$(".submit").on('click', function(){

  let number = document.getElementById("failed").value;
    number ++;
    localStorage.setItem('failed_attempts', number);
})

if (document.getElementById('failed').value > 5) {
  
  $(".timer-div").toggleClass('timer-none');
  var time = 59;
  var saved_countdown = localStorage.getItem('saved_countdown');

  if(saved_countdown == null) {
      var new_countdown = new Date().getTime() + (time + 2) * 1000;
      time = new_countdown;
      localStorage.setItem('saved_countdown', new_countdown);
  } else {
      time = saved_countdown;
  }

  var x = setInterval(() => {

    var now = new Date().getTime();
    var distance = time - now;
    var counter = Math.floor((distance % (1000 * 60)) / 1000);

    document.getElementById("timer").innerHTML = counter + " s";
        
    if (counter <= 0) {
        clearInterval(x);
        localStorage.removeItem('saved_countdown');
        $(".timer-div").addClass('timer-none');
    }
  }, 1000);

  $(".submit").prop("disabled", true);
  setTimeout(function(){
    $(".submit").prop("disabled", false);
    document.getElementById('failed').value = 0;
    localStorage.removeItem('failed_attempts');
    localStorage.setItem('failed_attempts', 0)
  }, 59000);
}
