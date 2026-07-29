


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head><title>
	景德镇昌河中学 
</title><meta content="Microsoft FrontPage 5.0" name="GENERATOR"><meta content="Visual Basic 7.0" name="CODE_LANGUAGE"><meta content="JavaScript" name="vs_defaultClientScript"><meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"><link href="css/jdzcss.css" rel="stylesheet" /><script language="javascript">
//----------------------------------------------------------------------------
//  这是梅花雨做的一个日历 Javascript 页面脚本控件，适用于微软的 IE （5.0以上）浏览器
//  主调用函数是 setday(this,[object])和setday(this)，[object]是控件输出的控件名，举两个例子：
//  一、<input name=txt><input type=button value=setday onclick="setday(this,document.all.txt)">
//  二、<input onfocus="setday(this)">
//  若有什么不足的地方，或者您有更好的建议，请与我联系：mail: meizz@hzcnc.com
//  本日历的年份限制是（1000 - 9999）
//  按ESC键关闭该控件
//  在年和月的显示地方点击时会分别出年与月的下拉框
//  控件外任意点击一点即可关闭该控件
/* 以下为walkingpoison的修改说明
walkingpoison联系方式：wayx@kali.com.cn

Ver	2.0
修改日期：2002-12-13
修改内容：
1.*全新修改使用iframe作为日历的载体，不再被select和flash等控件挡住。
2.修正了移植到iframe后移动日历控件的问题。onfocus="setday(this)"

Ver	1.5
修改日期：2002-12-4
修改内容：
1.选中的日期显示为凹下去的样式
2.修改了关闭层的方法，使得失去焦点的时候能够关闭日历。
3.修改按键处理，使得Tab切换焦点的时候可以关闭控件
4.*可以自定义日历是否可以拖动

Ver 1.4
修改日期：2002-12-3
修改内容：
1.修正选中年/月份下拉框后按Esc键导致年/月份不显示的问题
2.修正使用下拉框选择月份造成的日期错误（字符串转化为数字的问题）
3.*外观样式的改进，使得控件从丑小鸭变成了美丽的天鹅，从灰姑娘变成了高贵的公主，从……（读者可以自己进行恰当的比喻）
4.再次增大年/月份的点击空间，并对下拉框的位置稍作调整

注：*号表示比较关键的改动

说明：
1.受到iframe的限制，如果拖动出日历窗口，则日历会停止移动。
*/

//==================================================== 参数设定部分 =======================================================
var bMoveable=true;		//设置日历是否可以拖动
var _VersionInfo="Version:2005 作者:iOffice.net"	//版本信息

//==================================================== WEB 页面显示部分 =====================================================
var strFrame;		//存放日历层的HTML代码
document.writeln('<iframe id=meizzDateLayer Author=wayx frameborder=0 style="position: absolute; width: 150; height: 220; z-index: 9998; display: none"></iframe>');
strFrame='<style>';
strFrame+='INPUT.button{BORDER-RIGHT: #ff9900 1px solid;BORDER-TOP: #ff9900 1px solid;BORDER-LEFT: #ff9900 1px solid;';
strFrame+='BORDER-BOTTOM: #ff9900 1px solid;BACKGROUND-COLOR: #fff8ec;font-family:宋体;}';
strFrame+='TD{FONT-SIZE: 9pt;font-family:宋体;}';
strFrame+='</style>';
strFrame+='<scr' + 'ipt>';
strFrame+='var datelayerx,datelayery;	/*存放日历控件的鼠标位置*/';
strFrame+='var bDrag;	/*标记是否开始拖动*/';
strFrame+='function document.onmousemove()	/*在鼠标移动事件中，如果开始拖动日历，则移动日历*/';
strFrame+='{if(bDrag && window.event.button==1)';
strFrame+='	{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='		DateLayer.posLeft += window.event.clientX-datelayerx;/*由于每次移动以后鼠标位置都恢复为初始的位置，因此写法与div中不同*/';
strFrame+='		DateLayer.posTop += window.event.clientY-datelayery;}}';
strFrame+='function DragStart()		/*开始日历拖动*/';
strFrame+='{var DateLayer=parent.document.all.meizzDateLayer.style;';
strFrame+='	datelayerx=window.event.clientX;';
strFrame+='	datelayery=window.event.clientY;';
strFrame+='	bDrag=true;}';
strFrame+='function DragEnd(){		/*结束日历拖动*/';
strFrame+='	bDrag=false;}';
strFrame+='</scr' + 'ipt>';
strFrame+='<div style="z-index:9999;position: absolute; left:0; top:0;" onselectstart="return false"><span id=tmpSelectYearLayer Author=wayx style="z-index: 9999;position: absolute;top: 3; left: 19;display: none"></span>';
strFrame+='<span id=tmpSelectMonthLayer Author=wayx style="z-index: 9999;position: absolute;top: 3; left: 78;display: none"></span>';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 width=142 height=160 bordercolor=#ff9900 bgcolor=#ff9900 Author="wayx">';
strFrame+='  <tr Author="wayx"><td width=142 height=23 Author="wayx" bgcolor=#FFFFFF><table border=0 cellspacing=1 cellpadding=0 width=140 Author="wayx" height=23>';
strFrame+='      <tr align=center Author="wayx"><td width=16 align=center bgcolor=#ff9900 style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='        onclick="parent.meizzPrevM()" title="向前翻 1 月" Author=meizz><b Author=meizz>&lt;</b>';
strFrame+='        </td><td width=60 align=center style="font-size:12px;cursor:default" Author=meizz ';
strFrame+='onmouseover="style.backgroundColor=\'#FFD700\'" onmouseout="style.backgroundColor=\'white\'" ';
strFrame+='onclick="parent.tmpSelectYearInnerHTML(this.innerText.substring(0,4))" title="点击这里选择年份"><span Author=meizz id=meizzYearHead></span></td>';
strFrame+='<td width=48 align=center style="font-size:12px;cursor:default" Author=meizz onmouseover="style.backgroundColor=\'#FFD700\'" ';
strFrame+=' onmouseout="style.backgroundColor=\'white\'" onclick="parent.tmpSelectMonthInnerHTML(this.innerText.length==3?this.innerText.substring(0,1):this.innerText.substring(0,2))"';
strFrame+='        title="点击这里选择月份"><span id=meizzMonthHead Author=meizz></span></td>';
strFrame+='        <td width=16 bgcolor=#ff9900 align=center style="font-size:12px;cursor: hand;color: #ffffff" ';
strFrame+='         onclick="parent.meizzNextM()" title="向后翻 1 月" Author=meizz><b Author=meizz>&gt;</b></td></tr>';
strFrame+='    </table></td></tr>';
strFrame+='  <tr Author="wayx"><td width=142 height=18 Author="wayx">';
strFrame+='<table border=1 cellspacing=0 cellpadding=0 bgcolor=#ff9900 ' + (bMoveable? 'onmousedown="DragStart()" onmouseup="DragEnd()"':'');
strFrame+=' BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF width=140 height=20 Author="wayx" style="cursor:' + (bMoveable ? 'move':'default') + '">';
strFrame+='<tr Author="wayx" align=center valign=bottom><td style="font-size:12px;color:#FFFFFF" Author=meizz>日</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>一</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>二</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>三</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>四</td>';
strFrame+='<td style="font-size:12px;color:#FFFFFF" Author=meizz>五</td><td style="font-size:12px;color:#FFFFFF" Author=meizz>六</td></tr>';
strFrame+='</table></td></tr><!-- Author:F.R.Huang(meizz) http://www.meizz.com/ mail: meizz@hzcnc.com 2002-10-8 -->';
strFrame+='  <tr Author="wayx"><td width=142 height=120 Author="wayx">';
strFrame+='    <table border=1 cellspacing=2 cellpadding=0 BORDERCOLORLIGHT=#FF9900 BORDERCOLORDARK=#FFFFFF bgcolor=#fff8ec width=140 height=120 Author="wayx">';
var n=0; for (j=0;j<5;j++){ strFrame+= ' <tr align=center Author="wayx">'; for (i=0;i<7;i++){
strFrame+='<td width=20 height=20 id=meizzDay'+n+' style="font-size:12px" Author=meizz onclick=parent.meizzDayClick(this.innerText,0)></td>';n++;}
strFrame+='</tr>';}
strFrame+='      <tr align=center Author="wayx">';
for (i=35;i<39;i++)strFrame+='<td width=20 height=20 id=meizzDay'+i+' style="font-size:12px" Author=wayx onclick="parent.meizzDayClick(this.innerText,0)"></td>';
strFrame+='        <td colspan=3 align=right Author=meizz><span onclick=parent.closeLayer() style="font-size:12px;cursor: hand"';
strFrame+='         Author=meizz title="' + _VersionInfo + '"><u>关闭</u></span>&nbsp;</td></tr>';
strFrame+='    </table></td></tr><tr Author="wayx"><td Author="wayx">';
strFrame+='        <table border=0 cellspacing=1 cellpadding=0 width=100% Author="wayx" bgcolor=#FFFFFF>';
strFrame+='          <tr Author="wayx"><td Author=meizz align=left><input Author=meizz type=button class=button value="<<" title="向前翻 1 年" onclick="parent.meizzPrevY()" ';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"><input Author=meizz class=button title="向前翻 1 月" type=button ';
strFrame+='             value="< " onclick="parent.meizzPrevM()" onfocus="this.blur()" style="font-size: 12px; height: 20px"></td><td ';
strFrame+='             Author=meizz align=center><input Author=meizz type=button class=button value=今天 onclick="parent.meizzToday()" ';
strFrame+='             onfocus="this.blur()" title="当前日期" style="font-size: 12px; height: 20px; cursor:hand"></td><td ';
strFrame+='             Author=meizz align=right><input Author=meizz type=button class=button value=" >" onclick="parent.meizzNextM()" ';
strFrame+='             onfocus="this.blur()" title="向后翻 1 月" class=button style="font-size: 12px; height: 20px"><input ';
strFrame+='             Author=meizz type=button class=button value=">>" title="向后翻 1 年" onclick="parent.meizzNextY()"';
strFrame+='             onfocus="this.blur()" style="font-size: 12px; height: 20px"></td>';
strFrame+='</tr></table></td></tr></table></div>';

