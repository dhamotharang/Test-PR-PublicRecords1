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
  <part name="UseIngestDate" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Contains Fraud Advisor 3, 5, 9, Version1 and Fraud Attributes */

import Address, Risk_Indicators, Riskwise, ut, seed_files, doxie, Risk_Reporting, Inquiry_AccLogs, STD, Models, Gateway, Easi;

export FraudAdvisor_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('SSNMask', '');

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
        'IncludeQAOutputs',
        'LexIdSourceOptout',
        '_TransactionId',
        '_BatchUID',
        '_GCID',
        '_CompanyID',
        '_LoginID',
				'UseIngestDate',
        'IDA_gateway_mode'

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
cleaned_name2 := STD.STR.ToUpperCase(address.CleanPerson73(unparsed_fullname_value2));
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
boolean   inIsUtility := Doxie.Compliance.isUtilityRestricted(STD.Str.ToUpperCase(industry_class_val));
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
boolean   Test_Data_Enabled := false  	: stored('TestDataEnabled');
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


string20  Model                := ''    : stored('Model');
boolean   IncludeRiskIndices   := false : stored('IncludeRiskIndices');  // to include the 6 fraud indices that come back in fp1109_0
boolean SuppressCompromisedDLs := false : stored('SuppressCompromisedDLs');
// Set to TRUE when running RiskProcessing scripts to include some intermediate boca shell outputs for modelers
boolean IncludeQAOutputs := FALSE : stored('IncludeQAOutputs'); 
boolean UseIngestDate    := FALSE : stored('UseIngestDate'); 

//IDA gateway modes 
// 0 = production mode
// 1 = UAT mode
// 2 = Retro mode
unsigned1 IDA_gateway_mode := 0 : stored('IDA_gateway_mode');

Boolean TrackInsuranceRoyalties := Risk_Indicators.iid_constants.InsuranceDL_ok(DataPermission);

// integer   FraudVersion_in := 1 : stored('ModelVersion');
// fraudversion_check := max( 1, fraudversion_in ); // don't allow versions <=0

dobradius := if(usedobFilter,dobradius0,-1);
//model_url := dataset([],Models.Layout_Score_Chooser) 				: stored('scores',few);
ModelOptions_In := DATASET([], Models.Layouts.Layout_Model_Request_In)	: STORED('ModelRequests',few);
attributesIn := dataset([],Models.Layouts.Layout_Attributes_In)						: stored('RequestedAttributeGroups',few);
gateways_in := Gateway.Configuration.Get();

//IF Model field is used, then we expect only 1 model. So project it into the ModelRequests format so we can use it in the validation/execution parts.
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

//IF Model field is used, then we expect only 1 model. So project it into the ModelRequests format so we can use it in the validation/execution parts.
single_model := Dataset([Transform(Models.Layouts.Layout_Model_Request_In,
                                   Self.ModelName := 'customfa_service',
                                   Self.ModelOptions := Dataset([Transform(Models.Layouts.Layout_Model_Options,
                                                                 Self.OptionName := 'custom',
                                                                 Self.OptionValue := Model
                                                                )])
                       )]);

//For FraudPoint 3.0, a second input name and address was added so they could then be avalable for custom models. It was also
//required that this info be passed in from InstantID and FlexID in the 'Scores' data set, which actually ends up in this 'ModelRequests'
//section. There are no changes needed to handle these second input fields until a model is developed which actually needs them. If
//and when a custom model does need them, code will be needed in the Models.FP_models.Execute_model function to look for these fields and
//pass them to the new model. It will be somewhat confusing as when the new model is requested via FraudAdvisor_Service, these second
//identity fields are available as regular input fields, but if the new model is requested via InstantID or FlexID, the fields will be
//available only through this custom model request.  

mod_access := MODULE(Doxie.IDataAccess)
	EXPORT glb := GLB_Purpose;
	EXPORT dppa := DPPA_Purpose;
	EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
	EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
	EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
END;

//If this model request limit changes, update the model_check and custom_field_replacement functions as well
Model_requests := choosen(ModelOptions_In, 3);

Models_to_use := IF(Model != '', single_model, Model_requests);

Valid_requested_models := project(Models_to_use, Transform(Models.Layouts.Layout_Model_Request_In,
                                       self := Models.FP_models.Valid_request(left, attributesIn, ip_value, includeriskindices, RedFlag_version, glb_ok)));

//Check minimum input for Digital Insights model
IF((Models.FP_models.Model_Check(Valid_requested_models, ['di31906_0']))
    and (email_value = '' or hphone_value = ''),
    FAIL('Invalid request for Digital Insights, must supply a phone number and email.'));

isWFS34 := Models.FP_models.Model_Check(Valid_requested_models, ['ain801_1']);

