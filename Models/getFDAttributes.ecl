import address, Easi, Risk_Indicators, Riskwise, ut, IdentityManagement_Services, STD, daybatchPCNSR;

export getFDAttributes(grouped DATASET(risk_indicators.Layout_Boca_Shell) clam,
	grouped DATASET(Risk_Indicators.Layout_Output) iid,
	string30 account_value,
	dataset(riskwise.Layout_IP2O) ips,
	string model_name='', //we are passing in attribute group name if paro attributes are requested instead of model name
	boolean suppressCompromisedDLs=false,
  unsigned1 DPPA=0, unsigned1 GLB=0,
  string DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
  string DataPermission=risk_indicators.iid_constants.default_DataPermission,
  string32 appType = ''
	) := FUNCTION


// =============== Get Easi Info =============
layout_prop := Record
	unsigned4 seq;
	string2 st;
	string3 county;
	string7 geo_blk;
end;

layout_prop get_addresses(clam le, integer c) := TRANSFORM
	SELF.st := CHOOSE(c,le.Address_Verification.Input_Address_Information.st,
											le.Address_Verification.Address_History_1.st,
											le.Address_Verification.Address_History_2.st);
	SELF.county := CHOOSE(c,le.Address_Verification.Input_Address_Information.county,
													le.Address_Verification.Address_History_1.county,
													le.Address_Verification.Address_History_2.county);
	SELF.geo_blk := CHOOSE(c,le.Address_Verification.Input_Address_Information.geo_blk,
													 le.Address_Verification.Address_History_1.geo_blk,
													 le.Address_Verification.Address_History_2.geo_blk);
	SELF.seq := le.seq;
	SELF := [];
END;
e_address := NORMALIZE(clam,3,get_addresses (LEFT,COUNTER))(st != '', county != '', geo_blk != '');


used_census := RECORD
	string12 geolink;
	string6 med_hhinc;
	string6 med_hval;
	string6 murders;
	string6 cartheft;
	string6 burglary;
	string6 totcrime;
  string6 hhsize;
END;

Layout_EasiSeq := record
	unsigned seq := 0;
	used_census easi;
ENd;
easi_census := join(e_address, Easi.Key_Easi_Census,
										keyed(right.geolink=left.st+left.county+left.geo_blk),
										transform(Layout_EasiSeq,
															self.seq := left.seq,
															self.easi := right),
															ATMOST(keyed(right.geolink=left.st+left.county+left.geo_blk), Riskwise.max_atmost), KEEP(1));


used_ip := RECORD
	string45 ipaddr;
	string3 countrycode;
	string30 state;
	string20 continent;
END;


layout_bseasi := record, maxlength(100000)
	Risk_Indicators.Layout_Boca_Shell;
	used_census inEasi;
	used_census Easi1;
	used_census Easi2;
	used_ip ip2o;
  Risk_Indicators.Layout_Output iid_out;
END;

layout_bseasi intoWideClam(clam le) := transform
	self := le;
	self := [];
END;
wideClam := project(clam, intoWideClam(LEFT));


layout_bseasi joinEm(wideClam le, easi_census ri) := transform
	Input_match := LE.Address_Verification.Input_Address_Information.st+
				LE.Address_Verification.Input_Address_Information.county+
				LE.Address_Verification.Input_Address_Information.geo_blk=RI.easi.geolink;
	Hist1_Match := LE.Address_Verification.Address_History_1.st+
				LE.Address_Verification.Address_History_1.county+
				LE.Address_Verification.Address_History_1.geo_blk=RI.easi.geolink;
	Hist2_Match := LE.Address_Verification.Address_History_2.st+
				LE.Address_Verification.Address_History_2.county+
				LE.Address_Verification.Address_History_2.geo_blk=RI.easi.geolink;

	self.inEasi := if(Input_match, ri.easi, le.inEasi);
	self.Easi1 := if(Hist1_Match, ri.easi, le.easi1);
	self.Easi2 := if(Hist2_Match, ri.easi, le.easi2);
	self := le;
END;
clamEasi := group( sort(denormalize (wideClam, easi_census,	left.seq = right.seq, joinEm (LEFT,RIGHT)), seq), seq);

layout_bseasi add_iid(clamEasi le, iid ri) := transform
	self.iid_out := ri;
	self := le;

end;

wiid := join(clamEasi, iid, left.seq=right.seq, add_iid(left,right), left outer);

layout_bseasi add_ips(wiid le, ips ri) := transform
	self.ip2o := ri;
	self := le;
end;

wIPs := join(wiid, ips, left.seq=right.seq, add_ips(left,right), left outer);


Prep := project(ungroup(iid), transform(risk_indicators.Layout_input, self := left));

skiptrace_call := riskwise.skip_trace(Prep, DPPA, GLB, DataRestriction,appType, DataPermission);


