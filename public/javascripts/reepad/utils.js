function modplus(num){
  return Math.sqrt(Math.pow(num, 2));
}

function konsole(stuff) {
  $('#konsole').html( stuff +"<br>" + $('#konsole').html() );
}

function debugg_multiple(elements, attrs) {
  if (attrs == undefined) 
    attrs = [];
  string = "";
  for (var i = elements.length - 1; i >= 0; i--){
    string = string + debugg(elements[i], attrs) + "<br>";
  };
  return string;
}

function debugg(element, attrs) {
  if (attrs == undefined) 
    attrs = [];
  string = "";
  for (var i = attrs.length - 1; i >= 0; i--){
    string = string + attrs[i]+": "+$(element).attr(attrs[i])+", ";
  };
  return element+": { "+string+" }";
}

function megadebug() {
  // $("#konsole").html(
	konsole(
    debugg_multiple(["img#prev", "img#first", "img#next"], ["data-page_id", "src", "data-page_name"]) // , "src"
  );
}

$(function(){
  $('#konsole').ajaxError(function(event, request, settings) {
    $(this).prepend('ajaxError triggered with url: '+ settings.url +"<br>");
  });
});