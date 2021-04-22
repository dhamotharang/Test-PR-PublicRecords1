#workunit('name','NonFCRA-Chargeback Defender Score');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false);
import ut, risk_indicators, riskwise, models;

// *** IP Address logic is included ***


in_layout := record	
	string account;
	string first;
	string last;
	string addr;
	string city;
	string state;
	string zip;
	string hphone;
	string socs;
	string email;
	string first2;
	string last2;
	string addr2;
	string city2;
	string state2;
	string zip2;
	string hphone2;
	string ipaddr;
	string HistorydateYYYYMM;
end;

unsigned1 parallel_threads := 30;  //max number of parallel threads = 30

f := dataset('~jpyon::in::northern_1985_cb_consumer_in_in', In_Layout, csv(QUOTE('"')));
//f := choosen(dataset('~jpyon::in::northern_1985_cb_consumer_in_in', In_Layout, csv(QUOTE('"'))),5);

output(f);

Layout_Attributes_In := RECORD
	string name;
END;

layout_soap_in := record
	string account;
	string first;
	string last;
	string addr;
	string city;
	string state;
	string zip;
	string hphone;
	string socs;
	string email;
	string first2;
	string last2;
	string addr2;
	string city2;
	string state2;
	string zip2;
	string hphone2;
	string ipaddr;
	string HistoryDateYYYYMM;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	string DataRestrictionMask;
end;

paramsA := dataset([{'Version', 'cdn712_0'}], models.Layout_Parameters);

layout_soap_in to_soap( f le ) := TRANSFORM
	self.HistoryDateYYYYMM := le.historydateyyyymm; 
	self.dppapurpose := 3;
	self.glbpurpose := 1;
		
		self.scores := dataset([{'Models.ChargebackDefender_Service', '', paramsA}], models.Layout_Score_Chooser); 
  	self.gateways := riskwise.shortcuts.gw_netacuityv4;
		
		// 	self.DataRestrictionMask := '00000100';  // restricts experian from use, this is the default value for all legacy scoring products
		//  self.DataRestrictionMask := '00000001';  // to restrict Equifax from use
		self.DataRestrictionMask := '000000000000';  // to allow use everything
		
// <scores>
// <row>
// <name>Models.ChargebackDefender_Service</name>
// <parameters>
// <row><name>Version</name><value>cdn712_0</value></row>
// </parameters>
// </row>
// </scores>


    self := le;
	self := [];
end;

soap_in := project( f, to_soap(LEFT) );
output(soap_in, named('soap_in'));

ip := 'http://roxiethorvip.hpcc.risk.regn.net:9856'; // roxiebatch
svc:= 'Models.ChargebackDefender_Service';

layout_with_errcode := record
	string200 errorcode;
	Models.Layout_Chargeback_Out;
END;

layout_with_errcode myFail( soap_in le ) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	self := [];
END;

Layout_Chargeback := RECORD
	STRING30 account := '';
	STRING2  socsverlevel := '';
	STRING2  phoneverlevel := '';
	STRING20 correctlast := '';
	STRING10 correcthphone := '';
	STRING9  correctsocs := '';
	STRING50 correctaddr := '';
	STRING3  altareacode := '';
	STRING8  areacodesplitdate := '';
	STRING15 verfirst := '';
	STRING20 verlast := '';
	STRING50 veraddr := '';
	STRING30 vercity := '';
	STRING2  verstate := '';
	STRING5  verzip5 := '';
	STRING4  verzip4 := '';
	STRING10 nameaddrphone := '';
	STRING1  hphonetypeflag := '';
	STRING1  dwelltypeflag := '';
	STRING6  sic := '';
	
	STRING2  phoneverlevel2 := '';
	STRING20 correctlast2 := '';
	STRING10 correcthphone2 := '';
	STRING50 correctaddr2 := '';
	STRING3  altareacode2 := '';
	STRING8  areacodesplitdate2 := '';
	STRING15 verfirst2 := '';
	STRING20 verlast2 := '';
	STRING50 veraddr2 := '';
	STRING30 vercity2 := '';
	STRING2  verstate2 := '';
	STRING5  verzip52 := '';
	STRING4  verzip42 := '';
	STRING10 nameaddrphone2 := '';
	STRING1  hphonetypeflag2 := '';
	STRING1  dwelltypeflag2 := '';
	STRING6  sic2 := '';
	
	// score
	string3	 cb_score;
	string2  cb_reason1;
	string2  cb_reason2;
	string2  cb_reason3;
	string2  cb_reason4;
	string2  cb_reason5;
	string2  cb_reason6;
	
	string2  cb_reason7;
	string2  cb_reason8;
	string2  cb_reason9;
	string2  cb_reason10;
	string2  cb_reason11;
	string2  cb_reason12;
	
	string200 errorcode;
end;

soap_out1 := soapcall( soap_in, ip, svc, {soap_in}, dataset(layout_with_errcode), 
	retry(2), timeout(500), literal,
	 XPATH('Models.ChargebackDefender_ServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'), 
	 Parallel(parallel_threads),ONFAIL(myFail(LEFT))); 

output(soap_out1);



layout_chargeback flatten(soap_out1 le) := transform

	self.account := le.accountnumber;

	self.cb_score   := le.models.scores[1].i;
	bt_reasons := le.models.scores[1].riskindicatorsets(Name='BillTo');
	self.cb_reason1 := bt_reasons[1].reason_codes[1].reason_code;
	self.cb_reason2 := bt_reasons[1].reason_codes[2].reason_code;
	self.cb_reason3 := bt_reasons[1].reason_codes[3].reason_code;
	self.cb_reason4 := bt_reasons[1].reason_codes[4].reason_code;
	self.cb_reason5 := bt_reasons[1].reason_codes[5].reason_code;
	self.cb_reason6 := bt_reasons[1].reason_codes[6].reason_code;
	
	st_reasons := le.models.scores[1].riskindicatorsets(Name='ShipTo');
	self.cb_reason7 := st_reasons[1].reason_codes[1].reason_code;
	self.cb_reason8 := st_reasons[1].reason_codes[2].reason_code;
	self.cb_reason9 := st_reasons[1].reason_codes[3].reason_code;
	self.cb_reason10 := st_reasons[1].reason_codes[4].reason_code;
	self.cb_reason11 := st_reasons[1].reason_codes[5].reason_code;
	self.cb_reason12 := st_reasons[1].reason_codes[6].reason_code;
	
	self.errorcode := le.errorcode;
	self := le.chargeback;
	
end;

soap_out  := project(soap_out1,flatten(left));

output(soap_out,named('output'));
output(soap_out(errorcode = ''),,'~jpyon::out::northern_1985_cb_out',CSV(heading(single), quote('"')), overwrite);
output(soap_out(errorcode != ''),,'~jpyon::out::northern_1985_cb_out_err',CSV(heading(single), quote('"')), overwrite);

output(choosen(soap_out(errorcode<>''), 5), named('errors'));
