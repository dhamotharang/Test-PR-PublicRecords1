import risk_indicators, Business_Header, doxie, suppress, gateway, RiskWise;

export CT1O_Function(dataset(RiskWise.Layout_CT1I) indata, dataset(Gateway.Layouts.Config) gateways, doxie.IDataAccess mod_access,
				 boolean isUtility=false) := function

// full_history_date := (STRING8)((STRING6)history_date+'01');
// myGetDate := IF(history_date=999999,ut.GetDate,full_history_date);
// myDaysApart(string8 d1, string8 d2) := ut.DaysApart(d1,d2) <= 365 OR (unsigned)d2 >= (unsigned)full_history_date;			 
min_addrscore := 80;
	
working_layout := record 
	unsigned3 historydate;
	string4 tribcode := '';
	STRING30  account := '';
	string30  acctno := '';
	UNSIGNED6 did := 0;
	UNSIGNED6 bdid := 0;
	UNSIGNED2 didscore := 0;
	UNSIGNED4 seq := 0;
	string10  phone10 :='';
	boolean   isPOTS := false;
	STRING20  gong_fname := '';
	STRING20  gong_mname := '';
	STRING20  gong_lname := '';
	STRING5   gong_suffix := '';
	STRING50  gong_cmpy := '';
	STRING210 gong_prim_range :='';
	STRING2   gong_predir :='';
	STRING28  gong_prim_name :='';
	STRING4   gong_addr_suffix :='';
	STRING2   gong_postdir :='';
	STRING8   gong_sec_range :='';
	STRING50  gong_addr := '';
	STRING25  gong_city := '';
	STRING2   gong_state := '';
	STRING5   gong_zip := '';
	STRING4   gong_zip4 := '';
	STRING8   gong_date_last_seen := '';
	BOOLEAN   gong_bus_flag := false;
	BOOLEAN   gong_current_flag := false;
	STRING1   hdr_tnt := '';
	UNSIGNED1 hdr_addrscore := 0;
	STRING20  hdr_fname := '';
	STRING20  hdr_mname := '';
	STRING20  hdr_lname := '';
	STRING5   hdr_suffix := '';
	STRING50  hdr_cmpy := '';
	STRING210 hdr_prim_range :='';
	STRING2   hdr_predir :='';
	STRING28  hdr_prim_name :='';
	STRING4   hdr_addr_suffix :='';
	STRING2   hdr_postdir :='';
	STRING8   hdr_sec_range :='';
	STRING50  hdr_addr := '';
	STRING25  hdr_city := '';
	STRING2   hdr_state := '';
	STRING5   hdr_zip := '';
	STRING4   hdr_zip4 := '';
	STRING9   hdr_ssn := '';
	STRING8   hdr_date_last_seen := '';
	STRING20  ver_fname := '';
	STRING20  ver_mname := '';
	STRING20  ver_lname := '';
	STRING5   ver_suffix := '';
	STRING50  ver_cmpy := '';
	STRING50  ver_addr := '';
	STRING25  ver_city := '';
	STRING2   ver_state := '';
	STRING5   ver_zip := '';
	STRING4   ver_zip4 := '';
	STRING9   ver_ssn := '';
	BOOLEAN   coaalertflag := false;
	STRING1   joinfield := '';
	STRING2   nxx_type := '';
	BOOLEAN   potDisconnect := false;
	STRING1   sic_code := '';
	BOOLEAN   iscurrent := false;
	Layout_for_Royalties;
end;

working_layout fill(indata l) := transform
	self.historydate := l.historydate;
	self.tribcode := l.tribcode;
	self.seq := l.seq;
	self.phone10 := l.phoneno;
	self.account := l.account;
	self.acctno := l.acctno;
	self := [];
end;

inrec := project(indata, fill(left));

working_layout teltrans(working_layout le, risk_indicators.Key_Telcordia_tpm_slim ri, INTEGER i) := transform
	self.nxx_type := ri.nxx_type;
	self.isPOTS := risk_indicators.PRIIPhoneRiskFlag(le.phone10).isPOTS(ri.nxx_type);
	self := le;
END;

// search telcordia file to see if the phone number is POTS and append the nxx_type to working layout
wTelcordia := join(inrec,risk_indicators.Key_Telcordia_tpm_slim, 
						keyed(LEFT.phone10[1..3]=(RIGHT.npa)) and 
						keyed(left.phone10[4..6]=RIGHT.nxx) and
						KEYED(RIGHT.tb IN [LEFT.phone10[7],'A']),
			   	  teltrans(left,right,1),
				  left outer, keep(1));
				  
