
/*--SOAP--
<message name="BeneficiaryRiskScore_Batch_Service">

	<part name="BRScore_batch_in"            type="tns:XmlDataSet" cols="70" rows="20"/>
	<part name="IncludeRealTimeMotorVehicle" type="xsd:boolean"/>

	<!-- =====[ Options: bocashell things ]===== -->
	<part name="ExcludeRelatives"       type="xsd:boolean" comment="bocashell"/>
	<part name="IncludeScore"           type="xsd:boolean" comment="bocashell"/>
	<part name="ADLBasedShell"          type="xsd:boolean" comment="bocashell"/>
	<part name="RemoveFares"            type="xsd:boolean" comment="bocashell"/>
	<part name="LeadIntegrityMode"      type="xsd:boolean" comment="bocashell"/>

	<!-- =====[ System ]===== -->

	<!-- =====[ Permissions ]===== -->
	<part name="DPPAPurpose"            type="xsd:byte"/>
	<part name="GLBPurpose"             type="xsd:byte"/>

	<!-- =====[ Restrictions ]===== -->
	<part name="DataRestrictionMask"    type="xsd:string"/>
	<part name="DataPermissionMask"     type="xsd:string"/>
	<part name="IndustryClass"          type="xsd:string"/>

	<!-- =====[ Query behavior ]===== -->
	<part name="BSVersion"              type='xsd:integer'/>
	<part name="RelativeDepthLevel"     type="xsd:byte"/>    <!-- 1,2,3 -->

	<!-- =====[ Gateways ]===== -->
	<part name="RealTimePermissibleUse" type="xsd:string"/>
	<part name="Gateways"               type="tns:XmlDataSet" cols="110" rows="10" comment="bocashell"/> <!-- optional -->
</message>
*/
/*--INFO--      */
/*--HELP--
<pre>
&lt;dataset&gt;
   &lt;row&gt;
      &lt;acctno&gt;&lt;/acctno&gt;
      &lt;seq&gt;&lt;/seq&gt;
      &lt;history_date&gt;&lt;/history_date&gt;
      &lt;historyDateTimeStamp&gt;&lt;/historyDateTimeStamp&gt;
      &lt;did_value&gt;&lt;/did_value&gt;
      &lt;full_name_value&gt;&lt;/full_name_value&gt;
      &lt;first_name_value&gt;&lt;/first_name_value&gt;
      &lt;middle_name_value&gt;&lt;/middle_name_value&gt;
      &lt;last_name_value&gt;&lt;/last_name_value&gt;
      &lt;name_suffix_value&gt;&lt;/name_suffix_value&gt;
      &lt;addr1_value&gt;&lt;/addr1_value&gt;
      &lt;addr2_value&gt;&lt;/addr2_value&gt;
      &lt;city_value&gt;&lt;/city_value&gt;
      &lt;state_value&gt;&lt;/state_value&gt;
      &lt;zip_value&gt;&lt;/zip_value&gt;
      &lt;country_value&gt;&lt;/country_value&gt;
      &lt;ssn_value&gt;&lt;/ssn_value&gt;
      &lt;dob_value&gt;&lt;/dob_value&gt;
      &lt;age_value&gt;&lt;/age_value&gt;
      &lt;dl_number_value&gt;&lt;/dl_number_value&gt;
      &lt;dl_state_value&gt;&lt;/dl_state_value&gt;
      &lt;email_value&gt;&lt;/email_value&gt;
      &lt;ip_value&gt;&lt;/ip_value&gt;
      &lt;phone_value&gt;&lt;/phone_value&gt;
      &lt;wphone_value&gt;&lt;/wphone_value&gt;
      &lt;employer_name_value&gt;&lt;/employer_name_value&gt;
      &lt;prev_lname_value&gt;&lt;/prev_lname_value&gt;
      &lt;case_number&gt;&lt;/case_number&gt;
      &lt;benefit_claim_amount&gt;&lt;/benefit_claim_amount&gt;
      &lt;benefits_issued_state&gt;&lt;/benefits_issued_state&gt;
      &lt;date_applied_for_benefits&gt;&lt;/date_applied_for_benefits&gt;
      &lt;mvr_vehicle_value&gt;&lt;/mvr_vehicle_value&gt;
      &lt;number_mvrs_reported&gt;&lt;/number_mvrs_reported&gt;
      &lt;number_properties_reported&gt;&lt;/number_properties_reported&gt;
      &lt;number_adults_in_household&gt;&lt;/number_adults_in_household&gt;
      &lt;filler_field_1&gt;&lt;/filler_field_1&gt;
   &lt;/row&gt;
&lt;/dataset&gt;
</pre>
*/

