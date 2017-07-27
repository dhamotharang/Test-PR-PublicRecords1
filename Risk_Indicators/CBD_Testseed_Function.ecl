import Models, Seed_Files;

export CBD_Testseed_Function (dataset(Risk_Indicators.Layout_BocaShell_BtSt.BTST_input) inData, string30 account_value, string20 TestDataTableName) := 
				
FUNCTION
	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	layout_CBDseq := RECORD
		unsigned4 seq;
		Models.Layout_Chargeback_Out;
	END;
	
	layout_CBDseq create_output(inData le, Seed_Files.Key_CBD ri) := TRANSFORM
		reason_codes := dataset( [
			{ri.reason1,ri.reason1desc},
			{ri.reason2,ri.reason2desc},
			{ri.reason3,ri.reason3desc},
			{ri.reason4,ri.reason4desc}
			], models.layout_reason_codes
		);

		risk_indicators.mac_add_sequence(reason_codes(reason_code<>''), reasons_with_seq);
		rc_sets := dataset([{'BillTo',reasons_with_seq}], Models.Layouts.Layout_Reason_Code_Sets);
		scores := dataset([{ri.score1,ri.scoredesc,ri.scoreindex,rc_sets}], Models.Layouts.Layout_Score_Multiple);
		self.models := dataset( [{account_value,ri.modeldesc,scores}], Models.Layouts.Layout_Model_Multiple );

		SELF.accountnumber := account_value;
		SELF.seq := (INTEGER)ri.sequence;
		
		SELF.chargeback.seq := SELF.seq;
		SELF.chargeback.addr   := ri.address;
		SELF.chargeback.hphone := ri.homephone;
		SELF.chargeback.socs   := ri.social;
		SELF.chargeback.hphone2 := ri.homephone2;
		SELF.chargeback.socsverlevel := ri.nas;
		SELF.chargeback.phoneverlevel := ri.nap;
		SELF.chargeback.correctlast := ri.pclast;
		SELF.chargeback.correcthphone := ri.pcphone;
		SELF.chargeback.correctsocs := ri.pcsocs;
		SELF.chargeback.correctaddr := ri.pcaddr;
		SELF.chargeback.altareacode := ri.newareacod;
		SELF.chargeback.areacodesplitdate := ri.acsplitdat;
		SELF.chargeback.nameaddrphone := ri.nameaddrphn;
		SELF.chargeback.hphonetypeflag := ri.homephntyp;
		SELF.chargeback.dwelltypeflag := ri.dwelltype;
		SELF.chargeback.phoneverlevel2 := ri.natsearch2;
		SELF.chargeback.correctlast2 := ri.pclast2;
		SELF.chargeback.correcthphone2 := ri.pcphon2;
		SELF.chargeback.correctaddr2 := ri.pcaddr2;
		SELF.chargeback.altareacode2 := ri.newarea2;
		SELF.chargeback.areacodesplitdate2 := ri.acsplitda2;
		SELF.chargeback.nameaddrphone2 := ri.nameaddrph2;
		SELF.chargeback.hphonetypeflag2 := ri.hphntyp2;
		SELF.chargeback.dwelltypeflag2 := ri.dwelltype2;

		SELF.chargeback.verzip5  := ri.verzip[1..5];
		SELF.chargeback.verzip4  := ri.verzip[6..9];
		SELF.chargeback.verzip52 := ri.verzip2[1..5];
		SELF.chargeback.verzip42 := ri.verzip2[6..9];
                                  

		SELF.chargeback := ri;
		
		
		SELF.ipdata.ipcontinent := ri.ipcontinen;
		SELF.ipdata.iproutingtype := ri.iproutetyp;
		SELF.ipdata.topleveldomain := ri.topdomain;
		SELF.ipdata.ipareacode := ri.iparea;
		SELF.ipdata.secondleveldomain := ri.secdomain;
		self.ipdata := ri;

		SELF := ri;
		SELF := [];
		
	END;
	
	
	
	cbd_rec := join(inData, Seed_Files.Key_CBD,
			keyed(right.dataset_name=Test_Data_Table_Name) and 
			keyed(
				right.hashvalue=Seed_Files.Hash_InstantID(
					(string15)left.fname,
					(string20)left.lname,
					(string9)left.ssn,
					Risk_Indicators.nullstring, // fein
					(string9)(left.z5),
					(string10)left.phone10,
					Risk_Indicators.nullstring // company name
				)
			),
			create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
	);
	
	return cbd_rec;
END;