//Grab the first 2 actual model names for scout logging later
// Model_name_1 is also used for old Frauddefender models and Paro models that were left in the service instead of being moved to the new execute model function
model_name_1 := STD.STR.ToLowerCase(TRIM(Valid_requested_models[1].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));
model_name_2 := STD.STR.ToLowerCase(TRIM(Valid_requested_models[2].ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom')[1].OptionValue));

r1 := record
	unsigned4 seq;
end;

d := dataset([{(unsigned)account_value}],r1);

risk_indicators.layout_input into(d l) := transform
	
	street_address := risk_indicators.MOD_AddressClean.street_address(addr_value);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_value, state_value, zip_value ) ;		
	
	dob_val := riskwise.cleandob(dob_value);
	dl_num_clean := riskwise.cleanDL_num(drlc_value);
	
	self.seq := l.seq;
	self.DID := did_value;//IF(model_name='fp31604_0', (unsigned)cmLexIDValue, did_value);
	self.score := if(self.did<>0, 100, 0);
	self.ssn := IF(socs_value='000000000','',socs_value);	// blank out social if it is all 0's
	self.dob := dob_val;
	self.age := if (age_value = 0 and (integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), (string3)age_value);
	self.phone10 := hphone_value;
	self.wphone10 := wphone_value;
	
	self.fname := STD.STR.ToUpperCase(first_value);
	self.mname := STD.STR.ToUpperCase(middle_value);
	self.lname := STD.STR.ToUpperCase(last_value);
	self.suffix := STD.STR.ToUpperCase(suffix_value);
	
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
	
	SELF.dl_number := STD.STR.ToUpperCase(dl_num_clean);
	SELF.dl_state := STD.STR.ToUpperCase(drlcstate_value);
	
	SELF.email_address := email_value;
	SELF.ip_address := ip_value;
	
	SELF.employer_name := STD.STR.ToUpperCase(cmpy_value);
	SELF.lname_prev := STD.STR.ToUpperCase(formerlast_value);
	SELF.historydate := IF(historyDateTimeStamp <> '', (UNSIGNED)historyDateTimeStamp[1..6], history_date);
	SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
end;
prep_temp := PROJECT(d,into(LEFT));

//replace did value with custom parameter for fp31604_0 if requested
prep := Models.FP_models.custom_field_replacement(prep_temp, Valid_requested_models, 'fp31604_0', 'DID', 'lexid', 'unsigned');

risk_indicators.layout_input into2 := TRANSFORM
	self.seq    := (unsigned)account_value;
	// Allow for one person / two addresses if second person name data is blank.
	self.fname  := IF( fname2_value  != '', STD.STR.ToUpperCase(fname2_value) , STD.STR.ToUpperCase(first_value) );
	self.mname  := IF( mname2_value  != '', STD.STR.ToUpperCase(mname2_value) , STD.STR.ToUpperCase(middle_value) );
	self.lname  := IF( lname2_value  != '', STD.STR.ToUpperCase(lname2_value) , STD.STR.ToUpperCase(last_value) );
	self.suffix := IF( suffix2_value != '', STD.STR.ToUpperCase(suffix2_value), STD.STR.ToUpperCase(suffix_value) );
	
	// for greendot custom, we need to send just the custom input retailZipcode through the address cleaner to get it's lat and long
	SELF.in_streetAddress := if(Models.FP_models.Model_Check(Valid_requested_models, ['fp1509_2']), 'fp1509', STD.STR.ToUpperCase(addr2_value));
	SELF.in_city          := if(Models.FP_models.Model_Check(Valid_requested_models, ['fp1509_2']), '', STD.STR.ToUpperCase(city2_value));
	SELF.in_state         := if(Models.FP_models.Model_Check(Valid_requested_models, ['fp1509_2']), '', STD.STR.ToUpperCase(state2_value));
	SELF.in_zipCode       := zip2_value;//if(model_name='fp1509_2', cmRetailZipValue, zip2_value);
	SELF.phone10          := hphone2_value;	
	SELF.historydate := IF(historyDateTimeStamp <> '', (UNSIGNED)historyDateTimeStamp[1..6], history_date);
	SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
	SELF := [];
END;

prep2_temp := DATASET([into2]);

//replace in_zipCode value with custom parameter for fp1509_2 if requested
prep2 := Models.FP_models.custom_field_replacement(prep2_temp, Valid_requested_models, 'fp1509_2', 'in_zipCode', 'retailzip', 'String');

////////////////////////////////////////////////////////////////////////////////////////
//  BEGIN: New minimum input criteria for Fraud Intel models (i.e. IDA combo models)  //
////////////////////////////////////////////////////////////////////////////////////////

//is this a FraudIntelModel?
isFraudIntelModel := Models.FP_models.Model_Check(Valid_requested_models, [Models.FraudAdvisor_Constants.IDA_models_set]);

//blank out SSN, DOB, hphone, and wphone unless they meet specific lengths
socs_trim := trim(socs_value);
dob_trim := trim(dob_value);
hphone_trim := trim(hphone_value);
wphone_trim := trim(wphone_value);
ssn_length := length(socs_trim);
dob_length := length(dob_trim);
hphone_length := length(hphone_trim);
wphone_length := length(wphone_trim);
ssn_FraudIntel := if(ssn_length <> 0 AND ssn_length <> 9, '', socs_trim);
dob_FraudIntel := if(dob_length <> 0 AND dob_length <> 8, '', dob_trim);
hphone_FraudIntel := if(hphone_length <> 0 AND hphone_length <> 10, '', hphone_trim);
wphone_FraudIntel := if(wphone_length <> 0 AND wphone_length <> 10, '', wphone_trim);

//primary phone - if home phone empty, check work phone...
//...if work phone also empty, blank out, otherwise use work phone...
//...otherwise, use home phone
primaryPhone_FraudIntel := if(hphone_FraudIntel = '',
                              if(wphone_FraudIntel = '', '', wphone_FraudIntel),
                              hphone_FraudIntel);

//wphone gets blanked out if we're promoting it to phone10 (home phone blank but work phone present)                              
wphone_FraudIntel_Conditional := IF(hphone_fraudIntel = '' AND wphone_FraudIntel <> '', '', wphone_FraudIntel);

//FraudIntel minimum input - must meet one of the following requirements
//  First Name, Last Name, StreetAddress1, and Zip5
//  First Name, Last Name, StreetAddress1, City, and State
//  First Name, Last Name, and SSN
//  First Name, Last Name, and DOB
//  First Name, Last Name, and Primary Phone (hphone, wphone if no hphone present - see primaryPhone_FraudIntel)
passesFraudIntelMinimumCheck := (
                                  //First Name, Last Name - must always be present...
                                  (trim(first_value)<>'' and trim(last_value)<>'') and
                                    //...and one of the following
                                    (
                                      //StreetAddress1, Zip5
                                      (trim(addr_value)<>'' and trim(zip_value)<>'')
                                      or
                                      //StreetAddress1, City, State
                                      (trim(addr_value)<>'' and trim(city_value)<>'' and trim(state_value)<>'')
                                      or
                                      //SSN
                                      (ssn_FraudIntel<>'')
                                      or
                                      //DOB
                                      (dob_FraudIntel<>'')
                                      or
                                      //Primary Phone
                                      (primaryPhone_FraudIntel<>'')
                                    )
                                  );
hasOtherApplicationIdentifier3 := trim(OtherApplicationIdentifier3)<>'';
passesFraudIntelTotalCheck := passesFraudIntelMinimumCheck AND hasOtherApplicationIdentifier3;
canCallFraudIntel := isFraudIntelModel AND passesFraudIntelTotalCheck;

//////////////////////////////////////////////////////////////////////////////////////
//  END: New minimum input criteria for Fraud Intel models (i.e. IDA combo models)  //
//////////////////////////////////////////////////////////////////////////////////////

Gateway.Layouts.Config gw_switch(gateways_in le) := transform

  serviceNameLowerTrim := STD.STR.ToLowerCase(TRIM(le.servicename));
  
  self.servicename := map(Models.FP_models.Model_Check(Valid_requested_models, ['fd5609_2'])                                                                                  => '', //turn off all gateways for fd5609_2
                          Models.FP_models.Model_Check(Valid_requested_models, ['fp1303_1', 'fp1307_1']) and serviceNameLowerTrim = Gateway.Constants.ServiceName.NetAcuity   => '', //turn off netacuity gateway for fp1303_1
                          serviceNameLowerTrim = Gateway.Constants.ServiceName.bridgerwlc and OFACVersion = 4 and Models.FP_models.Model_Check(Valid_requested_models, [''])  => le.servicename,
                          serviceNameLowerTrim = Gateway.Constants.ServiceName.bridgerwlc and OFACVersion = 4 and
                          Not Models.FP_models.Model_Check(Valid_requested_models, Risk_Indicators.iid_constants.FAXML_WatchlistModels)                                       => '',
                          serviceNameLowerTrim in Models.FraudAdvisor_Constants.IDA_services and 
													(Not Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.IDA_models_set) OR
                          passesFraudIntelTotalCheck = FALSE)                                                                                                                 => '', //turn off IDA gateway if we don't need it OR minimum input check fails
                                                                                                                                                                                 le.servicename);
                                                                                                                                               
  self.url := map(Models.FP_models.Model_Check(Valid_requested_models, ['fd5609_2'])                                                                                          => '',
                  Models.FP_models.Model_Check(Valid_requested_models, ['fp1303_1', 'fp1307_1']) and serviceNameLowerTrim = Gateway.Constants.ServiceName.NetAcuity           => '',
                  serviceNameLowerTrim = Gateway.Constants.ServiceName.bridgerwlc and OFACVersion = 4 and Models.FP_models.Model_Check(Valid_requested_models, [''])          => le.url,
                  serviceNameLowerTrim = Gateway.Constants.ServiceName.bridgerwlc and OFACVersion = 4 and
                  Not Models.FP_models.Model_Check(Valid_requested_models, Risk_Indicators.iid_constants.FAXML_WatchlistModels)                                               => '',
                  serviceNameLowerTrim in Models.FraudAdvisor_Constants.IDA_services and 
									(Not Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.IDA_models_set) OR
                  passesFraudIntelTotalCheck = FALSE)                                                                                                                         => '', //turn off IDA gateway if we don't need it OR minimum input check fails
                                                                                                                                                                                 le.url); 
  self := le;
  
