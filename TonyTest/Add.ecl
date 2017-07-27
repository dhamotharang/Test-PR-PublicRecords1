/*--SOAP--
<message name="Addition" noWuAbort="0" wuTimeout="888">
  <part name="ValueA" type="xsd:integer" />
  <part name="ValueB" type="xsd:long" />
</message>
*/

/*--RESULT--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 	xmlns:xalan="http://xml.apache.org/xalan">
	<xsl:output method="html" version="1.0" encoding="utf-8" indent="yes"/>
	<xsl:template match="text()"/>
	<xsl:template match="//Results">
		<xsl:variable name="wuid" select="//Workunit[1]"/>
		<xsl:variable name="eclwatch" select="//EclWatch[1]"/>
		<html>
		  <head>
			  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<style type="text/css">
					div
					{
						visibility: hidden;
						position: absolute;
						left:0;
						top:0;
						width:400;
					}
				</style>

	            <script id="popup_labels" language="JavaScript1.2">0</script>
				<script language="JavaScript1.2">
					<xsl:text disable-output-escaping="yes">
						function clip(w)
						{
							var n=Number(String(w).match(/\d+/)[0]);    
							return n;
						}
			
						function resize_graph(width,height)
						{
							//alert('resize w:'+width +" h:"+height);
							var svg=document.all['SVGGraph'];
							if(!svg) return;
			
							var w=clip(width), h=clip(height);
							var ws=Math.min(16383,w), hs=Math.min(16383,h)
							svg.style.width=ws;
							svg.style.height=hs;
			
							var root=svg.getSVGDocument().rootElement;
							root.currentScale=Math.min(ws/w,hs/h);
						}
						
						function try_to_fit(iframe,w,h,xn1,yn1,xm1,ym1,xn2,yn2,xm2,ym2)
						{
							var x=0, y=0;
							if(w>=xm1-xn1)
								w=xm1-xn1-1;
							if(h>=ym1-yn1)
								h=ym1-yn1-1;
			
							if(xm1-xm2>w &amp;&amp; ym1-yn1>h)
							{
								x=xm2;
								y=Math.min(ym2,ym1-h);
							}
							else if(xm1-xn1>w &amp;&amp; ym1-ym2>h)
							{
								x=Math.min(xm2,xm1-w);
								y=ym2;
							}
							else if(xn2-xn1>w &amp;&amp; ym1-yn1>h)
							{
								x=xn2-w;
								y=Math.max(yn1,yn2-h);
							}
							else if(xm1-xn1>w &amp;&amp; yn2-yn1>h)
							{
								x=Math.max(xn2-w,xn1);
								y=yn2-h;
							}
							else return null;
			
							iframe.style.left=x;
							iframe.style.top=y;
							iframe.style.width=w-2;
							iframe.style.height=h-2;
							iframe.style.visibility='visible';
						}
			
						function show_popup(popup_id)
						{
							//alert("show_popup: " + popup_id);
							var frame=document.frames['popupFrame'];
							if(!frame) return;
								
							var iframe=document.all['popupFrame'];
							if(!iframe) return;
							//alert("popupFrame");
			
							var svg=document.all['SVGGraph'];
							if(!svg) return;
							//alert("SVGGraph");
			
							var o=svg.getSVGDocument().getElementById(popup_id);
							if(!o) return;
							var root=svg.getSVGDocument().rootElement, 
								scale=root.currentScale,
								shift=root.currentTranslate;
			
							var rect=o.getBBox();
							var x=rect.x*scale+shift.x, 
								y=rect.y*scale+shift.y,
								w=rect.width*scale,
								h=rect.height*scale;
			
							var div=document.all['popup_'+popup_id];
							if(!div) return;
							//alert("DIV");
							
							if(div.length)
								div = div[1];
			
							frame.document.body.innerHTML = div.outerHTML;
							var fdiv = frame.document.body.all.tags("DIV");
							if (!fdiv)
								alert("no fdiv");
							if (fdiv.length)
								fdiv=fdiv[0];
							//alert(fdiv.outerHTML);
							var tab=fdiv.children.tags("table");
							if (!tab)
								alert("no tab");
							
							if (tab.length)
							{
								for(indx = 0; indx &lt; tab.length; indx++)
								{
									tab[indx].style.backgroundColor = 'yellow';
									//tab[indx].style.margin = 0;
									//tab[indx].style.padding = 0;
									tab[indx].style.border = '2 solid black';
								}
								tab=tab[0];
							}
							else
							{
								tab.style.backgroundColor = 'yellow';
								//tab.style.margin = 0;
								//tab.style.padding = 0;
								tab.style.border = '2 solid black';
							}
			
							frame.document.body.style.margin=0;
							iframe.style.width=400;
			
							window.top.activepopup=popup_id;
			
							try_to_fit(iframe,tab.clientWidth+6,tab.clientHeight+6,
									   document.body.scrollLeft,document.body.scrollTop,document.body.scrollLeft+document.body.clientWidth,document.body.scrollTop+document.body.clientHeight,
									   svg.offsetLeft+x,svg.offsetTop+y,svg.offsetLeft+x+w,svg.offsetTop+y+h);
						}
			
						function hide_popup()
						{
							var iframe=document.all['popupFrame'];
							if(!iframe) return;
							iframe.style.visibility='hidden';
							iframe.style.height=1;
							iframe.style.width=1;
							
							if(window.top.activepopup)
								window.top.activepopup=null;
						}
					</xsl:text>
				</script>
			</head>
			<body>
				<b>
				<xsl:call-template name="id2string">
					<xsl:with-param name="toconvert" select="name(/*)"/>
				</xsl:call-template>
				</b>
				<br/><hr/>
				<xsl:if test="$wuid">
					Workunit ID: 
					<xsl:choose>
						<xsl:when test="$eclwatch">
							<a href="http://{$eclwatch}/WsWorkunits/WUInfo?Wuid={$wuid}"><b><xsl:value-of select="$wuid"/></b></a>
						</xsl:when>
						<xsl:otherwise>
							<b><xsl:value-of select="$wuid"/></b>
						</xsl:otherwise>
					</xsl:choose>
					<br/><br/>
				</xsl:if>
				<xsl:apply-templates select="//Exception"/>
				<xsl:apply-templates select="//Dataset"/>
				<xsl:apply-templates select="//Tracing"/>
				<xsl:apply-templates select="//SvgGraphs/SvgGraph[1]"/>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="Exception">
		<b>Exception</b><br/>
		Reported by: <xsl:value-of select="Source"/><br/>
        Message: <xsl:value-of select="Message"/><br/>
		<hr/><br/>
	</xsl:template>
  <xsl:template match="Tracing">
	    <html>
	        <head>
	                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	                <link REL="stylesheet" TYPE="text/css" HREF="/esp/files/default.css"/>
	        </head>
                <body>
                        <table border="1">
                                <xsl:for-each select="Log">
                                        <tr>
                                                <td><xsl:value-of select="."/></td>
                                        </tr>
                                </xsl:for-each>
                        </table>
                </body>
	     </html>
	</xsl:template>
	<xsl:template match="Row" mode="draw_heading">
			<tr>
				<td bgcolor="#0066CC">
					<font face="Verdana" size="2">&#160;</font>
				</td>
				<xsl:for-each select="*">
					<td align="center" bgcolor="#0066CC">
						<font face="Verdana" size="2" color="#DFEFFF">
							<b>
								<xsl:value-of select="name()"/>
							</b>
						</font>
					</td>
				</xsl:for-each>
			</tr>
	</xsl:template>
	<xsl:template match="Dataset">
		<xsl:if test="@name">
			<b>Dataset: </b><xsl:value-of select="@name"/><br/>
		</xsl:if>
		<table bordercolor="#0066CC" border="1" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<table border="1" bordercolor="#0066CC" cellspacing="0" cellpadding="0">
						<xsl:apply-templates select="Row[1]" mode="draw_heading"/>
						<xsl:for-each select="Row">
							<xsl:variable name="rowpos" select="position()"/>
								<tr>
									<td align="center" bgcolor="#0066CC">
										<font face="Verdana" size="2" color="#DFEFFF">
											<xsl:value-of select="position()"/>
										</font>
									</td>
									<xsl:for-each select="*">
										<td align="center" nowrap="nowrap">
											<xsl:attribute name="bgcolor">
												<xsl:call-template name="cellbgcolor">
													<xsl:with-param name="rpos" select="$rowpos"/>
												</xsl:call-template>
											</xsl:attribute>
											<font face="Verdana" size="2">
												<xsl:text>&#160;</xsl:text>
												<xsl:value-of select="."/>
											</font>
										</td>
									</xsl:for-each>
								</tr>
						</xsl:for-each>
					</table>
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="SvgGraph">
		<xsl:variable name="wuid" select="//Workunit[1]"/>
		<xsl:variable name="graphname" select="@name"/>
		<hr/>
		<b>Graph: </b><xsl:value-of select="@name"/><br/>
		<xsl:apply-templates select="//_Probe/Graph[@name=$graphname]/xgmml" mode="popups">
			<xsl:with-param name="graphname" select="$graphname"/>
		</xsl:apply-templates>
		<embed id="SVGGraph" width="1" height="1" src="/svg/files_/{@name}{@token}.svg?wuid={$wuid}" type="image/xml-svg" pluginspage="http://www.adobe.com/svg/viewer/install/"/>
        <iframe id="popupFrame" frameborder="0" scrolling="no" style="position:absolute;left:0;top:0;width:1;height:1;visibility:hidden" src='about:blank'/>
	</xsl:template>

	<xsl:template name="cellbgcolor">
		<xsl:param name="rpos"/>
		<xsl:if test="$rpos mod 2=0">
			<xsl:text>#DFEFFF</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xgmml" mode="popups">
		<xsl:param name="graphname"/>
		<xsl:apply-templates select="//node|//edge" mode="popups">
			<xsl:with-param name="graphname" select="$graphname"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="node" mode="popups">
		<xsl:param name="graphname"/>
	    <div id="popup_{@id}">
	        <table id="tab">
		        <colgroup>
		            <col align="left" valign="top"/>
		        </colgroup>
			<xsl:apply-templates select="att" mode="inner">
				<xsl:with-param name="parent" select="@id"/>
				<xsl:with-param name="graphname" select="$graphname"/>
			</xsl:apply-templates>
	        </table>
	    </div>
	</xsl:template>

	<xsl:template match="edge" mode="popups">
		<xsl:param name="graphname"/>
	    <div id="popup_{@id}">
	        <table id="tab">
		        <colgroup>
		            <col align="left" valign="top"/>
		        </colgroup>
			<xsl:apply-templates select="att" mode="inner">
				<xsl:with-param name="parent" select="@id"/>
				<xsl:with-param name="graphname" select="$graphname"/>
			</xsl:apply-templates>
			
	        </table>
	    </div>
	</xsl:template>

	<xsl:template match="att" mode="inner">
		<xsl:param name="parent"/>
		<xsl:param name="graphname"/>
		
	    <xsl:if test="not(starts-with(@name, '_'))">
			<tr>
				<th><xsl:value-of select="@name"/></th>
				<xsl:choose>
					<xsl:when test="@name='rowvalues'">
						<td>
							<xsl:apply-templates select="//rowvalues/Dataset[@parent=$parent]" mode="inner"/>
						</td>
					</xsl:when>
					<xsl:otherwise>
							<td><xsl:value-of select="@value"/></td>
					</xsl:otherwise>
				</xsl:choose>
			</tr>
		</xsl:if>
	</xsl:template>

	<xsl:template match="Dataset" mode="inner">
	    <table border="1">
	        <thead>
				<tr>
					<xsl:for-each select="Group[1]/Row[1]/*">
						<th>
							<xsl:value-of select="name()"/>
						</th>
					</xsl:for-each>
				</tr>
	        </thead>
	        <xsl:apply-templates select="Group" mode="inner"/>
	    </table>
	</xsl:template>
	
	<xsl:template match="Group" mode="inner">
	    <tbody>
	    <xsl:apply-templates select="Row" mode="inner"/>
	    </tbody>
	</xsl:template>
	
	<xsl:template match="Row" mode="inner">
	    <tr><xsl:apply-templates select="*" mode="inner"/></tr>
	</xsl:template>
	
	<xsl:template match="*" mode="inner">
		<td>
			<xsl:choose>
				<xsl:when test="string-length(.) &gt; 0">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>
	<xsl:template name="id2string">
		<xsl:param name="toconvert"/>
		<xsl:param name="hadcap" select="false"/>
		<xsl:if test="string-length($toconvert) > 0">
			<xsl:variable name="f" select="substring($toconvert, 1, 1)"/>
			<xsl:variable name="iscap" select="contains('ABCDEFGHIJKLMNOPQRSTUVWXYZ', $f)"/>
			<xsl:variable name="nextcap" select="contains('ABCDEFGHIJKLMNOPQRSTUVWXYZ', substring($toconvert, 2, 1))"/>
			<xsl:if test="$iscap and (($hadcap=false) or ($nextcap=false))">
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:value-of select="$f"/>
			<xsl:variable name="s" select="substring($toconvert, 2)"/>
			<xsl:call-template name="id2string">
				<xsl:with-param name="toconvert" select="$s"/>
				<xsl:with-param name="hadcap" select="$iscap"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template name="underscores2spaces">
		<xsl:param name="toconvert"/>
		<xsl:value-of select="translate($toconvert, '_', ' ')"/>
	</xsl:template>
</xsl:stylesheet>
*/

export Add() := macro

#option ('tonytest', 'aaaaa1');
#debug ('tonytest', 'aaaaa2');

integer a := 0 : stored('ValueA');
integer b := 0 : stored('ValueB');
integer c := a + b;

output(c, named('ADDED'));
output(c, named('SUMMER'));

endmacro;