Models.Layout_FraudAttributes intoAttributes(wIPs le) := TRANSFORM

	fulldate := (unsigned4)((STRING6)le.historyDate+'01');


	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim(((string)histdate)[5..6])='01';
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;

	checkDate6(unsigned3 foundDate) := FUNCTION
			outDate := if(foundDate > le.historyDate, getPreviousMonth(le.historyDate), foundDate);
			return outDate;
	END;

	/* The following accounts for randomized socials - This code is located within Risk_Indicators.iid_getSSNFlags:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
	*/
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.shell_input.ssn, le.iid.socsvalflag, le.iid.socllowissue, le.iid.socsRCISflag);
	ssnLowIssue := le.iid.socllowissue;
	ssnHighIssue := le.iid.soclhighissue;

	self.input.historydate := le.historydate;
	self.input := le.shell_input;
	self.AccountNumber:= account_value;

	// VERSION 1 fields---------------------------------------------------------------------------------------------------------

	// Identity Authentication Attributes
	self.version1.SSNFirstSeen := ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen);
	last_seen := max(le.ssn_verification.header_last_seen, le.ssn_verification.credit_last_seen);
	self.version1.DateLastSeen := checkDate6(last_seen);
	today := (STRING8)Std.Date.Today();
	sysdate := if(le.historydate <> 999999, (integer)(((string)le.historydate)[1..6]), (integer)(today[1..6]));
	self.version1.isRecentUpdate := (sysdate - last_seen) < 100;
	// I moved numSources down below the calculation for current address
	self.version1.isPhoneFullNameMatch := le.iid.nap_summary in [9,12];
	self.version1.isPhoneLastNameMatch := le.iid.nap_summary in [7,9,11,12];
	ageDate := if(le.historydate <> 999999, (unsigned)(((string)le.historydate)[1..6]+'31'), (unsigned)today);
	self.version1.inferredAge := ut.Age(le.reported_dob, ageDate);
	self.version1.isSSNInvalid := ~le.SSN_Verification.Validation.valid;
	self.version1.isPhoneInvalid := le.iid.phonetype <> '1' and le.shell_input.phone10 <> '';
	self.version1.isAddrInvalid := le.iid.addrvalflag='N' and ((le.shell_input.in_StreetAddress<>'' and le.shell_input.in_City<>'' and
																 le.shell_input.in_State<>'') or (le.shell_input.in_StreetAddress<>'' and le.shell_input.in_Zipcode<>''));
	self.version1.isDLInvalid := le.iid.drlcvalflag in ['1','3'];
	self.version1.isNoVer := le.iid.nas_summary <= 4 and le.iid.nap_summary <= 4 and le.address_verification.input_address_information.naprop <= 2;


	// SSN Attributes
	self.version1.isDeceased := le.iid.decsflag='1';
	self.version1.DeceasedDate := if(le.ssn_verification.Validation.deceasedDate>fullDate, 0, le.ssn_verification.Validation.deceasedDate);
	self.version1.isSSNValid := le.SSN_Verification.Validation.valid and le.shell_input.ssn<>'';
	self.version1.isRecentIssue := (sysdate - (INTEGER)(le.iid.soclhighissue[1..6])) < 100 AND sysdate <= Risk_Indicators.iid_constants.randomSSN1Year;
	self.version1.LowIssueDate := if((unsigned)ssnLowIssue>fullDate, 0, (unsigned)ssnLowIssue);
	self.version1.HighIssueDate := if((unsigned)ssnHighIssue>fullDate, 0, (unsigned)ssnHighIssue);
	self.version1.IssueState := le.iid.soclstate;
	self.version1.isNonUS := le.iid.non_us_ssn OR
													 (le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8']);// ITIN logic
	self.version1.isIssued3 := // If it is not a randomized social and only issued within the last 36 months
																(~randomizedSocial AND (sysdate - (INTEGER)(le.iid.socllowissue[1..6])) < 300) OR
																// Or it was possibly randomized and the date is prior to June 25th, 2014
																(randomizedSocial AND sysdate <= Risk_Indicators.iid_constants.randomSSN3Years);
	self.version1.isIssuedAge5 := ((INTEGER)(le.iid.socllowissue[1..6]) - (INTEGER)(le.shell_input.Dob[1..6])) > 500 AND (INTEGER)(le.shell_input.Dob[1..4]) > 1990 AND (INTEGER)(le.shell_input.Dob[1..6]) < 200606;
	self.version1.ssnCode := le.ssn_verification.validation.inputsocscode;


	// Evidence of Compromised Identity
	self.version1.isSSNNotFound := ~le.iid.ssnexists;
	self.version1.isFoundOther := le.iid.nas_summary in [1,2,3,4,5,8] and le.iid.ssnExists and ~le.iid.lastssnmatch2;
	self.version1.isIssuedPrior := le.ssn_verification.validation.dob_mismatch;
	self.version1.isPhoneOther := le.iid.phonelastcount=0 AND le.iid.phoneaddrcount=0 AND le.iid.phonephonecount>0 and ~le.iid.phonevalflag='0';
	self.version1.SSNPerID := le.velocity_counters.ssns_per_adl;
	self.version1.AddrPerID := le.velocity_counters.addrs_per_adl;
	self.version1.PhonePerID := le.velocity_counters.phones_per_adl;
	self.version1.IDPerSSN := le.SSN_Verification.adlPerSSN_count;
	self.version1.AddrPerSSN := le.velocity_counters.addrs_per_ssn;
	self.version1.IDPerAddr := le.velocity_counters.adls_per_addr;
	self.version1.SSNPerAddr := le.velocity_counters.ssns_per_addr;
	self.version1.PhonePerAddr := le.velocity_counters.phones_per_addr;
	self.version1.IDPerPhone := le.velocity_counters.adls_per_phone;
	self.version1.SSNPerID6 := le.velocity_counters.ssns_per_adl_created_6months;
	self.version1.AddrPerID6 := le.velocity_counters.addrs_per_adl_created_6months;
	self.version1.PhonePerID6 := le.velocity_counters.phones_per_adl_created_6months;
	self.version1.IDPerSSN6 := le.velocity_counters.adls_per_ssn_created_6months;
	self.version1.AddrPerSSN6 := le.velocity_counters.addrs_per_ssn_created_6months;
	self.version1.IDPerAddr6 := le.velocity_counters.adls_per_addr_created_6months;
	self.version1.SSNPerAddr6 := le.velocity_counters.ssns_per_addr_created_6months;
	self.version1.PhonePerAddr6 := le.velocity_counters.phones_per_addr_created_6months;
	self.version1.IDPerPhone6 := le.velocity_counters.adls_per_phone_created_6months;


	// Identity Change Information
	self.version1.LastPerSSN := le.SSN_Verification.namePerSSN_count;
	self.version1.LastPerID := le.velocity_counters.lnames_per_adl;
	self.version1.DateLastNameChange := if(le.name_verification.newest_lname_dt_first_seen>le.historyDate, 0, le.name_verification.newest_lname_dt_first_seen);
	self.version1.NewLastName := if(le.name_verification.newest_lname_dt_first_seen>le.historyDate, '', le.name_verification.newest_lname);
	self.version1.LastNames30 := le.velocity_counters.lnames_per_adl30;
	self.version1.LastNames90 := le.velocity_counters.lnames_per_adl90;
	self.version1.LastNames180 := le.velocity_counters.lnames_per_adl180;
	self.version1.LastNames12 := le.velocity_counters.lnames_per_adl12;
	self.version1.LastNames24 := le.velocity_counters.lnames_per_adl24;
	self.version1.LastNames36 := le.velocity_counters.lnames_per_adl36;
	self.version1.LastNames60 := le.velocity_counters.lnames_per_adl60;
	self.version1.IDPerSFDUAddr := if(le.address_validation.error_codes[1]='S', le.velocity_counters.adls_per_addr, 0);
	self.version1.SSNPerSFDUAddr := if(le.address_validation.error_codes[1]='S', le.velocity_counters.ssns_per_addr, 0);


	// Characteristics of Input Address
	self.version1.IAAddress := Risk_Indicators.MOD_AddressClean.street_address('',le.shell_input.prim_range,le.shell_input.predir,
																												 le.shell_input.prim_name,le.shell_input.addr_suffix,
																												 le.shell_input.postdir, le.shell_input.unit_desig,
																												 le.shell_input.sec_range);
	self.version1.IACity := le.shell_input.p_city_name;
	self.version1.IAState := le.shell_input.st;
	self.version1.IAZip := le.shell_input.z5;
	self.version1.IAZip4 := le.shell_input.zip4;
	self.version1.IADateFirstReported := le.address_verification.input_address_information.date_first_seen;
	self.version1.IADateLastReported := checkDate6(le.address_verification.input_address_information.date_last_seen);
	self.version1.IALenOfRes := if(self.version1.IADateFirstReported <> 0 and
																 self.version1.IADateLastReported <> 0,
																		round((ut.DaysApart((string)self.version1.IADateFirstReported,
																												(string)self.version1.IADateLastReported)) / 30),
																 0);
	self.version1.IADwellType := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.version1.IAisNotPrimaryRes := ~le.address_verification.input_address_information.isbestmatch;
	self.version1.IAPhoneListed := le.Address_Verification.edaMatchLevel;
	self.version1.IAPhoneNumber := le.Address_Verification.activePhone;
	self.version1.IAMED_HHINC := le.ineasi.med_hhinc;
	self.version1.IAMED_HVAL := le.ineasi.med_hval;
	self.version1.IAMURDERS := le.ineasi.murders;
	self.version1.IACARTHEFT := le.ineasi.cartheft;
	self.version1.IABURGLARY := le.ineasi.burglary;
	self.version1.IATOTCRIME := le.ineasi.totcrime;


	// Characteristics of Current Address (Most Recent Date First Reported)
	CAaddrChooser := map(le.did=0 => 0,
											 le.address_verification.input_address_information.date_first_seen >=
										   le.address_verification.address_history_1.date_first_seen and
														le.address_verification.input_address_information.date_first_seen >=
														le.address_verification.address_history_2.date_first_seen => 1,	// input is picked
											 le.address_verification.address_history_1.date_first_seen >=
											 le.address_verification.input_address_information.date_first_seen and
														le.address_verification.address_history_1.date_first_seen >=
														le.address_verification.address_history_2.date_first_seen => 2,	// address history 1 is picked
											 3);	// address history 2 is picked

	currAddr := map(CAaddrChooser=0 => '',
									CAaddrChooser=1 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range,
																																 le.address_verification.input_address_information.predir,
																																 le.address_verification.input_address_information.prim_name,
																																 le.address_verification.input_address_information.addr_suffix,
																																 le.address_verification.input_address_information.postdir,
																																 le.address_verification.input_address_information.unit_desig,
																																 le.address_verification.input_address_information.sec_range),
									CAaddrChooser=2 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,
																																 le.address_verification.address_history_1.predir,
																																 le.address_verification.address_history_1.prim_name,
																																 le.address_verification.address_history_1.addr_suffix,
																																 le.address_verification.address_history_1.postdir,
																																 le.address_verification.address_history_1.unit_desig,
																																 le.address_verification.address_history_1.sec_range),
									Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range,
																							le.address_verification.address_history_2.predir,
																							le.address_verification.address_history_2.prim_name,
																							le.address_verification.address_history_2.addr_suffix,
																							le.address_verification.address_history_2.postdir,
																							le.address_verification.address_history_2.unit_desig,
																							le.address_verification.address_history_2.sec_range));
	currAddrSt := map(CAaddrChooser=0 => '',
										CAaddrChooser=1 => le.address_verification.input_address_information.st,
										CAaddrChooser=2 => le.address_verification.address_history_1.st,
										le.address_verification.address_history_2.st);

	// fits in above
	self.version1.NumSources := map(CAaddrChooser=0 => 0,
																	CAaddrChooser=1 => le.address_verification.input_address_information.source_count,
																	CAaddrChooser=2 => le.address_verification.address_history_1.source_count,
																	le.address_verification.address_history_2.source_count);

	self.version1.CAAddress := currAddr;
	self.version1.CACity := map(CAaddrChooser=0 => '',
															CAaddrChooser=1 => le.address_verification.input_address_information.city_name,
															CAaddrChooser=2 => le.address_verification.address_history_1.city_name,
															le.address_verification.address_history_2.city_name);
	self.version1.CAState := currAddrSt;
	self.version1.CAZip := map(CAaddrChooser=0 => '',
														 CAaddrChooser=1 => le.address_verification.input_address_information.zip5/*+le.address_verification.input_address_information.zip4*/,
														 CAaddrChooser=2 => le.address_verification.address_history_1.zip5/*+le.address_verification.address_history_1.zip4*/,
														 le.address_verification.address_history_2.zip5/*+le.address_verification.address_history_2.zip4*/);
	self.version1.CAZip4 := map(CAaddrChooser=0 => '',
															CAaddrChooser=1 => le.shell_input.zip4,
															CAaddrChooser=2 => le.addrhist1zip4,
															le.addrhist2zip4);
	self.version1.CADateFirstReported := map(CAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																					 CAaddrChooser=2 =>	le.address_verification.address_history_1.date_first_seen,
																					 le.address_verification.address_history_2.date_first_seen);
	self.version1.CADateLastReported := checkDate6(
																					map(CAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																							CAaddrChooser=2 =>	le.address_verification.address_history_1.date_last_seen,
																							le.address_verification.address_history_2.date_last_seen));
	self.version1.CALenOfRes := if(self.version1.CADateFirstReported <> 0 and self.version1.CADateLastReported <> 0,
																		round((ut.DaysApart((string)self.version1.CADateFirstReported,
																												(string)self.version1.CADateLastReported)) / 30),
																 0);
	self.version1.CADwellType := map(CAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 CAaddrChooser=2 => le.address_verification.addr_type2,
																	 le.address_verification.addr_type3);
	self.version1.CAisNotPrimaryRes := map(CAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 CAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 ~le.address_verification.address_history_2.isbestmatch);
	self.version1.CAPhoneListed := map(CAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 CAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 le.address_verification.edaMatchLevel3);
	self.version1.CAPhoneNumber := map(CAaddrChooser=1 => le.address_verification.activePhone,
																		 CAaddrChooser=2 => le.address_verification.activePhone2,
																		 le.address_verification.activePhone3);
	 self.version1.CAMED_HHINC := map(CAaddrChooser=1 => le.ineasi.med_hhinc,
																		CAaddrChooser=2 => le.easi1.med_hhinc,
																		le.easi2.med_hhinc);
	self.version1.CAMED_HVAL := map(CAaddrChooser=1 => le.ineasi.med_hval,
																	CAaddrChooser=2 => le.easi1.med_hval,
																	le.easi2.med_hval);
	self.version1.CAMURDERS := map(CAaddrChooser=1 => le.ineasi.murders,
																 CAaddrChooser=2 => le.easi1.murders,
																 le.easi2.murders);
	self.version1.CACARTHEFT := map(CAaddrChooser=1 => le.ineasi.cartheft,
																	CAaddrChooser=2 => le.easi1.cartheft,
																	le.easi2.cartheft);
	self.version1.CABURGLARY := map(CAaddrChooser=1 => le.ineasi.burglary,
																	CAaddrChooser=2 => le.easi1.burglary,
																	le.easi2.burglary);
	self.version1.CATOTCRIME := map(CAaddrChooser=1 => le.ineasi.totcrime,
																	CAaddrChooser=2 => le.easi1.totcrime,
																	le.easi2.totcrime);


	// Characteristics of Previous Address (next most recently reported)
	PAaddrChooser := map(le.did=0 => 0,
											 (le.address_verification.input_address_information.date_first_seen between
														le.address_verification.address_history_1.date_first_seen and
														le.address_verification.address_history_2.date_first_seen) OR
													(le.address_verification.input_address_information.date_first_seen between
															le.address_verification.address_history_2.date_first_seen and
															le.address_verification.address_history_1.date_first_seen) => 1,	// input is picked
											 (le.address_verification.address_history_1.date_first_seen between
														le.address_verification.input_address_information.date_first_seen and
														le.address_verification.address_history_2.date_first_seen) OR
													(le.address_verification.address_history_1.date_first_seen between
														le.address_verification.address_history_2.date_first_seen and
														le.address_verification.input_address_information.date_first_seen) => 2,	// address history 1 is picked
											 3);	// address history 2 is picked

	prevAddr := map(PAaddrChooser=0 => '',
									PAaddrChooser=1 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range,
																																 le.address_verification.input_address_information.predir,
																																 le.address_verification.input_address_information.prim_name,
																																 le.address_verification.input_address_information.addr_suffix,
																																 le.address_verification.input_address_information.postdir,
																																 le.address_verification.input_address_information.unit_desig,
																																 le.address_verification.input_address_information.sec_range),
									PAaddrChooser=2 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_1.prim_range,
																																 le.address_verification.address_history_1.predir,
																																 le.address_verification.address_history_1.prim_name,
																																 le.address_verification.address_history_1.addr_suffix,
																																 le.address_verification.address_history_1.postdir,
																																 le.address_verification.address_history_1.unit_desig,
																																 le.address_verification.address_history_1.sec_range),
									Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range,
																							le.address_verification.address_history_2.predir,
																							le.address_verification.address_history_2.prim_name,
																							le.address_verification.address_history_2.addr_suffix,
																							le.address_verification.address_history_2.postdir,
																							le.address_verification.address_history_2.unit_desig,
																							le.address_verification.address_history_2.sec_range));
	prevAddrSt := map(PAaddrChooser=0 => '',
										PAaddrChooser=1 => le.address_verification.input_address_information.st,
										PAaddrChooser=2 => le.address_verification.address_history_1.st,
										le.address_verification.address_history_2.st);

	self.version1.PAAddress := prevAddr;
	self.version1.PACity := map(PAaddrChooser=0 => '',
															PAaddrChooser=1 => le.address_verification.input_address_information.city_name,
															PAaddrChooser=2 => le.address_verification.address_history_1.city_name,
															le.address_verification.address_history_2.city_name);
	self.version1.PAState := prevAddrSt;
	self.version1.PAZip := map(PAaddrChooser=0 => '',
														 PAaddrChooser=1 => le.address_verification.input_address_information.zip5/*+le.address_verification.input_address_information.zip4*/,
														 PAaddrChooser=2 => le.address_verification.address_history_1.zip5/*+le.address_verification.address_history_1.zip4*/,
														 le.address_verification.address_history_2.zip5/*+le.address_verification.address_history_2.zip4*/);
	self.version1.PAZip4 := map(PAaddrChooser=0 => '',
															PAaddrChooser=1 => le.shell_input.zip4,
															PAaddrChooser=2 => le.addrhist1zip4,
															le.addrhist2zip4);
	self.version1.PADateFirstReported := map(PAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																					 PAaddrChooser=2 =>	le.address_verification.address_history_1.date_first_seen,
																					 le.address_verification.address_history_2.date_first_seen);
	self.version1.PADateLastReported := checkDate6(
																					map(PAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																							PAaddrChooser=2 =>	le.address_verification.address_history_1.date_last_seen,
																							le.address_verification.address_history_2.date_last_seen));
	self.version1.PALenOfRes := if(self.version1.PADateFirstReported <> 0 and self.version1.PADateLastReported <> 0,
																		round((ut.DaysApart((string)self.version1.PADateFirstReported,
																												(string)self.version1.PADateLastReported)) / 30),
																 0);
	self.version1.PADwellType := map(PAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 PAaddrChooser=2 => le.address_verification.addr_type2,
																	 le.address_verification.addr_type3);
	self.version1.PAisNotPrimaryRes := map(PAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 PAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 ~le.address_verification.address_history_2.isbestmatch);
	self.version1.PAPhoneListed := map(PAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 PAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 le.address_verification.edaMatchLevel3);
	self.version1.PAPhoneNumber := map(PAaddrChooser=1 => le.address_verification.activePhone,
																		 PAaddrChooser=2 => le.address_verification.activePhone2,
																		 le.address_verification.activePhone3);
	self.version1.PAMED_HHINC := map(PAaddrChooser=1 => le.ineasi.med_hhinc,
																	 PAaddrChooser=2 => le.easi1.med_hhinc,
																	 le.easi2.med_hhinc);
	self.version1.PAMED_HVAL := map(PAaddrChooser=1 => le.ineasi.med_hval,
																	PAaddrChooser=2 => le.easi1.med_hval,
																	le.easi2.med_hval);
	self.version1.PAMURDERS := map(PAaddrChooser=1 => le.ineasi.murders,
																 PAaddrChooser=2 => le.easi1.murders,
																 le.easi2.murders);
	self.version1.PACARTHEFT := map(PAaddrChooser=1 => le.ineasi.cartheft,
																	PAaddrChooser=2 => le.easi1.cartheft,
																	le.easi2.cartheft);
	self.version1.PABURGLARY := map(PAaddrChooser=1 => le.ineasi.burglary,
																	PAaddrChooser=2 => le.easi1.burglary,
																	le.easi2.burglary);
	self.version1.PATOTCRIME := map(PAaddrChooser=1 => le.ineasi.totcrime,
																	PAaddrChooser=2 => le.easi1.totcrime,
																	le.easi2.totcrime);


	// Differences between Input Address and Current Address
	self.version1.isInputCurrMatch := CAaddrChooser=1;
	self.version1.DistInputCurr := map(CAaddrChooser=1 => 0,// same address as input
																		 CAaddrChooser=2 => le.address_verification.distance_in_2_h1,// compare input to history 1
																		 le.address_verification.distance_in_2_h2);	// compare input to history 2
	self.version1.isDiffState := ~(currAddrSt = StringLib.StringToUpperCase(le.shell_input.in_state));
	self.version1.IncomeDiff := if(~CAaddrChooser=1, if(CAaddrChooser=2, (unsigned)self.version1.CAmed_hhinc - (unsigned)self.version1.IAmed_hhinc,
																																			 (unsigned)self.version1.PAmed_hhinc - (unsigned)self.version1.IAmed_hhinc), 0);
	self.version1.HomeValueDiff := if(~CAaddrChooser=1, if(CAaddrChooser=2, (unsigned)self.version1.CAmed_hval - (unsigned)self.version1.IAmed_hval,
																																					(unsigned)self.version1.PAmed_hval - (unsigned)self.version1.IAmed_hval), 0);
	self.version1.CrimeDiff := if(~CAaddrChooser=1, if(CAaddrChooser=2, (unsigned)self.version1.CAtotcrime - (unsigned)self.version1.IAtotcrime,
																																			(unsigned)self.version1.PAtotcrime - (unsigned)self.version1.IAtotcrime), 0);

	inputEcon := Models.EconCode(le.iid.dwelltype, le.address_verification.input_address_information.assessed_amount,
												le.avm.input_address_information, (unsigned)le.address_verification.input_address_information.census_home_value);
	hist1Econ := Models.EconCode(le.address_verification.addr_type2, le.address_verification.address_history_1.assessed_amount,
												le.avm.address_history_1, (unsigned)le.address_verification.address_history_1.census_home_value);
	hist2Econ := Models.EconCode(le.address_verification.addr_type3, le.address_verification.address_history_2.assessed_amount,
												le.avm.address_history_2, (unsigned)le.address_verification.address_history_2.census_home_value);

	CAeconCode := map(CAaddrChooser=1 => inputEcon,
										CAaddrChooser=2 => hist1Econ,
										hist2Econ);
	PAeconCode := map(PAaddrChooser=1 => inputEcon,
										PAaddrChooser=2 => hist1Econ,
										hist2Econ);

	self.version1.EcoTrajectory := CAeconCode+inputEcon;


	// Differences between Current Address and Previous Address
	self.version1.isInputPrevMatch := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range,
																																le.address_verification.input_address_information.predir,
																																le.address_verification.input_address_information.prim_name,
																																le.address_verification.input_address_information.addr_suffix,
																																le.address_verification.input_address_information.postdir,
																																le.address_verification.input_address_information.unit_desig,
																																le.address_verification.input_address_information.sec_range) =
																																prevAddr;
	self.version1.DistCurrPrev := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.distance_in_2_h1,
																		CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.distance_in_2_h2,
																		CAaddrChooser=2 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=2 => le.address_verification.distance_h1_2_h2,
																		9999);
	self.version1.isDiffState2 := if(~self.version1.isInputPrevMatch, ~(prevAddrSt = currAddrSt), false);
	self.version1.IncomeDiff2 := if(~self.version1.isInputPrevMatch, (unsigned)self.version1.CAmed_hhinc - (unsigned)self.version1.PAmed_hhinc, 0);
	self.version1.HomeValueDiff2 := if(~self.version1.isInputPrevMatch, (unsigned)self.version1.CAmed_hval - (unsigned)self.version1.PAmed_hval, 0);
	self.version1.CrimeDiff2 := if(~self.version1.isInputPrevMatch, (unsigned)self.version1.CAtotcrime - (unsigned)self.version1.PAtotcrime, 0);
	self.version1.EcoTrajectory2 := PAeconCode+CAeconCode;


	// Transient Person Attributes
	self.version1.mobility_indicator := le.mobility_indicator;

	statusAddr1 := map(le.address_verification.input_address_information.applicant_owned or
														le.address_verification.input_address_information.applicant_sold or
														le.address_verification.input_address_information.family_owned or
														le.address_verification.input_address_information.family_sold => 'O',// owned
										 ~le.address_verification.input_address_information.occupant_owned and
														le.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
	statusAddr2 := map(le.address_verification.address_history_1.applicant_owned or
														le.address_verification.address_history_1.applicant_sold or
														le.address_verification.address_history_1.family_owned or
														le.address_verification.address_history_1.family_sold => 'O',// owned
										 ~le.address_verification.address_history_1.occupant_owned and
														le.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
	statusAddr3 := map(le.address_verification.address_history_2.applicant_owned or
														le.address_verification.address_history_2.applicant_sold or
														le.address_verification.address_history_2.family_owned or
														le.address_verification.address_history_2.family_sold => 'O',// owned
										 ~le.address_verification.address_history_2.occupant_owned and
														le.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
										 'U');// unknown;

	self.version1.statusAddr := map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	statusAddr3);

	self.version1.statusAddr2 := map(PAaddrChooser=1 => statusAddr1,
																	 PAaddrChooser=2 => statusAddr2,
																	 statusAddr3);
	self.version1.statusAddr3 := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => statusAddr3,
																	 CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => statusAddr2,
																	 'U'/*if(le.iid.chronodate_first<self.version1.PADateFirstReported, le.iid.chronodate_first,
																				 if(le.iid.chronodate_first2<self.version1.PADateFirstReported, le.iid.chronodate_first2,
																							 le.iid.chronodate_first3))*/);
	self.version1.PADateFirstReported2 := map(PAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																						PAaddrChooser=2 => le.address_verification.address_history_1.date_first_seen,
																						le.address_verification.address_history_2.date_first_seen);
	self.version1.NPADateFirstReported := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.address_history_2.date_first_seen,
																						CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.address_history_1.date_first_seen,
																						if(le.iid.chronodate_first<self.version1.PADateFirstReported, le.iid.chronodate_first,
																									if(le.iid.chronodate_first2<self.version1.PADateFirstReported, le.iid.chronodate_first2,
																												le.iid.chronodate_first3)));// does this make sense?  assuming one of the chronodates is the third address, pick the one that is less than the pa date
	self.version1.addrChanges30 := le.other_address_info.addrs_last30;
	self.version1.addrChanges90 := le.other_address_info.addrs_last90;
	self.version1.addrChanges180 := le.velocity_counters.addrs_per_adl_created_6months;
	self.version1.addrChanges12 := le.other_address_info.addrs_last12;
	self.version1.addrChanges24 := le.other_address_info.addrs_last24;
	self.version1.addrChanges36 := le.other_address_info.addrs_last36;
	self.version1.addrChanges60 := le.other_address_info.addrs_last_5years;


	// Higher Risk Address and Phone Attributes
	self.version1.isAddrHighRisk := le.iid.hriskaddrflag = '4';
	self.version1.isPhoneHighRisk := le.iid.hriskphoneflag = '6';
	self.version1.hriskcmpy := MAP(le.iid.addrcommflag = '1' => le.iid.hriskcmpyphone,
																 le.iid.addrcommflag = '2' => le.iid.hriskcmpy,
																 '');
  self.version1.sic := MAP(le.iid.addrcommflag = '1' => RiskWise.convertSIC(le.iid.hrisksicphone),
													 le.iid.addrcommflag = '2' => RiskWise.convertSIC(le.iid.hrisksic),
													 '');
	self.version1.isAddrPrison := le.iid.hriskaddrflag='4' AND le.iid.hrisksic = '2225';
	self.version1.isZipPOBox := le.iid.zipclass='P';
	self.version1.isZipCorpMil := le.iid.zipclass in ['M','U'];
	self.version1.phoneStatus := map(le.iid.hriskphoneflag = '5' => 'D',
																	 le.iid.phonevalflag in ['1','2'] => 'C',
																	 '');
	self.version1.isPhonePager := le.iid.hriskphoneflag = '2';
	self.version1.isPhoneMobile := le.iid.hriskphoneflag = '1';
	self.version1.isPhoneZipMismatch := le.iid.phonezipflag = '1';
	self.version1.phoneAddrDist := le.iid.disthphoneaddr;
	self.version1.hphonetypeflag := le.iid.hphonetypeflag;
  self.version1.hphonesrvcflag := risk_indicators.PRIIPhoneRiskFlag('').telcordiaServiceType(le.phone_verification.telcordia_type);
	self.version1.areacodesplit := map(le.iid.areacodesplitflag='Y' => '1',
																		 le.iid.reverse_areacodesplitflag='Y' => '2',
																		 '');
  self.version1.altareacode := le.iid.altareacode;
	self.version1.addrval := le.iid.addrvalflag;
  self.version1.invalidaddr := riskwise.certErr(le.shell_input.addr_status, le.shell_input.predir, le.shell_input.prim_name,
																								le.shell_input.addr_suffix, le.shell_input.postdir, le.shell_input.st);


	// Higher Risk Internet Connection Attributes
	self.version1.IPinvalid := trim(le.ip2o.ipaddr)='' and trim(le.shell_input.ip_address)<>'';
	self.version1.IPNonUS := StringLib.StringToUpperCase(le.ip2o.countrycode[1..2]) <> 'US' and trim(StringLib.StringToUpperCase(le.ip2o.countrycode[1..2]))<>'';
	self.version1.IPState := if(StringLib.StringToUpperCase(le.ip2o.countrycode[1..2]) = 'US', StringLib.StringToUpperCase(le.ip2o.state), '');
	self.version1.IPCountry := StringLib.StringToUpperCase(le.ip2o.countrycode);
	self.version1.IPContinent := le.ip2o.continent;


	le_clam := row( le, risk_indicators.Layout_Boca_Shell );
	le_inEASI := project( le.inEasi, transform(EASI.Layout_Easi_Census, self := left, self := []) );
	le_Easi1 := project( le.Easi1, transform(EASI.Layout_Easi_Census, self := left, self := []) );
	le_Easi2 := project( le.Easi2, transform(EASI.Layout_Easi_Census, self := left, self := []) );
	le_IP2O := project( le.IP2O, transform(riskwise.Layout_IP2O, self := left, self := []) );
	isFCRA := false;

	attr := models.Attributes_Master(le_clam, isFCRA, le_inEASI, le_Easi1, le_Easi2, ,le_IP2O );

  self.version2.IdentityRiskLevel	:=	attr.IdentityRiskLevel		;
  self.version2.IdentityAgeOldest	:=	attr.AgeOldestRecord		;
  self.version2.IdentityAgeNewest	:=	attr.AgeNewestRecord		;
  self.version2.IdentityRecentUpdate	:=	attr.RecentUpdate		;
  self.version2.IdentityRecordCount	:=	attr.IdentityRecordCount		;
  self.version2.IdentitySourceCount	:=	attr.IdentitySourceCount		;
  self.version2.IdentityAgeRiskIndicator	:=	attr.AgeRiskIndicator		;
  self.version2.IDVerRiskLevel	:=	attr.IDVerRiskLevel		;
  self.version2.IDVerSSN	:=	attr.IDVerSSN	;
  self.version2.IDVerName	:=	attr.VerifiedName		;
  self.version2.IDVerAddress	:=	attr.VerifiedAddress		;
  self.version2.IDVerAddressNotCurrent	:=	attr.VerAddressNotCurrent		;
  self.version2.IDVerAddressAssocCount	:=	attr.VerAddressAssocCount		;
  self.version2.IDVerPhone	:=	attr.VerifiedPhone		;
  self.version2.IDVerDriversLicense	:=	attr.verifiedDL		;
  self.version2.IDVerDOB	:=	attr.VerifiedDOB		;
  self.version2.IDVerSSNSourceCount	:=	attr.VerSSNSourceCount		;
  self.version2.IDVerAddressSourceCount	:=	attr.IDVerAddressSourceCount	;
  // self.version2.IDVerPhoneSourceCount	:=	attr.VerPhoneSourceCount		;
  self.version2.IDVerDOBSourceCount	:=	attr.VerDOBSourceCount		;
  self.version2.IDVerSSNCreditBureauCount	:=	attr.VerSSNCreditBureauCount		;
  self.version2.IDVerSSNCreditBureauDelete	:=	attr.IDVerSSNCreditBureauDelete		;
  self.version2.IDVerAddrCreditBureauCount	:=	attr.VerAddrCreditBureauCount		;
  self.version2.SourceRiskLevel	:=	attr.SourceRiskLevel		;
  self.version2.SourceFirstReportingIdentity	:=	attr.SourceFirstReportingIdentity		;
  self.version2.SourceCreditBureau	:=	attr.SourceCreditBureau		;
  self.version2.SourceCreditBureauCount	:=	attr.SourceCreditBureauCount	;
  self.version2.SourceCreditBureauAgeOldest	:=	attr.SourceCreditBureauAgeOldest		;
  self.version2.SourceCreditBureauAgeNewest	:=	attr.SourceCreditBureauAgeNewest		;
  self.version2.SourceCreditBureauAgeChange	:=	attr.SourceCreditBureauAgeChange		;
  self.version2.SourcePublicRecord	:=	attr.SourcePublicRecord		;
  self.version2.SourcePublicRecordCount	:=	attr.SourcePublicRecordCount		;
  self.version2.SourcePublicRecordCountYear	:=	attr.SourcePublicRecordCountYear		;
  self.version2.SourceEducation	:=	attr.EducationAttendedCollege		;
  self.version2.SourceOccupationalLicense	:=	attr.SourceOccupationalLicense		;
  self.version2.SourceVoterRegistration	:=	attr.VoterRegistrationRecord;
  self.version2.SourceOnlineDirectory	:=	attr.SourceOnlineDirectory		;
  self.version2.SourceDoNotMail	:=	attr.SourceDoNotMail		;
  self.version2.SourceAccidents	:=	attr.SourceAccidents		;
  self.version2.SourceBusinessRecords	:=	attr.SourceBusinessRecords		;
  self.version2.SourceProperty	:=	attr.PropertyOwner		;
  self.version2.SourceAssets	:=	attr.SourceAssets	;
  self.version2.SourcePhoneDirectoryAssistance	:=	attr.SourcePhoneDirectoryAssistance		;
  self.version2.SourcePhoneNonPublicDirectory	:=	attr.SourcePhoneNonPublicDirectory		;
  self.version2.VariationRiskLevel	:=	attr.VariationRiskLevel		;
  self.version2.VariationIdentityCount	:=	attr.VariationIdentityCount		;
  self.version2.VariationSSNCount	:=	attr.VariationSSNCount		;
  self.version2.VariationSSNCountNew	:=	attr.VariationSSNCountNew		;
  self.version2.VariationMSourcesSSNCount	:=	attr.VariationMSourcesSSNCount		;
  self.version2.VariationMSourcesSSNUnrelCount	:=	attr.VariationMSourcesSSNUnrelCount		;
  self.version2.VariationLastNameCount	:=	attr.VariationLastNameCount		;
  self.version2.VariationLastNameCountNew	:=	attr.VariationLastNameCountNew		;
  self.version2.VariationAddrCountYear	:=	attr.AddrChangeCount12		;
  self.version2.VariationAddrCountNew	:=	attr.AddrChangeCount06		;
  self.version2.VariationAddrStability	:=	attr.AddrStability		;
  self.version2.VariationAddrChangeAge	:=	attr.AddrMostRecentMoveAge	;
  self.version2.VariationDOBCount	:=	attr.VariationDOBCount		;
  self.version2.VariationDOBCountNew	:=	attr.VariationDOBCountNew		;
  self.version2.VariationPhoneCount	:=	attr.SubjectPhoneCount		;
  self.version2.VariationPhoneCountNew	:=	attr.SubjectPhoneRecentCount	;
  self.version2.VariationSearchSSNCount	:=	attr.PRSearchIdentitySSNs		;
  self.version2.VariationSearchAddrCount	:=	attr.PRSearchIdentityAddrs 		;
  self.version2.VariationSearchPhoneCount	:=	attr.PRSearchIdentityPhones 		;
  self.version2.SearchVelocityRiskLevel	:=	attr.PRSearchVelocityRiskLevel		;
  self.version2.SearchCount	:=	attr.PRSearchCount		;
  self.version2.SearchCountYear	:=	attr.PRSearchCountYear		;
  self.version2.SearchCountMonth	:=	attr.PRSearchCountMonth	;
  self.version2.SearchCountWeek	:=	attr.PRSearchCountWeek		;
  self.version2.SearchCountDay	:=	attr.PRSearchCountDay		;
  self.version2.SearchUnverifiedSSNCountYear	:=	attr.PRSearchUnverifiedSSNCountYear		;
  self.version2.SearchUnverifiedAddrCountYear	:=	attr.PRSearchUnverifiedAddrCountYear		;
  self.version2.SearchUnverifiedDOBCountYear	:=	attr.PRSearchUnverifiedDOBCountYear		;
  self.version2.SearchUnverifiedPhoneCountYear	:=	attr.PRSearchUnverifiedPhoneCountYear	;
  self.version2.SearchBankingSearchCount	:=	attr.PRSearchBankingSearchCount		;
  self.version2.SearchBankingSearchCountYear	:=	attr.PRSearchBankingSearchCountYear			;
  self.version2.SearchBankingSearchCountMonth	:=	attr.PRSearchBankingSearchCountMonth			;
  self.version2.SearchBankingSearchCountWeek	:=	attr.PRSearchBankingSearchCountWeek			;
  self.version2.SearchBankingSearchCountDay	:=	attr.PRSearchBankingSearchCountDay			;
  self.version2.SearchHighRiskSearchCount	:=	attr.PRSearchHighRiskSearchCount		;
  self.version2.SearchHighRiskSearchCountYear	:=	attr.PRSearchHighRiskSearchCountYear		;
  self.version2.SearchHighRiskSearchCountMonth	:=	attr.PRSearchHighRiskSearchCountMonth		;
  self.version2.SearchHighRiskSearchCountWeek	:=	attr.PRSearchHighRiskSearchCountWeek		;
  self.version2.SearchHighRiskSearchCountDay	:=	attr.PRSearchHighRiskSearchCountDay		;
  self.version2.SearchFraudSearchCount	:=	attr.PRSearchFraudSearchCount		;
  self.version2.SearchFraudSearchCountYear	:=	attr.PRSearchFraudSearchCountYear		;
  self.version2.SearchFraudSearchCountMonth	:=	attr.PRSearchFraudSearchCountMonth		;
  self.version2.SearchFraudSearchCountWeek	:=	attr.PRSearchFraudSearchCountWeek		;
  self.version2.SearchFraudSearchCountDay	:=	attr.PRSearchFraudSearchCountDay		;
  self.version2.SearchLocateSearchCount	:=	attr.PRSearchLocateCount		;
  self.version2.SearchLocateSearchCountYear	:=	attr.PRSearchLocateCount12		;
  self.version2.SearchLocateSearchCountMonth	:=	attr.PRSearchLocateCount01		;
  self.version2.SearchLocateSearchCountWeek	:=	attr.PRSearchLocateCountWeek		;
  self.version2.SearchLocateSearchCountDay	:=	attr.PRSearchLocateCountDay		;
  self.version2.AssocRiskLevel	:=	attr.AssocRiskLevel		;
  self.version2.AssocCount	:=	attr.AssocCount		;
  self.version2.AssocDistanceClosest	:=	attr.AssocDistanceClosest		;
  self.version2.AssocSuspicousIdentitiesCount	:=	attr.AssocSuspicousIdentitiesCount		;
  self.version2.AssocCreditBureauOnlyCount	:=	attr.AssocCreditBureauOnlyCount		;
  self.version2.AssocCreditBureauOnlyCountMonth	:=	attr.AssocCreditBureauOnlyCountMonth		;
  self.version2.AssocCreditBureauOnlyCountNew	:=	attr.AssocCreditBureauOnlyCountNew		;
  self.version2.AssocHighRiskTopologyCount	:=	attr.AssocHighRiskTopologyCount		;
  self.version2.ValidationRiskLevel	:=	attr.ValidationRiskLevel		;
  self.version2.ValidationSSNProblems	:=	attr.ValidationSSNProblems		;
  self.version2.ValidationAddrProblems	:=	attr.ValidationAddrProblems		;
  self.version2.ValidationPhoneProblems	:=	attr.ValidationPhoneProblems		;
  self.version2.ValidationDLProblems	:=	attr.InvalidDL		;
  self.version2.ValidationIPProblems	:=	attr.IP_problems		;
  self.version2.CorrelationRiskLevel	:=	attr.CorrelationRiskLevel		;
  self.version2.CorrelationSSNNameCount	:=	attr.CorrelationSSNNameCount		;
  self.version2.CorrelationSSNAddrCount	:=	attr.CorrelationSSNAddrCount		;
  self.version2.CorrelationAddrNameCount	:=	attr.CorrelationAddrNameCount		;
  self.version2.CorrelationAddrPhoneCount	:=	attr.CorrelationAddrPhoneCount		;
  self.version2.CorrelationPhoneLastNameCount	:=	attr.CorrelationPhoneLastNameCount ;
  self.version2.DivRiskLevel	:=	attr.DivRiskLevel		;
  self.version2.DivSSNIdentityCount	:=	attr.DivSSNIdentityCount		;
  self.version2.DivSSNIdentityCountNew	:=	attr.DivSSNIdentityCountNew		;
  self.version2.DivSSNIdentityMSourceCount	:=	attr.DivSSNIdentityMSourceCount		;
  self.version2.DivSSNIdentityMSourceUrelCount	:=	attr.DivSSNIdentityMSourceUrelCount		;
  self.version2.DivSSNLNameCount	:=	attr.DivSSNLNameCount		;
  self.version2.DivSSNLNameCountNew	:=	attr.DivSSNLNameCountNew		;
  self.version2.DivSSNAddrCount	:=	attr.DivSSNAddrCount		;
  self.version2.DivSSNAddrCountNew	:=	attr.DivSSNAddrCountNew		;
  self.version2.DivSSNAddrMSourceCount	:=	attr.DivSSNAddrMSourceCount		;
  self.version2.DivAddrIdentityCount	:=	attr.DivAddrIdentityCount		;
  self.version2.DivAddrIdentityCountNew	:=	attr.DivAddrIdentityCountNew		;
  self.version2.DivAddrIdentityMSourceCount	:=	attr.DivAddrIdentityMSourceCount		;
  self.version2.DivAddrSuspIdentityCountNew	:=	attr.DivAddrSuspIdentityCountNew		;
  self.version2.DivAddrSSNCount	:=	attr.DivAddrSSNCount		;
  self.version2.DivAddrSSNCountNew	:=	attr.DivAddrSSNCountNew		;
  self.version2.DivAddrSSNMSourceCount	:=	attr.DivAddrSSNMSourceCount		;
  self.version2.DivAddrPhoneCount	:=	attr.DivAddrPhoneCount		;
  self.version2.DivAddrPhoneCountNew	:=	attr.DivAddrPhoneCountNew		;
  self.version2.DivAddrPhoneMSourceCount	:=	attr.DivAddrPhoneMSourceCount		;
  self.version2.DivPhoneIdentityCount	:=	attr.DivPhoneIdentityCount		;
  self.version2.DivPhoneIdentityCountNew	:=	attr.DivPhoneIdentityCountNew		;
  self.version2.DivPhoneIdentityMSourceCount	:=	attr.DivPhoneIdentityMSourceCount		;
  self.version2.DivPhoneAddrCount	:=	attr.DivPhoneAddrCount		;
  self.version2.DivPhoneAddrCountNew	:=	attr.DivPhoneAddrCountNew		;
  self.version2.DivSearchSSNIdentityCount	:=	attr.DivSearchSSNIdentityCount		;
  self.version2.DivSearchAddrIdentityCount	:=	attr.DivSearchAddrIdentityCount		;
  self.version2.DivSearchAddrSuspIdentityCount	:=	attr.DivSearchAddrSuspIdentityCount		;
  self.version2.DivSearchPhoneIdentityCount	:=	attr.DivSearchPhoneIdentityCount		;

  self.version2.SearchComponentRiskLevel	:=	attr.PRSearchComponentRiskLevel		;
  self.version2.SearchSSNSearchCount	:=	attr.PRSearchSSNSearchCount		;
  self.version2.SearchSSNSearchCountYear	:=	attr.PRSearchSSNSearchCountYear		;
  self.version2.SearchSSNSearchCountMonth	:=	attr.PRSearchSSNSearchCountMonth		;
  self.version2.SearchSSNSearchCountWeek	:=	attr.PRSearchSSNSearchCountWeek		;
  self.version2.SearchSSNSearchCountDay	:=	attr.PRSearchSSNSearchCountDay		;
  self.version2.SearchAddrSearchCount	:=	attr.PRSearchAddrSearchCount		;
  self.version2.SearchAddrSearchCountYear	:=	attr.PRSearchAddrSearchCountYear		;
  self.version2.SearchAddrSearchCountMonth	:=	attr.PRSearchAddrSearchCountMonth		;
  self.version2.SearchAddrSearchCountWeek	:=	attr.PRSearchAddrSearchCountWeek		;
  self.version2.SearchAddrSearchCountDay	:=	attr.PRSearchAddrSearchCountDay		;
  self.version2.SearchPhoneSearchCount	:=	attr.PRSearchPhoneSearchCount		;
  self.version2.SearchPhoneSearchCountYear	:=	attr.PRSearchPhoneSearchCountYear		;
  self.version2.SearchPhoneSearchCountMonth	:=	attr.PRSearchPhoneSearchCountMonth		;
  self.version2.SearchPhoneSearchCountWeek	:=	attr.PRSearchPhoneSearchCountWeek		;
  self.version2.SearchPhoneSearchCountDay	:=	attr.PRSearchPhoneSearchCountDay		;
  self.version2.ComponentCharRiskLevel	:=	attr.ComponentCharRiskLevel		;
  self.version2.SSNHighIssueAge	:=	attr.SSNHighIssueAge		;
  self.version2.SSNLowIssueAge	:=	attr.SSNLowIssueAge		;
  self.version2.SSNIssueState	:=	attr.SSNIssueState		;
  self.version2.SSNNonUS	:=	attr.SSNNonUS		;
  self.version2.InputPhoneType	:=	attr.InputPhoneType		;
  self.version2.IPState	:=	attr.IPState		;
  self.version2.IPCountry	:=	attr.IPCountry		;
  self.version2.IPContinent	:=	attr.IPContinent		;
  self.version2.InputAddrAgeOldest	:=	attr.InputAddrAgeOldestRecord		;
  self.version2.InputAddrAgeNewest	:=	attr.InputAddrAgeNewestRecord		;
  self.version2.InputAddrType	:=	attr.InputAddrType		;
  self.version2.InputAddrLenOfRes	:=	attr.InputAddrLenOfRes		;
  self.version2.InputAddrDwellType	:=	attr.InputAddrDwellType		;
  self.version2.InputAddrDelivery	:=	attr.InputAddrDelivery		;
  self.version2.InputAddrActivePhoneList	:=	attr.InputAddrActivePhoneList		;
  self.version2.InputAddrOccupantOwned	:=	attr.FP_InputAddrOccupantOwned		;
  self.version2.InputAddrBusinessCount	:=	attr.BusinessInputAddrCount	;
  self.version2.InputAddrNBRHDBusinessCount	:=	attr.InputAddrNBRHDBusinessCount		;
  self.version2.InputAddrNBRHDSingleFamilyCount	:=	attr.InputAddrNBRHDSingleFamilyCount		;
  self.version2.InputAddrNBRHDMultiFamilyCount	:=	attr.InputAddrNBRHDMultiFamilyCount		;
  self.version2.InputAddrNBRHDMedianIncome	:=	attr.IACensus.MedianIncome		;
  self.version2.InputAddrNBRHDMedianValue	:=	attr.IACensus.MedianValue		;
  self.version2.InputAddrNBRHDMurderIndex	:=	attr.IACensus.Murder		;
  self.version2.InputAddrNBRHDCarTheftIndex	:=	attr.IACensus.CarTheft		;
  self.version2.InputAddrNBRHDBurglaryIndex	:=	attr.IACensus.Burglary	;
  self.version2.InputAddrNBRHDCrimeIndex	:=	attr.IACensus.Crime		;
  self.version2.InputAddrNBRHDMobilityIndex	:=	attr.InputAddrMobilityIndex		;
  self.version2.InputAddrNBRHDVacantPropCount	:=	attr.InputAddrNBRHDVacantPropCount		;
  self.version2.AddrChangeDistance	:=	attr.AddrMostRecentDistance		;
  self.version2.AddrChangeStateDiff	:=	attr.AddrMostRecentStateDiff		;
  self.version2.AddrChangeIncomeDiff	:=	attr.AddrMostRecentIncomeDiff		;
  self.version2.AddrChangeValueDiff	:=	attr.AddrMostRecentValueDIff		;
  self.version2.AddrChangeCrimeDiff	:=	attr.AddrMostRecentCrimeDiff		;
  self.version2.AddrChangeEconTrajectory	:=	attr.AddrRecentEconTrajectory		;
  self.version2.AddrChangeEconTrajectoryIndex	:=	attr.AddrRecentEconTrajectoryIndex		;
  self.version2.CurrAddrAgeOldest	:=	attr.CurrAddrAgeOldestRecord		;
  self.version2.CurrAddrAgeNewest	:=	attr.CurrAddrAgeNewestRecord		;
  self.version2.CurrAddrLenOfRes	:=	attr.CurrAddrLenOfRes		;
  self.version2.CurrAddrDwellType	:=	attr.CurrAddrDwellType		;
  self.version2.CurrAddrStatus	:=	attr.StatusMostRecent		;
  self.version2.CurrAddrActivePhoneList	:=	attr.CurrAddrActivePhoneList		;
  self.version2.CurrAddrMedianIncome	:=	attr.CACensus.MedianIncome		;
  self.version2.CurrAddrMedianValue	:=	attr.CACensus.MedianValue		;
  self.version2.CurrAddrMurderIndex	:=	attr.CACensus.Murder		;
  self.version2.CurrAddrCarTheftIndex	:=	attr.CACensus.CarTheft		;
  self.version2.CurrAddrBurglaryIndex	:=	attr.CACensus.Burglary		;
  self.version2.CurrAddrCrimeIndex	:=	attr.CACensus.Crime		;
  self.version2.PrevAddrAgeOldest	:=	attr.PrevAddrAgeOldestRecord		;
  self.version2.PrevAddrAgeNewest	:=	attr.PrevAddrAgeNewestRecord		;
  self.version2.PrevAddrLenOfRes	:=	attr.PrevAddrLenOfRes		;
  self.version2.PrevAddrDwellType	:=	attr.PrevAddrDwellType		;
  self.version2.PrevAddrStatus	:=	attr.StatusPrevious		;
  self.version2.PrevAddrOccupantOwned	:=	attr.PrevAddrOccupantOwned		;
  self.version2.PrevAddrMedianIncome	:=	attr.PACensus.MedianIncome		;
  self.version2.PrevAddrMedianValue	:=	attr.PACensus.MedianValue		;
  self.version2.PrevAddrMurderIndex	:=	attr.PACensus.Murder		;
  self.version2.PrevAddrCarTheftIndex	:=	attr.PACensus.CarTheft		;
  self.version2.PrevAddrBurglaryIndex	:=	attr.PACensus.Burglary		;
  self.version2.PrevAddrCrimeIndex	:=	attr.PACensus.Crime		;

  invalidIdAddr := le.did=0 or not le.input_validation.Address;
  invalidIdDl := le.did=0 or attr.InvalidDL='-1';

  self.version201.IDVerAddressMatchesCurrent := map(invalidIdAddr => '-1',
                                                    le.Address_Verification.Address_History_1.address_score in [90, 100] => '1',
                                                    '0');
  self.version201.IDVerAddressVoter := map(invalidIdAddr => '-1',
                                            Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'VO' , ', ', 'E') > 0 => '1',
                                            '0');
  self.version201.IDVerAddressVehicleRegistation :=  map(invalidIdAddr => '-1',
                                            Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'V' , ', ', 'E') > 0 => '1',
                                            '0');
  self.version201.IDVerAddressDriversLicense :=  map(invalidIdAddr => '-1',
                                            (Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'CY' , ', ', 'E') > 0) AND
                                            (Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'D' , ', ', 'E') > 0) => '3',
                                            Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'D' , ', ', 'E') > 0 => '2',
                                            Models.Common.findw_cpp(le.address_sources_summary.input_addr_sources, 'CY' , ', ', 'E') > 0 => '1',
                                            '0');

  self.version201.IDVerDriversLicenseType := map(invalidIdDl => '-1',
                                            (Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'CY' , ', ', 'E') > 0) AND
                                            (Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'D' , ', ', 'E') > 0) AND
                                            (le.iid_out.insurance_dl_used)                                                     => '7',
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'D' , ', ', 'E') > 0 AND
                                            (le.iid_out.insurance_dl_used)                                                     => '6',
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'CY' , ', ', 'E') > 0 AND
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'D' , ', ', 'E') > 0       => '5',
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'CY' , ', ', 'E') > 0 AND
                                            (le.iid_out.insurance_dl_used)                                                     => '4',
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'D' , ', ', 'E') > 0       => '3',
                                            (le.iid_out.insurance_dl_used)                                                     => '2',
                                            Models.Common.findw_cpp(le.iid_out.verified_DL_sources, 'CY' , ', ', 'E') > 0      => '1',
                                            '0');
  self.version201.IDVerSSNDriversLicense := map(le.did=0 or not le.input_validation.ssn => '-1',
                                            (Models.Common.findw_cpp(le.header_summary.ver_ssn_sources, 'CY' , ', ', 'E') > 0) AND
                                            (Models.Common.findw_cpp(le.header_summary.ver_ssn_sources, 'D' , ', ', 'E') > 0) => '3',
                                            Models.Common.findw_cpp(le.header_summary.ver_ssn_sources, 'D' , ', ', 'E') > 0 => '2',
                                            Models.Common.findw_cpp(le.header_summary.ver_ssn_sources, 'CY' , ', ', 'E') > 0 => '1',
                                            '0');
  self.version201.SourceVehicleRegistration := map(le.did=0 => '-1',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'V' , ', ', 'E') > 0 => '1',
                                            '0');
  self.version201.SourceDriversLicense := map(le.did=0 => '-1',
                                            (Models.Common.findw_cpp(le.header_summary.ver_sources, 'CY' , ', ', 'E') > 0) AND
                                            (Models.Common.findw_cpp(le.header_summary.ver_sources, 'D' , ', ', 'E') > 0) AND
                                            (le.iid_out.insurance_dl_used)																													=> '7',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'D' , ', ', 'E') > 0 AND
                                            (le.iid_out.insurance_dl_used)																													=> '6',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'CY' , ', ', 'E') > 0 AND
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'D' , ', ', 'E') > 0 				=> '5',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'CY' , ', ', 'E') > 0 AND
                                            (le.iid_out.insurance_dl_used) 																													=> '4',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'D' , ', ', 'E') > 0 				=> '3',
                                            (le.iid_out.insurance_dl_used)																													=> '2',
                                            Models.Common.findw_cpp(le.header_summary.ver_sources, 'CY' , ', ', 'E') > 0 				=> '1',
                                            '0');

