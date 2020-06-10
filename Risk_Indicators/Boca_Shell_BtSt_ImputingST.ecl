import ut, Risk_Indicators, RiskWise, dx_Gong, AutoKey, Phones, Phonesplus_v2, Data_Services, Email_Data, doxie;

export Boca_Shell_BtSt_ImputingST(DATASET(Risk_Indicators.Layout_CIID_BtSt_In) BtSt_In,
	UNSIGNED1 GLBPurpose, UNSIGNED1 DPPAPurpose, STRING30 IndustryClass = '',
	STRING DataRestriction,
    doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

 integer8 ValidDaysApart(string8 d1, string8 d2) :=
	UT.DaysSince1900(d1[1..4], d1[5..6], d1[7..8]) -
	UT.DaysSince1900(d2[1..4], d2[5..6], d2[7..8]);
	//Gets the input on digital ST records


	//BtSt_In has all input for BT and ST
	//Gets the input on digital ST records
	getSTInput := BtSt_In(Bill_To_In.TypeOfOrder = risk_indicators.iid_constants.DigitalOrder);
	//grab any ship to information that does not have ship to information
	getSTInput_missingInput := getSTInput(Ship_To_In.fname = '' and Ship_To_In.mname = '' and Ship_To_In.lname = '' and Ship_To_In.suffix= '' and
			Ship_To_In.in_streetAddress = '' and Ship_To_In.in_city = '' and  Ship_To_In.in_state = '' and Ship_To_In.in_zipCode  = '' and
			Ship_To_In.prim_range  = '' and Ship_To_In.predir = '' and Ship_To_In.prim_name   = '' and
			Ship_To_In.addr_suffix  = '' and Ship_To_In.postdir  = '' and Ship_To_In.unit_desig    = '' and
			Ship_To_In.sec_range    = '' and Ship_To_In.p_city_name = '' and
			Ship_To_In.st = '' and Ship_To_In.z5 = '' and Ship_To_In.zip4 = '' and
			Ship_To_In.lat = '' and Ship_To_In.long = '' and Ship_To_In.addr_type = '' and
			Ship_To_In.addr_status  = '' and Ship_To_In.county = '' and Ship_To_In.geo_blk   = '' and
			Ship_To_In.dl_number= '' and Ship_To_In.dl_state  = '' and  Ship_To_In.dob  = '' and
			Ship_To_In.did  = 0
			and Ship_To_In.score  = 0);

	getSTInput_impute := getSTInput_missingInput( Ship_To_In.phone10 != '' or Ship_To_In.email_address != ''); //phone only populated

	//if only phone is provided for ST input phone do reverse phone lookup
	//1A. Risk_Indicators.iid_getACsplit

	imp_tmp := record
		 string3 altareacode;
		 Risk_Indicators.Layout_CIID_BtSt_In;
	end;

	tmp_dids := record
		unsigned6 did;
		string8 DateSeen;
		UNSIGNED4 seq;
		unsigned6 fdid;
		unsigned3 historydate;
		string10 phone10;
		string200 email;
	end;

	imp_tmp get_ac_split(Risk_Indicators.Layout_CIID_BtSt_In le, risk_indicators.Key_AreaCode_Change_plus ri) := TRANSFORM
		self.altareacode := ri.new_NPA;
		self := le
	END;

	// Seeing if any other area codes area available
	getSTInput_phoneOnlyAC := JOIN(getSTInput_impute, risk_indicators.Key_AreaCode_Change_plus,
										(integer) LEFT.Ship_To_In.Phone10 <>0 AND
										LENGTH(TRIM(LEFT.Ship_To_In.phone10))=10 AND
										keyed(LEFT.Ship_To_In.phone10[1..3]=RIGHT.old_NPA) AND
										keyed(LEFT.Ship_To_In.phone10[4..6]=RIGHT.old_NXX) and
										(unsigned) (right.permissive_start[1..6]) < left.Ship_To_In.historydate,
										get_ac_split(LEFT,RIGHT),left outer,ATMOST(RiskWise.max_atmost),
									keep(100));

	//1B. EDA to get most recent Lexid from last year of EDA phones
	EDA_Phones_possibilites1 := JOIN (getSTInput_phoneOnlyAC, dx_Gong.key_history_phone(),
															(integer) LEFT.Ship_To_In.Phone10 <>0 AND
																keyed ((LEFT.Ship_To_In.Phone10[4..10] = RIGHT.p7 AND
																LEFT.Ship_To_In.Phone10[1..3] = RIGHT.p3)) and
																RIGHT.did <> 0 and
															 ((LEFT.Ship_To_In.historydate = 999999 and RIGHT.current_flag = TRUE) or
															 (LEFT.Ship_To_In.historydate = 999999 and (unsigned)RIGHT.dt_first_seen[1..6] < LEFT.Ship_To_In.historydate) or
																(LEFT.Ship_To_In.historydate <> 999999 and (unsigned)RIGHT.dt_first_seen[1..6] < LEFT.Ship_To_In.historydate)) and
																//keep only EDA records with phones in last year
																ValidDaysApart(risk_indicators.iid_constants.mygetdate(LEFT.Ship_To_In.historydate), RIGHT.dt_first_seen) < ut.DaysInNYears(1),
															TRANSFORM (tmp_dids,
																			SELF.SEQ := LEFT.Bill_To_In.seq,
																			SELF.DateSeen := RIGHT.dt_last_seen,//should this be date_first_seen? Don't think so
																			SELF.did := RIGHT.did,
																			SELF.Fdid := 0,
																			self.phone10 := right.p3 + right.p7;
																			self.email := '';
																			SELF.historydate := LEFT.Ship_To_In.historydate),
																		ATMOST(RiskWise.max_atmost),
															keep(100));
		EDA_Phones_possibilites2 := JOIN (getSTInput_phoneOnlyAC, dx_Gong.key_history_phone(),
															(integer) LEFT.Ship_To_In.Phone10 <>0
															AND keyed ((LEFT.Ship_To_In.Phone10[4..10] = RIGHT.p7 AND //see if alternate area code returns records
																LEFT.altareacode[1..3] = RIGHT.p3)) and
																RIGHT.did <> 0 and
															 ((LEFT.Ship_To_In.historydate = 999999 and RIGHT.current_flag = TRUE) or
															 (LEFT.Ship_To_In.historydate = 999999 and (unsigned)RIGHT.dt_first_seen[1..6] < LEFT.Ship_To_In.historydate) or
																(LEFT.Ship_To_In.historydate <> 999999 and (unsigned)RIGHT.dt_first_seen[1..6] < LEFT.Ship_To_In.historydate)) and
																//keep only EDA records with phones in last year
																ValidDaysApart(risk_indicators.iid_constants.mygetdate(LEFT.Ship_To_In.historydate), RIGHT.dt_first_seen) < ut.DaysInNYears(1),
															TRANSFORM (tmp_dids,
																			SELF.SEQ := LEFT.Bill_To_In.seq,
																			SELF.DateSeen := RIGHT.dt_last_seen,//should this be date_first_seen? Don't think so
																			SELF.did := RIGHT.did,
																			SELF.Fdid := 0,
																			self.phone10 := right.p3 + right.p7;
																			self.email := '';
																			SELF.historydate := LEFT.Ship_To_In.historydate),
																		ATMOST(RiskWise.max_atmost),
															keep(100));
	EDA_Phones_possibilites := EDA_Phones_possibilites1 + EDA_Phones_possibilites2;
	EDA_Phones := DEDUP(SORT(EDA_Phones_possibilites, seq, -(integer) DateSeen, -(integer) did), seq);

//1C. no EDA, then do PhonesPlus
	getSTInput_phoneOnlyAC_NO_EDA := join(getSTInput_phoneOnlyAC, EDA_Phones,
		LEFT.Bill_To_In.seq = RIGHT.seq,
		transform(LEFT),LEFT ONLY);

	PhoneAutoKey := AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');

	PP_Phones_fdid1 := JOIN(getSTInput_phoneOnlyAC_NO_EDA, PhoneAutoKey,
				TRIM(LEFT.Ship_To_In.Phone10) NOT IN ['', '0'] AND
				keyed(RIGHT.p7 = LEFT.Ship_To_In.Phone10[4..10]) AND
				keyed(RIGHT.p3 = LEFT.Ship_To_In.Phone10[1..3]) ,
					TRANSFORM(tmp_dids,
											SELF.SEQ := LEFT.Bill_To_In.seq,
											SELF.DateSeen := '',
											SELF.did := 0,
											self.FDID := RIGHT.did,
											self.phone10 := right.p3 + right.p7;
											self.email := '';
											self.historydate := LEFT.Ship_To_In.HistoryDate),
											KEEP(1000), ATMOST(RiskWise.max_atmost));

	PP_Phones_fdid2 := JOIN(getSTInput_phoneOnlyAC_NO_EDA, PhoneAutoKey,
				TRIM(LEFT.Ship_To_In.Phone10) NOT IN ['', '0'] AND
				keyed(RIGHT.p7 = LEFT.Ship_To_In.Phone10[4..10]) AND
				keyed(RIGHT.p3 = LEFT.altareacode),
					TRANSFORM(tmp_dids,
											SELF.SEQ := LEFT.Ship_To_In.seq,
											SELF.DateSeen := '',
											SELF.did := 0,
											self.FDID := RIGHT.did,
											self.phone10 := right.p3 + right.p7;
											self.email := '';
											self.historydate := LEFT.Ship_To_In.HistoryDate),
											KEEP(1000), ATMOST(RiskWise.max_atmost));
 PP_Phones_fdid := PP_Phones_fdid1 + PP_Phones_fdid2;
 PP_Phones_possibilites := JOIN(PP_Phones_fdid, Phonesplus_v2.key_phonesplus_fdid,
			LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND
			Phones.Functions.IsPhoneRestricted(
					RIGHT.origstate,
					GLBPurpose,
					DPPAPurpose,
					IndustryClass,
					, //checkRNA
				  RIGHT.datefirstseen,
				  RIGHT.dt_nonglb_last_seen,
					RIGHT.rules,
					RIGHT.src_all,
					DataRestriction
				 ) = FALSE
				 AND RIGHT.did > 0 //saw that sometimes the key has a did of 0
				 and (unsigned3) ((STRING)RIGHT.datelastseen)[1..6] < (unsigned3) left.historydate
				 	and ValidDaysApart(risk_indicators.iid_constants.mygetdate(LEFT.historydate),
					if(((string6) RIGHT.datelastseen)[5..6] = '00', ((string4) RIGHT.datelastseen)[1..4] + '0101',
					(string6) RIGHT.datelastseen + '01')) < ut.DaysInNYears(1),
				TRANSFORM(tmp_dids,
											SELF.SEQ := LEFT.seq,
											SELF.DateSeen := (STRING)RIGHT.datelastseen;
											SELF.did := RIGHT.did,
											self.FDID := RIGHT.did,
											self.phone10 := right.cellphone,
											self.email := '',
											SELF.historydate := LEFT.historydate)
											, KEEP(100), ATMOST(RiskWise.max_atmost));


	PP_Phones := DEDUP(SORT(PP_Phones_possibilites, seq, -(integer) DateSeen, -(integer) did), seq);

	tempCIID_btst_in := record
		Risk_Indicators.Layout_CIID_BtSt_In;
		boolean impute;
	end;

	phone_found_dids := EDA_Phones + PP_Phones;
  //fill in the ship to information with the phone information that we found
	digital_prep_phones := join(getSTInput_impute, phone_found_dids,
		LEFT.Bill_To_In.seq = right.Seq,
		TRANSFORM(tempCIID_btst_in,
			self.Ship_To_In.seq := left.Bill_To_In.seq;
			self.Ship_To_In.did := right.did;
			self.Ship_To_In.Phone10 := right.Phone10;
			self.Impute := if(right.Phone10 != '', true, false);
			self := left),ATMOST(RiskWise.max_atmost),
		left outer);

	Email_possibilites := join(getSTInput_impute, Email_Data.Key_Email_Address,
		LEFT.Ship_To_In.email_address <> '' AND
		keyed(LEFT.Ship_To_In.email_address = RIGHT.clean_email)
		and right.email_src IN Risk_Indicators.iid_constants.setEmailsources
		and right.did <  Risk_Indicators.iid_constants.EmailFakeIds  // don't include Fake DIDs
		and (unsigned)right.date_first_seen[1..6] < left.Ship_To_In.historydate,
		TRANSFORM(tmp_dids,
							SELF.SEQ := LEFT.Bill_To_In.seq, // + 1,
							SELF.DateSeen := (STRING)RIGHT.date_last_seen, //uses last seen so latest email
							SELF.did := RIGHT.did,
							self.FDID := RIGHT.did,
							self.email := RIGHT.clean_email,
							self.phone10 := '';
							SELF.historydate := LEFT.Ship_To_In.historydate)
							, KEEP(100), ATMOST(RiskWise.max_atmost));

	Email_found_dids := DEDUP(SORT(Email_possibilites, seq, -(integer) DateSeen, -(integer) did), seq);

	digital_prep_PhonesEmails := join(digital_prep_phones, Email_found_dids,
		LEFT.Ship_To_In.seq = RIGHT.Seq, //AND
		TRANSFORM(tempCIID_btst_in,
			self.Ship_To_In.did := if(left.Impute, left.Ship_To_In.did, right.did);
			self.Ship_To_In.email_address := if(left.Impute, '', right.email);
			self.Ship_To_In.seq := if(left.Impute, left.Ship_To_In.seq, IF(right.seq = 0, left.ship_to_in.seq, right.Seq));
			self.Impute := true;
			self := left),ATMOST(RiskWise.max_atmost),
		left outer);

	digital_prep_in := join(getSTInput, digital_prep_PhonesEmails,
		left.Bill_To_In.seq = right.Bill_To_In.seq,
		transform(Risk_Indicators.Layout_CIID_BtSt_In,
			ShipToImputed := if(right.impute, true, false);
			self.Ship_To_In.seq := if(ShipToImputed, right.Ship_To_In.Seq, left.Ship_To_In.seq);
			self.Ship_To_In.did := if(ShipToImputed, right.Ship_To_In.did, left.Ship_To_In.did);
			self.Ship_To_In.email_address := if(ShipToImputed, right.Ship_To_In.email_address, left.Ship_To_In.email_address);
			self.Ship_To_In.Phone10 := if(ShipToImputed, right.Ship_To_In.Phone10, left.Ship_To_In.Phone10);
			self := left;
		), ATMOST(RiskWise.max_atmost));

//Get best info for the ST input fields
//Doxie.Mac_Best_Records
glb_ok := ut.PermissionTools.glb.ok(GLBPurpose);
dppa_ok := ut.PermissionTools.dppa.ok(DPPAPurpose);

tmp_CBD_STin := record
	Risk_Indicators.Layout_Input  ;
end;

digital_prep := project(digital_prep_in, transform(tmp_CBD_STin, self := left.Ship_To_In, self := []));

doxie.mac_best_records(digital_prep,
											 did,
											 outfile,
											 dppa_ok,
											 glb_ok,
											 ,
											 doxie.DataRestriction.fixed_DRM);

tmp_CBD_STin AppendBest(tmp_CBD_STin l, recordof(outfile) r) := transform
		self.did := if(l.did != 0, l.did, (UNSIGNED6) R.did);
		self.fname := if(l.fname != '', l.fname, R.fname);
		self.mname := if(l.mname != '', l.mname, R.mname);
		self.lname := if(l.lname != '', l.lname, R.lname);
		self.in_streetAddress := if(l.in_streetAddress != '', l.in_streetAddress,
			Risk_Indicators.MOD_AddressClean.street_address('',R.prim_Range, R.predir, R.prim_name, R.suffix, R.postdir, R.unit_desig, R.sec_range));
		self.in_city := if(l.in_city != '', l.in_city, R.city_name);
		self.in_state := if(l.in_state != '', l.in_state, R.st);
		self.in_zipCode := if(l.in_zipCode != '', l.in_zipCode, R.zip);
		self.prim_range := if(l.prim_range != '', l.prim_range, R.prim_range);
		self.predir := if(l.predir != '', l.predir, R.predir);
		self.prim_name := if(l.prim_name != '', l.prim_name, R.prim_name);
		self.addr_suffix := if(l.addr_suffix != '', l.addr_suffix, R.suffix);
		self.postdir := if(l.postdir != '', l.postdir, R.postdir);
		self.unit_desig := if(l.unit_desig != '', l.unit_desig, R.unit_desig);
		self.sec_range := if(l.sec_range != '', l.sec_range, R.sec_range);
		self.p_city_name := if(l.p_city_name != '', l.p_city_name, R.city_name);
		self.st := if(l.st != '', l.st, R.st);
		self.z5 := if(l.z5 != '', l.z5, R.zip);
		self.zip4 := if(l.zip4 != '', l.zip4, R.zip4);	// use the input zip if cass zip is empty
		self.phone10 := if(l.phone10 != '', l.phone10, R.phone);
		self.ssn := if(l.ssn != '', l.ssn, R.ssn);
		self.dob := if(l.dob != '', l.dob, (string)R.dob);
		// we need the latitude and longitude for the Score_And_Distance_Function to work
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(self.in_streetAddress, self.in_city,
		self.in_state, self.z5);
		self.lat             := clean_a2[146..155];
		self.long            := clean_a2[156..166];
		self.addr_type 				:= risk_indicators.iid_constants.override_addr_type(self.in_streetAddress, clean_a2[139],clean_a2[126..129]);
		self.addr_status     := clean_a2[179..182];
		self.county          := clean_a2[143..145];
		self.geo_blk         := clean_a2[171..177];
		self := l;
end;

STwithBest_ALL := join(digital_prep, outfile,
	LEFT.did = (UNSIGNED6) right.did,
	AppendBest(LEFT, RIGHT),ATMOST(RiskWise.max_atmost),
	left outer);

STwithBest := dedup(sort(STwithBest_ALL, seq, did), seq, did);

BtStWithSTBest := join(STwithBest, BtSt_In,
	left.seq = right.Bill_To_In.seq,
	transform(Risk_Indicators.Layout_CIID_BtSt_In,
		self.Ship_To_In.seq := left.seq;
		self.Ship_To_In.did := left.did;
		self.Ship_To_In.fname := left.fname;
		self.Ship_To_In.mname := left.mname;
		self.Ship_To_In.lname := left.lname;
		self.Ship_To_In.in_streetAddress :=left.in_streetAddress ;
		self.Ship_To_In.in_city := left.in_city;
		self.Ship_To_In.in_state := left.in_state ;
		self.Ship_To_In.in_zipCode := left.in_zipCode;
		self.Ship_To_In.prim_range := left.prim_range ;
		self.Ship_To_In.predir :=left.predir;
		self.Ship_To_In.prim_name :=left.prim_name;
		self.Ship_To_In.addr_suffix := left.addr_suffix ;
		self.Ship_To_In.postdir := left.postdir;
		self.Ship_To_In.unit_desig := left.unit_desig;
		self.Ship_To_In.sec_range := left.sec_range;
		self.Ship_To_In.p_city_name := left.p_city_name;
		self.Ship_To_In.st := left.st;
		self.Ship_To_In.z5 := left.z5;
		self.Ship_To_In.zip4 := left.zip4;
		self.Ship_To_In.phone10 := left.phone10;
		self.Ship_To_In.ssn := left.ssn;
		self.Ship_To_In.dob := left.dob;
		self.Ship_To_In.historydate := RIGHT.Ship_To_In.historydate;
		self.Ship_To_In.historydatetimestamp := RIGHT.Ship_To_In.historydatetimestamp;
		self.Ship_To_In.lat := left.lat;
		self.Ship_To_In.long := left.long;
		self.Ship_To_In.addr_type :=  left.addr_type;
		self.Ship_To_In.addr_status := left.addr_status;
		self.Ship_To_In.county := left.county;
		self.Ship_To_In.geo_blk := left.geo_blk;
		self.Ship_To_In.email_address := left.email_address;

		self.Bill_To_In := right.Bill_To_In,
		self := []));

	 BtStWithSTBest_info := join(BtSt_In, BtStWithSTBest,
	 left.Bill_To_In.seq = right.Bill_To_In.seq,
		transform(Risk_Indicators.Layout_CIID_BtSt_In,
			self.bill_to_in := left.bill_to_in;
			self.ship_to_in := if(left.ship_to_in.seq = right.ship_to_in.seq, right.ship_to_in, left.ship_to_in),
			self := [];),
		left outer);

		// //debug outputs
		// output(BtSt_In, named('BtSt_In'));
		// output(getSTInput_missingInput, named('getSTInput_missingInput'));
		// output(getSTInput_impute, named('getSTInput_impute'));
		// output(getSTInput_phoneOnlyAC, named('getSTInput_phoneOnlyAC'));
		// output(EDA_Phones_possibilites1, named('EDA_Phones_possibilites1'));
		// output(EDA_Phones_possibilites2, named('EDA_Phones_possibilites2'));
		// output(EDA_Phones_possibilites, named('EDA_Phones_possibilites'));
		// output(getSTInput_phoneOnlyAC_NO_EDA, named('getSTInput_phoneOnlyAC_NO_EDA'));
		// output(PP_Phones_fdid1, named('PP_Phones_fdid1'));
		// output(PP_Phones_fdid2, named('PP_Phones_fdid2'));
		// output(PP_Phones_fdid, named('PP_Phones_fdid'));
		// output(PP_Phones_possibilites, named('PP_Phones_possibilites'));
		// output(phone_found_dids, named('phone_found_dids'));
		// output(Email_found_dids, named('Email_found_dids'));
		// output(EDA_Phones, named('EDA_Phones'));
		// output(PP_Phones, named('PP_Phones'));
		// output(Email_possibilites, named('Email_possibilites'));
		// output(digital_prep, named('digital_prep'));
		// output(outfile, named('outfile'));
		// output(STwithBest, named('STwithBest'));
		// output(BtStWithSTBest, named('BtStWithSTBest'));
		// output(digital_prep_phones, named('digital_prep_phones'));
		// output(digital_prep_in, named('digital_prep_in'));
		// output(digital_prep_PhonesEmails, named('digital_prep_PhonesEmails'));

return BtStWithSTBest_info;
end;