end;

gateways := project(gateways_in, gw_switch(left));

if(OFACVersion = 4 and Models.FP_models.Model_Check(Valid_requested_models, Risk_Indicators.iid_constants.FAXML_WatchlistModels) and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway)); 
if(OFACVersion = 4 and Models.FP_models.Model_Check(Valid_requested_models, ['']) and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway)); 

// requirement 2.5 - minimum input required
// a. Model is AVENGER and cmLexID is populated, and is the only thing populated
// b.	First Name, Last Name, Street Address, Zip
// c.	First Name, Last Name, SSN
input_ok := if( (Models.FP_models.FP31604_0_check(Valid_requested_models, 'fp31604_0', 'lexid')
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
                 ) 
                   //these checks only apply to NON-FraudIntel models
                   or
                   (isFraudIntelModel = false and
                     (
                       (trim(prep[1].fname)<>'' and trim(prep[1].lname)<>'' and 
                       (trim(prep[1].ssn)<>'' or (trim(prep[1].in_streetAddress)<>'' and trim(prep[1].in_zipCode)<>'')))
                     )
                   )
                   //FraudIntel-ONLY check
                   or
                   canCallFraudIntel
                  ,
                  TRUE,
                  ERROR(301,doxie.ErrorCodes(301)));
						
//=============================================================
//===  Description: This is the attribute version section. 
//===  This defines all the different version of attributes 
//===  that can be requested  
//=============================================================

attributesV2set := [Models.FraudAdvisor_Constants.attrV2,
                    Models.FraudAdvisor_Constants.attrV201,
                    Models.FraudAdvisor_Constants.attrV202];

doAttributesVersion1 := Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.attrV1]);	                  // output version1 if requested
doIDAttributes := Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.IDattr]);                          // Output IDAttributes if requested
doAttributesVersion2 := Models.FP_Models.Check_Valid_Attributes(attributesIn, attributesV2set) and input_ok;	                            // output version2 if requested and minimum input entered
doAttributesVersion201 := Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.attrV201]) and input_ok;	  // output version201 if requested and minimum input entered
doAttributesVersion202 := (Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.attrV202]) 
                          or Models.FP_models.Model_Check(Valid_requested_models, ['fp1908_1'])) // run attributes by this model name in case model called by FlexID
                          and input_ok;	  // output version202 if requested and minimum input entered
doParoAttributes := Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.attrvparo]) and input_ok;	      // output Paro attrs if requested and minimum input entered
doTMXAttributes := Models.FP_Models.Check_Valid_Attributes(attributesIn, [Models.FraudAdvisor_Constants.attrvTMX]) and input_ok;	      // output TMX attrs if requested and minimum input entered


//Options copied over from targets np31 model to make it work the same in FraudAdvisor
//These options are being hard coded to prevent target's fp1403_2 model from changing if FraudAdvisor settings change
DisableInquiriesInCVI := True;																																								//Disable Customer Network: True
unsigned3 LastSeenThresholdIn := map(	
                                  Models.FP_models.Model_Check(Valid_requested_models, ['fp1702_1','fp1702_2']) => risk_indicators.iid_constants.max_unsigned3,
                                  Models.FP_models.Model_Check(Valid_requested_models, ['fp1403_2','fp1510_2']) => 730,
                                  Models.FP_models.Model_Check(Valid_requested_models, ['fp1908_1','fp1909_1','fp1909_2']) => risk_indicators.iid_constants.oneyear,
                                  doAttributesVersion201 OR doAttributesVersion202     => 9999,
                                                                                          risk_indicators.iid_constants.oneyear);	//Last Seen Threshold: 365 days (1 year) for fp1403_2, otherwise use default