// if the option to SuppressCompromisedDLs is set to true, check the last name and SSN against the equifax compromised DL key
compromised_DL_hash_value := if(SuppressCompromisedDLs,
	IdentityManagement_Services.CompromisedDL.fn_CheckForMatch(le.shell_input.lname, le.shell_input.ssn), 
  '');
DL_is_compromised := trim(compromised_DL_hash_value) <> '';

  self.version201.IdentityDriversLicenseComp := map(
    le.truedid=false => '-1',  // no identity found
    (integer)le.shell_input.ssn=0 => '0',  // SSN not provided
    DL_is_compromised => '2',  //  A Driver’s License associated to the identity potentially compromised
    '1');  // no known issues

  // VERSION 2.02
  self.version202.IDVerFNameBest := attr.input_fname_isbestmatch;
  self.version202.IDVerLNameBest := attr.input_lname_isbestmatch;
  self.version202.IDVerSSNBest := attr.input_ssn_isbestmatch;
  self.version202.VariationSearchSSNCtDay := attr.srch_ssnsperid_count_day;
  self.version202.VariationSearchSSNCtWeek := attr.srch_ssnsperid_count_wk;
  self.version202.VariationSearchSSNCtMonth := attr.srch_ssnsperid_count01;
  self.version202.VariationSearchSSNCt3Month := attr.srch_ssnsperid_count03;
  self.version202.VariationSearchSSNCtNew := attr.srch_ssnsperid_count06;
  self.version202.VariationSearchAddrCtDay := attr.srch_addrsperid_count_day;
  self.version202.VariationSearchAddrCtWeek := attr.srch_addrsperid_count_wk;
  self.version202.VariationSearchAddrCtMonth := attr.srch_addrsperid_count01;
  self.version202.VariationSearchAddrCt3Month := attr.srch_addrsperid_count03;
  self.version202.VariationSearchAddrCtNew := attr.srch_addrsperid_count06;
  self.version202.VariationSearchPhoneCtDay := attr.srch_phonesperid_count_day;
  self.version202.VariationSearchPhoneCtWeek := attr.srch_phonesperid_count_wk;
  self.version202.VariationSearchPhoneCtMonth := attr.srch_phonesperid_count01;
  self.version202.VariationSearchPhoneCt3Month := attr.srch_phonesperid_count03;
  self.version202.VariationSearchLNameCtDay := attr.srch_lnamesperid_count_day;
  self.version202.VariationSearchLNameCtWeek := attr.srch_lnamesperid_count_wk;
  self.version202.VariationSearchLNameCtMonth := attr.srch_lnamesperid_count01;
  self.version202.VariationSearchLNameCt3Month := attr.srch_lnamesperid_count03;
  self.version202.VariationSearchFNameCtDay := attr.srch_fnamesperid_count_day;
  self.version202.VariationSearchFNameCtWeek := attr.srch_fnamesperid_count_wk;
  self.version202.VariationSearchFNameCtMonth := attr.srch_fnamesperid_count01;
  self.version202.VariationSearchFNameCt3Month := attr.srch_fnamesperid_count03;
  self.version202.VariationSearchFNameCtNew := attr.srch_fnamesperid_count06;
  self.version202.VariationSearchDOBCtDay := attr.srch_dobsperid_count_day;
  self.version202.VariationSearchDOBCtWeek := attr.srch_dobsperid_count_wk;
  self.version202.VariationSearchDOBCtMonth := attr.srch_dobsperid_count01;
  self.version202.VariationSearchDOBCt3Month := attr.srch_dobsperid_count03;
  self.version202.VariationSearchDOBCtNew := attr.srch_dobsperid_count06;
  self.version202.VariationSearchEmailCt := attr.srch_email_per_id;
  self.version202.VariationSearchEmailCtDay := attr.srch_emailsperid_count_day;
  self.version202.VariationSearchEmailCtWeek := attr.srch_emailsperid_count_wk;
  self.version202.VariationSearchEmailCtMonth := attr.srch_emailsperid_count01;
  self.version202.VariationSearchEmailCt3Month := attr.srch_emailsperid_count03;
  self.version202.VariationSearchEmailCtNew := attr.srch_emailsperid_count06;
  self.version202.VariationSearchSSN1SubCt := attr.srch_ssnsperid_1subs;
  self.version202.VariationSearchPhone1SubCt := attr.srch_phnsperid_1subs;
  self.version202.VariationSearchAddr1SubCt := attr.srch_primrangesperid_1subs;
  self.version202.VariationSearchDOB1SubCt := attr.srch_dobsperid_1subs;
  self.version202.VariationSearchFName1SubCt := attr.srch_fnamesperid_1subs;
  self.version202.VariationSearchLName1SubCt := attr.srch_lnamesperid_1subs;
  self.version202.VariationSearchDOB1SubDayCt := attr.srch_dobsperid_daysubs;
  self.version202.VariationSearchDOB1SubMoCt := attr.srch_dobsperid_mosubs;
  self.version202.VariationSearchDOB1SubYrCt := attr.srch_dobsperid_yrsubs;
  self.version202.VariationSearchSSNSeqCt := attr.srch_ssnsperid_1dig;
  self.version202.VariationSearchPhoneSeqCt := attr.srch_phnsperid_1dig;
  self.version202.VariationSearchAddrSeqCt := attr.srch_primrangesperid_1dig;
  self.version202.VariationSearchDobSeqCt := attr.srch_dobsperid_1dig;
  self.version202.SearchSSNBestSearchCt := attr.srch_perbestssn;
  self.version202.DivSearchSSNBestIdentityCt := attr.srch_idsperbestssn;
  self.version202.DivSearchSSNBestLNameCt := attr.srch_lnamesperbestssn;
  self.version202.DivSearchSSNBestAddrCt := attr.srch_addrsperbestssn;
  self.version202.DivSearchSSNBestDOBCt := attr.srch_dobsperbestssn;
  self.version202.CorrNameDOBCt := attr.corrnamedob;
  self.version202.CorrAddrDOBCt := attr.corraddrdob;
  self.version202.CorrSSNDOBCt := attr.corrssndob;
  self.version202.CorrSearchSSNNameCt := attr.srch_corrnamessn;
  self.version202.CorrSearchVerSSNNameCt := attr.srch_corrnamessn_id;
  self.version202.CorrSearchNamePhoneCt := attr.srch_corrnamephone;
  self.version202.CorrSearchVerNamePhoneCt := attr.srch_corrnamephone_id;
  self.version202.CorrSearchSSNAddrCt := attr.srch_corraddrssn;
  self.version202.CorrSearchVerSSNAddrCt := attr.srch_corraddrssn_id;
  self.version202.CorrSearchAddrDOBCt := attr.srch_corrdobaddr;
  self.version202.CorrSearchVerAddrDOBCt := attr.srch_corrdobaddr_id;
  self.version202.CorrSearchAddrPhoneCt := attr.srch_corraddrphone;
  self.version202.CorrSearchVerAddrPhoneCt := attr.srch_corraddrphone_id;
  self.version202.CorrSearchSSNDOBCt := attr.srch_corrdobssn;
  self.version202.CorrSearchVerSSNDOBCt := attr.srch_corrdobssn_id;
  self.version202.CorrSearchSSNPhoneCt := attr.srch_corrphonessn;
  self.version202.CorrSearchVerSSNPhoneCt := attr.srch_corrphonessn_id;
  self.version202.CorrSearchDOBPhoneCt := attr.srch_corrdobphone;
  self.version202.CorrSearchVerDOBPhoneCt := attr.srch_corrdobphone_id;
  self.version202.CorrSearchSSNAddrNameCt := attr.srch_corrnameaddrssn;
  self.version202.CorrSearchVerSSNAddrNameCt := attr.srch_corrnameaddrssn_id;
  self.version202.CorrSearchSSNNamePhoneCt := attr.srch_corrnamephonessn;
  self.version202.CorrSearchVerSSNNamePhoneCt := attr.srch_corrnamephonessn_id;
  self.version202.CorrSearchSSNAddrNamePhoneCt := attr.srch_corrnameaddrphnssn;
  self.version202.CorrSearchVerSSNAddrNamePhneCt := attr.srch_corrnameaddrphnssn_id;
  self.version202.DivSearchAddrSSNCtDay := attr.srch_ssnsperaddr_count_day;
  self.version202.DivSearchAddrSSNCtWeek := attr.srch_ssnsperaddr_count_wk;
  self.version202.DivSearchAddrSSNCt1Month := attr.srch_ssnsperaddr_count01;
  self.version202.DivSearchAddrSSNCt3Month := attr.srch_ssnsperaddr_count03;
  self.version202.DivSearchAddrSSNCtNew := attr.srch_ssnsperaddr_count06;
  self.version202.DivSearchSSNIdentityCtDay := attr.srch_idsperssn_count_day;
  self.version202.DivSearchSSNIdentityCtWeek := attr.srch_idsperssn_count_wk;
  self.version202.DivSearchSSNIdentityCt1Month := attr.srch_idsperssn_count01;
  self.version202.DivSearchSSNIdentityCt3Month := attr.srch_idsperssn_count03;
  self.version202.DivSearchSSNIdentityCtNew := attr.srch_idsperssn_count06;
  self.version202.DivSearchAddrIdentityCtDay := attr.srch_idsperaddr_count_day;
  self.version202.DivSearchAddrIdentityCtWeek := attr.srch_idsperaddr_count_wk;
  self.version202.DivSearchAddrIdentityCt1Month := attr.srch_idsperaddr_count01;
  self.version202.DivSearchAddrIdentityCt3Month := attr.srch_idsperaddr_count03;
  self.version202.DivSearchAddrIdentityCtNew := attr.srch_idsperaddr_count06;
  self.version202.DivSearchPhoneIdentityCt := attr.srch_idsperphone;
  self.version202.DivSearchPhoneIdentityCtDay := attr.srch_idsperphone_count_day;
  self.version202.DivSearchPhoneIdentityCtWeek := attr.srch_idsperphone_count_wk;
  self.version202.DivSearchPhoneIdentityCt1Month := attr.srch_idsperphone_count01;
  self.version202.DivSearchPhoneIdentityCt3Month := attr.srch_idsperphone_count03;
  self.version202.DivSearchPhoneIdentityCtNew := attr.srch_idsperphone_count06;
  self.version202.DivSearchSSNLNameCtDay := attr.srch_lnamesperssn_count_day;
  self.version202.DivSearchSSNLNameCtWeek := attr.srch_lnamesperssn_count_wk;
  self.version202.DivSearchSSNLNameCt1Month := attr.srch_lnamesperssn_count01;
  self.version202.DivSearchSSNLNameCt3Month := attr.srch_lnamesperssn_count03;
  self.version202.DivSearchSSNLNameCtNew := attr.srch_lnamesperssn_count06;
  self.version202.DivSearchSSNAddrCtDay := attr.srch_addrsperssn_count_day;
  self.version202.DivSearchSSNAddrCtWeek := attr.srch_addrsperssn_count_wk;
  self.version202.DivSearchSSNAddrCt1Month := attr.srch_addrsperssn_count01;
  self.version202.DivSearchSSNAddrCt3Month := attr.srch_addrsperssn_count03;
  self.version202.DivSearchSSNAddrCtNew := attr.srch_addrsperssn_count06;
  self.version202.DivSearchSSNDOBCtDay := attr.srch_dobsperssn_count_day;
  self.version202.DivSearchSSNDOBCtWeek := attr.srch_dobsperssn_count_wk;
  self.version202.DivSearchSSNDOBCt1Month := attr.srch_dobsperssn_count01;
  self.version202.DivSearchSSNDOBCt3Month := attr.srch_dobsperssn_count03;
  self.version202.DivSearchSSNDOBCtNew := attr.srch_dobsperssn_count06;
  self.version202.DivSearchAddrLNameCtDay := attr.srch_lnamesperaddr_ct_day;
  self.version202.DivSearchAddrLNameCtWeek := attr.srch_lnamesperaddr_count_wk;
  self.version202.DivSearchAddrLNameCt1Month := attr.srch_lnamesperaddr_count01;
  self.version202.DivSearchAddrLNameCt3Month := attr.srch_lnamesperaddr_count03;
  self.version202.DivSearchAddrLNameCtNew := attr.srch_lnamesperaddr_count06;
  self.version202.DivSearchEmailIdentityCt := attr.srch_ids_per_email;
  self.version202.DivSearchEmailIdentityCtDay := attr.srch_idsperemail_count_day;
  self.version202.DivSearchEmailIdentityCtWeek := attr.srch_idsperemail_count_wk;
  self.version202.DivSearchEmailIdentityCt1Month := attr.srch_idsperemail_count01;
  self.version202.DivSearchEmailIdentityCt3Month := attr.srch_idsperemail_count03;
  self.version202.DivSearchEmailIdentityCtNew := attr.srch_idsperemail_count06;
  self.version202.SearchPhoneSearchCtDay := attr.srch_perphone_count_day;
  self.version202.SearchPhnSearchCtWeek := attr.srch_perphone_count_wk;
  self.version202.SearchPhnSearchCt1Month := attr.srch_perphone_count01;
  self.version202.SearchPhnSearchCt3Month := attr.srch_perphone_count03;
  self.version202.SearchPhnSearchCtNew := attr.srch_perphone_count06;
  self.version202.SourceTypeIndicator := attr.source_type;
  self.version202.SourceTypeEmergence := attr.emergence_source_type;
  self.version202.SourceTypeCredentialCt := attr.sum_src_credentialed;
  self.version202.SourceTypeCredentialAgeOldest := attr.m_src_credentialed_fs;
  self.version202.SourceTypeOtherCt := attr.sum_src_other;
  self.version202.SourceTypeOtherAgeOldest := attr.m_src_other_fs;
  self.version202.SourceCreditBureauCBOCt := attr.bureau_only_index;
  self.version202.SourceCreditBureauVerSSN := attr.ssn_bureau_only;
  self.version202.SourceCreditBureauVerAddr := attr.addr_bureau_only;
  self.version202.SourceCreditBureauVerDOB := attr.dob_bureau_only;
  self.version202.IDVerAddressMatchesCurrentV2 := attr.address_match;
  self.version202.SearchSSNUnVerAddrCt := attr.srch_perssn_addrunver;
  self.version202.SearchSSNIdentitySearchCtDiff := attr.srch_ssn_id_diff01;
  self.version202.SearchNonBankSearchCtWeek := attr.srch_nonbank_count_wk;
  self.version202.SearchNonBankSearchCtYear := attr.srch_nonbank_count12;
  self.version202.SearchNonBankSearchCtRecency := attr.srch_nonbank_recency;
  self.version202.AssocCBOIdentityCt := attr.rel_count_for_bureau_only;
  self.version202.AssocCBOHHMemberCt := attr.hh_members_for_bureau_only;
  self.version202.SourceCreditBureauFSAge := attr.bureau_emergence_age;
  self.version202.SourceCreditBureauFSAge25to59 := attr.bureau_emergence_age_25_59;
  self.version202.SourceCreditBureauCBOFSAge := attr.bureau_only_emergence_age;
  self.version202.SourceCreditBureauNotSSNVer := attr.fla_fld_bureau_no_ssn_flag;
  self.version202.IdentitySyntheticRiskLevel := attr.synthidindex;
  self.version202.IdentitySynthetic := attr.synthid_trigger;
  self.version202.IdentityManipSSNRiskLevel := attr.cpnindex;
  self.version202.IdentitySSNManip := attr.cpn_trigger;
  // VERSION 2.03
  self.version203.IDVerSSNVerAgeOldest := attr.ver_ssn_sources_first_seen;
  self.version203.IDVerSSNNotVerAgeOldest := attr.adls_per_ssn_and_first_seen_date;
  //TESTING ONLY
  // self.version203.clam := attr.attr_clam;

  self.compromisedDL_hash := compromised_DL_hash_value;
  self := [];
