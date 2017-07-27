/* =============================
split up zip5 and zip4 in property. 
add county in property.
*/
/*--RESULT--
<!DOCTYPE stylesheet [
<!ENTITY space "<xsl:text> </xsl:text>">
<!ENTITY cr "<br/>">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:variable name="Main_Did" select="//Results/Result/Dataset[@name='best_information']/Row/did"/>
<xsl:variable name="Main_SSN" select="//Results/Result/Dataset[@name='best_information']/Row/ssn"/>

<xsl:template match="/">
	<html><body><xsl:apply-templates/></body></html>
</xsl:template>

<xsl:template match="EclWatch"/>

<!--========================= Subject Information ===========================-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='best_information']">
	<H2>Subject Information:</H2>
	<xsl:for-each select="Row">
		<xsl:call-template name="name_dob"/>
	</xsl:for-each>
</xsl:template>

<!-- ======================== Address Summary ============================== --> 
<xsl:template match="/child::node()/Results/Result/Dataset[@name='Addresses']">
  <H2>Address Summary:</H2>
  <b>Active Addresses</b>&cr;
  <xsl:for-each select="Row[number(did)=number($Main_Did) and (tnt = 'B' or tnt = 'V' or tnt = 'C')]">
    <i>Address</i>&cr;
    <xsl:call-template name="name_address"><xsl:with-param name='extras' select='"true"'/></xsl:call-template>
  </xsl:for-each>
  <b>Historical or Unverified Addresses</b>&cr;
  <xsl:for-each select="Row[number(did)=number($Main_Did) and (tnt != 'B' and tnt != 'V' and tnt != 'C')]">
    <i>Address</i>&cr;
    <xsl:call-template name="name_address"><xsl:with-param name='extras' select='"true"'/></xsl:call-template>
  </xsl:for-each>
</xsl:template>

<!--========================Construct the relative summary ==================-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='Relative_Summary']">
  <H2>Possible Relative Summary:</H2>
  <i>(Click on name to link to more details within this report - No Charge)</i>&cr;
  <xsl:for-each select="Row">
	<br/>&gt;<xsl:if test="depth>1">&gt;</xsl:if>
	<xsl:if test="depth>2">&gt;</xsl:if>
	<xsl:if test="aka='true'">&gt;</xsl:if>
	<a> <xsl:attribute name="href">#RelDat<xsl:value-of select="person2"/></xsl:attribute>
	<xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/></a>
	<xsl:if test="aka='true'"> - (AKA)</xsl:if>
	<xsl:if test="aka != 'true' and age!=0">, Age <xsl:value-of select="age"/></xsl:if>
  </xsl:for-each>
  <H2>Possible Relatives</H2>
  <xsl:for-each select="Row">
	<xsl:if test="position()=1 or preceding::person2[1]!=person2">
		<xsl:variable name="p2" select="person2"></xsl:variable>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='Names']/Row[number(did)=number($p2)]">
			<xsl:if test="position()=1">
				<a><xsl:attribute name="name">#RelDat<xsl:value-of select="did"/></xsl:attribute></a>
				&cr;<b>Relative:</b>&cr;
			</xsl:if>
			<xsl:if test="position()=2"><i>Other names used:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_dob"/>
		</xsl:for-each>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='Addresses']/Row[number(did)=number($p2)]">
			<xsl:if test="position()=1"><i>Addresses:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_address"/>
		</xsl:for-each>
	</xsl:if>
  </xsl:for-each>
</xsl:template>

<!--======================= Construct the associates summary ================-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='Associate_Summary']">
  <H2>Possible Associates Summary:</H2>
  <i>(Click on name to link to more details within this report - No Charge)</i>&cr;
  <xsl:for-each select="Row">
	<br/>&gt;<xsl:if test="depth>1">&gt;</xsl:if>
	<xsl:if test="depth>2">&gt;</xsl:if>
	<xsl:if test="aka='true'">&gt;</xsl:if>
	<a> <xsl:attribute name="href">#RelDat<xsl:value-of select="person2"/></xsl:attribute>
	<xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/></a>
	<xsl:if test="aka='true'"> - (AKA)</xsl:if>
	<xsl:if test="aka != 'true' and age!=0">, Age <xsl:value-of select="age"/></xsl:if>
  </xsl:for-each>
  <H2>Possible Associates</H2>
  <xsl:for-each select="Row">
	<xsl:if test="position()=1 or preceding::person2[1]!=person2">
		<xsl:variable name="p2" select="person2"></xsl:variable>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='Names']/Row[number(did)=number($p2)]">
			<xsl:if test="position()=1">
				<a><xsl:attribute name="name">#RelDat<xsl:value-of select="did"/></xsl:attribute></a>
				&cr;<b>Associate:</b>&cr;
			</xsl:if>
			<xsl:if test="position()=2"><i>Other names used:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_dob"/>
		</xsl:for-each>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='Addresses']/Row[number(did)=number($p2)]">
			<xsl:if test="position()=1"><i>Addresses:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_address"/>
		</xsl:for-each>
	</xsl:if>
  </xsl:for-each>
</xsl:template>

<!-- =============== Remove auto-expansion of datasets handled elsewhere ====-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='Names']"/>
<xsl:template match="/child::node()/Results/Result/Exception">
Exception : <xsl:value-of select="Message"/>&cr;
</xsl:template>

<!--============Name / DOB / SSN common template ============================-->
<xsl:template name="name_dob">   
    <a><xsl:attribute name="href">../Doxie/Doxie.HeaderFileSearchService?FirstName=<xsl:value-of select="fname"/>&amp;LastName=<xsl:value-of select="lname"/>&amp;MiddleName=<xsl:value-of select="mname"/></xsl:attribute>
    <xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/></a>
    <xsl:if test="normalize-space(first_seen)!='' or normalize-space(last_seen)!=''">
        &space;(<xsl:value-of select="first_seen"/>
        <xsl:if test="normalize-space(first_seen)!='' and normalize-space(last_seen)!=''">
            -
        </xsl:if>
        <xsl:value-of select="last_seen"/>)&space;&space;&space;
    </xsl:if>
   <xsl:if test="dob!='0'"> DOB: <xsl:value-of select="concat(substring(dob,5,2),'/',substring(dob,7,2),'/',substring(dob,1,4))"/>&space;
   </xsl:if>
    <xsl:if test="age!=0"> Age: <xsl:value-of select="age"/>&space;</xsl:if>
   <xsl:if test="normalize-space(ssn)!=''">
   SSN: <a><xsl:attribute name="href">../Doxie/Doxie.HeaderFileSearchService?SSN=<xsl:value-of select="ssn"/></xsl:attribute><xsl:value-of select="ssn"/></a>
   <xsl:variable name="ssn5" select="substring(ssn,1,5)"/>
   <xsl:for-each select="/child::node()/Results/Result/Dataset[@name='SSN_Lookups']/Row[ssn5=$ssn5]">
   Issued in <xsl:value-of select="ssn_issue_place"/> between <xsl:value-of select="ssn_issue_early"/> and <xsl:value-of select="ssn_issue_last"/>
   </xsl:for-each>
   </xsl:if>
   <br/>
</xsl:template>

<!--========================= Standard Gender Decode ========================-->
<xsl:template name="std_gender">
	<xsl:param name="gender_field"/>
	<xsl:if test="starts-with($gender_field,'M') or starts-with($gender_field,'m')">Male</xsl:if>
	<xsl:if test="starts-with($gender_field,'F') or starts-with($gender_field,'f')">Female</xsl:if>
	<xsl:if test="not(starts-with($gender_field,'F') or starts-with($gender_field,'f') or
			      starts-with($gender_field,'M') or starts-with($gender_field,'m'))">Unknown</xsl:if>
</xsl:template>

	<!-- Standard Race Decode -->
<xsl:template name="std_race">
	<xsl:param name="race_field"/>
	<xsl:choose>
		<xsl:when test='starts-with($race_field,"W")'>White</xsl:when>
		<xsl:when test='starts-with($race_field,"B")'>Black</xsl:when>
		<xsl:when test='starts-with($race_field,"H")'>Hispanic</xsl:when>
		<xsl:when test='starts-with($race_field,"I")'>American Indian</xsl:when>
		<xsl:when test='starts-with($race_field,"P")'>Pacific Islander</xsl:when>
		<xsl:when test='starts-with($race_field,"A")'>Asian</xsl:when>
		<xsl:when test='starts-with($race_field,"U")'>Unknown</xsl:when>
		<xsl:otherwise>Other</xsl:otherwise>
	</xsl:choose>
	&cr;
</xsl:template>

<!--=================== Name and Address from common data ===================-->
<xsl:template name="name_address">
	<xsl:param name="extras" select = '"true"'/>
	<xsl:text>
	</xsl:text>
	<xsl:if test="shared_address='S'">
		<b>S</b>&space;
	</xsl:if>
     <xsl:variable name="city">
     <xsl:choose>
        <xsl:when test="normalize-space(city_name)!=''"><xsl:value-of select="city_name"/></xsl:when>
        <xsl:when test="normalize-space(v_city_name)!=''"><xsl:value-of select="v_city_name"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="p_city_name"/></xsl:otherwise>
     </xsl:choose>
     </xsl:variable>
	<xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/> 
     <xsl:if test="normalize-space(prim_name)!=''">- 
		<b><xsl:value-of select="tnt"/></b>&space;
		<a><xsl:attribute name="href">../Doxie/Doxie.HeaderFileSearchService?Addr=<xsl:value-of select="concat(prim_range,' ',predir,' ',prim_name,' ',suffix,' ',postdir,' ',unit_desig,' ',sec_range)"/>&amp;City=<xsl:value-of select="$city"/>&amp;State=<xsl:value-of select="st"/></xsl:attribute>
		<xsl:value-of select="prim_range"/>&space;
		<xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="suffix"/>&space;<xsl:value-of select="postdir"/>&space;
		<xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
		<xsl:value-of select="$city"/>
		&space;
		<xsl:value-of select="county_name"/>&space;
		<xsl:value-of select="st"/>&space;<xsl:value-of select="zip"/><xsl:if test="normalize-space(zip4)!=''">-<xsl:value-of select="zip4"/></xsl:if></a>
		<xsl:if test="normalize-space(dt_first_seen)!='' or normalize-space(dt_last_seen)!=''">
			(<xsl:value-of select="dt_first_seen"/> 
			<xsl:if test="normalize-space(dt_first_seen)!='' and normalize-space(dt_last_seen)!=''">-</xsl:if>
			<xsl:value-of select="dt_last_seen"/>)
		</xsl:if>
		&cr;
		<xsl:if test = "$extras = 'true'">
			<xsl:variable name="pn" select="normalize-space(prim_name)"/>
			<xsl:variable name="pr" select="normalize-space(prim_range)"/>
			<xsl:variable name="sr" select="normalize-space(sec_range)"/>
			<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='Phones']/Row[normalize-space(prim_name)=$pn and normalize-space(prim_range)=$pr and (normalize-space(sec_range)=$sr or normalize-space(sec_range)='')]">
				At Address: &space;<a><xsl:attribute name="href">../Doxie/Doxie.GongSearchService?Phone=<xsl:value-of select="phone"/></xsl:attribute><xsl:value-of select="concat('(',substring(phone,1,3),') ',substring(phone,4,3),'-',substring(phone,7,5))"/></a>&space;<xsl:value-of select="listing_name"/>&cr;
			</xsl:for-each>
			<xsl:variable name="stt" select="normalize-space(st)"/>
			<xsl:variable name="county" select="normalize-space(county)"/>
			<xsl:variable name="trct" select="substring(geo_blk,1,6)"/>
			<xsl:variable name="blk" select="substring(geo_blk,7,1)"/>
			<!-- Neighborhoods -->
			<xsl:for-each select="/child::node()/Results/Result/Dataset[@name='NbrHoods']/Row[normalize-space(stusab)=$stt and normalize-space(county)=$county and normalize-space(blkgrp)=$blk and normalize-space(tract)=$trct]">
				<b>Neighborhood Profile (2000 Census)</b>&cr;
					Average Age:&space;<xsl:value-of select="age"/>&cr;
					Median Household Income: $<xsl:value-of select="income"/>&cr;
					Median Owner Occupied Home Value: $<xsl:value-of select="home_value"/>&cr;
					Average Years of Education: <xsl:value-of select="education"/>&cr;
			</xsl:for-each>
		</xsl:if>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>
*/
