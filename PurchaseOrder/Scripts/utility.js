
function setWindowSize() {
    $(window).resize(function () {


        var height = $(window).height() - 132;
        var width = $(window).width();


        if (width < 1000) {
            width = 1000;
            $("body").css("width", 1000);
        }
        else {
            $("body").css("width", "100%");
        }


        if (document.all != null) {
            height -= 10;
        }


        //if($(".Content").height()<height)
        //{
        //   $(".Content").css("height",height);

        //}
        // $(".Content").css("width",width- 235);




    }).resize();


}



function initialize() {


    // $(".datatable").Scrollable(400, $(window).width()-300);
    ApplyThickbox();
    $("input[id $='btnDelete']").click(function () { return confirm("Are you sure you want to delete this item?"); })





    $("span[mandatory='true'] label").remove();
    $("span[mandatory='true']").append("<label style='color:red'>*</label>");
    $("textbox,textarea").each(function (i) {

        this.value = $.trim(this.value);
    });

}

function OnTreeClick(evt) {



    var src = window.event != window.undefined ? window.event.srcElement : evt.target;
    var nodeClick = src.tagName.toLowerCase() == "a";


    if (nodeClick) {
        if (GetNodeValue(src) > 0)
            $("#inputEdit").attr('disabled', false);
        else
            $("#inputEdit").attr('disabled', true);

        $("#inputAdd").attr('disabled', false);



        var nodeText = src.innerText;
        var nodeValue = GetNodeValue(src);
        //alert("Text: "+nodeText + "," + "Value: " + nodeValue);
    }
    //return false; //uncomment this if you do not want postback on node click
}
function ShowDate(img) {

    var cal = new Zapatec.Calendar.setup({

        inputField: $(img.parentNode).prev().attr("id"),
        ifFormat: "%d-%m-%Y",
        button: $(img).attr('id'),
        showsTime: false
    });
}




function EnableView() {


    $(":button[alt],.leftPanel").remove();
    $(".gridheader th:last").html("Select");


}

function ModifyLeftpanel() {

    $.post("test.aspx?r=" + Math.random() % 1000, function (data) {

        $(".leftPanel").html(data);
    });
}

function ThousandSeparator(Value, digit) {
    decimalDigits = 2;
    if (digit != null) {
        decimalDigits = digit;
    }

    // Separator Length. Here this is thousand separator 
    var separatorLength = 3;
    var OriginalValue = Value;
    var TempValue = "" + OriginalValue;
    var NewValue = "";

    // Store digits after decimal 
    var pStr;

    // store digits before decimal 
    var dStr;

    // Add decimal point if it is not there 
    if (TempValue.indexOf(".") == -1) {
        TempValue += "."
    }

    dStr = TempValue.substr(0, TempValue.indexOf("."));

    pStr = TempValue.substr(TempValue.indexOf("."))

    // Add "0″ for remaining digits after decimal point 
    while (pStr.length - 1 < decimalDigits) { pStr += "0" }

    if (pStr == '.')
        pStr = "";

    if (dStr.length > separatorLength) {
        // Logic of separation 
        while (dStr.length > separatorLength) {
            NewValue = "," + dStr.substr(dStr.length - separatorLength) + NewValue;
            dStr = dStr.substr(0, dStr.length - separatorLength);
            separatorLength = 2;
        }
        NewValue = dStr + NewValue;
    }
    else {

        NewValue = dStr;
    }
    // Add decimal part 
    NewValue = NewValue + pStr;
    // Show Final value 

    var x = "";
    x = NewValue.substr(NewValue.indexOf("."));
    var y = NewValue.replace(x, "");
    if (x.length > decimalDigits + 1)
        x = x.substr(0, decimalDigits + 1);
    y = y.replace("-,", "-");
    return NewValue = y + x;
}


function MathRound(val, digit) {

    var temp = Math.pow(10, digit);

    return Math.round(val * temp) / temp;

}

function replaceCharacters(origString, inChar, outChar) {

    var newString = origString.split(inChar);
    newString = newString.join(outChar);
    return newString;

}