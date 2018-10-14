function send(){
$.ajax({
			  url:"http://localhost/CloudNote/user/captcha.do",
			  type:"get",
			  dataType:"json",
			  success:function(){
			     
			  },
			  error:function(){
			  	alert("ÏµÍ³Òì³£,×¢²áÊ§°Ü");
			  }
			});
}