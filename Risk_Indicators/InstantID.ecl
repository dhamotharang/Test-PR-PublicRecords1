/*--SOAP--
<message name="InstantID">
	<part name="_LoginID" type="xsd:string"/>
	<part name="AccountNumber" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="StreetAddress" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="PrimRange" type="xsd:string"/> 
	<part name="PreDir" type="xsd:string"/>
	<part name="PrimName" type="xsd:string"/> 
	<part name="AddrSuffix" type="xsd:string"/>
	<part name="PostDir" type="xsd:string"/> 
	<part name="UnitDesignation" type="xsd:string"/>
	<part name="SecRange" type="xsd:string"/> 
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
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="HistoryDateTimeStamp" type="xsd:string"/>
	<part name="PoBoxCompliance" type="xsd:boolean"/>
  <part name="_espclientinterfaceversion'" type="xsd:string"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="FromIIDModel" type="xsd:boolean"/>
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="DLMask"	type="xsd:string"/>
	<part name="DOBMask" type="xsd:string"/>
	<part name="IncludeTargusE3220" type="xsd:boolean"/>
	<part name="scores" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="ExactFirstNameMatch" type="xsd:boolean"/>
	<part name="ExactFirstNameMatchAllowNicknames" type="xsd:boolean"/>
	<part name="ExactLastNameMatch" type="xsd:boolean"/>
	<part name="ExactAddrMatch" type="xsd:boolean"/>
	<part name="ExactPhoneMatch" type="xsd:boolean"/>
	<part name="ExactSSNMatch" type="xsd:boolean"/>
	<part name="ExactDOBMatch" type="xsd:boolean"/>
	<part name="ExactDriverLicenseMatch" type="xsd:boolean"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IncludeMSoverride" type="xsd:boolean"/>
	<part name="IncludeCLOverride" type="xsd:boolean"/>
	<part name="IncludeDLVerification" type="xsd:boolean"/>
	<part name="WatchList" type="tns:XmlDataSet" cols="90" rows="10"/>
	<part name="PassportUpperLine" type="xsd:string"/>
	<part name="PassportLowerLine" type="xsd:string"/>
	<part name="Gender" type="xsd:string"/>	
	<part name="DOBMatchOptions" type="tns:XmlDataSet" cols="110" rows="10"/>
	<part name="IncludeAllRiskIndicators" type="xsd:boolean"/>
	<part name="Channel" type="xsd:string"/>
	<part name="Income" type="xsd:string"/>
	<part name="OwnOrRent" type="xsd:string"/>
	<part name="LocationIdentifier" type="xsd:string"/>
	<part name="OtherApplicationIdentifier" type="xsd:string"/>
	<part name="OtherApplicationIdentifier2" type="xsd:string"/>
	<part name="OtherApplicationIdentifier3" type="xsd:string"/>
	<part name="DateofApplication" type="xsd:string"/>
	<part name="TimeofApplication" type="xsd:string"/>

	<part name="CustomCVIModelName" type="xsd:string"/>
	<part name="LastSeenThreshold" type="xsd:string"/>
	<part name="IncludeMIoverride" type="xsd:boolean"/>
	<part name="IncludeDOBinCVI" type="xsd:boolean"/>
	<part name="IncludeDriverLicenseInCVI" type="xsd:boolean"/>
  <part name="DisableCustomerNetworkOptionInCVI" type="xsd:boolean"/>
	<part name="DisallowInsurancePhoneHeaderGateway" type="xsd:boolean"/>
	<part name="CustomerID" type="xsd:string"/>
	<part name="_CompanyID" type="xsd:string"/>
	<part name="InstantIDVersion" type="xsd:string"/>
	<part name="IIDVersionOverride" type="xsd:boolean"/>
	<part name="IncludeDPBC" type="xsd:boolean"/>
	<part name="EnableEmergingID" type="xsd:boolean"/>
	<part name="AllowEmergingID" type="xsd:boolean"/>
	<part name="NameInputOrder" type="xsd:string"/>
	<part name="outcometrackingoptout" type="xsd:boolean"/>
 </message>
*/

import ut, codes, address, models, riskwise, suppress, seed_files, Royalty;

export InstantID := MACRO

#stored('_espclientinterfaceversion', '');

