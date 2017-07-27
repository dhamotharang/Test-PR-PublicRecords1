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

	<!-- Exceptions -->
<xsl:template match="/child::node()/Results/Result/Exception">
	Exception : <xsl:value-of select="Message"/>&cr;
</xsl:template>

	<!--Subject Information-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='best_information']">
<!--	NOT using this info anymore....this dataset's info is duplicated below
		and we keep it only to know which DID is the subject did.
		
	<H2>Subject Information:</H2>
	<xsl:for-each select="Row">
     	<xsl:call-template name="name_dob"/>&cr;
		<xsl:call-template name="std_address"/>&cr;
		Phone: <xsl:value-of select="phone"/>&cr;
		<xsl:if test = 'normalize-space(dod)'>
			DOD: <xsl:value-of select="dod"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(prpty_deed_id)">
			Property Deed ID: <xsl:value-of select="prpty_deed_id"/>&cr;
		</xsl:if>
		<xsl:if test= "normalize-space(vehicle_vehnum)">
			Vehicle Number: <xsl:value-of select="vehicle_vehnum"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(bkrupt_crtcode_caseno)">
			Bankruptcy Court Code / Case Number : <xsl:value-of select="bkrupt_crtcode_caseno"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(dl_number)">
			DL Number: <xsl:value-of select="dl_number"/>&cr;
		</xsl:if>
		&cr;Information believed current as of : <xsl:value-of select="run_date"/>&cr;
	</xsl:for-each>

-->
</xsl:template>

	<!-- Living Situations -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='living_situation']">
	<H2>Subject Information</H2>
	<xsl:for-each select="Row[did=$Main_Did]">
		<xsl:call-template name="name_dob"/>
		<xsl:if test="switched = 'true'">
			Switched: True &cr;
		</xsl:if>
		Gender: <xsl:call-template name="std_gender">
				<xsl:with-param name="gender_field" select="gender"/>
			   </xsl:call-template>&cr;
		<xsl:call-template name="std_address"/>&cr;
		Phone: <xsl:value-of select="phone"/>&cr;
		<xsl:if test = 'normalize-space(dod)'>
			DOD: <xsl:value-of select="dod"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(prpty_deed_id)">
			Property Deed ID: <xsl:value-of select="prpty_deed_id"/>&cr;
		</xsl:if>
		<xsl:if test= "normalize-space(vehicle_vehnum)">
			Vehicle Number: <xsl:value-of select="vehicle_vehnum"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(bkrupt_crtcode_caseno)">
			Bankruptcy Court Code / Case Number : <xsl:value-of select="bkrupt_crtcode_caseno"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(dl_number)">
			DL Number: <xsl:value-of select="dl_number"/>&cr;
		</xsl:if>
		&cr;Information believed current as of : <xsl:value-of select="run_date"/>&cr;
		&cr;&cr;
	</xsl:for-each>
	<H2>Household</H2>
	<xsl:for-each select="Row[did!=$Main_Did]">
		<xsl:call-template name="name_dob"/>
		<xsl:if test="switched = 'true'">
			Switched: True &cr;
		</xsl:if>
		Gender: <xsl:call-template name="std_gender">
				<xsl:with-param name="gender_field" select="gender"/>
			   </xsl:call-template>&cr;
		<xsl:call-template name="std_address"/>&cr;
		Phone: <xsl:value-of select="phone"/>&cr;
		<xsl:if test = 'normalize-space(dod)'>
			DOD: <xsl:value-of select="dod"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(prpty_deed_id)">
			Property Deed ID: <xsl:value-of select="prpty_deed_id"/>&cr;
		</xsl:if>
		<xsl:if test= "normalize-space(vehicle_vehnum)">
			Vehicle Number: <xsl:value-of select="vehicle_vehnum"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(bkrupt_crtcode_caseno)">
			Bankruptcy Court Code / Case Number : <xsl:value-of select="bkrupt_crtcode_caseno"/>&cr;
		</xsl:if>
		<xsl:if test="normalize-space(dl_number)">
			DL Number: <xsl:value-of select="dl_number"/>&cr;
		</xsl:if>
		&cr;Information believed current as of : <xsl:value-of select="run_date"/>&cr;
		&cr;&cr;
	</xsl:for-each>