working_layout phtrans(working_layout le,risk_indicators.key_phone_table_v2 ri) := transform
	self.nxx_type := IF(le.nxx_type = '', ri.nxx_type, le.nxx_type);
	self.potDisconnect := ri.potDisconnect;
	self.sic_code := ri.sic_code;
	self.iscurrent := ri.iscurrent;
	self := le;
END;

//pick up disconnect and sic_code
phonerec1 := join(wTelcordia,risk_indicators.key_phone_table_v2,				
				keyed(left.phone10=right.phone10) and left.phone10!=''	AND RIGHT.dt_first_seen < left.historydate,
				phtrans(left,right),left outer, ATMOST(keyed(left.phone10=right.phone10),RiskWise.max_atmost), keep(50));

sortedphonerec := group(sort(phonerec1,seq),seq);

working_layout rollphonerec(working_layout le, working_layout rt) := transform
	self := if(le.iscurrent, le, rt);
end;
				
phonerec := rollup(sortedphonerec, true, rollphonerec(left,right));

//Search gong by phone number
Risk_Indicators.Layouts.Layout_Input_Plus_Overrides t_f(phonerec le) := transform
	self.phone10 := le.phone10;
	self.wphone10 := if(le.isPOTS, le.phone10, '');
	self.historydate := le.historydate;
	self := [];
end;
dirsphon := riskwise.getDirsByPhone(project(ungroup(phonerec), t_f(left)), gateways, mod_access.dppa, mod_access.glb);


working_layout add_gong(phonerec le, dirsphon ri) := transform
	self.did := ri.did;
	self.bdid := ri.bdid;
     self.gong_fname := ri.name_first;
	self.gong_mname := ri.name_middle;
	self.gong_lname := ri.name_last;
	self.gong_suffix := ri.name_suffix;	
	self.gong_cmpy := IF(ri.business_flag,ri.listed_name,'');
     self.gong_prim_range := ri.prim_range;
     self.gong_predir := ri.predir;
     self.gong_prim_name := ri.prim_name;
     self.gong_addr_suffix := ri.suffix;
     self.gong_postdir := ri.postdir;
     self.gong_sec_range := ri.sec_range;
	self.gong_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,'',ri.sec_range);
	self.gong_city := ri.p_city_name;
	self.gong_state := ri.st;
	self.gong_zip := ri.z5;
	self.gong_zip4 := ri.z4;
	self.gong_date_last_seen := (string)ri.dt_last_seen;
	self.gong_bus_flag := ri.business_flag;
	self.gong_current_flag := ri.current_flag;
	self.TargusGatewayUsed := ri.TargusGatewayUsed;
	self.src := ri.src;
	self.TargusType := ri.TargusType;
	self := le;
end;
 
gong_added := join(phonerec, dirsphon,
			  left.phone10 = right.phone10 and
			  ((unsigned)RIGHT.dt_first_seen < (unsigned)risk_indicators.iid_constants.full_history_date(left.historydate) and
			  (RIGHT.current_flag OR risk_indicators.iid_constants.myDaysApart(left.historydate,((STRING6)RIGHT.deletion_date[1..6]+'01')))),				
			  add_gong(left,right), left outer, many lookup,
			  ATMOST(left.phone10 = right.phone10,RiskWise.max_atmost),
			  keep(100));											
gong_sorted := group(sort(gong_added, seq, -gong_date_last_seen, did), seq);
											
working_layout filter1(gong_sorted le, gong_sorted ri) := transform
	chooser1 := ri.gong_date_last_seen[1..6] > le.gong_date_last_seen[1..6];	//narrow down to 1 gong record with the most recent dt_last_seen		
	self := if(chooser1, le, ri);										//move all fields from the most recent record
end;

one_gong := rollup(gong_sorted, true, filter1(left, right));

//Search header file by the did from gong.  If gong is a business, we won't hit here.  
d := record
	unsigned6 did := 0;
end;

eqfs := riskwise.getHeaderByDid(ungroup(project(one_gong, transform(d, self:=left))), mod_access.dppa, mod_access.glb, mod_access.ln_branded, mod_access.DataRestrictionMask);

