﻿﻿//=============================================
//===         FraudAdvisor_Service          === 
//=============================================

/*--SOAP--
<message name="FraudAdvisorService">
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

	<part name="UnparsedFullName2" type="xsd:string"/>
	<part name="FirstName2" type="xsd:string"/>
	<part name="MiddleName2" type="xsd:string"/>
	<part name="LastName2" type="xsd:string"/>
	<part name="NameSuffix2" type="xsd:string"/>
	<part name="StreetAddress2" type="xsd:string"/> 
	<part name="City2" type="xsd:string"/>
	<part name="State2" type="xsd:string"/>
	<part name="Zip2" type="xsd:string"/>
	<part name="HomePhone2" type="xsd:string"/>

	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
		<part name="historyDateTimeStamp" type="xsd:string"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="OFACSearching" type="xsd:boolean"/>
	
	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	
	
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="Model" type="xsd:string"/>
	<part name="ModelRequests" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="RedFlag_version" type="xsd:unsignedInt"/>
	<part name="RequestedAttributeGroups" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>

	<part name="IncludeRiskIndices" type="xsd:boolean"/>
	<part name="Channel" type="xsd:string"/>
	<part name="Income" type="xsd:string"/>
	<part name="OwnOrRent" type="xsd:string"/>
	<part name="LocationIdentifier" type="xsd:string"/>
	<part name="OtherApplicationIdentifier" type="xsd:string"/>
	<part name="OtherApplicationIdentifier2" type="xsd:string"/>
	<part name="OtherApplicationIdentifier3" type="xsd:string"/>
	<part name="DateofApplication" type="xsd:string"/>
	<part name="TimeofApplication" type="xsd:string"/>
  <part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
  <part name="SuppressCompromisedDLs" type="xsd:boolean"/>
  <part name="IncludeQAOutputs" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Contains Fraud Advisor 3, 5, 9, Version1 and Fraud Attributes */

import Address, Risk_Indicators, Riskwise, ut, seed_files, doxie, Risk_Reporting, Inquiry_AccLogs, STD;

export FraudAdvisor_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* *********************************************
	 *     Force the order on the WsECL page     *
	 ********************************************* */
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

		'UnparsedFullName2',
		'FirstName2',
		'MiddleName2',
		'LastName2',
		'NameSuffix2',
		'StreetAddress2',
		'City2',
		'State2',
		'Zip2',
		'HomePhone2',

		'DPPAPurpose',
		'GLBPurpose',
		'DataRestrictionMask',
		'DataPermissionMask',
		'IndustryClass',
		'HistoryDateYYYYMM',
		'historyDateTimeStamp',
		'OfacOnly',
		'OFACSearching',

		'ExcludeWatchLists',
		'OFACversion',
		'IncludeOfac',
		'GlobalWatchlistThreshold',
		'IncludeAdditionalWatchLists',
		'UseDOBFilter',
		'DOBRadius',

		'TestDataEnabled',
		'TestDataTableName',
		'Model',
		'ModelRequests',
		'RedFlag_version',
		'RequestedAttributeGroups',
		'gateways',

		'IncludeRiskIndices',
		'Channel',
		'Income',
		'OwnOrRent',
		'LocationIdentifier',
		'OtherApplicationIdentifier',
		'OtherApplicationIdentifier2',
		'OtherApplicationIdentifier3',
		'DateofApplication',
		'TimeofApplication',
		'OutcomeTrackingOptOut',
		'SuppressCompromisedDLs',
  'IncludeQAOutputs'  
	));

Risk_indicators.MAC_unparsedfullname(title_val,first_value,middle_value,last_value,suffix_value,'FirstName','MiddleName','LastName','NameSuffix')



/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6 ssnmask             := '' : STORED('SSNMask');
	string6 dobmask	            := ''	: STORED('DOBMask');
	string1 dlmask              := ''	: STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.Models__FraudAdvisor_Service);
/* ************* End Scout Fields **************/

unsigned6 did_value := 0          : stored('DID');
string30  account_value := ''     : stored('AccountNumber');
string120 addr_value := ''        : stored('StreetAddress');
string25  city_value := ''        : stored('City');
string2   state_value := ''       : stored('State');
string9   zip_value := ''         : stored('Zip');
string25  country_value := ''     : stored('Country');
string9   socs_value := ''        : stored('ssn');
string8   dob_value := ''         : stored('DateOfBirth');
unsigned1 age_value := 0          : stored('Age');
string20  drlc_value := ''        : stored('DLNumber');
string2   drlcstate_value := ''   : stored('DLState');
string50 	email_value := ''       : stored('Email');
string45  ip_value := ''          : stored('IPAddress');
string10  hphone_value := ''      : stored('HomePhone');
string10  wphone_value := ''      : stored('WorkPhone');
string100 cmpy_value := ''        : stored('EmployerName');
string30  formerlast_value := ''  : stored('FormerName');
string120 unparsed_fullname_value := '' : stored('UnParsedFullName');

// ----------[ Second input ]----------
// Perform unparsed name cleaning without a macro until we make MAC_UnparsedFullName completely BtSt-savvy. 
string120 unparsed_fullname_value2 := '' : stored('UnParsedFullName2');
cleaned_name2 := Stringlib.StringToUppercase(address.CleanPerson73(unparsed_fullname_value2));
boolean  valid_cleaned2 := unparsed_fullname_value2 <> '';

string30 pre_fname_val2  := '' : stored('FirstName2');
string30 fname2_value    := if(pre_fname_val2 = '' AND valid_cleaned2, cleaned_name2[6..25], pre_fname_val2);
string30 pre_mname_val2  := '' : stored('MiddleName2');
string30 mname2_value    := if(pre_mname_val2 = '' AND valid_cleaned2, cleaned_name2[26..45], pre_mname_val2);
string30 pre_lname_val2  := '' : stored('LastName2');
string30 lname2_value    := if(pre_lname_val2 = '' AND valid_cleaned2, cleaned_name2[46..65], pre_lname_val2);
string5  pre_suffix_val2 := '' : stored('NameSuffix2');
string5  suffix2_value   := if(pre_suffix_val2 = '' AND valid_cleaned2, cleaned_name2[66..70], pre_suffix_val2);

string50 addr2_value   := '' : stored('StreetAddress2');
string30 city2_value   := '' : stored('City2');
string2  state2_value  := '' : stored('State2');
string5  zip2_value    := '' : stored('Zip2');
string10 hphone2_value := '' : stored('HomePhone2');
// ----------[ End second input. ]----------
		
unsigned1 DPPA_Purpose := 0         : stored('DPPAPurpose');
unsigned1 GLB_Purpose := 8          : stored('GLBPurpose');
boolean   isFCRA      := false;
boolean   glb_ok 	:= Risk_Indicators.iid_constants.glb_ok(GLB_Purpose, isFCRA);
string5   industry_class_val := ''  : stored('IndustryClass');
boolean   inIsUtility := StringLib.StringToUpperCase(industry_class_val) = 'UTILI';
unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');
string20	historyDateTimeStamp := '' : stored('historyDateTimeStamp');
boolean   in_ofac_only := true 			: stored('OfacOnly');
boolean   ofacSearching := true 		: stored('OFACSearching');

boolean   excludewatchlists := false 		: stored('ExcludeWatchLists');
unsigned1 OFACVersion       := 1        : stored('OFACVersion');
boolean   IncludeOfac       := false    : stored('IncludeOfac');
real      gwThreshold       := 0.84     : stored('GlobalWatchlistThreshold');
boolean   addtl_watchlists  := false    : stored('IncludeAdditionalWatchLists');
boolean   usedobFilter      := false   	: stored('UseDOBFilter');
integer2  dobradius0        := 2       	: stored('DOBRadius');
unsigned1 RedFlag_version 	:= 0 				: stored('RedFlag_version');
string 	 	DataRestriction 	:= risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string	 	DataPermission 		:= Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
boolean   Test_Data_Enabled := false  		: stored('TestDataEnabled');
string20  Test_Data_Table_Name := ''   	: stored('TestDataTableName');
 

// these new fields were asked to be added for fp 2.0, but we're not using them yet other than echoing them back
string16 Channel                     := '' : stored('Channel');
string8 Income                       := '' : stored('Income');
string8 OwnOrRent                    := '' : stored('OwnOrRent');
string16 LocationIdentifier          := '' : stored('LocationIdentifier');
string16 OtherApplicationIdentifier  := '' : stored('OtherApplicationIdentifier');
string16 OtherApplicationIdentifier2 := '' : stored('OtherApplicationIdentifier2');
string16 OtherApplicationIdentifier3 := '' : stored('OtherApplicationIdentifier3');
string8 DateofApplication            := '' : stored('DateofApplication');
string8 TimeofApplication            := '' : stored('TimeofApplication');

#stored('DisableBocaShellLogging', DisableOutcomeTracking);


string20  Model              := ''    : stored('Model');
boolean   IncludeRiskIndices := false : stored('IncludeRiskIndices');  // to include the 6 fraud indices that come back in fp1109_0
boolean SuppressCompromisedDLs := false : stored('SuppressCompromisedDLs');
// Set to TRUE when running RiskProcessing scripts to include some intermediate boca shell outputs for modelers
boolean IncludeQAOutputs             := FALSE : stored('IncludeQAOutputs'); 


Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);

// integer   FraudVersion_in := 1 : stored('ModelVersion');
// fraudversion_check := max( 1, fraudversion_in ); // don't allow versions <=0

Layout_Attributes_In := RECORD
	string name;
END;

dobradius := if(usedobFilter,dobradius0,-1);
//model_url := dataset([],Models.Layout_Score_Chooser) 				: stored('scores',few);
ModelOptions_In := DATASET([], Models.Layouts.Layout_Model_Request_In)	: STORED('ModelRequests',few);
attributesIn := dataset([],Layout_Attributes_In)						: stored('RequestedAttributeGroups',few);
gateways_in := Gateway.Configuration.Get();

doAttributesVersion1 := EXISTS(attributesIn(stringlib.stringtolowercase(name)='version1'));	// output version1 if requested
doIDAttributes := EXISTS(attributesIn(StringLib.StringToLowerCase(name)='idattributes')); // Output IDAttributes if requested

//For FraudPoint 3.0, a second input name and address was added so they could then be avalable for custom models. It was also
//required that this info be passed in from InstantID and FlexID in the 'Scores' data set, which actually ends up in this 'ModelRequests'
//section. There are no changes needed to handle these second input fields until a model is developed which actually needs them. If
//and when a custom model does need them, code will be needed here below to look for these fields and pass them to the new model.
//It will be somewhat confusing as when the new model is requested via FraudAdvisor_Service, these second identity fields are 
//available as regular input fields, but if the new model is requested via InstantID or FlexID, the fields will be available only
//through this custom model request.  

cmIn := ModelOptions_In(StringLib.StringToLowerCase(TRIM(ModelName)) = 'customfa_service');
cmModelName       := StringLib.StringToLowerCase(ModelOptions_In[1].ModelName);
cmName            := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'custom');
cmNameValue       := StringLib.StringToLowerCase(TRIM(cmName[1].OptionValue));
cmGrade           := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'grade');
cmGradeValue      := StringLib.StringToUpperCase(TRIM(cmGrade[1].OptionValue));
cmRetailZip       := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'retailzip');
cmRetailZipValue  := StringLib.StringToUpperCase(TRIM(cmRetailZip[1].OptionValue));
cmLoadAmount      := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'loadamount');
cmLoadAmountValue := StringLib.StringToUpperCase(TRIM(cmLoadAmount[1].OptionValue));
cmSegment         := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'segment');
cmSegmentValue    := StringLib.StringToUpperCase(TRIM(cmSegment[1].OptionValue));
cmLexID           := cmIn[1].ModelOptions(StringLib.StringToLowerCase(TRIM(OptionName)) = 'lexid');
cmLexIDValue      := StringLib.StringToUpperCase(TRIM(cmLexID[1].OptionValue));

isWFS34 := (cmNameValue = 'ain801_1');
	
Grade_Value := cmGradeValue; // To mask wfs3/4 using Grade.

// The ‘fraudpoint2_models’ set are models that return risk indicies and so need the expanded layout.
fraudpoint2_models := ['fp1109_0', 'fp1109_9', 'fp1307_2', 'fp1307_1', 'fp31310_2',
	'fp1509_2','fp1512_1','fp31604_0', 'fp1303_1','fp1404_1','fp1407_1','fp1407_2'];

// The ‘fraudpoint3_models’ set are the FraudPoint 3.0 flagship models only.
fraudpoint3_models := ['fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9'];

fraudpoint3_custom_models := ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',
                              'fp1607_1', 'fp1712_0', 'fp1508_1', 'fp1802_1', 'fp1705_1','fp1801_1','fp1806_1'];

// The ‘custom_models’ set are all possible models and so add any new model name to this set.  The model requested must be in this set or the query will return an “Invalid model” error. 
custom_models := ['fp3710_0', 'fp3904_1', 'fp3905_1', 'idn6051', 'fd5609_2', 'fp3710_9', 'fp1109_0', 'fp1109_9', 'fp31203_1', 'fp31105_1',
									'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1',
									'fp1403_2',	'fp1409_2', 'fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1509_2','fp1509_1',
									'fp1510_2', 'fp1511_1', 'fp1512_1','fp31604_0', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2',
                  'fp1702_1','fp1706_1','fp1609_2','fp1607_1', 'fp1712_0','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1'];

// The ‘bill_to_ship_to_models’ set are models that use the new second input address that was introduced in Fraudpoint 3.0.
bill_to_ship_to_models := ['fp1409_2', 'fp1509_2'];

invalidCustomRequest := (((cmModelName = 'customfa_service' AND ~isWFS34) AND
												(cmModelName = 'customfa_service' AND cmNameValue NOT IN custom_models)) OR
												(cmModelName <> 'customfa_service' AND COUNT(ModelOptions_In) > 0));
												
InvalidGreenDotRequest := (((cmNameValue in  ['fp31310_2', 'fp1509_2']) AND (cmRetailZipValue = '') AND (ip_value = ''))
							Or ((cmNameValue in ['fp31310_2', 'fp1509_2']) AND (cmLoadAmountValue = '')));
												
model_lc := IF(TRIM(Model) <> '', StringLib.StringToLowerCase(trim(Model)), cmNameValue);

model_name1 := if( (model_lc='' or model_lc in custom_models OR isWFS34) AND invalidCustomRequest=false, IF(isWFS34, 'ain801_1', model_lc), error('Invalid fraud version/model input combination'));

InvalidFP3GLBRequest := model_name1 in fraudpoint3_models and ~glb_ok; 

// Bureau Fraud Flags Models needs to be requested on it's own with no other scores/attributes.
InvalidFraudFlagsRequest := model_lc = 'fp1712_0' AND 
														(EXISTS(attributesIn(stringlib.stringtolowercase(name)<>'')) OR
														includeriskindices = TRUE OR
														redflag_version > 0);
														
// model_name := if(InvalidGreenDotRequest = false, model_name1, error('Invalid parameter input combination for fp31310_2 or fp1509_2'));
model_name := map(InvalidGreenDotRequest = true		=> error('Invalid parameter input combination for fp31310_2 or fp1509_2'),
									InvalidFP3GLBRequest = true			=> error('Valid Gramm-Leach-Bliley Act (GLBA) purpose required'),
							 	InvalidFraudFlagsRequest = true => error('invalid product option combination'),
								
																										model_name1 );