END;

version1Temp := project(wIPs, intoAttributes(left));

// For Paro estincome and hownstatusflag attributes
xlayout := record
  Integer seq;
  unsigned6 DID;
  STRING1 hownstatusflag := '';
  STRING3 estincome := '';
  STRING6 refresh_date :='';  // for demographic data rollup
end;

	xlayout get_household(wIPs le, daybatchPCNSR.Key_PCNSR_DID rt) := transform
		self.hownstatusflag := map(rt.own_rent='9' => '4',
							  rt.own_rent in ['7','8'] => '3',
							  rt.own_rent in ['1','2','3','4','5','6'] => '2',
							  '0');
		self.estincome := (string)round(((integer)rt.find_income_in_1000s)/1000);
		self.refresh_date := rt.refresh_date;
    self := le;
	end;

	hous_recs := join(wIPs, DayBatchPCNSR.Key_PCNSR_DID, 
					left.did!=0 and keyed(left.did=right.did), 
					get_household(left, right), left outer,
          ATMOST(keyed(left.did=right.did), RiskWise.max_atmost), keep(50));

  xlayout roll_hous(xlayout le, xlayout rt) := transform
    self := if(le.refresh_date > rt.refresh_date, le, rt); 
  end;
	
	groupedHouse   := group(sort(ungroup(hous_recs),seq),seq);
	wHouseHold   := rollup(groupedHouse, true, roll_hous(left, right));
