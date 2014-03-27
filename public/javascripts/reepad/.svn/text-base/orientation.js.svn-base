$(function(){
  

  var orient;
  if( window.orientation )
    orientationchanged();
  
  addEventListener("orientationchange", orientationchanged, false);
  function orientationchanged() { 
    orient = "portrait";
  
    if (modplus(window.orientation) == 90) {
      orient = "landscape";
    } else {
      imgg.setMinScale();
    }
  }

});