var scale=0;
function resetPage() {
	var deviceWidth = document.documentElement.clientWidth;
	scale = deviceWidth/640;
	document.body.style.zoom = scale;
}
window.onload = function(){
	resetPage();
};
window.onresize = function(){
	resetPage();
};
function hengshuping(){
	if(window.orientation==180||window.orientation==0){
		jQuery("body").show();
	}
	if(window.orientation==90||window.orientation==-90){
		jQuery("body").hide();
		alert("~不支持横屏~");
	}
}
window.addEventListener("onorientationchange" in window ? "orientationchange" : "resize", hengshuping, false);
