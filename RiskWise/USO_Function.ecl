IMPORT ut, Risk_Indicators, Models, gateway, STD;

export USO_Function(DATASET(Layout_1USI) indata, dataset(Gateway.Layouts.Config) gateways, unsigned1 glb, unsigned1 dppa, 
			string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
			string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
            unsigned1 LexIdSourceOptout = 1,
            string TransactionID = '',
            string BatchUID = '',
            unsigned6 GlobalCompanyId = 0) := function


risk_indicators.layout_input into(indata le) := TRANSFORM
	clean_a := risk_indicators.MOD_AddressClean.clean_addr(le.addr, le.city, le.state, le.zip) ;	

	ssn_val := cleanSSN( le.socs );
	hphone_val := cleanPhone( le.hphone );
	wphone_val := cleanPhone( le.wphone );
	dob_val := cleanDOB(le.dob);

	self.historydate := le.historydate;
	self.seq := le.seq;
	self.ssn := ssn_val;
	self.dob := dob_val;
	self.phone10 := hphone_val;	
	self.wphone10 := wphone_val;
	self.fname := STD.Str.touppercase(le.first);
	self.lname := STD.Str.touppercase(le.last);
	SELF.in_streetAddress := STD.Str.touppercase(le.addr);
	SELF.in_city := STD.Str.touppercase(le.city);
	SELF.in_state := STD.Str.touppercase(le.state);
	SELF.in_zipCode := le.zip;
	self.prim_range := clean_a[1..10];
	self.predir := clean_a[11..12];
	self.prim_name := clean_a[13..40];
	self.addr_suffix := clean_a[41..44];
	self.postdir := clean_a[45..46];
	self.unit_desig := clean_a[47..56];
	self.sec_range := clean_a[57..64];
	self.p_city_name := clean_a[90..114];
	self.st := clean_a[115..116];
	self.z5 := IF(clean_a[117..121]<>'',clean_a[117..121],le.zip[1..5]);		// use the input zip if cass zip is empty
	self.zip4 := IF(clean_a[122..125]<>'', clean_a[122..125], le.zip[6..9]);	// use the input zip if cass zip is empty
	self.lat := clean_a[146..155];
	self.long := clean_a[156..166];
	self.addr_type := clean_a[139];
	self.addr_status := clean_a[179..182];
	self.county := clean_a[143..145];
	self.geo_blk := clean_a[171..177];
	self.age := if ((integer)dob_val != 0, (STRING3)ut.Age((integer)dob_val), '');
	SELF.employer_name := STD.Str.touppercase(le.cmpy);
	
	self := [];
END;
prep := PROJECT(indata,into(LEFT));


ret := risk_indicators.InstantID_Function(prep, gateways, dppa, glb, false, false, true, true, false, in_DataRestriction:=DataRestriction,in_DataPermission:=DataPermission,
                                                                    LexIdSourceOptout := LexIdSourceOptout, 
                                                                    TransactionID := TransactionID, 
                                                                    BatchUID := BatchUID, 
                                                                    GlobalCompanyID := GlobalCompanyID);

working_layout := RECORD
	unsigned seq;
	Layout_1USO;
end;


layout_pt := record
	risk_indicators.Key_Telcordia_tpm_slim;
	string1 phonetype;
	string2 servicetype;
end;


