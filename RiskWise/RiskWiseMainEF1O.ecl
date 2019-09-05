/*--SOAP--
<message name="eFunds Process">
	<part name="tribcode" type="xsd:string"/>
	<part name="account" type="xsd:string"/>
	<part name="first" type="xsd:string"/>
	<part name="last" type="xsd:string"/>
	<part name="addr" type="xsd:string"/>
	<part name="city" type="xsd:string"/>
	<part name="state" type="xsd:string"/>
	<part name="zip" type="xsd:string"/>
	<part name="hphone" type="xsd:string"/>
	<part name="socs" type="xsd:string"/>
	<part name="dob" type="xsd:string"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
 </message>
*/
/*--INFO-- Migrating ef01 to boca.  */
IMPORT risk_indicators, ut, seed_files, gateway, STD, Riskwise;

export RiskwiseMainEF1O := macro

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

#WEBSERVICE(FIELDS(
	'tribcode',
	'account',
	'first',
	'last',
	'addr',
	'city',
	'state',
	'zip',
	'hphone',
	'socs',
	'dob',
	'runSeed',
	'DPPAPurpose',
	'GLBPurpose', 
	'HistoryDateYYYYMM',
	'DataRestrictionMask',
	'DataPermissionMask',
    'LexIdSourceOptout',
    '_TransactionId',
    '_BatchUID',
    '_GCID'));

string4  tribcode_value := '' : stored('tribcode');
string30 account_value := '' : stored('account');
string15 first_value := '' : stored('first');
string20 last_value := '' : stored('last');
string50 addr_value := '' : stored('addr');
string30 city_value := '' : stored('city');
string2  state_value := '' : stored('state');
string9  zip_value := '' : stored('zip');
string10 hphone_value := '' : stored('hphone');
string9  socs_value := '' : stored('socs');
string8  dob_value := '' : stored('dob');
boolean  runSeed_value := false : stored('runSeed');
gateways := Gateway.Constants.void_gateway;

unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');

string50 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');

//CCPA fields
unsigned1 LexIdSourceOptout := 1 : STORED('LexIdSourceOptout');
string TransactionID := '' : STORED('_TransactionId');
string BatchUID := '' : STORED('_BatchUID');
unsigned6 GlobalCompanyId := 0 : STORED('_GCID');

boolean isUtility := false;
boolean ln_branded := false;
boolean ofac_only := true;
boolean suppressNearDups := true;
boolean require2Ele := true;

input_layout := record
	unsigned4 seq := 0;
	unsigned6 did := 0;
	string4 tribcode := '';
	string30 in_account := '';
     string15 in_first := '';
     string20 in_last := '';
     string50 in_addr := '';
     string30 in_city := '';
     string2 in_state := '';
     string5 in_zip := '';
	string10 in_hphone := '';
	string9 in_socs := '';
     string8 in_dob := '';
end;
d := dataset([{0}], input_layout);

input_layout addseq(d l, integer C) := transform
	self.seq := C;
	self.tribcode := STD.Str.ToLowerCase(tribCode_value);
	self.in_account := account_value;
	self.in_first := STD.Str.touppercase(first_value);
	self.in_last := STD.Str.touppercase(last_value);
	self.in_addr := STD.Str.touppercase(addr_value);
	self.in_city := STD.Str.touppercase(city_value);
	self.in_state := STD.Str.touppercase(state_value);
	self.in_zip := trim(zip_value);

	self.in_socs := RiskWise.cleanSSN( socs_value );
	self.in_hphone := RiskWise.cleanPhone( hphone_value );
	self.in_dob := RiskWise.cleanDOB( dob_value );


	self := [];
end;
indata := project(d, addseq(LEFT,COUNTER));

risk_indicators.layout_input into(indata le) := TRANSFORM	
	self.seq := le.seq;
	self.ssn := le.in_socs;
	self.dob := le.in_dob;
	self.age := if (le.in_dob!='',(STRING3)ut.Age((integer)le.in_dob), '');
	self.phone10 := le.in_hphone;
	self.fname := le.in_first;
	self.lname := le.in_last;
	SELF.in_streetAddress := le.in_addr;
	SELF.in_city := le.in_city;
	SELF.in_state := le.in_state;
	SELF.in_zipCode := le.in_zip;
	
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.in_addr, le.in_city, le.in_state, le.in_zip);
	
	
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := clean_a[117..121];	
	self.zip4 := clean_a[122..125];
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.historydate := history_date;
	self := [];
END;
prep := PROJECT(indata,into(LEFT));
													
iid_results := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, isUtility, ln_branded,  
			ofac_only, suppressNearDups, require2Ele,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission,
            LexIdSourceOptout := LexIdSourceOptout, 
            TransactionID := TransactionID, 
            BatchUID := BatchUID, 
            GlobalCompanyID := GlobalCompanyID);

xlayout := record
	string30 account := '';
     string32 riskwiseid := '';
     string1 socsverlevel := '';
end;

xlayout add_social_level(indata le, iid_results rt) := transform
	self.account := le.in_account;
	self.riskwiseid := (string)rt.did;
	
	ef01_socslevel :=  MAP(rt.socsverlevel in [9, 12] => '4',  // first, last, social
						rt.socsverlevel in [7, 11] => '3',  // last, social
						rt.socsverlevel in [4, 10] => '2',  // first, social
						rt.socsverlevel in [1] => '1',  // social only
						'0');
	self.socsverlevel := if(le.tribcode='ef01', ef01_socslevel, '');
end;

ret := join(indata, iid_results, left.seq=right.seq, add_social_level(left,right));

tribcode := STD.Str.ToLowerCase(tribCode_value);
seed_files.mac_query_seedfiles(socs_value, 'ef1o', 'ef1i', '001', seed_out);

xlayout format_seed(seed_out le) := transform
	self.account := account_value;
	self := le;
end;
final_seed := if(runSeed_value, project(seed_out, format_seed(left)), dataset([], xlayout));
	
final := if(tribcode in ['ef01'], 
		if(count(final_seed)>0 and runSeed_value, final_seed, ret),
		dataset([{'', account_value}], xlayout));

	   
output(final, named('Results'));

endmacro;
// RiskWise.RiskWiseMainEF1O()