boolean doInquiries := ~DisableInquiriesInCVI AND dataRestriction[risk_indicators.iid_constants.posInquiriesRestriction]<>risk_indicators.iid_constants.sTrue AND
                       Models.FP_models.Model_Check(Valid_requested_models, ['fp1403_2','fp1510_2']);

//  options
doRelatives      := true;
doDL             := false;
//***If your model uses vehicle data - then you must add it to this list
doVehicle        := (Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.DoVechicle_List)) or doAttributesVersion2;
doDerogs         := true;
isLn             := false;     // set ln branded to activate exp dl sources in iid getheader in < 5 shells.
suppressNearDups := Models.FP_models.Model_Check(Valid_requested_models, ['idn6051', 'fd5609_2']) OR isWFS34 OR doIDAttributes;
require2Ele      := Models.FP_models.Model_Check(Valid_requested_models, ['fd5609_2']) OR isWFS34 OR doIDAttributes;
from_biid        := false;
from_IT1O        := IF(Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.Paro_models) or doParoAttributes, true, false); //set to true if Paro is transacting
doScore          := false;
nugen            := if(Models.FP_models.Model_Check(Valid_requested_models, ['fd5609_2']) OR isWFS34 OR doIDAttributes, false, true);  // fd5609_2 and wfs34 are legacy models being plugged into nugen product
inCalif          := false;
fdReasonsWith38  := false;

// Fields tweaked for WFS3/WFS4
ofac_only        := isWFS34 OR doIDAttributes OR in_ofac_only;
isUtility					:= IF(isWFS34 OR doIDAttributes, FALSE, inIsUtility);

// new options for fp attributes 2.0
IncludeDLverification := if(doAttributesVersion2, true, false);

//=========================
//=== BS Version        ===
//=========================
bsVersion := map(
  Models.FP_models.Model_Check(Valid_requested_models, ['di31906_0']) or doTMXAttributes => 55,
  Models.FP_models.Model_Check(Valid_requested_models, ['fp1902_1', 'fp1908_1', 'fp1909_1', 'fp1909_2', 'fp1907_1', 'fp1907_2', 'fibn12010_0']) => 54,
  Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.BS_Version53_List) or doParoAttributes or doAttributesVersion202 => 53,
	Models.FP_models.Model_Check(Valid_requested_models, ['fp1706_1','fp1705_1','fp1704_1']) => 52,
	Models.FP_models.Model_Check(Valid_requested_models, ['fp1506_1', 'fp31505_0', 'fp3fdn1505_0', 'fp31505_9', 'fp3fdn1505_9','fp1509_1', 
      'fp1512_1','fp31604_0','fp1610_1', 'fp1610_2', 'fp1609_1', 'fp1611_1', 'fp1606_1','fp1702_2','fp1702_1','fp1609_2','fp1607_1']) => 51, 
	doAttributesVersion201 => 50,
	Models.FP_models.Model_Check(Valid_requested_models, ['fp1509_2','fp1510_2','fp1511_1']) => 50,
	Models.FP_models.Model_Check(Valid_requested_models, ['fp1303_1', 'fp1310_1', 'fp1401_1', 'fp31310_2',
      'fp1307_1', 'fp1307_2', 'fp1404_1', 'fp1407_1', 'fp1407_2', 'fp1406_1', 'fp1403_2', 'fp1409_2']) => 41,
  doAttributesVersion2 or Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.fraudpoint2_models) => 4,
	Models.FP_models.Model_Check(Valid_requested_models, ['fp31203_1']) => 4,
  Models.FP_models.Model_Check(Valid_requested_models, ['fp31105_1']) => 3,
                                                                            2
);

//=========================
//=== BS options        ===
//=========================
BSOptions := Models.FP_Models.Set_BSOptions(Valid_requested_models, attributesIn, input_ok, doInquiries, UseIngestDate);

iid := //Group(Dataset([],risk_indicators.layout_output), seq);
       risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn, 
																					ofac_only, suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists, 
																					from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius, 
																					BSversion, in_runDLverification:=IncludeDLverification,
																					in_DataRestriction:=DataRestriction, in_BSOptions:=BSOptions,
                                                                                    in_LastSeenThreshold:=LastSeenThresholdIn, in_CompanyID := CompanyID,
                                                                                    in_DataPermission:=DataPermission,
                                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                                    TransactionID := TransactionID, 
                                                                                    BatchUID := BatchUID, 
                                                                                    GlobalCompanyID := GlobalCompanyID);

//Check for ThreatMetrix Gateway error
IF(EXISTS(gateways(servicename IN ['threatmetrix', 'threatmetrix_test'])),
          IF(iid[1].threatmetrix.digital_id_result[1..14] = 'gateway-error:', 
             FAIL('An error occured within the ThreatMetrix Gateway (Error Code ' + iid[1].threatmetrix.digital_id_result[15..] + ')')));

                                                                                    

clam := //Group(Dataset([], risk_indicators.Layout_Boca_Shell), seq);
        risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn,  
																						doRelatives, doDL, doVehicle, doDerogs, bsVersion, doScore, nugen,
																						DataRestriction:=DataRestriction, BSOptions := BSOptions, DataPermission:=DataPermission,
                                                                                        LexIdSourceOptout := LexIdSourceOptout, 
                                                                                        TransactionID := TransactionID, 
                                                                                        BatchUID := BatchUID, 
                                                                                        GlobalCompanyID := GlobalCompanyID);


