/*--SOAP--
<message name="StudentAdvisorService">
	<part name="AccountNumber" type="xsd:string"/>
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
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="IndustryClass" type="xsd:string"/>
	<part name="LnBranded" type="xsd:boolean"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="OfacOnly" type="xsd:boolean"/>
	<part name="OFACSearching" type="xsd:boolean"/>

	<part name="ExcludeWatchLists" type="xsd:boolean"/>
	<part name="OFACversion" type="xsd:unsignedInt"/>
	<part name="IncludeOfac" type="xsd:boolean"/>
	<part name="GlobalWatchlistThreshold" type="xsd:real"/>  
	<part name="IncludeAdditionalWatchLists" type="xsd:boolean"/>
	<part name="UseDOBFilter" type="xsd:boolean"/>
	<part name="DOBRadius" type="xsd:unsignedInt"/>	

	<part name="isStudent" type="xsd:boolean"/>					// may need to change this to the dataset that dermot is passing, or pick the field out of the dataset and pass as boolean here
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
/*--INFO-- Contains Student Advisor 3, 5 and 9 */

import risk_indicators, riskwise, ut, gateway, AutoStandardI, STD;


export StudentAdvisor_Service := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
#WEBSERVICE(FIELDS(
	'AccountNumber',
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
	'DPPAPurpose',
	'GLBPurpose', 
	'DataRestrictionMask',
	'DataPermissionMask',
	'IndustryClass',
	'LnBranded',
	'HistoryDateYYYYMM',
	'OfacOnly',
	'OFACSearching',

	'ExcludeWatchLists',
	'OFACversion',
	'IncludeOfac',
	'GlobalWatchlistThreshold',
	'IncludeAdditionalWatchLists',
	'UseDOBFilter',
	'DOBRadius',	

	'isStudent',					// may need to change this to the dataset that dermot is passing, or pick the field out of the dataset and pass as boolean here
	'gateways',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

string30  account_value := '' 		: stored('AccountNumber');
string30  first_value := ''     		: stored('FirstName');
string30  middle_value := ''     		: stored('MiddleName');
string30  last_value := ''     		: stored('LastName');
string5   suffix_value := ''     		: stored('NameSuffix');
string120 addr_value := ''    		: stored('StreetAddress');
string25  city_value := ''      		: stored('City');
string2   state_value := ''      		: stored('State');
string9   zip_value := ''      		: stored('Zip');
string25  country_value := '' 		: stored('Country');
string9   socs_value := ''     		: stored('ssn');
string8   dob_value := ''      		: stored('DateOfBirth');
unsigned1 age_value := 0      		: stored('Age');
string20  drlc_value := ''     		: stored('DLNumber');
string2   drlcstate_value := ''    	: stored('DLState');
string100 email_value := ''  			: stored('Email');
string45  ip_value := ''      		: stored('IPAddress');
string10  hphone_value := ''   		: stored('HomePhone');
string10  wphone_value := ''  		: stored('WorkPhone');
string100 cmpy_value := '' 			: stored('EmployerName');
string30  formerlast_value := ''   	: stored('FormerName');

unsigned1 DPPA_Purpose := 0 			: stored('DPPAPurpose');
unsigned1 GLB_Purpose := AutoStandardI.Constants.GLBPurpose_default : stored('GLBPurpose');
string5   industry_class_val := '' 	: stored('IndustryClass');
		industry_class_value := STD.Str.ToUpperCase(industry_class_val);
boolean   ln_branded_value := false 	: stored('LnBranded');
unsigned3 history_date := 999999 		: stored('HistoryDateYYYYMM');
boolean   ofac_only := true 			: stored('OfacOnly');
boolean   ofacSearching := true 		: stored('OFACSearching');

//
boolean   excludewatchlists := false    : stored('ExcludeWatchLists');
unsigned1 OFACVersion       := 1        : stored('OFACVersion');
boolean   IncludeOfac       := false    : stored('IncludeOfac');
real      gwThreshold       := 0.84     : stored('GlobalWatchlistThreshold');
boolean   addtl_watchlists  := false    : stored('IncludeAdditionalWatchLists');
boolean   usedobfilter       := false    : stored('UseDOBfilter');
integer2  dobradius0         := 2       : stored('DOBRadius');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

//
boolean   isStudent := false			: stored('isStudent');

dobradius := if(usedobfilter,dobradius0,-1);
gateways := Gateway.Configuration.Get();

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED ('LexIdSourceOptout');
string TransactionID := '' : stored ('_TransactionId');
string BatchUID := '' : stored('_BatchUID');
unsigned6 GlobalCompanyId := 0 : stored('_GCID');

if( OFACVersion = 4 and not exists(gateways(servicename = 'bridgerwlc')) , fail(Risk_Indicators.iid_constants.OFAC4_NoGateway));

// constants
	suppressNearDups := true;
	require2Ele      := false;
	from_biid        := false;
	isFCRA           := false;
	from_IT1O        := false;
//


r := RECORD
	unsigned4 seq;
END;
d := dataset([{0}],r);