</xsl:template>   

	<!-- Living Situation Counts -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name='living_situation_counts']">
	<h2>Living Situation Counts</h2>
	<xsl:for-each select="Row[did = $Main_Did]">
		status: <xsl:value-of select='status'/>&cr;
		gender: <xsl:call-template name='std_gender'>
				<xsl:with-param name= 'gender_field' select='gender'/>
			   </xsl:call-template>&cr;
		house_size: <xsl:value-of select='house_size'/>&cr;
		sg_within_7: <xsl:value-of select='sg_within_7'/>&cr;
		sg_within_7_up_same : <xsl:value-of select='sg_within_7_up_same'/>&cr;
		sg_within_7_dn_same : <xsl:value-of select='sg_within_7_dn_same'/>&cr;
		sg_within_7_up_diff : <xsl:value-of select='sg_within_7_up_diff'/>&cr;
		sg_within_7_dn_diff : <xsl:value-of select='sg_within_7_dn_diff'/>&cr;
		
		dg_within_7 : <xsl:value-of select='dg_within_7'/>&cr;
		dg_within_7_up_same : <xsl:value-of select='dg_within_7_up_same'/>&cr;
		dg_within_7_dn_same : <xsl:value-of select='dg_within_7_dn_same'/>&cr;
		dg_within_7_up_diff : <xsl:value-of select='dg_within_7_up_diff'/>&cr;
		dg_within_7_dn_diff : <xsl:value-of select='dg_within_7_dn_diff'/>&cr;
		
		ug_within_7 : <xsl:value-of select='ug_within_7'/>&cr;
		ug_within_7_up_same : <xsl:value-of select='ug_within_7_up_same'/>&cr;
		ug_within_7_dn_same : <xsl:value-of select='ug_within_7_dn_same'/>&cr;
		ug_within_7_up_diff : <xsl:value-of select='ug_within_7_up_diff'/>&cr;
		ug_within_7_dn_diff : <xsl:value-of select='ug_within_7_dn_diff'/>&cr;
		
		sg_y_8_15 : <xsl:value-of select='sg_y_8_15'/>&cr;
		sg_y_8_15_same : <xsl:value-of select='sg_y_8_15_same'/>&cr;
		sg_y_8_15_diff : <xsl:value-of select='sg_y_8_15_diff'/>&cr;
		dg_y_8_15: <xsl:value-of select='dg_y_8_15'/>&cr;
		dg_y_8_15_same: <xsl:value-of select='dg_y_8_15_same'/>&cr;
		dg_y_8_15_diff: <xsl:value-of select='dg_y_8_15_diff'/>&cr;
		ug_y_8_15: <xsl:value-of select='ug_y_8_15'/>&cr;
		ug_y_8_15_same: <xsl:value-of select='ug_y_8_15_same'/>&cr;
		ug_y_8_15_diff: <xsl:value-of select='ug_y_8_15_diff'/>&cr;
		sg_y_16_30: <xsl:value-of select='sg_y_16_30'/>&cr;
		sg_y_16_30_same: <xsl:value-of select='sg_y_16_30_same'/>&cr;
		sg_y_16_30_diff: <xsl:value-of select='sg_y_16_30_diff'/>&cr;
		dg_y_16_30: <xsl:value-of select='dg_y_16_30'/>&cr;
		dg_y_16_30_same: <xsl:value-of select='dg_y_16_30_same'/>&cr;
		dg_y_16_30_diff: <xsl:value-of select='dg_y_16_30_diff'/>&cr;
		ug_y_16_30: <xsl:value-of select='ug_y_16_30'/>&cr;
		ug_y_16_30_same: <xsl:value-of select='ug_y_16_30_same'/>&cr;
		ug_y_16_30_diff: <xsl:value-of select='ug_y_16_30_diff'/>&cr;
		sg_o_8_15: <xsl:value-of select='sg_o_8_15'/>&cr;
		sg_o_8_15_same: <xsl:value-of select='sg_o_8_15_same'/>&cr;
		sg_o_8_15_diff: <xsl:value-of select='sg_o_8_15_diff'/>&cr;
		dg_o_8_15: <xsl:value-of select='dg_o_8_15'/>&cr;
		dg_o_8_15_same: <xsl:value-of select='dg_o_8_15_same'/>&cr;
		dg_o_8_15_diff: <xsl:value-of select='dg_o_8_15_diff'/>&cr;
		ug_o_8_15: <xsl:value-of select='ug_o_8_15'/>&cr;
		ug_o_8_15_same: <xsl:value-of select='ug_o_8_15_same'/>&cr;
		ug_o_8_15_diff: <xsl:value-of select='ug_o_8_15_diff'/>&cr;
		sg_o_16_30: <xsl:value-of select='sg_o_16_30'/>&cr;
		sg_o_16_30_same: <xsl:value-of select='sg_o_16_30_same'/>&cr;
		sg_o_16_30_diff: <xsl:value-of select='sg_o_16_30_diff'/>&cr;
		dg_o_16_30: <xsl:value-of select='dg_o_16_30'/>&cr;
		dg_o_16_30_same: <xsl:value-of select='dg_o_16_30_same'/>&cr;
		dg_o_16_30_diff: <xsl:value-of select='dg_o_16_30_diff'/>&cr;
		ug_o_16_30: <xsl:value-of select='ug_o_16_30'/>&cr;
		ug_o_16_30_same: <xsl:value-of select='ug_o_16_30_same'/>&cr;
		ug_o_16_30_diff: <xsl:value-of select='ug_o_16_30_diff'/>&cr;
		sg_o_30: <xsl:value-of select='sg_o_30'/>&cr;
		sg_o_30_same: <xsl:value-of select='sg_o_30_same'/>&cr;
		sg_o_30_diff: <xsl:value-of select='sg_o_30_diff'/>&cr;
		dg_o_30: <xsl:value-of select='dg_o_30'/>&cr;
		dg_o_30_same: <xsl:value-of select='dg_o_30_same'/>&cr;
		dg_o_30_diff: <xsl:value-of select='dg_o_30_diff'/>&cr;
		ug_o_30: <xsl:value-of select='ug_o_30'/>&cr;
		ug_o_30_same: <xsl:value-of select='ug_o_30_same'/>&cr;
		ug_o_30_diff: <xsl:value-of select='ug_o_30_diff'/>&cr;
		sg_y_30: <xsl:value-of select='sg_y_30'/>&cr;
		sg_y_30_same: <xsl:value-of select='sg_y_30_same'/>&cr;
		sg_y_30_diff: <xsl:value-of select='sg_y_30_diff'/>&cr;
		dg_y_30: <xsl:value-of select='dg_y_30'/>&cr;
		dg_y_30_same: <xsl:value-of select='dg_y_30_same'/>&cr;
		dg_y_30_diff: <xsl:value-of select='dg_y_30_diff'/>&cr;
		ug_y_30: <xsl:value-of select='ug_y_30'/>&cr;
		ug_y_30_same: <xsl:value-of select='ug_y_30_same'/>&cr;
		ug_y_30_diff: <xsl:value-of select='ug_y_30_diff'/>&cr;
		
		kids: <xsl:value-of select='kids'/>&cr;
		parents: <xsl:value-of select='parents'/>&cr;
		
		sg: <xsl:value-of select='sg'/>&cr;
		sg_same: <xsl:value-of select='sg_same'/>&cr;
		sg_diff: <xsl:value-of select='sg_diff'/>&cr;
		dg: <xsl:value-of select='dg'/>&cr;
		dg_same: <xsl:value-of select='dg_same'/>&cr;
		dg_diff: <xsl:value-of select='dg_diff'/>&cr;
		ug: <xsl:value-of select='ug'/>&cr;
		ug_same: <xsl:value-of select='ug_same'/>&cr;
		ug_diff: <xsl:value-of select='ug_diff'/>&cr;
	</xsl:for-each>
