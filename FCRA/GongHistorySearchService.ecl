/*--SOAP--
<message name="FcraGongHistorySearchService">
	<part name="AccountNumber" type="xsd:string"/>
  <part name="ADL" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="PrimRange" type="xsd:string"/>
	<part name="PreDir" type="xsd:string"/>
	<part name="PrimName" type="xsd:string"/>
	<part name="PostDir" type="xsd:string"/>
	<part name="AddrSuffix" type="xsd:string"/>
	<part name="UnitDesignation" type="xsd:string"/>
	<part name="SecRange" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DOB" type="xsd:unsignedInt"/>
	<part name="Phone" type="xsd:string"/> 
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="gateways" type="tns:XmlDataSet" cols="110" rows="4"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	</message>
*/
/*--INFO-- This service searches the FCRA gong history file by ADL(either input or found) */

import risk_indicators, riskwisefcra, doxie, address, gong, riskwise, ut, gateway;

export GongHistorySearchService := MACRO

string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways_in := Gateway.Configuration.Get();

Gateway.Layouts.Config gw_switch(gateways_in le) := TRANSFORM
	SELF.servicename := le.servicename;
	SELF.url := IF(le.servicename IN ['targus'], '', le.url); // Don't allow Targus Gateway
	SELf := le;
END;
gateways := PROJECT(gateways_in, gw_switch(LEFT));

gateway_check := gateways (servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
string neutral_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);


Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')
string30  account_value := '' 					: stored('AccountNumber');
string65  addr_value := ''    					: stored('Addr');
string28  PrimName_value := ''					: stored('PrimName');
string10  PrimRange_value := ''					: stored('PrimRange');
string8   SecRange_value := ''					: stored('SecRange');
string2   PostDir_value := ''						: stored('PostDir');
string4   AddrSuffix_value := '' 				: stored('StreetSuffix');
string10  UnitDesig_value := '' 				: stored('UnitDesignation');
string2   PreDir_value := ''						: stored('PreDir');
string25  city_value := ''     					: stored('City');
string2   state_value := ''     				: stored('State');
string5   zip_val := ''      						: stored('Zip');
string9   ssn_value := ''      					: stored('SSN');
string8   dob_val := ''      						: stored('DOB');
string10  phone_val := ''   						: stored('Phone');
boolean   Test_Data_Enabled := false   	: stored('TestDataEnabled');
string20  Test_Data_Table_Name := ''   	: stored('TestDataTableName');
unsigned6 adl_value := 0								: stored('ADL');
unsigned3 history_date := 999999;


r := RECORD
	unsigned6 seq;
END;
d := dataset([{(unsigned)account_value}],r);


Risk_Indicators.Layout_Input into(d l) := TRANSFORM
	self.seq := l.seq;			
	self.title := stringlib.stringtouppercase(title_val);
	self.fname := stringlib.stringtouppercase(fname_val);
	self.mname := stringlib.stringtouppercase(mname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	self.suffix := stringlib.stringtouppercase(suffix_val);  
	
	street_address := risk_indicators.MOD_AddressClean.street_address(addr_value, PrimRange_value, Predir_value, PrimName_value,
																																		AddrSuffix_value, Postdir_value, UnitDesig_value, SecRange_value); 
	clean_address := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_value, state_value, zip_val ) ;	
	
	self.in_streetAddress := if(addr_value='', Risk_Indicators.MOD_AddressClean.street_address('',PrimRange_value, predir_value,	primname_value, '', postdir_value, '', secrange_value), addr_value);
	self.in_city := city_value;
	self.in_state := state_value;
	self.in_zipCode := zip_val;
	
	self.prim_range := clean_address[1..10];
	self.predir := clean_address[11..12];
	self.prim_name := clean_address[13..40];
	self.addr_suffix := clean_address[41..44];
	self.postdir := clean_address[45..46];
	self.unit_desig := clean_address[47..56];
	self.sec_range := clean_address[57..64];
	self.p_city_name := clean_address[90..114];
	self.st := clean_address[115..116];
	self.z5 := clean_address[117..121];
	self.zip4 := clean_address[122..125];
	self.lat := clean_address[146..155];
	self.long := clean_address[156..166];
	self.addr_type := clean_address[139];
	self.addr_status := clean_address[179..182];
	self.county := clean_address[143..145];
	self.geo_blk := clean_address[171..177];
		
	self.ssn := ssn_value;
	self.dob := (string)dob_val;
	self.phone10 := phone_val;
			
	self := [];
END;
bsprep := PROJECT(d, into(left));


// call neutral to get the DID if not input
shell := FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (bsprep, gateways, 1, 1, DataPermission:=DataPermission);

ret := fcra.GongHistoryFunction(bsprep, shell, account_value, adl_value);


	// specifically for test data enabled transactions
Risk_Indicators.Layout_Input doTestInput(d l) := transform			
	// only set the necessary fields to search test seed record, don't cass input addr
	self.seq := l.seq;
	self.ssn := ssn_value;
	self.phone10 := phone_val;
	self.fname := stringlib.stringtouppercase(fname_val);
	self.lname := stringlib.stringtouppercase(lname_val);
	self.z5 := zip_val;
	self := [];
END;
testPrep := PROJECT(d, doTestInput(left));


ret_test_seed := FCRA.GongHistory_Testseed_Function(testPrep, Test_Data_Table_Name);

// choose either real data or test seed
ret_selected := if(Test_Data_Enabled, ret_test_seed, ret);



FCRA.GongHistoryLayouts.Layout_GongHistoryFCRAout fillGong(ret le) := transform
	self.gong := dataset([le.gong], FCRA.GongHistoryLayouts.Layout_fcragongslim);
	self.gongcount := 0;
	self := le;
end;
popGong := project(ret_selected, fillGong(left));



FCRA.GongHistoryLayouts.Layout_GongHistoryFCRAout rollflags(popGong le, popGong rt) := transform
	self.gong := le.gong + rt.gong; 
	self := rt;
end;
summary_results := rollup(popGong, true, rollflags(left, right));


// calculate gong count, not on actual output to customer
FCRA.GongHistoryLayouts.Layout_GongHistoryFCRAout getCount(summary_results le) := transform
	self.account_number := account_value;
	self.gongcount := count(le.gong);
	self := le;
end;
final := project(summary_results, getCount(left));

output(final, named('Results'));

ENDMACRO;
// FCRA.GongHistorySearchService()