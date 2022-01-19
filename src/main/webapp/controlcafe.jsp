<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="cafecss.css">
    <title>카페관리</title>
</head>
<body>
<h1 align=center>sky Cafe</h1>
    <table align=center>
        <tr>
            <td valign=top>
                <table class='bound'>
                    <caption>메뉴목록</caption>
                    <tr>
                        <td colspan=2 align=right>
                            <button id=btnMenu>메뉴관리</button>
                        </td>
                    </tr>
                <tr>
                    <td colspan=2>
                        <select id=selMenu size=13></select>
                    </td>
                </tr>
                <tr>
                    <td>메뉴명</td>
                    <td><input type=text id=menuname readonly></td>
                </tr>
                <tr>
                    <td>수량</td>
                    <td><input type=number id=count min=1 style='width:50px'>잔</td>
                </tr>
                <tr>
                    <td>금액</td>
                    <td><input type=number id=_price readonly>원</td>
                </tr>
                <tr>
                    <td><button id=btnReset style='width: 70px'>비우기</button></td>
                    <td align=right><button id=btnAdd>메뉴추가</button></td>
                </tr>
                </table>
            </td>
            <td valign=top>
                <table class='bound'>
                    <caption>주문목록</caption>
                    <tr>
                        <td colspan=2>
                            <select id=selOrder size=13></select>
                        </td>
                    </tr>
                    <tr>
                        <td>총액</td>
                        <td><input type=number id=total style='width:100px'>원</td>
                    </tr>
                    <tr>
                        <td>모바일</td>
                        <td><input type=phone id=mobile size=13></td>
                    </tr>
                    <tr>
                        <td colspan=2>&nbsp;</td>
                    </tr>
                    <tr>
                        <td><button id=btnCancel>주문취소</button></td>
                        <td align=right><button id=btnDone>주문완료</button></td>
                    </tr>
                </table>
            </td>
            <td valign=top>
                <table class='bound'>
                    <caption>판매내역</caption>
                     <tr>
                        <td colspan=2 align=right>
                            <button id=btnsale>summary</button>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <select id=selSales size=20 style="width:500px"></select>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id=dlgMenu style='display:none;' title="메뉴관리">
        <table>
            <tr>
                <td>
                    <select id=selMenu1 size=10></select>
                </td>
                <td>
                    <table>
                     <tr>
                        <td>코드</td><td><input type=number id=code style='width:120px'></td>
                    </tr>
                    <tr>
                        <td>메뉴명</td><td><input type=text id=name style='width:120px'></td>
                    </tr>
                    <tr>
                        <td>단가(가격)</td><td><input type=number id=price min=500 step=500 style='width:70px'>원</td>
                    </tr>
                    <tr>
                        <td colspan=2 align=center><button id=btnPlus>확인</button>&nbsp;
                        </td>
                    </tr>
                    </table>
                </td>
            </tr>    
            </table>
    </div>
     <div id=dlgsale style='display:none;' title="summary">
            <table align=center>
            <tr>
                <td>
                    <table>
                    <tr>
                        <td>메뉴명 매출금액</td>
                        <td>고객별 매출금액</td>
                    </tr>
                    <tr>
                       <td colspan=2>
                       <select id=salesMenu size=13></select>
                       <select id=salesMenu1 size=13></select>
                      </td>
                   </tr>
                    </table>
                </td>
            </tr>    
            </table>
    </div>
</body>
<script src=https://code.jquery.com/jquery-3.5.0.js></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
var dt = new Date();
dt.toLocaleDateString();
nTotal=0;
function loadRoom(){
   $.get('select',{},function(txt){
      if (txt == "")
         return false;
      let rec = txt.split(';');
      for (i = 0; i < rec.length; i++) {
         let fld = rec[i].split(',');
         html = '<option>'+fld[0]+' '+fld[1]+' '+fld[2]+'</option>';
         $('#selMenu').append(html);
      }
   })
}
function loadpan(){
    $.get('panme',{},function(txt){
       if (txt == "") return false;
       let rec = txt.split(';');
       for (i = 0; i < rec.length; i++) {
           let fld = rec[i].split(',');
           html = '<option>'+fld[0]+' '+fld[1]+' '+fld[2]+' '+fld[3]+' '+fld[4]+'</option>';
           $('#selSales').append(html);
       }
    })
 }
