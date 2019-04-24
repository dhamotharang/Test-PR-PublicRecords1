/*--SOAP--
<message name="Internal Flags Process">
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
	<part name="wphone" type="xsd:string"/>
	<part name="drlc" type="xsd:string"/>
	<part name="drlcstate" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
 </message>
*/
/*--INFO-- FLGO processes */

import address, risk_indicators, ut, gateway;

export RiskWiseMainFLGO := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);

/* Force layout of WsECL page */
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
	'wphone',
	'drlc',
	'drlcstate',
	'DataRestrictionMask',
	'DataPermissionMask',
	'DPPAPurpose',
	'GLBPurpose', 
	'HistoryDateYYYYMM'));

string4  tribCode_value := ''  : stored('tribcode');
string30 account_value := ''   : stored('account');
string20 first_value := ''     : stored('first');
string20 last_value := ''      : stored('last');
string50 addr_value := ''      : stored('addr');
string25 city_value := ''      : stored('city');
string2  state_value := ''     : stored('state');
string5  zip_value := ''       : stored('zip');
string10 hphone_value := ''    : stored('hphone');
string9  socs_value := ''	 : stored('socs');
string8  dob_value := ''		 : stored('dob');
string10 wphone_value := ''	 : stored('wphone');
string20 drlc_value := ''	 : stored('drlc');
string2  drlcstate_value := '' : stored('drlcstate'); 
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string10 DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 DPPA_Purpose := RiskWise.permittedUse.fraudDPPA 	: stored('DPPAPurpose');
unsigned1 GLB_Purpose := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
STRING5   industry_class_val := '' 					: STORED('IndustryClass');
industry_class_value := StringLib.StringToUpperCase(industry_class_val);
boolean   ln_branded_value := false 					: STORED('LnBranded');
unsigned3 history_date := 999999 						: stored('HistoryDateYYYYMM');
boolean   ofac_only := true				 			: stored('OfacOnly');
gateways := Gateway.Constants.void_gateway;

tribcode := StringLib.StringToLowerCase(tribCode_value);

r := record
	unsigned seq;
end;

t := dataset([{0}], r);

risk_indicators.layout_input into(t le, INTEGER C) := TRANSFORM
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, city_value, state_value, zip_value);
	
	ssn_val := RiskWise.cleanSSN( socs_value );
	hphone_val := RiskWise.cleanPhone( hphone_value );
	wphone_val := RiskWise.cleanPhone( wphone_value );
	dob_val := RiskWise.cleanDOB( dob_value );
	dl_num_clean := RiskWise.cleanDL_num( drlc_value );

	self.seq := C;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	self.fname := stringlib.stringtouppercase(first_value);
	self.mname := '';
	self.lname := stringlib.stringtouppercase(last_value);
	SELF.in_streetAddress := stringlib.stringtouppercase(addr_value);
	SELF.in_city := stringlib.stringtouppercase(city_value);
	SELF.in_state := stringlib.stringtouppercase(state_value);
	SELF.in_zipCode := zip_value;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := IF(clean_a[117..121]<>'',clean_a[117..121],zip_value);		// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a[122..125]<>'', clean_a[122..125], '');
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	SELF.dl_number := stringlib.stringtouppercase(dl_num_clean);
	SELF.dl_state := stringlib.stringtouppercase(drlcstate_value);
	self.age := if ((integer)dob_val != 0, (STRING3)ut.GetAgeI((integer)dob_val), '');
	SELF.email_address := '';
	SELF.employer_name := '';
	SELF.lname_prev := '';
	self.historydate := history_date;
	self := [];
END;
prep := PROJECT(t,into(LEFT,COUNTER));


iid := risk_indicators.InstantID_Function(prep, gateways, DPPA_Purpose, GLB_Purpose, Doxie.Compliance.isUtilityRestricted(industry_class_value), ln_branded_value, 
					ofac_only, false,false,in_DataRestriction := DataRestriction,in_DataPermission := DataPermission);

RiskWise.Layout_FLGO format_out(iid le) := TRANSFORM					
	SELF.account := account_value;
	SELF.riskwiseid := '';
	SELF.hriskphoneflag := le.hriskphoneflag;
	SELF.phonevalflag := le.phonevalflag;
	SELF.phonezipflag := le.phonezipflag;
	SELF.hriskaddrflag := le.hriskaddrflag;
	SELF.decsflag := le.decsflag;
	SELF.socsdobflag := le.socsdobflag;
	self.socsvalflag := le.socsvalflag;
	self.drlcvalflag := if(le.drlcvalflag='3', '1', le.drlcvalflag);
	SELF.areacodesplitflag := map(
		le.phone10='' => '2',
		le.areacodesplitflag='Y' => '1',
		'');	
	SELF.addrvalflag := le.addrvalflag;
	SELF.dwelltypeflag := le.dwelltype;						
END;

Results := ungroup(PROJECT(iid, format_out(LEFT)));

emptyset := dataset([{account_value}], riskwise.Layout_FLGO);
ret := if(StringLib.StringToLowerCase(tribCode_value) in ['flg1'], Results, emptyset);

output(ret,NAMED('Results'));

ENDMACRO;

// RiskWise.RiskWiseMainFLGO()