// End for Paro estincome and hownstatusflag attributes

// Logic taken from IT1O function so that we can match what Paro had
dwelltype(STRING1 at) := MAP(at='F' => '', at='G' => 'S', at='H' => 'A', at='P' => 'E', at='R' => 'R', at='S' => '', '');					  		
invalidSet := ['E101','E212','E213','E214','E216','E302','E412','E413','E420','E421','E423','E500','E501','E502','E503','E600'];
ambiguousSet := ['E422','E425','E427','E428','E429','E430','E431','E504'];	
addrvalflag(STRING4 stat) := MAP(stat IN invalidSet => 'N', stat IN ambiguousSet => 'M', stat = '' => '', 'V');

Models.Layout_FraudAttributes intoParoAttrs(wIPs le, skiptrace_call rt) := TRANSFORM
  self.input.historydate := le.historydate;
	self.input := le.shell_input;
	self.AccountNumber:= account_value;
  
  self.ParoAttributes.paro_bansmatchflag     := rt.bansmatchflag;
  self.ParoAttributes.paro_banscasenum       := rt.banscasenum;
  self.ParoAttributes.paro_bansprcode        := rt.bansprcode;
  self.ParoAttributes.paro_bansdispcode      := rt.bansdispcode;
  self.ParoAttributes.paro_bansdatefiled     := rt.bansdatefiled;
  self.ParoAttributes.paro_bansfirst         := rt.bansfirst;
  self.ParoAttributes.paro_bansmiddle        := rt.bansmiddle;
  self.ParoAttributes.paro_banslast          := rt.banslast;
  self.ParoAttributes.paro_banscnty          := rt.banscnty;
  self.ParoAttributes.paro_bansecoaflag      := rt.bansecoaflag;
  self.ParoAttributes.paro_decsflag          := IF(rt.decsflag='0', '', rt.decsflag);
  self.ParoAttributes.paro_decsdob           := rt.decsdob;
  self.ParoAttributes.paro_decszip           := rt.decszip;
  self.ParoAttributes.paro_decszip2          := rt.decszip2;
  self.ParoAttributes.paro_decslast          := rt.decslast;
  self.ParoAttributes.paro_decsfirst         := rt.decsfirst;
  self.ParoAttributes.paro_decsdod           := rt.decsdod;
  
  // Logic taken from IT1O function so that we can match what Paro had
  clean_input_addr := Risk_Indicators.MOD_AddressClean.clean_addr(le.iid_out.in_streetAddress, le.iid_out.in_city, le.iid_out.in_state, le.iid_out.in_zipcode);
  a1 := Risk_Indicators.MOD_AddressClean.street_address('',le.iid_out.chronoprim_range,le.iid_out.chronopredir,le.iid_out.chronoprim_name,le.iid_out.chronosuffix,le.iid_out.chronopostdir, le.iid_out.chronounit_desig, le.iid_out.chronosec_range);
  clean_addr := Risk_Indicators.MOD_AddressClean.clean_addr(a1, le.iid_out.chronocity, le.iid_out.chronostate, le.iid_out.chronozip);
	in_av := addrvalflag(clean_input_addr[179..182]);
  av := addrvalflag(if(a1='', clean_input_addr[179..182], clean_addr[179..182]));
  
  self.ParoAttributes.paro_inputaddrcharflag := map(le.iid_out.in_streetAddress = '' => '0',
                                                  in_av in ['N', 'M'] => '1',  // this is different than address history records, where invalid or ambiguous = 'U'
                                                  dwelltype(clean_input_addr[139]));
  self.ParoAttributes.paro_inputsocscharflag := le.ssn_verification.validation.inputsocscharflag;
  self.ParoAttributes.paro_correctsocs       := le.iid.correctssn;
  self.ParoAttributes.paro_phonestatusflag   := IF(le.iid_out.chronoaddrscore = 0, '', (String)le.iid_out.chronoaddrscore);
  self.ParoAttributes.paro_phone             := le.iid_out.chronophone;
  self.ParoAttributes.paro_altareacode       := le.iid_out.altareacode;
  self.ParoAttributes.paro_splitdate         := le.iid_out.areacodesplitdate;
  self.ParoAttributes.paro_addrstatusflag    := map(a1='' => '0', // other address not found
                                               Risk_Indicators.ga(Risk_Indicators.addrscore.AddressScore(clean_input_addr[1..10], clean_input_addr[13..40],
                                               clean_input_addr[57..64], clean_addr[1..10], clean_addr[13..40], clean_addr[57..64])) => '1',  // same as input address
                                               '2'); // different address than input
  self.ParoAttributes.paro_addrcharflag      := map(le.iid_out.in_streetAddress = '' and a1 = '' => '0',
                                               av in ['N', 'M'] => 'U',
                                               dwelltype(if(a1='', clean_input_addr[139], clean_addr[139])));
  self.ParoAttributes.paro_first             := le.iid_out.chronofirst;
  self.ParoAttributes.paro_last              := le.iid_out.chronolast;
  self.ParoAttributes.paro_addr              := if(a1='', Risk_Indicators.MOD_AddressClean.street_address('',clean_input_addr[1..10],clean_input_addr[11..12],clean_input_addr[13..40],clean_input_addr[41..44],
                                                                                                     clean_input_addr[45..46],clean_input_addr[47..56],clean_input_addr[57..64]),
                                                     Risk_Indicators.MOD_AddressClean.street_address('',clean_addr[1..10],clean_addr[11..12],clean_addr[13..40],clean_addr[41..44],
                                                                                                        clean_addr[45..46],clean_addr[47..56],clean_addr[57..64]));
  self.ParoAttributes.paro_city              := if(a1='',clean_input_addr[90..114],clean_addr[90..114]);
  self.ParoAttributes.paro_state             := if(a1='',clean_input_addr[115..116],clean_addr[115..116]);
  self.ParoAttributes.paro_zip               := if(a1='',clean_input_addr[117..125],clean_addr[117..125]);
  self.ParoAttributes.paro_hownstatusflag    := ''; //will come from get_estincome join later
  self.ParoAttributes.paro_estincome         := (string)round(((integer)le.inEasi.med_hhinc)/1000);
  self.ParoAttributes.paro_median_hh_size    := le.inEasi.hhsize;
  
  self := [];
