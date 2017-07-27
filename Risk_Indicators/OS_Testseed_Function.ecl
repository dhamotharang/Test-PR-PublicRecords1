import Models, Seed_Files, iesp;

export OS_Testseed_Function (dataset(Risk_Indicators.Layout_BocaShell_BtSt.BTST_input) inData, 
		string30 account_value, string20 TestDataTableName) := 
				
FUNCTION
	Test_Data_Table_Name := trim(stringlib.stringtouppercase(TestDataTableName));
	
	Risk_Indicators.Layout_BocaShell_BtSt.layout_OSMain_wAcct create_output(inData le, Seed_Files.Key_OS ri) := TRANSFORM

		BT_rc_sets := dataset([
			{ri.ricode,ri.ridesc, ri.riseq},	
			{ri.ricode2,ri.ridesc2, ri.riseq2},
			{ri.ricode3,ri.ridesc3, ri.riseq3},
			{ri.ricode4,ri.ridesc4, ri.riseq4},	
			{ri.ricode5,ri.ridesc5, ri.riseq5},	
			{ri.ricode6,ri.ridesc6, ri.riseq6}
			], iesp.share.t_SequencedRiskIndicator);
		BT_sets := dataset([{'BillTo', BT_rc_sets(RiskCode != '')}], iesp.instantid.t_RISet);
		ST_rc_sets := dataset([
			{ri.ricode7,ri.ridesc7, ri.riseq7},	
			{ri.ricode8,ri.ridesc8, ri.riseq8},
			{ri.ricode9,ri.ridesc9, ri.riseq9},
			{ri.ricode10,ri.ridesc10, ri.riseq10},	
			{ri.ricode11, ri.ridesc11, ri.riseq11},	
			{ri.ricode12,ri.ridesc12, ri.riseq12}
			], iesp.share.t_SequencedRiskIndicator);
		ST_sets := dataset([{'ShipTo', ST_rc_sets(RiskCode != '')}], iesp.instantid.t_RISet);
		
		scores := dataset([{ri.modeltype, ri.modelscore, BT_sets+ST_sets}], iesp.instantid.t_ScoreSequencedRISets);
		scores_final := dataset([{ri.modelname, scores}], iesp.instantid.t_ModelSequencedRISets);
	
		//Models
		SELF.result.Models := scores_final;

		SELF.accountnumber := account_value;
		SELF.seq := (INTEGER)le.seq;
		//bill to input echo
		SELF.result.inputecho.BillTo.Name.Full := ri.Fullname;	
		SELF.result.inputecho.BillTo.Name.First := ri.First;	
		SELF.result.inputecho.BillTo.Name.Middle := ri.Middle;	
		SELF.result.inputecho.BillTo.Name.Last := ri.Last;
		SELF.result.inputecho.BillTo.Name.Suffix := ri.Suffix;	
		SELF.result.inputecho.BillTo.Name.Prefix := ri.Prefix;	
		SELF.result.inputecho.BillTo.Address.StreetAddress1 := ri.Address1;	
		SELF.result.inputecho.BillTo.Address.StreetAddress2 := ri.Address12;	
		SELF.result.inputecho.BillTo.Address.StreetNumber := ri.StNum;	
		SELF.result.inputecho.BillTo.Address.StreetName := ri.StName;	
		SELF.result.inputecho.BillTo.Address.StreetSuffix := ri.stsuffix;	
		SELF.result.inputecho.BillTo.Address.StreetPreDirection := ri.PreDir;		
		SELF.result.inputecho.BillTo.Address.StreetPostDirection := ri.postdir;	
		SELF.result.inputecho.BillTo.Address.UnitDesignation := ri.unitdesig;	
		SELF.result.inputecho.BillTo.Address.UnitNumber := ri.unitNum;
		SELF.result.inputecho.BillTo.Address.county := ri.county;	
		SELF.result.inputecho.BillTo.Address.PostalCode := ri.PostalCo;	
		SELF.result.inputecho.BillTo.Address.StateCityZip := ri.stcityzip;
		SELF.result.inputecho.BillTo.Address.City := ri.City;	
		SELF.result.inputecho.BillTo.Address.State := ri.State;
		SELF.result.inputecho.BillTo.Address.Zip5 := ri.Zip5;	
		SELF.result.inputecho.BillTo.Address.Zip4 := ri.zip4;
		SELF.result.inputecho.BillTo.Phone10 := ri.phone10;
		SELF.result.inputecho.BillTo.SSN := ri.ssn;
		SELF.result.inputecho.BillTo.EmailAddress := ri.emailaddr;
		SELF.result.inputecho.BillTo.DriverLicenseNumber := ri.drlc;
		SELF.result.inputecho.BillTo.DriverLicenseState := ri.drlcSt;	
		SELF.result.inputecho.BillTo.DOB.Year := (integer)  ri.dobyear ;
		SELF.result.inputecho.BillTo.DOB.month := (integer) ri.dobmonth ;
		SELF.result.inputecho.BillTo.DOB.day := (integer)  ri.dobday ;
		SELF.result.inputecho.BillTo.IPAddress := ri.ipaddr;
		//bill to - verified
		SELF.result.BillTo.VerifiedInput.Name.Full := ri.vFull;	
		SELF.result.BillTo.VerifiedInput.Name.First := ri.vFirst;	
		SELF.result.BillTo.VerifiedInput.Name.Middle := ri.vMiddle;	
		SELF.result.BillTo.VerifiedInput.Name.Last := ri.vLast;
		SELF.result.BillTo.VerifiedInput.Name.Suffix := ri.vSuffix;	
		SELF.result.BillTo.VerifiedInput.Name.Prefix := ri.vPrefix;
		SELF.result.BillTo.VerifiedInput.Address.StreetAddress1 := ri.vAddress1;	
		SELF.result.BillTo.VerifiedInput.Address.StreetAddress2 := ri.vAddress12;	
		SELF.result.BillTo.VerifiedInput.Address.StreetNumber := ri.vStNum;	
		SELF.result.BillTo.VerifiedInput.Address.StreetName := ri.vStName;	
		SELF.result.BillTo.VerifiedInput.Address.StreetSuffix := ri.vstsuffix;	
		SELF.result.BillTo.VerifiedInput.Address.StreetPreDirection := ri.vPreDir;	
		SELF.result.BillTo.VerifiedInput.Address.StreetPostDirection := ri.vpostdir;	
		SELF.result.BillTo.VerifiedInput.Address.UnitDesignation := ri.vunitdesig;	
		SELF.result.BillTo.VerifiedInput.Address.UnitNumber := ri.vunitNum;
		SELF.result.BillTo.VerifiedInput.Address.county := ri.vcounty;	
		SELF.result.BillTo.VerifiedInput.Address.PostalCode := ri.vPostalCo;	
		SELF.result.BillTo.VerifiedInput.Address.StateCityZip := ri.vstcityzip;
		SELF.result.BillTo.VerifiedInput.Address.City := ri.vCity;	
		SELF.result.BillTo.VerifiedInput.Address.State := ri.vState;
		SELF.result.BillTo.VerifiedInput.Address.Zip5 := ri.vZip5;	
		SELF.result.BillTo.VerifiedInput.Address.Zip4 := ri.vzip4;
		//bill to - corrected
		SELF.result.BillTo.InputCorrected.Name.Full := ri.cFull;	
		SELF.result.BillTo.InputCorrected.Name.First := ri.cFirst;	
		SELF.result.BillTo.InputCorrected.Name.Middle := ri.cMiddle;	
		SELF.result.BillTo.InputCorrected.Name.Last := ri.cLast;
		SELF.result.BillTo.InputCorrected.Name.Suffix := ri.cSuffix;	
		SELF.result.BillTo.InputCorrected.Name.Prefix := ri.cPrefix;
		SELF.result.BillTo.InputCorrected.Address.StreetAddress1 := ri.cAddress1;	
		SELF.result.BillTo.InputCorrected.Address.StreetAddress2 := ri.cAddress12;	
		SELF.result.BillTo.InputCorrected.Address.StreetNumber := ri.cStNum;	
		SELF.result.BillTo.InputCorrected.Address.StreetName := ri.cStName;	
		SELF.result.BillTo.InputCorrected.Address.StreetSuffix := ri.cstsuffix;	
		SELF.result.BillTo.InputCorrected.Address.StreetPreDirection := ri.cPreDir;	
		SELF.result.BillTo.InputCorrected.Address.StreetPostDirection := ri.cpostdir;	
		SELF.result.BillTo.InputCorrected.Address.UnitDesignation := ri.cunitdesig;	
		SELF.result.BillTo.InputCorrected.Address.UnitNumber := ri.cunitNum;
		SELF.result.BillTo.InputCorrected.Address.county := ri.ccounty;	
		SELF.result.BillTo.InputCorrected.Address.PostalCode := ri.cPostalCo;	
		SELF.result.BillTo.InputCorrected.Address.StateCityZip := ri.cstcityzip;
		SELF.result.BillTo.InputCorrected.Address.City := ri.cCity;	
		SELF.result.BillTo.InputCorrected.Address.State := ri.cState;
		SELF.result.BillTo.InputCorrected.Address.Zip5 := ri.cZip5;	
		SELF.result.BillTo.InputCorrected.Address.Zip4 := ri.czip4;
		SELF.Result.BillTo.InputCorrected.Phone10 := ri.cphone;
		SELF.Result.BillTo.InputCorrected.SSN := ri.cssn;
		//bill to - newarea
		SELF.Result.BillTo.NewAreaCode.AreaCode := ri.areacode;
		SELF.Result.BillTo.NewAreaCode.EffectiveDate.year:= (integer) ri.areayear;
		SELF.Result.BillTo.NewAreaCode.EffectiveDate.Month:= (integer) ri.areamonth;
		SELF.Result.BillTo.NewAreaCode.EffectiveDate.day:= (integer) ri.areaday;
		//bill to - extras
		SELF.Result.BillTo.NameAddressSSNSummary := ri.nas;
		SELF.Result.BillTo.NameAddressPhoneSummary := ri.nap;
		SELF.Result.BillTo.PhoneOfNameAddress := ri.phnameaddr;
		SELF.Result.BillTo.PhoneType  := ri.phonetype;
		SELF.Result.BillTo.DwellingType := ri.dwelltype;
		self.Result.BillTo.SIC := (string)ri.sic;
		//ship to input echo
		SELF.result.inputecho.ShipTo.Name.Full := ri.Fullname2;	
		SELF.result.inputecho.ShipTo.Name.First := ri.First2;	
		SELF.result.inputecho.ShipTo.Name.Middle := ri.Middle2;	
		SELF.result.inputecho.ShipTo.Name.Last := ri.Last2;
		SELF.result.inputecho.ShipTo.Name.Suffix := ri.Suffix2;	
		SELF.result.inputecho.ShipTo.Name.Prefix := ri.Prefix2;	
		SELF.result.inputecho.ShipTo.Address.StreetAddress1 := ri.Address2;	
		SELF.result.inputecho.ShipTo.Address.StreetAddress2 := ri.Address22;	
		SELF.result.inputecho.ShipTo.Address.StreetNumber := ri.StNum2;	
		SELF.result.inputecho.ShipTo.Address.StreetName := ri.StName2;	
		SELF.result.inputecho.ShipTo.Address.StreetSuffix := ri.stsuffix2;	
		SELF.result.inputecho.ShipTo.Address.StreetPreDirection := ri.PreDir2;	
		SELF.result.inputecho.ShipTo.Address.StreetPostDirection := ri.postdir2;	
		SELF.result.inputecho.ShipTo.Address.UnitDesignation := ri.unitdesig2;	
		SELF.result.inputecho.ShipTo.Address.UnitNumber := ri.unitNum2;
		SELF.result.inputecho.ShipTo.Address.county := ri.county2;	
		SELF.result.inputecho.ShipTo.Address.PostalCode := ri.PostalCo2;	
		SELF.result.inputecho.ShipTo.Address.StateCityZip := ri.stcityzip2;
		SELF.result.inputecho.ShipTo.Address.City := ri.City2;	
		SELF.result.inputecho.ShipTo.Address.State := ri.State2;
		SELF.result.inputecho.ShipTo.Address.Zip5 := ri.Zip52;	
		SELF.result.inputecho.ShipTo.Address.Zip4 := ri.zip42;
		SELF.result.inputecho.ShipTo.Phone10 := ri.phone102;
		SELF.result.inputecho.ShipTo.SSN := ri.ssn2;
		SELF.result.inputecho.ShipTo.EmailAddress := ri.emailaddr2;
		SELF.result.inputecho.ShipTo.DriverLicenseNumber := ri.drlc2;
		SELF.result.inputecho.ShipTo.DriverLicenseState := ri.drlcSt2;
		SELF.result.inputecho.ShipTo.DOB.Year := (integer) ri.dobyear2 ;
		SELF.result.inputecho.ShipTo.DOB.month := (integer) ri.dobmonth2 ;
		SELF.result.inputecho.ShipTo.DOB.day := (integer) ri.dobday2 ;
		//bill to - verified
		SELF.result.ShipTo.VerifiedInput.Name.Full := ri.vFull2;	
		SELF.result.ShipTo.VerifiedInput.Name.First := ri.vFirst2;	
		SELF.result.ShipTo.VerifiedInput.Name.Middle := ri.vMiddle2;	
		SELF.result.ShipTo.VerifiedInput.Name.Last := ri.vLast2;
		SELF.result.ShipTo.VerifiedInput.Name.Suffix := ri.vSuffix2;	
		SELF.result.ShipTo.VerifiedInput.Name.Prefix := ri.vPrefix2;
		SELF.result.ShipTo.VerifiedInput.Address.StreetAddress1 := ri.vAddress2;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetAddress2 := ri.vAddress22;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetNumber := ri.vStNum2;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetName := ri.vStName2;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetSuffix := ri.vstsuffix2;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetPreDirection := ri.vpredir2;	
		SELF.result.ShipTo.VerifiedInput.Address.StreetPostDirection := ri.vpostdir2;	
		SELF.result.ShipTo.VerifiedInput.Address.UnitDesignation := ri.vunitdesig2;	
		SELF.result.ShipTo.VerifiedInput.Address.UnitNumber := ri.vunitNum2;
		SELF.result.ShipTo.VerifiedInput.Address.county := ri.vcounty2;	
		SELF.result.ShipTo.VerifiedInput.Address.PostalCode := ri.vPostalCo2;	
		SELF.result.ShipTo.VerifiedInput.Address.StateCityZip := ri.vstcityzip2;
		SELF.result.ShipTo.VerifiedInput.Address.City := ri.vCity2;	
		SELF.result.ShipTo.VerifiedInput.Address.State := ri.vState2;
		SELF.result.ShipTo.VerifiedInput.Address.Zip5 := ri.vZip52;	
		SELF.result.ShipTo.VerifiedInput.Address.Zip4 := ri.vzip42;
		//bill to - corrected
		SELF.result.ShipTo.InputCorrected.Name.Full := ri.cFull2;	
		SELF.result.ShipTo.InputCorrected.Name.First := ri.cFirst2;	
		SELF.result.ShipTo.InputCorrected.Name.Middle := ri.cMiddle2;	
		SELF.result.ShipTo.InputCorrected.Name.Last := ri.cLast2;
		SELF.result.ShipTo.InputCorrected.Name.Suffix := ri.cSuffix2;	
		SELF.result.ShipTo.InputCorrected.Name.Prefix := ri.cPrefix2;
		SELF.result.ShipTo.InputCorrected.Address.StreetAddress1 := ri.cAddress2;	
		SELF.result.ShipTo.InputCorrected.Address.StreetAddress2 := ri.cAddress22;	
		SELF.result.ShipTo.InputCorrected.Address.StreetNumber := ri.cStNum2;	
		SELF.result.ShipTo.InputCorrected.Address.StreetName := ri.cStName2;	
		SELF.result.ShipTo.InputCorrected.Address.StreetSuffix := ri.cstsuffix2;
		SELF.result.ShipTo.InputCorrected.Address.StreetPreDirection := ri.cpredir2;	
		SELF.result.ShipTo.InputCorrected.Address.StreetPostDirection := ri.cpostdir2;	
		SELF.result.ShipTo.InputCorrected.Address.UnitDesignation := ri.cunitdesig2;	
		SELF.result.ShipTo.InputCorrected.Address.UnitNumber := ri.cunitNum2;
		SELF.result.ShipTo.InputCorrected.Address.county := ri.ccounty2;	
		SELF.result.ShipTo.InputCorrected.Address.PostalCode := ri.cPostalCo2;	
		SELF.result.ShipTo.InputCorrected.Address.StateCityZip := ri.cstcityzip2;
		SELF.result.ShipTo.InputCorrected.Address.City := ri.cCity2;	
		SELF.result.ShipTo.InputCorrected.Address.State := ri.cState2;
		SELF.result.ShipTo.InputCorrected.Address.Zip5 := ri.cZip52;	
		SELF.result.ShipTo.InputCorrected.Address.Zip4 := ri.czip42;
		SELF.Result.ShipTo.InputCorrected.Phone10 := ri.cphone2;
		SELF.Result.ShipTo.InputCorrected.SSN := ri.cssn2;
		//bill to - newarea
		SELF.Result.ShipTo.NewAreaCode.AreaCode := ri.areacode2;
		SELF.Result.ShipTo.NewAreaCode.EffectiveDate.year:= (integer) ri.areayear2;
		SELF.Result.ShipTo.NewAreaCode.EffectiveDate.Month:= (integer) ri.areamonth2;
		SELF.Result.ShipTo.NewAreaCode.EffectiveDate.day:= (integer) ri.areaday2;
		//bill to - extras
		SELF.Result.ShipTo.NameAddressSSNSummary := ri.nas2;
		SELF.Result.ShipTo.NameAddressPhoneSummary := ri.nap2;
		SELF.Result.ShipTo.PhoneOfNameAddress := ri.phnameaddr2;
		SELF.Result.ShipTo.PhoneType  := ri.phonetype2;
		SELF.Result.ShipTo.DwellingType := ri.dwelltype2;
		self.Result.ShipTo.SIC := (string)ri.sic2;                              
		//ip info
		self.Result.IPAddressID.Continent := ri.ipcontinen;
		self.Result.IPAddressID.RoutingType := ri.iproutetyp;
		self.Result.IPAddressID.TopLevelDomain := ri.topdomain;
		self.Result.IPAddressID.AreaCode := ri.iparea;
		self.Result.IPAddressID.SecondLevelDomain := ri.secdomain;
		self.Result.IPAddressID.Country := ri.ipcountry;
		self.Result.IPAddressID.State := ri.ipstate;
		self.Result.IPAddressID.Zip := ri.ipzip;

		SELF.Result := [];
		
	END;	
	
	os_rec := join(inData, Seed_Files.Key_OS,
			keyed(right.table_name=Test_Data_Table_Name) and 
			keyed(
				right.hashvalue=Seed_Files.Hash_InstantID(
					(string15)left.fname,
					(string20)left.lname,
					(string9)left.ssn,
					Risk_Indicators.nullstring, // fein
					(string9)left.z5,
					(string10)left.phone10,
					Risk_Indicators.nullstring // company name
				)
			),
			create_output(LEFT,RIGHT), LEFT OUTER, KEEP(1)
	);

	return os_rec;
END;