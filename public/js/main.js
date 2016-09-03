$(document).on("click", "#edit-button", function(){
  var imageId    = $(this).data("image-id");
  var imageFile  = $(this).data("image-file");
  var imageTitle = $(this).data("image-title");

  $("#form-edit", "#modal-edit").attr("action", "/images/" + imageId + "/edit");
  $("#modal-image", "#modal-edit").attr("src", imageFile);
  $("#form-input-text", "#modal-edit").val(imageTitle);
});

$(document).on("click", "#delete-button", function(){
  var imageId    = $(this).data("image-id");
  var imageFile  = $(this).data("image-file");

  $("#form-delete", "#modal-delete").attr("action", "/images/" + imageId + "/delete");
  $("#modal-image", "#modal-delete").attr("src", imageFile);
});