working_layout gongheader(one_gong le, eqfs ri) := transform
	self.hdr_fname := ri.fname;
	self.hdr_mname := ri.mname;
	self.hdr_lname := ri.lname;
	self.hdr_suffix := ri.name_suffix;
     self.hdr_prim_range := ri.prim_range;
     self.hdr_predir := ri.predir;
     self.hdr_prim_name := ri.prim_name;
     self.hdr_addr_suffix := ri.suffix;
     self.hdr_postdir := ri.postdir;
     self.hdr_sec_range := ri.sec_range;
	self.hdr_addr := Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range);
	self.hdr_city:= ri.city_name;
	self.hdr_state := ri.st;
	self.hdr_zip := ri.zip;
	self.hdr_zip4 := ri.zip4;
	self.hdr_ssn := ri.ssn;
	self.hdr_date_last_seen := (string)ri.dt_last_seen;
	self.hdr_addrscore := Risk_Indicators.AddrScore.AddressScore(le.gong_prim_range, le.gong_prim_name, le.gong_sec_range,
										   ri.prim_range, ri.prim_name, ri.sec_range );
	self.coaalertflag := IF(self.hdr_addrscore < min_addrscore,1,0);  	//Set COA flag if gong address is different from header address.
	self := le;
end;

combined_gong_header := join(one_gong, eqfs,
						left.did = right.s_did and RIGHT.dt_first_seen < left.historydate,
						gongheader(left, right), left outer, many lookup, ATMOST(left.did = right.s_did,RiskWise.max_atmost), keep(100));
						
wHeader := group(sort(combined_gong_header, seq, -hdr_date_last_seen), seq);

working_layout filter2(working_layout le, working_layout ri) := transform
	chooser2 := ri.hdr_date_last_seen[1..6] >= le.hdr_date_last_seen[1..6];	  	//narrow down to 1 header record with the most recent dt_last_seen		 
	self := if(chooser2, ri, le);											//move all fields from the most recent record
end;	

rolled_header := rollup(wHeader, true, filter2(left, right));  // rollup to 1 record per seq before the keyed join to business header
					
//Search business_header by the bdid from gong.  
working_layout gongbheader(rolled_header le, Business_Header.Key_BH_Best ri) := transform
	isCmpy := le.hdr_lname='' and ri.bdid<>0;
	self.hdr_cmpy := if(isCmpy, ri.company_name, le.hdr_cmpy);
     self.hdr_prim_range := if(isCmpy, ri.prim_range, le.hdr_prim_range);
     self.hdr_predir := if(isCmpy, ri.predir, le.hdr_predir);
     self.hdr_prim_name := if(isCmpy, ri.prim_name, le.hdr_prim_name);
     self.hdr_addr_suffix := if(isCmpy, ri.addr_suffix, le.hdr_addr_suffix);
     self.hdr_postdir := if(isCmpy, ri.postdir, le.hdr_postdir);
     self.hdr_sec_range := if(isCmpy, ri.sec_range, le.hdr_sec_range);
	self.hdr_addr := if(isCmpy, Risk_Indicators.MOD_AddressClean.street_address('',ri.prim_range,ri.predir,ri.prim_name,ri.addr_suffix,ri.postdir,ri.unit_desig,ri.sec_range), le.hdr_addr);
	self.hdr_city := if(isCmpy, ri.city, le.hdr_city);
	self.hdr_state := if(isCmpy, ri.state, le.hdr_state);
	self.hdr_zip := if(isCmpy, (STRING5) ri.zip, le.hdr_zip);
	self.hdr_zip4 := if(isCmpy, (STRING4) ri.zip4, le.hdr_zip4);
	self.hdr_ssn := if(isCmpy, (STRING9) ri.fein, le.hdr_ssn);
	self.hdr_date_last_seen := if(isCmpy, (string)ri.dt_last_seen, le.hdr_date_last_seen);
	self := le;
end;

combined_gong_bheader := join(rolled_header, Business_Header.Key_BH_Best, 
						keyed(right.bdid = left.bdid) and left.bdid<>0 and RIGHT.dt_last_seen < left.historydate AND 
						doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask), 
						gongbheader(left, right), left outer, ATMOST(keyed(right.bdid = left.bdid),RiskWise.max_atmost), keep(100));

finalheader := group(sort(combined_gong_bheader, seq, -hdr_date_last_seen), seq);
														
one_header := rollup(finalheader, true, filter2(left, right));	//rollup to 1 record per seq


