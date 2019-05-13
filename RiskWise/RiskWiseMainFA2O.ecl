/*--SOAP--
<message name="Factual Data Custom SSN search process">
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
	<part name="DPPAPurpose" type="xsd:byte"/>
	<part name="GLBPurpose" type="xsd:byte"/> 
	<part name="ApplicationType" type="xsd:string"/>
	<part name="DataRestrictionMask" type="xsd:string"/>
	<part name="DataPermissionMask" type="xsd:string"/>
	<part name="HistoryDateYYYYMM" type="xsd:integer"/>
	<part name="runSeed" type="xsd:boolean"/>
	<part name="OutcomeTrackingOptOut" type="xsd:boolean"/>
 </message>
*/
/*--INFO-- Migrating fac1 and fac2 to boca.  */
import AutoStandardI, Risk_Indicators, ut, suppress, didville,
			 seed_files, gateway, Death_Master, dx_header;

export RiskWiseMainFA2O := MACRO

// Can't have duplicate definitions of Stored with different default values, 
// so add the default to #stored to eliminate the assignment of a default value.
#stored('GLBPurpose',RiskWise.permittedUse.fraudGLBA);
#stored('DataRestrictionMask',risk_indicators.iid_constants.default_DataRestriction);
#stored('DataPermissionMask',Risk_Indicators.iid_constants.default_DataPermission);

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
	'DPPAPurpose',
	'GLBPurpose', 
	'ApplicationType',
	'DataRestrictionMask',
	'DataPermissionMask',
	'HistoryDateYYYYMM',
	'runSeed',
	'OutcomeTrackingOptOut'));

/* **********************************************
   *  Fields needed for improved Scout Logging  *
   **********************************************/
	string32 _LoginID           := ''	: STORED('_LoginID');
	string20 CompanyID          := '' : STORED('_CompanyID');
	string20 FunctionName       := '' : STORED('_LogFunctionName');
	string50 ESPMethod          := '' : STORED('_ESPMethodName');
	string10 InterfaceVersion   := '' : STORED('_ESPClientInterfaceVersion');
	string6  ssnmask            := 'NONE' : STORED('SSNMask');
	string10 dobmask            := '' : STORED('DOBMask');
	string1 dlmask              := '' : STORED('DLMask');
	string5 DeliveryMethod      := '' : STORED('_DeliveryMethod');
	string5 DeathMasterPurpose  := '' : STORED('__deathmasterpurpose');
	string1 ExcludeDMVPII       := '' : STORED('ExcludeDMVPII');
	BOOLEAN DisableOutcomeTracking := FALSE : STORED('OutcomeTrackingOptOut');
	string1 ArchiveOptIn        := '' : STORED('instantidarchivingoptin');

	//Look up the industry by the company ID.
	Industry_Search := Inquiry_AccLogs.Key_Inquiry_industry_use_vertical_login(FALSE)(s_company_id = CompanyID and s_product_id = (String)Risk_Reporting.ProductID.RiskWise__RiskWiseMainFA2O);
/* ************* End Scout Fields **************/

string4  tribcode_value_in := '' : stored('tribcode');
string4  tribcode_value := StringLib.StringToLowerCase( tribcode_value_in );
string30 account_value := '' 	: stored('account');
string15 first_value := '' 	: stored('first');
string20 last_value := '' 	: stored('last');
string50 addr_value := '' 	: stored('addr');
string30 city_value := '' 	: stored('city');
string2  state_value := '' 	: stored('state');
string5  zip_value := '' 	: stored('zip');
string10 hphone_value := '' 	: stored('hphone');
string9  socs_value := '' 	: stored('socs');
string DataRestriction := risk_indicators.iid_constants.default_DataRestriction : stored('DataRestrictionMask');
string DataPermission  := Risk_Indicators.iid_constants.default_DataPermission : stored('DataPermissionMask');
unsigned1 dppa := RiskWise.permittedUse.fraudDPPA : stored('DPPAPurpose');
unsigned1 glb := RiskWise.permittedUse.fraudGLBA : stored('GLBPurpose');
unsigned3 history_date := 999999 : stored('HistoryDateYYYYMM');
boolean   runSeed_value := false : stored('runSeed');
appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

