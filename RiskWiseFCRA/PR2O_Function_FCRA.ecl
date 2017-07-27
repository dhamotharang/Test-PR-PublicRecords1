import ut, address, Risk_Indicators, Models, RiskWise,gateway;

export PR2O_Function_FCRA(dataset(RiskWise.Layout_SD1I) indata, dataset(Gateway.Layouts.Config) gateways, 
unsigned1 glb, unsigned1 dppa, string4 tribCode,
string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
boolean UsePersonContext) := 

FUNCTION

Risk_Indicators.Layout_Input into(indata le) := TRANSFORM
	clean_a := Risk_Indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip);
	
	ssn_val := riskwise.cleanSSN(le.socs);
	hphone_val := riskwise.cleanPhone(le.hphone);
	wphone_val := riskwise.cleanphone(le.wphone);
	dob_val := riskwise.cleandob(le.dob);
	dl_num_clean := riskwise.cleanDL_num(le.drlc);

	self.historydate := le.historydate;
	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	self.fname := stringlib.stringtouppercase(le.first);
	self.lname := stringlib.stringtouppercase(le.last);
	self.in_streetAddress := stringlib.stringtouppercase(le.addr);
	self.in_city := stringlib.stringtouppercase(le.city);
	self.in_state := stringlib.stringtouppercase(le.state);
	self.in_zipCode := le.zip;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := if(clean_a[117..121]<>'',clean_a[117..121],le.zip[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := if(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.dl_number := stringlib.stringtouppercase(dl_num_clean);
	self.dl_state := stringlib.stringtouppercase(le.drlcstate);
	self.age := if((integer)dob_val != 0, (string3)ut.GetAgeI((integer)dob_val), '');
	self.email_address := le.email;
	self.employer_name := stringlib.stringtouppercase(le.cmpy);
	
	self := [];
END;
prep := PROJECT(indata,into(LEFT));

clam := Risk_Indicators.Boca_Shell_Function_FCRA (prep, gateways, dppa, glb, false, false, false, false, false, false, true,datarestriction:=datarestriction,datapermission:=datapermission);


// intermediate results
working_layout := RECORD
	RiskWise.Layout_PR2O;
	boolean inCalif;
	unsigned4 seq;
END;


unsigned2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => 0,
									  level = 1 => 1,
									  level = 4 => 2,
									  level = 6 => 3,
									  level = 7 => 4,
									  level-4);	// 9,10,11,12 results in 5,6,7,8


working_layout fill_output(clam le, indata ri) := TRANSFORM
	self.inCalif := Stringlib.stringtouppercase(ri.state) = 'CA' and 
				 ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+(integer)(boolean)le.iid.combo_addrcount+
				 (integer)(boolean)le.iid.combo_hphonecount+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;


	self.seq := ri.seq;
	self.account := ri.account;
	self.acctno := ri.acctno;
	self.riskwiseid := (string)le.did;
	
	self.score := if(self.inCalif, '000', '');
	
	// Per Bug 58288 - EQ99 logging in no longer necessary, removing.
	self.billing := dataset([],risk_indicators.Layout_Billing);								
															
	self := [];
end;
mapped_results := join(clam, indata, left.seq=right.seq, fill_output(left,right), left outer);



getScore := Models.TBD609_1_0(clam, true, mapped_results[1].inCalif);


working_layout addBTmodel(mapped_results le, getScore ri) := TRANSFORM
	self.score := if(le.score = '' or ri.score in ['101','102','103','104','105'], ri.score, le.score);
	self.reason11 := if(Risk_Indicators.rcSet.isCode36(ri.ri[1].hri), '36', ri.ri[1].hri);
	self.reason21 := ri.ri[2].hri;
	self.reason31 := ri.ri[3].hri;
	self.reason41 := ri.ri[4].hri;
	
	self := le;
END;
withBTmodel := join(mapped_results, getScore, left.seq=right.seq, addBTmodel(left, right), left outer);


final := project(withBTmodel, transform(RiskWise.Layout_PR2O, self := left));

RETURN final;

END;