window.frames.meizzDateLayer.document.writeln(strFrame);
window.frames.meizzDateLayer.document.close();		//解决ie进度条不结束的问题

//==================================================== WEB 页面显示部分 ======================================================
var outObject;
var outButton;		//点击的按钮
var outDate="";		//存放对象的日期
var odatelayer=window.frames.meizzDateLayer.document.all;		//存放日历对象
function setday(tt,obj) //主调函数
{
	if (arguments.length >  2){alert("对不起！传入本控件的参数太多！");return;}
	if (arguments.length == 0){alert("对不起！您没有传回本控件任何参数！");return;}
	var dads  = document.all.meizzDateLayer.style;
	var th = tt;
	var ttop  = tt.offsetTop;     //TT控件的定位点高
	var thei  = tt.clientHeight;  //TT控件本身的高
	var tleft = tt.offsetLeft;    //TT控件的定位点宽
	var ttyp  = tt.type;          //TT控件的类型
	while (tt = tt.offsetParent){ttop+=tt.offsetTop; tleft+=tt.offsetLeft;}
	dads.top  = (ttyp=="image")? ttop+thei : ttop+thei+6;
	dads.left = tleft;
	outObject = (arguments.length == 1) ? th : obj;
	outButton = (arguments.length == 1) ? null : th;	//设定外部点击的按钮
	//根据当前输入框的日期显示日历的年月
	var reg = /^(\d+)-(\d{1,2})-(\d{1,2})$/; 
	var r = outObject.value.match(reg); 
	if(r!=null){
		r[2]=r[2]-1; 
		var d= new Date(r[1], r[2],r[3]); 
		if(d.getFullYear()==r[1] && d.getMonth()==r[2] && d.getDate()==r[3]){
			outDate=d;		//保存外部传入的日期
		}
		else outDate="";
			meizzSetDay(r[1],r[2]+1);
	}
	else{
		outDate="";
		meizzSetDay(new Date().getFullYear(), new Date().getMonth() + 1);
	}
	dads.display = '';

	event.returnValue=false;
}

var MonHead = new Array(12);    		   //定义阳历中每个月的最大天数
    MonHead[0] = 31; MonHead[1] = 28; MonHead[2] = 31; MonHead[3] = 30; MonHead[4]  = 31; MonHead[5]  = 30;
    MonHead[6] = 31; MonHead[7] = 31; MonHead[8] = 30; MonHead[9] = 31; MonHead[10] = 30; MonHead[11] = 31;

var meizzTheYear=new Date().getFullYear(); //定义年的变量的初始值
var meizzTheMonth=new Date().getMonth()+1; //定义月的变量的初始值
var meizzWDay=new Array(39);               //定义写日期的数组

function document.onclick() //任意点击时关闭该控件	//ie6的情况可以由下面的切换焦点处理代替
{ 
  with(window.event)
  { if (srcElement.getAttribute("Author")==null && srcElement != outObject && srcElement != outButton)
    closeLayer();
  }
}

function document.onkeyup()		//按Esc键关闭，切换焦点关闭
  {
    if (window.event.keyCode==27){
		if(outObject)outObject.blur();
		closeLayer();
	}
	else if(document.activeElement)
		if(document.activeElement.getAttribute("Author")==null && document.activeElement != outObject && document.activeElement != outButton)
		{
			closeLayer();
		}
  }

function meizzWriteHead(yy,mm)  //往 head 中写入当前的年与月
  {
	odatelayer.meizzYearHead.innerText  = yy + " 年";
    odatelayer.meizzMonthHead.innerText = mm + " 月";
  }

function tmpSelectYearInnerHTML(strYear) //年份的下拉框
{
  if (strYear.match(/\D/)!=null){alert("年份输入参数不是数字！");return;}
  var m = (strYear) ? strYear : new Date().getFullYear();
  if (m < 1000 || m > 9999) {alert("年份值不在 1000 到 9999 之间！");return;}
  var n = m - 80;
  if (n < 1000) n = 1000;
  if (n + 86 > 9999) n = 9914;
  var s = "<select Author=meizz name=tmpSelectYear style='font-size: 12px' "
     s += "onblur='document.all.tmpSelectYearLayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpSelectYearLayer.style.display=\"none\";"
     s += "parent.meizzTheYear = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
  var selectInnerHTML = s;
  for (var i = n; i < n + 86; i++)
  {
    if (i == m)
       {selectInnerHTML += "<option Author=wayx value='" + i + "' selected>" + i + "年" + "</option>\r\n";}
    else {selectInnerHTML += "<option Author=wayx value='" + i + "'>" + i + "年" + "</option>\r\n";}
  }
  selectInnerHTML += "</select>";
  odatelayer.tmpSelectYearLayer.style.display="";
  odatelayer.tmpSelectYearLayer.innerHTML = selectInnerHTML;
  odatelayer.tmpSelectYear.focus();
}

function tmpSelectMonthInnerHTML(strMonth) //月份的下拉框
{
  if (strMonth.match(/\D/)!=null){alert("月份输入参数不是数字！");return;}
  var m = (strMonth) ? strMonth : new Date().getMonth() + 1;
  var s = "<select Author=meizz name=tmpSelectMonth style='font-size: 12px' "
     s += "onblur='document.all.tmpSelectMonthLayer.style.display=\"none\"' "
     s += "onchange='document.all.tmpSelectMonthLayer.style.display=\"none\";"
     s += "parent.meizzTheMonth = this.value; parent.meizzSetDay(parent.meizzTheYear,parent.meizzTheMonth)'>\r\n";
  var selectInnerHTML = s;
  for (var i = 1; i < 13; i++)
  {
    if (i == m)
       {selectInnerHTML += "<option Author=wayx value='"+i+"' selected>"+i+"月"+"</option>\r\n";}
    else {selectInnerHTML += "<option Author=wayx value='"+i+"'>"+i+"月"+"</option>\r\n";}
  }
  selectInnerHTML += "</select>";
  odatelayer.tmpSelectMonthLayer.style.display="";
  odatelayer.tmpSelectMonthLayer.innerHTML = selectInnerHTML;
  odatelayer.tmpSelectMonth.focus();
}

function closeLayer()               //这个层的关闭
  {
    document.all.meizzDateLayer.style.display="none";
  }

function IsPinYear(year)            //判断是否闰平年
  {
    if (0==year%4&&((year%100!=0)||(year%400==0))) return true;else return false;
  }

function GetMonthCount(year,month)  //闰年二月为29天
  {
    var c=MonHead[month-1];if((month==2)&&IsPinYear(year)) c++;return c;
  }
function GetDOW(day,month,year)     //求某天的星期几
  {
    var dt=new Date(year,month-1,day).getDay()/7; return dt;
  }

