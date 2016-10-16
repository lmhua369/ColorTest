<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String ip=request.getParameter("ip");
%>
<!DOCTYPE html>
<html style="overflow-y:scroll;">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="initial-scale=1, width=device-width, maximum-scale=1, user-scalable=no"/>
		<title></title>
		<style>
			*{margin: 0px;padding: 0px;}
			.outer{
				height: 24px;
				width: 530px;
				border-radius: 8px;
				border:1px solid #999;
				margin-left: 30px;
				margin-top: 50px;
				position: relative;
			}
			.outer1{
				width: 530px;
				height: 100%;
				border-radius: 6px;
				-webkit-transform: matrix(1,0,0,1,0,0)translateZ(0);
				transform: matrix(1,0,0,1,0,0)translateZ(0);
			}
			#outerr1{
				height: 24px;
				width: 530px;
				border-radius: 8px;
				border:1px solid #999;
				margin-left: 30px;
				margin-top: 80px;
				position: relative;
			}
			.outer2{
				height: 50px;
				width: 50px;
				border-radius: 10px;
				position: absolute;
				right: -25px;
				top: -14px;
				
				-webkit-transform: matrix(1,0,0,1,0,0)translateZ(0);
				transform: matrix(1,0,0,1,0,0)translateZ(0);
			}
			#outer21{
				background:-webkit-linear-gradient(
				top,
				#f00 0%,
				#efedee 95%,
				#f3f3f3 100%);
			}
			#outer22{
				background:-webkit-linear-gradient(
				top,
				#0f0 0%,
				#efedee 95%,
				#f3f3f3 100%);
			}
			#outer23{
				background:-webkit-linear-gradient(
				top,
				#00f 0%,
				#efedee 95%,
				#f3f3f3 100%);
			}
			#outer31{
				background:-webkit-linear-gradient(
				top,
				#000 0%,
				#efedee 95%,
				#f3f3f3 100%);
			}
			.rgb{
				width: 550px;
				height: 60px;
				margin-top: 40px;
				margin-left: 35px;
				color: #777;
				font-size: 32px;
				line-height: 50px;
				position: relative;
			}
			.rgb input{
				width: 65px;
				height: 32px;
				font-size: 24px;
				outline: none;
				margin-left: 5px;
				margin-right: 15px;
				line-height: 35px;
				padding-top:3px;
			}
			.rgb .rgb1{
				width: 105px;
				height:31px;
				padding-top:4px;
			}
			#color_container{
				margin-left:150px;
				margin-top:50px;
				display:block;
			}
			.circle {
				border-radius: 50%;
				width: 190px;
				height: 190px;
				margin-left:205px;
				margin-top:55px;
				display:block;
				position:absolute;
				z-index:10;
			}
			#colorcircle {
				border-radius: 50%;
				width: 100px;
				height: 100px;
				margin-left:250px;
				margin-top:100px;
				display:block;
				position:absolute;
				z-index:20;
			}
		</style> 
		
		<script type="text/javascript" src="js/zepto.min.js"></script>
		<script type="text/javascript" src="js/scale.js"></script>
		<script type="text/javascript" src="js/getcanvaspixelcolor.js"></script>
	</head>
	<body>
		<div class="circle"></div>
		<div id="colorcircle"></div>
		<canvas id="color_container" width="300px" height="300px"></canvas>
		<div class="outer" id="outerr1">
			<div class="outer1" id="outer11"></div>
			<div class="outer2" id="outer21"></div>
		</div>
		<div class="outer">
			<div class="outer1" id="outer12"></div>
			<div class="outer2" id="outer22"></div>
		</div>
		<div class="outer">
			<div class="outer1" id="outer13"></div>
			<div class="outer2" id="outer23"></div>
		</div>
		<div class="rgb">
			r:<input id="rrr" type="number" value="255"/>
			g:<input id="ggg" type="number" value="255"/>
			b:<input id="bbb" type="number" value="255"/>
			<input class="rgb1" readonly="true" value="#FFFFFF"/>
		</div>
		<div class="outer">
			<div class="outer1"></div>
			<div class="outer2" id="outer31"></div>
		</div>
		
	</body>
	<script>
		$("body").on("touchmove",function(){
			return false;
		},false);
		var ip=<%=ip%>;
		var light=0;
		var s="";
		var rr=255,gg=255,bb=255,light=255;
		var reg=/\-?[0-9]+\.?[0-9]*/g;
		$(".outer1").eq(0).css("background","red");
		$(".outer1").eq(1).css("background","green");
		$(".outer1").eq(2).css("background","blue");
		$(".outer1").eq(3).css("background","black");
		$(".outer2").eq(0).css("border","1px solid red");
		$(".outer2").eq(1).css("border","1px solid green");
		$(".outer2").eq(2).css("border","1px solid blue");
		$(".outer2").eq(3).css("border","1px solid black");
		$(".outer2").on("touchstart",a1,false);
		$(".outer2").on("touchmove",a2,false);
		$(".outer2").on("touchend",a3,false);
		function a1(event){
			event.preventDefault();
			$(".rgb input").blur();
			sX=event.touches[0].pageX;
			sY=event.touches[0].pageY;
			(function(){
				var deviceWidth2 = document.documentElement.clientWidth;
				zz2 = deviceWidth2/640;
				s1Y=sY/zz2;
				s1X=sX/zz2;
			})();
			this.style.background="#008cFF";
			fdyd=$(this).css("-webkit-transform").match(reg);
			for(var d=0;d<fdyd.length;d++){
				fdyd[d]=Number(fdyd[d]);
			}
			fx=fdyd[4];
			fy=fdyd[5];
			leh=$(this).prev().width();
		}
		function a2(event){
			event.preventDefault();
			eX=event.touches[0].pageX;
			eY=event.touches[0].pageY;
			(function(){
				var deviceWidth2 = document.documentElement.clientWidth;
				zz2 = deviceWidth2/640;
				e1Y=eY/zz2;
				e1X=eX/zz2;
			})();
			if(event.touches.length==1){
				esfx=e1X-s1X+fx;
				if(esfx>0){
					esfx=0;
				}else if(esfx<-510){
					esfx=-510
				}
				$(this).css("-webkit-transform","matrix(1,0,0,1,"+esfx+",0)translateZ(0)");
				$(this).prev().css("width",leh+(esfx-fx)+"px");
				rr=Math.ceil(($(".outer1").eq(0).width()-20)/2);
				gg=Math.ceil(($(".outer1").eq(1).width()-20)/2);
				bb=Math.ceil(($(".outer1").eq(2).width()-20)/2);
				if(rr<0){
					rr=0;
				}else if(rr>255){
					rr=255;
				}
				if(gg<0){
					gg=0;
				}else if(gg>255){
					gg=255;
				}
				if(bb<0){
					bb=0;
				}else if(bb==254){
					bb=255;
				}else if(bb>255){
					bb=255;
				}
				light=Math.ceil(($(".outer1").eq(3).width()-20)/2);
				$("input").eq(0).val(rr);
				$("input").eq(1).val(gg);
				$("input").eq(2).val(bb);
				$("#colorcircle").css("background-color","rgb("+rr+","+gg+","+bb+")");
				if(rr<16){
					r1="0"+rr.toString(16);
				}else{
					r1=rr.toString(16);
				}
				if(gg<16){
					g1="0"+gg.toString(16);
				}else{
					g1=gg.toString(16);
				}
				if(bb<16){
					b1="0"+bb.toString(16);
				}else{
					b1=bb.toString(16);
				}
				s="#"+r1+g1+b1;
				$(".rgb1").val(s.toUpperCase());
			}
		}
		function a3(){
			
			document.getElementById("outer21").style.background="-webkit-linear-gradient(top,#f00 0%,#efedee 95%,#f3f3f3 100%)";
			document.getElementById("outer22").style.background="-webkit-linear-gradient(top,#0f0 0%,#efedee 95%,#f3f3f3 100%)";
			document.getElementById("outer23").style.background="-webkit-linear-gradient(top,#00f 0%,#efedee 95%,#f3f3f3 100%)";
			document.getElementById("outer31").style.background="-webkit-linear-gradient(top,#000 0%,#efedee 95%,#f3f3f3 100%)";
			sendmessage();
		}
		for(var i=0;i<$(".rgb input").length;i++){
			$(".rgb input").eq(i).keyup(function(){
				if($(this).val()>255){
					$(this).val(255);
				}else if($(this).val()<0){
					$(this).val(0);
				}
				$(".outer1").eq($(this).index()).css("width",($(this).val()*2+20)+"px");
				rr=Math.ceil(($(".outer1").eq(0).width()-20)/2);
				gg=Math.ceil(($(".outer1").eq(1).width()-20)/2);
				bb=Math.ceil(($(".outer1").eq(2).width()-20)/2);
				$(".outer2").eq($(this).index()).css("-webkit-transform","matrix(1,0,0,1,-"+(510-$(this).val()*2)+",0)translateZ(0)")
				$("#colorcircle").css("background-color","rgb("+rr+","+gg+","+bb+")");
				if(rr<16){
					r1="0"+rr.toString(16);
				}else{
					r1=rr.toString(16);
				}
				if(gg<16){
					g1="0"+gg.toString(16);
				}else{
					g1=gg.toString(16);
				}
				if(bb<16){
					b1="0"+bb.toString(16);
				}else{
					b1=bb.toString(16);
				}
				s="#"+r1+g1+b1;
				$(".rgb1").val(s.toUpperCase());
				sendmessage();
			});
			
		}
		$(".rgb input").blur(function(){
			if($(this).val()==""){
				$(this).val(0);
			}
		});
		var colorData=null;
		function draws(imgs) {
			var canvas = document.getElementById("color_container");
			var context = canvas.getContext("2d");
			context.shadowBlur = 20;
			context.shadowColor = "#000000";
			context.drawImage(imgs, 10, 10, 280,280);

			canvas = $("#color_container");
			canvas.on("touchstart",b1,false);
			canvas.on("touchmove",b2,false);
			canvas.on("touchend",b3,false);
			function b1(event){
				event.preventDefault();
				var eX = event.touches[0].pageX;
				var eY = event.touches[0].pageY; 
				var deviceWidth2 = document.documentElement.clientWidth;
				var deviceHeight2 = document.documentElement.clientHeight;
				var canvasX =eX/scale-150;
				var canvasY = eY/scale-50;
				colorData = document.getElementById("color_container").getPixelColor(canvasX, canvasY);
				console.log();
				if(colorData.r==0&&colorData.g==0&&colorData.b==0){
					return;
				}
				var color = colorData.rgba;
				$("#colorcircle").css("backgroundColor", color);
			}
			function b2(event){
				event.preventDefault();
				var eX = event.touches[0].pageX;
				var eY = event.touches[0].pageY;
				var deviceWidth2 = document.documentElement.clientWidth;
				var deviceHeight2 = document.documentElement.clientHeight;
				var canvasX =eX/scale-150;
				var canvasY = eY/scale-50;
				colorData = document.getElementById("color_container").getPixelColor(canvasX, canvasY);
				var colorhex="";
				if(colorData.r==255&&colorData.g==255&&colorData.b==255){
					$(".rgb input").eq(0).val(rr);
					$(".rgb input").eq(1).val(gg);
					$(".rgb input").eq(2).val(bb);
					$(".rgb1").val(colorhex.toUpperCase());
					changeTiao();
					return;
				}
				var color = colorData.rgba;
				colorhex=colorData.hex;
				rr=colorData.r;
				gg=colorData.g;
				bb=colorData.b;
				$("#colorcircle").css("backgroundColor", color);
			}
			function b3(){
				var color = colorData.rgba;
				if(colorData.r==255&&colorData.g==255&&colorData.b==255){
					return;
				}
				rr=colorData.r;
				gg=colorData.g;
				bb=colorData.b;
				$(".rgb input").eq(0).val(rr);
				$(".rgb input").eq(1).val(gg);
				$(".rgb input").eq(2).val(bb);
				$(".rgb1").val(colorData.hex.toUpperCase());
				changeTiao();
				
				$("#colorcircle").css("backgroundColor", color);
			} 
		}
		var imgs = new Image();
		imgs.src = "img/sehuan.png";
		imgs.onload=function(){
			draws(imgs);
		};
		
		function changeTiao(){
			$("#outer11").css("width",($("#rrr").val()*2+20)+"px");
			$("#outer21").css("-webkit-transform","matrix(1,0,0,1,-"+(510-$("#rrr").val()*2)+",0)translateZ(0)");
			$("#outer12").css("width",($("#ggg").val()*2+20)+"px");
			$("#outer22").css("-webkit-transform","matrix(1,0,0,1,-"+(510-$("#ggg").val()*2)+",0)translateZ(0)");
			$("#outer13").css("width",($("#bbb").val()*2+20)+"px");
			$("#outer23").css("-webkit-transform","matrix(1,0,0,1,-"+(510-$("#bbb").val()*2)+",0)translateZ(0)");
			sendmessage();
		}
		function hex2int(hex){
			return parseInt(hex,10);
		}
		function int2hex(intt){
			return parseInt(intt,16);
		}
		function sendmessage(){
			$.ajax(
					{
					 url:"./ColorServlet",
					 type:"post",
					 data:{
					     ip:ip,
					     r:rr,
					     g:gg,
					     b:bb,
					     light:light
					 },
					 success:function(){
					     
					 },
					 error:function(a,b){
					     alert("error");
					 }
					}
			);
		}
		sendmessage();
		//setInterval(sendmessage, 10000);
		
	</script>
	
</html>