$(document)
.ready(function(){
   loadpan();
   loadRoom();
   $('#total').val()
})
.on('click','#btnMenu',function(){ 
        $('#dlgMenu').dialog({
        width:560,
        open:function(){ 
           $.get('select',{},function(txt){
              if (txt == "")
                 return false;
              let rec = txt.split(';');
              for (i = 0; i < rec.length; i++) {
                 let fld = rec[i].split(',');
                 html = '<option>'+fld[0]+' '+fld[1]+' '+fld[2]+'</option>';
                 $('#selMenu1').append(html);
              }
           })
        },
        close:function(){
           $('#selMenu').empty();
           $('#selMenu1').empty();
           loadRoom();
        }
        });
    })
   .on('click','#btnPlus',function() {
      $('#selMenu1').empty();
            let operation = '';
            if ($('#code').val() == '') {
               if ($('#name').val() != '' && $('#price').val() != '') {
                  operation = "insert";
               } else {
                  alert('입력값이 모두 채워지지 않았습니다.');
                  return false;
               }
            } else {
               if ($('#name').val() != '' && $('#price').val() != '') {
                  operation = "update";
               } else {
                  operation = "delete";
               }
            }
            $.get(operation, {
               code : $('#code').val(),
               name : $('#name').val(),
               price : $('#price').val(),
            }, function(txt) {
               $('#code,#name,price').val("");
               $.get('select',{},function(txt){
                  if (txt == "")
                     return false;
                  let rec = txt.split(';');
                  for (i = 0; i < rec.length; i++) {
                     let fld = rec[i].split(',');
                     html = '<option>'+fld[0]+' '+fld[1]+' '+fld[2]+'</option>';
                     $('#selMenu1').append(html);
                  }
               })
            }, 'text');
               $('#code').val('');
               $('#name').val('');
               $('#price').val('');
            return false;
         })
.on('click','#selMenu',function(){
        str=$('#selMenu option:selected').text();
        let ar=str.split(' ');
        $('#menuname').val(ar[1]);
        $('#count').val(1);
        $('#_price').val(ar[2]);
})
.on('change','#count',function(){
        str=$('#selMenu option:selected').text();
        let ar=str.split(' ');
        bb=$('#count').val();
        $('#_price').val(ar[2]*bb);
})
.on('click','#btnReset',function(){
        $('#menuname').val(null)
        $('#_price').val(null)
        $('#count').val(null)
})
.on('click','#btnAdd',function(){
	    pr=$('#_price').val();
	    str=$('#selMenu option:selected').text();
	    let ar=str.split(' ');
	    asd='<option>'+ar[0]+' '+ar[1]+' '+$('#count').val()+' '+pr+'</option>';
        $('#selOrder').append(asd);
        pr=parseInt(pr);
        nTotal+=pr
        $("#total").val(nTotal)  
        $('#btnReset').trigger('click');
})
.on('click','#btnCancel',function(){
        $('#selOrder').empty()
        nTotal=null
        $("#total").val(nTotal)
        $("#mobile").val(null)
})
.on('click','#btnDone',function(){
$('#selOrder option').each(function(){
   str='<option>'+$('#mobile').val()+' '+$(this).text()+' '+dt.toLocaleDateString()+'</option>'
   $('#selSales').append(str);
   let a=$(this).text();
   let rec=a.split(' ');
   console.log(rec);
$.get('saleinsert',{
   code:rec[0],
   mobile : $('#mobile').val(),
   qty : rec[2],
   total : rec[3]
},function(txt){},'text');
})
$('#mobile').val(null);
nTotal=null;
$("#total").val(nTotal)
$('#selOrder').empty();
})
.on('click','#btnsale',function(){
    $('#dlgsale').dialog({
        width:560,
        open:function() {
            $.get('saleselect', {}, function(txt) {
               if (txt == "") return false;
                      let rec = txt.split(';');
                      for (i = 0; i < rec.length; i++) { 
                         let field = rec[i].split(',');
                         let html ='<option>'+field[0]+' '+field[1]+' '+field[2]+'</option>';
                         $('#salesMenu').append(html);
                   }
                }, 'text')
            $.get('goselect', {}, function(txt) {
                   if (txt == "") return false;
                   let rec = txt.split(';');
                   for (i = 0; i < rec.length; i++) {  
                      let field = rec[i].split(',');
                      let html ='<option>'+field[0]+' '+field[1]+'</option>';
                      $('#salesMenu1').append(html);
                   }
             }, 'text')
         },
         close:function() {
            $('#salesMenu').empty();
            $('#salesMenu1').empty();
         }
      });
   })
</script>
</html>