risk_indicators.Layout_Input into(d l, integer C) := TRANSFORM
	clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);	
		
	ssn_val := socs_value;
	hphone_val := riskwise.cleanphone(hphone_value);	
	wphone_val := riskwise.cleanphone(wphone_value); 	
	dob_val := riskwise.cleandob(dob_value); 	
	dl_num_clean := riskwise.cleanDL_num(drlc_value);

	self.seq := C;
	
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if (age_value = 0 and (integer)dob_val != 0, (string3)ut.Age((integer)dob_val), (string3)age_value);
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	self.fname := STD.Str.touppercase(first_value);
	self.mname := STD.Str.touppercase(middle_value);
	self.lname := STD.Str.touppercase(last_value);
	self.suffix := STD.Str.touppercase(suffix_value);
	
	self.in_streetAddress := addr_value;
	self.in_city := city_value;
	self.in_state := state_value;
	self.in_zipCode := zip_value;
	self.in_country := country_value;
	
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..64];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := IF(clean_a2[117..121]<>'', clean_a2[117..121], zip_value[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a2[122..125]<>'', clean_a2[122..125], zip_value[6..9]);		// use the input zip if cass zip is empty
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];	
	
	self.country := country_value;
	
	self.dl_number := STD.Str.touppercase(dl_num_clean);
	self.dl_state := STD.Str.touppercase(drlcstate_value);
	
	self.email_address := email_value;
	self.ip_address := ip_value;
	
	self.employer_name := STD.Str.touppercase(cmpy_value);
	self.lname_prev := STD.Str.touppercase(formerlast_value);
	self.historydate := history_date;
end;
prep := PROJECT(d,into(left,counter));


iid := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, Doxie.Compliance.isUtilityRestricted(industry_class_value), ln_branded_value, ofac_only,
	suppressNearDups, require2Ele, from_biid, isFCRA, excludewatchlists, from_IT1O, OFACVersion, IncludeOfac, addtl_watchlists, gwThreshold, dobradius,
	in_DataRestriction := DataRestriction, in_DataPermission := DataPermission,
    LexIdSourceOptout := LexIdSourceOptout, 
    TransactionID := TransactionID, 
    BatchUID := BatchUID, 
    GlobalCompanyID := GlobalCompanyID
);//check parameters here

clam := risk_indicators.Boca_Shell_Function(iid, gateways, DPPA_Purpose, GLB_Purpose, Doxie.Compliance.isUtilityRestricted(industry_class_value), ln_branded_value, false, false, true, true,
DataRestriction := DataRestriction, DataPermission := DataPermission,
LexIdSourceOptout := LexIdSourceOptout, 
TransactionID := TransactionID, 
BatchUID := BatchUID, 
GlobalCompanyID := GlobalCompanyID);// set some to false?

ret := Models.FD9607_1_0(clam, ofacSearching, isStudent, addtl_watchlists);



models.Layout_Reason_Codes form_rc(ret le) :=
TRANSFORM
	self.reason_code := if(le.ri[1].hri <> '00', le.ri[1].hri, '');
	self.reason_description := le.ri[1].desc;
end;
models.Layout_Reason_Codes form_rc2(ret le) :=
TRANSFORM
	self.reason_code := if(le.ri[2].hri <> '00', le.ri[2].hri, '');
	self.reason_description := le.ri[2].desc;
end;
models.Layout_Reason_Codes form_rc3(ret le) :=
TRANSFORM
	self.reason_code := if(le.ri[3].hri <> '00', le.ri[3].hri, '');
	self.reason_description := le.ri[3].desc;
end;
models.Layout_Reason_Codes form_rc4(ret le) :=
TRANSFORM
	self.reason_code := if(le.ri[4].hri <> '00', le.ri[4].hri, '');
	self.reason_description := le.ri[4].desc;
end;


models.Layout_Score form_cscore(ret le) :=
TRANSFORM
	self.i := le.score[1..3];
	self.description := '0 to 999';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;
models.Layout_Score form_cscore2(ret le) :=
TRANSFORM
	self.i := le.score[4..6];
	self.description := '10 to 50';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;
models.Layout_Score form_cscore3(ret le) :=
TRANSFORM
	self.i := le.score[7..9];
	self.description := '10 to 90';
	reason_codes := PROJECT(le,form_rc(LEFT)) + PROJECT(le,form_rc2(LEFT)) + PROJECT(le,form_rc3(LEFT)) + PROJECT(le,form_rc4(LEFT));
	risk_indicators.MAC_add_sequence(reason_codes(reason_code<>''), reason_codes_with_seq);
	self.reason_codes := reason_codes_with_seq;
END;


Models.Layout_Model form_model(ret le) :=
TRANSFORM
	self.accountnumber := account_value;
	self.description := 'StudentDefender';
	self.scores := PROJECT(le, form_cscore(LEFT)) + PROJECT(le,form_cscore2(LEFT)) + PROJECT(le, form_cscore3(LEFT));
END;
final := project(ret, form_model(LEFT));


OUTPUT(final,NAMED('Results'));

ENDMACRO;
// Models.StudentAdvisor_Service()