Gateway.Layouts.Config gw_switch(gateways_in le) := transform  
	self.servicename := map(model_name = 'fd5609_2'                                  => '', //turn off all gateways for fd5609_2
                            model_name IN ['fp1303_1', 'fp1307_1'] and le.servicename = 'netacuity' => '', //turn off netacuity gateway for fp1303_1
                            le.servicename = 'bridgerwlc' and OFACVersion = 4 and StringLib.StringToLowerCase(model_name) = '' => le.servicename,
                            le.servicename = 'bridgerwlc' and OFACVersion = 4 and StringLib.StringToLowerCase(model_name) not in Risk_Indicators.iid_constants.FAXML_WatchlistModels => '',
                                                                                                                                               le.servicename);
	self.url := map(model_name = 'fd5609_2'                                  => '',
                    model_name IN ['fp1303_1', 'fp1307_1'] and le.servicename = 'netacuity' => '',
                    le.servicename = 'bridgerwlc' and OFACVersion = 4 and StringLib.StringToLowerCase(model_name) = '' => le.url,
                    le.servicename = 'bridgerwlc' and OFACVersion = 4 and StringLib.StringToLowerCase(model_name) not in Risk_Indicators.iid_constants.FAXML_WatchlistModels => '',
                                                                                                                                               le.url); 
  self := le;																																								
end;
gateways := project(gateways_in, gw_switch(left));