IMPORT address, risk_indicators, models, riskwise, ut, gateway;

EXPORT BeneficiaryRiskScore_Batch_Service() := MACRO
 #CONSTANT('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
	// For the PostBeneficiaryFraud attributes, we want all of them to run; and only the
	// Real-Time Vehicles if chosen explicitly by the customer.
	#STORED('IncludeAllAttributeCategories', TRUE);
	
  UCase := StringLib.StringToUpperCase;
	STRING8 todays_date_full := StringLib.GetDateYYYYMMDD();
	
	// Define batch input dataset.
	batchin_raw := 
		DATASET([],Models.BeneficiaryRiskScore_Layouts.SearchSubject) : STORED('BRScore_batch_in',FEW);

	// Apply rules to a few of the input values. According to the Modeling team, the history_date
	// (expressed as usual, as YYYYMM) shall be based on the date the customer applied for benefits,
	// if provided. 
	batchin := 
		PROJECT(
			batchin_raw,
			TRANSFORM( Models.BeneficiaryRiskScore_Layouts.SearchSubject,
				SELF.history_date := 
					MAP( 
						LEFT.date_applied_for_benefits != '' => (UNSIGNED3)(LEFT.date_applied_for_benefits[1..6]),
						LEFT.history_date              !=  0 => LEFT.history_date, 
						Risk_Indicators.iid_constants.default_history_date // default
					);
				SELF.date_applied_for_benefits := 
					MAP( 
						LEFT.date_applied_for_benefits != '' => LEFT.date_applied_for_benefits,
						LEFT.history_date NOT IN [0, 999999] => (STRING8)(LEFT.history_date * 100 + 1), 
						todays_date_full // default
					);
				SELF.mvr_vehicle_value          := IF( LEFT.mvr_vehicle_value = ''         , '10000', LEFT.mvr_vehicle_value );
				SELF.number_mvrs_reported       := IF( LEFT.number_mvrs_reported = ''      , '0'    , LEFT.number_mvrs_reported );
				SELF.number_properties_reported := IF( LEFT.number_properties_reported = '', '0'    , LEFT.number_properties_reported );
				SELF.number_adults_in_household := IF( LEFT.number_adults_in_household = '', '0'    , LEFT.number_adults_in_household );
				SELF := LEFT,
				SELF := []
			)
		);
		
	// Define query restrictions and search options.
	restrictions  := Models.BeneficiaryRiskScore_Functions.get_restriction_params();
	bsSvcOptions  := Models.BeneficiaryRiskScore_Functions.get_InputSearchOptions_BocaShell();
	pbfSvcOptions := Models.BeneficiaryRiskScore_Functions.get_InputSearchOptions_PostBeneficiaryFraud();
	
	// Define the gateways for MVR.
	gateways := Models.BeneficiaryRiskScore_Functions.get_gateways(bsSvcOptions);

	// Filter out any records having invalid input. The minimum requirements for input file are:
	// acctno, Name (full or parsed) and Address (street, city, state, zip) or
	// acctno, Name (full or parsed) and SSN
	batchin_valid := 
		batchin(
			acctno != '' AND 
			(full_name_value != '' OR (last_name_value != '' AND first_name_value != '')) AND
			(ssn_value != '' OR addr1_value != '')
		);
	
	// Instantiate _Records module...
	records := 
		Models.BeneficiaryRiskScore_Records(batchin_valid, gateways, bsSvcOptions, pbfSvcOptions, restrictions);
	
	// ...and assign result datasets.
	pbf_fraud_results := records.postbeneficiaryfraud_results;
	
	// Append 'score' field.
	results := PROJECT( pbf_fraud_results, Models.BeneficiaryRiskScore_Layouts.Batch_Final );

	OUTPUT( results, NAMED('Results') );

ENDMACRO;