</xsl:template>   

	<!-- Standard Address Template -->
<xsl:template name="std_address">
	<b><u>Address</u></b>&cr;
			<xsl:value-of select="normalize-space(prim_range)"/>&space;<xsl:value-of select="normalize-space(predir)"/>&space;
			<xsl:value-of select="normalize-space(prim_name)"/>&space;<xsl:value-of select="normalize-space(suffix)"/>&space;
			<xsl:value-of select="normalize-space(postdir)"/> &cr;
			<xsl:if test='normalize-space(sec_range)'>
				<xsl:value-of select="normalize-space(unit_desig)"/>&space;<xsl:value-of select="normalize-space(sec_range)"/>&cr;
			</xsl:if>
			<xsl:value-of select="normalize-space(city_name)"/>,&space;<xsl:value-of select="normalize-space(st)"/>&space;<xsl:value-of select="normalize-space(zip)"/>
			<xsl:if test="normalize-space(zip4) != ''">-<xsl:value-of select="normalize-space(zip4)"/></xsl:if>&cr;
</xsl:template>

    <!--Name / DOB / SSN common template-->
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
    &cr;
    <xsl:if test="dob!='0'"> DOB: <xsl:value-of select="concat(substring(dob,5,2),'/',substring(dob,7,2),'/',substring(dob,1,4))"/>&space;
    </xsl:if>
    <xsl:if test="age!=0"> Age: <xsl:value-of select="age"/>&space;</xsl:if>
    &cr;
    <xsl:if test="normalize-space(ssn)!=''">
       SSN: <a><xsl:attribute name="href">../Doxie/Doxie.HeaderFileSearchService?SSN=<xsl:value-of select="ssn"/></xsl:attribute><xsl:value-of select="ssn"/></a>
       <xsl:variable name="ssn5" select="substring(ssn,1,5)"/>
       <xsl:for-each select="/child::node()/Results/Result/Dataset[@name='SSN_Lookups']/Row[ssn5=$ssn5]">
           Issued in <xsl:value-of select="ssn_issue_place"/> between <xsl:value-of select="ssn_issue_early"/> and <xsl:value-of select="ssn_issue_last"/>
       </xsl:for-each>
    </xsl:if>
    <br/>
</xsl:template>

    <!-- Standard Gender Decode -->
<xsl:template name="std_gender">
	<xsl:param name="gender_field"/>
	<xsl:if test="starts-with($gender_field,'M') or starts-with($gender_field,'m')">Male</xsl:if>
	<xsl:if test="starts-with($gender_field,'F') or starts-with($gender_field,'f')">Female</xsl:if>
	<xsl:if test="not(starts-with($gender_field,'F') or starts-with($gender_field,'f') or
			      starts-with($gender_field,'M') or starts-with($gender_field,'m'))">Unknown</xsl:if>
</xsl:template>

</xsl:stylesheet>
*/
