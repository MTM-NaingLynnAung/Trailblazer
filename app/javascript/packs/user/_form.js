$('#profile').on('change', function(e) {
  var reader = new FileReader();
  reader.onload = function (event) {
      $('#img_prev')
          .attr('src', event.target.result);
  };
  reader.readAsDataURL(e.target.files[0]);
});

$(".showPwd").on('click', function() {
  $(this).toggleClass("fa-eye-slash fa-eye")
  if ($(".pwd").attr('type') === 'password') {
      $(".pwd").attr('type', 'text');
  } else {
      $(".pwd").attr('type', 'password');
  }
});

$(".cShowPwd").on('click', function() {
  $(this).toggleClass("fa-eye-slash fa-eye")
  if ($(".cpwd").attr('type') === 'password') {
      $(".cpwd").attr('type', 'text');
  } else {
      $(".cpwd").attr('type', 'password');
  }
});
