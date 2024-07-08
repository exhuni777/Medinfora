<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/notice/notice.css" />
<link rel="stylesheet" type="text/css" href="<%= ctxPath %>/resources/css/notice/noticeMedia.css" />

<script type="text/javascript" src="<%= ctxPath %>/resources/js/notice/notice.js"></script>
<script type="text/javascript" src="<%= ctxPath %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
    var oEditors = [];
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: oEditors,
        elPlaceHolder: "CONTENT",
        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
        htParams: {
            bUseToolbar: true,
            bUseVerticalResizer: true,
            bUseModeChanger: true,
        },
        fCreator: "createSEditor2"
    });

    $("button#btnWrite").click(function(){
        oEditors.getById["CONTENT"].exec("UPDATE_CONTENTS_FIELD", []);

        const TITLE = $("input[name='TITLE']").val().trim();
        if (TITLE === "") {
            alert("글 제목을 입력하세요!!");
            $("input[name='TITLE']").focus();
            return;
        }

        let content_val = $("textarea[name='CONTENT']").val().trim();
        content_val = content_val.replace(/&nbsp;/gi, "");
        content_val = content_val.substring(content_val.indexOf("<p>") + 3);

        if (content_val === "" || content_val == null) {
            alert("글 내용을 입력하세요!!");
            return;
        }

        const frm = document.noticeWriteFrm;
        frm.method = "post";
        frm.action = "<%=ctxPath%>/notice/noticeWriteEnd.bibo";
        console.log("Form action:", frm.action);
        
        frm.submit();
    });
});
</script>

<div class="board_wrap">
    <div class="board_title11">
        <p class="nanum-eb size-b">글 등록하기</p>
    </div>
    <br>
    <div style="display: flex;">
    <div style="margin: auto; padding-left: 3%;">
      <form name="noticeWriteFrm" method="post" enctype="multipart/form-data" action="<%= ctxPath %>/notice/noticeWriteEnd.bibo">
            <table style="width: 1024px" class="table table-bordered">
                <tr>
                    <th style="width: 15%;">제목</th>
                    <td>
                        <input type="text" name="TITLE" size="103" maxlength="200" />
                    </td>
                </tr>
                <tr>
                    <th style="width: 15%;">내용</th>
                    <td>
                        <textarea style="width: 100%; height: 612px;" name="CONTENT" id="CONTENT"></textarea>
                    </td>
                </tr>
                <tr>
                    <th style="width: 15%;">파일첨부</th>
                    <td>

                        <input id="attach" type="file" name="attach" />
                    </td>
                </tr>
            </table>
            <div class="writebtn" style="margin: 20px;">
                   <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
                  <button type="button" class="btn btn-secondary btn-sm" onclick="window.location.href='<%= ctxPath%>/notice/noticeList.bibo'">취소</button></div>
            </div>
        </form>
    </div>
</div>


</div>
