/*--SOAP--
<message name="RiskView_Derogs_Report" wuTimeout="300000">
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
	<part name="gateways" type="tns:XmlDataSet" cols="70" rows="10"/>
	<part name="DataPermissionMask" type="xsd:string"/>
</message>
*/
/*--INFO-- This service calls neutral roxie to get DID, then uses the DID to search bankruptcy and liens data. */
IMPORT riskwisefcra, Risk_Indicators, doxie, address, ut, gateway;

export RiskView_Derogs_Report_Batch := MACRO
string50 DataPermission := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
gateways := Gateway.Configuration.Get();
gateway_check := gateways (servicename IN riskwisefcra.Neutral_Service_Name)[1].url;
string neutral_ip := IF (gateway_check='', ERROR (301, doxie.ErrorCodes(301)), gateway_check);

batchin := dataset([],risk_indicators.Layout_Batch_In) 	: stored('batch_in',few);

// add sequence to matchup later to add acctno to output
Risk_Indicators.Layout_Batch_In into_seq(batchin le, integer C) := TRANSFORM
	self.seq := C;
	self := le;
END;
batchinseq := project(batchin, into_seq(left,counter));

Risk_Indicators.Layout_Input into_in(batchinseq le) := TRANSFORM
	// clean up input
	ssn_val := le.ssn;
	hphone_val := le.home_phone;
	wphone_val := le.work_phone;
	dob_val := le.dob;
	dl_num_clean := le.dl_number;

	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.age := if ((integer)le.age = 0 and (integer)le.dob != 0, (string3)ut.Age((integer)le.dob), (le.age));
	
	self.phone10 := hphone_val;
	self.wphone10 := wphone_val;
	
	cleaned_name := address.CleanPerson73(le.UnParsedFullName);
	boolean valid_cleaned := le.UnParsedFullName <> '';
	
	self.fname := stringlib.stringtouppercase(if(le.Name_First='' AND valid_cleaned, cleaned_name[6..25], le.Name_First));
	self.lname := stringlib.stringtouppercase(if(le.Name_Last='' AND valid_cleaned, cleaned_name[46..65], le.Name_Last));
	self.mname := stringlib.stringtouppercase(if(le.Name_Middle='' AND valid_cleaned, cleaned_name[26..45], le.Name_Middle));
	self.suffix := stringlib.stringtouppercase(if(le.Name_Suffix ='' AND valid_cleaned, cleaned_name[66..70], le.Name_Suffix));	
	self.title := stringlib.stringtouppercase(if(valid_cleaned, cleaned_name[1..5],''));

	street_address := risk_indicators.MOD_AddressClean.street_address(le.street_addr, le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
	clean_a2 := risk_indicators.MOD_AddressClean.clean_addr( street_address, le.p_City_name, le.St, le.Z5 ) ;											

	SELF.in_streetAddress := street_address;
	SELF.in_city := le.p_City_name;
	SELF.in_state := le.St;
	SELF.in_zipCode := le.Z5;
		
	self.prim_range := clean_a2[1..10];
	self.predir := clean_a2[11..12];
	self.prim_name := clean_a2[13..40];
	self.addr_suffix := clean_a2[41..44];
	self.postdir := clean_a2[45..46];
	self.unit_desig := clean_a2[47..56];
	self.sec_range := clean_a2[57..65];
	self.p_city_name := clean_a2[90..114];
	self.st := clean_a2[115..116];
	self.z5 := clean_a2[117..121];
	self.zip4 := clean_a2[122..125];
	self.lat := clean_a2[146..155];
	self.long := clean_a2[156..166];
	self.addr_type := clean_a2[139];
	self.addr_status := clean_a2[179..182];
	self.county := clean_a2[143..145];
	self.geo_blk := clean_a2[171..177];
	
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.dl_state);
	
	self := [];
END;

	bsprep := PROJECT(batchinseq, into_in(left));
	// output(bsprep, named('bsprep'));

	shell := FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (bsprep, gateways, 1, 1, DataPermission:=DataPermission);
	// output(shell, named('shell'));

ret := fcra.RiskView_Derogs_Function(shell);

batch_w_acctno := record
	string30 acctno;
	fcra.RiskView_Derogs_Module.batch_layout;
end;

summary_results := join(batchinseq, ret, left.seq=right.seq, 
			transform(batch_w_acctno, self.acctno := left.acctno, self := right));
			
output(summary_results, named('Results'));

ENDMACRO;

// FCRA.RiskView_Derogs_Report_Batch();