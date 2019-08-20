/*--SOAP--
<message name="ITA_Search_Service">
	<part name="seq" type="xsd:string"/>
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
	<part name="SSN" type="xsd:string"/>
	<part name="DateOfBirth" type="xsd:string"/>
	<part name="DLNumber" type="xsd:string"/>
	<part name="DLState" type="xsd:string"/>
	<part name="HomePhone" type="xsd:string"/>
	<part name="WorkPhone" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="ModelName" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/> 
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="Version" type="xsd:integer"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
</message>
*/
/*--INFO-- Invitation to Apply Search Service*/

IMPORT Risk_Indicators, Models, RiskWise, ut;
	
EXPORT ITA_Search_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.GLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);


/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'seq',
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
	'SSN',
	'DateOfBirth',
	'DLNumber',
	'DLState',
	'HomePhone',
	'WorkPhone',
	'DPPAPurpose',
	'GLBPurpose',
	'DataRestrictionMask',
	'DataPermissionMask',
	'ModelName',
  'gateways',  
  'OFACversion',
	'Version',
	'HistoryDateYYYYMM',
        'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));


/* ***************************************
	 *             Grab Input:             *
   *************************************** */
Risk_indicators.MAC_unparsedfullname(title_val,first_value,middle_value,last_value,suffix_value,'FirstName','MiddleName','LastName','NameSuffix');

UNSIGNED4	seq := 1 							: stored('seq');
STRING30  account_value := ''		: stored('AccountNumber');
STRING120 addr_value := ''    	: stored('StreetAddress');
STRING25  city_value := ''      : stored('City');
STRING2   state_value := ''     : stored('State');
STRING9   zip_value := ''      	: stored('Zip');
STRING25  country_value := '' 	: stored('Country');
STRING9   socs_value := ''     	: stored('ssn');
STRING8   dob_value := ''      	: stored('DateOfBirth');
UNSIGNED1 age_value := 0      	: stored('Age');
STRING20  drlc_value := ''     	: stored('DLNumber');
STRING2   drlcstate_value := '' : stored('DLState');
STRING100 email_value := ''  		: stored('Email');
STRING45  ip_value := ''      	: stored('IPAddress');
STRING10  hphone_value := ''   	: stored('HomePhone');
STRING10  wphone_value := ''  	: stored('WorkPhone');
UNSIGNED1 DPPA := 0			: stored('DPPAPurpose');
UNSIGNED1 GLB := RiskWise.permittedUse.GLBA : stored('GLBPurpose');
STRING ModelName_in := ''				: stored('ModelName');
model_name := STD.Str.ToLowerCase( modelname_in );
UNSIGNED1 ofac_version      := 1        : stored('OFACVersion');
UNSIGNED1 attributesVersion   := 1 : stored('Version');
UNSIGNED3 historyDate := 999999 : stored('HistoryDateYYYYMM');
STRING DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
STRING50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

gateways_in := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

Gateway.Layouts.Config gw_switch(gateways_in le) := transform
	self.servicename := if(ofac_version = 4 and le.servicename = 'bridgerwlc',le.servicename, '');
	self.url := if(ofac_version = 4 and le.servicename = 'bridgerwlc', le.url, ''); 		
	self := le;
end;
gateways := project(gateways_in, gw_switch(left));

if( ofac_version = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

/* ***************************************
	 *           Package Input:            *
   *************************************** */

packagedInput := DATASET([TRANSFORM(Models.Layout_LeadIntegrity_In,
    SELF.Seq := (STRING)seq;
	SELF.FirstName := first_value;
	SELF.MiddleName := middle_value;
	SELF.LastName := last_value;
	SELF.SuffixName := suffix_value;
	SELF.streetAddr := addr_value;
	SELF.City := city_value;
	SELF.State := state_value;
	SELF.Zip := zip_value;
	SELF.Country := country_value;
	SELF.DateOfBirth := dob_value;
	SELF.SSN := socs_value;
	SELF.HomePhone := hphone_value;
	SELF.WorkPhone := wphone_value;
	SELF.DLNumber := drlc_value;
	SELF.DLState := drlcstate_value;
	SELF.AccountNumber := account_value;
	SELF := [])] );

/* ***************************************
	 *      Gather Attributes/Scores:      *
   *************************************** */
results := Models.LeadIntegrity_Search_Function(packagedInput, GLB, DPPA, historyDate, DataRestriction, attributesVersion, model_name, false, DataPermission, gateways, ofac_version,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);

OUTPUT(results, NAMED('Results'));
	
ENDMACRO;