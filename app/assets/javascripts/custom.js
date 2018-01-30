$(document).ready(function(){
  $( ".avatar .camera" ).on( "click", function() {
    $( "#avatar" ).trigger( "click" );
  });

  $("#avatar").on("change", function(){
    readURL(avatar,"img-avatar");
  });

  $(document).on('click', '.browse', function(){
    var file = $(this).parent().parent().parent().find('.file');
    file.trigger('click');
  });
  
  $(document).on('change', '.file', function(){
    $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
  });
});
// get thumb image
function readURL(input,imgId) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
<<<<<<< 3a833543fdd1620f12e64827aedbaf72f623f6ef
      $('.'+imgId).attr('src', e.target.result);
=======
        $('.'+imgId).attr('src', e.target.result);
>>>>>>> User - Profile user
    }
    reader.readAsDataURL(input.files[0]);
  }
}
