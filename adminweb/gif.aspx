<html>
    <head>
        <title>参数无效。</title>
        <style>
         body {font-family:"Verdana";font-weight:normal;font-size: .7em;color:black;} 
         p {font-family:"Verdana";font-weight:normal;color:black;margin-top: -5px}
         b {font-family:"Verdana";font-weight:bold;color:black;margin-top: -5px}
         H1 { font-family:"Verdana";font-weight:normal;font-size:18pt;color:red }
         H2 { font-family:"Verdana";font-weight:normal;font-size:14pt;color:maroon }
         pre {font-family:"Lucida Console";font-size: .9em}
         .marker {font-weight: bold; color: black;text-decoration: none;}
         .version {color: gray;}
         .error {margin-bottom: 10px;}
         .expandable { text-decoration:underline; font-weight:bold; color:navy; cursor:hand; }
        </style>
    </head>

    <body bgcolor="white">

            <span><H1>“/”应用程序中的服务器错误。<hr width=100% size=1 color=silver></H1>

            <h2> <i>参数无效。</i> </h2></span>

            <font face="Arial, Helvetica, Geneva, SunSans-Regular, sans-serif ">

            <b> 说明: </b>执行当前 Web 请求期间，出现未处理的异常。请检查堆栈跟踪信息，以了解有关该错误以及代码中导致错误的出处的详细信息。

            <br><br>

            <b> 异常详细信息: </b>System.ArgumentException: 参数无效。<br><br>

            <b>源错误:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

行 25:         Dim gheight As Integer = Int(Len(vnum) * 12.5)
行 26:         'gheight为图片宽度,根据字符长度自动更改图片宽度
<font color=red>行 27:         img = New Bitmap(gheight, 26)
</font>行 28:         g = Graphics.FromImage(img)
行 29:         g.FillRectangle(New SolidBrush(Color.SteelBlue), New Rectangle(0, 0, gheight, 26))</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <b> 源文件: </b> D:\www\web\jdzch18.com\www\adminweb\gif.aspx.vb<b> &nbsp;&nbsp; 行: </b> 27
            <br><br>

            <b>堆栈跟踪:</b> <br><br>

            <table width=100% bgcolor="#ffffcc">
               <tr>
                  <td>
                      <code><pre>

[ArgumentException: 参数无效。]
   System.Drawing.Bitmap..ctor(Int32 width, Int32 height, PixelFormat format) +1051733
   System.Drawing.Bitmap..ctor(Int32 width, Int32 height) +14
   gif.validatecode(Object vnum) in D:\www\web\jdzch18.com\www\adminweb\gif.aspx.vb:27
   gif.Page_Load(Object sender, EventArgs e) in D:\www\web\jdzch18.com\www\adminweb\gif.aspx.vb:19
   System.Web.UI.Control.OnLoad(EventArgs e) +99
   System.Web.UI.Control.LoadRecursive() +50
   System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) +627
</pre></code>

                  </td>
               </tr>
            </table>

            <br>

            <hr width=100% size=1 color=silver>

            <b>版本信息:</b>&nbsp;Microsoft .NET Framework 版本:2.0.50727.3662; ASP.NET 版本:2.0.50727.3668

            </font>

    </body>
</html>
<!-- 
[ArgumentException]: 参数无效。
   在 System.Drawing.Bitmap..ctor(Int32 width, Int32 height, PixelFormat format)
   在 System.Drawing.Bitmap..ctor(Int32 width, Int32 height)
   在 gif.validatecode(Object vnum) 位置 D:\www\web\jdzch18.com\www\adminweb\gif.aspx.vb:行号 27
   在 gif.Page_Load(Object sender, EventArgs e) 位置 D:\www\web\jdzch18.com\www\adminweb\gif.aspx.vb:行号 19
   在 System.Web.UI.Control.OnLoad(EventArgs e)
   在 System.Web.UI.Control.LoadRecursive()
   在 System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
[HttpUnhandledException]: 引发类型为“System.Web.HttpUnhandledException”的异常。
   在 System.Web.UI.Page.HandleError(Exception e)
   在 System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
   在 System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
   在 System.Web.UI.Page.ProcessRequest()
   在 System.Web.UI.Page.ProcessRequestWithNoAssert(HttpContext context)
   在 System.Web.UI.Page.ProcessRequest(HttpContext context)
   在 ASP.adminweb_gif_aspx.ProcessRequest(HttpContext context)
   在 System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()
   在 System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)
--><!-- 
此错误页可能包含敏感信息，因为 ASP.NET 通过 &lt;customErrors mode="Off"/&gt; 被配置为显示详细错误消息。请考虑在生产环境中使用 &lt;customErrors mode="On"/&gt; 或 &lt;customErrors mode="RemoteOnly"/&gt;。-->