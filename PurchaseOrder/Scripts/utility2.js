
function setWindowSize()
{
    $(window).resize( function(){ 
    
    
        var height =$(window).height()-132;
     var width =$(window).width();
    
   
     if(  width < 1000)
     {
      width = 1000;
     $("body").css("width",1000);
     }
     else
     {
      $("body").css("width","100%");
     }
      
     
     if(document.all!=null)
     {
        height-=10;
     }
    
     
     if($(".Content").height()<height)
     {
        $(".Content").css("height",height);
        
     }
      $(".Content").css("width",width- 235);
     
   
    
    
      } ).resize();
      

}



function initialize()
{

   
  // $(".datatable").Scrollable(400, $(window).width()-300);
    ApplyThickbox();
    $("input[id $='btnDelete']").click(function (){ return confirm("Are you sure you want to delete this item?");   } ) 
     
    
  

    
    $("span[mandatory='true'] label").remove();
  $("span[mandatory='true']").append("<label style='color:red'>*</label>");
   
     
}

function OnTreeClick(evt)
{



var src = window.event != window.undefined ? window.event.srcElement : evt.target;
var nodeClick = src.tagName.toLowerCase() == "a";


if(nodeClick)
{
if(GetNodeValue(src)>0)
 $("#inputEdit").attr('disabled',false);
 else
 $("#inputEdit").attr('disabled',true);
 
 $("#inputAdd").attr('disabled',false);



var nodeText = src.innerText;
var nodeValue = GetNodeValue(src);
//alert("Text: "+nodeText + "," + "Value: " + nodeValue);
}
//return false; //uncomment this if you do not want postback on node click
}
function ShowDate(img)
                        {      
                           
                         var cal = new Zapatec.Calendar.setup({
                        
		                inputField: $(img.parentNode).prev().attr("id"),
		                ifFormat:"%d-%m-%Y",
		                button: $(img).attr('id'),
		                showsTime:false
		            });
		            }
		            
		            
		            
		            
		            function EnableView()
		            
		            {
		            
		            
		            $(":button[alt],.leftPanel").remove();
		              $(".gridheader th:last").html("Select");
		            
		            
		            }
		            
        function ModifyLeftpanel()
        {

        $.post("test.aspx?r=" + Math.random()%1000, function(data){

        $(".leftPanel").html(data);
        });
        }
        
        
        
        
        function MathRound(val,digit)
        {
        
            var temp = Math.pow(10,digit);
        
            return Math.round(val*temp)/temp; 
        
        }
          