// Run Bill-to-Ship-to Shell if necessary.
clam_BtSt := //Group(Dataset([], risk_indicators.layout_bocashell_btst_out), bill_to_out.seq);
	IF( Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.bill_to_ship_to_models),
				Models.FraudAdvisor_BtSt_Function(prep, prep2, gateways, DPPA_Purpose, GLB_Purpose, isUtility, isLn,
																					ofac_only, suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists,
																					from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius,
																					BSversion, DataRestriction, IncludeDLverification, DataPermission,
																					doRelatives, doDL, doVehicle, doDerogs, doScore, nugen, BSOptions,
                                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                                    TransactionID := TransactionID, 
                                                                                    BatchUID := BatchUID, 
                                                                                    GlobalCompanyID := GlobalCompanyID)
	);
  
  //Added for Paro 9-2018
  skiptrace_Prep := project(ungroup(iid), transform(risk_indicators.Layout_input, self := left));
  skiptrace_call := riskwise.skip_trace(skiptrace_Prep, DPPA_Purpose, GLB_Purpose, DataRestriction, '', DataPermission);
  
  riskwise.Layout_SkipTrace get_confidence(riskwise.Layout_SkipTrace le, risk_indicators.layout_output rt) := transform
    self.addr_confidence_a := map(le.addr_type_a='X' => '',
    
                                  le.addr_type_a in ['U','C'] and rt.chronophone<>'' and
                                  risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'A',

                                  le.addr_type_a in ['U','C'] and rt.chronophone='' and
                                  risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, rt.chronoprim_range, rt.chronoprim_name, rt.chronosec_range)) => 'B',

                                  risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, rt.chronoprim_range2, rt.chronoprim_name2, rt.chronosec_range2)) => 'B',

                                  risk_indicators.ga(Risk_Indicators.AddrScore.AddressScore(le.prim_range, le.prim_name, le.sec_range, rt.chronoprim_range3, rt.chronoprim_name3, rt.chronosec_range3)) => 'C',
                                  '');							
    self := le;		
  end;

  full_skiptrace := join(skiptrace_call, iid, LEFT.seq= RIGHT.seq, get_confidence(left,right) );
  
  skiptrace := IF(Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.Paro_models), full_skiptrace, Dataset([], riskwise.Layout_SkipTrace));

  easi_census1 := join(ungroup(iid), Easi.Key_Easi_Census,
                      keyed(left.st+left.county+left.geo_blk=right.geolink) and
                      Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.Paro_models),
                      transform(easi.layout_census, 
                                self.state:= left.st,
                                self.county:=left.county,
                                self.tract:=left.geo_blk[1..6],
                                self.blkgrp:=left.geo_blk[7],
                                self.geo_blk:=left.geo_blk,
                                self := right));
                                
  easi_census := IF(Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.Paro_models), easi_census1, Dataset([], easi.layout_census));
  //End for Paro
  
ip_prep := project( ungroup(iid), transform( riskwise.Layout_IPAI, self.seq := left.seq, self.ipaddr := ip_value, self.did := left.did) );
ipdata := risk_indicators.getNetAcuity( ip_prep, gateways, DPPA_Purpose, GLB_Purpose, applyOptOut := TRUE); 

clam_ip := join( clam, ipdata, left.seq=right.seq,
	transform( models.layouts.bs_with_ip,
		self.bs := left,
		self.ip := right
	),
	left outer
);

	
#if( NOT Models.FraudAdvisor_Constants.VALIDATION_MODE)
    
//* *************************************
//*   Boca Shell Logging Functionality  *
//***************************************
		 productID := Risk_Reporting.ProductID.Models__FraudAdvisor_Service;
	
     intermediate_Log := Risk_Reporting.To_LOG_Boca_Shell(clam, productID, bsVersion);
// ************ End Logging ************

#END
risk_indicators.layout_input into_test_prep(r1 l) := transform
	self.seq := l.seq;	
	self.ssn := socs_value;
	self.phone10 := hphone_value;
	self.fname := STD.STR.ToUpperCase(first_value);
	self.lname := STD.STR.ToUpperCase(last_value);
	SELF.in_zipCode := zip_value;
	self := [];
end;

test_prep := PROJECT(d,into_test_prep(LEFT));


model_indicator := IF(doParoAttributes, Models.FraudAdvisor_Constants.attrvparo, ''); //model names will now be passed in through the model request structure in getFDAttributes

// Get the attributes
attributes := Models.getFDAttributes(clam, iid, account_value, ipdata, model_indicator, suppressCompromisedDLs, ModelRequests := Valid_requested_models, mod_access := mod_access);
//For Paro update
// attributes := Models.getFDAttributes(clam, iid, account_value, ipdata, model_indicator, suppressCompromisedDLs,
                                     // DPPA_Purpose, GLB_Purpose, DataRestriction, DataPermission, '', Valid_requested_models);
																			
attr_test_seed := Risk_Indicators.FDAttributes_TestSeed_Function(test_prep, account_value, Test_Data_Table_Name);	
																																									
// choose either test seed or real
pick_attr := if(Test_Data_Enabled, attr_test_seed, ungroup(attributes));	
// pick_attr := ungroup(attributes);									

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

//Centralize the logic for getting the count for the attribute normalize's
NormalizeCount := map( doAttributesVersion1                              => 162,
                       doTMXAttributes                                   => 538,
                       doAttributesVersion202                            => 384,
                       doAttributesVersion201 and SuppressCompromisedDLs => 226,
                       doAttributesVersion201                            => 225,
                       doAttributesVersion2                              => 217,
                       doIDAttributes                                    => 105,
                       doParoAttributes                                  => 35,
                                                                            0);//no attributes or invalid attributes requested

name_pairs :=  normalize(pick_attr, NormalizeCount, Models.FraudAdvisor_Transforms(suppressCompromisedDLs).intoVersion1(left, counter));
v1 := project(name_pairs, transform(layout_attribute, self.attribute := left));

v2_name_pairs :=  normalize(pick_attr, NormalizeCount, Models.FraudAdvisor_Transforms(suppressCompromisedDLs).intoVersion2(left, counter))(name<>'');
v2 := project(v2_name_pairs, transform(layout_attribute, self.attribute := left));
		
layout_AttributeGroup formAttributes(Models.Layout_FraudAttributes le) := TRANSFORM
	self.name := map( doTMXAttributes        => 'Version202_DI1',
                    doAttributesVersion202 => 'Version202',
                    doAttributesVersion201 => 'Version201',
										doAttributesVersion2   => 'Version2',
										                          'Version1'
									);
	self.index := if(doAttributesVersion1 or doAttributesVersion2 or doTMXAttributes, '0', '');
	self.Attributes := if(doAttributesVersion2 or doTMXAttributes, ungroup(v2), ungroup(v1));
