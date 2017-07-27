/*--SOAP--
<message name="RiskView_Derogs_Report" wuTimeout="300000">
	<part name="AccountNumber" type="xsd:string"/>
	<part name="UnParsedFullName" type="xsd:string"/>
	<part name="FirstName" type="xsd:string"/>
	<part name="MiddleName" type="xsd:string"/>
	<part name="LastName" type="xsd:string"/>
	<part name="NameSuffix" type="xsd:string"/>
	<part name="Addr" type="xsd:string"/>
	<part name="City" type="xsd:string"/>
	<part name="State" type="xsd:string"/>
	<part name="Zip" type="xsd:string"/>
	<part name="SSN" type="xsd:string"/>
	<part name="DOB" type="xsd:unsignedInt"/>
	<part name="Phone" type="xsd:string"/>
	<part name="TestDataEnabled" type="xsd:boolean"/>
	<part name="TestDataTableName" type="xsd:string"/>
	<part name="HistoryDateYYYYMMDD" type="xsd:integer"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="DataPermissionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service calls neutral roxie to get DID, then uses the DID to search bankruptcy and liens data. */
IMPORT riskwisefcra, Risk_Indicators, doxie, ut, gateway;

export RiskView_Derogs_Report := MACRO
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways := Gateway.Configuration.Get();
gateway_check := gateways (servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
string neutral_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);

	string30  account_value := '' 	: stored('AccountNumber');
	Risk_indicators.MAC_unparsedfullname(title_val,fname_val,mname_val,lname_val,suffix_val,'FirstName','MiddleName','LastName','NameSuffix')
	
	string120 unparsed_fullname_val_echo :='':stored('UnParsedFullName');
	string30 fname_val_echo := '' : stored('FirstName');
	string30 mname_val_echo := '' : stored('MiddleName');
	string30 lname_val_echo := '' : stored('LastName');
	string5 suffix_val_echo :='' : stored('NameSuffix');
	
	string120 addr_value := ''    	: stored('Addr');
	string25  city_value := ''     	: stored('City');
	string2   state_value := ''     : stored('State');
	string5   zip_val := ''      	: stored('Zip');
	string9   ssn_value := ''      	: stored('SSN');
	string8   dob_val := ''      	: stored('DOB');
	string10  phone_val := ''   	: stored('Phone');
	unsigned4 history_date := 99999999  : stored('HistoryDateYYYYMMDD');
	boolean   Test_Data_Enabled := false   	: stored('TestDataEnabled');
	string20  Test_Data_Table_Name := ''   	: stored('TestDataTableName');

	Risk_Indicators.Layout_Input into() := TRANSFORM
		self.seq := (unsigned)account_value;			
		self.title := stringlib.stringtouppercase(title_val);
		self.fname := stringlib.stringtouppercase(fname_val);
		self.mname := stringlib.stringtouppercase(mname_val);
		self.lname := stringlib.stringtouppercase(lname_val);
		self.suffix := stringlib.stringtouppercase(suffix_val);  
		
		self.in_streetAddress := addr_value;
		self.in_city := city_value;
		self.in_state := state_value;
		self.in_zipCode := zip_val;
		
		street_address := risk_indicators.MOD_AddressClean.street_address(addr_value); 
		clean_address := risk_indicators.MOD_AddressClean.clean_addr( street_address, city_value, state_value, zip_val ) ;	
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
	bsprep := DATASET ([into()]);
	// output(bsprep, named('bsprep'));

	shell := FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (bsprep, gateways, 1, 1, DataPermission:=DataPermission);
	// output(shell, named('shell'));

ret := fcra.RiskView_Derogs_Function(shell, history_date);


	// specifically for test data enabled transactions
Risk_Indicators.Layout_Input doTestInput() := transform			
		// only set the necessary fields to search test seed record, don't cass input addr
		self.seq := (unsigned)account_value;
		self.ssn := ssn_value;
		self.phone10 := phone_val;
		self.fname := stringlib.stringtouppercase(fname_val);
		self.lname := stringlib.stringtouppercase(lname_val);
		self.z5 := zip_val;
		self := [];
	END;
	testPrep := DATASET ([doTestInput()]);
	// output(testPrep, named('testPrep'));
	

	ret_test_seed := FCRA.RiskView_Derogs_Testseed_Function(testPrep, Test_Data_Table_Name);
	// output(ret_test_seed);


ret_selected := if(Test_Data_Enabled, ret_test_seed, ret);

xml_prep := project(ret_selected, transform(fcra.RiskView_Derogs_Module.xml_layout, 
	self.accountnumber := account_value;
	self.unParsedFullName := unparsed_fullname_val_echo;
	self.firstname := fname_val_echo;
	self.middlename := mname_val_echo;
	self.lastname := lname_val_echo;
	self.namesuffix := suffix_val_echo;
	self.addr := addr_value;
	self.city := city_value;
	self.state := state_value;
	self.zip := zip_val;
	self.ssn := ssn_value;
	self.dob := dob_val;
	self.phone := phone_val;
					self.bankruptcy := dataset([left.bankruptcy], fcra.RiskView_Derogs_Module.bk_final),
					self.liens := dataset([left.liens], fcra.RiskView_Derogs_Module.lien_final),
					self := left));
// output(xml_prep, named('xml_prep'));

gs := group(sort(xml_prep , seq), seq);
fcra.RiskView_Derogs_Module.xml_layout rollflags(fcra.RiskView_Derogs_Module.xml_layout le, fcra.RiskView_Derogs_Module.xml_layout rt) := transform
	self.bankrupt:= if(le.bankrupt='Y' or rt.bankrupt='Y', 'Y', 'N');
	self.federal_tax_lien := if(le.federal_tax_lien='Y' or rt.federal_tax_lien='Y', 'Y', 'N');
	self.federal_tax_amount := if(le.federal_tax_amount<>'' or rt.federal_tax_amount<>'', (string)(integer)( (real)le.federal_tax_amount + (real)rt.federal_tax_amount), fcra.RiskView_Derogs_Module.default_amount);
	self.state_tax_lien := if(le.state_tax_lien='Y' or rt.state_tax_lien='Y', 'Y', 'N');
	self.state_tax_amount := if(le.state_tax_amount<>'' or rt.state_tax_amount<>'', (string)(integer)( (real)le.state_tax_amount + (real)rt.state_tax_amount), fcra.RiskView_Derogs_Module.default_amount);
	
	self.county_tax_lien := if(le.county_tax_lien='Y' or rt.county_tax_lien='Y', 'Y', 'N');
	self.county_tax_amount := if(le.county_tax_amount<>'' or rt.county_tax_amount<>'', (string)(integer)( (real)le.county_tax_amount + (real)rt.county_tax_amount), fcra.RiskView_Derogs_Module.default_amount);

	self.child_support := if(le.child_support='Y' or rt.child_support='Y', 'Y', 'N');
	self.child_support_amount := if(le.child_support_amount<>'' or rt.child_support_amount<>'', (string)(integer)( (real)le.child_support_amount + (real)rt.child_support_amount), fcra.RiskView_Derogs_Module.default_amount);
	
	self.bankruptcy := choosen( (le.bankruptcy + rt.bankruptcy)(seq_number<>''), fcra.RiskView_Derogs_Module.max_bk_count);  // filter out any that are blank records
	self.liens := choosen((le.liens + rt.liens)(tmsid<>''), fcra.RiskView_Derogs_Module.max_lien_count); // filter out any that are blank records
	self := rt;
end;

summary_results := rollup(gs, true, rollflags(left, right));
output(summary_results, named('Results'));


ENDMACRO;
// fcra.RiskView_Derogs_Report();