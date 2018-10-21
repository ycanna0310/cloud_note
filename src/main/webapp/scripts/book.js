//根据用户ID加载笔记本列表
//function loaduserbooks(){
//	
//	$.ajax({
//		url:ctx+"/notebook/loadbooks.do",
//		type:"post",
//		dataType:"json",
//		success:function(result){
//			if(result.status==0){
//				//清空原有笔记本列表
//				$("#book_list").empty();
//				//解析笔记本信息,生成列表
//				var books = result.data;
//				for(var i=0;i<books.length;i++){
//					var bookId = books[i].cn_notebook_id;
//					var bookName = books[i].cn_notebook_name;
//					//拼一个列表元素li
//					var sli ='<li class="online">';
//						sli+='<a>';
//						sli+='  <i class="fa fa-book" title="online" rel="tooltip-bottom"></i>';
//						sli+=bookName;
//						sli+='</a>';
//						sli+='</li>';
//					//将sli字符串转成jQuery对象,然后使用data函数藏bookId值
//					var $li = $(sli);
//					$li.data("bookId",bookId);
//					//将$li元素添加到id=book_list的<ul>中
//					$("#book_list").append($li);
//				}
//			}
//		},
//		error:function(){
//			alert("加载笔记本失败");
//		}
//	});
//};

//根据笔记本ID加载笔记列表
function loadbooknotes(){
	//将当前笔记本li设置为选中
//	$("#pc_part_1").show();
//	$("#pc_part_2").show();
//	$("#pc_part_3").show();
//	$("#pc_part_4").hide();
//	$("#pc_part_5").hide();
//	$("#pc_part_6").hide();
//	$("#pc_part_7").hide();
//	$("#pc_part_8").hide();
//	$("#book_list li a").removeClass("checked");
//	$(this).find("a").addClass("checked");
//	//获取请求参数
//	var bookId = $(this).data("bookId");
//	//发送ajax请求
//	$.ajax({
//		url:ctx+"/notebook/loadnotes.do?bookId="+bookId,
//		type:"get",
//		dataType:"json",
//		success:function(result){
//			if(result.status==0){
//				//将原有笔记列表清除
//				$("#note_list").empty();
//				//根据笔记信息生成笔记列表
//				var notes = result.data;
//			}
//		},
//		error:function(){
//			alert("加载笔记本的笔记失败");
//		}
//	});
};

//弹出添加笔记本对话框
function showAddBookWindow(){
	//加载alert页面内容
	$("#can").load(ctx+"/alert/alert_notebook.html");
	//显示背景色
	$(".opacity_bg").show();
};
//关闭对话框
function closeWindow(){
	$("#can").empty();//清空对话框,隐藏效果
	$(".opacity_bg").hide();//隐藏背景色
};

//确认创建笔记本
function sureAddBook(){
	//获取请求参数
	var bookName = $("#input_notebook").val().trim();
	//TODO检测非空
	$.ajax({
		url:ctx+"/notebook/add.do", //http://localhost/CloudNote/notebook/add.do
		type:"post",
		data:{"userId":userId,"bookName":bookName},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				//关闭对话框
				closeWindow();
				//追加笔记本列表项(刷新)
				//loaduserbooks();
				//拼一个笔记本li
				var sli ='<li class="online">';
					sli+='<a>';
					sli+='  <i class="fa fa-book" title="online" rel="tooltip-bottom"></i>';
					sli+=bookName;
					sli+='</a>';
					sli+='</li>';
				//将bookId绑定
				var $li = $(sli);
				var bookId = result.data;//获取笔记本ID
				$li.data("bookId",bookId);
				//将笔记本li添加到列表中(在最前面插入)
				$("#book_list").prepend($li);
			}
		},
		error:function(){
			alert("创建笔记本失败");
		}
	});
};

//弹出修改笔记本名对话框
function showRenameBookWindow(){
	//获取当前双击的笔记本名称
	var bookName = $(this).text().trim();
	//显示对话框内容
	$("#can").load(ctx+"/alert/alert_rename.html",function(){
		//当html载入can之后执行
		$("#input_notebook_rename").val(bookName);
	});
	$(".opacity_bg").show();//显示灰色背景
};

//确认修改笔记本名
function sureRenameBook(){
	//获取笔记本名
	var bookName = 
	  $("#input_notebook_rename").val().trim();
	//获取笔记本ID
	var $li = $("#book_list li a.checked").parent();
	var bookId = $li.data("bookId");
	//TODO 检测笔记本名格式
	//发送ajax请求
	$.ajax({
		url:ctx+"/notebook/rename.do",
		type:"post",
		data:{"bookId":bookId,"bookName":bookName},
		dataType:"json",
		success:function(result){
			if(result.status==0){
				//关闭对话框
				closeWindow();
				//修改li的笔记本名
				var sli='<a class="checked">';
					sli+='  <i class="fa fa-book" title="online" rel="tooltip-bottom"></i>';
					sli+=bookName;
					sli+='</a>';
				$li.html(sli);//替换原有li的内容
			}
		},
		error:function(){
			alert("更新笔记本名失败");
		}
	});
};


