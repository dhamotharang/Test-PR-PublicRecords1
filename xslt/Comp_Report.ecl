/*2004-12-23T12:25:58Z ()
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
<xsl:variable name="Main_Did" select="//Results/Result/Dataset[@name = 'CRS_result']/Row/best_information_children/Row/did"/>
<xsl:variable name="Main_SSN" select="//Results/Result/Dataset[@name = 'CRS_result']/Row/best_information_children/Row/ssn"/>

<xsl:template match="/">
	<html><body><xsl:apply-templates/></body></html>
</xsl:template>

<xsl:template match="EclWatch"/>

	<!--   TimeLine Template -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/timeline_children">
	<H2>Timeline Summary</H2>
	<xsl:for-each select="Row">
		<b><xsl:value-of select="event_date"/></b>&space;&space;<xsl:value-of select="occurrence"/>&space;&space;
		<xsl:call-template name="name_address"><xsl:with-param name="extras" select="false"/></xsl:call-template>
	</xsl:for-each>
</xsl:template>

	<!--Subject Information-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/best_information_children">
	<H2>Subject Information:</H2>
	<xsl:for-each select="Row">
		<xsl:call-template name="name_dob"/>
	</xsl:for-each>
</xsl:template>

	<!-- SSN Recs -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/ssn_children">
	<H2>Identities of subject:</H2>
	<xsl:for-each select="Row[number(did)=number($Main_Did)]">
		<xsl:call-template name="name_dob"/>
	</xsl:for-each>
	<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/deathfile_children/Row[number(did) = number($Main_Did)]">
		&cr;<b>Died:</b> <xsl:value-of select="dod8"/> &space;(<xsl:value-of select="county_name"/>,<xsl:value-of select="state"/>)&space;Age at Death: <xsl:value-of select="age_at_death"/>&cr;
	</xsl:for-each>
	<H2>Others using same SSN:</H2>
	<xsl:for-each select="Row[number(did)!=number($Main_Did) and normalize-space(ssn)=normalize-space($Main_SSN)]">
		<xsl:call-template name="name_dob"/>
		valid ssn: <xsl:if test='valid="true"'>Yes</xsl:if>
				 <xsl:if test='valid="false"'>No</xsl:if>&cr;
	</xsl:for-each>
</xsl:template>

    <!--UCC-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/ucc_children">
<H2>UCC Filings</H2>
 <xsl:for-each select="Row">
     &cr;Debtor Name: <xsl:value-of select="debtor_name"/>&cr;
     Debtor Address: <xsl:value-of select="debtor_prim_range"/>&space;
	<xsl:value-of select="debtor_predir"/>&space;
	<xsl:value-of select="debtor_prim_name"/>&space;
	<xsl:value-of select="debtor_addr_suffix"/>&space;
	<xsl:value-of select="debtor_postdir"/>&space;
	<xsl:value-of select="debtor_unit_desig"/>&space;
	<xsl:value-of select="debtor_sec_range"/>&space;
	<xsl:value-of select="debtor_city_name"/>&space;
	<xsl:value-of select="debtor_county_name"/>&space;
	<xsl:value-of select="debtor_st"/>&space;
	<xsl:value-of select="debtor_zip"/>&space;
	<xsl:value-of select="debtor_zip4"/>&cr;
     Secured Name: <xsl:value-of select="secured_name"/>&cr;
     Secured Address:<xsl:value-of select="secured_prim_range"/>&space;
	<xsl:value-of select="secured_predir"/>&space;
	<xsl:value-of select="secured_prim_name"/>&space;
	<xsl:value-of select="secured_addr_suffix"/>&space;
	<xsl:value-of select="secured_postdir"/>&space;
	<xsl:value-of select="secured_unit_desig"/>&space;
	<xsl:value-of select="secured_sec_range"/>&space;
	<xsl:value-of select="secured_city_name"/>&space;
	<xsl:value-of select="secured_county_name"/>&space;
	<xsl:value-of select="secured_st"/>&space;
	<xsl:value-of select="secured_zip"/>&space;
	<xsl:value-of select="secured_zip4"/>&cr;
	Original Date: <xsl:value-of select="orig_filing_date"/>&cr;
	Filing Date: <xsl:value-of select="filing_date"/>&cr;
	Filing State: <xsl:value-of select="filing_state"/>&cr;
	Document Number: <xsl:value-of select="event_document_num"/>&cr;
	Collateral List: <xsl:value-of select="collateral_type_desc"/>&cr;
	<xsl:for-each select="collateral_children/Row">
		<xsl:value-of select="collateral_type_desc"/>&cr;
	</xsl:for-each>
	Number of Filings: <xsl:value-of select="filing_count"/>&cr;
	Document Count: <xsl:value-of select="document_count"/>&cr;
	Number of Debtor Parties:<xsl:value-of select="debtor_count"/>&cr;
	Number of Secured Parties:<xsl:value-of select="secured_count"/>&cr;
	Legal Type:<xsl:value-of select="filing_type_desc"/>&cr;
</xsl:for-each>
</xsl:template>

    <!-- Properties -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/property_children">
  <H2>Possible Properties Owned by Subject:</H2>
	<xsl:for-each select="Row">
	    <xsl:if test='current="true"'>
	     <b>Property:</b>&cr;
		Parcel Number - <xsl:value-of select="fapn"/>&cr;		
		Book - <xsl:value-of select="substring(book_page,1,6)"/>&cr;
		Page - <xsl:value-of select="substring(book_page,7,6)"/>&cr;
		
		Lot Number - <xsl:value-of select="lot_number"/>&cr;
		Name Owner 1 - <xsl:value-of select="name_owner_1"/>&cr;
		Name Owner 2 - <xsl:value-of select="name_owner_2"/>&cr;	
		Address - <xsl:value-of select="address_prim_range"/>&space;<xsl:value-of select="address_predir"/>&space;<xsl:value-of select="address_prim_name"/>&space;<xsl:value-of select="address_suffix"/>&space;<xsl:value-of select="address_postdir"/>&space;<xsl:value-of select="address_unit_desig"/>&space;<xsl:value-of select="normalize-space(address_sec_range)"/>,&space;<xsl:value-of select="address_v_city_name"/>&space;<xsl:value-of select="address_ace_state"/>&space;<xsl:value-of select="address_ace_zip"/>-<xsl:value-of select="address_ace_zip4"/>,&space;<xsl:value-of select="address_county"/>&space;COUNTY&cr;
		Owner's Address - <xsl:value-of select="owners_address_prim_range"/>&space;<xsl:value-of select="owners_address_predir"/>&space;<xsl:value-of select="owners_address_prim_name"/>&space;<xsl:value-of select="owners_address_suffix"/>&space;<xsl:value-of select="owners_address_postdir"/>&space;<xsl:value-of select="owners_address_unit_desig"/>&space;<xsl:value-of select="normalize-space(owners_address_sec_range)"/>,&space;<xsl:value-of select="owners_address_v_city_name"/>&space;<xsl:value-of select="owners_address_ace_state"/>&space;<xsl:value-of select="owners_address_ace_zip"/>-<xsl:value-of select="owners_address_ace_zip4"/>,&space;<xsl:value-of select="owners_address_county"/>&space;COUNTY&cr;
          	
		Land Usage - <xsl:value-of select="land_usage"/>&cr;
		Subdivision Name - <xsl:value-of select="subdivision_name"/>&cr;
		Total Value - <xsl:value-of select="total_value"/>&cr;		
		Land Value - <xsl:value-of select="land_value"/>&cr;		
		Improvement Value - <xsl:value-of select="improvement_value"/>&cr;
		Land Size - <xsl:value-of select="land_size"/>&cr;
		
		Building Size - <xsl:value-of select="building_size"/>&cr;
		Year Built - <xsl:value-of select="year_built"/>&cr;
		Sale Date - <xsl:value-of select="sale_date"/>&cr;
		Sale Price - <xsl:value-of select="sale_price"/>&cr;
		
          Name of Seller - <xsl:value-of select="name_of_seller"/>&cr;
	     Legal Description - <xsl:value-of select="legal_description"/>&cr;
         	
		&cr;
		Market Total Value - <xsl:value-of select="mkt_total_val"/>&cr;
		Market Land Value - <xsl:value-of select="mkt_land_val"/>&cr;
		Market Improvement Value - <xsl:value-of select="mkt_improvement_val"/>&cr;
		Assessed Value - <xsl:value-of select="assd_total_val"/>&cr;		
				
		Building Square Feet - <xsl:value-of select="building_square_feet"/>&cr;
          Living Size - <xsl:value-of select="living_square_feet"/>&cr;
		Stories Number - <xsl:value-of select="stories_number"/>&cr;
		Foundation - <xsl:value-of select="foundation"/>&cr;
		Bedrooms Number - <xsl:value-of select="bedrooms"/>&cr;
		Full Baths Number - <xsl:value-of select="full_baths"/>&cr;
		Half Baths Number - <xsl:value-of select="half_baths"/>&cr;
				
		Loan Amount - <xsl:value-of select="loan_amount"/>&cr;
		Loan Term Code - <xsl:value-of select="loan_term_code"/>&cr; 
		Loan Term - <xsl:value-of select="loan_term"/>&cr;
		Loan Type - <xsl:value-of select="loan_type"/>&cr;
		Loan Deed Type - <xsl:value-of select="loan_deed_type"/>&cr;
		Loan Deed SubType - <xsl:value-of select="loan_deed_sub_type"/>&cr;
		Lender Name - <xsl:value-of select="lender_name"/>&cr;
		
		Document Type - <xsl:value-of select="document_type"/>&cr;
		Document Number - <xsl:value-of select="document_number"/>&cr;
		Transaction Type - <xsl:value-of select="transaction_type"/>&cr;
		Title Company Name - <xsl:value-of select="title_company_name"/>&cr;
		
		Tax Year - <xsl:value-of select="tax_year"/>&cr;
		Tax Amount - <xsl:value-of select="tax_amount"/>&cr;
		Recording Date - <xsl:value-of select="recording_date"/>&cr;	
		Record Type - <xsl:value-of select="record_type"/>&cr;			
		&cr;
		</xsl:if>
	</xsl:for-each>
  <H2>Active or Previous Address(es) - Property Info</H2>
	<xsl:for-each select="Row">
	    <xsl:if test='current="false"'>
	     <b>Property:</b>&cr;
		Parcel Number - <xsl:value-of select="fapn"/>&cr;		
		Book - <xsl:value-of select="substring(book_page,1,6)"/>&cr;
		Page - <xsl:value-of select="substring(book_page,7,6)"/>&cr;
		
		Lot Number - <xsl:value-of select="lot_number"/>&cr;
		Name Owner 1 - <xsl:value-of select="name_owner_1"/>&cr;
		Name Owner 2 - <xsl:value-of select="name_owner_2"/>&cr;	
		Address - <xsl:value-of select="address_prim_range"/>&space;<xsl:value-of select="address_predir"/>&space;<xsl:value-of select="address_prim_name"/>&space;<xsl:value-of select="address_suffix"/>&space;<xsl:value-of select="address_postdir"/>&space;<xsl:value-of select="address_unit_desig"/>&space;<xsl:value-of select="normalize-space(address_sec_range)"/>,&space;<xsl:value-of select="address_v_city_name"/>&space;<xsl:value-of select="address_ace_state"/>&space;<xsl:value-of select="address_ace_zip"/>-<xsl:value-of select="address_ace_zip4"/>,&space;<xsl:value-of select="address_county"/>&space;COUNTY&cr;
		Owner's Address - <xsl:value-of select="owners_address_prim_range"/>&space;<xsl:value-of select="owners_address_predir"/>&space;<xsl:value-of select="owners_address_prim_name"/>&space;<xsl:value-of select="owners_address_suffix"/>&space;<xsl:value-of select="owners_address_postdir"/>&space;<xsl:value-of select="owners_address_unit_desig"/>&space;<xsl:value-of select="normalize-space(owners_address_sec_range)"/>,&space;<xsl:value-of select="owners_address_v_city_name"/>&space;<xsl:value-of select="owners_address_ace_state"/>&space;<xsl:value-of select="owners_address_ace_zip"/>-<xsl:value-of select="owners_address_ace_zip4"/>,&space;<xsl:value-of select="owners_address_county"/>&space;COUNTY&cr;
          	
		Land Usage - <xsl:value-of select="land_usage"/>&cr;
		Subdivision Name - <xsl:value-of select="subdivision_name"/>&cr;
		Total Value - <xsl:value-of select="total_value"/>&cr;		
		Land Value - <xsl:value-of select="land_value"/>&cr;		
		Improvement Value - <xsl:value-of select="improvement_value"/>&cr;
		Land Size - <xsl:value-of select="land_size"/>&cr;
		
		Building Size - <xsl:value-of select="building_size"/>&cr;
		Year Built - <xsl:value-of select="year_built"/>&cr;
		Sale Date - <xsl:value-of select="sale_date"/>&cr;
		Sale Price - <xsl:value-of select="sale_price"/>&cr;
		
          Name of Seller - <xsl:value-of select="name_of_seller"/>&cr;
	     Legal Description - <xsl:value-of select="legal_description"/>&cr;
         	
		&cr;
		Market Total Value - <xsl:value-of select="mkt_total_val"/>&cr;
		Market Land Value - <xsl:value-of select="mkt_land_val"/>&cr;
		Market Improvement Value - <xsl:value-of select="mkt_improvement_val"/>&cr;
		Assessed Value - <xsl:value-of select="assd_total_val"/>&cr;		
				
		Building Square Feet - <xsl:value-of select="building_square_feet"/>&cr;
          Living Size - <xsl:value-of select="living_square_feet"/>&cr;
		Stories Number - <xsl:value-of select="stories_number"/>&cr;
		Foundation - <xsl:value-of select="foundation"/>&cr;
		Bedrooms Number - <xsl:value-of select="bedrooms"/>&cr;
		Full Baths Number - <xsl:value-of select="full_baths"/>&cr;
		Half Baths Number - <xsl:value-of select="half_baths"/>&cr;
				
		Loan Amount - <xsl:value-of select="loan_amount"/>&cr;
		Loan Term Code - <xsl:value-of select="loan_term_code"/>&cr; 
		Loan Term - <xsl:value-of select="loan_term"/>&cr;
		Loan Type - <xsl:value-of select="loan_type"/>&cr;
		Loan Deed Type - <xsl:value-of select="loan_deed_type"/>&cr;
		Loan Deed SubType - <xsl:value-of select="loan_deed_sub_type"/>&cr;
		Lender Name - <xsl:value-of select="lender_name"/>&cr;
		
		Document Type - <xsl:value-of select="document_type"/>&cr;
		Document Number - <xsl:value-of select="document_number"/>&cr;
		Transaction Type - <xsl:value-of select="transaction_type"/>&cr;
		Title Company Name - <xsl:value-of select="title_company_name"/>&cr;
		
		Tax Year - <xsl:value-of select="tax_year"/>&cr;
		Tax Amount - <xsl:value-of select="tax_amount"/>&cr;
		Recording Date - <xsl:value-of select="recording_date"/>&cr;	
		Record Type - <xsl:value-of select="record_type"/>&cr;			
		&cr;
		</xsl:if>
	</xsl:for-each>
</xsl:template>

	<!-- Foreclosures -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/foreclosure_children">
     <h2>Foreclosures</h2>
	<xsl:for-each select="Row">
		ForeclosureID:&space;<xsl:value-of select="foreclosure_id"/>&cr;
		CaseNumber:&space;<xsl:value-of select="court_case_nbr"/>&cr;
		DeedType:&space;<xsl:value-of select="deed_desc"/>&cr;
		SiteAddress:&space;<xsl:value-of select="situs1_prim_range"/>&space;
		                   <xsl:value-of select="situs1_predir"/>&space;
					    <xsl:value-of select="situs1_prim_name"/>&space;
					    <xsl:value-of select="situs1_addr_suffix"/>&space;
					    <xsl:value-of select="situs1_postdir"/>&space;
	                        <xsl:value-of select="situs1_unit_desig"/>&space;
					    <xsl:value-of select="situs1_sec_range"/>,&space;
					    <xsl:value-of select="situs1_v_city_name"/>&space;
					    <xsl:value-of select="situs1_st"/>,&space;
					    <xsl:value-of select="situs1_zip"/>-<xsl:value-of select="situs1_zip4"/>&cr;
		Plaintiffs&cr;
		<xsl:for-each select="plaintiffs/Row">
	    	     Plaintiff:&space;<xsl:value-of select="plaintiff"/>&cr;			
		</xsl:for-each>
		Defendants&cr;
	     <xsl:for-each select="defendants/Row">
	    	     Name::&space;<xsl:value-of select="name_prefix"/>&space;
					   <xsl:value-of select="name_first"/>&space;
					   <xsl:value-of select="name_middle"/>&space;
					   <xsl:value-of select="name_last"/>&space;
					   <xsl:value-of select="name_suffix"/>&cr;			
			CompanyName:&space;<xsl:value-of select="name_company"/>&cr;
			SSN:&space;<xsl:value-of select="name_ssn"/>&cr;
		</xsl:for-each>
		FilingDate:&space;<xsl:value-of select="filing_date"/>&cr;
		DocumentYear:&space;<xsl:value-of select="document_year"/>&cr;
		DocumentNumber:&space;<xsl:value-of select="document_nbr"/>&cr;
		DocumentBook-Pages:&space;<xsl:value-of select="document_book"/>&space;-
		                          <xsl:value-of select="document_pages"/>&cr;
		DateOfLoanDefault:&space;<xsl:value-of select="date_of_default"/>&cr;
		AmountOfLoanDefault:&space;<xsl:value-of select="amount_of_default"/>&cr;
		AuctionDate-Time:&space;<xsl:value-of select="auction_date"/>&space;
						     <xsl:value-of select="auction_time"/>&cr;
		AuctionLocation:&space;<xsl:value-of select="street_address_of_auction_call"/>&space;
						    <xsl:value-of select="city_of_auction_call"/>&space;
						    <xsl:value-of select="state_of_auction_call"/>&cr;
		OpeningBid:&space;<xsl:value-of select="opening_bid"/>&cr;
		FinalJudgmentAmount:&space;<xsl:value-of select="final_judgment_amount"/>&cr;
		LenderName:&space;<xsl:value-of select="lender_beneficiary_first_name"/>&space;
		                  <xsl:value-of select="lender_beneficiary_last_name"/>&cr;
		LenderCompanyName:&space;<xsl:value-of select="lender_beneficiary_company_name"/>&cr;
		Trustee:&space;<xsl:value-of select="trustee_name"/>&cr;
		TitleCompany:&space;<xsl:value-of select="title_company_name"/>&cr;
		Attorney:&space;<xsl:value-of select="attorney_name"/>&space;
		                <xsl:value-of select="attorney_phone_nbr"/>&cr;
		SubdivisionName:&space;<xsl:value-of select="tract_subdivision_name"/>&cr;			 
		LandUsage:&space;<xsl:value-of select="property_desc"/>&cr;			 
		ParcelNumber:&space;<xsl:value-of select="parcel_number_parcel_id"/>&cr;			 
		YearBuilt:&space;<xsl:value-of select="year_built"/>&cr;			 
		CurrentLandValue:&space;<xsl:value-of select="current_land_value"/>&cr;
		CurrentImprovementValue:&space;<xsl:value-of select="current_improvement_value"/>&cr;
		LandSize:&space;<xsl:value-of select="lot_size"/>&cr;
		LivingSize:&space;<xsl:value-of select="living_area_square_feet"/>&cr;
		LegalDescription:&space;<xsl:value-of select="expanded_legal"/>&space;
						    <xsl:value-of select="legal_2"/>&space;
						    <xsl:value-of select="legal_3"/>&space;
						    <xsl:value-of select="legal_4"/>&cr;
		&cr;              
	</xsl:for-each>       
</xsl:template>

	<!-- Address Summary --> 
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/addresses_children">
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

    <!--Vehicle Records-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/vehicle_children">
  <H2>Current Motor Vehicles Registered To Subject:</H2>
  <xsl:for-each select="Row">
	<b>Vehicle</b>:&cr;
              Description: <xsl:value-of select="major_color_name"/>&space;<xsl:value-of select="best_model_year"/>&space;
                                     <xsl:value-of select="best_make_code"/>&space;<xsl:value-of select="vp_series_name"/> - <xsl:value-of select="body_style_description"/>&cr;
              License Plate: <xsl:value-of select="true_license_plste_number"/>&cr;
              License Plate Type: <xsl:value-of select="license_plate_code_name"/>&cr;
              VIN: <xsl:value-of select="orig_vin"/>&cr;
              State of Origin: <xsl:value-of select="orig_state_name"/>&cr;
              Vehicle Use: <xsl:value-of select="vehicle_use_name"/>&cr;
              Vehicle Type Code: <xsl:value-of select="vehicle_type"/>&cr;
		    Vehicle Type: <xsl:value-of select="vehicle_type_name"/>&cr;
		    Mileage: <xsl:value-of select="odometer_mileage"/>&cr;
              Title Number: <xsl:value-of select="title_numberxbg9"/>&cr;
              Title Date: <xsl:value-of select="title_issue_date"/>&cr;
              Title Status: <xsl:value-of select="title_status_code_name"/>&cr;
              Decal Year: <xsl:value-of select="decal_year"/>&cr;
              Engine Size: <xsl:value-of select="engine_size"/>&cr;
              Number of Cylinders: <xsl:value-of select="number_of_cylinders"/>&cr;
              Body: <xsl:value-of select="body_style_description"/>&cr;
              Record Type: <xsl:value-of select="history_name"/>&cr;
              Lien Date: <xsl:value-of select="lh_1_lien_date"/>&cr;
		    <i>Owner(s)</i>&cr;
                     Name: <xsl:value-of select="own_1_customer_name"/>
                     DOB: <xsl:value-of select="concat(substring(own_1_dob,5,2),'/',substring(own_1_dob,7,2),'/',substring(own_1_dob,1,4))"/>&space;
                     Age: <xsl:value-of select="own_1_age"/>&space;
                     Sex: <xsl:call-template name="std_gender"><xsl:with-param name='gender_field' select = 'own_1_sex'/></xsl:call-template> &cr;
				<xsl:value-of select="own_1_fname"/>&space;<xsl:value-of select="own_1_mname"/>&space;<xsl:value-of select="own_1_lname"/>&space;
                     SSN: <xsl:value-of select="own_1_ssn"/>&cr;
                     DL #: <xsl:value-of select="own_1_driver_license_number"/>&cr;
                     Address: <xsl:value-of select="own_1_prim_range"/>&space;<xsl:value-of select="own_1_predir"/>&space;<xsl:value-of select="own_1_prim_name"/>&space;<xsl:value-of select="own_1_suffix"/>&space;<xsl:value-of select="own_1_postdir"/>&space;<xsl:value-of select="own_1_predir"/>&space;<xsl:value-of select="own_1_unit_desig"/>&space;<xsl:value-of select="own_1_sec_range"/>&space;<xsl:value-of select="own_1_p_city_name"/>&space;<xsl:value-of select="own_1_state_2"/>&space;<xsl:value-of select="own_1_zip5"/>&cr;
                    <xsl:if test="normalize-space(own_2_customer_name)!=''">
                     Name: <xsl:value-of select="own_2_customer_name"/>
                     DOB: <xsl:value-of select="concat(substring(own_2_dob,5,2),'/',substring(own_2_dob,7,2),'/',substring(own_2_dob,1,4))"/>&space;
                     Age: <xsl:value-of select="own_2_age"/>&space;
                     Sex: <xsl:call-template name="std_gender"><xsl:with-param name='gender_field' select = 'own_2_sex'/></xsl:call-template> &cr;
				 <xsl:value-of select="own_2_fname"/>&space;<xsl:value-of select="own_2_mname"/>&space;<xsl:value-of select="own_2_lname"/>&space;
                     SSN: <xsl:value-of select="own_2_ssn"/>&cr;
                     DL #: <xsl:value-of select="own_2_driver_license_number"/>&cr;
                     Address: <xsl:value-of select="own_2_prim_range"/>&space;<xsl:value-of select="own_2_predir"/>&space;<xsl:value-of select="own_2_prim_name"/>&space;<xsl:value-of select="own_2_suffix"/>&space;<xsl:value-of select="own_2_postdir"/>&space;<xsl:value-of select="own_2_predir"/>&space;<xsl:value-of select="own_2_unit_desig"/>&space;<xsl:value-of select="own_2_sec_range"/>&space;<xsl:value-of select="own_2_p_city_name"/>&space;<xsl:value-of select="own_2_state_2"/>&space;<xsl:value-of select="own_2_zip5"/>&cr;
                    </xsl:if>
              <i>Registrant(s)</i>&cr;
                     Name: <xsl:value-of select="reg_1_customer_name"/>
                     DOB: <xsl:value-of select="concat(substring(reg_1_dob,5,2),'/',substring(reg_1_dob,7,2),'/',substring(reg_1_dob,1,4))"/>&space;
                     Age: <xsl:value-of select="reg_1_age"/>&space;
                     Sex: <xsl:call-template name="std_gender"><xsl:with-param name='gender_field' select = 'reg_1_sex'/></xsl:call-template> &cr;		
				 <xsl:value-of select="reg_1_fname"/>&space;<xsl:value-of select="reg_1_mname"/>&space;<xsl:value-of select="reg_1_lname"/>&space;
                     SSN: <xsl:value-of select="reg_1_ssn"/>&cr;
                     DL #: <xsl:value-of select="reg_1_driver_license_number"/>&cr;
                     Address: <xsl:value-of select="reg_1_prim_range"/>&space;<xsl:value-of select="reg_1_predir"/>&space;<xsl:value-of select="reg_1_prim_name"/>&space;<xsl:value-of select="reg_1_suffix"/>&space;<xsl:value-of select="reg_1_postdir"/>&space;<xsl:value-of select="reg_1_predir"/>&space;<xsl:value-of select="reg_1_unit_desig"/>&space;<xsl:value-of select="reg_1_sec_range"/>&space;<xsl:value-of select="reg_1_p_city_name"/>&space;<xsl:value-of select="reg_1_state_2"/>&space;<xsl:value-of select="reg_1_zip5"/>&cr;
                    <xsl:if test="normalize-space(reg_2_customer_name)!=''">
                     Name: <xsl:value-of select="reg_2_customer_name"/>
                     DOB: <xsl:value-of select="concat(substring(reg_2_dob,5,2),'/',substring(reg_2_dob,7,2),'/',substring(reg_2_dob,1,4))"/>&space;
                     Age: <xsl:value-of select="reg_2_age"/>&space;
                     Sex: <xsl:call-template name="std_gender"><xsl:with-param name='gender_field' select = 'reg_2_sex'/></xsl:call-template> &cr;
				 <xsl:value-of select="reg_2_fname"/>&space;<xsl:value-of select="reg_2_mname"/>&space;<xsl:value-of select="reg_2_lname"/>&space;
                     SSN: <xsl:value-of select="reg_2_ssn"/>&cr;
                     DL #: <xsl:value-of select="reg_2_driver_license_number"/>&cr;
                     Address: <xsl:value-of select="reg_2_prim_range"/>&space;<xsl:value-of select="reg_2_predir"/>&space;<xsl:value-of select="reg_2_prim_name"/>&space;<xsl:value-of select="reg_2_suffix"/>&space;<xsl:value-of select="reg_2_postdir"/>&space;<xsl:value-of select="reg_2_predir"/>&space;<xsl:value-of select="reg_2_unit_desig"/>&space;<xsl:value-of select="reg_2_sec_range"/>&space;<xsl:value-of select="reg_2_p_city_name"/>&space;<xsl:value-of select="reg_2_state_2"/>&space;<xsl:value-of select="reg_2_zip5"/>&cr;
                    </xsl:if>
              <i>Lien Holder</i>&cr;
                    <xsl:if test="normalize-space(lh_1_customer_name)=''">
                     None&cr;
                     </xsl:if>
                    <xsl:if test="normalize-space(lh_1_customer_name)!=''">
                     Name: <xsl:value-of select="lh_1_customer_name"/>&cr;
                     </xsl:if>
</xsl:for-each>
</xsl:template>

   <!-- Drivers Licenses-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/drivers_licenses_children">
  <H2>Drivers Licences:</H2>
  <xsl:for-each select="Row">
	<xsl:call-template name="name_dob"/>
	DL Number: <xsl:value-of select="dl_number"/>
	&cr;State: <xsl:value-of select="orig_state"/>&cr;
	<xsl:call-template name="name_address"/>
	Sex: <xsl:call-template name="std_gender"><xsl:with-param name = "gender_field" select="sex_flag"/></xsl:call-template> &cr;
	Race: <xsl:call-template name="std_race"><xsl:with-param name = "race_field" select="race"/></xsl:call-template>
	Expiration Date : <xsl:value-of select="concat(substring(orig_expiration_date,5,2),'/',substring(orig_expiration_date,7,2),'/',substring(orig_expiration_date,1,4))"/>&cr;
	Issue Date : <xsl:value-of select="concat(substring(lic_issue_date,5,2),'/',substring(lic_issue_date,7,2),'/',substring(lic_issue_date,1,4))"/>&cr;
	License Type: <xsl:value-of select="license_type_name"/>&cr;
	Height: <xsl:value-of select="height"/>&cr;
	Weight: <xsl:value-of select="weight"/>&cr;
	Attention: <xsl:value-of select='attention_name'/>&cr;
	Restrictions: <xsl:value-of select="restriction1"/>&space;<xsl:value-of select="restriction2"/>&space;<xsl:value-of select="restriction3"/>&space;<xsl:value-of select="restriction4"/>&space;<xsl:value-of select="restriction5"/>&cr;
	Endorsments: <xsl:value-of select="endorsement1"/>&space;<xsl:value-of select="endorsement2"/>&space;<xsl:value-of select="endorsement3"/>&space;<xsl:value-of select="endorsement4"/>&space;<xsl:value-of select="endorsement5"/>&cr;&cr;
  </xsl:for-each>
</xsl:template>

	<!-- FL Crash -->
<xsl:template match = "/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/fl_crash_children">
  <h2>FL Crash Info</h2>
  <xsl:for-each select="Row">
	<b>Accident</b>&cr;
	<xsl:for-each select="flcrash_driver/Row">
		<b>Driver Info</b>&cr;
		Name: <xsl:value-of select='driver_full_name'/> &cr;
		Address: 	<xsl:value-of select="prim_range"/>&space;
				<xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="addr_suffix"/>&space;<xsl:value-of select="postdir"/>&space;
				<xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
				<xsl:value-of select="p_city_name"/>
				&space;
				<xsl:value-of select="st"/>&space;<xsl:value-of select="zip"/><xsl:if test="normalize-space(zip4)!=''">-</xsl:if><xsl:value-of select="zip4"/>&space;
				<xsl:value-of select="county_name"/>&cr;
		DL Number: <xsl:value-of select='driver_dl_nbr'/>&cr;
		DL State : <xsl:value-of select='dl_state_name'/>&cr;
		DL Type  : <xsl:value-of select='dl_type_name'/> &cr;
		Accident Number: <xsl:value-of select='accident_nbr'/> &cr;
		Alchohol/Drug Code: <xsl:value-of select='driver_alco_drug_code_name'/>&cr;
		Physical Defects: <xsl:value-of select='driver_physical_defects_code_name'/>&cr;
		Injury Severity: <xsl:value-of select='driver_injury_severity_name'/>&cr;
		Driver Safety: <xsl:value-of select='first_driver_safety_name'/> <xsl:value-of select='second_driver_safety_name'/>&cr;
          Driver Eject: <xsl:value-of select='driver_eject_code_name'/>&cr;
		Contributing Causes: <xsl:value-of select='first_contrib_cause_name'/> <xsl:value-of select='second_contrib_cause_name'/> <xsl:value-of select='third_contrib_cause_name'/> &cr;
		DL Number Validity: <xsl:value-of select='dl_nbr_good_bad_name'/>&cr;
	</xsl:for-each>
	<xsl:for-each select='flcrash_time_location/Row'>
		<b>Time and Location Info</b>&cr;
		Date: <xsl:value-of select='accident_date'/>&cr;
		City/Town: <xsl:value-of select='city_nbr_name'/>&cr;
		County: <xsl:value-of select='county_nbr_name'/>&cr;
		Intersection: <xsl:value-of select='at_intersect_of'/>&cr;
		Number of Lanes: <xsl:value-of select='dot_nbr_lanes'/>&cr;
          Type FR Case: <xsl:value-of select='type_fr_case_name'/>&cr;
          Action: <xsl:value-of select='action_code_name'/>&cr;
	</xsl:for-each>
	<xsl:for-each select='flcrash_vehicle/Row'>
		<b>Vehicle Info</b>&cr;
		Vehicle Type: <xsl:value-of select='vehicle_type_name'/>&cr;
		Vehicle Tag: <xsl:value-of select='vehicle_tag_nbr'/>&cr;
		Vehicle Registration State: <xsl:value-of select='vehicle_reg_state_name'/>&cr;
		VIN: <xsl:value-of select='vehicle_id_nbr'/>&cr;
		Travelling On: <xsl:value-of select='vehicle_travel_on'/> &space; Direction: <xsl:value-of select='direction_travel_name'/>&cr;
		Estimted Speed: <xsl:value-of select='est_vehicle_speed'/>&cr;
		Posted Speed: <xsl:value-of select='posted_speed'/>&cr;
		Estimated Damage: <xsl:value-of select='est_vehicle_damage'/>&cr;
		Damage Type: <xsl:value-of select='damage_type_name'/>&cr;
		Point of Impact: <xsl:value-of select='point_of_impact_name'/>&cr;
		Vehicle Movement: <xsl:value-of select='vehicle_movement_name'/>&cr;
		Vehicle Defects: <xsl:value-of select='vehs_first_defect_name'/> <xsl:value-of select='vehs_second_defect_name'/>&cr;
		Moving Violation: <xsl:value-of select='moving_violation_name'/>&cr;
		Fault: <xsl:value-of select='vehicle_fault_code_name'/>&cr;
		Insurance Co.: <xsl:value-of select='ins_company_name'/>&cr;
		Policy Number: <xsl:value-of select='ins_policy_nbr'/>&cr;
		Vehicle Owner: <xsl:value-of select='vehicle_owner_name'/>&cr;
		Owner DL Num : <xsl:value-of select='vehicle_owner_dl_nbr'/>&cr;
		Owner DOB: <xsl:value-of select='vehicle_owner_dob'/>&cr;
		Owner Sex: <xsl:value-of select='vehicle_owner_sex_name'/>&cr;
		Owner Race: <xsl:value-of select='vehicle_owner_race_name'/>&cr;
		Owner Address: <xsl:value-of select="prim_range"/>&space;
				<xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="addr_suffix"/>&space;<xsl:value-of select="postdir"/>&space;
				<xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
				<xsl:value-of select="p_city_name"/>
				&space;
				<xsl:value-of select="st"/>&space;<xsl:value-of select="zip"/><xsl:if test="normalize-space(zip4)!=''">-</xsl:if><xsl:value-of select="zip4"/>&space;
				<xsl:value-of select="county_name"/>&cr;
          Vehicle FR: <xsl:value-of select='vehicle_fr_code_name'/>&cr;
          Vehicle Insured/Not: <xsl:value-of select='vehicle_insur_code_name'/>&cr;
          Vehicle Driver Action: <xsl:value-of select='vehicle_driver_action_name'/>&cr;
          Vehicle Owner Driver: <xsl:value-of select='vehicle_owner_driver_code_name'/>&cr;
          How Removed: <xsl:value-of select='how_removed_code_name'/>&cr;
	</xsl:for-each>
	<xsl:for-each select='flcrash_accident_char/Row'>
		<b>Accident Details</b>&cr;
		Accident Time: <xsl:value-of select='hr_accident'/>:<xsl:value-of select='min_accident'/>&cr;
		Harmful Events: <xsl:value-of select='first_harmful_event_name'/> <xsl:value-of select='subs_harmful_event_name'/>&cr;
		Light Conditions: <xsl:value-of select='light_condition_name'/>&cr;
		Weather: <xsl:value-of select='weather_name'/>&cr;
		Road Surface Condition: <xsl:value-of select='rd_surface_condition_name'/>&cr;
		Contributing Environment: <xsl:value-of select='first_contrib_envir_name'/> <xsl:value-of select='second_contrib_envir_name'/>&cr;
		Traffic Controls: <xsl:value-of select='first_traffic_control_name'/> <xsl:value-of select='second_traffic_control_name'/>&cr;
		Investigating Agency: <xsl:value-of select='invest_agency_name'/>&cr;
		Investigation Report Number: <xsl:value-of select='invest_agy_rpt_nbr'/>&cr;
		Injury Severity: <xsl:value-of select='accident_injury_severity_name'/>&cr;
		Damage Severity: <xsl:value-of select='accident_damage_severity_name'/>&cr;
		Total Vehicle Damage: $<xsl:value-of select='total_vehicle_damage'/>&cr;
		Total Property Damage: $<xsl:value-of select='total_prop_damage_amt'/>&cr;
		Alchohol/Drug Use: <xsl:value-of select='alcohol_drug_name'/>&cr;
          Rural/Urban: <xsl:value-of select='rural_urban_code_name'/>&cr;
          Accident Insured/Not: <xsl:value-of select='accident_insur_code_name'/>&cr;
          Accident Fault: <xsl:value-of select='accident_fault_code_name'/>&cr;
          Type Driver Accident: <xsl:value-of select='type_driver_accident_name'/>&cr;
		Weekday: <xsl:value-of select='day_week_name'/>&cr;
	</xsl:for-each>	
     <xsl:for-each select='flcrash_passenger/Row'>
		<b>Passenger Info</b>&cr;
		Injure Severity: <xsl:value-of select='passenger_injury_sev_name'/>&cr;
		Passenger Safety: <xsl:value-of select='first_passenger_safe_name'/> <xsl:value-of select='second_passenger_safe_name'/>&cr;
          Passenger Eject: <xsl:value-of select='passenger_eject_code_name'/>&cr;
	</xsl:for-each>	
     <xsl:for-each select='flcrash_pedestrian/Row'>
		<b>Pedestrian Info</b>&cr;
		Pedestrian Action: <xsl:value-of select='ped_action_name'/>&cr;
	</xsl:for-each>	
  </xsl:for-each>
</xsl:template> 

	<!-- VOTER RECORDS -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/voter_children">
  <H2>Voter Records:</H2>
  <xsl:for-each select="Row">
	<xsl:call-template name="name_dob"/>
	<xsl:call-template name="name_address"/>
	Sex: <xsl:value-of select='gender_mapped'/> &cr;
	Race: <xsl:value-of select='race_mapped'/> &cr;
	Registration Date : <xsl:value-of select="concat(substring(regdate,5,2),'/',substring(regdate,7,2),'/',substring(regdate,1,4))"/>&cr;
	Political Party: <xsl:value-of select="poliparty_mapped"/>&cr;
	Registration State: <xsl:value-of select="source_state_mapped"/>&cr;
	Status: <xsl:value-of select="active_status_mapped"/>&cr;
  </xsl:for-each>
</xsl:template>

    <!--Construct the relative summary-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/relative_summary_children">
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
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/names_children/Row[did=$p2]">
			<xsl:if test="position()=1">
				<a><xsl:attribute name="name">#RelDat<xsl:value-of select="did"/></xsl:attribute></a>
				&cr;<b>Relative:</b>&cr;
			</xsl:if>
			<xsl:if test="position()=2"><i>Other names used:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_dob"/>
		</xsl:for-each>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/addresses_children/Row[did=$p2]">
			<xsl:if test="position()=1"><i>Addresses:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_address"/>
		</xsl:for-each>
	</xsl:if>
  </xsl:for-each>
</xsl:template>

    <!--Construct the associates summary-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/associate_summary_children">
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
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/names_children/Row[did=$p2]">
			<xsl:if test="position()=1">
				<a><xsl:attribute name="name">#RelDat<xsl:value-of select="did"/></xsl:attribute></a>
				&cr;<b>Associate:</b>&cr;
			</xsl:if>
			<xsl:if test="position()=2"><i>Other names used:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_dob"/>
		</xsl:for-each>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/addresses_children/Row[did=$p2]">
			<xsl:if test="position()=1"><i>Addresses:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_address"/>
		</xsl:for-each>
	</xsl:if>
  </xsl:for-each>
</xsl:template>
	
	<!-- Neighbors -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/nbrs_summary_children">
	<h2>Neighbours</h2>
	<xsl:for-each select="Row">
		<xsl:if test="seq='1'">
			<xsl:variable name="this_street" select="prim_name"/>
			<h3>Subject Address:</h3>
			<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/addresses_children/Row[number(did)=number($Main_Did) and normalize-space($this_street)=normalize-space(prim_name)]">
				<xsl:call-template name="name_address"/>
			</xsl:for-each>
		</xsl:if>
		<xsl:variable name="N_Did" select="did"/>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/names_children/Row[did=$N_Did]">
			<xsl:if test="position()=1">
				&cr;<b>Neighbour:</b>&cr;
			</xsl:if>
			<xsl:if test="position()=2"><i>Other names used:</i>&cr;
			</xsl:if>
			<xsl:call-template name="name_dob"/>
		</xsl:for-each>
		<b>Addresses:</b>&cr;   
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/addresses_children/Row[did=$N_Did]">
			<xsl:call-template name="name_address"/>
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

	<!-- Deathfile Records -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/deathfile_children">
	<h2>DeathFile Report for Neighbors, Associates, and Relatives</h2>
	<xsl:for-each select="Row[number(did) != number($Main_Did)]">
		&cr;Name: <xsl:value-of select='fname'/> <xsl:value-of select='mname'/> <xsl:value-of select='lname'/>&cr;
		<b>Died:</b> <xsl:value-of select="dod8"/> &space;(<xsl:value-of select="county_name"/>,<xsl:value-of select="state"/>)&space;Age at Death: <xsl:value-of select="age_at_death"/>&cr;
		&cr;
	</xsl:for-each>
</xsl:template>	

	<!-- Criminal Recs -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/doc_children">
	<h2>Possible Criminal Records</h2>
	<h3>Subject:</h3>
	<xsl:for-each select="Row[number(did) = number($Main_Did)]">
		<b><xsl:value-of select="source_file"/></b>&cr;
	     Name:      <xsl:call-template name="name_dob"/> &cr;
	     <xsl:for-each select='akas/Row'>
			AKA: <xsl:value-of select='fname'/> <xsl:value-of select='mname'/> <xsl:value-of select='lname'/> <xsl:value-of select='name_suffix'/>&cr;
		</xsl:for-each>
		Address:   <xsl:value-of select="prim_range"/>&space;
				 <xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="suffix"/>&space;<xsl:value-of select="postdir"/>&space;
				 <xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
				 <xsl:value-of select="p_city_name"/>
				 &space;
				 <xsl:value-of select="st"/>&space;<xsl:value-of select="zip5"/><xsl:if test="normalize-space(zip4)!=''">-</xsl:if><xsl:value-of select="zip4"/> &cr;
	     State of Origin: <xsl:value-of select="orig_state"/>&cr;
	     County: <xsl:value-of select="county_name"/>&cr;
	     Race: <xsl:call-template name="std_race"><xsl:with-param name='race_field' select="race_desc"/></xsl:call-template>
	     Sex: <xsl:call-template name='std_gender'><xsl:with-param name='gender_field' select="sex"/></xsl:call-template> &cr;
	     Eyes: <xsl:value-of select = 'eye_color_desc'/> &cr;
		State of Birth: <xsl:value-of select = "place_of_birth"/>&cr;	 
		<xsl:for-each select='doc_offenses/Row'>
		     <b>Offense</b>&cr;
			Case Number:  <xsl:value-of select='case_num'/> &cr;
			Offense Date: <xsl:value-of select='off_date'/> &cr;
			Offense:      <xsl:value-of select='arr_off_desc_1'/> &cr;
			Counts:	    <xsl:value-of select='num_of_counts'/> &cr;
			Convicted County: <xsl:value-of select='cty_conv'/> &cr;
			Sentence Date: <xsl:value-of select='stc_dt'/> &cr;
			Adjudication Withheld <xsl:if test='adj_wthd = "Y"'> Yes </xsl:if>
							  <xsl:if test='adj_wthd = "N"'> No  </xsl:if>
							  <xsl:if test='adj_wthd != "Y" and adj_wthd != "N"'>Unknown</xsl:if> &cr;
			Sentence: <xsl:value-of select='stc_desc_1'/> &cr;
		</xsl:for-each>
		<xsl:for-each select='court_offenses/Row'>
		     <b>Offense</b>&cr;
			Case Number:  <xsl:value-of select='court_case_number'/> &cr;
			Offense Date: <xsl:value-of select='off_date'/> &cr;
			Offense:      <xsl:value-of select='off_desc_1'/> &cr;
			Counts:	    <xsl:value-of select='num_of_counts'/> &cr;
			Sentence Date: <xsl:value-of select='sent_date'/> &cr;
		</xsl:for-each>
     </xsl:for-each>
     <xsl:for-each select="Row[number(did) != number($Main_Did)]">
		<xsl:if test="position() = 1">
			<h3>Relatives, Associates, and Neighbors:</h3>
		</xsl:if>
		<b><xsl:value-of select="source_file"/></b>&cr;
	     Name:      <xsl:call-template name="name_dob"/> &cr;
	     <xsl:for-each select='akas/Row'>
			AKA: <xsl:value-of select='fname'/> <xsl:value-of select='mname'/> <xsl:value-of select='lname'/> <xsl:value-of select='name_suffix'/>&cr;
		</xsl:for-each>
		Address:   <xsl:value-of select="prim_range"/>&space;
				 <xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="suffix"/>&space;<xsl:value-of select="postdir"/>&space;
				 <xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
				 <xsl:value-of select="p_city_name"/>
				 &space;
				 <xsl:value-of select="st"/>&space;<xsl:value-of select="zip5"/><xsl:if test="normalize-space(zip4)!=''">-</xsl:if><xsl:value-of select="zip4"/> &cr;
	     State of Origin: <xsl:value-of select="orig_state"/>&cr;
	     County: <xsl:value-of select="county_name"/>&cr;
	     Race: <xsl:call-template name="std_race"><xsl:with-param name='race_field' select="race_desc"/></xsl:call-template>
	     Sex: <xsl:call-template name='std_gender'><xsl:with-param name='gender_field' select="sex"/></xsl:call-template> &cr;
	     Eyes: <xsl:value-of select = 'eye_color_desc'/> &cr;
		State of Birth: <xsl:value-of select = "place_of_birth"/>&cr;	 
		<xsl:for-each select='doc_offenses/Row'>
		     <b>Offense</b>&cr;
			Case Number:  <xsl:value-of select='case_num'/> &cr;
			Offense Date: <xsl:value-of select='off_date'/> &cr;
			Offense:      <xsl:value-of select='off_desc_1'/> &cr;
			Counts:	    <xsl:value-of select='num_of_counts'/> &cr;
			Convicted County: <xsl:value-of select='cty_conv'/> &cr;
			Sentence Date: <xsl:value-of select='stc_dt'/> &cr;
			Adjudication Withheld <xsl:if test='adj_wthd = "Y"'> Yes </xsl:if>
							  <xsl:if test='adj_wthd = "N"'> No  </xsl:if>
							  <xsl:if test='adj_wthd != "Y" and adj_wthd != "N"'>Unknown</xsl:if> &cr;
			Sentence: <xsl:value-of select='stc_desc_1'/> &cr;
		</xsl:for-each>
		<xsl:for-each select='court_offenses/Row'>
		     <b>Offense</b>&cr;
			Case Number:  <xsl:value-of select='court_case_number'/> &cr;
			Offense Date: <xsl:value-of select='off_date'/> &cr;
			Offense:      <xsl:value-of select='arr_off_desc_1'/> &cr;
			Counts:	    <xsl:value-of select='num_of_counts'/> &cr;
			Sentence Date: <xsl:value-of select='sent_date'/> &cr;
		</xsl:for-each>
    </xsl:for-each>
</xsl:template>

	<!-- Professional Licenses -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/professional_licenses_children">
	<h2>Professional Licenses:</h2>
	<xsl:for-each select="Row">
		<b>License:</b>&cr;
		<xsl:call-template name="name_address"/>
		License State: <xsl:value-of select="source_st"/>&cr;
		License Number: <xsl:value-of select="orig_license_number"/>&cr;
		License Type: <xsl:value-of select="license_type"/>&cr;
		Profession/Board: <xsl:value-of select="profession_or_board"/>&cr;
		License Status: <xsl:value-of select="status"/>&cr;
		Issue Date:  <xsl:value-of select="concat(substring(issue_date,5,2),'/',substring(issue_date,7,2),'/',substring(issue_date,1,4))"/>&cr;
		Expiration Date:  <xsl:value-of select="concat(substring(expiration_date,5,2),'/',substring(expiration_date,7,2),'/',substring(expiration_date,1,4))"/>&cr;
	</xsl:for-each>
</xsl:template>

	<!-- People At Work Summary -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/employment_children">
	<h2>People At Work Information</h2>
	<xsl:for-each select="Row">
		<b>Company</b>&cr;
		<xsl:value-of select="company_name"/> - <xsl:value-of select="company_prim_range"/> <xsl:value-of select="company_prim_name"/> <xsl:value-of select="company_addr_suffix"/> <xsl:value-of select="company_unit_desig"/> <xsl:value-of select="company_sec_range"/>, <xsl:value-of select='company_city'/> <xsl:value-of select = "company_state"/> <xsl:value-of select="company_zip"/>&cr;
		email: <xsl:value-of select="email_address"/>&cr;
		&cr;
	</xsl:for-each>
</xsl:template>

	<!-- DEA Records -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/dea_children">
	<h2>DEA Records</h2>
	<xsl:for-each select = 'Row'>
		<b>License</b>&cr;
		Registration Number: <xsl:value-of select = 'dea_registration_number'/>&cr;
		Drug Schedules: <xsl:value-of select = 'drug_schedules'/>&cr;
		Expiration Date: <xsl:value-of select='expiration_date'/>&cr;
		<xsl:call-template name = 'name_address'/>
	</xsl:for-each>
</xsl:template>

   <!-- Pilot Licenses-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/pilot_licenses_children">
	<h2>FAA Certifications:</h2>
	<xsl:for-each select="Row[normalize-space(record_type) = 'ACTIVE']">
		<b>License:</b>&cr;
		<xsl:call-template name="name_address"/>
		Expiration Date: <xsl:value-of select="concat(substring(med_exp_date,1,2),'/',substring(med_exp_date,3,4))"/>&cr;
		Certification Date: <xsl:value-of select="concat(substring(med_date,1,2),'/',substring(med_date,3,4))"/>&cr;
		Class: <xsl:value-of select="med_class"/>&cr;
		Record Type: <xsl:value-of select="record_type"/>&cr;
		Certificate:&cr;
		<xsl:variable name="uid" select="unique_id"></xsl:variable>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/pilot_certificates_children/Row[unique_id=$uid]">
			&space;&space;&space;Type: <xsl:value-of select="cer_type_mapped"/>&cr;
			&space;&space;&space;Level: <xsl:value-of select="cer_level_mapped"/>&cr;
			&space;&space;&space;Ratings: <xsl:value-of select="ratings"/>&cr;
		</xsl:for-each>
	</xsl:for-each>
	<xsl:for-each select="Row[normalize-space(record_type) != 'ACTIVE']">
		<b>License:</b>&cr;
		<xsl:call-template name="name_address"/>
		Expiration Date: <xsl:value-of select="concat(substring(med_exp_date,1,2),'/',substring(med_exp_date,3,4))"/>&cr;
		Certification Date: <xsl:value-of select="concat(substring(med_date,1,2),'/',substring(med_date,3,4))"/>&cr;
		Class: <xsl:value-of select="med_class"/>&cr;
		Record Type: <xsl:value-of select="record_type"/>&cr;
		Certificate:&cr;
		<xsl:variable name="uid" select="unique_id"></xsl:variable>
		<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/pilot_certificates_children/Row[unique_id=$uid]">
			&space;&space;&space;Type: <xsl:value-of select="cer_type_mapped"/>&cr;
			&space;&space;&space;Level: <xsl:value-of select="cer_level_mapped"/>&cr;
			&space;&space;&space;Ratings: <xsl:value-of select="ratings"/>&cr;
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>

	<!-- Aircraft -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/pilot_aircraft_children">
	<h2> FAA Aircraft Records </h2>
	<xsl:for-each select="Row">
		<b>Aircraft</b>&cr;
		Serial Number: <xsl:value-of select="serial_number"/>&cr;
		Aircraft Number: <xsl:value-of select="n_number"/>&cr;
		Record Type: <xsl:if test="current_flag = 'A'">Active</xsl:if>
	                  <xsl:if test="current_flag = 'H'">Historical</xsl:if>&cr;
		Description: <xsl:value-of select="year_mfr"/> - <xsl:value-of select="aircraft_mfr_name"/>&space;<xsl:value-of select="model_name"/>&cr;
		Status: <xsl:value-of select='current_flag_mapped'/> &cr;
		County Name: <xsl:value-of select='county_name'/> &cr;
		<B>Engine Info</B>&cr;
		<xsl:for-each select='engine_info/Row'>
			Type of Engine: <xsl:value-of select='engine_type_mapped'/> &cr;
			Engine Manufacturer Name: <xsl:value-of select='engine_mfr_name'/> &cr;
			Engine HP: <xsl:value-of select='engine_hp_or_thrust'/> &cr;
			Engine Model: <xsl:value-of select='model_name'/> &cr;
		</xsl:for-each>
		<b>Craft Info</b>&cr;
		<xsl:for-each select='craft_info/Row'>
			Manufacturer Name: <xsl:value-of select='aircraft_mfr_name'/> &cr;
			Model: <xsl:value-of select='model_name'/> &cr;
			Type of aircraft: <xsl:value-of select='aircraft_type_mapped'/> &cr;
			Type of Engine: <xsl:value-of select='engine_type_mapped'/> &cr;
			Number of engines: <xsl:value-of select='number_of_engines'/> &cr;
			Number of seats: <xsl:value-of select='number_of_seats'/> &cr;
			Category: <xsl:value-of select='category_mapped'/> &cr;
			Amateur Certification: <xsl:value-of select='amateur_certification_mapped'/> &cr;
		</xsl:for-each>
	</xsl:for-each>
</xsl:template>


    <!-- Watercraft -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/watercraft_children">
  <H2>Watercraft:</H2>
	<xsl:for-each select="Row">
	<b>Vessel:</b>&cr;
          Hull Number: <xsl:value-of select="hull_number"/>&cr;
		Description: <xsl:value-of select="model_year"/>&space;<xsl:value-of select="watercraft_length"/>&space;<xsl:value-of select="watercraft_make_description"/>&space;(<xsl:value-of select="hull_type_description"/>)&space;<xsl:value-of select="use_description"/>&cr; 
	     Record Type: <xsl:value-of select="rec_type"/>&cr;
   	     <i>Owner(s):</i>&cr;	
		<xsl:for-each select="owners/Row">
			Name-Address: <xsl:call-template name="name_address"/>
		</xsl:for-each>
		<i>Vessel Information:</i>&cr;
		Vessel Name: <xsl:value-of select="name_of_vessel"/>&cr;
		Hull Number: <xsl:value-of select="hull_number"/>&cr;
		Vessel Service Type: <xsl:value-of select="use_description"/>&cr;
		Length: <xsl:value-of select="watercraft_length"/>
			   <xsl:if test="normalize-space(watercraft_length)='' and normalize-space(registered_length)!=''"> 
                          <xsl:value-of select="registered_length"/>
			   </xsl:if>&cr;
	     Gross Tons: <xsl:value-of select="registered_gross_tons"/>&cr;	
		Net Tons: <xsl:value-of select="registered_net_tons"/>&cr;
		Breadth: <xsl:value-of select="registered_breadth"/>&cr;
		Depth: <xsl:value-of select="registered_depth"/>&cr;
		Shipyard: <xsl:value-of select="ship_yard"/>&cr;
		Year Built: <xsl:value-of select="vessel_build_year"/>&cr;
		Vessel Complete Place: <xsl:value-of select="vessel_complete_build_city"/>&space;<xsl:value-of select="vessel_complete_build_state"/>&space;<xsl:value-of select="vessel_complete_build_country"/>
		                       <xsl:if test="normalize-space(vessel_complete_build_state)='' and normalize-space(vessel_complete_build_province)!=''"> 
                                      <xsl:value-of select="vessel_complete_build_city"/>&space;<xsl:value-of select="vessel_complete_build_province"/>&space;<xsl:value-of select="vessel_complete_build_country"/>
			                  </xsl:if>&cr;	
		Hull Build Place: <xsl:value-of select="vessel_hull_build_city"/>&space;<xsl:value-of select="vessel_hull_build_state"/>&space;<xsl:value-of select="vessel_hull_build_country"/>
		                       <xsl:if test="normalize-space(vessel_hull_build_state)='' and normalize-space(vessel_hull_build_province)!=''"> 
                                      <xsl:value-of select="vessel_hull_build_city"/>&space;<xsl:value-of select="vessel_hull_build_province"/>&space;<xsl:value-of select="vessel_hull_build_country"/>
			                  </xsl:if>&cr;	
		Hailing Port: <xsl:value-of select="hailing_port"/>&cr;
		&cr;
	</xsl:for-each>
</xsl:template>


	<!-- Bankruptcy -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/bankruptcies_children">
	<h2>Bankruptcies</h2>
	<xsl:for-each select="Row">
		Date Filed:&space;<xsl:value-of select="orig_filing_date"/>&space;Chapter: <xsl:value-of select="orig_chapter"/>&space;Disposition Date: <xsl:value-of select="disposed_date"/>    Disposition: <xsl:value-of select="disposition"/>&cr;
		Filing Status: <xsl:value-of select="filer_type_mapped"/>&space;<xsl:value-of select="filing_status"/>&cr;
		Case Number: <xsl:value-of select="case_number"/>&space;Court Location: <xsl:value-of select = "court_state"/> - <xsl:value-of select="court_location"/>&cr;
		<xsl:for-each select="debtor_records/Row">
	    	     Debtor Type:&space;<xsl:value-of select="debtor_type"/>&space;Debtor SSN:&space;<xsl:value-of select="debtor_ssn"/>&cr;
			<xsl:for-each select="names/Row">
			     Debtor Name:&space;<xsl:value-of select="debtor_title"/>&space;<xsl:value-of select="debtor_fname"/>&space;<xsl:value-of select="debtor_mname"/>&space;<xsl:value-of select="debtor_lname"/>&space;<xsl:value-of select="debtor_name_suffix"/>&space;Debtor Company:&space;<xsl:value-of select="debtor_company"/>&cr;
			</xsl:for-each>
			<xsl:for-each select="addresses/Row">
			     Debtor Address:&space;<xsl:value-of select="prim_range"/>&space;<xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="suffix"/>&space;<xsl:value-of select="postdir"/>&space;
	                                     <xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;<xsl:value-of select="v_city_name"/>&space;<xsl:value-of select="st"/>,&space;<xsl:value-of select="z5"/>-<xsl:value-of select="zip4"/>,&space;<xsl:value-of select="county_name"/>&space;COUNTY&cr;
			</xsl:for-each>
		</xsl:for-each>
		Assets available for unsecured creditors:&space;<xsl:value-of select="assets_no_asset_indicator"/>&cr;
          <!--The below is a guess-->
		Debtor is self-represented:&space;<xsl:if test="pro_se_ind = 'Y'">Yes</xsl:if>
								 <xsl:if test="pro_se_ind != 'Y'">No</xsl:if>&cr;
		Liabilities:&space;<xsl:value-of select="liabilities_only"/>&space;&space;Assets: <xsl:value-of select="assets_only"/>&space;&space;Exempt: <xsl:value-of select="exempt_only"/>&cr;
          <!--The below is a guess-->
		Attorney: &space;<xsl:value-of select="attorney_name"/>&cr;
		Attorney Phone: &space;<xsl:value-of select="attorney_phone"/>&cr;
		Trustee: &space;<xsl:value-of select="trustee_name"/>&cr;
		Trustee Phone: &space;<xsl:value-of select="trustee_phone"/>&cr;
		Judge Assigned:&space;<xsl:value-of select="judge_name"/>&cr;
		Creditors Meeting Date:&space;<xsl:value-of select="meeting_date"/>&cr;
		Creditors Meeting Location:&space;<xsl:value-of select="address_341"/>&cr;
		Complaints Deadline:&space;<xsl:value-of select="complaint_deadline"/>&cr;
		Claims Deadline:&space;<xsl:value-of select="claims_deadline"/>&cr;&cr;
	</xsl:for-each>       
</xsl:template>

	<!-- Liens and Judgements -->
<xsl:template match = "/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/liens_judgements_children">
	<h2>Liens and Judgements</h2>
	<xsl:for-each select="Row">
		<b>Case</b>&cr;
		Debtor Name: <xsl:value-of select="def_title"/> &space;<xsl:value-of select="def_fname"/> &space;<xsl:value-of select="def_mname"/> &space;<xsl:value-of select="def_lname"/> &space; <xsl:value-of select="def_name_suffix"/> &cr;
		Debtor SSN: <xsl:value-of select="ssn_appended"/>&cr;
		Debtor Address: <xsl:value-of select="prim_range"/>&space;
			<xsl:value-of select="predir"/>&space;<xsl:value-of select="prim_name"/>&space;<xsl:value-of select="suffix"/>&space;<xsl:value-of select="postdir"/>&space;
			<xsl:value-of select="unit_desig"/>&space;<xsl:value-of select="sec_range"/>&space;
			<xsl:value-of select="v_city_name"/>
			&space;
			<xsl:value-of select="st"/>&space;<xsl:value-of select="zip"/><xsl:if test="normalize-space(zip4)!=''">-</xsl:if><xsl:value-of select="zip4"/> &cr;
		Filing Date: <xsl:value-of select="filing_date"/>&cr;
		Amount: <xsl:value-of select="amount"/> &cr;
		Book/Page: <xsl:value-of select="book"/> / <xsl:value-of select="page"/> &cr;
		Creditor: <xsl:value-of select="plaintiff"/> &cr;
		Case Number: <xsl:value-of select="casenumber"/> &cr;
		Court: <xsl:value-of select="court_desc"/> &cr;
		Filing Type: <xsl:value-of select="filingtype_desc"/> &cr;
		Release Date: <xsl:value-of select="release_date"/> &cr;
		Original Case Number: <xsl:value-of select="origcase"/> &cr;
		&cr;&cr;
	</xsl:for-each>
</xsl:template>

	<!-- Civil Court -->
<!--		Removed from comp report, not used in moxie.
		I'm leaving the code here in case we put it back
		11/29/04
		
		<xsl:template match ="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/civil_court_children">
			<h2> Civil Court Records </h2>
			<xsl:for-each select='Row'>
				<xsl:if test='normalize-space(entity_1) != ""'> 
					<xsl:value-of select="entity_type_description_1_orig"/> : <xsl:value-of select="entity_1"/>&cr;
				</xsl:if>
				<xsl:if test='normalize-space(primary_entity_2) != ""'>
					<xsl:value-of select="entity_type_description_2_orig"/> : <xsl:value-of select="primary_entity_2"/>&cr;
				</xsl:if>
				City: <xsl:value-of select="v_city_name1"/>&cr;
				State: <xsl:value-of select="st1"/>&cr;
				Case Title: <xsl:value-of select="case_title"/>&cr;
				Case Type: <xsl:value-of select="case_type"/>&cr;
				State Of Origin: <xsl:value-of select="state_origin"/>&cr; 
				Jurisdiction: <xsl:value-of select="court"/>&cr;
			</xsl:for-each>
		</xsl:template>
-->
	<!--    Corporate Affiliations -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/corporate_affiliations_children">
    <h2>Corporate Affiliations</h2>
    <xsl:for-each select="Row">
       Corporation Name:&space;<xsl:value-of select="corporation_name"/>&cr;
       Corporation Status: &space;<xsl:value-of select="corporation_status"/>&cr;
       Charter Number: &space;<xsl:value-of select="charter_number"/>&cr;
       State of Origin:&space;<xsl:value-of select="state_origin"/>&cr;
       Filing Date:&space;<xsl:value-of select="filing_date"/>&cr;
       Affiliation:&space;<xsl:value-of select="affiliation"/>, <xsl:value-of select="contact_name"/>&cr;
       Address: <xsl:call-template name="name_address"/>
       Address Type: <xsl:value-of select="address_type"/>&cr;&cr;
    </xsl:for-each>
</xsl:template>

	<!-- Hunting and Fishing -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/hunting_licenses_children">
	<h2>Hunting/Fishing Permit:</h2>
	<xsl:for-each select="Row">
		<b>License:</b>&cr;
		<xsl:call-template name="name_dob"/>
		<xsl:call-template name="name_address"/>
		Gender: <xsl:value-of select="gender_name"/>&cr;
		Permit date: <xsl:value-of select="concat(substring(datelicense,7,2),'/',substring(datelicense,5,2),'/',substring(datelicense,1,4))"/>&cr;
		Permit: <xsl:value-of select="huntfishperm"/>&cr;
		Permit Type: <xsl:value-of select="license_type_mapped"/>&cr;
		Home State: <xsl:value-of select="homestate"/>&cr;
		Permit State: <xsl:value-of select="source_state"/>&cr;
     </xsl:for-each>
</xsl:template>

	<!-- Concealed Weapons -->
<xsl:template match = "/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/concealed_weapon_licenses_children">
	<h2>Concealed Weapons Permits</h2>
	<h3>Subject</h3>
	<xsl:for-each select='Row[number(did) = number($Main_Did)]'>
		<b>License</b>&cr;
		<xsl:call-template name = 'name_dob'/>
		<xsl:call-template name = 'name_address'/>
		Gender: <xsl:call-template name="std_gender"><xsl:with-param name="gender_field" select="gender"/></xsl:call-template> &cr;
		Race: <xsl:call-template name="std_race"><xsl:with-param name="race_field" select="race"/></xsl:call-template> &cr;
		Permit State: <xsl:value-of select="source_state"/>&cr;
		Permit Number: <xsl:value-of select="ccwpermnum"/>&cr;
		Permit Type: <xsl:value-of select="ccwpermtype"/>&cr;
		Registration Date: <xsl:value-of select="ccwregdate"/>&cr;
		Expiration Date: <xsl:value-of select="ccwexpdate"/>&cr;
	</xsl:for-each>
	<xsl:for-each select='Row[number(did) != number($Main_Did)]'>
		<xsl:if test="position() = 1">
			<h3>Associates, Neighbors, and Relatives</h3>
		</xsl:if>
		<b>License</b>&cr;
		<xsl:call-template name = 'name_dob'/>
		<xsl:call-template name = 'name_address'/>
		Gender: <xsl:call-template name="std_gender"><xsl:with-param name="gender_field" select="gender"/></xsl:call-template> &cr;
		Race: <xsl:call-template name="std_race"><xsl:with-param name="race_field" select="race"/></xsl:call-template> &cr;
		Permit State: <xsl:value-of select="source_state"/>&cr;
		Permit Number: <xsl:value-of select="ccwpermnum"/>&cr;
		Permit Type: <xsl:value-of select="ccwpermtype"/>&cr;
		Registration Date: <xsl:value-of select="ccwregdate"/>&cr;
		Expiration Date: <xsl:value-of select="ccwexpdate"/>&cr;
	</xsl:for-each>
</xsl:template>

    <!--Sex_Offenses-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/sex_offenses_children">
    <H2>Sexual Offenses</H2>
    <xsl:for-each select="Row[number(did) = number($Main_Did)]">
		<b>Instance:</b>&cr;
		<xsl:for-each select="name/Row">
			 <xsl:if test="position()=1">Name:</xsl:if><xsl:if test="position()=2">&cr;AKAS:</xsl:if>
			 <xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/>&space;<xsl:value-of select="name_suffix"/>
		</xsl:for-each>&cr;
		Registration Date 1: <xsl:value-of select="reg_date_1"/>&cr;
		Registration Type 1: <xsl:value-of select="reg_date_1_type"/>&cr;
		Registration Date 2: <xsl:value-of select="reg_date_2"/>&cr;
		Registration Type 2: <xsl:value-of select="reg_date_2_type"/>&cr;
		Registration Date 3: <xsl:value-of select="reg_date_3"/>&cr;
		Registration Type 3: <xsl:value-of select="reg_date_3_type"/>&cr;
		Address:<xsl:call-template name="name_address"/>        
		Date Last Seen: <xsl:value-of select="dt_last_reported"/>&cr;
		SSN: <xsl:value-of select="ssn_appended"/>&cr;
		Sex: <xsl:call-template name="std_gender"><xsl:with-param name="gender_field" select="sex"/></xsl:call-template> &cr;
		DOB: <xsl:value-of select="dob"/>&cr;
		Hair Color: <xsl:value-of select="hair_color"/>&cr;
		Eye Color: <xsl:value-of select="eye_color"/>&cr;
		Height: <xsl:value-of select="height"/>&cr;
		Weight: <xsl:value-of select="weight"/> lbs&cr;
		Race: <xsl:call-template name="std_race"><xsl:with-param name='race_field' select="race"/></xsl:call-template>
		Scars, Marks, and Tattoos: <xsl:value-of select="scars_marks_tattoos"/>&cr;
		<xsl:for-each select="offenses/Row">
			Offense: <xsl:value-of select="offense_description"/>&cr;
			Victim's Gender: <xsl:call-template name='std_gender'><xsl:with-param name='gender_field' select="victim_gender"/></xsl:call-template> &cr;
			Victim is Minor: <xsl:value-of select="victim_minor_name"/>&cr;
		</xsl:for-each>
		State of Origin: <xsl:value-of select="orig_state"/>&cr;
	</xsl:for-each>
	<xsl:for-each select="Row[number(did) != number($Main_Did)]">
		<xsl:if test="position() = 1">
		<h3>Relatives, Neighbors, and Associates</h3>
		</xsl:if>
		<b>Instance:</b>&cr;
		<xsl:for-each select="name/Row">
			 <xsl:if test="position()=1">Name:</xsl:if><xsl:if test="position()=2">&cr;AKAS:</xsl:if>
			 <xsl:value-of select="fname"/>&space;<xsl:value-of select="mname"/>&space;<xsl:value-of select="lname"/>&space;<xsl:value-of select="name_suffix"/>
		</xsl:for-each>&cr;
		Registration Date 1: <xsl:value-of select="reg_date_1"/>&cr;
		Registration Type 1: <xsl:value-of select="reg_date_1_type"/>&cr;
		Registration Date 2: <xsl:value-of select="reg_date_2"/>&cr;
		Registration Type 2: <xsl:value-of select="reg_date_2_type"/>&cr;
		Registration Date 3: <xsl:value-of select="reg_date_3"/>&cr;
		Registration Type 3: <xsl:value-of select="reg_date_3_type"/>&cr;
		Address:<xsl:call-template name="name_address"/>        
		Date Last Seen: <xsl:value-of select="dt_last_reported"/>&cr;
		SSN: <xsl:value-of select="ssn_appended"/>&cr;
		Sex: <xsl:call-template name="std_gender"><xsl:with-param name="gender_field" select="sex"/></xsl:call-template> &cr;
		DOB: <xsl:value-of select="dob"/>&cr;
		Hair Color: <xsl:value-of select="hair_color"/>&cr;
		Eye Color: <xsl:value-of select="eye_color"/>&cr;
		Height: <xsl:value-of select="height"/>&cr;
		Weight: <xsl:value-of select="weight"/> lbs&cr;
		Race: <xsl:call-template name="std_race"><xsl:with-param name='race_field' select="race"/></xsl:call-template>
		Scars, Marks, and Tattoos: <xsl:value-of select="scars_marks_tattoos"/>&cr;
		<xsl:for-each select="offenses/Row">
			Offense: <xsl:value-of select="offense_description"/>&cr;
			Victim's Gender: <xsl:call-template name='std_gender'><xsl:with-param name='gender_field' select="victim_gender"/></xsl:call-template> &cr;
			Victim is Minor: <xsl:if test="victim_minor = 'Y'">Yes</xsl:if><xsl:if test="victim_minor = 'N'">No</xsl:if>&cr;
		</xsl:for-each>
		State of Origin: <xsl:value-of select="orig_state"/>&cr;
	</xsl:for-each>
</xsl:template>    

	<!--Merchant Vessels-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/merchant_vessels_children">
    <H2>Merchant Vessels</H2>
    <xsl:for-each select="Row">
       <b>Vessel:</b>&cr;
              Hull Number: <xsl:value-of select="hull_number"/>&cr;
              Description:<xsl:value-of select="vessel_build_year"/>&space;<xsl:value-of select="registered_length"/>'&space;<xsl:value-of select="hull_material"/>&space;<xsl:value-of select="vessel_service_type"/>&cr;
              Vessel Number: <xsl:value-of select="vessel_id"/>&cr;
              Record Type: <xsl:value-of select="recordtype"/>&cr;
              Owner:&space; <xsl:call-template name="name_address"/>
              Vessel Information&cr;
                     Vessel Name: <xsl:value-of select="name_of_vessel"/>&cr;
                     Hull Number: <xsl:value-of select="hull_number"/>&cr;
                     Vessel Service Type: <xsl:value-of select="vessel_service_type"/>&cr;
                     <xsl:if test="normalize-space(self_propelled_indicator)">
                     Self Propelled: Yes&cr;
                     </xsl:if>
                     <xsl:if test="normalize-space(self_propelled_indicator) = ''">
                     Self Propelled: No&cr;
                     </xsl:if>
                     Length: <xsl:value-of select="registered_length"/>'&cr;
                     Gross Tons: <xsl:value-of select="registered_gross_tons"/>&cr;
                     Breadth: <xsl:value-of select="registered_breadth"/>'&cr;
                     Net Tons: <xsl:value-of select="registered_net_tons"/>&cr;
                     Depth: <xsl:value-of select="registered_depth"/>'&cr;
                     Shipyard: <xsl:value-of select="ship_yard"/>&cr;
                     Year Built: <xsl:value-of select="vessel_build_year"/>&cr;
                     Place Built: <xsl:value-of select="vessel_complete_build_city"/>&cr;
                     Hull Builder: <xsl:value-of select="hull_builder_name"/>&cr;
                     Hailing Port: <xsl:value-of select="hailing_port"/>&cr;
        </xsl:for-each>
    </xsl:template>
  
	<!-- Images -->

<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/images_children">
	<h2>Images</h2>
	<xsl:for-each select="Row">
		<b>Image Available</b>&cr;
		State : <xsl:value-of select="state"/>&cr;
		Source: <xsl:value-of select="source"/> - <xsl:value-of select="rtype"/>&cr;
		ID:     <xsl:value-of select="id"/> &cr; 
		Date  : <xsl:value-of select="date"/>&cr;
	</xsl:for-each>
</xsl:template>  

	<!-- Whois Domains -->

<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/netdomain_children">
	<h2>Internet Domains</h2>
	<xsl:for-each select="Row">
		Owner: <xsl:value-of select="registrant_name"/> &cr;
		Domain: <xsl:value-of select="domain_name"/>&cr;&cr;
	</xsl:for-each>
</xsl:template>


<!-- ================== Old phones ======================== -->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/phones_old_children">
  <h2>Old Phone Records</h2>
  <xsl:for-each select="Row">
    <b>Phone:</b> <xsl:value-of select="phone"/>&space;&space;
    First Seen: <xsl:value-of select="dt_first_seen"/>&space;&space;
    Last Seen: <xsl:value-of select="dt_last_seen"/>&space;&space;
    (Zip: <xsl:value-of select="zip"/>-<xsl:value-of select="zip4"/>) &cr;
  </xsl:for-each>
</xsl:template>

   <!-- Remove auto-expansion of datasets handled elsewhere-->
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/nbrhoods_children"/>
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/property_assessor_children"/>
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/phones_children"/>
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/ssn_lookups_children"/>
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/names_children"/>
<xsl:template match="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/pilot_certificates_children"/>
<xsl:template match="/child::node()/Results/Result/Exception">
Exception : <xsl:value-of select="Message"/>&cr;
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
   <xsl:if test="dob!='0'"> DOB: <xsl:value-of select="concat(substring(dob,5,2),'/',substring(dob,7,2),'/',substring(dob,1,4))"/>&space;
   </xsl:if>
    <xsl:if test="age!=0"> Age: <xsl:value-of select="age"/>&space;</xsl:if>
   <xsl:if test="normalize-space(ssn)!=''">
   SSN: <a><xsl:attribute name="href">../Doxie/Doxie.HeaderFileSearchService?SSN=<xsl:value-of select="ssn"/></xsl:attribute><xsl:value-of select="ssn"/></a>
   <xsl:variable name="ssn5" select="substring(ssn,1,5)"/>
   <xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/ssn_lookups_children/Row[ssn5=$ssn5]">
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

    <!--Name and Address from common data-->
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
			<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/phones_children/Row[normalize-space(prim_name)=$pn and normalize-space(prim_range)=$pr and (normalize-space(sec_range)=$sr or normalize-space(sec_range)='')]">
				At Address: &space;<a><xsl:attribute name="href">../Doxie/Doxie.GongSearchService?Phone=<xsl:value-of select="phone"/></xsl:attribute><xsl:value-of select="concat('(',substring(phone,1,3),') ',substring(phone,4,3),'-',substring(phone,7,5))"/></a>&space;<xsl:value-of select="listing_name"/>&cr;
			</xsl:for-each>
			<xsl:variable name="stt" select="normalize-space(st)"/>
			<xsl:variable name="county" select="normalize-space(county)"/>
			<xsl:variable name="trct" select="substring(geo_blk,1,6)"/>
			<xsl:variable name="blk" select="substring(geo_blk,7,1)"/>
			<!-- Neighborhoods -->
			<xsl:for-each select="/child::node()/Results/Result/Dataset[@name = 'CRS_result']/Row/nbrhoods_children/Row[normalize-space(stusab)=$stt and normalize-space(county)=$county and normalize-space(blkgrp)=$blk and normalize-space(tract)=$trct]">
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