#WEBSERVICE(FIELDS(
		'_LoginID',
		'_CompanyID',
		'AccountNumber',
		'UnParsedFullName',
		'FirstName',
		'MiddleName',
		'LastName',
		'NameSuffix',
		'StreetAddress',
		'Addr',
		'PrimRange',
		'PreDir',
		'PrimName',
		'AddrSuffix',
		'PostDir',
		'UnitDesignation',
		'SecRange',
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
		'DPPAPurpose',
		'GLBPurpose',
		'IndustryClass',
		'HistoryDateYYYYMM',
		'HistoryDateTimeStamp',
		'PoBoxCompliance',
    '_espclientinterfaceversion',
		'OfacOnly',
		'ExcludeWatchLists',
		'OFACversion',
		'IncludeOfac',
		'GlobalWatchlistThreshold',
		'IncludeAdditionalWatchLists',
		'UseDOBFilter',
		'DOBRadius',
		'TestDataEnabled',
		'TestDataTableName',
		'FromIIDModel',
		'RedFlag_version',
		'SSNMask',
		'DLMask',
		'DOBMask',
		'IncludeTargusE3220',
		'scores',
		'gateways',
		'ExactFirstNameMatch',
		'ExactFirstNameMatchAllowNicknames',
		'ExactLastNameMatch',
		'ExactAddrMatch',
		'ExactPhoneMatch',
		'ExactSSNMatch',
		'ExactDOBMatch',
		'ExactDriverLicenseMatch',
		'DataRestrictionMask',
		'DataPermissionMask',
		'IncludeMSoverride',
		'IncludeCLOverride',
		'IncludeDLVerification',
		'WatchList',
		'PassportUpperLine',
		'PassportLowerLine',
		'Gender',
		'DOBMatchOptions',
		'IncludeAllRiskIndicators',
		'Channel',
		'Income',
		'OwnOrRent',
		'LocationIdentifier',
		'OtherApplicationIdentifier',
		'OtherApplicationIdentifier2',
		'OtherApplicationIdentifier3',
		'DateofApplication',
		'TimeofApplication',

		'CustomCVIModelName',
		'LastSeenThreshold',
		'IncludeMIoverride',
		'IncludeDOBinCVI',
		'IncludeDriverLicenseInCVI',
		'DisableCustomerNetworkOptionInCVI',
		'DisallowInsurancePhoneHeaderGateway',
		'CustomerID',
		'InstantIDVersion',
		'IIDVersionOverride',
		'IncludeDPBC',
		'EnableEmergingID',
		'AllowEmergingID',
		'NameInputOrder',
		'outcometrackingoptout'
	));

Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6 ssnmask             := 'NONE' : STORED('SSNMask');
	string6 dobmask	            := 'NONE'	: STORED('DOBMask');
	unsigned1 dlmask            := 0	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');
	
	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Risk_Indicators__InstantID);
/* ************* End Scout Fields **************/

boolean Test_Data_Enabled := FALSE   	: stored('TestDataEnabled');
string120 addr1_val := ''    : stored('StreetAddress');
string200 addr2_val := ''		 : stored('Addr');
// Parsed address input
string10 PrimRange := AutoStandardI.GlobalModule().primrange;
string2 PreDir := AutoStandardI.GlobalModule().predir;
string28 Primname := autostandardi.GlobalModule().primname;
string4 AddrSuffix := '' : stored('AddrSuffix');
string2 PostDir := AutoStandardI.GlobalModule().postdir;
string10 UnitDesignation := '' : stored('UnitDesignation');
string8 SecRange := AutoStandardI.GlobalModule().secrange;

addr_value := map( 
										trim(addr2_val)!='' => addr2_val,
										trim(addr1_val)!='' => addr1_val,
										Address.Addr1FromComponents(PrimRange, PreDir, PrimName, AddrSuffix, PostDir, UnitDesignation, SecRange)
										);

string120 fullname_val := '' : stored('UnParsedFullName');
string8 dob_value := ''      : stored('DateOfBirth');
string25 city_val := ''      : stored('City');
string2 state_val := ''      : stored('State');
string5 zip_value := AutoStandardI.GlobalModule().zip;
string9 ssn_value := AutoStandardI.GlobalModule().ssn;
STRING20 dl_number_value := '' : stored('DLNumber');
STRING2 dl_state_value   := '' : stored('DLState');
string10 phone_val     := '' : stored('HomePhone');
string10 wphone_val    := '' : stored('WorkPhone');
unsigned1 DPPAPurpose  := 0  : stored('DPPAPurpose');
unsigned1 GLBPurpose   := 8  : stored('GLBPurpose');
string DataRestriction := AutoStandardI.GlobalModule().DataRestrictionMask;
string DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

model_url := dataset([],Models.Layout_Score_Chooser) : STORED('scores',few);
fa_params := model_url(StringLib.StringToLowerCase(name)='models.fraudadvisor_service')[1].parameters;
model_version := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='version')[1].value));
custom_modelname := trim(StringLib.StringToUppercase(fa_params(StringLib.StringToLowerCase(name)='custom')[1].value));
modelname := if(model_version='', custom_modelname, model_version);

string128 In_CustomCVIModelName := '' : STORED('CustomCVIModelName');
LoggedCCVI := StringLib.StringToUppercase(In_CustomCVIModelName);


iid := Risk_Indicators.InstantID_records;

targus := Project(iid, transform(Royalty.Layouts.Royalty,
									self.royalty_type_code := left.royalty_type_code_targus,
                  self.royalty_type := left.royalty_type_targus,	
									self.royalty_count := left.royalty_count_targus,
									self.non_royalty_count := left.non_royalty_count_targus,
									self.count_entity := left.count_entity_targus,
									self := left));

