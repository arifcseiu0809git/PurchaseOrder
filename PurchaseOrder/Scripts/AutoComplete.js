function selectKeyDown()
{
    // "Delete" Key resets previous search keys.
    if(window.event.keyCode == 46)
        clr();                
}

function selectKeyPress()
{    
    // If the search doesn't find a match, this returns to normal 1 key search. Setting returnValue = false below for ALL cases will prevent default behavior.	
    var sndr = window.event.srcElement;
    var pre = this.document.all["keys"].value;
    var key = window.event.keyCode;
    var char = String.fromCharCode(key);

    var re = new RegExp("^" + pre + char, "i"); // "i" -> ignoreCase    
    for(var i=0; i<sndr.options.length; i++)
    {	    
	    if(re.test(sndr.options[i].text))
	    {		    
		    sndr.options[i].selected=true;
		    document.all["keys"].value += char;
		    window.event.returnValue = false;
		    break;
	    }
    }    
}

function clr()
{
    document.all["keys"].value = "";
}