END;

ParoAttrsTemp := JOIN(wIPs, skiptrace_call,
                      left.seq = right.seq,
                      intoParoAttrs(LEFT, RIGHT),
                      LEFT OUTER, ATMOST(RiskWise.max_atmost));

Models.Layout_FraudAttributes get_estincome(Models.Layout_FraudAttributes le, xlayout rt) := TRANSFORM
  self.ParoAttributes.paro_hownstatusflag := rt.hownstatusflag;
  self.ParoAttributes.paro_estincome      := IF(rt.estincome != '0', rt.estincome, le.ParoAttributes.paro_estincome);
  self := le;
END;


ParoAttrs := JOIN(ParoAttrsTemp, wHouseHold,
                  left.input.seq = right.seq,
                  get_estincome(LEFT, RIGHT),
                  ATMOST(RiskWise.max_atmost));

AttrVersion := IF(model_name = Models.FraudAdvisor_Constants.attrvparo, ParoAttrs, Version1Temp);

Layout_WorkingCombo := RECORD
	Models.Layout_FraudAttributes;
	Risk_Indicators.Layout_Output iid;
END;


string2 getSocsLevel(unsigned1 level) := map(level in [0,2,3,5,8] => '0',
									level = 1 => '1',
									level = 4 => '2',
									level = 6 => '3',
									level = 7 => '4',
									(string)(level-4));	// 9,10,11,12 results in 5,6,7,8

