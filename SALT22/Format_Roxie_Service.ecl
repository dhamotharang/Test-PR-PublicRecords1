/*2010-03-17T20:37:37Z (Salini Pamidimukkala)
added automatic pull of service names
*/
/*--RESULT--
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="//Results/Result">
  <html>
	<!-- META DATA - STYLE DETAILS-->
	<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>WS-ECL Result</title>
	<style type="text/css">body { background-color: #white;}
	table { border-collapse: collapse; border: double solid #0066CC;
	font: 10pt arial, helvetica, sans-serif; }table th { border: 2 solid #0066CC;
	background-color: #DFEFFF;}table td { border: 2 solid #0066CC; text-align:center;}
	.blue { background-color: #DFEFFF; }
	a:active { color:#0000DD;}</style>
<script type="text/javascript">
<![CDATA[
var tb_ref = new Array();
var tb_ref_cnt =0;
var strCopy ;
var cell_cnt ;
//highlights row in left mouse click
function HighLightTR(el)
{	
     var cell_cnt,sep;
		 if (event.button==1) //LEFT CLICK
		 {
      if(el.bgColor == '#C0C0C0' || el.bgColor == '#c0c0c0')
			{
			  el.bgColor = '#FFFFFF';
			}
			else if (el.bgColor=='#99CCFF' || el.bgColor=='#99ccff')
			{
				  el.bgColor = '#99CCFF';
			}
			else
			{
			   el.bgColor = '#C0C0C0';
				 cell_cnt  = el.cells.length;
			}
     }
}
//highlight the cell contents on right click
function HighLightTD(el)
{
 if (event.button==2) //RIGHT CLICK
 {
	 var fnd_pos = -1;
	 var prv_cell_id ;
	 var prv_cell_pos= new Array();
	 var cur_cell_id;
	 var cur_cell_pos= new Array();
	 
   for (var i = 0; i < tb_ref.length; i++) 
	 {
	   prv_cell_id = tb_ref[i];
	 	 prv_cell_pos = prv_cell_id.split('_');
	   
		 cur_cell_id = el.id;
	 	 cur_cell_pos = cur_cell_id.split('_');
		 
		 var prv_len = prv_cell_pos.length-1;
		 var cur_len = cur_cell_pos.length-1;
		 
		 if(prv_cell_pos[prv_len]==cur_cell_pos[cur_len])
		 {
		     fnd_pos =fnd_pos+i+1;
		 }
		} 
		 if(fnd_pos>=0)
		 {
		   if(tb_ref[fnd_pos] ==el.id)
			 {
          			 
			    el.style.fontWeight='normal';
	        el.style.textDecoration = 'none';
					tb_ref[fnd_pos] ='0';
			 }
			 else
			 {
			 var cell_id = tb_ref[fnd_pos];
			 var prev_cell = document.getElementById(cell_id);
			 prev_cell.style.fontWeight='normal';
	     prev_cell.style.textDecoration = 'none';			 
		   el.style.fontWeight='bold';
	     el.style.textDecoration = 'underline';			 
		   tb_ref[fnd_pos]=el.id;
			 }
       fnd_pos =-1;
		 }
		 else
		 {
		   // alert(el.id);
			 tb_ref[tb_ref_cnt] = new Array();
		 	 tb_ref[tb_ref_cnt] = el.id;
			 tb_ref_cnt++;
       el.style.fontWeight='bold';
	     el.style.textDecoration = 'underline';		 			 
	     
		 }
  }		 
}
//export html into excel
function TableToExcel()
{
  	this.document.execCommand("SelectAll", false);
		this.document.execCommand("Copy", true); 
		this.document.execCommand("UnSelect", false);
		var oXL = new ActiveXObject("Excel.Application"); 
		var oWB = oXL.Workbooks.Add(); 
		var oSheet = oWB.ActiveSheet; 
		oSheet.Paste(); 
		oXL.Visible = true;
		oXL.UserControl = true;
}
//on request makes a new call to service
function SearchQuery()
{
   var def_search_str = document.location.href;
   var search_str;
 
	 if(document.getElementById('Service_NamesList').selectedIndex==0)
	 {
	    search_str = def_search_str;
	 }
	 else
	 {
	    var sn = document.getElementById('Service_NamesList');
			
		 	search_str = sn.options[sn.selectedIndex].value
	 }
   var tb_size = tb_ref.length;
   for (var i = 0; i < tb_size; i++) 
   	 {
   	     if(!(tb_ref[i]=='0'))
   			 {	
   			    var cell_id = tb_ref[i];
   					var item = document.getElementById(cell_id);
   					var sep ='';
 						sep ='&amp;';
						var str  = sep+item.className+'='+item.innerText;
   					search_str = search_str+str;
   			 }
      }
 
 window.open(search_str);	
	 
}
//determines the services in the roxie
function Append_ServiceName()
{
  //getting config info
	var alias_loc ;
	var loc_url = parent.location.href.split('/')
	var config_URL = loc_url[0]+'//'+loc_url[2]+"/main/?config_&inner=../main/?config_";
	var xmlDoc=new ActiveXObject("MSXML2.DOMDocument");
	xmlDoc.async="false";
	xmlDoc.load(config_URL);
	
	//building 8050 port address
  var items = xmlDoc.getElementsByTagName("EspBinding");
	var url_parts = new Array();
	for (var i=0,c;c=items[i];i++) 
	{
	  if(c.getAttribute("defaultBinding")=="true")
		{
			var str12 = document.location.protocol+'//'+document.location.host;
			var cur_port = document.location.port;
			var node_port = c.getAttribute("port");
			if(node_port.substring(2)=='5'+cur_port.substring(3))
			{
			alias_loc = str12.substring(0,str12.length-5)+':'+c.getAttribute("port");
			}
		}
	}
    	 
	 //getting service names
	 var orequest;
	 if (window.XMLhttprequest)
		{
		orequest = new XMLhttprequest();
		}
		else
		{
    orequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
   var sURL = alias_loc+"/ws_roxieconfig/ListDeployedAliases";
   orequest.open("GET",sURL,false);
	 orequest.setrequestHeader("Content-Type", "text/xml");
   orequest.send(null);
	
	  //Parsing HTML for service names
	  var root = document.createElement("div");
		root.innerHTML = orequest.responseText;
		var list = document.getElementById('Service_NamesList');
	  for (var i=0,c;c=root.childNodes[i];i++) 
	  {
	       if(c.tagName=='xml' && c.id=='xmlPrevArgsDoc')
				 {
				        var xml_list = c.firstChild.firstChild;
							  for (var i1=0,xl;xl=xml_list.childNodes[i1];i1++) 
	             {
							    var op_text = xl.firstChild.text;
									var dir  = op_text.split('.')[0];
							    var op_val = parent.location.href+dir+'/'+op_text+'/?';
									list.options[list.options.length]=new Option(op_text, op_val, false, false);
							 }
				 }
	  }
}
]]>		
	</script>
	</head>
	
	<body onload="Append_ServiceName()">
	<!--onClick="SearchQuery();"-->
	<div id="navigation_section">
	<table id="navigation_content" >
	<tr>
	<td><i><a onClick="TableToExcel();" id="Import_Data" href="#">Download .xls</a></i></td>
	<td><button onClick="SearchQuery();" id="Search_HyperLink">SEARCH QUERY</button></td>
	<td>
	<select id="Service_NamesList">
		<option>Select the Service Name</option>
  </select>
	</td>
	</tr>
	</table>
	</div>
	<br/>
	<!--FOR EVERY ROW IN DATASET-->	
	<xsl:for-each select="Dataset">
	<xsl:variable name="table_id">
		 <xsl:value-of select ="concat('table_',position())"/>
	</xsl:variable>
	<table border="1" cellspacing="0" cellpadding="2" oncontextmenu="return false;">
	<xsl:attribute name="id"><xsl:value-of select="$table_id"/></xsl:attribute>
	<xsl:for-each select="Row">	
		        <!-- LOGIC TO COMPARE PREVIOUS AND CURRENT DID-->
		        <xsl:variable name="pos">
							 <xsl:value-of select ="position()-1"/>
						</xsl:variable>
	            <xsl:variable name="prev_did">
							   <xsl:value-of select ="../Row[position()=$pos]/did"/>
							</xsl:variable>
	            <xsl:variable name="cur_did">
							   <xsl:value-of select ="did"/>
							</xsl:variable>
								<xsl:variable name="ndids">
								  <xsl:if test="$prev_did!=$cur_did">
								   <xsl:value-of select ="1"/>
							    </xsl:if>
									<xsl:if test="$prev_did=$cur_did">
								   <xsl:value-of select ="0"/>
							    </xsl:if>
								</xsl:variable>		
							
							<!-- WRITING TABLE HEADER-->
              <xsl:if test="position()=1"> 
							 <xsl:for-each select="*">
									<th>
										<font color ="#000000"> 
                    <b><xsl:value-of select="name()"/></b>
										</font>
									</th>
								</xsl:for-each>
							</xsl:if>
 							
	          
						<!-- WRITING DATA ROWS-->
						<tr onMouseDown="HighLightTR(this);">
						<xsl:variable name="tr_pos">
							 <xsl:value-of select ="position()"/>
						</xsl:variable>
						<xsl:attribute name="id"> <xsl:value-of select ="concat('row_',$tr_pos)"/></xsl:attribute>
						
						    <xsl:for-each select="*"> 
                		<xsl:variable name="cell_id">
							         <xsl:value-of select ="concat('cell_',$tr_pos,'_',position())"/>
						        </xsl:variable>
								<td valign="top" style="border-width: 1px;" onMouseDown="HighLightTD(this);">  
								
								<xsl:attribute name="id"> <xsl:value-of select ="$cell_id"/></xsl:attribute>
								<xsl:attribute name="class"> <xsl:value-of select ="name()"/></xsl:attribute>
								<xsl:if test ="$ndids mod 2 = 1">
								    <xsl:attribute name="bgcolor">#99CCFF</xsl:attribute>
								</xsl:if>
								<xsl:choose>
								     <xsl:when test="contains(name(),'match,score,weight')">		     
													<xsl:value-of select="."/>			
									   </xsl:when>
										 <!-- LOGIC TO HIGHLIGHT SCORED FIELDS -->
										 <xsl:otherwise>
								        <xsl:variable name="match" select="'match'"/>		     
								        <xsl:variable name="match1" select="'score'"/>		     
								        <xsl:variable name="match2" select="'weight'"/>		     
										     <xsl:variable name="fname" select="name()"/>
												 <xsl:variable name="bg_score" >
												   	<xsl:value-of select="../*[(contains(name(),$match) or contains(name(),$match1) or contains(name(),$match2)) and contains(name(),$fname)]"/>
                         </xsl:variable>
												 <xsl:if test="$bg_score=-1">
														 <xsl:attribute name="bgcolor">#FFFF00</xsl:attribute>
												 </xsl:if>
												<!-- adding hyeperlink colors-->
												<a>
													<xsl:call-template name='link_Color'>
												        <xsl:with-param name="score" >
												   	    	<xsl:value-of select="$bg_score"/>
                                </xsl:with-param>		
																<xsl:with-param name="field_name" >
												   	    <xsl:value-of select="name()"/>
                                </xsl:with-param>														 
													</xsl:call-template>
											 <xsl:value-of select="."/>
												 </a> 
													
								     </xsl:otherwise>
									 </xsl:choose>	 
  							</td>
							</xsl:for-each>
						</tr>
  </xsl:for-each>								
  </table>
	</xsl:for-each>		
	</body></html>
</xsl:template>
<!--LINK COLOR TEMPALTE -->
<xsl:template name="link_Color">
												 <xsl:param name="score" select="0"/>
												 <xsl:param name="field_name" select="0"/>
												 
												 <xsl:choose>	 
														 <xsl:when test="$score=2">  
														    <xsl:attribute name="style">color:#006600;</xsl:attribute>
														 </xsl:when>
														 <xsl:when test="$score=-2">  
														    <xsl:attribute name="style">color:#CC0000;</xsl:attribute>
														 </xsl:when>
														 <xsl:when test="$score=1">  
														    <xsl:attribute name="style">color:#CC6633;</xsl:attribute>
														 </xsl:when>
														 <!--<xsl:when test="$score=0 and not($field_name='src' or $field_name='source_rid' or $field_name='sec_range')">  
														    <xsl:attribute name="style">color:#0000DD;</xsl:attribute>
														 </xsl:when>
														 <xsl:otherwise>
														    <xsl:attribute name="style">color:#000000;</xsl:attribute>
														 </xsl:otherwise>-->
													</xsl:choose>	 
												 
</xsl:template>	
</xsl:stylesheet> 
*/
