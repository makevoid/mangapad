$(function(){
  

function Imgg(elementID, callback){
  var self = this;
  this.imgg = document.getElementById(elementID);
  this.callback = callback;
  this.first = document.getElementById("first");
  //this.first = document.getElementsByClassName("first")[0];
  this.imgHeight = 0;
  this.imgWidth = 0;
  this.first.onload=function(){
    if (is_iOS) {
      loadPageImage(page_id, "first");
    }
    imgg.imgHeight = $('#imgg #first').height();
    imgg.imgWidth = $('#imgg #first').width();
  }
  this.movedByX = 0;
  this.movedByY = 0;
  this.imgg.addEventListener("touchstart", this, false);
  this.imgg.addEventListener("touchmove", this, false);
  this.imgg.addEventListener("touchend", this, false);
  this.imgg.addEventListener("gesturechange", this, false);
  this.imgg.addEventListener("gestureend", this, false);
  this.accel = 0;
  // scale
  this.scale = 1.0; 
  this.startScale = 1.0;
  this.minScale = (window.innerHeight-$("#menu").height())/this.first.height;

}


Imgg.prototype.handleEvent = function(event){
  if (typeof(this[event.type]) === "function"){
    return this[event.type](event);
  }
}

Imgg.prototype.touchstart = function(event) { 
  event.preventDefault();
  //$('#konsole').append("start ");
  if (event.targetTouches.length == 1) {
    this.startX = event.targetTouches[0].pageX;
    this.startY = event.targetTouches[0].pageY;
    this.moveKnobTo(this.startX, this.startY);
    time = new Date(); time.getTime();
    this.time = time;
  } else if (event.targetTouches.length == 2) {
    this.centerX = (event.targetTouches[0].pageX + event.targetTouches[1].pageX)/2;
    this.centerY = (event.targetTouches[0].pageY + event.targetTouches[1].pageY)/2;
    //konsole("this.centerX: "+this.centerX+" this.centerY: "+this.centerY);
  }
}
Imgg.prototype.touchmove = function(event) { 
  event.preventDefault();
  //$('#konsole').append(this.left);

  //$('#konsole').append(time2 + " ");
  if (event.targetTouches.length == 1) {
    this.moveKnobTo(event.targetTouches[0].pageX, event.targetTouches[0].pageY);
    //this.checkAndLoadImages();
  }
}

Imgg.prototype.touchend = function(event) {   
  //this.transformImage("move");
  this.movedByX = this.deltaX;
  this.movedByY = this.deltaY;
  
  this.checkAndLoadImages();
}

Imgg.prototype.moveKnobTo = function(x, y) {
  this.pageX = x;
  this.pageY = y;
  this.deltaX = x - this.startX + this.movedByX;
  this.deltaY = y - this.startY + this.movedByY;

  // FIXME: time
  // time = new Date(); time.getTime();
  //  dTime = time - this.time;
  //  
  //  this.speedX = modplus(x - this.startX) / dTime;
  //  this.speedY = modplus(y - this.startY) / dTime;
  

  this.transformImage("move", true);
}

Imgg.prototype.maxScaleReached = function() {
  return this.scale == this.minScale || this.scale >= 1.5;
}

Imgg.prototype.checkAndLoadImages = function() { 
  //this.treshold = imagesTotalWidth() + this.deltaX - $('#imgg img:last').width();
  //konsole(this.deltaX+" - "+this.dXMin); // was up
  //konsole(this.scale +' - '+this.minScale);
  if (this.scale <= 1 || this.maxScaleReached() ) { 

    if (-this.dXMin >= this.deltaX ){ 
   
      if (this.maxScaleReached()) {
        this.scale = 1;
      }
      //konsole("loading next")
			if ($('#imgg img').size() >= 3)
      	this.loadImage("next");
      	
      
      //this.first.removeEventListener('touchmove', self.onTouchMove(e), false);
    } else if ( this.dXMin <= this.deltaX ){
    
      if (this.maxScaleReached()) {
        this.scale = 1;
      }   
			if ($('#imgg img').size() >= 3)
      	this.loadImage("prev");
    } else {
      this.fireResetAnimation();
    }
  }
}
Imgg.prototype.fireResetAnimation = function() {
  this.first.style.webkitTransitionDuration = "0.2s";
  this.first.style.webkitTransform = 'translate3d('+0+'px, '+this.deltaY+'px, 0) '+ 'scale(' + this.scale + ')';;
  this.deltaX = this.movedByX = 0;

  this.resetTransitionDuration();
}

Imgg.prototype.resetTransitionDuration = function() {
  this.first.addEventListener( 'webkitTransitionEnd', function( event ) { 
    first = document.getElementById("first")
    first.style.webkitTransitionDuration = "0s";
    animating = false;
  }, false );
}

Imgg.prototype.loadImage = function(direction) {
  //konsole($("#next").size() == 1 ? "next" : "nonext");
  if (document.getElementById(direction) == undefined) {
    konsole("WTF! direction undefined? expected prev");
    return false;
  }
    
  
  this.first.style.webkitTransitionDuration = "0.4s";

  if (direction == "next"){
    this.first.style.webkitTransform = 'translate3d('+-2*window.innerWidth+'px, '+this.deltaY+'px, 0)';
		this.next = document.getElementById("next");
		
		src = $("#prev").attr("src");
		page_id = $("#prev").attr("data-page_name");
		page_name = $("#prev").attr("data-page_id");
    $("#prev").remove();

		this.first.id = "prev";
		this.next.id = "first";
		
    this.prev = document.getElementById("prev");
    this.first = document.getElementById("first");

  } else { // direction == "prev"
    direction = "prev";
    this.first.style.webkitTransform = 'translate3d('+2*window.innerWidth+'px, '+this.deltaY+'px, 0)';
		
		src = $("#next").attr("src");
		page_id = $("#next").attr("data-page_name");
		page_name = $("#next").attr("data-page_id");
    $("#next").remove();

		this.first.id = "next";
		this.prev.id = "first";
		
    this.next = document.getElementById("next");
    this.first = document.getElementById("first");
  }
    
  this.first.style.webkitTransitionDuration = "0.4s";
  this.first.style.webkitTransform = 'translate3d('+0+'px, '+0+'px, 0)'+ 'scale(' + this.scale + ')';
  this.deltaX = this.movedByX = this.movedByY = 0;
  
  this.resetTransitionDuration();
  
  loadPageImage($('#first').attr("data-page_id"), direction);
}

Imgg.prototype.gesturechange = function(event) { 
  event.preventDefault();
  kanvas = window.innerHeight-$("#menu").height();
  this.minScale = kanvas/this.first.height;

  this.scale = this.startScale * event.scale;
  this.scale = Math.max(this.minScale, this.scale);
  this.scale = Math.min(1.5, this.scale);

  imgd2 = this.imgHeight/2; 
  this.deltaY = Math.min(imgd2*this.scale-imgd2, this.deltaY);
  
  //centerX = event.targetTouches[0].pageX - event.targetTouches[1].pageX;
  //centerY = event.targetTouches[0].pageY - event.targetTouches[1].pageY;

  //konsole("centerX: "+centerX+" centerY: "+centerY);
  this.transformImage("scale");
}

Imgg.prototype.gestureend = function(event) { 
  this.startScale = this.scale;
      
}

var animating = false;
Imgg.prototype.transformImage = function(evt_type, margin) { 
  
  
  kanvas = window.innerHeight-$("#menu").height();
  landscape = modplus(window.orientation) == 90;
  
  // deltaY
  imghd2 = this.imgHeight/2;
  imgwd2 = this.imgWidth/2;
  
  this.deltaY = Math.min(imghd2*(this.scale-1), this.deltaY);
  pez = -this.imgHeight+kanvas;
  max = -this.imgHeight+kanvas/2*(1/this.scale+1);
  coeff = landscape ? 1.3 : 1.4;
  if (this.scale > 1)
    max = max*coeff;
  this.deltaY = Math.max(max, this.deltaY);


  if (this.scale <= 1) {
    if (!margin) {
      this.deltaX = Math.max(-imgwd2*(-this.scale+1), this.deltaX);
      this.deltaX = Math.min(imgwd2*(-this.scale+1), this.deltaX);
    } else {
      this.dXMin = imgwd2*(-this.scale+1)+200;
      this.deltaX = Math.max(-imgwd2*(-this.scale+1)-200, this.deltaX);
      this.deltaX = Math.min(this.dXMin, this.deltaX);
      //this.deltaXLim = Math.max(imgwd2*(-this.scale+1)+200, this.deltaX);
      //this.deltaXLim = this.deltaX;      
    }
  }
  
  //this.deltaX = Math.min(imgwd2*(this.scale+1), this.deltaX);

  //konsole("kanvas: "+kanvas+" imgHeight: "+this.imgHeight+" dY: "+this.deltaY+" dX: "+this.deltaX+", scale: "+this.scale);

  this.first.style.webkitTransform = 'translate3d('+this.deltaX+'px, '+this.deltaY+'px, 0)'+ 'scale(' + this.scale + ')';

}



Imgg.prototype.setMinScale = function() { 
  if ( this.first.height != 0 ) {
    this.minScale = (window.innerHeight-$("#menu").height())/this.first.height;
    //konsole(this.first.height);
    this.scale = Math.max(this.minScale, this.scale);
    this.transformImage("scale");
  }
}

var imgg = new Imgg("imgg", ended);

function ended(){
  // ? 
}

$("#next_image").click(function(){
  imgg.loadImage("next");
  // if (first page)
    $("#prev_image").show('slow');
});

$("#prev_image").click(function(){
  imgg.loadImage("prev");
  // if (last page)
    $("#next_image").show('slow');
});

var loadingPage = false;

function loadPageImage(pag_id, direction){
  if (!loadingPage){
    loadingPage = true;
    konsole(direction + ", url: " +root_url + "pages/" + pag_id + "/"+direction);
    url_direction = direction;
    if (url_direction == "first") 
      url_direction = "next";
    
    if (app_name == "reepad"){
      (url_direction == "next") ? page_id=pag_id+1 : page_id=pag_id-1;
      page = {
        "page_id": page_id,
        "name": "",
        "image_url": root_url+"pages/"+issue_id+"/"+page_id+".pdf"
      }
      add_image(page, pag_id, direction);
    } else {
      konsole("mbe?");
      $.getJSON(root_url + "pages/" + pag_id + "/"+url_direction, function(data){
        page = data.page;
        add_image(page, pag_id, direction);
      });
    }
  }
}


function add_image(page, pag_id, direction) {
  image_url = page.image_url;
  if (image_url != "") {
    
    if (direction != "first"){
      
      img = "<img id='"+direction+"'>";
    	$('#imgg').append($(img));
       img2 = "img#"+direction;
      $(img2).css({ "-webkit-transform": "translate3d("+window.innerWidth+"px, 0px, 0)"});
      $(img2).attr("src", image_url);
      $(img2).attr("data-page_id", page.page_id);
      $(img2).attr("data-page_name", page.name);
      $("span#page").html($("#first").attr("data-page_name"));

      megadebug();
      
    } else { // direction == first
      
      img = "img#next";
      $(img).css({ "-webkit-transform": "translate3d("+window.innerWidth+"px, 0px, 0)"});
      $(img).attr("src", image_url);
      $(img).attr("data-page_id", page.page_id);
      $("img#next").attr("data-page_name", page.name);
      $("img#first").attr("data-page-id", pag_id);
      
      megadebug();
    }
  } else {
    $("#konsole").html("error retreiving "+direction+" image_url");
  }
  
  loadingPage = false;
}


// keyboard events

if (!is_iOS) {
  if (!no_next_page) {
    $('img.first').css({ cursor: "pointer" });
    $('img.first').click(function(){
      document.location=$("#controls a.next").attr("href");
    });  
  }
  
  document.onkeydown = function(e) {
      e = e || window.event;
      var keycode = e.keyCode || e.which;
    
      if (keycode == 39) {         
        // imgg.loadImage("next");
        // // if (first page)
        //   $("#prev_image").show('slow');
        if ($("#controls a.next").length != 0)
          document.location=$("#controls a.next").attr("href");
      } else if (keycode == 37) {
        if ($("#controls a.prev").length != 0)
          document.location=$("#controls a.prev").attr("href");
      }
  }
}

});