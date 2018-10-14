$(function(){//页面载入后执行,body内容载入
	window.onload = function () {
		//alert("1");
		//alert(navigator.userAgent.indexOf());
		var u = navigator.userAgent;
		if (u.indexOf('Android') > -1 || u.indexOf('Linux') > -1) {//安卓手机
			 window.location.href="loginbeifen.html";
		// window.location.href = "mobile/index.html";
		} else if (u.indexOf('iPhone') > -1) {//苹果手机
		// window.location.href = "mobile/index.html";
			window.location.href="loginbeifen.html";
		} else if (u.indexOf('Windows Phone') > -1) {//winphone手机
			window.location.href="loginbeifen.html";
		// window.location.href = "mobile/index.html";
		}
	}
	
	
	$("#login").click(function(){
		//清空消息
		$("#count_msg").html("");
		$("#password_msg").html("");
		//获取请求参数
		var name = $("#count").val().trim();
		var password = $("#password").val().trim();
		var captcha=$("#captcher").val().trim();
		//检查参数格式
		var ok = true;//表示表单是否通过检测
		if(name==""){
		  $("#count_msg").html("用户名不能为空");
		  ok = false;
		}
		if(password==""){
		  $("#password_msg").html("密码不能为空");
		  ok = false;
		}
		if(captcha==""){
			  $("#captcha_msg").html("验证码不能为空");
			  ok = false;
			}
		if(ok){
		$.ajax({
			  url:"/cloudnote/user/checkCaptch.do",
			  async: false,
			  type:"post",
			  data:{"captcha":captcha},
			  dataType:"json",
			  success:function(result){
			  	//result是服务器返回的json结果
			  	if(result.status==0){//成功
			  		$.ajax({
			  			url:"/cloudnote/user/login.do",
			  			type:"post",
			  			data:{"name":name,"password":password},
			  			dataType:"json",
			  			success:function(result){
						  	//result是服务器返回的json结果
						  	if(result.status==0){//成功
						  	   //获取返回的userID，放入cookie
						  	   var userId = result.data.cn_user_id;
						  	   addCookie("userId",userId,2);
						  	   //跳转到edit.html
						  	   window.location.href="edit.html";
						  	}else if(result.status==1){//用户名错
						  	   $("#count_msg").html(result.msg);
						  	}else if(result.status==2){
						  	   $("#password_msg").html(result.msg);
						  	}
						  },
						  error:function(){
						  	alert("系统错误");
						  }
			  		});
			  	}else if(result.status==1){//用户名错
			  	   $("#captcha_msg").html(result.msg);
			  	   ok=false;
			  	}
			  },
			  error:function(){
			  	alert("验证出错");
			  	ok=false;
			  }
			});
		}
		
		//发送ajax请求
		
			
		
	});
	$("#pp").click(function(){
		var time=new Date().getTime();
		  document.getElementById("yanzhengma").src="/cloudnote/user/captcha.do?d="+time;
	});
	
});