END;

name_pairs_IDAttributes := NORMALIZE(pick_attr, NormalizeCount, Models.FraudAdvisor_Transforms(suppressCompromisedDLs).intoIDAttributes(LEFT, COUNTER));
id_attr := PROJECT(name_pairs_IDAttributes, TRANSFORM(layout_attribute, self.attribute := LEFT));

Layout_AttributeGroup form_IDAttributes(Models.Layout_FraudAttributes le) := TRANSFORM
	self.name := 'IDAttributes';
	self.index := if(doIDAttributes, '0', '');
	self.Attributes := ungroup(id_attr);
END;

name_pairs_ParoAttributes := NORMALIZE(pick_attr, NormalizeCount, Models.FraudAdvisor_Transforms(suppressCompromisedDLs).intoParoAttributes(LEFT, COUNTER));
Paro_attr := PROJECT(name_pairs_ParoAttributes, TRANSFORM(layout_attribute, self.attribute := LEFT));

Layout_AttributeGroup form_ParoAttributes(Models.Layout_FraudAttributes le) := TRANSFORM
	self.name := 'ParoAttributes';
	self.index := if(doParoAttributes, '0', '');
	self.Attributes := ungroup(Paro_attr);
END;

layout_FDAttributesOut formAttributeGroup(Models.Layout_FraudAttributes le) := transform
	self.accountnumber := if(doAttributesVersion1 or doAttributesVersion2 OR doIDAttributes or doParoAttributes or doTMXAttributes, account_value, '');
	self.input.grade := ''; // To mask wfs3/4 using Grade. Will be populated using the custom_field_replacement function below
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
	
	self.AttributeGroup := MAP(doAttributesVersion1 or
                             doAttributesVersion2 or
                             doTMXAttributes          => DATASET([formAttributes(le)]),
                             doIDAttributes           => DATASET([form_IDAttributes(le)]),
                             doParoAttributes         => DATASET([form_ParoAttributes(le)]),
                                                         DATASET([], layout_AttributeGroup)
                            );
  self := [];
END;
attributeOut_temp := PROJECT(pick_attr, formAttributeGroup(left));

attributeOut := Models.FP_models.custom_field_replacement(attributeOut_temp, Valid_requested_models, '', 'input.grade', 'grade', 'string');
// attributeOut := join(pick_attr,clam,  left.input.seq=right.seq, formAttributeGroup(LEFT,RIGHT));


//Make sure we are passing in the input PII not the cleaned PII to IDA
IDA_input := PROJECT(iid, Transform(Risk_Indicators.layouts.layout_IDAFraud_in,
                      SELF.seq := left.seq;
                      SELF.DID := left.did;
                      SELF.fname := first_value;
                      SELF.mname := middle_value;
                      SELF.lname := last_value;
                      SELF.suffix := suffix_value;
                      SELF.in_streetAddress := addr_value;
                      SELF.in_city := city_value;
                      SELF.in_state := state_value;
                      SELF.in_zipCode := zip_value;
                      SELF.in_country := country_value;
                      SELF.ssn := ssn_FraudIntel;
                      SELF.dob := dob_FraudIntel;
                      SELF.phone10 := primaryPhone_FraudIntel;
                      SELF.wphone10 := wphone_FraudIntel_Conditional;
                      SELF.dl_number := drlc_value;
                      SELF.dl_state := drlcstate_value;
                      SELF.email_address := email_value;
                      SELF.ip_address := ip_value;
                      SELF.historydate := IF(historyDateTimeStamp <> '', (UNSIGNED)historyDateTimeStamp[1..6], history_date);
                      SELF.historyDateTimeStamp := risk_indicators.iid_constants.mygetdateTimeStamp(historydateTimeStamp, history_date);
                      
                      SELF.Client := Map(IDA_gateway_mode = 2 => Trim('ACC1357055'),
                                         IDA_gateway_mode = 1 => Trim('ACC1357055'),
                                         IDA_gateway_mode = 0 => Trim('ACC'+CompanyID),
                                                                 '' //shouldn't happen
                                        );
                      SELF.Solution := Trim('Standard/MultiProduct'); 
                      SELF.ProductName := ''; //Populated per model
                      SELF.ProductID := ''; //Populated per model
                      SELF.App_ID := Trim(OtherApplicationIdentifier3);
                      SELF.ESPTransactionId := TransactionID;
                      SELF.Channel := Channel;
                      SELF := [];

                     ));


//Call the IDA gateway if needed
IDA_attributes_raw := Risk_Indicators.Prep_IDA_Fraud(ungroup(IDA_input), gateways, Valid_requested_models);
  
IDA_attributes := IF(Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.IDA_models_set), 
                     IDA_attributes_raw,
                     DATASET([],Risk_Indicators.layouts.layout_IDAFraud_out)
                     );


// Get the Fraud Defender models
ret  := Models.FD3510_0_0(clam, ofacSearching, isFCRA, inCalif, fdReasonsWith38, nugen, addtl_watchlists);
ret2 := Models.FD5510_0_0(clam, ofacSearching, nugen, addtl_watchlists);
ret3 := Models.FD9510_0_0(clam, ofacSearching, nugen, addtl_watchlists);

//Defining the bulk of FP_Mod here for use in LUCI wrapper debug mode
FPMod_params := MODULE(models.FraudAdvisor_Constants.FP_model_params)
  EXPORT Grouped DATASET(risk_indicators.Layout_Boca_Shell) _clam := clam;
  EXPORT Grouped DATASET(risk_indicators.layout_bocashell_btst_out) _clam_BtSt :=  clam_BtSt;
  EXPORT DATASET(models.layouts.bs_with_ip) _clam_ip :=  clam_ip;
  EXPORT Grouped DATASET(Risk_Indicators.Layout_Output) IID_ret := iid;
  EXPORT DATASET(riskwise.Layout_SkipTrace) _skiptrace := skiptrace;
  EXPORT DATASET(easi.layout_census) _easicensus := easi_census;
  EXPORT DATASET(Models.Layout_FraudAttributes) _FDattributes := attributes;
  EXPORT DATASET(Risk_Indicators.layouts.layout_IDAFraud_out) IDAattributes := IDA_attributes;
