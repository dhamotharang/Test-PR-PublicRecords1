/*--HTML--
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
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
					

function get_Array_Input(parentId,typeName,itemName) 
{
		var newId = parentId + "." + typeName; 
		<![CDATA[ return "<span id='"+parentId+".$Span'>"
		 + "<table id='"+newId+"'> </table></hr>"
		 + "<input type='hidden' id='"+newId+"_ItemCt' name='"+newId+".itemcount' value='0' />"
		 + "&nbsp;<input type='button' id='"+newId+"' onclick='appendRow(\""+newId+"\",\""+itemName+"\",get_"+typeName+"_Item)' value='Add' /> "
		 + "<input type='button' id='"+newId+"_RvItem' onclick='removeRow(\""+newId+"\",-1)' value='Delete' disabled='true' />" 
		 + "</hr>"
		 + "</span>"; ]]>
}


function enableButton(tableId)
{
	var table = document.getElementById(tableId);
	var b = document.getElementById(tableId+"_RvItem");
	b.disabled = (table.rows.length==0);
}

function removeRow(tableId)
{
	var table = document.getElementById(tableId);
	table.deleteRow(-1);
	enableButton(tableId);
	document.getElementById(tableId+'_ItemCt').value = table.rows.length;
}

function appendRow(tableId, itemName, htmlContent)
{
	var table = document.getElementById(tableId);
	var x=table.insertRow(-1);
	var idx = x.rowIndex;
	var oldContent = htmlContent(tableId,idx);
   
	var r2=x.insertCell(0);
	r2.innerHTML = itemName + "[" + (idx + 1) + "]:";

	var r3=x.insertCell(1);
	r3.innerHTML = oldContent; 

	enableButton(tableId);
	document.getElementById(tableId+'_ItemCt').value = table.rows.length;
}
function onSubmit()
{
	var ctrls = document.forms["input"].elements;	
	for (var idx=0; idx &lt; ctrls.length; idx++)
  {
			var item = ctrls[idx];
			if (item.type != "hidden" || item.id[0]!='_' || item.id[1]!='_')
				continue;
				
			var arrayName = item.id.substr(2);
			//alert("Array found: id=" + item.id + ", name=" + item.name);
			
			// construct value
			var count = document.getElementById(arrayName+"_ItemCt").value;
			//alert("Table rows: " + count);
			
			if (count>0)
			{
			   var ds = "&lt;dataset&gt;";
			   for (var row=0; row &lt; count; row++)
				 {
				    ds += "&lt;row&gt;";
						for (var f=0; ; f++)
						{
						    var c = document.getElementById(arrayName+'.'+row+'.'+f);
								if (!c) break;
								if (c.value)
									ds += "&lt;"+c.name+"&gt;"+c.value+"&lt;/"+c.name+"&gt;";
			      }
						ds += "&lt;/row&gt;";
				  }    
					ds += "&lt;/dataset&gt;";
			
			    // set value
					// alert("Dataset: " + ds);
			    item.value = ds;
			}
	 }
}

<xsl:call-template name="GenerateArrayFunctions"/>
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
								<tr>
									<td/>
									<td>
										<font face="Verdana" size="2">
											<input type="submit" value="Submit" onclick="onSubmit()"/>&#160;<input type="reset" value="Clear"/>
										</font>
									</td>
								</tr>
								<xsl:apply-templates select="/EspWebForm/message/part"/>
								<tr>
									<td/>
									<td>
										<font face="Verdana" size="2">
											<input type="submit" value="Submit" onclick="onSubmit()"/>&#160;<input type="reset" value="Clear"/>
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
	<xsl:template match="part[@type='xs:boolean']" mode="Draw">
		<input type="checkbox" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
	</xsl:template>
	<xsl:template match="part[@type='xs:string']" mode="Draw">
		<input type="text" name="{@name}"/>
		<xsl:if test="@required='1'">*</xsl:if>
		<xsl:call-template name="nullable"/>
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
  
	<!-- Improve UI using Schema if possible -->
	<xsl:template match="part[@type='tns:XmlDataSet']" mode="Draw">
	  <xsl:variable name="schema" select="/EspWebForm/DatasetSchema"/>
		<xsl:variable name="name" select="@name"/>
	  <xsl:choose>
	   <xsl:when test="$schema/schema[@name=$name]">
		   <input type="hidden" name="{@name}" id="{concat('__',@name)}"/>
		   <xsl:call-template name="GetArrayUIHtml">
			   <xsl:with-param name="parentId" select="''"/>
				 <xsl:with-param name="typeName" select="@name"/>
				 <xsl:with-param name="itemName" select="'Row'"/>
			 </xsl:call-template> 
		 </xsl:when>
		 <xsl:otherwise>
			<xsl:call-template name="Draw_TextAreaControl">
				<xsl:with-param name="default-rows" select="'5'"/>
				<xsl:with-param name="default-cols" select="'25'"/>
			</xsl:call-template>
		 </xsl:otherwise>
	  </xsl:choose>	
	</xsl:template>
	
	<!-- Textarea -->
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
	
 <!-- ================================================================================
          generate javascript functions 
  ================================================================================ -->
	<xsl:template name="GenerateArrayFunctions">
	   <xsl:variable name="root" select="/EspWebForm/DatasetSchema"/>
	   <xsl:for-each select="/EspWebForm/DatasetSchema/schema">
        <xsl:call-template name="GenerateFuncFromSchema"> 
				    <xsl:with-param name="node" select="."/>
				</xsl:call-template>
		 </xsl:for-each>			
	</xsl:template>

  <xsl:template name="GenerateFuncFromSchema">
	  <xsl:param name="node"/>
		<xsl:variable name="html">
	   <xsl:variable name="ds" select="$node/xs:schema/xs:element[@name='Dataset']"/> 
		  <xsl:choose>
			  <xsl:when test="$ds">
				  <xsl:text><![CDATA[<table style='border-bottom: thin solid gray; border-left: thin solid gray;'>]]></xsl:text>
                            <xsl:variable name="cpxType" select="$ds/xs:complexType/xs:sequence/xs:element[@name='Row']/xs:complexType" />
				  <xsl:call-template name="doComplexType">
					  <xsl:with-param name="nodes" select="$cpxType/xs:all/xs:element | $cpxType/xs:sequence/xs:element"/>
						<xsl:with-param name="firstIndex" select="0"/>
						<xsl:with-param name="parentId" select="''"/>
					</xsl:call-template>
					<xsl:text><![CDATA[</table>]]></xsl:text>
				</xsl:when>
				<xsl:otherwise>
				  <xsl:text>TODO: Controls for </xsl:text>
					<xsl:value-of select="$node/@name"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
	function get_<xsl:value-of select="$node/@name"/>_Item(parentId,itemIndex) {
    return &quot;<xsl:value-of select="$html"/>&quot;;
  }
	</xsl:template>
	
	<xsl:template name="doComplexType">
	  <xsl:param name="nodes"/>		 
    <xsl:param name="parentId" />
		<xsl:param name="firstIndex" />
    <xsl:if test="$nodes">
			<xsl:variable name="first">
				<xsl:variable name="fieldName" select="$nodes[1]/@name"/>
				<xsl:variable name="type" select="$nodes[1]/@type"/>
				<xsl:text><![CDATA[ <tr><td>]]></xsl:text>
				<xsl:call-template name="id2string">
				   <xsl:with-param name="toconvert" select="$fieldName"/>
				</xsl:call-template>
				<xsl:text><![CDATA[:</td><td>]]></xsl:text>
				<xsl:choose>
					<xsl:when test="$type='xsd:string'">
						<xsl:text><![CDATA[<input type='text' name=']]></xsl:text>
						<xsl:value-of select="$fieldName"/>
						<xsl:text><![CDATA[' id='"+parentId+"."+itemIndex+".]]></xsl:text>
					  <xsl:value-of select="$firstIndex"/>
						<xsl:text><![CDATA[' size='20'/>]]></xsl:text>
					</xsl:when>
					<xsl:when test="starts-with($type,'string')">
						<xsl:variable name="size" select="substring($type,7)"/>
						<xsl:text><![CDATA[<input type='text' name=']]></xsl:text>
						<xsl:value-of select="$fieldName"/>
						<xsl:text><![CDATA[' id='"+parentId+"."+itemIndex+".]]></xsl:text>
					  <xsl:value-of select="$firstIndex"/>
						<xsl:text><![CDATA[' size=']]></xsl:text>
						<xsl:value-of select="$size"/>
						<xsl:text><![CDATA[' maxlength=']]></xsl:text>
						<xsl:value-of select="$size"/>
						<xsl:text><![CDATA['/>]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
					  <xsl:text>Unhandled type: </xsl:text><xsl:value-of select="$type"/> 
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text><![CDATA[</td></tr>]]></xsl:text>
			</xsl:variable>
			<xsl:variable name="rest">
          <xsl:if test="count($nodes) &gt; 1">
            <xsl:call-template name="doComplexType">
              <xsl:with-param name="nodes" select="$nodes[position()!=1]" />
              <xsl:with-param name="parentId" select="$parentId" />
							<xsl:with-param name="firstIndex" select="$firstIndex+1"/>
            </xsl:call-template>
          </xsl:if>
      </xsl:variable>
			<xsl:value-of select="concat($first,$rest)" />
   </xsl:if>
	</xsl:template>
	
  <xsl:template name="MakeId">
    <xsl:param name="parentId" />
    <xsl:param name="fieldName" />
    <xsl:choose>
      <xsl:when test="$parentId">
        <xsl:value-of select="concat($parentId,'.',$fieldName)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$fieldName" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="GetArrayUIHtml">
	  <xsl:param name="parentId"/>
		<xsl:param name="typeName"/>
		<xsl:param name="itemName"/>

		<xsl:variable name="newId">
		 <xsl:call-template name="MakeId">
		   <xsl:with-param name="parentId" select="$parentId"/>
			 <xsl:with-param name="fieldName" select="$typeName"/>
		 </xsl:call-template>
		</xsl:variable>
		
	  <xsl:variable name="html">	  
			<xsl:text><![CDATA[<span id=']]></xsl:text>
			<xsl:value-of select="$parentId"/>
			<xsl:text><![CDATA[.$Span'><table id=']]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA['> </table></hr><input type='hidden' id=']]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[_ItemCt' name=']]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[.itemcount' value='0' />&nbsp;<input type='button' id=']]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[' onclick='appendRow("]]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[","]]></xsl:text>
			<xsl:value-of select="$itemName"/>
			<xsl:text><![CDATA[",get_]]></xsl:text>
			<xsl:value-of select="$typeName"/>
			<xsl:text><![CDATA[_Item)' value='Add' /> <input type='button' id=']]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[_RvItem' onclick='removeRow("]]></xsl:text>
			<xsl:value-of select="$newId"/>
			<xsl:text><![CDATA[",-1)' value='Delete' disabled='true' /></hr></span>]]></xsl:text>	
	  </xsl:variable>
		<xsl:value-of disable-output-escaping="yes" select="$html"/>
  </xsl:template>						 
	 						 
</xsl:stylesheet>
*/