Models.Layout_FraudAttributes intoIDAttributes(Layout_WorkingCombo le) := TRANSFORM
/* **********************************************************************************
   *                         -=   WFS3/4 IDAttributes    =-                           *
   ************************************************************************************/
	verfied_residence := [8, 12];
	socialsource_verified_residence := le.iid.socsverlevel in verfied_residence;
	phonelisting_verified_residence := le.iid.phoneverlevel in verfied_residence;
	high_risk_address := le.iid.hriskaddrflag<>'0';
	address_not_most_recent := le.iid.inputAddrNotMostRecent;

	disconnected_or_no_phonelisting := map(le.iid.phoneaddr_firstcount > 0 and
								le.iid.phoneaddr_lastcount > 0 and
								le.iid.phoneaddr_addrcount > 0 => le.iid.phoneaddr_disconnected,
								le.iid.phonefirstcount > 0 and
								le.iid.phonelastcount > 0 and
								le.iid.phoneaddrcount > 0 => le.iid.phone_disconnected,
								// If it got this far, and all we have left is utility that may be verifying first/last/addr
								// set disconnect = true because we have no idea if utility listing is recent
								true);
	inputPresent := if(le.iid.fname='' and le.iid.lname='' and le.iid.in_streetAddress='' and le.iid.ssn='' and le.iid.dob='' and le.iid.phone10='' and le.iid.wphone10='', false, true);

	SELF.IDAttributes.InputPresent := if(inputPresent, 'True', 'False');
	SELF.IDAttributes.DoOutput := if(inputPresent, 'True', 'False');
	SELF.IDAttributes.DataReturn := if(inputPresent, 'Y', 'N');
	SELF.IDAttributes.FirstCount := if(le.iid.fname<>'',RiskWise.flattenCount(le.iid.combo_firstcount,1,1),'');
	SELF.IDAttributes.LastCount := if(le.iid.lname<>'',RiskWise.flattenCount(le.iid.combo_lastcount,1,1),'');
	SELF.IDAttributes.AddrCount := if(le.iid.in_streetAddress<>'',RiskWise.flattenCount(le.iid.combo_addrcount,1,1),'');
	SELF.IDAttributes.FormerAddrCount := '';
	SELF.IDAttributes.HPhoneCount := if(le.iid.phone10<>'',RiskWise.flattenCount(le.iid.combo_hphonecount,1,1),'');
	SELF.IDAttributes.SocsCount := if(le.iid.ssn<>'',RiskWise.flattenCount(le.iid.combo_ssncount,1,1),'');
	SELF.IDAttributes.SocsVerLevel := getSocsLevel(le.iid.socsverlevel);
	SELF.IDAttributes.DOBCount := if(le.iid.dob<>'',RiskWise.flattenCount(le.iid.combo_dobcount,1,1),'');
	SELF.IDAttributes.DRLCCount := if(le.iid.dl_number<>'','0','');
	SELF.IDAttributes.CmpyCount := if(le.iid.employer_name<>'' and le.iid.combo_cmpyscore<>255,RiskWise.flattenCount(le.iid.combo_cmpycount,1,1),'');
	SELF.IDAttributes.VerFirst := le.iid.combo_first;
	SELF.IDAttributes.VerLast := le.iid.combo_last;
	SELF.IDAttributes.VerCmpy := le.iid.combo_cmpy;
	SELF.IDAttributes.VerAddr := Risk_Indicators.MOD_AddressClean.street_address('',le.iid.combo_prim_range,le.iid.combo_predir,le.iid.combo_prim_name,le.iid.combo_suffix,le.iid.combo_postdir,le.iid.combo_unit_desig,le.iid.combo_sec_range);
	SELF.IDAttributes.VerCity := le.iid.combo_city;
	SELF.IDAttributes.VerState := le.iid.combo_state;
	SELF.IDAttributes.VerZIP := le.iid.combo_zip;
	SELF.IDAttributes.VerHPhone := le.iid.combo_hphone;
	SELF.IDAttributes.VerSocs := if(le.iid.combo_ssncount>0,le.iid.combo_ssn,'');
	SELF.IDAttributes.VerDRLC := '';
	SELF.IDAttributes.VerDOB := le.iid.combo_dob;
	SELF.IDAttributes.NumELever := (string)le.iid.numelever;
	SELF.IDAttributes.NumSource := (string)((integer)if(le.iid.fname<>'',RiskWise.flattenCount(le.iid.combo_firstcount,1,1),'')+(integer)if(le.iid.lname<>'',RiskWise.flattenCount(le.iid.combo_lastcount,1,1),'')+(integer)if(le.iid.employer_name<>'' and
														le.iid.combo_cmpyscore<>255,RiskWise.flattenCount(le.iid.combo_cmpycount,1,1),'')+(integer)if(le.iid.in_streetAddress<>'',RiskWise.flattenCount(le.iid.combo_addrcount,1,1),'')+(integer)if(le.iid.phone10<>'',RiskWise.flattenCount(le.iid.combo_hphonecount,1,1),'')+
														(integer)if(le.iid.ssn<>'',RiskWise.flattenCount(le.iid.combo_ssncount,1,1),'')+(integer)if(le.iid.dob<>'',RiskWise.flattenCount(le.iid.combo_dobcount,1,1),''));
	SELF.IDAttributes.FirstScore := if(le.iid.fname<>'',if(le.iid.combo_firstscore=255, '0',(string)le.iid.combo_firstscore),'');
	SELF.IDAttributes.LastScore := if(le.iid.lname<>'',if(le.iid.combo_lastscore=255, '0',(string)le.iid.combo_lastscore),'');
	SELF.IDAttributes.CmpyScore := if(le.iid.employer_name<>''and le.iid.combo_cmpyscore<>255,if(le.iid.combo_cmpyscore=255, '0',(string)le.iid.combo_cmpyscore),'');
	SELF.IDAttributes.AddrScore := if(le.iid.in_streetAddress<>'',if(le.iid.combo_addrscore=255, '0',(string)le.iid.combo_addrscore),'');
	SELF.IDAttributes.HPhoneScore := if(le.iid.phone10<>'',if(le.iid.combo_hphonescore=255, '0',(string)le.iid.combo_hphonescore),'');
	SELF.IDAttributes.SocsScore := if(le.iid.ssn<>'',if(le.iid.combo_ssnscore=255, '0',(string)le.iid.combo_ssnscore),'');
	SELF.IDAttributes.DOBScore := if(le.iid.dob<>'',if(le.iid.combo_dobscore=255, '0',(string)le.iid.combo_dobscore),'');
	SELF.IDAttributes.DRLCScore := if(le.iid.dl_number<>'','0','');
	SELF.IDAttributes.WPhoneName := le.iid.wphonename;
	SELF.IDAttributes.WPhoneAddr := le.iid.wphoneaddr;
	SELF.IDAttributes.WPhoneCity := le.iid.wphonecity;
	SELF.IDAttributes.WPhoneState := le.iid.wphonestate;
	SELF.IDAttributes.WPhoneZIP := le.iid.wphonezip;
	SELF.IDAttributes.SocsMiskeyFlag := (string)(integer)le.iid.socsmiskeyflag;
	SELF.IDAttributes.HPhoneMiskeyFlag := (string)(integer)le.iid.hphonemiskeyflag;
	SELF.IDAttributes.AddrMiskeyFlag := (string)(integer)le.iid.addrmiskeyflag;
	SELF.IDAttributes.IDTheftFlag := (STRING)(INTEGER)le.iid.idtheftflag;
	SELF.IDAttributes.AptScanFlag := (STRING)(INTEGER)le.iid.aptscamflag;
	SELF.IDAttributes.AddrHistoryFlag := '0';
	SELF.IDAttributes.COAAlertFlag := '';
	SELF.IDAttributes.COAFirst := '';
	SELF.IDAttributes.COALast := '';
	SELF.IDAttributes.COAAddr := '';
	SELF.IDAttributes.COACity := '';
	SELF.IDAttributes.COAState := '';
	SELF.IDAttributes.COAZip := '';
	SELF.IDAttributes.WPhoneTypeFlag := le.iid.wphonetypeflag;
	SELF.IDAttributes.WPhoneValFlag := le.iid.wphonevalflag;
	SELF.IDAttributes.HPhoneTypeFlag := le.iid.hphonetypeflag;
	SELF.IDAttributes.HPhoneValFlag := le.iid.hphonevalflag;
	SELF.IDAttributes.PhoneZIPFlag := le.iid.PWphonezipflag;
	SELF.IDAttributes.PhoneDissFlag := (string)(integer)le.iid.phonedissflag;
	SELF.IDAttributes.AddrValFlag := le.iid.addrvalflag;
	SELF.IDAttributes.DwellTypeFlag := le.iid.dwelltype;
	SELF.IDAttributes.ZIPTypeFlag := le.iid.ziptypeflag;
	SELF.IDAttributes.SocsValFlag := le.iid.PWsocsvalflag;
	SELF.IDAttributes.DecsFlag := le.iid.decsflag;
	SELF.IDAttributes.SocsDOBFlag := le.iid.PWsocsdobflag;
	SELF.IDAttributes.AreaCodeSplitFlag := map(le.iid.phone10='' => '2', le.iid.areacodesplitflag = 'Y' => '1', '0');
	SELF.IDAttributes.AreaCodeSplitDate := IF(le.iid.areacodesplitflag='Y', le.iid.areacodesplitdate, '');
	SELF.IDAttributes.AltAreaCode := if(le.iid.areacodesplitflag='Y',le.iid.altareacode,'');
	SELF.IDAttributes.BansFlag := if(le.iid.bansflag = '3','0',le.iid.bansflag);
	SELF.IDAttributes.DRLCValFlag := le.iid.drlcvalflag;
	SELF.IDAttributes.DRLCSoundX := le.iid.drlcsoundx;
	SELF.IDAttributes.DRLCFirst := le.iid.drlcfirst;
	SELF.IDAttributes.DRLCLast := le.iid.drlclast;
	SELF.IDAttributes.DRLCMiddle := le.iid.drlcmiddle;
	SELF.IDAttributes.DRLCSocs := le.iid.drlcsocs;
	SELF.IDAttributes.DRLCDOB := le.iid.drlcdob;
	SELF.IDAttributes.DRLCGender := le.iid.drlcgender;
	SELF.IDAttributes.DistAddrPrevAddr := '';
	SELF.IDAttributes.DistHPhoneWPhone := if(le.iid.disthphonewphone<>9999,(string)le.iid.disthphonewphone,'');
	SELF.IDAttributes.DistWPhoneAddr := if(le.iid.distwphoneaddr<>9999,(string)le.iid.distwphoneaddr,'');
	SELF.IDAttributes.StateZIPFlag := le.iid.statezipflag;
	SELF.IDAttributes.CityZIPFlag := le.iid.cityzipflag;
	SELF.IDAttributes.HPhoneStateFlag := '0';
	SELF.IDAttributes.CheckAcctFlag := if(le.iid.watchlist_table<>'','1','0');
	SELF.IDAttributes.CassAddr := Risk_Indicators.MOD_AddressClean.street_address('',le.iid.prim_range,le.iid.predir,le.iid.prim_name,le.iid.addr_suffix,le.iid.postdir,le.iid.unit_desig,le.iid.sec_range);
	SELF.IDAttributes.CassCity := le.iid.p_city_name;
	SELF.IDAttributes.CassState := le.iid.st;
	SELF.IDAttributes.CassZIP := le.iid.z5+le.iid.zip4;
	SELF.IDAttributes.AddrCommFlag := le.iid.addrcommflag;
	SELF.IDAttributes.NonResName := map(le.iid.addrcommflag='1' => le.iid.hriskcmpyphone, le.iid.addrcommflag='2' => le.iid.hriskcmpy, '');
	SELF.IDAttributes.NonResSic := map(le.iid.addrcommflag='1' => RiskWise.convertSIC(le.iid.hrisksicphone), le.iid.addrcommflag='2' => RiskWise.convertSIC(le.iid.hrisksic), '');
	SELF.IDAttributes.NonResPhone := map(le.iid.addrcommflag='1' => le.iid.hriskphonephone, le.iid.addrcommflag='2' => le.iid.hriskphone, '');
	SELF.IDAttributes.NonResAddr := map(le.iid.addrcommflag='1' => le.iid.hriskaddrphone, le.iid.addrcommflag='2' => le.iid.hriskaddr, '');
	SELF.IDAttributes.NonResCity := map(le.iid.addrcommflag='1' => le.iid.hriskcityphone, le.iid.addrcommflag='2' => le.iid.hriskcity, '');
	SELF.IDAttributes.NonResState := map(le.iid.addrcommflag='1' => le.iid.hriskstatephone, le.iid.addrcommflag='2' => le.iid.hriskstate, '');
	SELF.IDAttributes.NonResZIP := map(le.iid.addrcommflag='1' => le.iid.hriskzipphone, le.iid.addrcommflag='2' => le.iid.hriskzip, '');
	SELF.IDAttributes.NumFraud := RiskWise.getNumFraud('0','0',le.iid.addrvalflag,le.iid.decsflag,if(le.iid.bansflag = '3','0',le.iid.bansflag),le.iid.drlcvalflag).PRWO(le.iid.wphonetypeflag,le.iid.wphonevalflag,le.iid.hphonetypeflag,
												le.iid.hphonevalflag,le.iid.PWphonezipflag,(string)(integer)le.iid.phonedissflag,le.iid.PWsocsvalflag,le.iid.PWsocsdobflag,le.iid.statezipflag,le.iid.cityzipflag,'0',le.iid.addrcommflag);
	SELF.IDAttributes.Score2 := '';
	SELF.IDAttributes.TciAddrFlag := if( (socialsource_verified_residence or (phonelisting_verified_residence and ~disconnected_or_no_phonelisting)) and high_risk_address=false and address_not_most_recent=false, '1', '0');
	SELF.IDAttributes.TciPrevAddrFlag := '';
	SELF.IDAttributes.EstIncome := '';
	SELF.IDAttributes.EmailDomainFlag := '';
	SELF.IDAttributes.EmailUserFlag := '';
	SELF.IDAttributes.EmailBrowserFlag := '';
	SELF.IDAttributes.HRiskEmailDomainFlag := '';
	SELF.IDAttributes.DistAddrDomain := '';
	SELF := le;
	SELF := [];