if(OFACVersion = 4 and StringLib.StringToLowerCase(model_name) in Risk_Indicators.iid_constants.FAXML_WatchlistModels and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway)); 
if(OFACVersion = 4 and StringLib.StringToLowerCase(model_name) = '' and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

r := record
	unsigned4 seq;
end;
d := dataset([{(unsigned)account_value}],r);

risk_indicators.layout_input into(d l) := transform
	
	street_address := risk_indicators.MOD_AddressClean.street_address(addr_value);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_value, state_value, zip_value ) ;		
	
	dob_val := riskwise.cleandob(dob_value);
	dl_num_clean := riskwise.cleanDL_num(drlc_value);
	
	self.seq := l.seq;
	self.DID := /*did_value;*/IF(model_name='fp31604_0', (unsigned)cmLexIDValue, did_value);
	self.score := if(self.did<>0, 100, 0);
	self.ssn := IF(socs_value='000000000','',socs_value);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if (age_value = 0 and (integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), (string3)age_value);
	self.phone10 := hphone_value;
	self.wphone10 := wphone_value;
	
	self.fname := stringlib.stringtouppercase(first_value);
	self.mname := stringlib.stringtouppercase(middle_value);
	self.lname := stringlib.stringtouppercase(last_value);
	self.suffix := stringlib.stringtouppercase(suffix_value);
	
	SELF.in_streetAddress := street_address;
	SELF.in_city := city_value;
	SELF.in_state := state_value;
	SELF.in_zipCode := zip_value;
	SELF.in_country := country_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := IF(clean_a2[117..121]<>'',clean_a2[117..121],zip_value[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a2[122..125]<>'', clean_a2[122..125], zip_value[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := risk_indicators.iid_constants.override_addr_type(street_address, clean_a2[139], clean_a2[126..129]);
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];	
	
	self.country := country_value;
	
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(drlcstate_value);
	
	SELF.email_address := email_value;
	SELF.ip_address := ip_value;
	
	SELF.employer_name := stringlib.stringtouppercase(cmpy_value);
	SELF.lname_prev := stringlib.stringtouppercase(formerlast_value);
	SELF.historydate := IF(historyDateTimeStamp <> '', (UNSIGNED)historyDateTimeStamp[1..6], history_date);
	SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
end;
prep := PROJECT(d,into(LEFT));

risk_indicators.layout_input into2 := TRANSFORM
	self.seq    := (unsigned)account_value;
	// Allow for one person / two addresses if second person name data is blank.
	self.fname  := IF( fname2_value  != '', stringlib.stringtouppercase(fname2_value) , stringlib.stringtouppercase(first_value) );
	self.mname  := IF( mname2_value  != '', stringlib.stringtouppercase(mname2_value) , stringlib.stringtouppercase(middle_value) );
	self.lname  := IF( lname2_value  != '', stringlib.stringtouppercase(lname2_value) , stringlib.stringtouppercase(last_value) );
	self.suffix := IF( suffix2_value != '', stringlib.stringtouppercase(suffix2_value), stringlib.stringtouppercase(suffix_value) );
	
	// for greendot custom, we need to send just the custom input retailZipcode through the address cleaner to get it's lat and long
	SELF.in_streetAddress := if(model_name='fp1509_2', 'fp1509', stringlib.stringtouppercase(addr2_value));
	SELF.in_city          := if(model_name='fp1509_2', '', stringlib.stringtouppercase(city2_value));
	SELF.in_state         := if(model_name='fp1509_2', '', stringlib.stringtouppercase(state2_value));
	SELF.in_zipCode       := if(model_name='fp1509_2', cmRetailZipValue, zip2_value);
	SELF.phone10          := hphone2_value;	
	SELF.historydate := IF(historyDateTimeStamp <> '', (UNSIGNED)historyDateTimeStamp[1..6], history_date);
	SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	SELF := [];
END;

prep2 := DATASET([into2]);

// requirement 2.5 - minimum input required
// a. Model is AVENGER and cmLexID is populated, and is the only thing populated
// b.	First Name, Last Name, Street Address, Zip
// c.	First Name, Last Name, SSN
input_ok := if( (model_name='fp31604_0'
									 and (unsigned)cmLexIDValue>0
									 and trim(prep[1].fname)=''
									 and trim(prep[1].mname)=''
									 and trim(prep[1].lname)=''
									 and trim(prep[1].suffix)=''
									 and trim(prep[1].ssn)=''
									 and trim(prep[1].dob)=''
									 and trim(prep[1].age)='0'
									 and trim(prep[1].phone10)=''
									 and trim(prep[1].wphone10)=''
									 and trim(prep[1].in_streetAddress)=''
									 and trim(prep[1].in_city)=''
									 and trim(prep[1].in_state)=''
									 and trim(prep[1].in_zipCode)=''
									 and trim(prep[1].in_country)=''
									 and trim(prep[1].country)=''
									 and trim(prep[1].dl_number)=''
									 and trim(prep[1].dl_state)=''
									 and trim(prep[1].email_address)=''
									 and trim(prep[1].ip_address)=''
									 and trim(prep[1].employer_name)=''
									 and trim(prep[1].lname_prev)=''
											) or
								(trim(prep[1].fname)<>''
									 and trim(prep[1].lname)<>''
									 and (trim(prep[1].ssn)<>'' or (trim(prep[1].in_streetAddress)<>''
																										and trim(prep[1].in_zipCode)<>''))
											),
						TRUE,
						ERROR(301,doxie.ErrorCodes(301)));
						
//=============================================================
//===  Description: Amex is requesting a 
//===  set of custom attributes in addition 
//===  to the standard FP 2.0 attributes.
//===  They are called "fraudpointattrv201"     
//=============================================================
attrV201 := 'fraudpointattrv201';
attributesV2set := ['fraudpointattrv2', attrV201];
doAttributesVersion2 := EXISTS(attributesIn(stringlib.stringtolowercase(name)in attributesV2set)) and input_ok;	// output version2 if requested and minimum input entered
doAttributesVersion201 := EXISTS(attributesIn(stringlib.stringtolowercase(name)=attrV201)) and input_ok;	// output version201 if requested and minimum input entered


risk_indicators.layout_input into_test_prep(r l) := transform
	self.seq := l.seq;	
	self.ssn := socs_value;
	self.phone10 := hphone_value;
	self.fname := stringlib.stringtouppercase(first_value);
	self.lname := stringlib.stringtouppercase(last_value);
	SELF.in_zipCode := zip_value;
	self := [];
end;

//Options copied over from targets np31 model to make it work the same in FraudAdvisor
//These options are being hard coded to prevent target's fp1403_2 model from changing if FraudAdvisor settings change
DisableInquiriesInCVI := True;																																								//Disable Customer Network: True
unsigned3 LastSeenThresholdIn := map(	
																		model_name IN ['fp1702_1','fp1702_2'] => risk_indicators.iid_constants.max_unsigned3,
																		model_name IN ['fp1403_2','fp1510_2'] => 730, 
																		doAttributesVersion201 => 9999,
																		risk_indicators.iid_constants.oneyear);	//Last Seen Threshold: 365 days (1 year) for fp1403_2, otherwise use default
DisallowInsurancePhoneHeaderGateway := FALSE;																																	//Set to True to deny access to Insurance Phone Header Gateway
boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND model_name IN ['fp1403_2','fp1510_2'];

test_prep := PROJECT(d,into_test_prep(LEFT));

//  options
doRelatives      := true;
doDL             := false;
doVehicle        := (model_name IN ['fp31105_1','fp3904_1', 'fp1407_1', 'fp1407_2', 'fp1506_1','fp1509_2', 
                                    'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1610_1', 
																		'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1',
                                    'fp1706_1', 'fp1609_2', 'fp1607_1', 'fp1508_1','fp1705_1','fp1801_1',
                                    'fp1806_1']) 
																or doAttributesVersion2;
doDerogs         := true;
isLn             := false;     // set ln branded to activate exp dl sources in iid getheader in < 5 shells.
suppressNearDups := model_name in ['idn6051', 'fd5609_2'] OR isWFS34 OR doIDAttributes;
require2Ele      := model_name='fd5609_2' OR isWFS34 OR doIDAttributes;
from_biid        := false;
from_IT1O        := false;
doScore          := false;
nugen            := if(model_name='fd5609_2' OR isWFS34 OR doIDAttributes, false, true);  // fd5609_2 and wfs34 are legacy models being plugged into nugen product
inCalif						:= false;
fdReasonsWith38		:= false;

// Fields tweaked for WFS3/WFS4
ofac_only        := isWFS34 OR doIDAttributes OR in_ofac_only;
isUtility					:= IF(isWFS34 OR doIDAttributes, FALSE, inIsUtility);

// new options for fp attributes 2.0
IncludeDLverification := if(doAttributesVersion2, true, false);
bsVersion := map(
  model_name IN ['fp1712_0','fp1508_1','fp1802_1','fp1801_1', 'fp1806_1'] => 53,
	model_name IN ['fp1706_1','fp1705_1'] => 52,
	model_name IN ['fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9','fp1509_1','fp1512_1',
		'fp31604_0', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1609_2','fp1607_1'] => 51, 
	doAttributesVersion201 => 50,
	model_name IN ['fp1509_2','fp1510_2','fp1511_1'] => 50,
	model_name IN ['fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1403_2', 'fp1409_2'] => 41,
  doAttributesVersion2 or model_name in fraudpoint2_models => 4,
	model_name IN ['fp31203_1'] => 4,
  model_name in ['fp31105_1'] => 3,
  2
);

//=========================
//=== BSoptions         ===
//=========================
unsigned8 BSOptions := map(model_name='fp31604_0' and input_ok   => Risk_indicators.iid_constants.BSOptions.RetainInputDID
																																	+ Risk_indicators.iid_constants.BSOptions.IncludeDoNotMail
																																	+ Risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity
																																	+ risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary ,
													 model_name IN ['fp31203_1', 'fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1307_1','fp1404_1',
																					'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1506_1', 'fp1509_2','fp1509_1', 'fp31505_0',
																					'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9', 'fp1511_1','fp1512_1', 'fp1610_1', 
																					'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1706_1','fp1609_2',
                                          'fp1607_1','fp1508_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1']

													 or doAttributesVersion2               => Risk_indicators.iid_constants.BSOptions.IncludeDoNotMail
																																	+ Risk_indicators.iid_constants.BSOptions.IncludeFraudVelocity
																																	+ risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary
																																	+ If(doAttributesVersion201,  Risk_indicators.iid_constants.BSOptions.AllowInsuranceDLInfo
																																															+ Risk_indicators.iid_constants.BSOptions.AlwaysCheckInsurance,0), //Can't use bitwise because of If-false branch here!
																																	
													 model_name IN ['fp1403_2','fp1510_2'] => Risk_indicators.iid_constants.BSOptions.IsInstantIDv1
																																	+ Risk_Indicators.iid_constants.BSOptions.IncludeFraudVelocity
																																	+ risk_indicators.iid_constants.BSOptions.IncludeHHIDSummary
																																	+ if(doInquiries, Risk_indicators.iid_constants.BSOptions.IncludeInquiries,0)
																																	+ if(~DisallowInsurancePhoneHeaderGateway, Risk_indicators.iid_constants.BSOptions.IncludeInsNAP, 0),
																																	
													0);

iid := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn, 
																					ofac_only, suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists, 
																					from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius, 
																					BSversion, in_runDLverification:=IncludeDLverification,
																					in_DataRestriction:=DataRestriction, in_BSOptions:=BSOptions,
																					in_LastSeenThreshold:=LastSeenThresholdIn, in_DataPermission:=DataPermission);

clam := risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn,  
																						doRelatives, doDL, doVehicle, doDerogs, bsVersion, doScore, nugen,
																						DataRestriction:=DataRestriction, BSOptions := BSOptions, DataPermission:=DataPermission);

// Run Bill-to-Ship-to Shell if necessary.
clam_BtSt := 
	IF( model_lc IN bill_to_ship_to_models,
				Models.FraudAdvisor_BtSt_Function(prep, prep2, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn,
																					ofac_only, suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists,
																					from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius,
																					BSversion, DataRestriction, IncludeDLverification, DataPermission,
																					doRelatives, doDL, doVehicle, doDerogs, doScore, nugen, BSOptions)
	);
	
	
/* Validation Mode - Uncomment the two lines below and hit your model */
//	  ModelValidationResults := Models.FP1806_1_0(ungroup(clam), 6);
//	  OUTPUT(ModelValidationResults, named('Results'));
    

//================================================================
//===   Comment out all remaining for debug/validation mode   ====
//================================================================
 
//* *************************************
//*   Boca Shell Logging Functionality  *
//***************************************


		 productID := Risk_Reporting.ProductID.Models__FraudAdvisor_Service;
	
     intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(clam, productID, bsVersion);
// ************ End Logging ************


ip_prep := project( ungroup(iid), transform( riskwise.Layout_IPAI, self.seq := left.seq, self.ipaddr := ip_value ) );
ipdata := risk_indicators.getNetAcuity( ip_prep, gateways, DPPA_Purpose, GLB_Purpose);

// Get the attributes

attributes := Models.getFDAttributes(clam, iid, account_value, ipdata, model_name, suppressCompromisedDLs);
// search for test seeds																					
attr_test_seed := Risk_Indicators.FDAttributes_TestSeed_Function(test_prep, account_value, Test_Data_Table_Name);																																										
// choose either test seed or real
pick_attr := if(Test_Data_Enabled, attr_test_seed, ungroup(attributes));	

//pick_attr := ungroup(attributes);			

output(attributes[1].compromisedDL_hash, named('compromisedDL_hash'));


checkBoolean(boolean x) := if(x, '1', '0');									

Layout_FA_Input := RECORD
	Risk_Indicators.Layout_Input;
	STRING5 Grade := '';
	string16 Channel := '';
	string8 Income := '';
	string16 OwnOrRent := '';
	string16 LocationIdentifier := '';
	string16 OtherApplicationIdentifier := '';
	string16 OtherApplicationIdentifier2 := '';
	string16 OtherApplicationIdentifier3 := '';
	string8 DateofApplication := '';
	string8 TimeofApplication := '';
END;
Layout_Attribute := RECORD, maxlength(10000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(70000)
	string15 name;
	string3 index;
	DATASET(Layout_Attribute) Attributes;
END;

layout_FDAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	Layout_FA_Input input;
	//add second input fields for FP3
	string30 fname2;
	string30 mname2;
	string30 lname2;
	string5  suffix2;
	string50 in_streetaddress2;
	string30 in_city2;
	string2  in_state2;
	string5  in_zipcode2;
	string10 phone102;	
	DATASET(Layout_AttributeGroup) AttributeGroup;
	riskwise.layouts.red_flags_online_layout Red_Flags;
END;


Models.Layout_Parameters intoVersion1(Models.Layout_FraudAttributes le, integer c) := TRANSFORM
	self.name := map(c=1 => 'SSNFirstSeen',
									 c=2 => 'DateLastUpdate',
									 c=3 => 'RecentUpdate',
									 c=4 => 'NumSrcsConfirmIDAddr',
									 c=5 => 'PhoneFullNameMatch',
									 c=6 => 'PhoneLastNameMatch',
									 c=7 => 'InferredAge',
									 c=8 => 'InvalidSSN',
									 c=9 => 'InvalidPhone',
									 c=10 => 'InvalidAddr',
									 c=11 => 'InvalidDL',
									 c=12 => 'NoVerifyNameAddrPhoneSSN',
									 c=13 => 'SSNDeceased',
									 c=14 => 'DateSSNDeceased',
									 c=15 => 'SSNIssued',
									 c=16 => 'RecentSSN',
									 c=17 => 'LowIssueDate',
									 c=18 => 'HighIssueDate',
									 c=19 => 'SSNIssueState',
									 c=20 => 'NonUSssn',
									 c=21 => 'SSN3Years',
									 c=22 => 'SSNAfter5',
									 c=23 => 'SSNProbs',
									 c=24 => 'isSSNNotFound',
									 c=25 => 'isFoundOther',
									 c=26 => 'isIssuedPrior',
									 c=27 => 'isPhoneOther',
									 c=28 => 'SSNPerID',
									 c=29 => 'AddrPerID',
									 c=30 => 'PhonePerID',
									 c=31 => 'IDPerSSN',
									 c=32 => 'AddrPerSSN',
									 c=33 => 'IDPerAddr',
									 c=34 => 'SSNPerAddr',
									 c=35 => 'PhonePerAddr',
									 c=36 => 'IDPerPhone',
									 c=37 => 'SSNPerID6',
									 c=38 => 'AddrPerID6',
								   c=39 => 'PhonePerID6',
									 c=40 => 'IDPerSSN6',
									 c=41 => 'AddrPerSSN6',
									 c=42 => 'IDPerAddr6',
									 c=43 => 'SSNPerAddr6',
									 c=44 => 'PhonePerAddr6',
									 c=45 => 'IDPerPhone6',
									 c=46 => 'LastPerSSN',
									 c=47 => 'LastPerID',
									 c=48 => 'DateLastNameChange',
									 c=49 => 'NewLastName',
									 c=50 => 'LastNames30',
									 c=51 => 'LastNames90',
									 c=52 => 'LastNames180',
									 c=53 => 'LastNames12',
									 c=54 => 'LastNames24',
									 c=55 => 'LastNames36',
									 c=56 => 'LastNames60',
									 c=57 => 'IDPerSFDUAddr',
									 c=58 => 'SSNPerSFDUAddr',
									 c=59 => 'IAAddress',
									 c=60 => 'IACity',
									 c=61 => 'IAState',
									 c=62 => 'IAZip',
									 c=63 => 'IAZip4',
									 c=64 => 'InputAddrDateFirstSeen',
									 c=65 => 'InputAddrDateLastSeen',
									 c=66 => 'InputAddrLenOfRes',
									 c=67 => 'InputAddrDwellType',
									 c=68 => 'InputAddrNotPrimaryRes',
									 c=69 => 'InputAddrActivePhoneList',
									 c=70 => 'InputAddrActivePhoneNumber',
									 c=71 => 'InputAddrMedianIncome',
									 c=72 => 'InputAddrMedianHomeVal',
									 c=73 => 'InputAddrMurderIndex',
									 c=74 => 'InputAddrCarTheftIndex',
									 c=75 => 'InputAddrBurglaryIndex',
									 c=76 => 'InputAddrCrimeIndex',
									 c=77 => 'CAAddress',
									 c=78 => 'CACity',
									 c=79 => 'CAState',
									 c=80 => 'CAZip',
									 c=81 => 'CAZip4',
									 c=82 => 'CurrAddrDateFirstSeen',
									 c=83 => 'CurrAddrDateLastSeen',
									 c=84 => 'CurrAddrLenOfRes',
									 c=85 => 'CurrAddrDwellType',
									 c=86 => 'CurrAddrNotPrimaryRes',
									 c=87 => 'CurrAddrActivePhoneList',
									 c=88 => 'CurrAddrActivePhoneNumber',
									 c=89 => 'CurrAddrMedianIncome',
									 c=90 => 'CurrAddrMedianHomeVal',
									 c=91 => 'CurrAddrMurderIndex',
									 c=92 => 'CurrAddrCarTheftIndex',
									 c=93 => 'CurrAddrBurglaryIndex',
									 c=94 => 'CurrAddrCrimeIndex',
									 c=95 => 'PAAddress',
									 c=96 => 'PACity',
									 c=97 => 'PAState',
									 c=98 => 'PAZip',
									 c=99 => 'PAZip4',
									 c=100 => 'PrevAddrDateFirstSeen',
									 c=101 => 'PrevAddrDateLastSeen',
									 c=102 => 'PrevAddrLenOfRes',
									 c=103 => 'PrevAddrDwellType',
									 c=104 => 'PrevAddrNotPrimaryRes',
									 c=105 => 'PrevAddrActivePhoneList',
									 c=106 => 'PrevAddrActivePhoneNumber',
									 c=107 => 'PrevAddrMedianIncome',
									 c=108 => 'PrevAddrMedianHomeVal',
									 c=109 => 'PrevAddrMurderIndex',
									 c=110 => 'PrevAddrCarTheftIndex',
									 c=111 => 'PrevAddrBurglaryIndex',
									 c=112 => 'PrevAddrCrimeIndex',
									 c=113 => 'InputAddrCurrAddrMatch',
									 c=114 => 'InputAddrCurrAddrDistance',
									 c=115 => 'InputAddrCurrAddrStateDiff',
									 c=116 => 'InputAddrCurrAddrIncomeDiff',
									 c=117 => 'InputAddrCurrAddrHomeValDiff',
									 c=118 => 'InputAddrCurrAddrCrimeDiff',
									 c=119 => 'EconomicTrajectory',
									 c=120 => 'InputAddrPrevAddrMatch',
									 c=121 => 'CurrAddrPrevAddrDistance',
									 c=122 => 'CurrAddrPrevAddrStateDiff',
									 c=123 => 'CurrAddrPrevAddrIncomeDiff',
									 c=124 => 'CurrAddrPrevAddrHomeValDiff',
									 c=125 => 'CurrAddrPrevAddrCrimeDiff',
									 c=126 => 'EconomicTrajectory2',
									 c=127 => 'AddrStability',
									 c=128 => 'StatusMostRecent',
									 c=129 => 'StatusPrevious',
									 c=130 => 'StatusNextPrevious',
									 c=131 => 'PrevAddrDateFirstSeen2',
									 c=132 => 'NextPrevDateFirstSeen',
									 c=133 => 'AddrChanges30',
									 c=134 => 'AddrChanges90',
									 c=135 => 'AddrChanges180',
									 c=136 => 'AddrChanges12',
									 c=137 => 'AddrChanges24',
									 c=138 => 'AddrChanges36',
									 c=139 => 'AddrChanges60',
									 c=140 => 'InputAddrCommercial',
									 c=141 => 'InputPhoneCommercial',
									 c=142 => 'CommercialEntity',
									 c=143 => 'SIC',
									 c=144 => 'InputAddrPrison',
									 c=145 => 'InputZipPOBox',
									 c=146 => 'InputZipCorpMil',
									 c=147 => 'InputPhoneStatus',
									 c=148 => 'InputPhonePager',
									 c=149 => 'InputPhoneMobile',
									 c=150 => 'InvalidPhoneZip',
									 c=151 => 'InputPhoneAddrDist',
									 c=152 => 'PhoneType',
									 c=153 => 'ServiceType',
									 c=154 => 'AreaCodeChange',
									 c=155 => 'AltAreaCode',
									 c=156 => 'AddrVal',
									 c=157 => 'AddrValErrorCode',
									 c=158 => 'IPVal',
									 c=159 => 'IPNonUS',
									 c=160 => 'IPState',
									 c=161 => 'IPCountry',
									 'IPContinent');
									 
	self.value := map( c=1 => (string)le.version1.SSNFirstSeen,
										 c=2 => (string)le.version1.DateLastSeen,
										 c=3 => checkBoolean(le.version1.isRecentUpdate),
										 c=4 => (string)le.version1.NumSources,
										 c=5 => checkBoolean(le.version1.isPhoneFullNameMatch),
										 c=6 => checkBoolean(le.version1.isPhoneLastNameMatch),
										 c=7 => (string)le.version1.inferredAge,
										 c=8 => checkBoolean(le.version1.isSSNInvalid),
										 c=9 => checkBoolean(le.version1.isPhoneInvalid),
										 c=10 => checkBoolean(le.version1.isAddrInvalid),
										 c=11 => checkBoolean(le.version1.isDLInvalid),
										 c=12 => checkBoolean(le.version1.isNoVer),
										 c=13 => checkBoolean(le.version1.isDeceased),
										 c=14 => (string)le.version1.DeceasedDate,
										 c=15 => checkBoolean(le.version1.isSSNValid),
										 c=16 => checkBoolean(le.version1.isRecentIssue),
										 c=17 => (string)le.version1.LowIssueDate,
										 c=18 => (string)le.version1.HighIssueDate,
										 c=19 => (string)le.version1.IssueState,
										 c=20 => checkBoolean(le.version1.isNonUS),
										 c=21 => checkBoolean(le.version1.isIssued3),
										 c=22 => checkBoolean(le.version1.isIssuedAge5),
										 c=23 => le.version1.ssnCode,
										 c=24 => checkBoolean(le.version1.isSSNNotFound),
										 c=25 => checkBoolean(le.version1.isFoundOther),
										 c=26 => checkBoolean(le.version1.isIssuedPrior),
										 c=27 => checkBoolean(le.version1.isPhoneOther),
										 c=28 => (string)le.version1.SSNPerID,
										 c=29 => (string)le.version1.AddrPerID,
										 c=30 => (string)le.version1.PhonePerID,
										 c=31 => (string)le.version1.IDPerSSN,
										 c=32 => (string)le.version1.AddrPerSSN,
										 c=33 => (string)le.version1.IDPerAddr,
										 c=34 => (string)le.version1.SSNPerAddr,
										 c=35 => (string)le.version1.PhonePerAddr,
										 c=36 => (string)le.version1.IDPerPhone,
										 c=37 => (string)le.version1.SSNPerID6,
										 c=38 => (string)le.version1.AddrPerID6,
										 c=39 => (string)le.version1.PhonePerID6,
										 c=40 => (string)le.version1.IDPerSSN6,
										 c=41 => (string)le.version1.AddrPerSSN6,
										 c=42 => (string)le.version1.IDPerAddr6,
										 c=43 => (string)le.version1.SSNPerAddr6,
										 c=44 => (string)le.version1.PhonePerAddr6,
										 c=45 => (string)le.version1.IDPerPhone6,
										 c=46 => (string)le.version1.LastPerSSN,
										 c=47 => (string)le.version1.LastPerID,
										 c=48 => (string)le.version1.DateLastNameChange,
										 c=49 => le.version1.NewLastName,
										 c=50 => (string)le.version1.LastNames30,
										 c=51 => (string)le.version1.LastNames90,
										 c=52 => (string)le.version1.LastNames180,
										 c=53 => (string)le.version1.LastNames12,
										 c=54 => (string)le.version1.LastNames24,
										 c=55 => (string)le.version1.LastNames36,
										 c=56 => (string)le.version1.LastNames60,
										 c=57 => (string)le.version1.IDPerSFDUAddr,
										 c=58 => (string)le.version1.SSNPerSFDUAddr,
										 c=59 => le.version1.IAAddress,
										 c=60 => le.version1.IACity,
										 c=61 => le.version1.IAState,
										 c=62 => le.version1.IAZip,
										 c=63 => le.version1.IAZip4,
										 c=64 => (string)le.version1.IADateFirstReported,
										 c=65 => (string)le.version1.IADateLastReported,
										 c=66 => (string)le.version1.IALenOfRes,
										 c=67 => le.version1.IADwellType,
										 c=68 => checkBoolean(le.version1.IAisNotPrimaryRes),
										 c=69 => (string)le.version1.IAPhoneListed,
										 c=70 => (string)le.version1.IAPhoneNumber,
										 c=71 => le.version1.IAMED_HHINC,
										 c=72 => le.version1.IAMED_HVAL,
										 c=73 => le.version1.IAMURDERS,
										 c=74 => le.version1.IACARTHEFT,
										 c=75 => le.version1.IABURGLARY,
										 c=76 => le.version1.IATOTCRIME,
										 c=77 => le.version1.CAAddress,
										 c=78 => le.version1.CACity,
										 c=79 => le.version1.CAState,
										 c=80 => le.version1.CAZip,
										 c=81 => le.version1.CAZip4,
										 c=82 => (string)le.version1.CADateFirstReported,
										 c=83 => (string)le.version1.CADateLastReported,
										 c=84 => (string)le.version1.CALenOfRes,
										 c=85 => le.version1.CADwellType,
										 c=86 => checkBoolean(le.version1.CAisNotPrimaryRes),
										 c=87 => (string)le.version1.CAPhoneListed,
										 c=88 => (string)le.version1.CAPhoneNumber,
										 c=89 => le.version1.CAMED_HHINC,
										 c=90 => le.version1.CAMED_HVAL,
										 c=91 => le.version1.CAMURDERS,
										 c=92 => le.version1.CACARTHEFT,
										 c=93 => le.version1.CABURGLARY,
										 c=94 => le.version1.CATOTCRIME,
										 c=95 => le.version1.PAAddress,
										 c=96 => le.version1.PACity,
										 c=97 => le.version1.PAState,
										 c=98 => le.version1.PAZip,
										 c=99 => le.version1.PAZip4,
										 c=100 => (string)le.version1.PADateFirstReported,
										 c=101 => (string)le.version1.PADateLastReported,
										 c=102 => (string)le.version1.PALenOfRes,
										 c=103 => le.version1.PADwellType,
										 c=104 => checkBoolean(le.version1.PAisNotPrimaryRes),
										 c=105 => (string)le.version1.PAPhoneListed,
										 c=106 => (string)le.version1.PAPhoneNumber,
										 c=107 => le.version1.PAMED_HHINC,
										 c=108 => le.version1.PAMED_HVAL,
										 c=109 => le.version1.PAMURDERS,
										 c=110 => le.version1.PACARTHEFT,
										 c=111 => le.version1.PABURGLARY,
										 c=112 => le.version1.PATOTCRIME,
										 c=113 => checkBoolean(le.version1.isInputCurrMatch),
										 c=114 => (string)le.version1.DistInputCurr,
										 c=115 => checkBoolean(le.version1.isDiffState),
										 c=116 => (string)le.version1.IncomeDiff,
										 c=117 => (string)le.version1.HomeValueDiff,
										 c=118 => (string)le.version1.CrimeDiff,
										 c=119 => le.version1.EcoTrajectory,
										 c=120 => checkBoolean(le.version1.isInputPrevMatch),
										 c=121 => (string)le.version1.DistCurrPrev,
										 c=122 => checkBoolean(le.version1.isDiffState2),
										 c=123 => (string)le.version1.IncomeDiff2,
										 c=124 => (string)le.version1.HomeValueDiff2,
										 c=125 => (string)le.version1.CrimeDiff2,
										 c=126 => le.version1.EcoTrajectory2,
										 c=127 => (string)le.version1.mobility_indicator,
										 c=128 => le.version1.statusAddr,
										 c=129 => le.version1.statusAddr2,
										 c=130 => le.version1.statusAddr3,
										 c=131 => (string)le.version1.PADateFirstReported2,
										 c=132 => (string)le.version1.NPADateFirstReported,
										 c=133 => (string)le.version1.addrChanges30,
										 c=134 => (string)le.version1.AddrChanges90,
										 c=135 => (string)le.version1.AddrChanges180,
										 c=136 => (string)le.version1.AddrChanges12,
										 c=137 => (string)le.version1.AddrChanges24,
										 c=138 => (string)le.version1.AddrChanges36,
										 c=139 => (string)le.version1.AddrChanges60,
										 c=140 => checkBoolean(le.version1.isAddrHighRisk),
										 c=141 => checkBoolean(le.version1.isPhoneHighRisk),
										 c=142 => le.version1.hriskcmpy,
										 c=143 => le.version1.sic,
										 c=144 => checkBoolean(le.version1.isAddrPrison),
										 c=145 => checkBoolean(le.version1.isZipPOBox),
										 c=146 => checkBoolean(le.version1.isZipCorpMil),
										 c=147 => le.version1.phoneStatus,
										 c=148 => checkBoolean(le.version1.isPhonePager),
										 c=149 => checkBoolean(le.version1.isPhoneMobile),
										 c=150 => checkBoolean(le.version1.isPhoneZipMismatch),
										 c=151 => (string)le.version1.phoneAddrDist,
										 c=152 => le.version1.hphonetypeflag,
										 c=153 => le.version1.hphonesrvcflag,
										 c=154 => le.version1.areacodesplit,
										 c=155 => le.version1.altareacode,
										 c=156 => le.version1.addrval,
										 c=157 => le.version1.invalidaddr,
										 c=158 => checkBoolean(le.version1.IPinvalid),
										 c=159 => checkBoolean(le.version1.IPNonUS),
										 c=160 => le.version1.IPState,
										 c=161 => le.version1.IPCountry,
										 le.version1.IPContinent);
END;

Models.Layout_Parameters intoVersion2(Models.Layout_FraudAttributes le, integer c) := TRANSFORM
	self.name := map(
		c=	1	=> 'IdentityRiskLevel',
		c=	2	=> 'IdentityAgeOldest',
		c=	3	=> 'IdentityAgeNewest',
		c=	4	=> 'IdentityRecentUpdate',
		c=	5	=> 'IdentityRecordCount',
		c=	6	=> 'IdentitySourceCount',
		c=	7	=> 'IdentityAgeRiskIndicator',
		c=	8	=> 'IDVerRiskLevel',
		c=	9	=> 'IDVerSSN',
		c=	10	=> 'IDVerName',
		c=	11	=> 'IDVerAddress',
		c=	12	=> 'IDVerAddressNotCurrent',
		c=	13	=> 'IDVerAddressAssocCount',
		c=	14	=> 'IDVerPhone',
		c=	15	=> 'IDVerDriversLicense',
		c=	16	=> 'IDVerDOB',
		c=	17	=> 'IDVerSSNSourceCount',
		c=	18	=> 'IDVerAddressSourceCount',
		c=	19	=> 'IDVerDOBSourceCount',
		c=	20	=> 'IDVerSSNCreditBureauCount',
		c=	21	=> 'IDVerSSNCreditBureauDelete',  
		c=	22	=> 'IDVerAddrCreditBureauCount',
		c=	23	=> 'SourceRiskLevel',
		c=	24	=> 'SourceFirstReportingIdentity',
		c=	25	=> 'SourceCreditBureau',
		c=	26	=> 'SourceCreditBureauCount',
		c=	27	=> 'SourceCreditBureauAgeOldest',
		c=	28	=> 'SourceCreditBureauAgeNewest',
		c=	29	=> 'SourceCreditBureauAgeChange',
		c=	30	=> 'SourcePublicRecord',
		c=	31	=> 'SourcePublicRecordCount',
		c=	32	=> 'SourcePublicRecordCountYear',
		c=	33	=> 'SourceEducation',
		c=	34	=> 'SourceOccupationalLicense',
		c=	35	=> 'SourceVoterRegistration',
		c=	36	=> 'SourceOnlineDirectory',
		c=	37	=> 'SourceDoNotMail',
		c=	38	=> 'SourceAccidents',
		c=	39	=> 'SourceBusinessRecords',
		c=	40	=> 'SourceProperty',
		c=	41	=> 'SourceAssets',
		c=	42	=> 'SourcePhoneDirectoryAssistance',
		c=	43	=> 'SourcePhoneNonPublicDirectory',
		c=	44	=> 'VariationRiskLevel',
		c=	45	=> 'VariationIdentityCount',
		c=	46	=> 'VariationSSNCount',
		c=	47	=> 'VariationSSNCountNew',
		c=	48	=> 'VariationMSourcesSSNCount',
		c=	49	=> 'VariationMSourcesSSNUnrelCount',
		c=	50	=> 'VariationLastNameCount',
		c=	51	=> 'VariationLastNameCountNew',
		c=	52	=> 'VariationAddrCountYear',
		c=	53	=> 'VariationAddrCountNew',
		c=	54	=> 'VariationAddrStability',
		c=	55	=> 'VariationAddrChangeAge',
		c=	56	=> 'VariationDOBCount',
		c=	57	=> 'VariationDOBCountNew',
		c=	58	=> 'VariationPhoneCount',
		c=	59	=> 'VariationPhoneCountNew',
		c=	60	=> 'VariationSearchSSNCount',
		c=	61	=> 'VariationSearchAddrCount',
		c=	62	=> 'VariationSearchPhoneCount',
		c=	63	=> 'SearchVelocityRiskLevel',
		c=	64	=> 'SearchCount',
		c=	65	=> 'SearchCountYear',
		c=	66	=> 'SearchCountMonth',
		c=	67	=> 'SearchCountWeek',
		c=	68	=> 'SearchCountDay',
		c=	69	=> 'SearchUnverifiedSSNCountYear',
		c=	70	=> 'SearchUnverifiedAddrCountYear',
		c=	71	=> 'SearchUnverifiedDOBCountYear',
		c=	72	=> 'SearchUnverifiedPhoneCountYear',
		c=	73	=> 'SearchBankingSearchCount',
		c=	74	=> 'SearchBankingSearchCountYear',
		c=	75	=> 'SearchBankingSearchCountMonth',
		c=	76	=> 'SearchBankingSearchCountWeek',
		c=	77	=> 'SearchBankingSearchCountDay',
		c=	78	=> 'SearchHighRiskSearchCount',
		c=	79	=> 'SearchHighRiskSearchCountYear',
		c=	80	=> 'SearchHighRiskSearchCountMonth',
		c=	81	=> 'SearchHighRiskSearchCountWeek',
		c=	82	=> 'SearchHighRiskSearchCountDay',
		c=	83	=> 'SearchFraudSearchCount',
		c=	84	=> 'SearchFraudSearchCountYear',
		c=	85	=> 'SearchFraudSearchCountMonth',
		c=	86	=> 'SearchFraudSearchCountWeek',
		c=	87	=> 'SearchFraudSearchCountDay',
		c=	88	=> 'SearchLocateSearchCount',
		c=	89	=> 'SearchLocateSearchCountYear',
		c=	90	=> 'SearchLocateSearchCountMonth',
		c=	91	=> 'SearchLocateSearchCountWeek',
		c=	92	=> 'SearchLocateSearchCountDay',
		c=	93	=> 'AssocRiskLevel',
		c=	94	=> 'AssocCount',
		c=	95	=> 'AssocDistanceClosest',
		c=	96	=> 'AssocSuspicousIdentitiesCount',
		c=	97	=> 'AssocCreditBureauOnlyCount',
		c=	98	=> 'AssocCreditBureauOnlyCountNew',
		c=	99	=> 'AssocCreditBureauOnlyCountMonth',
		c=	100	=> 'AssocHighRiskTopologyCount',
		c=	101	=> 'ValidationRiskLevel',
		c=	102	=> 'ValidationSSNProblems',
		c=	103	=> 'ValidationAddrProblems',
		c=	104	=> 'ValidationPhoneProblems',
		c=	105	=> 'ValidationDLProblems',
		c=	106	=> 'ValidationIPProblems',
		c=	107	=> 'CorrelationRiskLevel',
		c=	108	=> 'CorrelationSSNNameCount',
		c=	109	=> 'CorrelationSSNAddrCount',
		c=	110	=> 'CorrelationAddrNameCount',
		c=	111	=> 'CorrelationAddrPhoneCount',
		c=	112	=> 'CorrelationPhoneLastNameCount',
		c=	113	=> 'DivRiskLevel',
		c=	114	=> 'DivSSNIdentityCount',
		c=	115	=> 'DivSSNIdentityCountNew',
		c=	116	=> 'DivSSNIdentityMSourceCount',
		c=	117	=> 'DivSSNIdentityMSourceUrelCount',
		c=	118	=> 'DivSSNLNameCount',
		c=	119	=> 'DivSSNLNameCountNew',
		c=	120	=> 'DivSSNAddrCount',
		c=	121	=> 'DivSSNAddrCountNew',
		c=	122	=> 'DivSSNAddrMSourceCount',
		c=	123	=> 'DivAddrIdentityCount',
		c=	124	=> 'DivAddrIdentityCountNew',
		c=	125	=> 'DivAddrIdentityMSourceCount',
		c=	126	=> 'DivAddrSuspIdentityCountNew',
		c=	127	=> 'DivAddrSSNCount',
		c=	128	=> 'DivAddrSSNCountNew',
		c=	129	=> 'DivAddrSSNMSourceCount',
		c=	130	=> 'DivAddrPhoneCount',
		c=	131	=> 'DivAddrPhoneCountNew',
		c=	132	=> 'DivAddrPhoneMSourceCount',
		c=	133	=> 'DivPhoneIdentityCount',
		c=	134	=> 'DivPhoneIdentityCountNew',
		c=	135	=> 'DivPhoneIdentityMSourceCount',
		c=	136	=> 'DivPhoneAddrCount',
		c=	137	=> 'DivPhoneAddrCountNew',
		c=	138	=> 'DivSearchSSNIdentityCount',
		c=	139	=> 'DivSearchAddrIdentityCount',
		c=	140	=> 'DivSearchAddrSuspIdentityCount',
		c=	141	=> 'DivSearchPhoneIdentityCount',
		c=	142	=> 'SearchComponentRiskLevel',
		c=	143	=> 'SearchSSNSearchCount',
		c=	144	=> 'SearchSSNSearchCountYear',
		c=	145	=> 'SearchSSNSearchCountMonth',
		c=	146	=> 'SearchSSNSearchCountWeek',
		c=	147	=> 'SearchSSNSearchCountDay',
		c=	148	=> 'SearchAddrSearchCount',
		c=	149	=> 'SearchAddrSearchCountYear',
		c=	150	=> 'SearchAddrSearchCountMonth',
		c=	151	=> 'SearchAddrSearchCountWeek',
		c=	152	=> 'SearchAddrSearchCountDay',
		c=	153	=> 'SearchPhoneSearchCount',
		c=	154	=> 'SearchPhoneSearchCountYear',
		c=	155	=> 'SearchPhoneSearchCountMonth',
		c=	156	=> 'SearchPhoneSearchCountWeek',
		c=	157	=> 'SearchPhoneSearchCountDay',
		c=	158	=> 'ComponentCharRiskLevel',
		c=	159	=> 'SSNHighIssueAge',
		c=	160	=> 'SSNLowIssueAge',
		c=	161	=> 'SSNIssueState',
		c=	162	=> 'SSNNonUS',
		c=	163	=> 'InputPhoneType',
		c=	164	=> 'IPState',
		c=	165	=> 'IPCountry',
		c=	166	=> 'IPContinent',
		c=	167	=> 'InputAddrAgeOldest',
		c=	168	=> 'InputAddrAgeNewest',
		c=	169	=> 'InputAddrType',
		c=	170	=> 'InputAddrLenOfRes',
		c=	171	=> 'InputAddrDwellType',
		c=	172	=> 'InputAddrDelivery',
		c=	173	=> 'InputAddrActivePhoneList',
		c=	174	=> 'InputAddrOccupantOwned',
		c=	175	=> 'InputAddrBusinessCount',
		c=	176	=> 'InputAddrNBRHDBusinessCount',
		c=	177	=> 'InputAddrNBRHDSingleFamilyCount',
		c=	178	=> 'InputAddrNBRHDMultiFamilyCount',
		c=	179	=> 'InputAddrNBRHDMedianIncome',
		c=	180	=> 'InputAddrNBRHDMedianValue',
		c=	181	=> 'InputAddrNBRHDMurderIndex',
		c=	182	=> 'InputAddrNBRHDCarTheftIndex',
		c=	183	=> 'InputAddrNBRHDBurglaryIndex',
		c=	184	=> 'InputAddrNBRHDCrimeIndex',
		c=	185	=> 'InputAddrNBRHDMobilityIndex',
		c=	186	=> 'InputAddrNBRHDVacantPropCount',
		c=	187	=> 'AddrChangeDistance',
		c=	188	=> 'AddrChangeStateDiff',
		c=	189	=> 'AddrChangeIncomeDiff',
		c=	190	=> 'AddrChangeValueDiff',
		c=	191	=> 'AddrChangeCrimeDiff',
		c=	192	=> 'AddrChangeEconTrajectory',
		c=	193	=> 'AddrChangeEconTrajectoryIndex',
		c=	194	=> 'CurrAddrAgeOldest',
		c=	195	=> 'CurrAddrAgeNewest',
		c=	196	=> 'CurrAddrLenOfRes',
		c=	197	=> 'CurrAddrDwellType',
		c=	198	=> 'CurrAddrStatus',
		c=	199	=> 'CurrAddrActivePhoneList',
		c=	200	=> 'CurrAddrMedianIncome',
		c=	201	=> 'CurrAddrMedianValue',
		c=	202	=> 'CurrAddrMurderIndex',
		c=	203	=> 'CurrAddrCarTheftIndex',
		c=	204	=> 'CurrAddrBurglaryIndex',
		c=	205	=> 'CurrAddrCrimeIndex',
		c=	206	=> 'PrevAddrAgeOldest',
		c=	207	=> 'PrevAddrAgeNewest',
		c=	208	=> 'PrevAddrLenOfRes',
		c=	209	=> 'PrevAddrDwellType',
		c=	210	=> 'PrevAddrStatus',
		c=	211	=> 'PrevAddrOccupantOwned',
		c=	212	=> 'PrevAddrMedianIncome',
		c=	213	=> 'PrevAddrMedianValue',
		c=	214	=> 'PrevAddrMurderIndex',
		c=	215	=> 'PrevAddrCarTheftIndex',
		c=	216	=> 'PrevAddrBurglaryIndex',
		c=	217 => 'PrevAddrCrimeIndex',
// -------------- begin 2.01 attributes		
		c=	218 => 'IDVerAddressMatchesCurrent',
		c=	219 => 'IDVerAddressVoter',
		c=	220 => 'IDVerAddressVehicleRegistration',
		c=	221 => 'IDVerAddressDriversLicense',
		c=	222 => 'IDVerDriversLicenseType',
		c=	223 => 'IDVerSSNDriversLicense',
		c=	224 => 'SourceVehicleRegistration',
		c=	225 => 'SourceDriversLicense',
		c= 	226 => 'IdentityDriversLicenseComp',
		'INVALID'
		);
									 
	self.value := map( 
		c=	1	=> le.version2.IdentityRiskLevel	,
		c=	2	=> le.version2.IdentityAgeOldest	,
		c=	3	=> le.version2.IdentityAgeNewest	,
		c=	4	=> le.version2.IdentityRecentUpdate	,
		c=	5	=> le.version2.IdentityRecordCount	,
		c=	6	=> le.version2.IdentitySourceCount	,
		c=	7	=> le.version2.IdentityAgeRiskIndicator	,
		c=	8	=> le.version2.IDVerRiskLevel	,
		c=	9	=> le.version2.IDVerSSN	,
		c=	10	=> le.version2.IDVerName	,
		c=	11	=> le.version2.IDVerAddress	,
		c=	12	=> le.version2.IDVerAddressNotCurrent	,
		c=	13	=> le.version2.IDVerAddressAssocCount	,
		c=	14	=> le.version2.IDVerPhone	,
		c=	15	=> le.version2.IDVerDriversLicense	,
		c=	16	=> le.version2.IDVerDOB	,
		c=	17	=> le.version2.IDVerSSNSourceCount	,
		c=	18	=> le.version2.IDVerAddressSourceCount	,
		c=	19	=> le.version2.IDVerDOBSourceCount	,
		c=	20	=> le.version2.IDVerSSNCreditBureauCount	,
		c=	21	=> le.version2.IDVerSSNCreditBureauDelete	,
		c=	22	=> le.version2.IDVerAddrCreditBureauCount	,
		c=	23	=> le.version2.SourceRiskLevel	,
		c=	24	=> le.version2.SourceFirstReportingIdentity	,
		c=	25	=> le.version2.SourceCreditBureau	,
		c=	26	=> le.version2.SourceCreditBureauCount	,
		c=	27	=> le.version2.SourceCreditBureauAgeOldest	,
		c=	28	=> le.version2.SourceCreditBureauAgeNewest	,
		c=	29	=> le.version2.SourceCreditBureauAgeChange	,
		c=	30	=> le.version2.SourcePublicRecord	,
		c=	31	=> le.version2.SourcePublicRecordCount	,
		c=	32	=> le.version2.SourcePublicRecordCountYear	,
		c=	33	=> le.version2.SourceEducation	,
		c=	34	=> le.version2.SourceOccupationalLicense	,
		c=	35	=> le.version2.SourceVoterRegistration	,
		c=	36	=> le.version2.SourceOnlineDirectory	,
		c=	37	=> le.version2.SourceDoNotMail	,
		c=	38	=> le.version2.SourceAccidents	,
		c=	39	=> le.version2.SourceBusinessRecords	,
		c=	40	=> le.version2.SourceProperty	,
		c=	41	=> le.version2.SourceAssets	,
		c=	42	=> le.version2.SourcePhoneDirectoryAssistance	,
		c=	43	=> le.version2.SourcePhoneNonPublicDirectory	,
		c=	44	=> le.version2.VariationRiskLevel	,
		c=	45	=> le.version2.VariationIdentityCount	,
		c=	46	=> le.version2.VariationSSNCount	,
		c=	47	=> le.version2.VariationSSNCountNew	,
		c=	48	=> le.version2.VariationMSourcesSSNCount	,
		c=	49	=> le.version2.VariationMSourcesSSNUnrelCount	,
		c=	50	=> le.version2.VariationLastNameCount	,
		c=	51	=> le.version2.VariationLastNameCountNew	,
		c=	52	=> le.version2.VariationAddrCountYear	,
		c=	53	=> le.version2.VariationAddrCountNew	,
		c=	54	=> le.version2.VariationAddrStability	,
		c=	55	=> le.version2.VariationAddrChangeAge	,
		c=	56	=> le.version2.VariationDOBCount	,
		c=	57	=> le.version2.VariationDOBCountNew	,
		c=	58	=> le.version2.VariationPhoneCount	,
		c=	59	=> le.version2.VariationPhoneCountNew	,
		c=	60	=> le.version2.VariationSearchSSNCount	,
		c=	61	=> le.version2.VariationSearchAddrCount	,
		c=	62	=> le.version2.VariationSearchPhoneCount	,
		c=	63	=> le.version2.SearchVelocityRiskLevel	,
		c=	64	=> le.version2.SearchCount	,
		c=	65	=> le.version2.SearchCountYear	,
		c=	66	=> le.version2.SearchCountMonth	,
		c=	67	=> le.version2.SearchCountWeek	,
		c=	68	=> le.version2.SearchCountDay	,
		c=	69	=> le.version2.SearchUnverifiedSSNCountYear	,
		c=	70	=> le.version2.SearchUnverifiedAddrCountYear	,
		c=	71	=> le.version2.SearchUnverifiedDOBCountYear	,
		c=	72	=> le.version2.SearchUnverifiedPhoneCountYear	,
		c=	73	=> le.version2.SearchBankingSearchCount	,
		c=	74	=> le.version2.SearchBankingSearchCountYear	,
		c=	75	=> le.version2.SearchBankingSearchCountMonth	,
		c=	76	=> le.version2.SearchBankingSearchCountWeek	,
		c=	77	=> le.version2.SearchBankingSearchCountDay	,
		c=	78	=> le.version2.SearchHighRiskSearchCount	,
		c=	79	=> le.version2.SearchHighRiskSearchCountYear	,
		c=	80	=> le.version2.SearchHighRiskSearchCountMonth	,
		c=	81	=> le.version2.SearchHighRiskSearchCountWeek	,
		c=	82	=> le.version2.SearchHighRiskSearchCountDay	,
		c=	83	=> le.version2.SearchFraudSearchCount	,
		c=	84	=> le.version2.SearchFraudSearchCountYear	,
		c=	85	=> le.version2.SearchFraudSearchCountMonth	,
		c=	86	=> le.version2.SearchFraudSearchCountWeek	,
		c=	87	=> le.version2.SearchFraudSearchCountDay	,
		c=	88	=> le.version2.SearchLocateSearchCount	,
		c=	89	=> le.version2.SearchLocateSearchCountYear	,
		c=	90	=> le.version2.SearchLocateSearchCountMonth	,
		c=	91	=> le.version2.SearchLocateSearchCountWeek	,
		c=	92	=> le.version2.SearchLocateSearchCountDay	,
		c=	93	=> le.version2.AssocRiskLevel	,
		c=	94	=> le.version2.AssocCount	,
		c=	95	=> le.version2.AssocDistanceClosest	,
		c=	96	=> le.version2.AssocSuspicousIdentitiesCount	,
		c=	97	=> le.version2.AssocCreditBureauOnlyCount	,	
		c=	98	=> le.version2.AssocCreditBureauOnlyCountNew	,
		c=	99	=> le.version2.AssocCreditBureauOnlyCountMonth	,
		c=	100	=> le.version2.AssocHighRiskTopologyCount	,
		c=	101	=> le.version2.ValidationRiskLevel	,
		c=	102	=> le.version2.ValidationSSNProblems	,
		c=	103	=> le.version2.ValidationAddrProblems	,
		c=	104	=> le.version2.ValidationPhoneProblems	,
		c=	105	=> le.version2.ValidationDLProblems	,
		c=	106	=> le.version2.ValidationIPProblems	,
		c=	107	=> le.version2.CorrelationRiskLevel	,
		c=	108	=> le.version2.CorrelationSSNNameCount	,
		c=	109	=> le.version2.CorrelationSSNAddrCount	,
		c=	110	=> le.version2.CorrelationAddrNameCount	,
		c=	111	=> le.version2.CorrelationAddrPhoneCount	,
		c=	112	=> le.version2.CorrelationPhoneLastNameCount	,
		c=	113	=> le.version2.DivRiskLevel	,
		c=	114	=> le.version2.DivSSNIdentityCount	,
		c=	115	=> le.version2.DivSSNIdentityCountNew	,
		c=	116	=> le.version2.DivSSNIdentityMSourceCount	,
		c=	117	=> le.version2.DivSSNIdentityMSourceUrelCount	,
		c=	118	=> le.version2.DivSSNLNameCount	,
		c=	119	=> le.version2.DivSSNLNameCountNew	,
		c=	120	=> le.version2.DivSSNAddrCount	,
		c=	121	=> le.version2.DivSSNAddrCountNew	,
		c=	122	=> le.version2.DivSSNAddrMSourceCount	,
		c=	123	=> le.version2.DivAddrIdentityCount	,
		c=	124	=> le.version2.DivAddrIdentityCountNew	,
		c=	125	=> le.version2.DivAddrIdentityMSourceCount	,
		c=	126	=> le.version2.DivAddrSuspIdentityCountNew	,
		c=	127	=> le.version2.DivAddrSSNCount	,
		c=	128	=> le.version2.DivAddrSSNCountNew	,
		c=	129	=> le.version2.DivAddrSSNMSourceCount	,
		c=	130	=> le.version2.DivAddrPhoneCount	,
		c=	131	=> le.version2.DivAddrPhoneCountNew	,
		c=	132	=> le.version2.DivAddrPhoneMSourceCount	,
		c=	133	=> le.version2.DivPhoneIdentityCount	,
		c=	134	=> le.version2.DivPhoneIdentityCountNew	,
		c=	135	=> le.version2.DivPhoneIdentityMSourceCount	,
		c=	136	=> le.version2.DivPhoneAddrCount	,
		c=	137	=> le.version2.DivPhoneAddrCountNew	,
		c=	138	=> le.version2.DivSearchSSNIdentityCount	,
		c=	139	=> le.version2.DivSearchAddrIdentityCount	,
		c=	140	=> le.version2.DivSearchAddrSuspIdentityCount	,
		c=	141	=> le.version2.DivSearchPhoneIdentityCount	,
		c=	142	=> le.version2.SearchComponentRiskLevel	,
		c=	143	=> le.version2.SearchSSNSearchCount	,
		c=	144	=> le.version2.SearchSSNSearchCountYear	,
		c=	145	=> le.version2.SearchSSNSearchCountMonth	,
		c=	146	=> le.version2.SearchSSNSearchCountWeek	,
		c=	147	=> le.version2.SearchSSNSearchCountDay	,
		c=	148	=> le.version2.SearchAddrSearchCount	,
		c=	149	=> le.version2.SearchAddrSearchCountYear	,
		c=	150	=> le.version2.SearchAddrSearchCountMonth	,
		c=	151	=> le.version2.SearchAddrSearchCountWeek	,
		c=	152	=> le.version2.SearchAddrSearchCountDay	,
		c=	153	=> le.version2.SearchPhoneSearchCount	,
		c=	154	=> le.version2.SearchPhoneSearchCountYear	,
		c=	155	=> le.version2.SearchPhoneSearchCountMonth	,
		c=	156	=> le.version2.SearchPhoneSearchCountWeek	,
		c=	157	=> le.version2.SearchPhoneSearchCountDay	,
		c=	158	=> le.version2.ComponentCharRiskLevel	,
		c=	159	=> le.version2.SSNHighIssueAge	,
		c=	160	=> le.version2.SSNLowIssueAge	,
		c=	161	=> le.version2.SSNIssueState	,
		c=	162	=> le.version2.SSNNonUS	,
		c=	163	=> le.version2.InputPhoneType	,
		c=	164	=> le.version2.IPState	,
		c=	165	=> le.version2.IPCountry	,
		c=	166	=> le.version2.IPContinent	,
		c=	167	=> le.version2.InputAddrAgeOldest	,
		c=	168	=> le.version2.InputAddrAgeNewest	,
		c=	169	=> le.version2.InputAddrType	,
		c=	170	=> le.version2.InputAddrLenOfRes	,
		c=	171	=> le.version2.InputAddrDwellType	,
		c=	172	=> le.version2.InputAddrDelivery	,
		c=	173	=> le.version2.InputAddrActivePhoneList	,
		c=	174	=> le.version2.InputAddrOccupantOwned	,
		c=	175	=> le.version2.InputAddrBusinessCount	,
		c=	176	=> le.version2.InputAddrNBRHDBusinessCount	,
		c=	177	=> le.version2.InputAddrNBRHDSingleFamilyCount	,
		c=	178	=> le.version2.InputAddrNBRHDMultiFamilyCount	,
		c=	179	=> le.version2.InputAddrNBRHDMedianIncome	,
		c=	180	=> le.version2.InputAddrNBRHDMedianValue	,
		c=	181	=> le.version2.InputAddrNBRHDMurderIndex	,
		c=	182	=> le.version2.InputAddrNBRHDCarTheftIndex	,
		c=	183	=> le.version2.InputAddrNBRHDBurglaryIndex	,
		c=	184	=> le.version2.InputAddrNBRHDCrimeIndex	,
		c=	185	=> le.version2.InputAddrNBRHDMobilityIndex	,
		c=	186	=> le.version2.InputAddrNBRHDVacantPropCount	,
		c=	187	=> le.version2.AddrChangeDistance	,
		c=	188	=> le.version2.AddrChangeStateDiff	,
		c=	189	=> le.version2.AddrChangeIncomeDiff	,
		c=	190	=> le.version2.AddrChangeValueDiff	,
		c=	191	=> le.version2.AddrChangeCrimeDiff	,
		c=	192	=> le.version2.AddrChangeEconTrajectory	,
		c=	193	=> le.version2.AddrChangeEconTrajectoryIndex	,
		c=	194	=> le.version2.CurrAddrAgeOldest	,
		c=	195	=> le.version2.CurrAddrAgeNewest	,
		c=	196	=> le.version2.CurrAddrLenOfRes	,
		c=	197	=> le.version2.CurrAddrDwellType	,
		c=	198	=> le.version2.CurrAddrStatus	,
		c=	199	=> le.version2.CurrAddrActivePhoneList	,
		c=	200	=> le.version2.CurrAddrMedianIncome	,
		c=	201	=> le.version2.CurrAddrMedianValue	,
		c=	202	=> le.version2.CurrAddrMurderIndex	,
		c=	203	=> le.version2.CurrAddrCarTheftIndex	,
		c=	204	=> le.version2.CurrAddrBurglaryIndex	,
		c=	205	=> le.version2.CurrAddrCrimeIndex	,
		c=	206	=> le.version2.PrevAddrAgeOldest	,
		c=	207	=> le.version2.PrevAddrAgeNewest	,
		c=	208	=> le.version2.PrevAddrLenOfRes	,
		c=	209	=> le.version2.PrevAddrDwellType	,
		c=	210	=> le.version2.PrevAddrStatus	,
		c=	211	=> le.version2.PrevAddrOccupantOwned	,
		c=	212	=> le.version2.PrevAddrMedianIncome	,
		c=	213	=> le.version2.PrevAddrMedianValue	,
		c=	214	=> le.version2.PrevAddrMurderIndex	,
		c=	215	=> le.version2.PrevAddrCarTheftIndex	,
		c=	216	=> le.version2.PrevAddrBurglaryIndex	,
		c=	217 => le.version2.PrevAddrCrimeIndex,
// -------------- begin 2.01 attributes		
		c=	218 => le.version201.IDVerAddressMatchesCurrent,
		c=	219 => le.version201.IDVerAddressVoter,
		c=	220 => le.version201.IDVerAddressVehicleRegistation,
		c=	221 => le.version201.IDVerAddressDriversLicense,
		c=	222 => le.version201.IDVerDriversLicenseType,
		c=	223 => le.version201.IDVerSSNDriversLicense,
		c=	224 => le.version201.SourceVehicleRegistration,
		c=	225 => le.version201.SourceDriversLicense,
		c= 	226 => le.version201.IdentityDriversLicenseComp,
		''
		);
END;

Models.Layout_Parameters intoIDAttributes(Models.Layout_FraudAttributes le, integer c) := TRANSFORM
	self.name := map(c=1 => 'InputPresent',
			 c=2 => 'DoOutput',
			 c=3 => 'DataReturn',
			 c=4 => 'FirstCount',
			 c=5 => 'LastCount',
			 c=6 => 'AddrCount',
			 c=7 => 'FormerAddrCount',
			 c=8 => 'HPhoneCount',
			 c=9 => 'SocsCount',
			 c=10 => 'SocsVerLevel',
			 c=11 => 'DOBCount',
			 c=12 => 'DRLCCount',
			 c=13 => 'CmpyCount',
			 c=14 => 'VerFirst',
			 c=15 => 'VerLast',
			 c=16 => 'VerCmpy',
			 c=17 => 'VerAddr',
			 c=18 => 'VerCity',
			 c=19 => 'VerState',
			 c=20 => 'VerZIP',
			 c=21 => 'VerHPhone',
			 c=22 => 'VerSocs',
			 c=23 => 'VerDRLC',
			 c=24 => 'VerDOB',
			 c=25 => 'NumELever',
			 c=26 => 'NumSource',
			 c=27 => 'FirstScore',
			 c=28 => 'LastScore',
			 c=29 => 'CmpyScore',
			 c=30 => 'AddrScore',
			 c=31 => 'HPhoneScore',
			 c=32 => 'SocsScore',
			 c=33 => 'DOBScore',
			 c=34 => 'DRLCScore',
			 c=35 => 'WPhoneName',
			 c=36 => 'WPhoneAddr',
			 c=37 => 'WPhoneCity',
			 c=38 => 'WPhoneState',
			 c=39 => 'WPhoneZIP',
			 c=40 => 'SocsMiskeyFlag',
			 c=41 => 'HPhoneMiskeyFlag',
			 c=42 => 'AddrMiskeyFlag',
			 c=43 => 'IDTheftFlag',
			 c=44 => 'AptScanFlag',
			 c=45 => 'AddrHistoryFlag',
			 c=46 => 'COAAlertFlag',
			 c=47 => 'COAFirst',
			 c=48 => 'COALast',
			 c=49 => 'COAAddr',
			 c=50 => 'COACity',
			 c=51 => 'COAState',
			 c=52 => 'COAZip',
			 c=53 => 'WPhoneTypeFlag',
			 c=54 => 'WPhoneValFlag',
			 c=55 => 'HPhoneTypeFlag',
			 c=56 => 'HPhoneValFlag',
			 c=57 => 'PhoneZIPFlag',
			 c=58 => 'PhoneDissFlag',
			 c=59 => 'AddrValFlag',
			 c=60 => 'DwellTypeFlag',
			 c=61 => 'ZIPTypeFlag',
			 c=62 => 'SocsValFlag',
			 c=63 => 'DecsFlag',
			 c=64 => 'SocsDOBFlag',
			 c=65 => 'AreaCodeSplitFlag',
			 c=66 => 'AreaCodeSplitDate',
			 c=67 => 'AltAreaCode',
			 c=68 => 'BansFlag',
			 c=69 => 'DRLCValFlag',
			 c=70 => 'DRLCSoundX',
			 c=71 => 'DRLCFirst',
			 c=72 => 'DRLCLast',
			 c=73 => 'DRLCMiddle',
			 c=74 => 'DRLCSocs',
			 c=75 => 'DRLCDOB',
			 c=76 => 'DRLCGender',
			 c=77 => 'DistAddrPrevAddr',
			 c=78 => 'DistHPhoneWPhone',
			 c=79 => 'DistWPhoneAddr',
			 c=80 => 'StateZIPFlag',
			 c=81 => 'CityZIPFlag',
			 c=82 => 'HPhoneStateFlag',
			 c=83 => 'CheckAcctFlag',
			 c=84 => 'CassAddr',
			 c=85 => 'CassCity',
			 c=86 => 'CassState',
			 c=87 => 'CassZIP',
			 c=88 => 'AddrCommFlag',
			 c=89 => 'NonResName',
			 c=90 => 'NonResSic',
			 c=91 => 'NonResPhone',
			 c=92 => 'NonResAddr',
			 c=93 => 'NonResCity',
			 c=94 => 'NonResState',
			 c=95 => 'NonResZIP',
			 c=96 => 'NumFraud',
			 c=97 => 'Score2',
			 c=98 => 'TciAddrFlag',
			 c=99 => 'TciPrevAddrFlag',
			 c=100 => 'EstIncome',
			 c=101 => 'EmailDomainFlag',
			 c=102 => 'EmailUserFlag',
			 c=103 => 'EmailBrowserFlag',
			 c=104 => 'HRiskEmailDomainFlag',
			 c=105 => 'DistAddrDomain',
			 'IDAttributes');
 
	self.value := map(c=1 => le.IDAttributes.InputPresent,
			c=2 => le.IDAttributes.DoOutput,
			c=3 => le.IDAttributes.DataReturn,
			c=4 => le.IDAttributes.FirstCount,
			c=5 => le.IDAttributes.LastCount,
			c=6 => le.IDAttributes.AddrCount,
			c=7 => le.IDAttributes.FormerAddrCount,
			c=8 => le.IDAttributes.HPhoneCount,
			c=9 => le.IDAttributes.SocsCount,
			c=10 => le.IDAttributes.SocsVerLevel,
			c=11 => le.IDAttributes.DOBCount,
			c=12 => le.IDAttributes.DRLCCount,
			c=13 => le.IDAttributes.CmpyCount,
			c=14 => le.IDAttributes.VerFirst,
			c=15 => le.IDAttributes.VerLast,
			c=16 => le.IDAttributes.VerCmpy,
			c=17 => le.IDAttributes.VerAddr,
			c=18 => le.IDAttributes.VerCity,
			c=19 => le.IDAttributes.VerState,
			c=20 => le.IDAttributes.VerZIP,
			c=21 => le.IDAttributes.VerHPhone,
			c=22 => le.IDAttributes.VerSocs,
			c=23 => le.IDAttributes.VerDRLC,
			c=24 => le.IDAttributes.VerDOB,
			c=25 => le.IDAttributes.NumELever,
			c=26 => le.IDAttributes.NumSource,
			c=27 => le.IDAttributes.FirstScore,
			c=28 => le.IDAttributes.LastScore,
			c=29 => le.IDAttributes.CmpyScore,
			c=30 => le.IDAttributes.AddrScore,
			c=31 => le.IDAttributes.HPhoneScore,
			c=32 => le.IDAttributes.SocsScore,
			c=33 => le.IDAttributes.DOBScore,
			c=34 => le.IDAttributes.DRLCScore,
			c=35 => le.IDAttributes.WPhoneName,
			c=36 => le.IDAttributes.WPhoneAddr,
			c=37 => le.IDAttributes.WPhoneCity,
			c=38 => le.IDAttributes.WPhoneState,
			c=39 => le.IDAttributes.WPhoneZIP,
			c=40 => le.IDAttributes.SocsMiskeyFlag,
			c=41 => le.IDAttributes.HPhoneMiskeyFlag,
			c=42 => le.IDAttributes.AddrMiskeyFlag,
			c=43 => le.IDAttributes.IDTheftFlag,
			c=44 => le.IDAttributes.AptScanFlag,
			c=45 => le.IDAttributes.AddrHistoryFlag,
			c=46 => le.IDAttributes.COAAlertFlag,
			c=47 => le.IDAttributes.COAFirst,
			c=48 => le.IDAttributes.COALast,
			c=49 => le.IDAttributes.COAAddr,
			c=50 => le.IDAttributes.COACity,
			c=51 => le.IDAttributes.COAState,
			c=52 => le.IDAttributes.COAZip,
			c=53 => le.IDAttributes.WPhoneTypeFlag,
			c=54 => le.IDAttributes.WPhoneValFlag,
			c=55 => le.IDAttributes.HPhoneTypeFlag,
			c=56 => le.IDAttributes.HPhoneValFlag,
			c=57 => le.IDAttributes.PhoneZIPFlag,
			c=58 => le.IDAttributes.PhoneDissFlag,
			c=59 => le.IDAttributes.AddrValFlag,
			c=60 => le.IDAttributes.DwellTypeFlag,
			c=61 => le.IDAttributes.ZIPTypeFlag,
			c=62 => le.IDAttributes.SocsValFlag,
			c=63 => le.IDAttributes.DecsFlag,
			c=64 => le.IDAttributes.SocsDOBFlag,
			c=65 => le.IDAttributes.AreaCodeSplitFlag,	
			c=66 => le.IDAttributes.AreaCodeSplitDate,	
			c=67 => le.IDAttributes.AltAreaCode,
			c=68 => le.IDAttributes.BansFlag,
			c=69 => le.IDAttributes.DRLCValFlag,
			c=70 => le.IDAttributes.DRLCSoundX,
			c=71 => le.IDAttributes.DRLCFirst,
			c=72 => le.IDAttributes.DRLCLast,
			c=73 => le.IDAttributes.DRLCMiddle,
			c=74 => le.IDAttributes.DRLCSocs,
			c=75 => le.IDAttributes.DRLCDOB,
			c=76 => le.IDAttributes.DRLCGender,
			c=77 => le.IDAttributes.DistAddrPrevAddr,
			c=78 => le.IDAttributes.DistHPhoneWPhone,
			c=79 => le.IDAttributes.DistWPhoneAddr,
			c=80 => le.IDAttributes.StateZIPFlag,
			c=81 => le.IDAttributes.CityZIPFlag,
			c=82 => le.IDAttributes.HPhoneStateFlag,
			c=83 => le.IDAttributes.CheckAcctFlag,
			c=84 => le.IDAttributes.CassAddr,
			c=85 => le.IDAttributes.CassCity,
			c=86 => le.IDAttributes.CassState,
			c=87 => le.IDAttributes.CassZIP,
			c=88 => le.IDAttributes.AddrCommFlag,
			c=89 => le.IDAttributes.NonResName,
			c=90 => le.IDAttributes.NonResSic,
			c=91 => le.IDAttributes.NonResPhone,
			c=92 => le.IDAttributes.NonResAddr,
			c=93 => le.IDAttributes.NonResCity,
			c=94 => le.IDAttributes.NonResState,
			c=95 => le.IDAttributes.NonResZIP,
			c=96 => le.IDAttributes.NumFraud,
			c=97 => le.IDAttributes.Score2,
			c=98 => le.IDAttributes.TciAddrFlag,
			c=99 => le.IDAttributes.TciPrevAddrFlag,
			c=100 => le.IDAttributes.EstIncome,
			c=101 => le.IDAttributes.EmailDomainFlag,
			c=102 => le.IDAttributes.EmailUserFlag,
			c=103 => le.IDAttributes.EmailBrowserFlag,
			c=104 => le.IDAttributes.HRiskEmailDomainFlag,
			c=105 => le.IDAttributes.DistAddrDomain,
			'');
END;

name_pairs :=  normalize(pick_attr, 162, intoVersion1(left, counter));
v1 := project(name_pairs, transform(layout_attribute, self.attribute := left));

v2attributeCount := map( 
doAttributesVersion201 and SuppressCompromisedDLs => 226,
doAttributesVersion201 => 225,
												 217);
v2_name_pairs :=  normalize(pick_attr, v2attributeCount, intoVersion2(left, counter));
v2 := project(v2_name_pairs, transform(layout_attribute, self.attribute := left));
		
layout_AttributeGroup formAttributes(Models.Layout_FraudAttributes le) := TRANSFORM
	self.name := map( doAttributesVersion201 => 'Version201',
										doAttributesVersion2 => 'Version2',
										'Version1'
									);
	self.index := if(doAttributesVersion1 or doAttributesVersion2, '0', '');
	self.Attributes := if(doAttributesVersion2, ungroup(v2), ungroup(v1));
END;

name_pairs_IDAttributes := NORMALIZE(pick_attr, 105, intoIDAttributes(LEFT, COUNTER));
id_attr := PROJECT(name_pairs_IDAttributes, TRANSFORM(layout_attribute, self.attribute := LEFT));

Layout_AttributeGroup form_IDAttributes(Models.Layout_FraudAttributes le) := TRANSFORM
	self.name := 'IDAttributes';
	self.index := if(doIDAttributes, '0', '');
	self.Attributes := ungroup(id_attr);
END;

layout_FDAttributesOut formAttributeGroup(Models.Layout_FraudAttributes le) := transform
	self.accountnumber := if(doAttributesVersion1 or doAttributesVersion2 OR doIDAttributes, account_value, '');
	self.input.grade := Grade_Value;
	self.input.Channel := Channel;
	self.input.Income := Income;
	self.input.OwnOrRent := OwnOrRent;
	self.input.LocationIdentifier := LocationIdentifier;
	self.input.OtherApplicationIdentifier := OtherApplicationIdentifier;
	self.input.OtherApplicationIdentifier2 := OtherApplicationIdentifier2;
	self.input.OtherApplicationIdentifier3 := OtherApplicationIdentifier3;
	self.input.DateofApplication := DateofApplication;
	self.input.TimeofApplication := TimeofApplication;
	
	self.input := le.input;
	//populate the second input PII for FP3
	self.fname2  						:= fname2_value;
	self.mname2  						:= mname2_value;
	self.lname2  						:= lname2_value;
	self.suffix2 						:= suffix2_value;
	SELF.in_streetAddress2 	:= addr2_value;
	SELF.in_city2          	:= city2_value;
	SELF.in_state2         	:= state2_value;
	SELF.in_zipCode2       	:= zip2_value;
	SELF.phone102          	:= hphone2_value;
	
	self.AttributeGroup := IF(doAttributesVersion1 or doAttributesVersion2, project(le, formAttributes(left)),
																IF(doIDAttributes, PROJECT(le, form_IDAttributes(LEFT))));	
	self := [];
END;
attributeOut := project(pick_attr, formAttributeGroup(left));



// Get the models
ret := Models.FD3510_0_0(clam, ofacSearching, isFCRA, inCalif, fdReasonsWith38, nugen, addtl_watchlists);
ret2 := Models.FD5510_0_0(clam, ofacSearching, nugen, addtl_watchlists);
ret3 := Models.FD9510_0_0(clam, ofacSearching, nugen, addtl_watchlists);

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

clam_ip := join( clam, ipdata, left.seq=right.seq,
	transform( bs_with_ip,
		self.bs := left,
		self.ip := right
	),
	left outer
);

ret_custom := case( model_name,   //This set does not return risk indices
	'fp3710_0' => Models.FP3710_0_0( clam_ip, 6, false),
	'fp3710_9' => Models.FP3710_0_0( clam_ip, 6, true), // FP3710_9 is simply FP3710_0 with criminal risk codes returned
	'fp3904_1' => Models.FP3904_1_0( ungroup(clam) ),
	'fp3905_1' => Models.FP3905_1_0( ungroup(clam) ),
	'fd5609_2' => Models.FD5609_2_0( clam, true ),
	'ain801_1' => Models.AIN801_1_0(clam, true, Grade_Value),
	'fp31203_1' => Models.FP31203_1_0(clam_ip, Grade_Value),
	'fp31105_1' => Models.FP31105_1_0(clam_ip),
	'fp1303_1' => Models.FP1303_1_0( ungroup(clam), 6, false),
	'fp1310_1' => Models.FP1310_1_0( ungroup(clam), 6),
	'fp1401_1' => Models.FP1401_1_0( ungroup(clam), 6),
	'fp1404_1' => Models.FP1404_1_0( ungroup(clam), 6),
	'fp1407_1' => Models.FP1407_1_0( ungroup(clam), 6, cmSegmentValue),
	'fp1407_2' => Models.FP1407_2_0( ungroup(clam), 6, cmSegmentValue),
	'fp1406_1' => Models.FP1406_1_0( ungroup(clam), 6),
	'fp1403_2' => Models.FP1403_2_0( ungroup(clam), 6),
	'fp1409_2' => Models.FP1409_2_0( ungroup(clam_BtSt)),
	'fp1506_1' => Models.FP1506_1_0( ungroup(clam), 6),
	'fp1509_1' => Models.FP1509_1_0( ungroup(clam), 6),
	'fp1510_2' => Models.FP1510_2_0( ungroup(clam), 6),
	'fp1511_1' => Models.FP1511_1_0( ungroup(clam), 6),
	dataset( [], Models.Layout_ModelOut )
);

// because the layout returned from the fp1109 is different, these will need to be in their own case
model_fp1109_0   := Models.FP1109_0_0( clam_ip, 6, false);
model_fp1307_2   := Models.FP1307_2_0( clam_ip, 6, false);
model_fp1307_1   := Models.FP1307_1_0( ungroup(clam), 6);
model_fp31310_2  := Models.FP31310_2_0( ungroup(clam_ip), 6, cmRetailZipValue, cmLoadAmountValue);
model_fp1509_2   := Models.FP1509_2_0( ungroup(clam_BtSt), cmLoadAmountValue);
model_fp1512_1   := Models.FP1512_1_0( ungroup(clam), 6 );
model_fp31604_0  := Models.FP31604_0_0( ungroup(clam), 6 );

ret_fraudpoint2 := case( model_name,
	'fp1109_0' => model_fp1109_0, 
	'fp1109_9' => Models.FP1109_0_0( clam_ip, 6, true), // FP1109_9 is simply FP1109_0 with criminal risk codes returned
	'fp1307_2' => join(model_fp1109_0, model_fp1307_2, //fp1307_2 returns the indice info WITH the fp1109_0 score, etc.
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := right.StolenIdentityIndex,
												self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
												self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),
	'fp1307_1' => join(model_fp1307_1, model_fp1109_0, //fp1307_1 returns the indice from fp1109_0 score
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := right.StolenIdentityIndex,
												self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
												self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),	
	'fp31310_2' => join(model_fp31310_2, model_fp1109_0, //fp31310_2 returns the indice from fp1109_0 score
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := right.StolenIdentityIndex,
												self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
												self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),
	'fp1509_2' => join(model_fp1509_2, model_fp1109_0, //fp1509_2 returns the indices from fp1109_0 score
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := right.StolenIdentityIndex,
												self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
												self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),			
	'fp1512_1' => join(model_fp1512_1, model_fp1109_0, //fp1512_1 returns the indices from fp1109_0 score
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := right.StolenIdentityIndex,
												self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
												self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),
'fp31604_0' => join(model_fp31604_0, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
										left.seq = right.seq,
											transform(models.layouts.layout_fp1109, 
												self.StolenIdentityIndex := [],
												self.SyntheticIdentityIndex := [],
												self.ManipulatedIdentityIndex := [],
												self.VulnerableVictimIndex := right.VulnerableVictimIndex,
												self.FriendlyFraudIndex := right.FriendlyFraudIndex,
												self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
												self := left)),	
'fp1303_1' => join(ret_custom, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
									left.seq = right.seq,
										transform(models.layouts.layout_fp1109, 
											self.StolenIdentityIndex := right.StolenIdentityIndex,
											self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
											self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
											self.VulnerableVictimIndex := right.VulnerableVictimIndex,
											self.FriendlyFraudIndex := right.FriendlyFraudIndex,
											self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
											self := left)),	
											
'fp1404_1' => join(ret_custom, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
									left.seq = right.seq,
										transform(models.layouts.layout_fp1109, 
											self.StolenIdentityIndex := right.StolenIdentityIndex,
											self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
											self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
											self.VulnerableVictimIndex := right.VulnerableVictimIndex,
											self.FriendlyFraudIndex := right.FriendlyFraudIndex,
											self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
											self := left)),	

'fp1407_1' => join(ret_custom, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
									left.seq = right.seq,
										transform(models.layouts.layout_fp1109, 
											self.StolenIdentityIndex := right.StolenIdentityIndex,
											self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
											self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
											self.VulnerableVictimIndex := right.VulnerableVictimIndex,
											self.FriendlyFraudIndex := right.FriendlyFraudIndex,
											self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
											self := left)),	

'fp1407_2' => join(ret_custom, model_fp1109_0, //fp31604_0 returns the indices from fp1109_0 score
									left.seq = right.seq,
										transform(models.layouts.layout_fp1109, 
											self.StolenIdentityIndex := right.StolenIdentityIndex,
											self.SyntheticIdentityIndex := right.SyntheticIdentityIndex,
											self.ManipulatedIdentityIndex := right.ManipulatedIdentityIndex,
											self.VulnerableVictimIndex := right.VulnerableVictimIndex,
											self.FriendlyFraudIndex := right.FriendlyFraudIndex,
											self.SuspiciousActivityIndex := right.SuspiciousActivityIndex,
											self := left)),
													
	dataset( [], Models.Layouts.layout_fp1109 )
);


//fraudpoint 3
ret_fraudpoint3 := case( model_name,
	'fp31505_0' 		=> Models.FP31505_0_Base( clam_ip, 6, false), 
	'fp3fdn1505_0'	=> Models.FP3FDN1505_0_Base( clam_ip, 6, false), 
	'fp31505_9' 		=> Models.FP31505_0_Base( clam_ip, 6, true), //'_9' is the "criminal" version of the flagship model
	'fp3fdn1505_9'	=> Models.FP3FDN1505_0_Base( clam_ip, 6, true), //'_9' is the "criminal" version of the flagship model
	'fp1610_1' => Models.FP1610_1_0( ungroup(clam), 6),
	'fp1610_2' => Models.FP1610_2_0( ungroup(clam), 6),
	'fp1609_1' => Models.FP1609_1_0( ungroup(clam), 6),
	'fp1611_1' => Models.FP1611_1_0( ungroup(clam), 6),
	'fp1606_1' => Models.FP1606_1_0( ungroup(clam), 6),
	'fp1702_2' => Models.FP1702_2_0( ungroup(clam), 6),
	'fp1702_1' => Models.FP1702_1_0( ungroup(clam), 6),
	'fp1706_1' => Models.FP1706_1_0( ungroup(clam), 6),
	'fp1609_2' => Models.FP1609_2_0( ungroup(clam), 6),
	'fp1607_1' => Models.FP1607_1_0( ungroup(clam), 6),
  'fp1712_0' => Models.FP1712_0_0( ungroup(clam), 1), // Fraud flags model -- only one risk indicator is returned.
  'fp1508_1' => Models.FP1508_1_0( ungroup(clam), 6), 
  'fp1802_1' => Models.FP1802_1_0( ungroup(clam), 6), 
  'fp1705_1' => Models.FP1705_1_0( ungroup(clam), 6), 
  'fp1801_1' => Models.FP1801_1_0( ungroup(clam), 6),
  'fp1806_1' => Models.FP1806_1_0( ungroup(clam), 6),
	dataset( [], Models.Layouts.layout_fp1109 )
);

fp_test_seed := Risk_Indicators.FraudPoint_TestSeed_Function(test_prep, Test_Data_Table_Name);

models.Layout_Reason_Codes form_rc(Models.Layout_ModelOut le) :=
TRANSFORM
	SELF.reason_code := IF(~isWFS34, if(le.ri[1].hri <> '00', le.ri[1].hri, ''), IF(Risk_Indicators.rcSet.isCode36(le.ri[1].hri), '36', le.ri[1].hri));
	SELF.reason_description := IF(~isWFS34, le.ri[1].desc, IF(Risk_Indicators.rcSet.isCode36(le.ri[1].hri), Risk_Indicators.getHRIDesc('36'), le.ri[1].desc));
end;
models.Layout_Reason_Codes form_rc2(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[2].hri <> '00', le.ri[2].hri, '');
	SELF.reason_description := le.ri[2].desc;
end;
models.Layout_Reason_Codes form_rc3(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[3].hri <> '00', le.ri[3].hri, '');
	SELF.reason_description := le.ri[3].desc;
end;
models.Layout_Reason_Codes form_rc4(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[4].hri <> '00', le.ri[4].hri, '');
	SELF.reason_description := le.ri[4].desc;
end;
models.Layout_Reason_Codes form_rc5(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[5].hri <> '00', le.ri[5].hri, '');
	SELF.reason_description := le.ri[5].desc;
end;
models.Layout_Reason_Codes form_rc6(ret le) :=
TRANSFORM
	SELF.reason_code := if(le.ri[6].hri <> '00', le.ri[6].hri, '');
	SELF.reason_description := le.ri[6].desc;
end;



Models.Layouts.Layout_Score_FP form_cscore(ret le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := if(model_name='fd5609_2', '10 to 50', '0 to 999');
	reason_codes_temp :=
		PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT))
		+ if( model_name in ['fp3710_0', 'fp3904_1', 'fp3905_1', 'fp3710_9', 'fp31203_1', 'fp31105_1', 'fp1310_1', 'fp1401_1', 'fp31310_2', 'fp1404_1',
		                     'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1403_2', 'fp1506_1', 'fp1509_2','fp1509_1',
												 'fp1510_2','fp1511_1', 'fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1606_1','fp1702_2',
												 'fp1702_1','fp1706_1','fp1609_2','fp1607_1','fp1802_1','fp1705_1','fp1801_1', 'fp1806_1'], 
		PROJECT(le,form_rc5(LEFT)) + PROJECT(le,form_rc6(LEFT)) );
	risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self.index := case( model_name,
		'fp3710_0' => risk_indicators.BillingIndex.FP3710_0,
		'fp3710_9' => risk_indicators.BillingIndex.FP3710_9,
		'fp3904_1' => risk_indicators.BillingIndex.FP3904_1,
		'fp3905_1' => risk_indicators.BillingIndex.FP3905_1,
		'fd5609_2' => risk_indicators.BillingIndex.FD5609_2,
		'ain801_1' => Risk_Indicators.BillingIndex.AIN801_1,
		'fp31203_1' => Risk_Indicators.BillingIndex.FP31203_1,
		'fp31105_1' => Risk_Indicators.BillingIndex.FP31105_1,
		'fp1303_1' => Risk_Indicators.BillingIndex.FP1303_1,
		'fp1310_1' => Risk_Indicators.BillingIndex.FP1310_1,
		'fp1401_1' => Risk_Indicators.BillingIndex.FP1401_1,
		'fp1404_1' => Risk_Indicators.BillingIndex.FP1404_1,
		'fp1407_1' => Risk_Indicators.BillingIndex.FP1407_1,
		'fp1407_2' => Risk_Indicators.BillingIndex.FP1407_2,
		'fp1406_1' => Risk_Indicators.BillingIndex.FP1406_1,
		'fp1403_2' => Risk_Indicators.BillingIndex.FP1403_2,
		'fp1409_2' => Risk_Indicators.BillingIndex.FP1409_2,
		'fp1506_1' => Risk_Indicators.BillingIndex.FP1506_1,
		'fp1509_1' => Risk_Indicators.BillingIndex.FP1509_1,
		'fp1510_2' => Risk_Indicators.BillingIndex.FP1510_2,
		'fp1511_1' => Risk_Indicators.BillingIndex.FP1511_1,
		''
	);
	self := [];
end;

Models.Layouts.Layout_Score_FP form_fp2score(ret_fraudpoint2 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '0 to 999';
	// get the le into layout_modelout to re-use the form_rc function
	le_temp := project(le, transform(Models.Layout_ModelOut, self := left));
	reason_codes_temp := PROJECT(le_temp,form_rc(LEFT)) + PROJECT(le_temp,form_rc2(LEFT)) + PROJECT(le_temp,form_rc3(LEFT)) + PROJECT(le_temp,form_rc4(LEFT)) + PROJECT(le_temp,form_rc5(LEFT)) + PROJECT(le_temp,form_rc6(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self.index := case( model_name,
		'fp1109_0' => risk_indicators.BillingIndex.FP1109_0,
		'fp1109_9' => risk_indicators.BillingIndex.FP1109_9,
		'fp1307_2' => Risk_Indicators.BillingIndex.FP1307_2,
		'fp1307_1' => Risk_Indicators.BillingIndex.FP1307_1,
		'fp31310_2' => Risk_Indicators.BillingIndex.FP31310_2,
		'fp1509_2' => Risk_Indicators.BillingIndex.FP1509_2,
		'fp1512_1' => Risk_Indicators.BillingIndex.FP1512_1,
		'fp31604_0' => Risk_Indicators.BillingIndex.FP31604_0,
		''
	);

	IncludeRiskIndicesFinal := if( model_name in ['fp31310_2', 'fp1509_2', 'fp1512_1', 'fp31604_0', 'fp1303_1',
		'fp1404_1','fp1407_1','fp1407_2'], true, IncludeRiskIndices);
	
	self.StolenIdentityIndex        := if(IncludeRiskIndicesFinal, le.StolenIdentityIndex, '');
	self.SyntheticIdentityIndex     := if(IncludeRiskIndicesFinal, le.SyntheticIdentityIndex, '');
	self.ManipulatedIdentityIndex   := if(IncludeRiskIndicesFinal, le.ManipulatedIdentityIndex, '');
	self.VulnerableVictimIndex      := if(IncludeRiskIndicesFinal, le.VulnerableVictimIndex, '');
	self.FriendlyFraudIndex         := if(IncludeRiskIndicesFinal, le.FriendlyFraudIndex, '');
	self.SuspiciousActivityIndex    := if(IncludeRiskIndicesFinal, le.SuspiciousActivityIndex, '');
end;
	
Models.Layouts.Layout_Score_FP form_cscore2(ret2 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 50';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self := [];
END;
Models.Layouts.Layout_Score_FP form_cscore3(ret3 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 90';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self := [];
END;

testrec := record
	unsigned seq;
	Models.layouts.FP_Layout_Model;
end;

testrec form_model(ret le, ret2 ri) := 
TRANSFORM
	self.seq := le.seq;
	self.accountnumber := account_value;
	self.description := 'FraudDefender';
	self.scores := PROJECT(le,form_cscore(LEFT)) + PROJECT(ri,form_cscore2(LEFT));
	self := [];
END;
final := join(ret,ret2,left.seq=right.seq, form_model(LEFT,RIGHT));


Models.layouts.FP_Layout_Model form_fraudpoint2_model(ret_fraudpoint2 le) := 
TRANSFORM
	self.accountnumber := account_value;
	self.description := map(model_name = 'fp1509_2'		=> 'FraudPointFP1509_2',
													model_name = 'fp1512_1'		=> 'FraudPointFP1512_1',
													model_name = 'fp31604_0'	=> 'FraudPointFP31604_0',
																											 'FraudPoint');	
	self.scores := project(le, form_fp2score(left));

END;
fraudpoint2_model := if(input_ok, 
	project(if(test_data_enabled, fp_test_seed, ret_fraudpoint2), form_fraudpoint2_model(LEFT)), 
//	project( ret_fraudpoint2, form_fraudpoint2_model(LEFT)), 
	dataset([], models.layouts.FP_layout_model) );

//new for FraudPoint 3.0
Models.Layouts.Layout_Score_FP form_fp3score(ret_fraudpoint3 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '0 to 999';
	// get the le into layout_modelout to re-use the form_rc function
	le_temp := project(le, transform(Models.Layout_ModelOut, self := left));
	reason_codes_temp := PROJECT(le_temp,form_rc(LEFT)) + PROJECT(le_temp,form_rc2(LEFT)) + PROJECT(le_temp,form_rc3(LEFT)) + PROJECT(le_temp,form_rc4(LEFT)) + PROJECT(le_temp,form_rc5(LEFT)) + PROJECT(le_temp,form_rc6(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self.index := case( model_name,
		'fp31505_0' 	 => risk_indicators.BillingIndex.FP31505_0,
		'fp3fdn1505_0' => risk_indicators.BillingIndex.FP3FDN1505_0,
		'fp31505_9' 	 => risk_indicators.BillingIndex.FP31505_9,
		'fp3fdn1505_9' => risk_indicators.BillingIndex.FP3FDN1505_9,
		'fp1610_1' => Risk_Indicators.BillingIndex.FP1610_1,
		'fp1610_2' => Risk_Indicators.BillingIndex.FP1610_2,
		'fp1609_1' => Risk_Indicators.BillingIndex.FP1609_1,
		'fp1611_1' => Risk_Indicators.BillingIndex.FP1611_1,
		'fp1606_1' => Risk_Indicators.BillingIndex.FP1606_1,
		'fp1702_2' => Risk_Indicators.BillingIndex.FP1702_2,
		'fp1702_1' => Risk_Indicators.BillingIndex.FP1702_1,
		'fp1706_1' => Risk_Indicators.BillingIndex.FP1706_1,
		'fp1609_2' => Risk_Indicators.BillingIndex.FP1609_2,
		'fp1607_1' => Risk_Indicators.BillingIndex.FP1607_1,
		'fp1712_0' => Risk_Indicators.BillingIndex.FP1712_0,
		'fp1508_1' => Risk_Indicators.BillingIndex.FP1508_1,
		'fp1802_1' => Risk_Indicators.BillingIndex.FP1802_1,
    'fp1705_1' => Risk_Indicators.BillingIndex.FP1705_1,
    'fp1801_1' => Risk_Indicators.BillingIndex.FP1801_1,
    'fp1806_1' => Risk_Indicators.BillingIndex.FP1806_1, 
		''
	);

	IncludeRiskIndicesFinal := if( model_name in ['fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1609_2','fp1607_1','fp1508_1',
                                                'fp1802_1','fp1705_1','fp1801_1','fp1806_1'], true, IncludeRiskIndices);	

	self.StolenIdentityIndex        := if(IncludeRiskIndicesFinal, le.StolenIdentityIndex, '');
	self.SyntheticIdentityIndex     := if(IncludeRiskIndicesFinal, le.SyntheticIdentityIndex, '');
	self.ManipulatedIdentityIndex   := if(IncludeRiskIndicesFinal, le.ManipulatedIdentityIndex, '');
	self.VulnerableVictimIndex      := if(IncludeRiskIndicesFinal, le.VulnerableVictimIndex, '');
	self.FriendlyFraudIndex         := if(IncludeRiskIndicesFinal, le.FriendlyFraudIndex, '');
	self.SuspiciousActivityIndex    := if(IncludeRiskIndicesFinal, le.SuspiciousActivityIndex, ''); 
end;

Models.layouts.FP_Layout_Model form_fraudpoint3_model(ret_fraudpoint3 le) := 
TRANSFORM
	self.accountnumber := account_value;
	self.description := map(model_name = 'fp31505_0'		=> 'FraudPointFP31505_0',
													model_name = 'fp3fdn1505_0'	=> 'FraudPointFP3FDN1505_0',
													model_name = 'fp31505_9'		=> 'FraudPointFP31505_9',
													model_name = 'fp3fdn1505_9'	=> 'FraudPointFP3FDN1505_9',
													model_name = 'fp1610_1'	=> 'FraudPointFP1610_1',
													model_name = 'fp1610_2'	=> 'FraudPointFP1610_2',
													model_name = 'fp1609_1'	=> 'FraudPointFP1609_1',
													model_name = 'fp1611_1'	=> 'FraudPointFP1611_1',
													model_name = 'fp1606_1'	=> 'FraudPointFP1606_1',
													model_name = 'fp1702_2'	=> 'FraudPointFP1702_2',
													model_name = 'fp1702_1'	=> 'FraudPointFP1702_1',
													model_name = 'fp1706_1'	=> 'FraudPointFP1706_1',
													model_name = 'fp1609_2'	=> 'FraudPointFP1609_2',
													model_name = 'fp1607_1'	=> 'FraudPointFP1607_1',
													model_name = 'fp1712_0'	=> 'FraudPointFP1712_0',
													model_name = 'fp1508_1'	=> 'FraudPointFP1508_1',
													model_name = 'fp1802_1'	=> 'FraudPointFP1802_1',
                          model_name = 'fp1705_1'	=> 'FraudPointFP1705_1',
                          model_name = 'fp1801_1'	=> 'FraudPointFP1801_1',
                          model_name = 'fp1806_1'	=> 'FraudPointFP1806_1',
                          																	 'FraudPoint');	

	self.scores := project(le, form_fp3score(left));

END;
fraudpoint3_model := if(input_ok, 
	project(if(test_data_enabled, fp_test_seed, ret_fraudpoint3), form_fraudpoint3_model(LEFT)), 
//	project(ret_fraudpoint3, form_fraudpoint3_model(LEFT)), 
	dataset([], models.layouts.FP_layout_model) );

//end FP 3.0 code

Models.layouts.FP_Layout_Model form_model2(final le, ret3 ri) := 
TRANSFORM
	self.accountnumber := account_value;
	self.description := le.description;
	self.scores := le.scores + PROJECT(ri,form_cscore3(LEFT));
	self := [];
END;
final2 := join(final,ret3,left.seq=right.seq, form_model2(LEFT,RIGHT));

// Get the seed data for Fraud Defender V.1
fd_seeds := seed_files.GetFraudDefender(test_prep, account_value, Test_Data_Table_Name);


final_v1 := if(Test_Data_Enabled, fd_seeds, final2);
//final_v1 := final2;

//=============================================
//===  custom model descriptions            ===
//=============================================
Models.layouts.FP_Layout_Model form_custom_model( ret_custom le ) := TRANSFORM
	self.accountnumber := account_value;
	self.description := map(isWFS34									=> 'AIN801_1', 
													model_name = 'fp1506_1'	=> 'FraudPointFP1506_1',
													model_name = 'fp1509_1'	=> 'FraudPointFP1509_1',
													model_name = 'fp1510_2'	=> 'FraudPointFP1510_2',
													model_name = 'fp1511_1'	=> 'FraudPointFP1511_1',
																										 'FraudPoint');
	self.scores := project( le, form_cscore(left) );
	self := []; // 6 indices will be blank on all models except 2.0  (fp1109)
end;
fp1_test_seed := project(fp_test_seed, transform(Models.Layout_ModelOut, self := left));
custom := project( if(Test_Data_Enabled, fp1_test_seed, ret_custom),form_custom_model(left) );
//custom := project(ret_custom,form_custom_model(left) );
// this custom fraud model was put into place in 2007 in it's own service.
// to get rid of that service on roxie, we're putting that model in this service.
ret_idn6051 := Models.IDN605_1_0(clam, true );

Models.Layouts.Layout_Score_FP form_idnscore(ret3 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 90';
	self := []; // difference between this transform and cscore3 is that idn model doesn't return reason codes
END;

custom_idn6051 := project(ret_idn6051, 
				transform(Models.layouts.FP_Layout_Model,
									self.accountnumber := account_value;
									self.description := 'FraudAdvisorIDN6051';
									self.scores := project(left, form_idnscore(left) );
									self := [];
									));


finalcustom := map( model_name in fraudpoint3_models => fraudpoint3_model,
model_name in fraudpoint3_custom_models => fraudpoint3_model,
model_name in fraudpoint2_models => fraudpoint2_model,
model_name = 'idn6051' => custom_idn6051,
model_name in custom_models OR model_name = 'ain801_1' => custom, 
final_v1 ); 
										
// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs'
// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(intermediate_Log, NAMED('LOG_log__mbs_intermediate__log')) );

// pick either 3 defaults or attribute model
scores := if((~doAttributesVersion1 AND ~doIDAttributes) or model_name in custom_models OR isWFS34, finalcustom, dataset([],Models.layouts.FP_Layout_Model));
OUTPUT(scores,NAMED('Results')); // We only want to output this when wfs3/4 is not being requested

red_flags := if(Test_Data_Enabled, seed_files.GetRedFlags(test_prep, Test_Data_Table_Name), risk_indicators.Red_Flags_Function(iid));

// trigger red flags by setting redflag_version to something other than 0
attributes_w_redflags := if(redflag_version > 0, join(attributeout, red_flags, left.input.seq=right.seq, 
											transform(layout_FDAttributesOut,
																self.Red_Flags := right, self := left)), 
																attributeout);
OUTPUT(attributes_w_redflags, NAMED('Results2'));  

//Only get royalties for hitting the Insurance DL information if they are allowed to access the information
insurance := If(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetWebRoyalties(UNGROUP(iid), did, insurance_dl_used, true));

royalties := IF(~Test_Data_Enabled, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, ip_prep, ipdata) + insurance);
output(royalties,NAMED('RoyaltySet'));

// always give us back just 1 record, and sort the results by descending account number to keep the result with account number populated
joined_results := choosen(sort(join(scores, attributes_w_redflags, left.accountnumber = right.accountnumber, full outer), -accountnumber), 1);


	
  QA_dataset := PROJECT(Clam, TRANSFORM(Models.Layout_Fraudpoint_Debug,
    SELF.shell.account := account_value;
    SELF.shell.shell_version := bsversion;
    SELF.shell.did := LEFT.did;
    SELF.shell.TrueDID := LEFT.TrueDID;
    SELF.shell.adl_category := LEFT.adlcategory;
    SELF.shell.LexID_score := LEFT.Name_Verification.adl_score;
    SELF.shell.fnamepop := LEFT.input_validation.firstname;
    SELF.shell.lnamepop := LEFT.input_validation.lastname;
    SELF.shell.addrpop := LEFT.input_validation.address;
    SELF.shell.hphnpop := LEFT.input_validation.homephone;
    SELF.shell.ssnlength := LEFT.input_validation.ssn_length;
    SELF.shell.dobpop := LEFT.input_validation.dateofbirth;
    SELF.shell.emailpop := LEFT.input_validation.email;
    SELF.shell.DLpop := TRIM(drlc_value) <> '' AND TRIM(drlcstate_value) <> '';
    SELF.shell.ipaddrpop := LEFT.input_validation.ipaddress;
    SELF.shell.ver_sources := LEFT.header_summary.ver_sources;
    SELF.shell.ver_sources_nas := LEFT.header_summary.ver_sources_nas;
    SELF.shell.ver_sources_first_seen := LEFT.header_summary.ver_sources_first_seen_date;
    SELF.shell.ver_sources_last_seen := LEFT.header_summary.ver_sources_last_seen_date;
    SELF.shell.ver_sources_count := LEFT.header_summary.ver_sources_recordcount;
    SELF.shell.ver_fname_sources := LEFT.header_summary.ver_fname_sources;
    SELF.shell.ver_fname_sources_first_seen := LEFT.header_summary.ver_fname_sources_first_seen_date;
    SELF.shell.ver_fname_sources_count := LEFT.header_summary.ver_fname_sources_recordcount;
    SELF.shell.ver_lname_sources := LEFT.header_summary.ver_lname_sources;
    SELF.shell.ver_lname_sources_first_seen := LEFT.header_summary.ver_lname_sources_first_seen_date;
    SELF.shell.ver_lname_sources_count := LEFT.header_summary.ver_lname_sources_recordcount;
    SELF.shell.ver_addr_sources := LEFT.header_summary.ver_addr_sources;
    SELF.shell.ver_addr_sources_first_seen := LEFT.header_summary.ver_addr_sources_first_seen_date;
    SELF.shell.ver_addr_sources_count := LEFT.header_summary.ver_addr_sources_recordcount;
    SELF.shell.ver_ssn_sources := LEFT.header_summary.ver_ssn_sources;
    SELF.shell.ver_ssn_sources_first_seen := LEFT.header_summary.ver_ssn_sources_first_seen_date;
    SELF.shell.ver_ssn_sources_count := LEFT.header_summary.ver_ssn_sources_recordcount;
    SELF.shell.ver_dob_sources := LEFT.header_summary.ver_dob_sources;
    SELF.shell.ver_dob_sources_first_seen := LEFT.header_summary.ver_dob_sources_first_seen_date;
    SELF.shell.ver_dob_sources_count := LEFT.header_summary.ver_dob_sources_recordcount;
    SELF.shell.age := LEFT.name_verification.age;
    SELF.shell.add_input_isbestmatch := LEFT.address_verification.input_address_information.isbestmatch;
    SELF.shell.add_input_pop := LEFT.addrPop;
    SELF.shell.add_curr_isbestmatch := LEFT.address_verification.address_history_1.isbestmatch;
    SELF.shell.add_curr_pop := LEFT.addrPop2;
    SELF.shell.add_prev_isbestmatch := LEFT.address_verification.address_history_2.isbestmatch;
    SELF.shell.add_prev_pop := LEFT.addrPop3;
    SELF.shell.header_build_date := LEFT.header_summary.header_build_date;
    SELF.shell.historydatetimestamp := LEFT.historydatetimestamp;    
    ));
    
IF(IncludeQAOutputs, OUTPUT(QA_dataset, NAMED('QA_dataset')));

//Log to Deltabase
Deltabase_Logging_prep :=  project(joined_results, TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																					 self.company_id := (Integer)CompanyID,
																					 self.login_id := _LoginID,
																					 self.product_id := Risk_Reporting.ProductID.Models__FraudAdvisor_Service,
																					 self.function_name := FunctionName,
																					 self.esp_method := ESPMethod,
																					 self.interface_version := InterfaceVersion,
																					 self.delivery_method := DeliveryMethod,
																					 self.date_added := (STRING8)Std.Date.Today(),
																					 self.death_master_purpose := DeathMasterPurpose,
																					 self.ssn_mask := ssnmask,
																					 self.dob_mask := dobmask,
																					 self.dl_mask := dlmask,
																					 self.exclude_dmv_pii := ExcludeDMVPII,
																					 self.scout_opt_out := (String)(Integer)DisableOutcomeTracking,
																					 self.archive_opt_in := ArchiveOptIn,
                                           self.glb := GLB_Purpose,
                                           self.dppa := DPPA_Purpose,
																					 self.data_restriction_mask := DataRestriction,
																					 self.data_permission_mask := DataPermission,
																					 self.industry := Industry_Search[1].Industry,
																					 self.i_attributes_name := attributesIn[1].name,
																					 self.i_ssn := socs_value,
                                           self.i_dob := dob_value,
                                           self.i_name_full := unparsed_fullname_value,
																					 self.i_name_first := first_value,
																					 self.i_name_last := last_value,
																					 self.i_lexid := did_value, 
																					 self.i_address := addr_value,
																					 self.i_city := city_value,
																					 self.i_state := state_value,
																					 self.i_zip := zip_value,
																					 self.i_dl := drlc_value,
																					 self.i_dl_state := drlcstate_value,
                                           self.i_home_phone := hphone_value,
                                           self.i_work_phone := wphone_value,
																					 self.i_name_first_2 := pre_fname_val2,
																					 self.i_name_last_2 := pre_lname_val2,
																					 self.i_model_name_1 := model_name,
																					 self.i_model_name_2 := '',
																					 self.o_score_1    := (Integer)left.Scores[1].i,
																					 self.o_reason_1_1 := left.Scores[1].Reason_Codes[1].Reason_Code,
																					 self.o_reason_1_2 := left.Scores[1].Reason_Codes[2].Reason_Code,
																					 self.o_reason_1_3 := left.Scores[1].Reason_Codes[3].Reason_Code,
																					 self.o_reason_1_4 := left.Scores[1].Reason_Codes[4].Reason_Code,
																					 self.o_reason_1_5 := left.Scores[1].Reason_Codes[5].Reason_Code,
																					 self.o_reason_1_6 := left.Scores[1].Reason_Codes[6].Reason_Code,
																					 self.o_score_2    := (Integer)left.Scores[2].i,
																					 self.o_reason_2_1 := left.Scores[2].Reason_Codes[1].Reason_Code,
																					 self.o_reason_2_2 := left.Scores[2].Reason_Codes[2].Reason_Code,
																					 self.o_reason_2_3 := left.Scores[2].Reason_Codes[3].Reason_Code,
																					 self.o_reason_2_4 := left.Scores[2].Reason_Codes[4].Reason_Code,
																					 self.o_reason_2_5 := left.Scores[2].Reason_Codes[5].Reason_Code,
																					 self.o_reason_2_6 := left.Scores[2].Reason_Codes[6].Reason_Code,
																					 self.o_lexid      := attributes_w_redflags[1].input.did,
																					 self := left,
																					 self := [] ));
																					 
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));
 
//===========================================================
//==== end of commented code for debug/validation mode ======
//===========================================================

//======================================================
//==== for debug only - uncomment the call to the    ===
//===  model                                         ===
//======================================================
// ret_custom := Models.FP31604_0_0( ungroup(clam), 6);
// OUTPUT(ret_custom, NAMED('Results'));
// output( iid, NAMED('IID__out'));
// output(doAttributesVersion2, named('doAttributesVersion2'));
// output(v2, named('v2'));
// OUTPUT( clam_BtSt, NAMED('clam_BtSt') );
//============end of debug===========================


ENDMACRO;

// Models.FraudAdvisor_Service();

/*
====================================
======  Sample ModelRequest  =======
====================================
<ModelRequests>
  <Row>
    <ModelName>CustomFA_Service</ModelName>
    <ModelOptions>
      <Row>
        <OptionName>Custom</OptionName>
        <OptionValue>AIN801_1</OptionValue>
      </Row>
      <Row>
        <OptionName>Grade</OptionName>
        <OptionValue></OptionValue>
      </Row>
    </ModelOptions>
  </Row>
</ModelRequests>

====================================
===== Sample AttributeRequest ======
====================================
<RequestedAttributeGroup>
  <Row>
    <Name>IDAttributes</Name>
  </Row>
</RequestedAttributeGroup>
*/
