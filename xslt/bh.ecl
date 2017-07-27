/*--HTML--
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:param name="url" select="'unknown'"/>
	<xsl:template match="text()"/>
	<xsl:template match="/EspWebForm">
		<xsl:variable name="attribute" select="//message[1]/@name"/>
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>WS-ECL <xsl:value-of select="//message[1]/@name" disable-output-escaping="yes"/> Form</title>
				<script language="JavaScript1.2">
					function show_hide(obj_name)
					{
						if (obj_name.style.display == 'block')
						{
							obj_name.style.display='none';
							return "&gt;&gt;";
						}
						else
						{
							obj_name.style.display='block';
							return "&lt;&lt;";
						}
					}
					function check_nulls()
					{
						<xsl:for-each select="/EspWebForm/message/part[@nullable='true']">
							if (document.all.namedItem('<xsl:value-of select="@name"/>_null').checked == true)
								document.all.namedItem('<xsl:value-of select="@name"/>').disabled=true;
							else
								document.all.namedItem('<xsl:value-of select="@name"/>').disabled=false;
						</xsl:for-each>
					}
				</script>
			</head>
			<body>
				<table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="#000000" height="108">
					<tr>
						<td width="24%" height="24" bgcolor="#000000">
							<img border="0" src="/esp/files_/logo.gif" width="258" height="108"/>
						</td>
					</tr>
					<tr>
						<td width="24%" height="24" bgcolor="#AA0000">
							<p align="center">
								<font color="#FFFFFF" size="5">
									Enterprise Services Platform<sup><font face="Verdana" size="2">TM</font></sup>
								</font>
								<font color="#FFFFFF">
									<xsl:if test="/EspWebForm/@version"><xsl:text>  [ </xsl:text><xsl:value-of select="/EspWebForm/@version"/><xsl:text> </xsl:text><xsl:value-of select="/EspWebForm/@mode"/><xsl:text>] </xsl:text></xsl:if>
								</font>
							</p>
						</td>
					</tr>
				</table>
				<br/><br/>
				<p align="center">
					<table cellSpacing="0" cellPadding="1" width="90%" bgColor="#666666" border="0">
						<tbody>
							<tr align="middle" bgColor="#666666">
								<td height="23">
									<p align="left">
										<font face="Verdana" color="#efefef">
											<b><xsl:value-of select="//message[1]/@name" disable-output-escaping="yes"/></b>
										</font>
									</p>
								</td>
							</tr>
							<tr bgColor="#ffcc66">
								<td height="3"/>
							</tr>
							<TR bgColor="#666666">
								<TABLE cellSpacing="0" width="90%" bgColor="#efefef" border="0">
									<TBODY>
										<TR>
											<TD vAlign="center" align="left">
												<p align="left">
													<br/><xsl:value-of select="/EspWebForm/Info" disable-output-escaping="yes"/><br/>
												</p>
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</TR>
							<TR bgColor="#666666">
								<TABLE cellSpacing="0" width="90%" bgColor="#efefef" border="0">
									<TBODY>
										<TR>
											<TD vAlign="center" align="left">
												<p align="left">
													<br/><xsl:value-of select="/EspWebForm/Help" disable-output-escaping="yes"/><br/>
												</p>
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</TR>
							<TR bgColor="#666666">
								<TABLE cellSpacing="0" width="90%" bgColor="#efefef" border="0">
									<TBODY>
										<TR>
											<TD vAlign="center" align="left">
												<xsl:call-template name="doForm"/>
											</TD>
										</TR>
									</TBODY>
								</TABLE>
							</TR>
						</tbody>
					</table>
				</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="doForm">
		<form name="wsecl_form" method="post" action="{$url}" onsubmit="check_nulls();">
			<xsl:if test="//part[@type='tns:RawDataFile']">
				<xsl:attribute name="enctype">multipart/form-data</xsl:attribute>
			</xsl:if>
			<p align="center">
			<br/>
			<table name="wsecl_form_t1" bordercolor="#666666" bgcolor="#ffcc66" border="1" cellspacing="0" cellpadding="2" width="100%">
				<tr>
					<td>
						<table name="wsecl_form_t2" bordercolor="#efefef" frame="below" border="1" cellpadding="2" bgcolor="#efefef" width="100%">
							<xsl:apply-templates select="//part"/>
							<tr>
								<td/>
								<td>
									<font face="Verdana" size="2">
										<input type="submit" value="Submit"/>
									</font>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<hr/>
										<input type="button" value="options &gt;&gt;" onclick="value = 'options ' + show_hide(option_span);"/>
										<span id="option_span"  style="display:none">
												<br/>
												<xsl:if test="/EspWebForm/Environment/EclQueues/Queue">
													<b>ECL Server Queue: </b><br/>
													<select name="queue_">
														<option value="default">default</option>
														<xsl:for-each select="/EspWebForm/Environment/EclQueues/Queue">
															<option value="{@name}"><xsl:value-of select="@name"/></option>
														</xsl:for-each>
													</select>
												<br/>
												<br/>
												</xsl:if>
												<xsl:if test="/EspWebForm/Environment/EclClusters/Cluster">
													<b>ECL Cluster: </b>
													<br/>
													<select name="cluster_">
														<option value="default">default</option>
														<xsl:for-each select="/EspWebForm/Environment/EclClusters/Cluster">
															<option value="{@name}"><xsl:value-of select="@name"/></option>
														</xsl:for-each>
													</select>
													<br/><br/>
												</xsl:if>
												<xsl:text> Limit Result Count to 100: </xsl:text>
												<input type="checkbox" name="limitResults_" checked="1" value="1"/><br/>
												<xsl:text>Include Graph: </xsl:text>
												<input type="checkbox" name="_Probe" value="1"/><br/>
												<xsl:text>Display output as XML: </xsl:text>
												<input type="checkbox" name="rawxml_"/><br/>
												<xsl:text>Fast Result Page: </xsl:text>
												<input type="checkbox" name="fast_display_"/><br/>
												
												<xsl:if test="/EspWebForm/@saveOption!=0">
													<xsl:text>Save Workunit: </xsl:text>
													<input type="checkbox" name="saveWorkunit_"/>
												</xsl:if>
										</span>
									<br/>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</p>
		</form>
	</xsl:template>
	<xsl:template name="null_btn">
		<xsl:if test="@nullable='1' or @nullable='true'">
			(<input type="checkbox" name="{@name}_null" onclick="make_null({@name}_null, {@name});">
				<xsl:if test="@null_default='1' or @null_default='true'"><xsl:attribute name="checked">1</xsl:attribute></xsl:if>
			 </input>null)
		</xsl:if>
	</xsl:template>
	<xsl:template name="nullable">
		<xsl:if test="@nullable='1' or @nullable='true'">
			<xsl:attribute name="onsubmit">
				make_null(<xsl:value-of select="@name"/>_null, <xsl:value-of select="@name"/>);
			</xsl:attribute>
		</xsl:if>
	</xsl:template>
	<xsl:template match="part">
		<tr>
			<xsl:choose>
				<xsl:when test="html">
					<xsl:copy-of select="html/*"/>
				</xsl:when>
				<xsl:otherwise>
					<td width="10%" valign="top">
						<font face="Verdana" size="2">
							<xsl:call-template name="id2string">
								<xsl:with-param name="toconvert" select="@name"/>
							</xsl:call-template>
							<xsl:text>:</xsl:text>
						</font>
					</td>
					<td>
						<font face="Verdana" size="2">
							<xsl:apply-templates select="." mode="Draw"/>
						</font>
					</td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
	<xsl:template match="part" mode="Draw">
		<xsl:choose>
			<xsl:when test="@rows|@cols">
				<xsl:call-template name="Draw_TextAreaControl"/>
			</xsl:when>
			<xsl:otherwise>
				<input type="text" name="{@name}">
					<xsl:call-template name="nullable"/>
				</input>
				<xsl:if test="@required='1'">*</xsl:if>
				<xsl:call-template name="null_btn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="part[@type='xsd:boolean']" mode="Draw">
		<input type="checkbox" name="{@name}"/><xsl:if test="@required='1'">*</xsl:if>
	</xsl:template>
	<xsl:template match="part[@type='xsd:string']" mode="Draw">
		<input type="text" name="{@name}">
			<xsl:call-template name="nullable"/>
		</input>
		<xsl:if test="@required='1'">*</xsl:if>
		<xsl:call-template name="null_btn"/>
	</xsl:template>
	<xsl:template match="part" mode="Draw_TextControl">
		<input type="text" name="{@name}">
			<xsl:call-template name="nullable"/>
		</input>
		<xsl:if test="@required='1'">*</xsl:if>
		<xsl:call-template name="null_btn"/>
	</xsl:template>
	<xsl:template match="part[@type='tns:RawDataFile']" mode="Draw">
		<input type="file" name="{@name}"/><xsl:if test="@required='1'">*</xsl:if>
	</xsl:template>
	<xsl:template match="part[@type='tns:EspStringArray']" mode="Draw">
		<xsl:call-template name="Draw_TextAreaControl">
			<xsl:with-param name="default-rows" select="'5'"/>
			<xsl:with-param name="default-cols" select="'25'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="part[@type='tns:EspIntArray']" mode="Draw">
		<xsl:call-template name="Draw_TextAreaControl">
			<xsl:with-param name="default-rows" select="'5'"/>
			<xsl:with-param name="default-cols" select="'25'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="part[@type='tns:XmlDataSet']" mode="Draw">
		<xsl:call-template name="Draw_TextAreaControl">
			<xsl:with-param name="default-rows" select="'5'"/>
			<xsl:with-param name="default-cols" select="'25'"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="Draw_TextAreaControl">
		<xsl:param name="default-rows" select="'15'"/>
		<xsl:param name="default-cols" select="'60'"/>
		<xsl:text disable-output-escaping="yes">&lt;textarea name="</xsl:text>
		<xsl:value-of select="@name"/>
		<xsl:choose>
			<xsl:when test="@rows">
				<xsl:text disable-output-escaping="yes">" rows="</xsl:text>
				<xsl:value-of select="@rows"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text disable-output-escaping="yes">" rows="</xsl:text>
				<xsl:value-of select="$default-rows"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="@cols">
				<xsl:text disable-output-escaping="yes">" cols="</xsl:text>
				<xsl:value-of select="@cols"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text disable-output-escaping="yes">" cols="</xsl:text>
				<xsl:value-of select="$default-cols"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text disable-output-escaping="yes">" &gt;&lt;/textarea&gt;</xsl:text>
		<xsl:if test="@required='1'">*</xsl:if>
	</xsl:template>
	<xsl:template match="part[@type='tns:CsvDataFile']" mode="Draw">
		<input type="file" name="{@name}"/><xsl:if test="@required='1'">*</xsl:if><br/>
		<input type="button" value="CSV Details &gt;&gt;" id="show_csv_details_{@name}" onclick="value = 'CSV Details ' + show_hide({@name}_span);"/>
		<font face="Verdana" size="2">
			<table frame="box" style="display:none" id="{@name}_span">
				<tr>
					<td><xsl:text>CSV Field Seperator(s):</xsl:text></td>
					<td><input type="text" name="csv_fldsep_{@name}"/></td>
				</tr>
				<tr>
					<td><xsl:text>CSV Row Seperator(s):</xsl:text></td>
					<td><input type="text" name="csv_rowsep_{@name}"/></td>
				</tr>
				<tr>
					<td><xsl:text>CSV Quote Character(s):</xsl:text></td>
					<td><input type="text" name="csv_quotechar_{@name}"/></td>
				</tr>
			</table>
		</font>
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

/*--RESULT--
<?xml version="1.0" ?>
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

				table.ResultTable
				{
					border: 1px #0066CC solid;
					margin-top:1em;
					margin-bottom: 1em;
				}

				caption.ResultCaption
				{
					font-family: "Verdana";
					font-size: small;
					text-align: left;
					white-space: nowrap;
				}

				tr.ResultRowEven
				{
					background-color:#DFEFFF;
				}

				tr.ResultRowOdd
				{
					background-color:transparent;
				}

				td, th
				{
					font-family: "Verdana";
					font-size:x-small;
					border:  1px #0066CC solid;
				}

				td.RowOrdinal
				{
					background-color:#0066CC;
				}

				th.ColumnHeader
				{
					background-color:#0066CC;
					font-weight:bold;
				}

				a.BDIDLink
				{
					text-decoration: underline;
					color: red;
				}

				a.flipper
				{
					font-weight: bold;
					text-decoration: none;
					color: black;
				}

				a.flipper:visited
				{
					text-decoration: none;
					color: black;
				}

				a.flipper:hover
				{
					text-decoration: none;
					color: yellow;
				}

			</style>

			<script language="JavaScript1.2">
				function ShowHideResult(node)
				{
					var tbody = node.parentElement.parentElement.parentElement.nextSibling;
					if (tbody.style.display != 'none')
					{
						tbody.style.display = 'none';
						node.innerText = '+';
					}
					else
					{
						tbody.style.display = 'block';
						node.innerText = '-';
					}
					
					return true;
				}
			</script>
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
				<form id="wsecl_form" method="post" action="/BUSINESS_HEADER/BH_DrilldownService">
					<input type="hidden" name="BDID" />
				</form>

				<script>
				 function GetDetails(bdid_val)
				{
				 wsecl_form[0].value= bdid_val;
				 wsecl_form.submit();
				}
				</script>
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

	<xsl:template match="Dataset">
		<table cellspacing="0" cellpadding="1" class="ResultTable">
		<xsl:if test="@name">
			<caption class="ResultCaption"><b>Dataset: </b>
				<xsl:call-template name="underscores2spaces">
					<xsl:with-param name="toconvert" select="@name" />
				</xsl:call-template>
			</caption>
		</xsl:if>
			<xsl:apply-templates select="Row[1]" mode="draw_heading"/>
                  <tbody>
			<xsl:for-each select="Row">
				<xsl:variable name="rowpos" select="position()"/>
				<tr>
					<xsl:attribute name="class">
						<xsl:call-template name="rowbgcolor">
							<xsl:with-param name="rpos" select="$rowpos"/>
						</xsl:call-template>
					</xsl:attribute>
					<td class="RowOrdinal">
						<xsl:value-of select="$rowpos"/>
					</td>
					<xsl:apply-templates select="*" mode="inner" />
				</tr>
			</xsl:for-each>
                  </tbody>
		</table>
	</xsl:template>

	<xsl:template match="Row" mode="draw_heading">
		<thead>
			<tr>
				<th class="ColumnHeader">
					<a href="javascript:void(0)" onclick="ShowHideResult(this)" class="flipper">-</a>
				</th>
				<xsl:for-each select="*">
					<th class="ColumnHeader">
						<xsl:value-of select="name()"/>
					</th>
				</xsl:for-each>
			</tr>
		</thead>
	</xsl:template>
	
	<xsl:template name="rowbgcolor">
		<xsl:param name="rpos"/>
		<xsl:choose>
			<xsl:when test="$rpos mod 2=0">
				<xsl:text>ResultRowEven</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>ResultRowOdd</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*" mode="inner">
		<td>
			<xsl:choose>
				<xsl:when test="name()='bdid'">
					<a class="BDIDLink">
						<xsl:attribute name="href">javascript:GetDetails(<xsl:value-of select="." />)</xsl:attribute>
						<xsl:call-template name="fix_empty_cell" />
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="fix_empty_cell" />
				</xsl:otherwise>
			</xsl:choose>
		</td>
	</xsl:template>

	<xsl:template name="fix_empty_cell">
		<xsl:choose>
			<xsl:when test="string-length(translate(., ' ', '')) &gt; 0">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
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