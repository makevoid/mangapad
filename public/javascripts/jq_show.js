// unused, think about trying zepto js and add moz-transform support

      //change dynamic css
var jQT = new $.jQTouch({
          slideSelector: '#jqt li a, .slide',
	icon: 'jqtouch.png',
          addGlossToIcon: false,
          startupScreen: '/images/jqt/jqt_startup.png',
          statusBar: 'black',
          preloadImages: [
              '/images/jqt/back_button.png',
              '/images/jqt/back_button_clicked.png',
              '/images/jqt/button_clicked.png',
              '/images/jqt/grayButton.png',
              '/images/jqt/whiteButton.png',
              '/images/jqt/loading.gif'
              ]
      });
      // Some sample Javascript functions:
      $(function(){
          // Show a swipe event on swipe test
          $('#swipeme').swipe(function(evt, data) {
              $(this).html('You swiped <strong>' + data.direction + '/' + data.deltaX +':' + data.deltaY + '</strong>!');
              $(this).parent().after('<li>swiped!</li>')

          });
          $('#tapme').tap(function(){
              $(this).parent().after('<li>tapped!</li>')
          })
          $('a[target="_blank"]').click(function() {
              if (confirm('This link opens in a new window.')) {
                  return true;
              } else {
                  return false;
              }
          });
          // Page animation callback events
          $('#pageevents').
              bind('pageAnimationStart', function(e, info){ 
                  $(this).find('.info').append('Started animating ' + info.direction + '&hellip; ');
              }).
              bind('pageAnimationEnd', function(e, info){
                  $(this).find('.info').append(' finished animating ' + info.direction + '.<br /><br />');
              });
          // Page animations end with AJAX callback event, example 1 (load remote HTML only first time)
          $('#callback').bind('pageAnimationEnd', function(e, info){
              // Make sure the data hasn't already been loaded (we'll set 'loaded' to true a couple lines further down)
              if (!$(this).data('loaded')) {
                  // Append a placeholder in case the remote HTML takes its sweet time making it back
                  // Then, overwrite the "Loading" placeholder text with the remote HTML
                  $(this).append($('<div>Loading</div>').load('ajax.html .info', function() {        
                      // Set the 'loaded' var to true so we know not to reload
                      // the HTML next time the #callback div animation ends
                      $(this).parent().data('loaded', true);  
                  }));
              }
          });
          // Orientation callback event
          $('#jqt').bind('turn', function(e, data){
              $('#orient').html('Orientation: ' + data.orientation);
          });
          $('#play_movie').bind('tap', function(){
              $('#movie').get(0).play();
              $(this).removeClass('active');
          });
          
          $('#video').bind('pageAnimationStart', function(e, info){
              $('#movie').css('display', 'none');
          }).bind('pageAnimationEnd', function(e, info){
              if (info.direction == 'in')
              {
                  $('#movie').css('display', 'block');
              }
          });

  host = "192.168.1.2:3000"
	jQT.generateGallery("photo2",[				
	{src:"http://"+host+"/img/img.1000manga.com/mangas/00000025/000280692/01.jpg"},
	{src:"http://"+host+"/img/img.1000manga.com/mangas/00000025/000280692/02.jpg"},				  
  {src:"http://"+host+"/img/img.1000manga.com/mangas/00000025/000280692/03.jpg"},				  
  {src:"http://"+host+"/img/img.1000manga.com/mangas/00000025/000280692/04.jpg"}
								 ]);
      });