gateways := Gateway.Constants.void_gateway;
full_history_date := (STRING8)((STRING6)history_date+'01');
myGetDate := IF(history_date=999999,ut.GetDate,full_history_date);
myDaysApart(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= 365 OR (unsigned)d2 >= (unsigned)full_history_date;

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;
appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;

productSet := ['fac1', 'fac2'];
boolean Log_trib := tribcode_value in ['fac1'];

layout_input := record
	unsigned4 seq := 0;
	string4 tribcode := '';
	string30 in_account := '';
     string15 in_first := '';
     string20 in_last := '';
     string50 in_addr := '';
     string30 in_city := '';
     string2 in_state := '';
     string9 in_zip := '';
     string10 in_hphone := '';
     string9 in_socs := '';
end;

d := dataset([{0}],layout_input);

layout_input addseq(d l, integer C) := transform
	self.seq := C;
	self.tribcode := tribCode_value;
	self.in_account := account_value;
	self.in_first := stringlib.stringtouppercase(first_value);
	self.in_last := stringlib.stringtouppercase(last_value);
	self.in_addr := stringlib.stringtouppercase(addr_value);
	self.in_city := stringlib.stringtouppercase(city_value);
	self.in_state := stringlib.stringtouppercase(state_value);
	self.in_zip := zip_value;
	self.in_hphone := riskwise.cleanphone(hphone_value);
	self.in_socs := riskwise.cleanssn(socs_value);
end;
indata := project(d, addseq(LEFT,COUNTER));

//output(indata);

xlayout := record
	layout_input;
	riskwise.Layout_FA2O;
	unsigned6 did := 0;
	boolean 	ssnexists := false;
	STRING2 	src := '';
	boolean 	hdr_addr_isBest := false;
	string15	hdr_fname := '';
	string20  hdr_lname := '';
	STRING5   hdr_suffix := '';
	STRING50  hdr_cmpy := '';
	STRING10 hdr_prim_range :='';
	STRING2   hdr_predir :='';
	STRING28  hdr_prim_name :='';
	STRING4   hdr_addr_suffix :='';
	STRING2   hdr_postdir :='';
	string6 	hdr_unit_desig := '';
	STRING8   hdr_sec_range :='';
	string50	hdr_addr := '';
	STRING30 	hdr_city := '';
	STRING2 	hdr_state := '';
	STRING9 	hdr_zip := '';
	UNSIGNED3 hdr_date_first := 0;
	UNSIGNED3 hdr_date_last := 0;
	UNSIGNED3 hdr_date_last_reported := 0;
	STRING10 	hdr_phone := '';
	string15  hdr_current_fname := '';
	string20  hdr_current_lname := '';
	STRING15	hdr_former_first := '';
	STRING20	hdr_former_last := '';
	boolean coaalertflag := false;
	
	STRING10  best_prim_range :='';
  STRING2   best_predir :='';
  STRING28  best_prim_name :='';
  STRING4   best_addr_suffix :='';
  STRING2   best_postdir :='';
  STRING8   best_sec_range :='';
	STRING25  best_city := '';
	STRING2   best_state := '';
	string6	best_unit_desig := '';
	STRING5   best_zip := '';
	
	unsigned  gong_date_last_seen := 0;
   boolean   gong_current_flag := false;
	unsigned  gong_firstscore := 0;
	unsigned  gong_lastscore := 0;
	unsigned  gong_addrscore := 0;
	
	
END;

didville.Layout_Did_OutBatch fill_in_batch(indata le) := transform
	self.seq := le.seq;
	self.ssn := le.in_socs;
	self.phone10 := le.in_hphone;
	self.fname := le.in_first;
	self.lname := le.in_last;
	clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(le.in_addr, le.in_city, le.in_state, le.in_zip);	
	self.prim_range := clean_addr[1..10];
	self.predir := clean_addr[11..12];
	self.prim_name := clean_addr[13..40];
	self.addr_suffix := clean_addr[41..44];
	self.postdir := clean_addr[45..46];
	self.unit_desig := clean_addr[47..56];
	self.sec_range := clean_addr[57..64];
	self.p_city_name := clean_addr[90..114];
	self.st := clean_addr[115..116];
	self.z5 := clean_addr[117..121];
	self.zip4 := clean_addr[122..125];
	self := [];
end;
didprep := PROJECT(indata, fill_in_batch(left));

didville.MAC_DidAppend(didprep,did_results,true,'4GZ',false);

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(did_results, 
												appends, 
												verify, 
												thresh_num, 
												glb_ok, 
												best_data, 
												false,
												DataRestriction,
												,
												,
												,
												, 
												appType,
												,
												industryClass);

xlayout add_did(indata le, best_data rt) := transform
	self.did := rt.did;
	
	clean_best := Risk_Indicators.MOD_AddressClean.clean_addr(rt.best_Addr1, rt.best_city, rt.best_state, rt.best_zip+rt.best_zip4);
	
	self.best_prim_range := clean_best[1..10];
	self.best_predir := clean_best[11..12];
	self.best_prim_name := clean_best[13..40];
	self.best_addr_suffix := clean_best[41..44];
	self.best_postdir := clean_best[45..46];
	self.best_unit_desig := clean_best[47..56];
	self.best_sec_range := clean_best[57..64];
	self.best_city := clean_best[90..114];
	self.best_state := clean_best[115..116];
	self.best_zip := clean_best[117..121];
	
	self.billing := dataset([], risk_indicators.Layout_Billing);
	self := le;
end;

wDid := join(indata, best_data, left.seq=right.seq,
			add_did(left,right), left outer);

xlayout get_ssnTable(wDid le, risk_indicators.key_ssn_table_v4_2 rt) := transform
// determine which section of the table is permitted for use based on the data restriction mask
	header_version := map(DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse and
												DataRestriction[risk_indicators.iid_constants.posEquifaxRestriction]=risk_indicators.iid_constants.sFalse and
												DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse=> rt.combo,
												DataRestriction[risk_indicators.iid_constants.posExperianRestriction]=risk_indicators.iid_constants.sFalse => rt.en,
												DataRestriction[risk_indicators.iid_constants.posTransUnionRestriction]=risk_indicators.iid_constants.sFalse => rt.tn,
												rt.eq);  // default to the EQ version		
												
	pre_history := header_version.header_first_seen < history_date;

	self.ssnexists := rt.ssn<>'' and pre_history;
	self.did := IF(pre_history and header_version.bestCount=1 and le.did=0, header_version.bestDID, le.did);
	self.hdr_current_fname := header_version.lname1.fname;
	self.hdr_current_lname := header_version.lname1.lname;
	
	// Death flag will now be set in the next join to the SSN SSA file and so do not set here
	self.decsflag := '0';

	vssn := Risk_Indicators.Validate_SSN(le.in_socs,'');	
	self.socsvalflag := MAP(le.in_socs='' => '3',
					    vssn.invalid => '2',
					    (rt.ssn<>'' and pre_history and (~rt.isValidFormat OR ~rt.isSequenceValid)) or 
						vssn.begin_invalid or vssn.middle_invalid or vssn.last_invalid => '1',
						'0');
	SELF.soclstate := rt.issue_state;
	
	self.socllowissue := if(rt.official_first_seen=0, '', TRIM((STRING)rt.official_first_seen, left) + '00');
	self.soclhighissue := if(rt.official_last_seen=0, '', TRIM((STRING)rt.official_last_seen, left) + '00');
	self := le;
END;
got_SSNTable := join(wDid,risk_indicators.key_ssn_table_v4_2,
					keyed(left.in_socs=right.ssn) AND left.in_socs!='',		
					get_ssnTable(left,right),left outer, ATMOST(keyed(left.in_socs=right.ssn),RiskWise.max_atmost), keep(100));
//output(got_ssntable, named('got_ssntable'));

//*********************************Begin changes

deathSSNKey := Death_Master.key_ssn_ssa(false);

xlayout get_ssnDeath(got_SSNTable le, deathSSNKey rt) := transform
	
	ssnDeathHit 	:= trim(rt.ssn)<>'';
	pre_history 	:= (string)rt.dod8 < full_history_date;
	decsflag_temp := MAP((pre_history) 										=> '1',
												le.socsvalflag IN ['2','3']			=> '2',
																													 '0');

	self.decsflag := if(ssnDeathHit,decsflag_temp, le.decsflag);
	self.DOD 			:= if((ssnDeathHit) and decsflag_temp='1',rt.dod8, le.DOD);  // check only on ssn search, and make sure date is before history date				
	self 					:= le;
	self 					:= [];	
	
END;

got_SSNDeath := join (got_SSNTable, deathSSNKey,
                   left.in_socs!='' and keyed(left.in_socs=right.ssn) and
									 (((integer)right.DOD8 <> 0 and (string)right.DOD8 <= (string)full_history_date) or
									  ((integer)right.filedate <> 0 and (string)right.filedate <= (string)full_history_date)) and									 
									 right.src not in risk_indicators.iid_constants.masked_header_sources(DataRestriction, false) AND
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   get_ssnDeath(left,right),left outer, KEEP(10), ATMOST(keyed(left.in_socs=right.ssn),500));
//output(got_SSNDeath, named('got_SSNDeath'));

//*********************************End changes

index_wild_ssn := dx_header.key_wild_SSN();
xlayout get_wildcard_DID(xlayout le, index_wild_ssn rt) := transform
	self.did := if(le.did=0 and le.in_socs!='', rt.did, le.did);
	self := le;
end;

// if for some reason we don't have a DID by this point and there was a social on input, use the wildcard ssn key for allegis
allDIDs := join(got_SSNDeath, index_wild_ssn, left.did=0 and left.in_socs!='' and
						 keyed(right.s1=left.in_socs[1]) and keyed(right.s2=left.in_socs[2]) and keyed(right.s3=left.in_socs[3]) and 
						 keyed(right.s4=left.in_socs[4]) and keyed(right.s5=left.in_socs[5]) and keyed(right.s6=left.in_socs[6]) and 
						 keyed(right.s7=left.in_socs[7]) and keyed(right.s8=left.in_socs[8]) and keyed(right.s9=left.in_socs[9]), 
						 get_wildcard_DID(left,right), left outer,
						 ATMOST(
							keyed(right.s1=left.in_socs[1]) and keyed(right.s2=left.in_socs[2]) and keyed(right.s3=left.in_socs[3]) and 
							keyed(right.s4=left.in_socs[4]) and keyed(right.s5=left.in_socs[5]) and keyed(right.s6=left.in_socs[6]) and 
							keyed(right.s7=left.in_socs[7]) and keyed(right.s8=left.in_socs[8]) and keyed(right.s9=left.in_socs[9]), 
							RiskWise.max_atmost),
						 keep(100));
// output(alldids, named('alldids'));
						 
						 
// pick the lowest number DID
rolled_did := rollup(sort(allDIDs, seq, did), true, transform(xlayout, self:=left));
// output(rolled_did, named('rolled_did'));


e := record
	unsigned6 did := 0;
end;

eqfs := riskwise.getHeaderByDid(project(rolled_did, transform(e, self:=left)), DPPA, GLB, false, DataRestriction);

xlayout get_Header(xlayout le, eqfs rt) := TRANSFORM
	self.account := le.in_account;
	self.src := rt.src;		
	self.dob := if(rt.dob=0, '', (string)rt.dob);
	self.hdr_fname := rt.fname;
	self.hdr_lname := rt.lname;
	self.hdr_suffix := rt.name_suffix;
	self.hdr_prim_range := rt.prim_range;
	self.hdr_predir := rt.predir;
	self.hdr_prim_name := rt.prim_name;
	self.hdr_addr_suffix := rt.suffix;
	self.hdr_postdir := rt.postdir;
	self.hdr_unit_desig := rt.unit_desig;
	self.hdr_sec_range := rt.sec_range;
	self.hdr_addr := Risk_Indicators.MOD_AddressClean.street_address('',rt.prim_range,rt.predir,rt.prim_name,rt.suffix,rt.postdir,rt.unit_desig,rt.sec_range);
	self.hdr_city := rt.city_name;
	self.hdr_state := rt.st;
	self.hdr_zip := rt.zip;
	self.hdr_date_first := rt.dt_first_seen;
	self.hdr_date_last := if(rt.dt_last_seen=0, rt.dt_vendor_last_reported, rt.dt_last_seen);  // since we use the date last seen to sort by, make sure there is a date in that field for better historical accuracy
	self.hdr_date_last_reported := rt.dt_vendor_last_reported;
	self.billing := dataset([], risk_indicators.Layout_Billing);
	self := le;
end;

wHeader := join(rolled_did, eqfs, LEFT.did = RIGHT.s_did AND
							RIGHT.ssn = LEFT.in_socs AND
							RIGHT.src IN ['EQ','TU'] and
							(RIGHT.dt_first_seen < history_date),
		get_Header(LEFT,RIGHT), LEFT OUTER, many lookup);

sHeader := sort(wHeader, -hdr_date_last_reported, -hdr_date_last, -hdr_date_first);
// output(sHeader,NAMED('sHeader'));

// does this rollup only for the combination of records when date last reported and address are the same to get the person's former last name
xlayout fill_former_last(xlayout l, xlayout r) := TRANSFORM
	has_former_name := l.hdr_lname<>r.hdr_lname;
	self.hdr_fname := if(has_former_name, l.hdr_current_fname, l.hdr_fname);
	self.hdr_lname := if(has_former_name, l.hdr_current_lname, l.hdr_lname);
	self.hdr_former_first := if(has_former_name, if(l.hdr_current_fname=l.hdr_fname, r.hdr_fname, l.hdr_fname), '');
	self.hdr_former_last := if(has_former_name, if(l.hdr_current_lname=l.hdr_lname, r.hdr_lname, l.hdr_lname), '');
	SELF := l;
END;

dHeader := ROLLUP(sHeader, fill_former_last(LEFT, RIGHT), hdr_date_last_reported, hdr_zip, hdr_prim_range, hdr_prim_name, hdr_sec_range);
// output(dHeader, named('dHeader'));

s_with_former := SORT(dHeader, seq, hdr_zip, hdr_prim_range, hdr_prim_name, hdr_sec_range);
								

d_with_former := sort(DEDUP(s_with_former, seq, 
				risk_indicators.AddrScore.addressScore(left.hdr_prim_range, left.hdr_prim_name, left.hdr_sec_range,
									right.hdr_prim_range, right.hdr_prim_name, right.hdr_sec_range) between 80 and 100), seq, -hdr_date_last) ;
// output(d_with_former, named('d_with_former'));

xlayout fill_eqfs_addrs(xlayout le, integer urc) := transform	
	addr_score := Risk_Indicators.AddrScore.AddressScore(le.best_prim_range, le.best_prim_name, le.best_sec_range,
									le.hdr_prim_range, le.hdr_prim_name, le.hdr_sec_range);
									   	self.coaalertflag := IF(urc=1, if(addr_score<80,true,false), le.coaalertflag);  	//Set COA flag if best address is different from latest header address.
	self.coaaddr := if(self.coaalertflag, Risk_Indicators.MOD_AddressClean.street_address('',le.best_prim_range,le.best_predir,le.best_prim_name,
												le.best_addr_suffix,le.best_postdir,le.best_unit_desig,le.best_sec_range), le.coaaddr);
     self.coacity := if(self.coaalertflag, le.best_city, le.coacity);
     self.coastate := if(self.coaalertflag, le.best_state, le.coastate);
     self.coazip := if(self.coaalertflag, le.best_zip, le.coazip);
	
	self.first := if(urc=1, le.hdr_fname, le.first);
	self.last := if(urc=1, le.hdr_lname, le.last);
	self.addr := if(urc=1, le.hdr_addr, le.addr);
	self.city := if(urc=1, le.hdr_city, le.city);
	self.state := if(urc=1, le.hdr_state, le.state);
	self.zip := if(urc=1, le.hdr_zip, le.zip);
	self.formerfirst := if(urc=1, le.hdr_former_first, le.formerfirst);
	self.formerlast := if(urc=1, le.hdr_former_last, le.formerlast);
	
	self.first2 := if(urc=2, le.hdr_fname, le.first2);
	self.last2 := if(urc=2, le.hdr_lname, le.last2);
	self.addr2 := if(urc=2, le.hdr_addr, le.addr2);
	self.city2 := if(urc=2, le.hdr_city, le.city2);
	self.state2 := if(urc=2, le.hdr_state, le.state2);
	self.zip2 := if(urc=2, le.hdr_zip, le.zip2);
	self.formerfirst2 := if(urc=2, le.hdr_former_first, le.formerfirst2);
	self.formerlast2 := if(urc=2, le.hdr_former_last, le.formerlast2);
	
	self.first3 := if(urc=3, le.hdr_fname, le.first3);
	self.last3 := if(urc=3, le.hdr_lname, le.last3);
	self.addr3 := if(urc=3, le.hdr_addr, le.addr3);
	self.city3 := if(urc=3, le.hdr_city, le.city3);
	self.state3 := if(urc=3, le.hdr_state, le.state3);
	self.zip3 := if(urc=3, le.hdr_zip, le.zip3);
	self.formerfirst3 := if(urc=3, le.hdr_former_first, le.formerfirst3);
	self.formerlast3 := if(urc=3, le.hdr_former_last, le.formerlast3);
	
	self.first4 := if(urc=4, le.hdr_fname, le.first4);
	self.last4 := if(urc=4, le.hdr_lname, le.last4);
	self.addr4 := if(urc=4, le.hdr_addr, le.addr4);
	self.city4 := if(urc=4, le.hdr_city, le.city4);
	self.state4 := if(urc=4, le.hdr_state, le.state4);
	self.zip4 := if(urc=4, le.hdr_zip, le.zip4);
	self.formerfirst4 := if(urc=4, le.hdr_former_first, le.formerfirst4);
	self.formerlast4 := if(urc=4, le.hdr_former_last, le.formerlast4);
	
	self.first5 := if(urc=5, le.hdr_fname, le.first5);
	self.last5 := if(urc=5, le.hdr_lname, le.last5);
	self.addr5 := if(urc=5, le.hdr_addr, le.addr5);
	self.city5 := if(urc=5, le.hdr_city, le.city5);
	self.state5 := if(urc=5, le.hdr_state, le.state5);
	self.zip5 := if(urc=5, le.hdr_zip, le.zip5);
	self.formerfirst5 := if(urc=5, le.hdr_former_first, le.formerfirst5);
	self.formerlast5 := if(urc=5, le.hdr_former_last, le.formerlast5);
	
	self := le;
end;

chrono := project(d_with_former, fill_eqfs_addrs(left,counter)); 

xlayout roll_addrs(xlayout le, xlayout rt) := transform
	c1 := le.addr!='';
	self.first := if(c1, le.first, rt.first);
	self.last := if(c1, le.last, rt.last);
	self.addr := if(c1, le.addr, rt.addr);
	self.city := if(c1, le.city, rt.city);
	self.state := if(c1, le.state, rt.state);
	self.zip := if(c1, le.zip, rt.zip);	
	self.formerfirst := if(c1, le.formerfirst, rt.formerfirst);
	self.formerlast := if(c1, le.formerlast, rt.formerlast);
	
	c2 := le.addr2!='';
	self.first2 := if(c2, le.first2, rt.first2);
	self.last2 := if(c2, le.last2, rt.last2);
	self.addr2 := if(c2, le.addr2, rt.addr2);
	self.city2 := if(c2, le.city2, rt.city2);
	self.state2 := if(c2, le.state2, rt.state2);
	self.zip2 := if(c2, le.zip2, rt.zip2);	
	self.formerfirst2 := if(c2, le.formerfirst2, rt.formerfirst2);
	self.formerlast2 := if(c2, le.formerlast2, rt.formerlast2);	
	
	c3 := le.addr3!='';
	self.first3 := if(c3, le.first3, rt.first3);
	self.last3 := if(c3, le.last3, rt.last3);
	self.addr3 := if(c3, le.addr3, rt.addr3);
	self.city3 := if(c3, le.city3, rt.city3);
	self.state3 := if(c3, le.state3, rt.state3);
	self.zip3 := if(c3, le.zip3, rt.zip3);	
	self.formerfirst3 := if(c3, le.formerfirst3, rt.formerfirst3);
	self.formerlast3 := if(c3, le.formerlast3, rt.formerlast3);	
	
	c4 := le.addr4!='';
	self.first4 := if(c4, le.first4, rt.first4);
	self.last4 := if(c4, le.last4, rt.last4);
	self.addr4 := if(c4, le.addr4, rt.addr4);
	self.city4 := if(c4, le.city4, rt.city4);
	self.state4 := if(c4, le.state4, rt.state4);
	self.zip4 := if(c4, le.zip4, rt.zip4);	
	self.formerfirst4 := if(c4, le.formerfirst4, rt.formerfirst4);
	self.formerlast4 := if(c4, le.formerlast4, rt.formerlast4);	
	
	c5 := le.addr5!='';
	self.first5 := if(c5, le.first5, rt.first5);
	self.last5 := if(c5, le.last5, rt.last5);
	self.addr5 := if(c5, le.addr5, rt.addr5);
	self.city5 := if(c5, le.city5, rt.city5);
	self.state5 := if(c5, le.state5, rt.state5);
	self.zip5 := if(c5, le.zip5, rt.zip5);	
	self.formerfirst5 := if(c5, le.formerfirst5, rt.formerfirst5);
	self.formerlast5 := if(c5, le.formerlast5, rt.formerlast5);	
	
	self := le;
end;
	
rolled_Addrs := rollup(chrono,true,roll_addrs(left,right)); 
// output(rolled_addrs, named('rolled_addrs'));

//Search gong by most recent name and address found on header
Risk_Indicators.Layouts.Layout_Input_Plus_Overrides t_f(rolled_addrs le) := transform
	self.prim_range := le.hdr_prim_range;
	self.predir := le.hdr_predir;
	self.prim_name := le.hdr_prim_name;
	self.addr_suffix := le.hdr_addr_suffix;
	self.postdir := le.hdr_postdir;
	self.unit_desig := le.hdr_unit_desig;
	self.sec_range := le.hdr_sec_range;
	self.p_city_name := le.hdr_city;
	self.st := le.hdr_state;
	self.z5 := le.hdr_zip;
	self := [];
end;

dirs := riskwise.getDirsByAddr(project(rolled_addrs, t_f(left)));
// output(dirs, named('dirs'));

xlayout getPhone(xlayout le, dirs ri) := transform
	firstscore := Risk_Indicators.FnameScore(le.first, ri.name_first);
	lastscore := Risk_Indicators.LnameScore(le.last, ri.name_last);
	lastmatch := Risk_Indicators.g(lastscore);
     self.hphone := ri.phone10;
     self.gong_date_last_seen := (unsigned)ri.dt_last_seen;
     self.gong_current_flag := ri.current_flag;
     self.gong_firstscore := if(firstscore=255, 0, firstscore);
     self.gong_lastscore := if(lastscore=255, 0,lastscore);
     self.gong_addrscore := Risk_Indicators.AddrScore.AddressScore(le.hdr_prim_range, le.hdr_prim_name, le.hdr_sec_range,
									 ri.prim_range, ri.prim_name, ri.sec_range);
	self := le;
end;

dirs_added := join(rolled_addrs, dirs,
						left.hdr_prim_name=right.prim_name and left.hdr_state=right.st and left.hdr_zip=right.z5 and left.hdr_prim_range=right.prim_range and
				          ((unsigned)RIGHT.dt_first_seen < (unsigned)full_history_date and
						(RIGHT.current_flag OR myDaysApart(myGetDate,((STRING6)RIGHT.deletion_date[1..6]+'01')))),				          
						getPhone(left,right),
						left outer, many lookup, ATMOST(left.hdr_prim_name=right.prim_name and left.hdr_state=right.st and left.hdr_zip=right.z5 and left.hdr_prim_range=right.prim_range,RiskWise.max_atmost), keep(500));
	
gong_added := sort(dirs_added, seq, -gong_lastscore, -gong_firstscore, -gong_current_flag, -gong_date_last_seen);
// output(gong_added, named('gong_added'));


//Pick the best gong record
xlayout filter1(gong_added le, gong_added ri) := transform
	chooser1 := MAP(le.gong_current_flag=true and ri.gong_current_flag=false => false,
				 ri.gong_date_last_seen >= le.gong_date_last_seen and ri.gong_lastscore >= le.gong_lastscore AND ri.gong_firstscore >= le.gong_firstscore => true,
				 false);
	self := if(chooser1, ri, le);										
end;

rolled_phone := rollup(gong_added, true, filter1(left, right)); 
// output(rolled_phone, named('rolled_phone'));

final := project(rolled_phone, TRANSFORM(riskwise.Layout_FA2O, SELF:=LEFT));
// output(final, named('final'));

// remove output if on the following files
Suppress.MAC_Suppress(rolled_phone,out,appType,Suppress.Constants.LinkTypes.SSN,in_socs);
Suppress.MAC_Suppress(out,out2,appType,Suppress.Constants.LinkTypes.DID,did);

enough_input := if(socs_value!='' and (first_value!='' or last_value!='' or addr_value!='' or city_value!='' or state_value!='' or zip_value!='' or hphone_value!='' ), true, false);

emptyset := project(indata, transform(riskwise.Layout_FA2O, self.account := left.in_account, self := []));
ret := if(tribCode_value in productSet and count(out2)!=0 and enough_input, final, emptyset);

critter := case(tribcode_value,
	'fac1' => '001',
	'fac2' => '002',
	''
);

seed_files.mac_query_seedfiles(socs_value, 'fa2o', 'nafi', critter, fa2o_seed_output);

riskwise.Layout_FA2O format_seed(fa2o_seed_output le) := transform
	self.account := account_value;
	self := le;
	self := [];
end;
final_seed := if(runSeed_value, project(fa2o_seed_output, format_seed(left)), dataset([],RiskWise.Layout_FA2O) );

fa2o_final := map(
	tribcode_value not in productSet => dataset( [], RiskWise.Layout_FA2O ),
	count(final_seed) > 0 and runSeed_Value => final_seed,
	ret
);

//Log to Deltabase
Deltabase_Logging_prep := project(fa2o_final, transform(Risk_Reporting.Layouts.LOG_Deltabase_Layout_Record,
																								 self.company_id := (Integer)CompanyID,
																								 self.login_id := _LoginID,
																								 self.product_id := Risk_Reporting.ProductID.RiskWise__RiskWiseMainFA2O,
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
                                                 self.glb := glb,
                                                 self.dppa := dppa,
																								 self.data_restriction_mask := DataRestriction,
																								 self.data_permission_mask := DataPermission,
																								 self.industry := Industry_Search[1].Industry,
																								 self.i_ssn := socs_value,
																								 self.i_name_first := first_value,
																								 self.i_name_last := last_value,
																								 self.i_address := addr_value,
																								 self.i_city := city_value,
																								 self.i_state := state_value,
																								 self.i_zip := zip_value,
                                                 self.i_home_phone := hphone_value,
																								 self.o_lexid := (Integer)left.riskwiseid,  //did
																								 self := left,
																								 self := [] ));
Deltabase_Logging := DATASET([{Deltabase_Logging_prep}], Risk_Reporting.Layouts.LOG_Deltabase_Layout);
// #stored('Deltabase_Log', Deltabase_Logging);

//Improved Scout Logging
IF(~DisableOutcomeTracking and Log_trib and ~runSeed_value, OUTPUT(Deltabase_Logging, NAMED('LOG_log__mbs_transaction__log__scout')));

output(fa2o_final, named('Results'));

ENDMACRO;
// RiskWiseMainFA2O()
