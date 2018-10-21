$(function(){
	
	$("#regist_button").click(function(){
		//清空以前消息提示
		$("#warning_1").hide();
		$("#warning_2").hide();
		$("#warning_3").hide();
		$("#warning_4").hide();
		$("#warning_5").hide();
		
		//获取请求参数
		var name = $("#regist_username").val().trim();
		var password = $("#regist_password").val().trim();
		var nickname = $("#nickname").val().trim();
		var final_password = $("#final_password").val().trim();
		//非空,位数检查格式
		var ok = true;
		if(name==""){
			$("#warning_1 span").html("用户名不能为空");
		    $("#warning_1").show();
		    ok = false;
		}
		if(nickname==""){
			$("#warning_4 span").html("昵称不能为空");
			$("#warning_4").show();
			ok = false;
		}
		if(password==""){
			$("#warning_2 span").html("密码不能为空");
			$("#warning_2").show();
			ok = false;
		}else{//检测位数
			if(password.length<6){
				$("#warning_2 span").html("密码位数过短");
				$("#warning_2").show();
				ok = false;
			}
		}
		if(final_password==""){
			$("#warning_3 span").html("确认密码不能为空");
			$("#warning_3").show();
			ok = false;
		}else{
			if(final_password!=password){
				$("#warning_3 span").html("与密码不一致");
				$("#warning_3").show();
				ok = false;
			}
		}
		//发送ajax请求
		if(ok){
			$.ajax({
			  url:ctx+"/user/regist.do",
			  type:"post",
			  data:{"name":name,
			  	"password":password,
			  	"nickname":nickname},
			  dataType:"json",
			  success:function(result){
			     if(result.status==0){
			        alert(result.msg);//提示成功
			        $("#back").click();//切换到登录界面
			     }else if(result.status==1){//用户名已存在
			     	$("#warning_1 span").html(result.msg);
			     	$("#warning_1").show();//显示错误信息
			     }
			  },
			  error:function(){
			  	alert("系统异常,注册失败");
			  }
			});
		};
	});
});