END;

All_models := PROJECT(Valid_requested_models, transform(Models.layouts.Enhanced_layout_fp1109,

                                              Model_params := MODULE(FPMod_params)
                                                EXPORT DATASET(Models.Layouts.Layout_Model_Options) modeloptions  := left.modeloptions;
                                              END;

                                              custom_temp  := left.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
                                              custom_name  := STD.STR.ToLowerCase(TRIM(custom_temp[1].OptionValue));
                                              
                                              self.model_name := custom_name, // piping model name through to keep track of what's what
                                              self := Models.FP_models.Execute_model(Model_params)
                      ));

fp_test_seed := PROJECT(Valid_requested_models, Transform(Models.layouts.Enhanced_layout_fp1109,
                                                seed_custom_temp  := left.ModelOptions(STD.STR.ToLowerCase(TRIM(OptionName)) = 'custom');
                                                seed_custom_name  := STD.STR.ToLowerCase(TRIM(seed_custom_temp[1].OptionValue));
                                                
                                                self := Risk_Indicators.FraudPoint_TestSeed_Function(test_prep, Test_Data_Table_Name, seed_custom_name)
                        ));

models.Layout_Reason_Codes form_modelout_rc(Models.Layout_ModelOut le, unsigned1 cnt) :=
TRANSFORM
	SELF.reason_code := IF(cnt = 1, //if rc1 then do what the original transform was doing otherwise use what's there
                         IF(~isWFS34,
                            if(le.ri[cnt].hri <> '00', le.ri[cnt].hri, ''),
                            IF(Risk_Indicators.rcSet.isCode36(le.ri[cnt].hri), '36', le.ri[cnt].hri)),
                         if(le.ri[cnt].hri <> '00', le.ri[cnt].hri, ''));
                         
	SELF.reason_description := IF(cnt = 1, //if rc1 then do what the original transform was doing otherwise use what's there
                                IF(~isWFS34,
                                   le.ri[cnt].desc,
                                   IF(Risk_Indicators.rcSet.isCode36(le.ri[cnt].hri), Risk_Indicators.getHRIDesc('36'), le.ri[cnt].desc)),
                                le.ri[cnt].desc);
end;

//---------------FraudDefender Score Section-------------------------------------

Models.Layouts.Layout_Score_FP form_cscore(Models.Layout_ModelOut le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := if(Models.FP_models.Model_Check(Valid_requested_models, ['fd5609_2']), '10 to 50', '0 to 999');
	reason_codes_temp :=
		PROJECT(le,form_modelout_rc(LEFT, 1)) + PROJECT(le,form_modelout_rc(LEFT, 2)) + PROJECT(le,form_modelout_rc(LEFT, 3)) + PROJECT(le,form_modelout_rc(LEFT, 4))
			 //***if the model is present it will include all 6 reason codes
       + if( Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.ThisSet_for_Reason_Code_Temps),
		PROJECT(le,form_modelout_rc(LEFT, 5)) + PROJECT(le,form_modelout_rc(LEFT, 6)) );
	risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self.index := Models.FraudAdvisor_Constants.getBilling_Index(model_name_1); //might need to come back to this.

	self := [];
end;