END;

temp := JOIN(AttrVersion, iid, LEFT.input.seq = RIGHT.seq, TRANSFORM(Layout_WorkingCombo, SELF.iid := RIGHT, SELF := LEFT));

out := PROJECT(temp, intoIDAttributes(LEFT));


Models.Layout_FraudAttributes POR_Flag( Risk_Indicators.Layout_Boca_Shell le, Models.Layout_FraudAttributes ri ) := TRANSFORM
// WFDS Proof-of-residence flag logic from Eric Graves:
// *** A *** por_addr_not_verd;
     socialsource_verified_residence := (le.iid.NAS_Summary in [8,12]);
     phonelisting_verified_residence := (le.iid.NAP_Summary in [8,12]);
     disconnected_or_no_phonelisting := ((le.iid.phoneaddr_lastcount > 0 and le.iid.phoneaddr_addrcount > 0 and le.iid.nap_status = 'D') or
                                        (le.iid.phonelastcount > 0      and le.iid.phoneaddrcount > 0      and le.iid.nap_status = 'D'));
     por_addr_not_verd := (not (socialsource_verified_residence or (phonelisting_verified_residence and not disconnected_or_no_phonelisting)));

// *** B *** por_high_risk_address;
     por_high_risk_address := (le.iid.hriskaddrflag != '0');

// *** C *** por_newer_address_found;
    address_not_most_recent := le.iid.inputaddrnotmostrecent;
    add1_date_first_seen := le.address_verification.input_address_information.date_first_seen;
    add1_date_last_seen  := le.address_verification.input_address_information.date_last_seen;
    add2_date_first_seen := le.address_verification.address_history_1.date_first_seen;
    add2_date_last_seen  := le.address_verification.address_history_1.date_last_seen;

    _add1_date_first_seen := models.common.sas_date((string)add1_date_first_seen);
    _add1_date_last_seen  := models.common.sas_date((string)add1_date_last_seen );
    _add2_date_first_seen := models.common.sas_date((string)add2_date_first_seen);
    _add2_date_last_seen  := models.common.sas_date((string)add2_date_last_seen );

    sysdate := models.common.sas_date( if(le.historydate=999999, (STRING8)Std.Date.Today(), (string6)le.historydate+'01'));

    mos_add1_date_first_seen := (integer)((sysdate-_add1_date_first_seen)/(365.25/12));
    mos_add1_date_last_seen  := (integer)((sysdate-_add1_date_last_seen )/(365.25/12));
    mos_add2_date_first_seen := (integer)((sysdate-_add2_date_first_seen)/(365.25/12));
    mos_add2_date_last_seen  := (integer)((sysdate-_add2_date_last_seen )/(365.25/12));
    por_newer_address_found := address_not_most_recent
      and not (
            (mos_add1_date_first_seen > 12 )
        and (mos_add1_date_last_seen <= 1  )
        and (mos_add2_date_first_seen > 12 )
        and (mos_add2_date_last_seen <= 12 )
      );

// *** D *** por_addr_disconnected_phone;
     por_addr_disconnected_phone := (not socialsource_verified_residence and (phonelisting_verified_residence and disconnected_or_no_phonelisting));

// *** E *** por_more_than_4_addrs_last_year ;
     por_more_than_4_addrs_last_year := (le.other_address_info.addrs_last12 >= 4);

// *** FLAG ASSIGNMENT ***;

     _A := por_addr_not_verd;
     _B := por_high_risk_address;
     _C := por_newer_address_found;
     _D := por_addr_disconnected_phone;
     _E := por_more_than_4_addrs_last_year;

	SELF.IDAttributes.TciAddrFlag := map(
    not (_A or _B or _C or _D or _E)     => '0',
    _A and not (_B or _C)                => '1',
    _B and not (_A or _C)                => '2',
    _C and not (_A or _B)                => '3',
    _D and not (_A or _B or _C or _E)    => '4',
    (_D or _E) and not (_A or _B or _C)  => '5',
    (_A and _B) and not _C               => '6',
    (_A and _C) and not _B               => '7',
    (_B and _C) and not _A               => '8',
    (_A and _B and _C)                   => '9',
    '' // should never happen
  );
  self := ri;
END;

out_por := join( clam, out, left.seq=right.input.seq, POR_Flag(left,right), keep(1) );

// output (model_name, named ('model_name'), overwrite);
// output (wIPs, named ('wIPs'), overwrite);
// output (skiptrace_call, named ('skiptrace_call'), overwrite);
// output (wHouseHold, named ('wHouseHold'), overwrite);
// output (version1Temp, named ('version1Temp'), overwrite);
// output (ParoAttrsTemp, named ('ParoAttrsTemp'), overwrite);
// output (ParoAttrs, named ('ParoAttrs'), overwrite);
// output (AttrVersion, named ('AttrVersion'), overwrite);

return if( model_name='fp31203_1', out_por, out );
END;