insurance := Project(iid, transform(Royalty.Layouts.Royalty,
                  self.royalty_type_code := left.royalty_type_code_insurance,
                  self.royalty_type := left.royalty_type_insurance,
                  self.royalty_count := left.royalty_count_insurance,
                  self.non_royalty_count := left.non_royalty_count_insurance,
                  self.count_entity := left.count_entity_insurance,
									self := left));

royalties4ustemp := if(test_data_enabled, DATASET([], Royalty.Layouts.Royalty), 
	targus + insurance);
	
royalties4us := royalties4ustemp(royalty_type_code != 0);
	

// Deltabase_Log
Deltabase_Logging_prep := project(iid, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
                                                self.company_id := (Integer)CompanyID,
                                                self.login_id := _LoginID,
                                                self.product_id := Risk_Reporting.ProductID.Risk_Indicators__InstantID,
                                                self.function_name := FunctionName,
                                                self.esp_method := ESPMethod,
                                                self.interface_version := InterfaceVersion,
                                                self.delivery_method := DeliveryMethod,
                                                self.date_added := (STRING8)Std.Date.Today(),
                                                self.death_master_purpose := DeathMasterPurpose,
                                                self.ssn_mask := ssnmask,
                                                self.dob_mask := dobmask,
                                                self.dl_mask := (String)dlmask,
                                                self.exclude_dmv_pii := ExcludeDMVPII,
                                                self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
                                                self.archive_opt_in := ArchiveOptIn,
                                                self.glb := GLBPurpose,
                                                self.dppa := DPPAPurpose,
                                                self.data_restriction_mask := DataRestriction,
                                                self.data_permission_mask := DataPermission,
                                                self.industry := Industry_Search[1].Industry,
                                                self.i_ssn := ssn_value,
                                                self.i_dob := dob_value,
                                                self.i_name_full := fullname_val,
                                                self.i_name_first := fname_val,
                                                self.i_name_last := lname_val,
                                                // self.i_lexid := 0, 
                                                self.i_address := addr_value,
                                                self.i_city := city_val,
                                                self.i_state := state_val,
                                                self.i_zip := zip_value,
                                                self.i_dl := dl_number_value,
                                                self.i_dl_state := dl_state_value,
                                                self.i_home_phone := phone_val,
                                                self.i_work_phone := wphone_val,
                                                //Custom CVI takes presidence over normal CVI
                                                self.i_model_name_1 := IF(LoggedCCVI != '', LoggedCCVI, 'CVI'),
                                                self.i_model_name_2 := modelname,
                                                self.o_score_1 := IF(LoggedCCVI != '', (Integer)left.cviCustomScore, (Integer)left.cvi),
                                                self.o_reason_1_1 := IF(LoggedCCVI != '', left.cviCustomScore_ri[1].hri, left.ri[1].hri),
                                                self.o_reason_1_2 := IF(LoggedCCVI != '', left.cviCustomScore_ri[2].hri, left.ri[2].hri),
                                                self.o_reason_1_3 := IF(LoggedCCVI != '', left.cviCustomScore_ri[3].hri, left.ri[3].hri),
                                                self.o_reason_1_4 := IF(LoggedCCVI != '', left.cviCustomScore_ri[4].hri, left.ri[4].hri),
                                                self.o_reason_1_5 := IF(LoggedCCVI != '', left.cviCustomScore_ri[5].hri, left.ri[5].hri),
                                                self.o_reason_1_6 := IF(LoggedCCVI != '', left.cviCustomScore_ri[6].hri, left.ri[6].hri),
                                                //Check to see if there was a model requested
                                                extra_score := left.models[1].scores[1].i <> '';
                                                self.o_score_2 := IF(extra_score, (Integer)left.models[1].scores[1].i, 0),
                                                self.o_reason_2_1 := IF(extra_score, left.models[1].scores[1].reason_codes[1].reason_code, ''),
                                                self.o_reason_2_2 := IF(extra_score, left.models[1].scores[1].reason_codes[2].reason_code, ''),
                                                self.o_reason_2_3 := IF(extra_score, left.models[1].scores[1].reason_codes[3].reason_code, ''),
                                                self.o_reason_2_4 := IF(extra_score, left.models[1].scores[1].reason_codes[4].reason_code, ''),
                                                self.o_reason_2_5 := IF(extra_score, left.models[1].scores[1].reason_codes[5].reason_code, ''),
                                                self.o_reason_2_6 := IF(extra_score, left.models[1].scores[1].reason_codes[6].reason_code, ''),
                                                self.o_lexid := left.did,
                                                self := left,
                                                self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);

final := project(iid, risk_indicators.Layout_InstandID_NuGen);
output( final, named( 'Results' ) );

IF(~DisableOutcomeTracking and not Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

dRoyalties := royalties4us;
output(dRoyalties, named('RoyaltySet'));

ENDMACRO;