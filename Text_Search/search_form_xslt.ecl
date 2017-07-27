/*--HTML--
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="url" select="'unknown'"/>
	<xsl:include href="/esp/xslt/lib.xslt"/>
	<xsl:template match="text()"/>
	<xsl:template match="/EspWebForm">
		<xsl:variable name="attribute" select="message/@name"/>
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>WS-ECL <xsl:value-of select="message/@name" disable-output-escaping="yes"/> Form</title>
				<script language="JavaScript1.2">
				    function show_xmlopts(obj_name)
				    {
						if (document.getElementById('selformat').value=='xml')
							obj_name.style.display='block';
						else
							obj_name.style.display='none';
					}
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
							show_xmlopts(document.getElementById('xmlopt_span'));
							return "&lt;&lt;";
						}
					}
					function make_null(check_null, obj_name)
					{
						if (obj_name.disabled)
						{
							obj_name.disabled = false;
							obj_name.value = "";
							check_null.value = false;
						}
						else
						{
							obj_name.disabled = true;
							obj_name.value = "null";
							check_null.value = true;
						}
					}
			</script>
			</head>
			<body>
				<xsl:if test="not(@noheader)">
					<table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="#000000" height="108">
						<tr>
							<td width="24%" height="24" bgcolor="#000000">
								<img border="0" src="/esp/files_/logo.gif" width="258" height="108"/>
							</td>
						</tr>
						<tr>
							<td width="24%" height="24" bgcolor="#AA0000">
								<p align="center">
									<font color="#FFFFFF" size="5">Enterprise Services Platform<sup>
											<font face="Verdana" size="2">TM</font>
										</sup>
									</font>
									<font color="#FFFFFF">
										<xsl:if test="/EspWebForm/@version">
											<xsl:text>  [ </xsl:text>
											<xsl:value-of select="/EspWebForm/@version"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="/EspWebForm/@mode"/>
											<xsl:text> xslt=default] </xsl:text>
										</xsl:if>
									</font>
								</p>
							</td>
						</tr>
					</table>
					<br/>
					<br/>
				</xsl:if>
				<p align="center">
					<table cellSpacing="0" cellPadding="1" width="90%" bgColor="#666666" border="0">
						<tbody>
							<tr align="middle" bgColor="#666666">
								<td height="23">
									<p align="left">
										<font face="Verdana" color="#efefef">
											<b>
												<xsl:value-of select="/EspWebForm/message/@name" disable-output-escaping="yes"/>
												<xsl:if test="/EspWebForm/message/@async=1">
													<xsl:text disable-output-escaping="no"> (Async)</xsl:text>
												</xsl:if>
											</b>
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
													<br/>
													<xsl:value-of select="/EspWebForm/Info" disable-output-escaping="yes"/>
													<br/>
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
													<br/>
													<xsl:value-of select="/EspWebForm/Help" disable-output-escaping="yes"/>
													<br/>
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
		<form name="input" method="post" action="{$url}">
			<xsl:if test="/EspWebForm/message/part[@type='tns:RawDataFile']">
				<xsl:attribute name="enctype">multipart/form-data</xsl:attribute>
			</xsl:if>
			<p align="center">
				<br/>
				<table bordercolor="#666666" bgcolor="#ffcc66" border="1" cellspacing="0" cellpadding="2" width="100%">
					<tr>
						<td>
							<table bordercolor="#efefef" frame="below" border="1" cellpadding="2" bgcolor="#efefef" width="100%">
								<xsl:apply-templates select="/EspWebForm/message/part"/>
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
										<input type="button" value="options &gt;&gt;" onclick="value = 'options ' + show_hide(document.getElementById('option_span'));"/>
										<span id="option_span" style="display:none">
											<br/>
											<xsl:choose>
												<xsl:when test="/EspWebForm/@mode='roxie'">
													Output: 
													<select id="selformat" name="format_" onChange="show_xmlopts(document.getElementById('xmlopt_span'))">
														<option value="generate_html">Generated HTML</option>
														<option value="fast_html">Fast HTML</option>
														<option value="xml">XML</option>
													</select>
													<br/>
													<span id="xmlopt_span" style="display:none">
														<xsl:text>No XML Schema: </xsl:text>
														<input type="checkbox" name="noschemas_"/>
														<xsl:text>Process OTX: </xsl:text>
														<input type="checkbox" name="inc_otx_" value="1"/>
													</span>
													<xsl:text>Include Graph: </xsl:text>
													<input type="checkbox" name="_Probe" value="1"/>
													<br/>
												</xsl:when>
												<xsl:when test="/EspWebForm/@mode='doxie'">
													<xsl:if test="/EspWebForm/Environment/EclQueues/Queue">
														<b>ECL Server Queue: </b>
														<br/>
														<select name="queue_">
															<option value="default">default</option>
															<xsl:for-each select="/EspWebForm/Environment/EclQueues/Queue">
																<option value="{@name}">
																	<xsl:value-of select="@name"/>
																</option>
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
																<option value="{@name}">
																	<xsl:value-of select="@name"/>
																</option>
															</xsl:for-each>
														</select>
														<br/>
														<br/>
													</xsl:if>
													Output: 
													<select id="selformat" name="format_" onChange="show_xmlopts(document.getElementById('xmlopt_span'))">
														<option value="generate_html">Generated HTML</option>
														<option value="fast_html">Fast HTML</option>
														<option value="xml">XML</option>
													</select>
													<br/>
													<span id="xmlopt_span" style="display:none">
														<xsl:text>No XML Schema: </xsl:text>
														<input type="checkbox" name="noschemas_"/>
														<xsl:text>Process OTX: </xsl:text>
														<input type="checkbox" name="inc_otx_" value="1"/>
													</span>
													<xsl:text> Limit Result Count to 100: </xsl:text>
													<input type="checkbox" name="limitResults_" checked="1" value="1"/>
													<br/>
													<xsl:if test="not(/EspWebForm/message/@async=1)">
														<xsl:text>Include Graph: </xsl:text>
														<input type="checkbox" name="_Probe" value="1"/>
														<xsl:if test="/EspWebForm/@saveOption!=0">
															<br/>
															<xsl:text>Save Workunit: </xsl:text>
															<input type="checkbox" name="saveWorkunit_"/>
														</xsl:if>
													</xsl:if>
												</xsl:when>
											</xsl:choose>
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
	<xsl:template name="nullable">
		<xsl:if test="@nullable='1' or @nullable='true'">
			(<input type="checkbox" name="{@name}_null" onclick="value=make_null({@name}_null, {@name});"/>null)
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
				<input type="text" name="{@name}"/>
				<xsl:if test="@required='1'">*</xsl:if>
				<xsl:call-template name="nullable"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="part[@type='xsd:boolean']" mode="Draw">
		<input type="checkbox" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
	</xsl:template>
	<xsl:template match="part" mode="Draw_TextControl">
		<input type="text" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
		<xsl:call-template name="nullable"/>
	</xsl:template>
	<xsl:template match="part[@type='tns:RawDataFile']" mode="Draw">
		<input type="file" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
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
		<input type="file" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
		<br/>
		<input type="button" value="CSV Details &gt;&gt;" id="show_csv_details_{@name}" onclick="value = 'CSV Details ' + show_hide({@name}_span);"/>
		<font face="Verdana" size="2">
			<table frame="box" style="display:none" id="{@name}_span">
				<tr>
					<td>
						<xsl:text>CSV Field Seperator(s):</xsl:text>
					</td>
					<td>
						<input type="text" name="csv_fldsep_{@name}"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>CSV Row Seperator(s):</xsl:text>
					</td>
					<td>
						<input type="text" name="csv_rowsep_{@name}"/>
					</td>
				</tr>
				<tr>
					<td>
						<xsl:text>CSV Quote Character(s):</xsl:text>
					</td>
					<td>
						<input type="text" name="csv_quotechar_{@name}"/>
					</td>
				</tr>
			</table>
		</font>
	</xsl:template>
</xsl:stylesheet>
*/
/*--INDEX--
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="url" select="'unknown'"/>
	<xsl:template match="text()"/>
	<xsl:template match="/EspModulesIndex">
		<xsl:variable name="not_forms_only" select="@mode='dev'"/>
		<xsl:variable name="no_header" select="@noheader"/>
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>WS-ECL Available Modules</title>
				<xsl:if test="$not_forms_only">
					<script language="JavaScript1.2">
						function show_hide(show)
						{
							<xsl:for-each select="//Module">
							<xsl:if test="not(@hasForms)">
									var <xsl:value-of select="Name"/> = document.getElementById('<xsl:value-of select="Name"/>');
									if (show)
										<xsl:value-of select="Name"/>.style.display='none';
									else
										<xsl:value-of select="Name"/>.style.display='block';
								</xsl:if>
						</xsl:for-each>
						}
					</script>
				</xsl:if>
			</head>
			<body>
				<xsl:if test="not(@noheader)">
					<table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="#000000" height="108">
						<tr>
							<td width="24%" height="24" bgcolor="#000000">
								<img border="0" src="/esp/files_/logo.gif" width="258" height="108"/>
							</td>
						</tr>
						<tr>
							<td width="24%" height="24" bgcolor="#AA0000">
								<p align="center">
									<font color="#FFFFFF" size="5">Enterprise Services Platform<sup>
											<font size="2">TM</font>
										</sup>
									</font>
									<font color="#FFFFFF">
										<xsl:if test="/EspModulesIndex/@version">
											<xsl:text>  [ </xsl:text>
											<xsl:value-of select="/EspModulesIndex/@version"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="/EspModulesIndex/@mode"/>
											<xsl:text>] </xsl:text>
										</xsl:if>
									</font>
								</p>
							</td>
						</tr>
					</table>
					<br/>
					<br/>
				</xsl:if>
				<p align="center">
					<table cellSpacing="0" cellPadding="1" width="90%" bgColor="#666666" border="0">
						<tbody>
							<tr align="middle" bgColor="#666666">
								<td height="23">
									<p align="left">
										<font color="#efefef">
											<b>WS-ECL Available Modules</b>
										</font>
									</p>
								</td>
							</tr>
							<tr bgColor="#ffcc66">
								<td height="3">
									<p align="left">
										<b/>
									</p>
								</td>
							</tr>
							<TR bgColor="#666666">
								<TABLE cellSpacing="0" width="90%" bgColor="#efefef" border="0">
									<TBODY>
										<xsl:for-each select="//Module">
											<TR>
												<xsl:if test="not(@hasForms)">
													<xsl:attribute name="id"><xsl:value-of select="Name"/></xsl:attribute>
													<xsl:attribute name="style">display: none</xsl:attribute>
												</xsl:if>
												<p align="left">
													<TD vAlign="top" align="left">
														<a>
															<xsl:attribute name="href"><xsl:value-of select="Path"/></xsl:attribute>
															<b>
																<xsl:value-of select="Name"/>
															</b>
														</a>
													</TD>
												</p>
											</TR>
										</xsl:for-each>
									</TBODY>
								</TABLE>
							</TR>
						</tbody>
					</table>
				</p>
				<xsl:if test="$not_forms_only">
					<form action="">
						<input type="checkbox" name="forms_only" checked="1" onclick="show_hide(forms_only.checked)"/> Only show modules containing forms
					</form>
				</xsl:if>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="/EspWebIndex">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>WS-ECL <xsl:value-of select="//EspWebIndex/@path" disable-output-escaping="yes"/> Module Index</title>
			</head>
			<body>
				<xsl:if test="not(@noheader)">
					<table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="#000000" height="108">
						<tr>
							<td width="24%" height="24" bgcolor="#000000">
								<img border="0" src="/esp/files_/logo.gif" width="258" height="108"/>
							</td>
						</tr>
						<tr>
							<td width="24%" height="24" bgcolor="#AA0000">
								<p align="center">
									<font color="#FFFFFF" size="5">Enterprise Services Platform<sup>
											<font size="2">TM</font>
										</sup>
									</font>
									<font color="#FFFFFF">
										<xsl:if test="/EspWebIndex/@version">
											<xsl:text>  [ </xsl:text>
											<xsl:value-of select="/EspWebIndex/@version"/>
											<xsl:text> </xsl:text>
											<xsl:value-of select="/EspWebIndex/@mode"/>
											<xsl:text>] </xsl:text>
										</xsl:if>
									</font>
								</p>
							</td>
						</tr>
					</table>
					<br/>
					<br/>
				</xsl:if>
				<p align="center">
					<table cellSpacing="0" cellPadding="1" width="90%" bgColor="#666666" border="0">
						<tbody>
							<tr align="middle" bgColor="#666666">
								<td height="23">
									<p align="left">
										<font color="#efefef">
											<b>
												<xsl:value-of select="//EspWebIndex/@path" disable-output-escaping="yes"/> Module Index</b>
										</font>
									</p>
								</td>
							</tr>
							<tr bgColor="#ffcc66">
								<td height="3">
									<p align="left">
										<b/>
									</p>
								</td>
							</tr>
							<TR bgColor="#666666">
								<TABLE cellSpacing="0" width="90%" bgColor="#efefef" border="0">
									<TBODY>
										<xsl:apply-templates select="//Service">
											<xsl:sort select="translate(Name,'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
										</xsl:apply-templates>
									</TBODY>
								</TABLE>
							</TR>
						</tbody>
					</table>
				</p>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="Service">
		<TR>
			<p align="left">
				<TD vAlign="top" align="left">
					<a>
						<xsl:attribute name="href"><xsl:value-of select="Path"/></xsl:attribute>
						<b>
							<xsl:value-of select="Name"/>
						</b>
					</a>
				</TD>
				<td>
					<xsl:value-of select="Info" disable-output-escaping="yes"/>
				</td>
			</p>
		</TR>
	</xsl:template>
</xsl:stylesheet>
*/
/*--RESULT--
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="url" select="'unknown'"/>
	<xsl:param name="rowStart" select="0"/>
	<xsl:param name="rowCount"/>
	<xsl:param name="rowTotal"/>
	
	<xsl:include href="/esp/xslt/result_lib.xslt"/>
	
	<xsl:variable name="async" select="/child::node()/Async"/>
	<xsl:variable name="wuid" select="/child::node()/Workunit"/>
	<xsl:variable name="eclwatch" select="/child::node()/EclWatch"/>
			
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<link REL="stylesheet" TYPE="text/css" HREF="/esp/files/default.css"/>
			</head>
			<body>
				<b>
					<xsl:call-template name="id2string">
						<xsl:with-param name="toconvert" select="name(/*)"/>
					</xsl:call-template>
				</b>
				<br/>
				<xsl:if test="$async">
					<b>Query was run asynchronusly</b>
					<br/>
				</xsl:if>
				<xsl:if test="$wuid">
					Workunit ID: 
					<xsl:choose>
						<xsl:when test="$eclwatch">
							<xsl:choose>
								<xsl:when test="starts-with($eclwatch, 'http')">
									<a href="{$eclwatch}/WsWorkunits/WUInfo?Wuid={$wuid}">
										<b>
											<xsl:value-of select="$wuid"/>
										</b>
									</a>
								</xsl:when>
								<xsl:otherwise>
									<a href="http://{$eclwatch}/WsWorkunits/WUInfo?Wuid={$wuid}">
										<b>
											<xsl:value-of select="$wuid"/>
										</b>
									</a>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<b>
								<xsl:value-of select="$wuid"/>
							</b>
						</xsl:otherwise>
					</xsl:choose>
					<br/>
					<br/>
				</xsl:if>
				<xsl:apply-templates select="/child::node()/Results"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="Results">
		<xsl:apply-templates select="Exception"/>
		<xsl:apply-templates select="Result">
			<xsl:with-param name="wsecl" select="true()"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="Exception">
		<b>Exception</b>
		<br/>
		Reported by: <xsl:value-of select="Source"/>
		<br/>
     Message: <xsl:value-of select="Message"/>
	</xsl:template>
</xsl:stylesheet>
*/
/*--ERROR--
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml"/>
	<xsl:param name="url" select="'unknown'"/>
	<xsl:template match="text()"/>
	<xsl:template match="/">
		<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>WS-ECL Error</title>
			</head>
			<body>
				<xsl:choose>
					<xsl:when test="/EspWebError">
						<xsl:for-each select="/EspWebError">
							<xsl:if test="@module">
								<b>Module: <xsl:value-of select="@module"/></b><br/>
							</xsl:if>
							<xsl:if test="@service">
								<b>Attribute: <xsl:value-of select="@service"/></b><br/>
							</xsl:if>
							<xsl:for-each select="Exception">
								<p align="left">
								Exception: [in <xsl:value-of select="Source"/>] <xsl:value-of select="Message"/><br/>
								</p>
							</xsl:for-each>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						Unknown Error - Unable to display error information
					</xsl:otherwise>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
*/
export search_form_xslt := 1;