function meizzPrevY()  //往前翻 Year
  {
    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear--;}
    else{alert("年份超出范围（1000-9999）！");}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzNextY()  //往后翻 Year
  {
    if(meizzTheYear > 999 && meizzTheYear <10000){meizzTheYear++;}
    else{alert("年份超出范围（1000-9999）！");}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzToday()  //Today Button
  {
	var today;
    meizzTheYear = new Date().getFullYear();
    meizzTheMonth = new Date().getMonth()+1;
    today=new Date().getDate();
    //meizzSetDay(meizzTheYear,meizzTheMonth);
    if(outObject){
		outObject.value=meizzTheYear + "-" + meizzTheMonth + "-" + today;
    }
    closeLayer();
  }
function meizzPrevM()  //往前翻月份
  {
    if(meizzTheMonth>1){meizzTheMonth--}else{meizzTheYear--;meizzTheMonth=12;}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }
function meizzNextM()  //往后翻月份
  {
    if(meizzTheMonth==12){meizzTheYear++;meizzTheMonth=1}else{meizzTheMonth++}
    meizzSetDay(meizzTheYear,meizzTheMonth);
  }

function meizzSetDay(yy,mm)   //主要的写程序**********
{
  meizzWriteHead(yy,mm);
  //设置当前年月的公共变量为传入值
  meizzTheYear=yy;
  meizzTheMonth=mm;
  
  for (var i = 0; i < 39; i++){meizzWDay[i]=""};  //将显示框的内容全部清空
  var day1 = 1,day2=1,firstday = new Date(yy,mm-1,1).getDay();  //某月第一天的星期几
  for (i=0;i<firstday;i++)meizzWDay[i]=GetMonthCount(mm==1?yy-1:yy,mm==1?12:mm-1)-firstday+i+1	//上个月的最后几天
  for (i = firstday; day1 < GetMonthCount(yy,mm)+1; i++){meizzWDay[i]=day1;day1++;}
  for (i=firstday+GetMonthCount(yy,mm);i<39;i++){meizzWDay[i]=day2;day2++}
  for (i = 0; i < 39; i++)
  { var da = eval("odatelayer.meizzDay"+i)     //书写新的一个月的日期星期排列
    if (meizzWDay[i]!="")
      { 
		//初始化边框
		da.borderColorLight="#FF9900";
		da.borderColorDark="#FFFFFF";
		if(i<firstday)		//上个月的部分
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==1?12:mm-1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,-1)");
			if(!outDate)
				da.style.backgroundColor = ((mm==1?yy-1:yy) == new Date().getFullYear() && 
					(mm==1?12:mm-1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					 "#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && 
				meizzWDay[i]==outDate.getDate())? "#00ffff" :
				(((mm==1?yy-1:yy) == new Date().getFullYear() && (mm==1?12:mm-1) == new Date().getMonth()+1 && 
				meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if((mm==1?yy-1:yy)==outDate.getFullYear() && (mm==1?12:mm-1)== outDate.getMonth() + 1 && 
				meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else if (i>=firstday+GetMonthCount(yy,mm))		//下个月的部分
		{
			da.innerHTML="<b><font color=gray>" + meizzWDay[i] + "</font></b>";
			da.title=(mm==12?1:mm+1) +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,1)");
			if(!outDate)
				da.style.backgroundColor = ((mm==12?yy+1:yy) == new Date().getFullYear() && 
					(mm==12?1:mm+1) == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate()) ?
					 "#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && 
				meizzWDay[i]==outDate.getDate())? "#00ffff" :
				(((mm==12?yy+1:yy) == new Date().getFullYear() && (mm==12?1:mm+1) == new Date().getMonth()+1 && 
				meizzWDay[i] == new Date().getDate()) ? "#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if((mm==12?yy+1:yy)==outDate.getFullYear() && (mm==12?1:mm+1)== outDate.getMonth() + 1 && 
				meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
		else		//本月的部分
		{
			da.innerHTML="<b>" + meizzWDay[i] + "</b>";
			da.title=mm +"月" + meizzWDay[i] + "日";
			da.onclick=Function("meizzDayClick(this.innerText,0)");		//给td赋予onclick事件的处理
			//如果是当前选择的日期，则显示亮蓝色的背景；如果是当前日期，则显示暗黄色背景
			if(!outDate)
				da.style.backgroundColor = (yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					"#FFD700":"#e0e0e0";
			else
			{
				da.style.backgroundColor =(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())?
					"#00ffff":((yy == new Date().getFullYear() && mm == new Date().getMonth()+1 && meizzWDay[i] == new Date().getDate())?
					"#FFD700":"#e0e0e0");
				//将选中的日期显示为凹下去
				if(yy==outDate.getFullYear() && mm== outDate.getMonth() + 1 && meizzWDay[i]==outDate.getDate())
				{
					da.borderColorLight="#FFFFFF";
					da.borderColorDark="#FF9900";
				}
			}
		}
        da.style.cursor="hand"
      }
    else{da.innerHTML="";da.style.backgroundColor="";da.style.cursor="default"}
  }
}

function meizzDayClick(n,ex)  //点击显示框选取日期，主输入函数*************
{
  var yy=meizzTheYear;
  var mm = parseInt(meizzTheMonth)+ex;	//ex表示偏移量，用于选择上个月份和下个月份的日期
	//判断月份，并进行对应的处理
	if(mm<1){
		yy--;
		mm=12+mm;
	}
	else if(mm>12){
		yy++;
		mm=mm-12;
	}
	
  if (mm < 10){mm = "0" + mm;}
  if (outObject)
  {
    if (!n) {//outObject.value=""; 
      return;}
    if ( n < 10){n = "0" + n;}
    outObject.value= yy + "-" + mm + "-" + n ; //注：在这里你可以输出改成你想要的格式

	//2003-08-03添加，以使开始日期改变时，结束日期能一同改变
	try
	{
    		document.all.txtTDate.value=outObject.value
		document.all.txttdate.value=outObject.value
	}
	catch(exception)
	{
	}
    closeLayer(); 
  }
  else {closeLayer(); alert("您所要输出的控件对象并不存在！");}
}
</script></head>
<body bgcolor="#808080" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="images/bg.gif">
    <form name="form1" method="post" action="writelist.aspx" id="form1">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwUKMTM0OTgwNTExMA9kFgICAw9kFg4CAQ9kFgxmDw8WAh4EVGV4dAXEBOW9k+WJjeaXpeacn++8mjxzY3JpcHQgbGFuZ3VhZ2U9J0phdmFTY3JpcHQnPnZhciBlbmFibGU9MDsgdG9kYXk9bmV3IERhdGUoKTsgdmFyIGRheTsgdmFyIGRhdGU7dmFyIHRpbWVfc3RhcnQgPSBuZXcgRGF0ZSgpOyB2YXIgY2xvY2tfc3RhcnQgPSB0aW1lX3N0YXJ0LmdldFRpbWUoKTsgaWYodG9kYXkuZ2V0RGF5KCk9PTApZGF5PSfmmJ/mnJ/ml6UnOyBpZih0b2RheS5nZXREYXkoKT09MSkgZGF5PSfmmJ/mnJ/kuIAnOyBpZih0b2RheS5nZXREYXkoKT09MilkYXk9J+aYn+acn+S6jCc7IGlmKHRvZGF5LmdldERheSgpPT0zKWRheT0n5pif5pyf5LiJJzsgaWYodG9kYXkuZ2V0RGF5KCk9PTQpZGF5PSfmmJ/mnJ/lm5snOyBpZih0b2RheS5nZXREYXkoKT09NSlkYXk9J+aYn+acn+S6lCc7aWYodG9kYXkuZ2V0RGF5KCk9PTYpZGF5PSfmmJ/mnJ/lha0nOyBkYXRlPSh0b2RheS5nZXRZZWFyKCkpKyflubQnKyh0b2RheS5nZXRNb250aCgpKzEpKyfmnIgnK3RvZGF5LmdldERhdGUoKSsn5pelICc7ZG9jdW1lbnQud3JpdGUoJzxzcGFuID4nK2RhdGUpO2RvY3VtZW50LndyaXRlKGRheSsnPC9zcGFuPicpOyA8L3NjcmlwdD5kZAIBDw8WAh8ABQzorr7kuLrpppbpobVkZAICDw8WAh8ABQzliqDlhaXmlLbol49kZAIDDw8WAh8ABQzogZTns7vmiJHku6xkZAIEDw8WAh8ABZQEPG9iamVjdCBjbGFzc2lkPSdjbHNpZDpEMjdDREI2RS1BRTZELTExQ0YtOTZCOC00NDQ1NTM1NDAwMDAnIGlkPSdvYmoxJyBjb2RlYmFzZT0naHR0cDovL2Rvd25sb2FkLm1hY3JvbWVkaWEuY29tL3B1Yi9zaG9ja3dhdmUvY2Ficy9mbGFzaC9zd2ZsYXNoLmNhYiN2ZXJzaW9uPTYsMCw0MCwwJyBib3JkZXI9JzAnIHdpZHRoPSc5NjAnIGhlaWdodD0nMTYyJz48cGFyYW0gbmFtZT0nbW92aWUnIHZhbHVlPSdpbWFnZXMvZnVjazUuc3dmJz4JCTxwYXJhbSBuYW1lPSdxdWFsaXR5JyB2YWx1ZT0nSGlnaCc+PHBhcmFtIG5hbWU9J3dtb2RlJyB2YWx1ZT0ndHJhbnNwYXJlbnQnPgk8ZW1iZWQgc3JjPSdpbWFnZXMvZnVjazUuc3dmJyBwbHVnaW5zcGFnZT0naHR0cDovL3d3dy5tYWNyb21lZGlhLmNvbS9nby9nZXRmbGFzaHBsYXllcicgdHlwZT0nYXBwbGljYXRpb24veC1zaG9ja3dhdmUtZmxhc2gnIG5hbWU9J29iajEnIHdpZHRoPSc5NjAnIGhlaWdodD0nMTYyJyBxdWFsaXR5PSdIaWdoJyB3bW9kZT0ndHJhbnNwYXJlbnQnPjwvb2JqZWN0PmRkAgUPZBYEAgEPDxYCHwAFAkNIZGQCAw8PFgIfAAWJmQE8U0NSSVBUIGxhbmd1YWdlPUphdmFTY3JpcHQxLjIgc3JjPSdpbWFnZXMvc3RtMzEuanMnIHR5cGU9dGV4dC9KYXZhU2NyaXB0PjwvU0NSSVBUPiA8U0NSSVBUIGxhbmd1YWdlPUphdmFTY3JpcHQxLjIgdHlwZT10ZXh0L0phdmFTY3JpcHQ+IHN0bV9ibShbJ3V1ZW9laHInLDQwMCwnJywnaW1hZ2VzL2JsYW5rLmdpZicsMCwnJywnJywwLDAsMCwwLDAsMSwwLDBdKTsgc3RtX2JwKCdwMCcsWzAsNCwwLDAsMiwyLDAsMCwxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDAsMCwnIzAwMDAwMCcsJ3RyYW5zcGFyZW50JywnJywzLDAsMCwnIzAwMDAwMCddKTsgc3RtX2FpKCdwMGkwJyxbMCwnfCcsJycsJycsLTEsLTEsMCwnJywnX3NlbGYnLCcnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpMCcsJ3AwaTAnLFswLCfnvZHnq5npppbpobUnLCcnLCcnLC0xLC0xLDAsJ2luZGV4LmFzcHg/cGlkPTFfMCZ0eXBlaWQ9MScsJ19zZWxmJywnaW5kZXguYXNweD9waWQ9MV8wJnR5cGVpZD0xJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZXAoKTsgc3RtX2FpeCgncDBpMicsJ3AwaTAnLFswLCd8JywnJywnJywtMSwtMSwwLCcnLCdfc2VsZicsJycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpMScsJ3AwaTAnLFswLCfkv6Hmga/kuK3lv4MnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18xJnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTNfMSZ0eXBlaWQ9MScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2JwKCdwMScsWzEsNCwwLDAsMiwzLDYsNywxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDIsNCwnIzk5OTk5OScsJyNmZmZmZmYnLCcnLDMsMSwxLCcjQUNBODk5J10pOyBzdG1fYWl4KCdwMWkwJywncDBpMCcsWzAsJ+mAmuefpeWFrOWRiicsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0zXzEmcHBpZD0zXzFfMCcsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0zXzEmcHBpZD0zXzFfMCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCfmlrDpl7votYTorq8nLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18xJnBwaWQ9M18xXzUnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9M18xJnBwaWQ9M18xXzUnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTInLCdwMGkwJyxbMCwn5Zu+54mH5paw6Ze7JywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTNfMSZwcGlkPTNfMV8yJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTNfMSZwcGlkPTNfMV8yJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkzJywncDBpMCcsWzAsJ+aLm+eUn+S/oeaBrycsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0zXzEmcHBpZD0zXzFfMycsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0zXzEmcHBpZD0zXzFfMycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpNCcsJ3AwaTAnLFswLCfmi5vogZjkv6Hmga8nLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18xJnBwaWQ9M18xXzQnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9M18xJnBwaWQ9M18xXzQnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9lcCgpOyBzdG1fYWl4KCdwMGkyJywncDBpMCcsWzAsJ3wnLCcnLCcnLC0xLC0xLDAsJycsJ19zZWxmJywnJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMGkyJywncDBpMCcsWzAsJ+WtpuagoeamguWGtScsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0xXzYmdHlwZWlkPTEnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9MV82JnR5cGVpZD0xJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYnAoJ3AxJyxbMSw0LDAsMCwyLDMsNiw3LDEwMCwnZmlsdGVyOkdsb3coQ29sb3I9IzAwMDAwMCwgU3RyZW5ndGg9MyknLDQsJycsMjMsNTAsMiw0LCcjOTk5OTk5JywnI2ZmZmZmZicsJycsMywxLDEsJyNBQ0E4OTknXSk7IHN0bV9haXgoJ3AxaTAnLCdwMGkwJyxbMCwn5a2m5qCh566A5LuLJywnJywnJywtMSwtMSwwLCdkaXNwaW5mLmFzcHg/cGlkPTFfNiZwcGlkPTNfM181JywnX3NlbGYnLCdkaXNwaW5mLmFzcHg/cGlkPTFfNiZwcGlkPTNfM181JywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkxJywncDBpMCcsWzAsJ+mihuWvvOePreWtkCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0xXzYmcHBpZD0xXzZfMTAnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9MV82JnBwaWQ9MV82XzEwJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkyJywncDBpMCcsWzAsJ+iBjOiDvemDqOmXqCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0xXzYmcHBpZD0zXzNfNycsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0xXzYmcHBpZD0zXzNfNycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMycsJ3AwaTAnLFswLCfmoKHplb/orrLor50nLCcnLCcnLC0xLC0xLDAsJ2Rpc3BpbmYuYXNweD9waWQ9MV82JnBwaWQ9MV82XzgnLCdfc2VsZicsJ2Rpc3BpbmYuYXNweD9waWQ9MV82JnBwaWQ9MV82XzgnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTQnLCdwMGkwJyxbMCwn5aSn5LqL6K6wJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTFfNiZwcGlkPTFfNl85JywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTFfNiZwcGlkPTFfNl85JywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZXAoKTsgc3RtX2FpeCgncDBpMicsJ3AwaTAnLFswLCd8JywnJywnJywtMSwtMSwwLCcnLCdfc2VsZicsJycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpMycsJ3AwaTAnLFswLCflhZrlu7rlm63lnLAnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9NF8zJnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTRfMyZ0eXBlaWQ9MScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2JwKCdwMScsWzEsNCwwLDAsMiwzLDYsNywxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDIsNCwnIzk5OTk5OScsJyNmZmZmZmYnLCcnLDMsMSwxLCcjQUNBODk5J10pOyBzdG1fYWl4KCdwMWkwJywncDBpMCcsWzAsJ+aUr+mDqOa0u+WKqCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD00XzMmcHBpZD00XzNfMCcsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD00XzMmcHBpZD00XzNfMCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCflhYjov5vmgKfmlZnogrInLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9NF8zJnBwaWQ9NF8zXzEnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9NF8zJnBwaWQ9NF8zXzEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9lcCgpOyBzdG1fYWl4KCdwMGkyJywncDBpMCcsWzAsJ3wnLCcnLCcnLC0xLC0xLDAsJycsJ19zZWxmJywnJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMGk0JywncDBpMCcsWzAsJ+aVmeWtpuaVmeeglCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0yXzQmdHlwZWlkPTEnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9Ml80JnR5cGVpZD0xJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYnAoJ3AxJyxbMSw0LDAsMCwyLDMsNiw3LDEwMCwnZmlsdGVyOkdsb3coQ29sb3I9IzAwMDAwMCwgU3RyZW5ndGg9MyknLDQsJycsMjMsNTAsMiw0LCcjOTk5OTk5JywnI2ZmZmZmZicsJycsMywxLDEsJyNBQ0E4OTknXSk7IHN0bV9haXgoJ3AxaTAnLCdwMGkwJyxbMCwn5pWZ5a2m5pWZ56CU5bel5L2cJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTJfNCZwcGlkPTJfNF8zJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTJfNCZwcGlkPTJfNF8zJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkxJywncDBpMCcsWzAsJ+aVmeWtpuaVmeeglOa0u+WKqCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0yXzQmcHBpZD0yXzRfNCcsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0yXzQmcHBpZD0yXzRfNCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMicsJ3AwaTAnLFswLCfor77popjnoJTnqbYnLCcnLCcnLC0xLC0xLDAsJ2Rpc3BpbmYuYXNweD9waWQ9Ml80JnBwaWQ9Ml80XzUnLCdfc2VsZicsJ2Rpc3BpbmYuYXNweD9waWQ9Ml80JnBwaWQ9Ml80XzUnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTMnLCdwMGkwJyxbMCwn6K++5pS55a6e6Le1JywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTJfNCZwcGlkPTJfNF82JywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTJfNCZwcGlkPTJfNF82JywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZXAoKTsgc3RtX2FpeCgncDBpMicsJ3AwaTAnLFswLCd8JywnJywnJywtMSwtMSwwLCcnLCdfc2VsZicsJycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpNScsJ3AwaTAnLFswLCflvrfogrLlm63lnLAnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18wJnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTNfMCZ0eXBlaWQ9MScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2JwKCdwMScsWzEsNCwwLDAsMiwzLDYsNywxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDIsNCwnIzk5OTk5OScsJyNmZmZmZmYnLCcnLDMsMSwxLCcjQUNBODk5J10pOyBzdG1fYWl4KCdwMWkwJywncDBpMCcsWzAsJ+ePreS4u+S7u+W3peS9nCcsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0zXzAmcHBpZD0zXzBfMicsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0zXzAmcHBpZD0zXzBfMicsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCflvrfogrLmtLvliqgnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18wJnBwaWQ9M18wXzMnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9M18wJnBwaWQ9M18wXzMnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTInLCdwMGkwJyxbMCwn5qCh57qq5qCh6KeEJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTNfMCZwcGlkPTNfMF81JywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTNfMCZwcGlkPTNfMF81JywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZXAoKTsgc3RtX2FpeCgncDBpMicsJ3AwaTAnLFswLCd8JywnJywnJywtMSwtMSwwLCcnLCdfc2VsZicsJycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpNicsJ3AwaTAnLFswLCfmlZnluIjlm63lnLAnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9Ml8yJnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTJfMiZ0eXBlaWQ9MScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2JwKCdwMScsWzEsNCwwLDAsMiwzLDYsNywxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDIsNCwnIzk5OTk5OScsJyNmZmZmZmYnLCcnLDMsMSwxLCcjQUNBODk5J10pOyBzdG1fYWl4KCdwMWkwJywncDBpMCcsWzAsJ+WQjeW4iOmjjumHhycsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0yXzImcHBpZD0yXzJfMCcsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0yXzImcHBpZD0yXzJfMCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCfmlZnluIjojaPoqoknLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9Ml8yJnBwaWQ9Ml8zXzAnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9Ml8yJnBwaWQ9Ml8zXzAnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTInLCdwMGkwJyxbMCwn5pWZ5biI5a2m5LmgJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTJfMiZwcGlkPTJfMl8xJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTJfMiZwcGlkPTJfMl8xJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkzJywncDBpMCcsWzAsJ+aVmeW4iOiuuuaWhycsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0yXzImcHBpZD0yXzJfMycsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0yXzImcHBpZD0yXzJfMycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2VwKCk7IHN0bV9haXgoJ3AwaTInLCdwMGkwJyxbMCwnfCcsJycsJycsLTEsLTEsMCwnJywnX3NlbGYnLCcnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AwaTcnLCdwMGkwJyxbMCwn5a2m55Sf5aSp5ZywJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTNfMiZ0eXBlaWQ9MScsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0zXzImdHlwZWlkPTEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9icCgncDEnLFsxLDQsMCwwLDIsMyw2LDcsMTAwLCdmaWx0ZXI6R2xvdyhDb2xvcj0jMDAwMDAwLCBTdHJlbmd0aD0zKScsNCwnJywyMyw1MCwyLDQsJyM5OTk5OTknLCcjZmZmZmZmJywnJywzLDEsMSwnI0FDQTg5OSddKTsgc3RtX2FpeCgncDFpMCcsJ3AwaTAnLFswLCflrabnlJ/ojaPoqoknLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9M18yJnBwaWQ9M18yXzAnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9M18yJnBwaWQ9M18yXzAnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTEnLCdwMGkwJyxbMCwn6K++5aSW5rS75YqoJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTNfMiZwcGlkPTNfMl8yJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTNfMiZwcGlkPTNfMl8yJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkyJywncDBpMCcsWzAsJ+WtpueUn+S9nOWTgScsJycsJycsLTEsLTEsMCwnbGlzdGluZi5hc3B4P3BpZD0zXzImcHBpZD0zXzJfMycsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0zXzImcHBpZD0zXzJfMycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2VwKCk7IHN0bV9haXgoJ3AwaTInLCdwMGkwJyxbMCwnfCcsJycsJycsLTEsLTEsMCwnJywnX3NlbGYnLCcnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AwaTgnLCdwMGkwJyxbMCwn5a2m5qCh5Zui5aeUJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTJfMCZ0eXBlaWQ9MScsJ19zZWxmJywnbGlzdGluZi5hc3B4P3BpZD0yXzAmdHlwZWlkPTEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9icCgncDEnLFsxLDQsMCwwLDIsMyw2LDcsMTAwLCdmaWx0ZXI6R2xvdyhDb2xvcj0jMDAwMDAwLCBTdHJlbmd0aD0zKScsNCwnJywyMyw1MCwyLDQsJyM5OTk5OTknLCcjZmZmZmZmJywnJywzLDEsMSwnI0FDQTg5OSddKTsgc3RtX2FpeCgncDFpMCcsJ3AwaTAnLFswLCfmoKHlrabnlJ/kvJonLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbmYuYXNweD9waWQ9Ml8wJnBwaWQ9Ml8wXzQnLCdfc2VsZicsJ2xpc3RpbmYuYXNweD9waWQ9Ml8wJnBwaWQ9Ml8wXzQnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTEnLCdwMGkwJyxbMCwn5a2m55Sf5Zui5oC75pSvJywnJywnJywtMSwtMSwwLCdsaXN0aW5mLmFzcHg/cGlkPTJfMCZwcGlkPTJfMF8wJywnX3NlbGYnLCdsaXN0aW5mLmFzcHg/cGlkPTJfMCZwcGlkPTJfMF8wJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZXAoKTsgc3RtX2FpeCgncDBpMicsJ3AwaTAnLFswLCd8JywnJywnJywtMSwtMSwwLCcnLCdfc2VsZicsJycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDBpOScsJ3AwaTAnLFswLCfotYTmupDkuK3lv4MnLCcnLCcnLC0xLC0xLDAsJ2xpc3Rzb3VyY2VpbmYuYXNweD9waWQ9MV85JnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0c291cmNlaW5mLmFzcHg/cGlkPTFfOSZ0eXBlaWQ9MScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2JwKCdwMScsWzEsNCwwLDAsMiwzLDYsNywxMDAsJ2ZpbHRlcjpHbG93KENvbG9yPSMwMDAwMDAsIFN0cmVuZ3RoPTMpJyw0LCcnLDIzLDUwLDIsNCwnIzk5OTk5OScsJyNmZmZmZmYnLCcnLDMsMSwxLCcjQUNBODk5J10pOyBzdG1fYWl4KCdwMWkwJywncDBpMCcsWzAsJ+ivleWNt+exuycsJycsJycsLTEsLTEsMCwnbGlzdHNvdXJjZWluZi5hc3B4P3BpZD0xXzkmcHBpZD0xXzlfMCcsJ19zZWxmJywnbGlzdHNvdXJjZWluZi5hc3B4P3BpZD0xXzkmcHBpZD0xXzlfMCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCfotYTmlpnnsbsnLCcnLCcnLC0xLC0xLDAsJ2xpc3Rzb3VyY2VpbmYuYXNweD9waWQ9MV85JnBwaWQ9MV85XzEnLCdfc2VsZicsJ2xpc3Rzb3VyY2VpbmYuYXNweD9waWQ9MV85JnBwaWQ9MV85XzEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTInLCdwMGkwJyxbMCwn6L2v5Lu257G7JywnJywnJywtMSwtMSwwLCdsaXN0c291cmNlaW5mLmFzcHg/cGlkPTFfOSZwcGlkPTFfOV8yJywnX3NlbGYnLCdsaXN0c291cmNlaW5mLmFzcHg/cGlkPTFfOSZwcGlkPTFfOV8yJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkzJywncDBpMCcsWzAsJ+inhumikeexuycsJycsJycsLTEsLTEsMCwnbGlzdHNvdXJjZWluZi5hc3B4P3BpZD0xXzkmcHBpZD0xXzlfMycsJ19zZWxmJywnbGlzdHNvdXJjZWluZi5hc3B4P3BpZD0xXzkmcHBpZD0xXzlfMycsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2VwKCk7IHN0bV9haXgoJ3AwaTInLCdwMGkwJyxbMCwnfCcsJycsJycsLTEsLTEsMCwnJywnX3NlbGYnLCcnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AwaTEwJywncDBpMCcsWzAsJ+WbvueJh+S4reW/gycsJycsJycsLTEsLTEsMCwnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnR5cGVpZD0xJywnX3NlbGYnLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmdHlwZWlkPTEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9icCgncDEnLFsxLDQsMCwwLDIsMyw2LDcsMTAwLCdmaWx0ZXI6R2xvdyhDb2xvcj0jMDAwMDAwLCBTdHJlbmd0aD0zKScsNCwnJywyMyw1MCwyLDQsJyM5OTk5OTknLCcjZmZmZmZmJywnJywzLDEsMSwnI0FDQTg5OSddKTsgc3RtX2FpeCgncDFpMCcsJ3AwaTAnLFswLCfmoKHlm63po47lhYknLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbWdpbmYuYXNweD9waWQ9MV8xMCZwcGlkPTFfMTBfMCcsJ19zZWxmJywnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF8wJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkxJywncDBpMCcsWzAsJ+Wtpuagoea0u+WKqCcsJycsJycsLTEsLTEsMCwnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF8xJywnX3NlbGYnLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmcHBpZD0xXzEwXzEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTInLCdwMGkwJyxbMCwn5pWZ5biI6aOO6YeHJywnJywnJywtMSwtMSwwLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmcHBpZD0xXzEwXzInLCdfc2VsZicsJ2xpc3RpbWdpbmYuYXNweD9waWQ9MV8xMCZwcGlkPTFfMTBfMicsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMycsJ3AwaTAnLFswLCflrabnlJ/mtLvliqgnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbWdpbmYuYXNweD9waWQ9MV8xMCZwcGlkPTFfMTBfMycsJ19zZWxmJywnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF8zJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWk0JywncDBpMCcsWzAsJ+avleS4mueVmeW9sScsJycsJycsLTEsLTEsMCwnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF80JywnX3NlbGYnLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmcHBpZD0xXzEwXzQnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9haXgoJ3AxaTUnLCdwMGkwJyxbMCwn6I2j6KqJ5aWW54q2JywnJywnJywtMSwtMSwwLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmcHBpZD0xXzEwXzUnLCdfc2VsZicsJ2xpc3RpbWdpbmYuYXNweD9waWQ9MV8xMCZwcGlkPTFfMTBfNScsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpNicsJ3AwaTAnLFswLCfljoblsYrnirblkZgnLCcnLCcnLC0xLC0xLDAsJ2xpc3RpbWdpbmYuYXNweD9waWQ9MV8xMCZwcGlkPTFfMTBfNycsJ19zZWxmJywnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF83JywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWk3JywncDBpMCcsWzAsJ+agoeWbreS5i+aYnycsJycsJycsLTEsLTEsMCwnbGlzdGltZ2luZi5hc3B4P3BpZD0xXzEwJnBwaWQ9MV8xMF82JywnX3NlbGYnLCdsaXN0aW1naW5mLmFzcHg/cGlkPTFfMTAmcHBpZD0xXzEwXzYnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9lcCgpOyBzdG1fYWl4KCdwMGkyJywncDBpMCcsWzAsJ3wnLCcnLCcnLC0xLC0xLDAsJycsJ19zZWxmJywnJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMGkxMScsJ3AwaTAnLFswLCfkupLliqjkuqTmtYEnLCcnLCcnLC0xLC0xLDAsJ3dyaXRlbGlzdC5hc3B4P3BpZD0xXzcmdHlwZWlkPTEnLCdfc2VsZicsJ3dyaXRlbGlzdC5hc3B4P3BpZD0xXzcmdHlwZWlkPTEnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9icCgncDEnLFsxLDQsMCwwLDIsMyw2LDcsMTAwLCdmaWx0ZXI6R2xvdyhDb2xvcj0jMDAwMDAwLCBTdHJlbmd0aD0zKScsNCwnJywyMyw1MCwyLDQsJyM5OTk5OTknLCcjZmZmZmZmJywnJywzLDEsMSwnI0FDQTg5OSddKTsgc3RtX2FpeCgncDFpMCcsJ3AwaTAnLFswLCfmiJHopoHnlZnoqIAnLCcnLCcnLC0xLC0xLDAsJ3dyaXRlLmFzcHg/cGlkPTFfNyZwcGlkPTFfN18wJywnX3NlbGYnLCd3cml0ZS5hc3B4P3BpZD0xXzcmcHBpZD0xXzdfMCcsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMScsJ3AwaTAnLFswLCfnlZnoqIDmn6XnnIsnLCcnLCcnLC0xLC0xLDAsJ3dyaXRlbGlzdC5hc3B4P3BpZD0xXzcmcHBpZD0xXzdfMScsJ19zZWxmJywnd3JpdGVsaXN0LmFzcHg/cGlkPTFfNyZwcGlkPTFfN18xJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fYWl4KCdwMWkyJywncDBpMCcsWzAsJ+iBlOezu+aIkeS7rCcsJycsJycsLTEsLTEsMCwnZGlzcGluZi5hc3B4P3BpZD0xXzcmcHBpZD0xXzdfMicsJ19zZWxmJywnZGlzcGluZi5hc3B4P3BpZD0xXzcmcHBpZD0xXzdfMicsJycsJycsJycsMCwwLDAsJycsJycsMCwwLDAsMCwxLCcjRjFGMkVFJywxLCcjQ0NDQ0NDJywxLCcnLCcnLDMsMywwLDAsJyNGRkZGRjcnLCcjRkYwMDAwJywnIzAwMDAwMCcsJyNDQzAwMDAnLCc5cHQg5a6L5L2TJywnOXB0IOWui+S9kyddKTsgc3RtX2FpeCgncDFpMycsJ3AwaTAnLFswLCfnvZHnq5nosIPmn6UnLCcnLCcnLC0xLC0xLDAsJ1ZvdGUuYXNweGM9aD9waWQ9MV83JnBwaWQ9MV83XzMnLCdfc2VsZicsJ1ZvdGUuYXNweGM9aD9waWQ9MV83JnBwaWQ9MV83XzMnLCcnLCcnLCcnLDAsMCwwLCcnLCcnLDAsMCwwLDAsMSwnI0YxRjJFRScsMSwnI0NDQ0NDQycsMSwnJywnJywzLDMsMCwwLCcjRkZGRkY3JywnI0ZGMDAwMCcsJyMwMDAwMDAnLCcjQ0MwMDAwJywnOXB0IOWui+S9kycsJzlwdCDlrovkvZMnXSk7IHN0bV9lcCgpOyBzdG1fYWl4KCdwMGkyJywncDBpMCcsWzAsJ3wnLCcnLCcnLC0xLC0xLDAsJycsJ19zZWxmJywnJywnJywnJywnJywwLDAsMCwnJywnJywwLDAsMCwwLDEsJyNGMUYyRUUnLDEsJyNDQ0NDQ0MnLDEsJycsJycsMywzLDAsMCwnI0ZGRkZGNycsJyNGRjAwMDAnLCcjMDAwMDAwJywnI0NDMDAwMCcsJzlwdCDlrovkvZMnLCc5cHQg5a6L5L2TJ10pOyBzdG1fZW0oKTs8L1NDUklQVD5kZAIDD2QWBAIBDw8WAh4ISW1hZ2VVcmwFE2ltYWdlcy9sZWZ0bG9nby5qcGdkZAIDDw8WAh8AZGRkAgUPDxYCHwAFDOe9keermemmlumhtWRkAgkPDxYCHwAFAi0xZGQCFQ8PFgIfAAUBMGRkAhcPPCsACwEADxYKHgtfIUl0ZW1Db3VudGYeCERhdGFLZXlzFgAeEEN1cnJlbnRQYWdlSW5kZXhmHglQYWdlQ291bnQCAR4VXyFEYXRhU291cmNlSXRlbUNvdW50ZmRkAhwPZBYQZg8PFgIfAAUM54mI5p2D5omA5pyJZGQCAQ8PFgIfAAVG5Zyw5Z2AOuaxn+ilv+aZr+W+t+mVh+acnemYs+i3r+aYjOays+aVmeiCsuWbreWMuiZuYnNwOyAg6YKu57yWOjMzMzAwMGRkAgIPDxYCHwAFE+eUteivnTowNzk4LTg0NjI1NThkZAIDDw8WAh8ABRLlkI7lj7DnrqHnkIbnmbvlvZVkZAIEDw8WAh8ABQnnvZHlnYDvvJpkZAIFDw8WAh8ABQ/nlLXlrZDpgq7ku7bvvJpkZAIGDw8WAh8ABQ/liLbkvZznu7TmiqTvvJpkZAIHDw8WAh8ABQznkZ7lhYnova/ku7ZkZGRdYWoFP0R7XxsoFzkon7ccyuJoZg==" />

    <table width="900" height="900"  cellpadding="0" cellspacing="0" align="center">
    <tr><td height="216">
        
 <LINK href="css/jdzcss.css" rel=stylesheet>
    <LINK href="images/DefaultSkin.css" type=text/css rel=stylesheet>
<table width="100%" height="216" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="border-collapse: collapse">
    <tr><td height="22"> <table border="0" width="960" id="table1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" height="20">
		<tr>
			<td width="258">
			<p align="left">&nbsp;<span id="Top1_Label1">当前日期：<script language='JavaScript'>var enable=0; today=new Date(); var day; var date;var time_start = new Date(); var clock_start = time_start.getTime(); if(today.getDay()==0)day='星期日'; if(today.getDay()==1) day='星期一'; if(today.getDay()==2)day='星期二'; if(today.getDay()==3)day='星期三'; if(today.getDay()==4)day='星期四'; if(today.getDay()==5)day='星期五';if(today.getDay()==6)day='星期六'; date=(today.getYear())+'年'+(today.getMonth()+1)+'月'+today.getDate()+'日 ';document.write('<span >'+date);document.write(day+'</span>'); </script></span>
                </td>
			<td width="365">　</td>
			<td width="92">
			<img border="0" src="images/closenew.gif" width="14" height="14"> 
			<a onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.jdzch18.com');"href="http://www.jdzch18.com"><span id="Top1_Label2">设为首页</span></a></td>
			<td width="92">
			<img border="0" src="images/closenew.gif" width="14" height="14"> 
			<A onclick="javascript:window.external.addFavorite('http://www.jdzch18.com','景德镇昌河中学');"href="http://www.jdzch18.com"><span id="Top1_Label3">加入收藏</span></a></td>
			<td width="93">
			<img border="0" src="images/closenew.gif" width="14" height="14"> 
			<a href="dispinf.aspx?pid=1_7&ppid=1_7_2"><span id="Top1_Label4">联系我们</span></a></td>
		</tr>
	</table></td></tr>
    <tr><td height="162">  <span id="Top1_Label5"><object classid='clsid:D27CDB6E-AE6D-11CF-96B8-444553540000' id='obj1' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0' border='0' width='960' height='162'><param name='movie' value='images/fuck5.swf'>		<param name='quality' value='High'><param name='wmode' value='transparent'>	<embed src='images/fuck5.swf' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' name='obj1' width='960' height='162' quality='High' wmode='transparent'></object></span> </td></tr>
    <tr><td height="32" background="images/menubg.jpg" >
        <table width="100%" cellpadding="0" cellspacing="0"><tr><td width="25" height="32">&nbsp;</td><td>
<script language="javascript">
function addurl1(url)
{
	location.href=url;
  //	document.all.item("mainright").src=url;
//	settext1(str);
//	//Text1.value="dddd";
//	//menu_list.Text='asdf';
}
function openmenu(tableid)
{
	document.all[tableid].style.visibility='visible';


}
function hidemenu(tableid)
{
    document.all[tableid].style.visibility='hidden';
}	
function getleft(tdid)
{
  return document.all[tdid].left;
}
function gettop(tdid)
{
  return document.all[tdid].top;
}
function getwidth(tdid)
{
  return document.all[tdid].width;
}
function getheight(tdid)
{
  return document.all[tdid].height;
}
function setleft(tdid1,tdid2)
{
document.all[tdid1].style.left=getleft(tdid2)-80;
}
</script>

<table><tr><td><span id="Top1_Topmenu1_tbmenu"><SCRIPT language=JavaScript1.2 src='images/stm31.js' type=text/JavaScript></SCRIPT> <SCRIPT language=JavaScript1.2 type=text/JavaScript> stm_bm(['uueoehr',400,'','images/blank.gif',0,'','',0,0,0,0,0,1,0,0]); stm_bp('p0',[0,4,0,0,2,2,0,0,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,0,0,'#000000','transparent','',3,0,0,'#000000']); stm_ai('p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体','9pt 宋体','9pt 宋体']); stm_aix('p0i0','p0i0',[0,'网站首页','','',-1,-1,0,'index.aspx?pid=1_0&typeid=1','_self','index.aspx?pid=1_0&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i1','p0i0',[0,'信息中心','','',-1,-1,0,'listinf.aspx?pid=3_1&typeid=1','_self','listinf.aspx?pid=3_1&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'通知公告','','',-1,-1,0,'listinf.aspx?pid=3_1&ppid=3_1_0','_self','listinf.aspx?pid=3_1&ppid=3_1_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'新闻资讯','','',-1,-1,0,'listinf.aspx?pid=3_1&ppid=3_1_5','_self','listinf.aspx?pid=3_1&ppid=3_1_5','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'图片新闻','','',-1,-1,0,'listinf.aspx?pid=3_1&ppid=3_1_2','_self','listinf.aspx?pid=3_1&ppid=3_1_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'招生信息','','',-1,-1,0,'listinf.aspx?pid=3_1&ppid=3_1_3','_self','listinf.aspx?pid=3_1&ppid=3_1_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i4','p0i0',[0,'招聘信息','','',-1,-1,0,'listinf.aspx?pid=3_1&ppid=3_1_4','_self','listinf.aspx?pid=3_1&ppid=3_1_4','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i2','p0i0',[0,'学校概况','','',-1,-1,0,'listinf.aspx?pid=1_6&typeid=1','_self','listinf.aspx?pid=1_6&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'学校简介','','',-1,-1,0,'dispinf.aspx?pid=1_6&ppid=3_3_5','_self','dispinf.aspx?pid=1_6&ppid=3_3_5','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'领导班子','','',-1,-1,0,'listinf.aspx?pid=1_6&ppid=1_6_10','_self','listinf.aspx?pid=1_6&ppid=1_6_10','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'职能部门','','',-1,-1,0,'listinf.aspx?pid=1_6&ppid=3_3_7','_self','listinf.aspx?pid=1_6&ppid=3_3_7','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'校长讲话','','',-1,-1,0,'dispinf.aspx?pid=1_6&ppid=1_6_8','_self','dispinf.aspx?pid=1_6&ppid=1_6_8','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i4','p0i0',[0,'大事记','','',-1,-1,0,'listinf.aspx?pid=1_6&ppid=1_6_9','_self','listinf.aspx?pid=1_6&ppid=1_6_9','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i3','p0i0',[0,'党建园地','','',-1,-1,0,'listinf.aspx?pid=4_3&typeid=1','_self','listinf.aspx?pid=4_3&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'支部活动','','',-1,-1,0,'listinf.aspx?pid=4_3&ppid=4_3_0','_self','listinf.aspx?pid=4_3&ppid=4_3_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'先进性教育','','',-1,-1,0,'listinf.aspx?pid=4_3&ppid=4_3_1','_self','listinf.aspx?pid=4_3&ppid=4_3_1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i4','p0i0',[0,'教学教研','','',-1,-1,0,'listinf.aspx?pid=2_4&typeid=1','_self','listinf.aspx?pid=2_4&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'教学教研工作','','',-1,-1,0,'listinf.aspx?pid=2_4&ppid=2_4_3','_self','listinf.aspx?pid=2_4&ppid=2_4_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'教学教研活动','','',-1,-1,0,'listinf.aspx?pid=2_4&ppid=2_4_4','_self','listinf.aspx?pid=2_4&ppid=2_4_4','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'课题研究','','',-1,-1,0,'dispinf.aspx?pid=2_4&ppid=2_4_5','_self','dispinf.aspx?pid=2_4&ppid=2_4_5','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'课改实践','','',-1,-1,0,'listinf.aspx?pid=2_4&ppid=2_4_6','_self','listinf.aspx?pid=2_4&ppid=2_4_6','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i5','p0i0',[0,'德育园地','','',-1,-1,0,'listinf.aspx?pid=3_0&typeid=1','_self','listinf.aspx?pid=3_0&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'班主任工作','','',-1,-1,0,'listinf.aspx?pid=3_0&ppid=3_0_2','_self','listinf.aspx?pid=3_0&ppid=3_0_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'德育活动','','',-1,-1,0,'listinf.aspx?pid=3_0&ppid=3_0_3','_self','listinf.aspx?pid=3_0&ppid=3_0_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'校纪校规','','',-1,-1,0,'listinf.aspx?pid=3_0&ppid=3_0_5','_self','listinf.aspx?pid=3_0&ppid=3_0_5','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i6','p0i0',[0,'教师园地','','',-1,-1,0,'listinf.aspx?pid=2_2&typeid=1','_self','listinf.aspx?pid=2_2&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'名师风采','','',-1,-1,0,'listinf.aspx?pid=2_2&ppid=2_2_0','_self','listinf.aspx?pid=2_2&ppid=2_2_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'教师荣誉','','',-1,-1,0,'listinf.aspx?pid=2_2&ppid=2_3_0','_self','listinf.aspx?pid=2_2&ppid=2_3_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'教师学习','','',-1,-1,0,'listinf.aspx?pid=2_2&ppid=2_2_1','_self','listinf.aspx?pid=2_2&ppid=2_2_1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'教师论文','','',-1,-1,0,'listinf.aspx?pid=2_2&ppid=2_2_3','_self','listinf.aspx?pid=2_2&ppid=2_2_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i7','p0i0',[0,'学生天地','','',-1,-1,0,'listinf.aspx?pid=3_2&typeid=1','_self','listinf.aspx?pid=3_2&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'学生荣誉','','',-1,-1,0,'listinf.aspx?pid=3_2&ppid=3_2_0','_self','listinf.aspx?pid=3_2&ppid=3_2_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'课外活动','','',-1,-1,0,'listinf.aspx?pid=3_2&ppid=3_2_2','_self','listinf.aspx?pid=3_2&ppid=3_2_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'学生作品','','',-1,-1,0,'listinf.aspx?pid=3_2&ppid=3_2_3','_self','listinf.aspx?pid=3_2&ppid=3_2_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i8','p0i0',[0,'学校团委','','',-1,-1,0,'listinf.aspx?pid=2_0&typeid=1','_self','listinf.aspx?pid=2_0&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'校学生会','','',-1,-1,0,'listinf.aspx?pid=2_0&ppid=2_0_4','_self','listinf.aspx?pid=2_0&ppid=2_0_4','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'学生团总支','','',-1,-1,0,'listinf.aspx?pid=2_0&ppid=2_0_0','_self','listinf.aspx?pid=2_0&ppid=2_0_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i9','p0i0',[0,'资源中心','','',-1,-1,0,'listsourceinf.aspx?pid=1_9&typeid=1','_self','listsourceinf.aspx?pid=1_9&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'试卷类','','',-1,-1,0,'listsourceinf.aspx?pid=1_9&ppid=1_9_0','_self','listsourceinf.aspx?pid=1_9&ppid=1_9_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'资料类','','',-1,-1,0,'listsourceinf.aspx?pid=1_9&ppid=1_9_1','_self','listsourceinf.aspx?pid=1_9&ppid=1_9_1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'软件类','','',-1,-1,0,'listsourceinf.aspx?pid=1_9&ppid=1_9_2','_self','listsourceinf.aspx?pid=1_9&ppid=1_9_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'视频类','','',-1,-1,0,'listsourceinf.aspx?pid=1_9&ppid=1_9_3','_self','listsourceinf.aspx?pid=1_9&ppid=1_9_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i10','p0i0',[0,'图片中心','','',-1,-1,0,'listimginf.aspx?pid=1_10&typeid=1','_self','listimginf.aspx?pid=1_10&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'校园风光','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_0','_self','listimginf.aspx?pid=1_10&ppid=1_10_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'学校活动','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_1','_self','listimginf.aspx?pid=1_10&ppid=1_10_1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'教师风采','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_2','_self','listimginf.aspx?pid=1_10&ppid=1_10_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'学生活动','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_3','_self','listimginf.aspx?pid=1_10&ppid=1_10_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i4','p0i0',[0,'毕业留影','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_4','_self','listimginf.aspx?pid=1_10&ppid=1_10_4','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i5','p0i0',[0,'荣誉奖状','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_5','_self','listimginf.aspx?pid=1_10&ppid=1_10_5','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i6','p0i0',[0,'历届状员','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_7','_self','listimginf.aspx?pid=1_10&ppid=1_10_7','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i7','p0i0',[0,'校园之星','','',-1,-1,0,'listimginf.aspx?pid=1_10&ppid=1_10_6','_self','listimginf.aspx?pid=1_10&ppid=1_10_6','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p0i11','p0i0',[0,'互动交流','','',-1,-1,0,'writelist.aspx?pid=1_7&typeid=1','_self','writelist.aspx?pid=1_7&typeid=1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_bp('p1',[1,4,0,0,2,3,6,7,100,'filter:Glow(Color=#000000, Strength=3)',4,'',23,50,2,4,'#999999','#ffffff','',3,1,1,'#ACA899']); stm_aix('p1i0','p0i0',[0,'我要留言','','',-1,-1,0,'write.aspx?pid=1_7&ppid=1_7_0','_self','write.aspx?pid=1_7&ppid=1_7_0','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i1','p0i0',[0,'留言查看','','',-1,-1,0,'writelist.aspx?pid=1_7&ppid=1_7_1','_self','writelist.aspx?pid=1_7&ppid=1_7_1','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i2','p0i0',[0,'联系我们','','',-1,-1,0,'dispinf.aspx?pid=1_7&ppid=1_7_2','_self','dispinf.aspx?pid=1_7&ppid=1_7_2','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_aix('p1i3','p0i0',[0,'网站调查','','',-1,-1,0,'Vote.aspxc=h?pid=1_7&ppid=1_7_3','_self','Vote.aspxc=h?pid=1_7&ppid=1_7_3','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_ep(); stm_aix('p0i2','p0i0',[0,'|','','',-1,-1,0,'','_self','','','','',0,0,0,'','',0,0,0,0,1,'#F1F2EE',1,'#CCCCCC',1,'','',3,3,0,0,'#FFFFF7','#FF0000','#000000','#CC0000','9pt 宋体','9pt 宋体']); stm_em();</SCRIPT></span></td><td>
</td></tr></table>
</td></tr></table>
    </td></tr>
    </table>
        </td></tr>
    <tr><td height="600"><table width="100%" height="100%" cellpadding="0" cellspacing="0" borderColor="#111111" style="BORDER-COLLAPSE: collapse" bgColor=#f2fefc>
    <tr><td width="167">
        
<table width="167" cellpadding="0" cellspacing="0"><tr><td height="100" valign="top"><img id="Leftmenu1_Image1" src="images/leftlogo.jpg" border="0" width="167" /></td></tr><tr><td height="300" valign="top">
        <span id="Leftmenu1_leftmenu1"></span></td></tr><tr><td height="200" valign="top"></td></tr></table> 
    </td><TD vAlign=top width=6 background="images/xuxian1.jpg"
                height="100%">　</TD>
                <td width="787" valign="top"><table width="100%" height="100%" cellpadding="0" cellspacing="0"><tr><td height="57" valign="top"><table width="100%" height="100%" cellpadding="0" cellspacing="0"><tr><td width="160" background="images/rtb.jpg" height="38">
                    &nbsp;&nbsp;&nbsp;<img src="images/026.gif" />&nbsp;&nbsp;<span id="Label1"><b><font color="Red">网站首页</font></b></span></td>
                    <td background="images/rtb2.jpg" width="627" height="38"><table width="95%" cellpadding="0" cellspacing="0" align="center" height="19"><tr><td style="height: 19px" width="100%" align="center"><span id="lbtitle"><b><font color="Black" size="5"></font></b></span></td></tr></table></td></tr>
                    <tr><td colspan="2" background="images/bg2.jpg" width="727" height="19">
                        </td></tr>
                    </table></td></tr>
                    <tr><td style="height: 36px" valign="top" align="center"><table width="80%" height="100%" cellpadding="0" cellspacing="0"><tr><td style="height: 39px"><table width="100%" height="20" cellpadding="0" cellspacing="0">
                    <tr><td style="width: 73px; height: 24px">留言主题：</td><td style="height: 24px; width: 100px;"><input name="notetitle" type="text" id="notetitle" /></td><td style="height: 24px; width: 61px;">留言者：</td><td style="height: 24px; width: 150px;"><input name="notewriter" type="text" id="notewriter" /></td><td></td></tr>
                     <tr><td style="width: 73px; height: 24px">留言时间从：</td><td style="height: 24px; width: 100px;"><input name="txtFDate" type="text" id="txtFDate" onfocus="setday(this)" /></td><td style="height: 24px; width: 61px;">到：</td><td style="height: 24px; width: 150px;"><input name="txtTDate" type="text" id="txtTDate" onfocus="setday(this)" /></td><td width="50">
                         <input type="submit" name="Button1" value="查询" id="Button1" /></td></tr>
                       </table></td></tr><tr><td style="height: 15px" >    	<TABLE style="WIDTH: 95%" cellSpacing="0" cellPadding="0" border="0">
								<TR>
									<TD style="HEIGHT: 426px" vAlign="top">
										<TABLE style="WIDTH: 100%" cellSpacing="0" cellPadding="0" border="0">
											<TR>
												<TD class="tttable">
                                                    留言列表(总条数：
													<span id="lblOnNum" class="tttable"><font color="Green">0</font></span>)
												</TD>
												
												<TD class="td" style="WIDTH: 80px"><A onclick="re()" href="#">
													</A>
                                                    </TD>
											</TR>
										</TABLE>
										<table class="GridBackColor" cellspacing="0" rules="all" bordercolor="#999999" border="1" id="dgdAcLoginInfo" height="23" width="500">
	<tr class="GridHeadBackColor">
		<td align="center" valign="middle" width="50"><a href="javascript:__doPostBack('dgdAcLoginInfo$_ctl2$_ctl0','')">留言号</a></td><td align="center" valign="middle" width="80"><a href="javascript:__doPostBack('dgdAcLoginInfo$_ctl2$_ctl1','')">留言主题</a></td><td align="center" valign="middle" width="80"><a href="javascript:__doPostBack('dgdAcLoginInfo$_ctl2$_ctl2','')">留言者</a></td><td nowrap="nowrap" align="center" valign="middle" width="90"><a href="javascript:__doPostBack('dgdAcLoginInfo$_ctl2$_ctl3','')">留言时间</a></td>
	</tr><tr>
		<td colspan="6"><span>1</span></td>
	</tr>
</table>
                                        </TD>
								</TR>
							</TABLE>   </td></tr></table></td></tr></table>
                </td></tr></table>
        </td></tr>
    <tr><td height="120">
        
<CENTER>
<TABLE id=AutoNumber1 style="BORDER-COLLAPSE: collapse" borderColor=#111111 
height=27 cellSpacing=0 cellPadding=0 width=960 bgColor=#ffffff border=0>
  <TBODY>
  <TR>
    <TD width="100%" height=1 valign="top">
      <TABLE id=AutoNumber2 style="BORDER-COLLAPSE: collapse" 
      borderColor=#111111 height=122 cellSpacing=0 cellPadding=0 width="100%" 
      border=0>
        <TBODY>
              
        <TR>
          <TD width="100%" bgColor=#f2fefc height=43>
            <P style="LINE-HEIGHT: 200%" align=center><FONT face=Verdana 
            size=2><span id="Bottom1_Label1">版权所有</span> &copy; 2007-2008 景德镇昌河中学  <span id="Bottom1_Label2">地址:江西景德镇朝阳路昌河教育园区&nbsp;  邮编:333000</span><BR></FONT><FONT face=Verdana><SPAN 
            style="FONT-SIZE: 10pt"><span id="Bottom1_Label3">电话:0798-8462558</span>| <a href="adminweb/adminlogin.aspx"><span id="Bottom1_Label6">后台管理登录</span></a></SPAN></FONT></P></TD></TR>
        
        <TR>
          <TD width="100%" bgColor=#f2fefc height=21>
            <P align=center><FONT face=Verdana size=2><span id="Bottom1_Label7">网址：</span><A 
            href=http://www.jdzch18.com/>http://www.jdzch18.com/</A>&nbsp; 
           <span id="Bottom1_Label9">电子邮件：</span><A 
          href="mailto:jdzch18@126.com">Jdzch18@126.com</A>&nbsp;黔ICP备07002724号</FONT></P></TD></TR>
        <TR>
          <TD width="100%" bgColor=#f2fefc height=23>
            <P style="LINE-HEIGHT: 200%" align=center><FONT face=Verdana 
            size=2><span id="Bottom1_Label10">制作维护：</span><A 
            href="http://www.pasp.cn/"><span id="Bottom1_Label11">瑞光软件</span></A></FONT></P></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></CENTER>

    </td></tr>
    </table>
    </form>
</body>
</html>