Models.Layouts.Layout_Score_FP form_cscore2(ret2 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 50';
	reason_codes := PROJECT(le,form_modelout_rc(LEFT,1)) + PROJECT(le,form_modelout_rc(LEFT,2)) + PROJECT(le,form_modelout_rc(LEFT,3)) + PROJECT(le,form_modelout_rc(LEFT,4));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self := [];
END;
Models.Layouts.Layout_Score_FP form_cscore3(ret3 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := '10 to 90';
	reason_codes := PROJECT(le,form_modelout_rc(LEFT,1)) + PROJECT(le,form_modelout_rc(LEFT,2)) + PROJECT(le,form_modelout_rc(LEFT,3)) + PROJECT(le,form_modelout_rc(LEFT,4));
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
// final_v1 := final2;

//---------------END FraudDefender Score Section-------------------------------------


models.Layout_Reason_Codes form_fp1109_rc(Models.layouts.Enhanced_layout_fp1109 le, unsigned1 cnt) :=
TRANSFORM
	SELF.reason_code := if(le.ri[cnt].hri <> '00', le.ri[cnt].hri, '');
	SELF.reason_description := le.ri[cnt].desc;
end;

//---------------Normal Score Section-------------------------------------
Models.Layouts.Layout_Score_FP form_fp_scores(Models.layouts.Enhanced_layout_fp1109 le) :=
TRANSFORM
	SELF.i := le.Score;
	SELF.description := map(le.model_name = 'fd5609_2' => '10 to 50',
                          le.model_name = 'rsn804_1' => '250 to 999',
                                                        '0 to 999');
	// get the le into layout_modelout to re-use the form_rc function
	reason_codes_temp := PROJECT(le,form_fp1109_rc(LEFT,1)) + PROJECT(le,form_fp1109_rc(LEFT,2)) + PROJECT(le,form_fp1109_rc(LEFT,3)) +
                       PROJECT(le,form_fp1109_rc(LEFT,4)) + PROJECT(le,form_fp1109_rc(LEFT,5)) + PROJECT(le,form_fp1109_rc(LEFT,6));
	risk_indicators.MAC_add_sequence(reason_codes_temp(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
	self.index := Models.FraudAdvisor_Constants.getBilling_Index(trim(le.model_name));

	IncludeRiskIndicesFinal := if( le.model_name in Models.FraudAdvisor_Constants.List_Include_RiskIndices, true, IncludeRiskIndices);
	
	self.StolenIdentityIndex        := if(IncludeRiskIndicesFinal, le.StolenIdentityIndex, '');
	self.SyntheticIdentityIndex     := if(IncludeRiskIndicesFinal, le.SyntheticIdentityIndex, '');
	self.ManipulatedIdentityIndex   := if(IncludeRiskIndicesFinal, le.ManipulatedIdentityIndex, '');
	self.VulnerableVictimIndex      := if(IncludeRiskIndicesFinal, le.VulnerableVictimIndex, '');
	self.FriendlyFraudIndex         := if(IncludeRiskIndicesFinal, le.FriendlyFraudIndex, '');
	self.SuspiciousActivityIndex    := if(IncludeRiskIndicesFinal, le.SuspiciousActivityIndex, '');
end;


Models.layouts.FP_Layout_Model form_fraudpoint_models(Models.layouts.Enhanced_layout_fp1109 le) := 
TRANSFORM
	self.accountnumber := account_value;
	self.description  := Models.FraudAdvisor_Constants.getModel_Description(trim(le.model_name));
	self.scores := project(le, form_fp_scores(left));

END;

all_fraudpoint_models := if(input_ok, 
	project(if(test_data_enabled, fp_test_seed, All_models), form_fraudpoint_models(LEFT)),  
	// project( All_models, form_fraudpoint_models(LEFT)), 
	dataset([], models.layouts.FP_layout_model) );

//---------------END Normal Score Section-------------------------------------

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

standard_model_set := ['ain801_1', Models.FraudAdvisor_Constants.fraudpoint3_models, Models.FraudAdvisor_Constants.fraudpoint3_custom_models,
                       Models.FraudAdvisor_Constants.fraudpoint2_models, Models.FraudAdvisor_Constants.XML_custom_models,Models.FraudAdvisor_Constants.Paro_models ];

finalcustom := map( Models.FP_models.Model_Check(Valid_requested_models, ['idn6051'])        => custom_idn6051,
                    Models.FP_models.Model_Check(Valid_requested_models, standard_model_set) => all_fraudpoint_models,
                                                                                                final_v1 ); 

#if(~Models.FraudAdvisor_Constants.VALIDATION_MODE)

output(attributes[1].compromisedDL_hash, named('compromisedDL_hash'));	

// Note: All intermediate logs must have the following name schema:
// Starts with 'LOG_' (Upper case is important!!)
// Middle part is the database name, in this case: 'log__mbs'
// Must end with '_intermediate__log'
IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(intermediate_Log, NAMED('LOG_log__mbs_intermediate__log')) );

// pick either 3 defaults or attribute model
scores := if((~doAttributesVersion1 AND ~doIDAttributes) or 
                Models.FP_models.Model_Check(Valid_requested_models, Models.FraudAdvisor_Constants.XML_custom_models) OR  
                isWFS34, 
              finalcustom, dataset([],Models.layouts.FP_Layout_Model));
OUTPUT(scores,NAMED('Results')); // We only want to output this when wfs3/4 is not being requested

red_flags := if(Test_Data_Enabled, seed_files.GetRedFlags(test_prep, Test_Data_Table_Name), risk_indicators.Red_Flags_Function(iid));

// trigger red flags by setting redflag_version to something other than 0
attributes_w_redflags := if(redflag_version > 0, join(attributeout, red_flags, left.input.seq=right.seq, 
											transform(layout_FDAttributesOut,
																self.Red_Flags := right, self := left)), 
																attributeout);
OUTPUT(attributes_w_redflags, NAMED('Results2'));  

//Only get royalties for hitting the Insurance DL information if they are allowed to access the information
insurance_royalty := If(TrackInsuranceRoyalties, Royalty.RoyaltyFDNDLDATA.GetWebRoyalties(UNGROUP(iid), did, insurance_dl_used, true));

royalties := IF(~Test_Data_Enabled, Royalty.RoyaltyNetAcuity.GetOnlineRoyalties(gateways, ip_prep, ipdata) + insurance_royalty);
output(royalties,NAMED('RoyaltySet'));
	
  
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
Deltabase_Logging_prep :=  DATASET([TRANSFORM(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
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
																					 self.i_model_name_1 := model_name_1,
																					 self.i_model_name_2 := model_name_2,
																					 self.o_score_1    := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].i, ''),
																					 self.o_reason_1_1 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[1].Reason_Code, ''),
																					 self.o_reason_1_2 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[2].Reason_Code, ''),
																					 self.o_reason_1_3 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[3].Reason_Code, ''),
																					 self.o_reason_1_4 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[4].Reason_Code, ''),
																					 self.o_reason_1_5 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[5].Reason_Code, ''),
																					 self.o_reason_1_6 := IF(count(Valid_requested_models) > 0, Scores[1].Scores[1].Reason_Codes[6].Reason_Code, ''),
																					 self.o_score_2    := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].i, ''),
																					 self.o_reason_2_1 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[1].Reason_Code, ''),
																					 self.o_reason_2_2 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[2].Reason_Code, ''),
																					 self.o_reason_2_3 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[3].Reason_Code, ''),
																					 self.o_reason_2_4 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[4].Reason_Code, ''),
																					 self.o_reason_2_5 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[5].Reason_Code, ''),
																					 self.o_reason_2_6 := IF(count(Valid_requested_models) > 1, Scores[2].Scores[1].Reason_Codes[6].Reason_Code, ''),
																					 self.o_lexid      := attributes_w_redflags[1].input.did,
																					 self := [] // there are several fields that will not get populated from FP, mostly business fields
                                           )]);
																					 
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

IF(~DisableOutcomeTracking and ~Test_Data_Enabled, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

#ELSE //Valiation_mode = true

  // This is for ROUND 2 Validation ONLY //
  // ModelValidationResults := Models.FP1909_2_0(clam, 6, attributes);
  ModelValidationResults := Models.getLuciModel(FPMod_params).FIBN12010_0;
  OUTPUT(ModelValidationResults, named('Results'));
    

#END //==== end of commented code for debug/validation mode ======


//======================================================
//==== for debug only                                ===
//======================================================
 // ret_custom := Models.FP31604_0_0( ungroup(clam), 6);
//  OUTPUT(ret_custom, NAMED('Results'));
 // OUTPUT(paro_model, NAMED('paro_model'));
//  output( iid, NAMED('IID__out'));
 // output(doAttributesVersion2, named('doAttributesVersion2'));
  //output(v2, named('v2'));
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