working_layout format_out(ret le, prep ri) := TRANSFORM
	SELF.seq := ri.seq;	
		
	hphonetelco := if(le.phone10 != '', riskwise.telcoPhoneType(le.phone10), dataset([], layout_pt));
	self.hphonetypeflag := if(le.phone10 <> '' and hphonetelco[1].phonetype = '', '5', hphonetelco[1].phonetype);  // if miss on telcordia, set to 5
	self.hphonesrvcflag := if(le.phone10 <> '' and hphonetelco[1].servicetype = '', '0', if(le.phone10 = '', '', hphonetelco[1].servicetype)); // if miss on telcordia, set to 0
			
	
	wphonetelco := if(le.wphone10 != '', riskwise.telcoPhoneType(le.wphone10), dataset([], layout_pt));
	self.wphonetype := if(le.wphone10 <> '' and wphonetelco[1].phonetype = '', '5', wphonetelco[1].phonetype);  // if miss on telcordia, set to 5
	self.wphonesrvc := if(le.wphone10 <> '' and wphonetelco[1].servicetype = '', '0', if(le.wphone10 = '', '', wphonetelco[1].servicetype)); // if miss on telcordia, set to 0
		
	self.areacodesplit := map(le.areacodesplitflag='Y' => '1',
						 le.reverse_areacodesplitflag='Y' => '2',
						 '');
	self.altareacode := if(le.areacodesplitflag='Y' or le.reverse_areacodesplitflag='Y', le.altareacode, '');
	
	// Changed phone-zip miss flag to include '' - K.C. 1/25/06
	SELF.phonezipmis := MAP(length(trim(le.phone10)) < 6 or le.phone10 = '' or ~Risk_Indicators.IsAllNumeric(le.phone10) => '',
					    le.phonezipflag = '1' => '1',
					    '0');
		
	SELF.socsdobmis := le.inputsocscode;
	
	SELF.hriskflag := MAP(le.addrcommflag = '1' => '2',
					  le.addrcommflag = '2' => '1',
					  '');
	SELF.hriskcmpy := MAP(le.addrcommflag = '1' => le.hriskcmpyphone,
					  le.addrcommflag = '2' => le.hriskcmpy,
					  '');
	SELF.sic := MAP(le.addrcommflag = '1' => RiskWise.convertSIC(le.hrisksicphone),
				 le.addrcommflag = '2' => RiskWise.convertSIC(le.hrisksic),
				 '');
				 
	SELF.zipclassflag := IF(le.zipclass in ['P','U','M'], le.zipclass,'');
	SELF.cityzip := IF(le.zipclass in ['P','U','M'], le.zipcity,'');
	
	cens := riskwise.getCensus(ri.st, ri.county, ri.geo_blk);
	self.medincome :=  cens[1].income;
	
	
	// Changed to look more like riskwise output - K.C. 1/25/06
	SELF.bansflag := if(le.bansflag in ['0','3'], '', le.bansflag);
	SELF.bansdatefiled := le.bansdatefiled;	
	
	SELF.addrval := le.addrvalflag;
	self.invalidaddr := riskwise.certErr(ri.addr_status, ri.predir, ri.prim_name, ri.addr_suffix,ri.postdir, ri.st);
	SELF.cassaddr := Risk_Indicators.MOD_AddressClean.street_address('',le.prim_range,le.predir,le.prim_name,le.addr_suffix,le.postdir,le.unit_desig,le.sec_range);
	SELF.casscity := le.p_city_name;
	SELF.cassstate := le.st;
	SELF.casszip := le.z5 + le.zip4; 
	
	SELF.cmpyphoneflag := IF(le.hphonevalflag = '1', '1','');	// may need to be more specific here and run the key_phone_table
	
	SELF.lowissue := le.socllowissue;
	SELF.dwelltype := le.dwelltype;
	SELF.phonedissflag := IF(le.phonedissflag, '1','');
	
	SELF := [];
END;
mappedResults := JOIN(ret, prep, left.seq = right.seq, format_out(LEFT,RIGHT), left outer);

working_layout addIndata(mappedResults le, indata ri) := transform
	self := ri;
	self := le;
end;
withInput := join(mappedResults, indata, left.seq=right.seq, addIndata(left,right));

clam := risk_indicators.Boca_Shell_Function(ret, gateways, dppa, glb, false, false, false, false, false, false,DataRestriction:=Datarestriction,DataPermission:=DataPermission,
                                                                              LexIdSourceOptout := LexIdSourceOptout, 
                                                                              TransactionID := TransactionID, 
                                                                              BatchUID := BatchUID, 
                                                                              GlobalCompanyID := GlobalCompanyID);
getScore := ungroup(Models.CEN509_0_0(clam));
			 
Layout_1USO addModel(withInput le, getScore ri) := transform
	SELF.ecovariables := (string)round((real)ri.score);	
	SELF := le;
end;
withModel := join(withInput, getScore, left.seq=right.seq, addModel(left,right), left outer);	

RETURN withModel;

end;