//Here we decide what verified data to output based on disconnect and coa flags.  Basically, if the phone is a disconnected phone and the coa flag
//is on, then output the header data because this scenario indicates a change of address.
working_layout prep_output (one_header le) := TRANSFORM
	self.ver_fname := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_fname,	//change of address
					  le.potDisconnect AND ~le.coaalertflag => '',			//disconnected
					  le.gong_fname);									//not disconnected so output gong data
	self.ver_lname := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_lname,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_lname);
	self.ver_addr := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_addr,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_addr);
	self.ver_city := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_city,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_city);
	self.ver_state := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_state,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_state);
	self.ver_zip := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_zip,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_zip);
	self.ver_zip4 := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_zip4,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_zip4);
	self.ver_cmpy := MAP(le.potDisconnect AND le.coaalertflag => le.hdr_cmpy,
					  le.potDisconnect AND ~le.coaalertflag => '',
					  le.gong_cmpy);
	self := le;
						
END;

pre_output := PROJECT(one_header, prep_output(LEFT));

// remove output if on the following files
Suppress.MAC_Suppress(pre_output,out,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,hdr_ssn);
Suppress.MAC_Suppress(out,out2,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);

working_layout one_for_each(pre_output le, out2 rt) := transform
	self.seq := le.seq;
	self.tribcode := le.tribcode;
	self.acctno := le.acctno;
	self.account := le.account;
	self.phone10 := le.phone10;
	self := [];
end;

fullset := JOIN(pre_output,out2,LEFT.seq=RIGHT.seq,one_for_each(LEFT,RIGHT),LEFT ONLY, LOOKUP)+out2;

Layout_CT1O_4_royalties := RECORD
	Layout_CT1O;
	Layout_for_Royalties;
END;

Layout_CT1O_4_royalties format_out(fullset le) := TRANSFORM
	self.acctno := le.acctno;
	SELF.account := le.account;
	SELF.riskwiseid := (STRING)le.did;									// outputting the did here, doug should not use this
	self.nameaddrflag :=  MAP(le.tribCode = 'ct02' AND (le.ver_addr<>'' OR le.ver_city<>'' OR le.ver_state<>'' OR le.ver_zip<>'') => 'Y',	
						 le.tribCode = 'ct03' AND le.ver_addr<>'' => 'Y',
						 le.tribCode = 'ct50' => MAP(le.gong_bus_flag and le.ver_addr<>'' AND le.ver_cmpy<>'' => 'Y',
										     ~le.gong_bus_flag and le.ver_addr<>'' AND le.ver_fname<>'' AND le.ver_lname<>'' => 'Y',
										      'N'),
						'N');	
	SELF.first := IF(self.nameaddrflag = 'Y', le.ver_fname, '');
	self.last := IF(self.nameaddrflag = 'Y', le.ver_lname, '');
	self.addr := IF(self.nameaddrflag = 'Y', le.ver_addr, '');
	self.city := IF(self.nameaddrflag = 'Y', le.ver_city, '');
	self.state := IF(self.nameaddrflag = 'Y', le.ver_state, '');
	self.zip := IF(self.nameaddrflag = 'Y', le.ver_zip + le.ver_zip4, '');
	self.cmpy := IF(self.nameaddrflag = 'Y', le.ver_cmpy, '');
	self.reserved := '';

	self.phonserviceflag := IF(le.tribCode = 'ct50' AND (le.ver_addr = '' or (le.ver_lname = '' AND le.ver_cmpy = '')),
						   '',
						   MAP (self.nameaddrflag <> 'Y' AND le.tribCode <> 'ct03' => risk_indicators.PRIIPhoneRiskFlag(le.phone10).phoneRiskFlag(le.nxx_type, le.potDisconnect, le.sic_code),
						        self.nameaddrflag <> 'Y' AND le.tribCode = 'ct03' => '',
						        le.gong_bus_flag => 'B',
							   self.nameaddrflag = 'Y' AND (self.first = '' or self.last = '') => 'U',
						        self.nameaddrflag = 'Y' AND self.first<>'' and self.last<>'' => 'R',
						        self.addr<>'' => '0',
						        '4'));
	
	self.Billing := dataset([], risk_indicators.Layout_Billing);
	self.TargusGatewayUsed := le.TargusGatewayUsed;
	self.src := le.src;
	self.TargusType := le.TargusType;
END;
final := PROJECT(fullset, format_out(LEFT));

/*
output(phonerec1, named('phonerec1'));
output(phonerec, named('phonerec'));
output(one_gong, named('one_gong'));
output(one_header, named('one_header'));
output(pre_output, named('pre_output'));
*/

return final;
	 
end;
