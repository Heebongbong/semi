/**
 * 
 */

	function site_board_getList(d) {
		let page = $('#page_li_now_site').text();
		if(d!=null){
			page=parseInt(page)+parseInt(d);
		}else{
			page = 1;
		}
		console.log('1');
		$.ajax({
			type: "post",
			url: "board_Site_Get_List.do",
			data:{page: page},
			datatype: "xml",
			success: function(data){
				let table = "";
				
				if($(data).find("board").text()==""){
					table = "<tr><td colspan='4'><h3>등록된 게시물이 없습니다.</h3></td></tr>";
					$('#board_list tr:gt(0)').remove();
					$('#board_list tr:eq(0)').after(table);
				}else{
					$(data).find("board").each(function() {
						table += "<tr>";
						table += "<td>";
						table += $(this).find("board_no").text();
						table += "</td>";
						table += "<td><a href='"+p_path+"/board_Get_Content.do?board_no="+$(this).find("board_no").text()+"'>";
						table += "비밀 글입니다.";
						table += "</a></td>";
						table += "<td>";
						table += $(this).find("board_writer").text();
						table += "</td>";
						if($(this).find("board_update").text()=='null'){
							table += "<td>";
							table += $(this).find("board_date").text();
							table += "</td>";
						}else{
							table += "<td>";
							table += $(this).find("board_update").text();
							table += "</td>";
						}
						table += "</tr>";
					});
					if($('#board_list tr th:eq(2)').text()=='Hotel.'){
						$('#board_list tr th:eq(2)').remove();
					}
					$('#board_list tr:gt(0)').remove();
					$('#board_list tr:eq(0)').after(table);
					
					if($(data).find("page").text()!=''){
						page = $(data).find("page").text();
					}
					
					$('#board_navi_hotel').css('display', 'none');
					$('#board_navi_site').css('display', 'flex');
					
					
					$('#page_li_now_site').text(page);
					$('#page_li_lastPage').val($(data).find("allPage").text());
				}
			},
			error: function(){
				alert('게시물 불러오기 실패....');
			}
		});
		
	}
	function hotel_board_getList(d) {
		if(user_no == ''){
			alert('로그인이 필요합니다.');
		}else{
			let page = $('#page_li_now_hotel').text();
			if(d!=null){
				page=parseInt(page)+parseInt(d);
			}else{
				page = 1;
			}
			$.ajax({
				type: "post",
				url: "board_Hotel_Get_List.do",
				data: {
					userNo : user_no
				},
				datatype: "xml",
				success: function(data){
					let table = "";
					
					if($(data).find("board").text()==""){
						table = "<tr><td colspan='4'><h3>등록된 게시물이 없습니다.</h3></td></tr>";
						$('#board_list tr:gt(0)').remove();
						$('#board_list tr:eq(0)').after(table);
					}else{
						$(data).find("board").each(function() {
							table += "<tr>";
							table += "<td>";
							table += $(this).find("board_no").text();
							table += "</td>";
							table += "<td><a href='"+p_path+"/board_Get_Content.do?board_no="+$(this).find("board_no").text()+"'>";
							table += $(this).find("board_title").text();
							table += "</a></td>";
							table += "<td>";
							table += $(this).find("board_hotelname").text();
							table += "</td>";
							table += "<td>";
							table += $(this).find("board_writer").text();
							table += "</td>";
							if($(this).find("board_update").text()=='null'){
								table += "<td>";
								table += $(this).find("board_date").text();
								table += "</td>";
							}else{
								table += "<td>";
								table += $(this).find("board_update").text();
								table += "</td>";
							}
							table += "</tr>";
						});
						if($('#board_list tr th:eq(2)').text()!='Hotel.'){
							$('#board_list tr th:eq(1)').after("<th style='width: 100px;'>Hotel.</th>");
						}
						
						$('#board_navi_site').css('display', 'none');
						$('#board_navi_hotel').css('display', 'flex');
						
						$('#board_list tr:gt(0)').remove();
						$('#board_list tr:eq(0)').after(table);
						
						if($(data).find("page").text()!=''){
							page = $(data).find("page").text();
						}
						$('#page_li_now_hotel').text(page);
						$('#page_li_lastPage').val($(data).find("allPage").text());
					}
				},
				error: function(){
					alert('게시물 불러오기 실패....');
				}
			});
		}
	}