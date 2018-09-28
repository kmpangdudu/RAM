var Resource;
function CallService() {
    Web.MapService.asmx.getmapen(Callback);
}

function Callback(result) {
    Resource = result;
    //var outDiv = document.getElementById("outputDiv");
    //outDiv.innerText = result;
}