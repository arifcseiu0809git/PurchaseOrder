var tb_pathToImage = "images/ajax-loader.gif";


function ApplyThickbox()
{
  
    tb_init('a.thickbox, area.thickbox, input.thickbox');//pass where to apply thickbox
	imgLoader = new Image();// preload image
	imgLoader.src = tb_pathToImage;
}


//add thickbox to href & area elements that have a class of .thickbox
function tb_init(domChunk){
   $(domChunk).unbind("click");
	$(domChunk).click(function(){
	var t = this.title || this.name || null;
	var a = this.href || this.alt;
	tb_show(t,a);
	this.blur();
	return false;
	});
}

function tb_show(caption, url) {//function called when the user clicks on a thickbox link

	try {
		
		if (typeof document.body.style.maxHeight === "undefined") {//if IE 6
			
			if (document.getElementById("TB_HideSelect") === null) {//iframe to hide select elements in ie6
				$("body").append("<iframe id='TB_HideSelect'></iframe>");
			}
		}
		
		
		
		
		
		
		$("#TB_window").remove();
		$("body").append("<div id='TB_overlay'></div><div id='TB_window' ></div>");
		
		
		$("#TB_overlay").addClass("TB_overlayBG");
		$("#TB_window").append("<div id='TB_load'><img src='"+imgLoader.src+"' /></div>");//add loader to the page
		
		
		var queryString = url.replace(/^[^\?]+\??/,'');
		var params = tb_parseQuery( queryString );

		TB_WIDTH = (params['width']*1) + 30 || 1000; //defaults to 630 if no paramaters were added to URL
		/*	TB_HEIGHT = (params['height']*1) + 40 || 500; //defaults to 440 if no paramaters were added to URL*/

		let winHeight = window.innerHeight;

		if (winHeight < 500) {
			TB_HEIGHT = 350;
		}
		else if (winHeight > 500 && winHeight < 600) {
			TB_HEIGHT = 400;
		}
		else if (winHeight > 600 && winHeight < 700) {
			TB_HEIGHT = 500;
		}
		else {
			TB_HEIGHT = 600; //defaults to 440 if no paramaters were added to URL
		}

			
		if(url.indexOf('TB_iframe') != -1){	
			urlNoQuery = url.split('TB_');
			$("#TB_window").append("<iframe frameborder='0' hspace='0' src='"+urlNoQuery[0]+"'  name='TB_iframeContent"+Math.round(Math.random()*1000)+"' onload='tb_showIframe()' style='width:100%;height:100%' > </iframe>");
			$("#TB_window").dialog( {
				 height: TB_HEIGHT ,
				 width:TB_WIDTH, 
				 title:caption,
				resizable: false,
				position: {
					my: 'center top+70',
					at: 'center top'
				},
				// modal: true,
                                 close: function(event, ui) { 
                                     $("#TB_window").dialog( 'destroy' );
                                     $("#TB_HideSelect").remove();
                                     $("#TB_overlay").remove();
                                     $("#TB_window").html('');
                                     
                                    
                                 }
                                

			    });


		}

		
		
	   } catch(e) {	alert(e); }
}


function tb_showIframe(){
	$("#TB_load").remove();
	
}


function tb_remove(){
         
         $("#TB_window").dialog( 'close' );
        
	
}



function tb_parseQuery ( query ) {
   var Params = {};
   if ( ! query ) {return Params;}// return empty object
   var Pairs = query.split(/[;&]/);
   for ( var i = 0; i < Pairs.length; i++ ) {
      var KeyVal = Pairs[i].split('=');
      if ( ! KeyVal || KeyVal.length != 2 ) {continue;}
      var key = unescape( KeyVal[0] );
      var val = unescape( KeyVal[1] );
      val = val.replace(/\+/g, ' ');
      Params[key] = val;
   }
   return Params;
}



