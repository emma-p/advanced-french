$(document).ready(function(){
  function addHeading() {
    var h3 = $("h3");
    $('.row').prepend("<div class='span4'><ul class='nav nav-list affix'>");
    $('.nav-list').prepend("<li class='nav-header'>Contents</li>");
    h3.each(function(index){
      $(this).attr('id', index);
      $('.nav-list').append("<li><a href=#" + index + ">" + $(this).text() + "</a></li>");
    });
    $('.span4').after("</ul></div>");
  }

  if ($("h3").length){
    addHeading();
  }
})
