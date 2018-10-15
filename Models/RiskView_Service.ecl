/*--SOAP--
<message name="RiskView_Service">
	<part name="DID" type="xsd:unsigned"/>
	<part name="AccountNumber" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="Country" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="Age" type="xsd:unsignedInt"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
	<part name="Email" type="xsd:string"/>
	<part name="IPAddress" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="WorkPhone" type="xsd:string"/>
	<part name="EmployerName" type="xsd:string"/>
	<part name="FormerName" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="Attributes" type="xsd:boolean"/>
	<part name="IntendedPurpose" type="xsd:string"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="scores" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="RequestedAttributeGroups" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="InPersonApplication" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
  <part name="AddressAppend" type="xsd:boolean"/>
	<part name="FFDOptionsMask"	type="xsd:string"/>	
 </message>
*/
/*--INFO-- Contains RiskView Scores AirWaves, Auto, Bankcard, Retail and Money and Attributes */

IMPORT Risk_Reporting;

export RiskView_Service := MACRO

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'DID',
	'AccountNumber',
	'UnParsedFullName',
	'FirstName',
	'MiddleName',
	'LastName',
	'NameSuffix',
	'StreetAddress',
	'City',
	'State',
	'Zip',
	'Country',
	'SSN',
	'DateOfBirth',
	'Age',
	'DLNumber',
	'DLState',
	'Email',
	'IPAddress',
	'HomePhone',
	'WorkPhone',
	'EmployerName',
	'FormerName',
	'IndustryClass',
	'HistoryDateYYYYMM',
	'Attributes',
	'IntendedPurpose',
	'TestDataEnabled',
	'TestDataTableName',
	'scores',
	'RequestedAttributeGroups',
	'gateways',
	'InPersonApplication',
	'DataRestrictionMask',
	'DataPermissionMask',
	'OutcomeTrackingOptOut',
	'AddressAppend',
	'FFDOptionsMask'
	));
	
	/* **********************************************
		 *  Fields needed for improved Scout Logging  *
		 **********************************************/
		string32 _LoginID           := ''	: STORED('_LoginID');
		string20 CompanyID          := '' : STORED('_CompanyID');
		string20 FunctionName       := '' : STORED('_LogFunctionName');
		string50 ESPMethod          := '' : STORED('_ESPMethodName');
		string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
		string10 SSN_Mask           := '' : STORED('SSNMask');
		string10 DOB_Mask	          := ''	: STORED('DOBMask');
		string1 DL_Mask             := ''	: STORED('DLMask');
		string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
		string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
		string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
		BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
		string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');
		boolean   Test_Data_Enabled := false   	: stored('TestDataEnabled');
		
	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(TRUE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__RiskView_Service);
	/* ************* End Scout Fields **************/

	Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

	unsigned6 did_value := 0				: stored('DID');
  string120	fullname_value :=	''	: stored('UnParsedFullName');
  string8   dob_value := ''      	: stored('DateOfBirth');
	string120 addr_value := ''    	: stored('StreetAddress');
	string25  city_value := ''     	: stored('City');
	string2   state_value := ''     : stored('State');
	string5   zip_value := ''      	: stored('Zip');
	string9   ssn_value := ''      	: stored('ssn');
	string20  drlc_value := ''    	: stored('DLNumber');
	string2   drlcstate_value := '' : stored('DLState');
  string10  hphone_value := ''   	: stored('HomePhone');
	string10  wphone_value := ''  	: stored('WorkPhone');
	string50 DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
	string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

	Layout_Attributes_In := RECORD
		string name;
	END;

	model_url1 := dataset([],Models.Layout_Score_Chooser) 		: stored('scores',few);
	attributesIn := dataset([],Layout_Attributes_In)			: stored('RequestedAttributeGroups',few);
	gateways_in := Gateway.Configuration.Get();
	model_url := if( exists(model_url1) or exists(attributesIn), model_url1, fail(Models.Layout_Score_Chooser, 'No scores or attributes requested'));

	model_count := count(model_url);

	riskview_xml := Models.RiskView_Records;

	//Log to Deltabase
	Deltabase_Logging_prep := project(riskview_xml, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																					 self.company_id := (Integer)CompanyID,
																					 self.login_id := _LoginID,
																					 self.product_id := Risk_Reporting.ProductID.Models__RiskView_Service,
																					 self.function_name := FunctionName,
																					 self.esp_method := ESPMethod,
																					 self.interface_version := InterfaceVersion,
																					 self.delivery_method := DeliveryMethod,
																					 self.date_added := (STRING8)Std.Date.Today(),
																					 self.death_master_purpose := DeathMasterPurpose,
																					 self.ssn_mask := SSN_Mask,
																					 self.dob_mask := DOB_Mask,
																					 self.dl_mask := DL_Mask,
																					 self.exclude_dmv_pii := ExcludeDMVPII,
																					 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																					 self.archive_opt_in := ArchiveOptIn,
                                           self.glb := 0,  //hardcoded to 0 as that's what riskview records is doing
                                           self.dppa := 0, //hardcoded to 0 as that's what riskview records is doing
																					 self.data_restriction_mask := DataRestriction,
																					 self.data_permission_mask := DataPermission,
																					 self.industry := Industry_Search[1].Industry,
																					 self.i_attributes_name := attributesIn[1].name,
																					 self.i_ssn := ssn_value,
                                           self.i_dob := dob_value,
                                           self.i_name_full := fullname_value,
																					 self.i_name_first := fname_val,
																					 self.i_name_last := lname_val,
																					 self.i_lexid := did_value, 
																					 self.i_address := addr_value,
																					 self.i_city := city_value,
																					 self.i_state := state_value,
																					 self.i_zip := zip_value,
																					 self.i_dl := drlc_value,
																					 self.i_dl_state := drlcstate_value,
                                           self.i_home_phone := hphone_value,
                                           self.i_work_phone := wphone_value,
																					 self.i_model_name_1 := if(model_count >= 1, model_url.parameters[1].value, ''),
																					 // Check to see if there was a model requested
																					 extra_score := model_count > 1;
																					 self.i_model_name_2 := model_url.parameters[2].value,
																					 self.o_score_1    := left.Models[1].Scores[1].i,
																					 self.o_reason_1_1 := left.Models[1].Scores[1].reason_codes[1].reason_code,
																					 self.o_reason_1_2 := left.Models[1].Scores[1].reason_codes[2].reason_code,
																					 self.o_reason_1_3 := left.Models[1].Scores[1].reason_codes[3].reason_code,
																					 self.o_reason_1_4 := left.Models[1].Scores[1].reason_codes[4].reason_code,
																					 self.o_reason_1_5 := left.Models[1].Scores[1].reason_codes[5].reason_code,
																					 self.o_reason_1_6 := left.Models[1].Scores[1].reason_codes[6].reason_code,
																					 self.o_score_2    := IF(extra_score, left.Models[2].Scores[1].i, ''),
																					 self.o_reason_2_1 := IF(extra_score, left.Models[2].Scores[1].reason_codes[1].reason_code, ''),
																					 self.o_reason_2_2 := IF(extra_score, left.Models[2].Scores[1].reason_codes[2].reason_code, ''),
																					 self.o_reason_2_3 := IF(extra_score, left.Models[2].Scores[1].reason_codes[3].reason_code, ''),
																					 self.o_reason_2_4 := IF(extra_score, left.Models[2].Scores[1].reason_codes[4].reason_code, ''),
																					 self.o_reason_2_5 := IF(extra_score, left.Models[2].Scores[1].reason_codes[5].reason_code, ''),
																					 self.o_reason_2_6 := IF(extra_score, left.Models[2].Scores[1].reason_codes[6].reason_code, ''),
																					 self.o_lexid      := left.did,
																					 self := left,
																					 self := [] ));
	Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);

	intermediateLog := DATASET([], Risk_Reporting.Layouts.LOG_Boca_Shell) : STORED('Intermediate_Log');

	// Note: All intermediate logs must have the following name schema:
	// Starts with 'LOG_' (Upper case is important!!)
	// Middle part is the database name, in this case: 'log__mbs__fcra'
	// Must end with '_intermediate__log'
	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, 	OUTPUT(intermediateLog, NAMED('LOG_log__mbs__fcra_intermediate__log')) );

	IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs__fcra_transaction__log__scout')));

	output( riskview_xml, named( 'Results' ) );

ENDMACRO;
// Models.RiskView_Service()