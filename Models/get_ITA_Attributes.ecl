import risk_indicators, ut, easi, riskwise;

export get_ITA_Attributes(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, integer1 version=1) := function

	// =============== Get Easi Census Info for all 3 addressess =============
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
																						
	layout_bseasi := record, maxlength(100000)
		Risk_Indicators.Layout_Boca_Shell;
		used_census inEasi;
		used_census Easi1;
		used_census Easi2;
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
	clam_with_Easi := group( sort(denormalize (wideClam, easi_census,	left.seq = right.seq, joinEm (LEFT,RIGHT)), seq), seq);

	working_layout := record
		models.layouts.layout_ITA_attributes_batch;
		layout_bseasi clam;
	end;


	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim((string)(histdate)[5..6])='01';
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;
	


	months_apart(unsigned3 system_yearmonth, unsigned some_yearmonth) := function
		days := ut.DaysApart((string)system_yearmonth + '01', (string)some_yearmonth + '01' );
		days_in_a_month := 30.5;
		calculated_months := days/days_in_a_month;
		months := if(some_yearmonth=0, 0, calculated_months);
		return round(months);
	end;

	checkBoolean(boolean x) := if(x, '1', '0');
	cap1Byte := 9;
	cap2Byte := 99;
	cap3Byte := 999;
	cap4Byte := 9998;  // use 9998 because 9999 is a default value for distance not calculated
	cap10Byte := 9999999999;
	cap13byte := 9999999999999;
	decimal_length := 1;


	unsigned3 getYYYYMM( unsigned dt ) := (unsigned3)( ((string8)dt)[1..6] );
	
	
	// set desired number of chars after decimal point by passing in an integer value from 0-6 in decimals parameter	
	FormatDecimalString (real somenumber, integer decimals) := FUNCTION
		// cap this at 6 since a real value only has 6
		unsigned1 tail_length := IF (decimals > 6, 6, decimals);
		string temp := (string)somenumber;
		string zero_str := '000000';
		dec_point_position := stringlib.stringFind(temp, '.', 1);
		len := length(temp);
		integer_value := temp[1..dec_point_position-1];
		tail_value := temp[dec_point_position + 1..dec_point_position+tail_length];
		final_value := IF(dec_point_position=0,
							temp + '.' + zero_str[tail_length],
							integer_value + '.' + tail_value);
		return IF (somenumber = 0, '', final_value);
	END;
	
	
	
// create all of the attributes from what we have available in the clam_with_easi
working_layout map_fields(clam_with_Easi le) := transform
	system_yearmonth := if(le.historydate = risk_indicators.iid_constants.default_history_date, (integer)(ut.GetDate[1..6]), le.historydate);
	fulldate := (unsigned4)risk_indicators.iid_constants.full_history_date(le.historydate);
	
	checkDate6(unsigned3 foundDate) := FUNCTION
		outDate := if(foundDate > le.historyDate, getPreviousMonth(le.historyDate), foundDate);
		return (string)outDate;
	END;
	
	self.seq := (string)le.seq;
	self.acctno := '';

	// Identity Authentication Attributes	
	self.SubjectFirstSeen := (string)ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen);
	last_seen := ut.max2(le.ssn_verification.header_last_seen, le.ssn_verification.credit_last_seen);
	self.DateLastUpdate := checkDate6(last_seen);
	today := ut.GetDate;
	self.RecentUpdate := checkboolean( (system_yearmonth - last_seen) < 100 );
	self.PhoneFullNameMatch := checkboolean( le.iid.nap_summary in [9,12] );
	self.PhoneLastNameMatch:= checkboolean( le.iid.nap_summary in [7,9,11,12] );
		
	self.AgeRiskIndicator := map(le.inferred_age=0 => '',
																le.inferred_age between 1 and 17 => '0',
																le.inferred_age between 18 and 20 => '18',
																le.inferred_age between 21 and 69 => '21',
																le.inferred_age between 70 and 79 => '70',
																le.inferred_age > 80 => '80',
																'');
																
	self.InvalidSSN := checkboolean( ~le.SSN_Verification.Validation.valid );
	self.InvalidPhone := checkboolean( le.iid.phonetype <> '1' and le.shell_input.phone10 <> '' );
	self.InvalidAddr := checkboolean( le.iid.addrvalflag='N' and ((le.shell_input.in_StreetAddress<>'' and le.shell_input.in_City<>'' and 
																 le.shell_input.in_State<>'') or (le.shell_input.in_StreetAddress<>'' and le.shell_input.in_Zipcode<>'')) );
	self.NoVerifyNameAddrPhoneSSN := checkboolean( le.iid.nas_summary <= 4 and le.iid.nap_summary <= 4 and le.address_verification.input_address_information.naprop <= 2 );
	
// SSN Attributes
	self.ssndeceased:= checkboolean( le.iid.decsflag='1' );
	self.datessndeceased := (string)if(le.ssn_verification.Validation.deceasedDate>fullDate, 0, le.ssn_verification.Validation.deceasedDate);
	self.SSNIssued := checkboolean( le.SSN_Verification.Validation.valid and le.shell_input.ssn<>'' );
	self.RecentSSN := checkboolean(  (system_yearmonth - (INTEGER)(le.iid.soclhighissue[1..6])) < 100 );
	self.LowIssueDate := (string)if((unsigned)le.iid.socllowissue>fullDate, 0, (unsigned)le.iid.socllowissue);
	self.HighIssueDate := (string)if((unsigned)le.iid.soclhighissue>fullDate, 0, (unsigned)le.iid.soclhighissue);
	self.SSNIssueState := le.iid.soclstate;
	self.NonUSssn := checkboolean( le.shell_input.ssn[1..3] IN ['729','730','731','732','733'] OR 
													 le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8'] );// ITIN logic
	self.ssn3years := checkboolean( (system_yearmonth - (INTEGER)(le.iid.socllowissue[1..6])) < 300 );
	self.ssnAFter5 := checkboolean( ((INTEGER)(le.iid.socllowissue[1..6]) - (INTEGER)(le.shell_input.Dob[1..6])) > 500 AND (INTEGER)(le.shell_input.Dob[1..4]) > 1990 );
	self.ssnprobs := le.ssn_verification.validation.inputsocscode;
	
// Evidence of Compromised Identity
	self.SSNNotFound := checkboolean( ~le.iid.ssnexists );
	self.SSNFoundOther := checkboolean( le.iid.nas_summary in [1,2,3,4,5,8] and le.iid.ssnExists and ~le.iid.lastssnmatch2 );
	self.SSNIssuedPrior := checkboolean( le.ssn_verification.validation.dob_mismatch );
	self.PhoneOther := checkboolean( le.iid.phonelastcount=0 AND le.iid.phoneaddrcount=0 AND le.iid.phonephonecount>0 and ~le.iid.phonevalflag='0' );
	self.SSNPerID := (string)ut.imin2(le.velocity_counters.ssns_per_adl, cap2Byte);
	self.AddrPerID := (string)ut.imin2(le.velocity_counters.addrs_per_adl, cap2Byte);
	self.PhonePerID := (string)ut.imin2(le.velocity_counters.phones_per_adl, cap2Byte);
	self.IDPerSSN := (string)ut.imin2(le.SSN_Verification.adlPerSSN_count, cap2Byte);
	self.AddrPerSSN := (string)ut.imin2(le.velocity_counters.addrs_per_ssn, cap2Byte);
	self.IDPerAddr := (string)ut.imin2(le.velocity_counters.adls_per_addr, cap2Byte);
	self.SSNPerAddr := (string)ut.imin2(le.velocity_counters.ssns_per_addr, cap2Byte);
	self.PhonePerAddr := (string)ut.imin2(le.velocity_counters.phones_per_addr, cap2Byte);
	self.IDPerPhone := (string)ut.imin2(le.velocity_counters.adls_per_phone, cap2Byte);
	self.SSNPerID6 := (string)ut.imin2(le.velocity_counters.ssns_per_adl_created_6months, cap2Byte);
	self.AddrPerID6 := (string)ut.imin2(le.velocity_counters.addrs_per_adl_created_6months, cap2Byte);
	self.PhonePerID6 := (string)ut.imin2(le.velocity_counters.phones_per_adl_created_6months, cap2Byte);
	self.IDPerSSN6 := (string)ut.imin2(le.velocity_counters.adls_per_ssn_created_6months, cap2Byte);
	self.AddrPerSSN6 := (string)ut.imin2(le.velocity_counters.addrs_per_ssn_created_6months, cap2Byte);
	self.IDPerAddr6 := (string)ut.imin2(le.velocity_counters.adls_per_addr_created_6months, cap2Byte);
	self.SSNPerAddr6 := (string)ut.imin2(le.velocity_counters.ssns_per_addr_created_6months, cap2Byte);
	self.PhonePerAddr6 := (string)ut.imin2(le.velocity_counters.phones_per_addr_created_6months, cap2Byte);
	self.IDPerPhone6 := (string)ut.imin2(le.velocity_counters.adls_per_phone_created_6months, cap2Byte);	

// Identity Change Information
	self.LastNamePerSSN := (string)ut.imin2( le.SSN_Verification.namePerSSN_count, cap2Byte);
	self.LastNamePerID := (string)ut.imin2( le.velocity_counters.lnames_per_adl, cap2Byte);
	DateLastNameChange := if(le.name_verification.newest_lname_dt_first_seen>le.historyDate, 0, le.name_verification.newest_lname_dt_first_seen);
	self.TimeSinceLastName := (string)ut.imin2( months_apart(system_yearmonth, datelastnamechange), cap4byte);
	self.LastNames30 := (string)ut.imin2( le.velocity_counters.lnames_per_adl30, cap2Byte);
	self.LastNames90 := (string)ut.imin2( le.velocity_counters.lnames_per_adl90, cap2Byte);
	self.LastNames180 := (string)ut.imin2( le.velocity_counters.lnames_per_adl180, cap2Byte);
	self.LastNames12 := (string)ut.imin2( le.velocity_counters.lnames_per_adl12, cap2Byte);
	self.LastNames24 := (string)ut.imin2( le.velocity_counters.lnames_per_adl24, cap2Byte);
	self.LastNames36 := (string)ut.imin2( le.velocity_counters.lnames_per_adl36, cap2Byte);
	self.LastNames60 := (string)ut.imin2( le.velocity_counters.lnames_per_adl60, cap2Byte);
	self.IDPerSFDUAddr := (string)ut.imin2( if(le.address_validation.error_codes[1]='S', le.velocity_counters.adls_per_addr, 0), cap2Byte);
	self.SSNPerSFDUAddr := (string)ut.imin2( if(le.address_validation.error_codes[1]='S', le.velocity_counters.ssns_per_addr, 0), cap2Byte);
	
// Characteristics of Input Address	
	IADateFirstReported := (unsigned)checkDate6(le.address_verification.input_address_information.date_first_seen);
	IADateLastReported := (unsigned)checkDate6(le.address_verification.input_address_information.date_last_seen);
	self.TimeSinceInputAddrFirstSeen:= (string)ut.imin2( months_apart(system_yearmonth, IADateFirstReported), cap4byte);
	self.TimeSinceInputAddrLastSeen:= (string)ut.imin2( months_apart(system_yearmonth, IADateLastReported), cap4byte);
	IALenOfRes := if(IADateFirstReported <> 0 and IADateLastReported <> 0,
																		round((ut.DaysApart((string)IADateFirstReported, 
																												(string)IADateLastReported)) / 30),  0);
	self.InputAddrLenOfRes := (string)ut.imin2( IALenOfRes, cap3Byte ); 
	self.InputAddrDwellType := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.InputAddrLandUseCode := le.avm.input_address_information.avm_land_use_code;
	self.InputAddrAssessedValue := (string)le.address_verification.input_address_information.assessed_amount;
	self.InputAddrApplicantOwned := checkboolean( le.address_verification.input_address_information.applicant_owned );
	self.InputAddrFamilyOwned := checkboolean( le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned );
	self.InputAddrOccupantOwned := checkboolean( le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																		 ~le.address_verification.input_address_information.family_owned );
	self.InputAddrLastSalesDate := (string)if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_date);
	self.InputAddrLastSalesAmount := (string)ut.imin2(if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_amount), cap10byte);
	self.InputAddrNotPrimaryRes := checkboolean( ~le.address_verification.input_address_information.isbestmatch );
	self.InputAddrActivePhoneList := (string)ut.imin2(le.Address_Verification.edaMatchLevel, cap1Byte);
	self.InputAddrActivePhoneNumber := (string)le.Address_Verification.activePhone;
	IAMed_hhinc := le.ineasi.med_hhinc;
	self.InputAddrMedianIncome := IAMed_hhinc;
	IAMed_hval := le.ineasi.med_hval;
	self.InputAddrMedianHomeVal := IAMed_hval ;
	self.InputAddrMurderIndex := le.ineasi.murders;
	self.InputAddrCarTheftIndex := le.ineasi.cartheft;
	self.InputAddrBurglaryIndex := le.ineasi.burglary;
	IAtotcrime := le.ineasi.totcrime;
	self.InputAddrCrimeIndex := IAtotcrime;
	self.InputAddrTaxAssessedYr := le.avm.input_address_information.avm_assessed_value_year;
	self.InputAddrAssessMarket := le.avm.input_address_information.avm_market_total_value;
	self.InputAddrTaxAssessVal := (string)ut.imin2(le.avm.input_address_information.avm_tax_assessment_valuation, cap10Byte);
	self.InputAddrPriceIndVal := (string)ut.imin2(le.avm.input_address_information.avm_price_index_valuation, cap10Byte);
	self.InputAddrHedVal := (string)ut.imin2(le.avm.input_address_information.avm_hedonic_valuation, cap10Byte);
	
	IAAutomatedValuation := ut.imin2(le.avm.input_address_information.avm_automated_valuation, cap10Byte);
	self.InputAddrAutoVal := (string)IAAutomatedValuation;
	self.InputAddrConfScore := (string)ut.imin2(le.avm.input_address_information.avm_confidence_score, cap2byte);
	
	IACountyMedianValuation := ut.imin2(le.avm.input_address_information.avm_median_fips_level, cap10byte);
	IATractMedianValuation := ut.imin2(le.avm.input_address_information.avm_median_geo11_level, cap10byte);
	IABlockMedianValuation := ut.imin2(le.avm.input_address_information.avm_median_geo12_level, cap10byte);
	
	self.InputAddrCountyIndex := formatdecimalstring(IAAutomatedValuation/IACountyMedianValuation, decimal_length);
	self.InputAddrTractIndex :=  formatdecimalstring(IAAutomatedValuation/IATractMedianValuation, decimal_length);
	self.InputAddrBlockIndex := formatdecimalstring(IAAutomatedValuation/IABlockMedianValuation, decimal_length);

// Characteristics of Current Address (Most Recent Date First Reported)
	// current address pick for matching isbestmatch, assuming 1 of the 3 addresses are best
	CAaddrChooser := map(le.address_verification.input_address_information.isbestmatch => 1, // input is current
											 le.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
											 le.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
											 0);	// don't know what the current address is
	
	
										
	// numsources fits in above in the Identity Authentication section, but need to figure out which address is current to return numsources
	numsources := map(CAaddrChooser=0 => 0,
																	CAaddrChooser=1 => le.address_verification.input_address_information.source_count,
																	CAaddrChooser=2 => le.address_verification.address_history_1.source_count,
																	le.address_verification.address_history_2.source_count);
	self.NumSrcsConfirmIDAddr := (string)ut.imin2( numsources, cap2Byte);

	CADateFirstReported := (unsigned)checkDate6(
					map(CAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
										CAaddrChooser=2 => le.address_verification.address_history_1.date_first_seen,
										CAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
										0
										));
	CADateLastReported := (unsigned)checkDate6(
					map(CAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
										CAaddrChooser=2 =>	le.address_verification.address_history_1.date_last_seen,
										CAaddrChooser=3 =>	le.address_verification.address_history_2.date_last_seen,
										0
										));

	self.TimeSinceCurrAddrFirstSeen := (string)ut.imin2( months_apart(system_yearmonth, CADateFirstReported), cap4byte);
	self.TimeSinceCurrAddrLastSeen := (string)ut.imin2( months_apart(system_yearmonth, CADateLastReported), cap4byte);
	
	CALenOfRes := if(CADateFirstReported <> 0 and CADateLastReported <> 0,
																		round((ut.DaysApart((string)CADateFirstReported, 
																												(string)CADateLastReported)) / 30),  0);
	self.CurrAddrLenOfRes := (string)ut.imin2( CALenOfRes, cap3Byte ); 
	
	self.CurrAddrDwellType := map(CAaddrChooser=0 => '',
													CAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
													CAaddrChooser=2 => le.address_verification.addr_type2,
													le.address_verification.addr_type3);
																	
	self.CurrAddrLandUseCode := map(CAaddrChooser=0 => '',
														CAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
														CAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
														le.avm.address_history_2.avm_land_use_code);																
	
	CAAssessedValue := map(CAaddrChooser=0 => 0,
															CAaddrChooser=1 => le.address_verification.input_address_information.assessed_amount,
															CAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount,
															le.address_verification.input_address_information.assessed_amount);
															;
	
	self.CurrAddrAssessedValue := (string)ut.imin2(CAAssessedValue, cap10byte);
															
	CAisOwnedBySubject := map(CAaddrChooser=1 => le.address_verification.input_address_information.applicant_owned,
																					CAaddrChooser=2 => le.address_verification.address_history_1.applicant_owned,
																					CAaddrChooser=3 => le.address_verification.address_history_2.applicant_owned,
																					false);
	self.CurrAddrApplicantOwned := checkboolean( CAisOwnedBySubject );
	
	CAisFamilyOwned := map(CAaddrChooser=1 => le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned,
																			 CAaddrChooser=2 => le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned,
																			 CAaddrChooser=3 => le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned,
																			 false);
	self.CurrAddrFamilyOwned := checkboolean( CAisFamilyOwned );
	
	CAisOccupantOwned := map(CAaddrChooser=1 => le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																														~le.address_verification.input_address_information.family_owned,
																				 CAaddrChooser=2 => le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																														~le.address_verification.address_history_1.family_owned,
																				 CAaddrChooser=3 => le.address_verification.address_history_2.occupant_owned and ~le.address_verification.address_history_2.applicant_owned and
																														~le.address_verification.address_history_2.family_owned,
																				 false);
	self.CurrAddrOccupantOwned := checkboolean( CAisOccupantOwned );
																				 
	CALastSaleDate := map(CAaddrChooser=1 => le.address_verification.input_address_information.purchase_date,
												CAaddrChooser=2 => le.address_verification.address_history_1.purchase_date,
												CAaddrChooser=3 => le.address_verification.address_history_2.purchase_date,
												0);
										
	self.CurrAddrLastSalesDate := (string)if(CALastSaleDate>fullDate, 0, CALastSaleDate);
	
	CALastSaleAmount := if(CALastSaleDate>fullDate, 0, 
																				map(CAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						CAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						CAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0));
	self.CurrAddrLastSalesAmount := (string)ut.imin2(CALastSaleAmount, cap10byte);
	
	CAisNotPrimaryRes := map(CAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 CAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 CAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
																				 true);
	self.CurrAddrNotPrimaryRes := checkboolean( CAisNotPrimaryRes );
	
	CAPhoneListed := map(CAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 CAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 CAaddrChooser=3 => le.address_verification.edaMatchLevel3,
																		 0);
	self.CurrAddrActivePhoneList := (string)CAPhoneListed;
	
	CAPhoneNumber := map(CAaddrChooser=1 => le.address_verification.activePhone,
																		 CAaddrChooser=2 => le.address_verification.activePhone2,
																		 CAaddrChooser=3 => le.address_verification.activePhone3,
																		 0);
	self.CurrAddrActivePhoneNumber := (string)CAPhoneNumber;
	
	CAMed_HHINC := map(CAaddrChooser=0 => '',
													CAaddrChooser=1 => le.ineasi.med_hhinc,
													CAaddrChooser=2 => le.easi1.med_hhinc,
													le.easi2.med_hhinc);															 
	self.CurrAddrMedianIncome := CAMed_HHINC;
	
	CAMED_HVAL := map(CAaddrChooser=0 => '',
													CAaddrChooser=1 => le.ineasi.med_hval,
													CAaddrChooser=2 => le.easi1.med_hval,
													le.easi2.med_hval);
													
	self.CurrAddrMedianHomeVal := CAMED_HVAL;
																	
	self.CurrAddrMurderIndex := map(CAaddrChooser=0 => '',
												CAaddrChooser=1 => le.ineasi.murders,
												CAaddrChooser=2 => le.easi1.murders,
												le.easi2.murders);
												
	self.CurrAddrCarTheftIndex := map(CAaddrChooser=0 => '',
												 CAaddrChooser=1 => le.ineasi.cartheft,
												 CAaddrChooser=2 => le.easi1.cartheft,
												 le.easi2.cartheft);
												 
	self.CurrAddrBurglaryIndex := map(CAaddrChooser=0 => '',
												CAaddrChooser=1 => le.ineasi.burglary,
												CAaddrChooser=2 => le.easi1.burglary,
												le.easi2.burglary);
	
	CATotCrime := map(CAaddrChooser=0 => '',
												 CAaddrChooser=1 => le.ineasi.totcrime,
												 CAaddrChooser=2 => le.easi1.totcrime,
												 le.easi2.totcrime);
	self.CurrAddrCrimeIndex := CATotCrime;
	
	self.CurrAddrTaxAssessedYr := map(CAaddrChooser=0 => '',
														CAaddrChooser=1 => le.avm.input_address_information.avm_assessed_value_year,
														CAaddrChooser=2 => le.avm.address_history_1.avm_assessed_value_year,
														le.avm.address_history_2.avm_assessed_value_year);	
	
	
	self.CurrAddrAssessMarket := map(CAaddrChooser=0 => '',
														CAaddrChooser=1 => le.avm.input_address_information.avm_market_total_value,
														CAaddrChooser=2 => le.avm.address_history_1.avm_market_total_value,
														le.avm.address_history_2.avm_market_total_value);	
		
	
	CATaxAssessmentValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
														le.avm.address_history_2.avm_tax_assessment_valuation);	
	self.CurrAddrTaxAssessVal := (string)ut.imin2(CATaxAssessmentValuation, cap10byte);
														
	
	CAPriceIndexValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
														le.avm.address_history_2.avm_price_index_valuation);	
	self.CurrAddrPriceIndVal := (string)ut.imin2(CAPriceIndexValuation, cap10byte);
	
	CAHedonicValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
														le.avm.address_history_2.avm_hedonic_valuation);	
	self.CurrAddrHedVal := (string)ut.imin2(CAHedonicValuation, cap10byte);
			
	
	CAAutomatedValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_Automated_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_Automated_valuation,
														le.avm.address_history_2.avm_Automated_valuation);	
	self.CurrAddrAutoVal := (string)ut.imin2(CAAutomatedValuation, cap10byte);
	
	
	CAConfidenceScore := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
														CAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
														le.avm.address_history_2.avm_confidence_score);	
	self.CurrAddrConfScore := (string)ut.imin2(CAConfidenceScore, cap2byte);
	
	
	CACountyMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
														le.avm.address_history_2.avm_median_fips_level)
																				, cap10byte);
	CATractMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
														le.avm.address_history_2.avm_median_geo11_level)
																				, cap10byte);
	CABlockMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
														le.avm.address_history_2.avm_median_geo12_level)
																				, cap10byte);
																				
	
	self.CurrAddrCountyIndex := formatdecimalstring(CAAutomatedValuation/CACountyMedianValuation, decimal_length);
	self.CurrAddrTractIndex :=  formatdecimalstring(CAAutomatedValuation/CATractMedianValuation, decimal_length);
	self.CurrAddrBlockIndex := formatdecimalstring(CAAutomatedValuation/CABlockMedianValuation, decimal_length);
	
	
// Characteristics of Previous Address (next most recently reported)
	// Previous address picker assumes that either the input or Address history 1 is current
	PAaddrChooser_temp := map(CAaddrChooser=1 => 2, // if input is current, then pick history 1 as previous
											 CAaddrChooser=2 and le.address_verification.input_address_information.date_last_seen > le.address_verification.address_history_2.date_last_seen => 1,	// if hist 1 is current and input date last seen > hist 2 date last seen then input is previous
											 CAaddrChooser=2 and le.address_verification.input_address_information.date_last_seen = le.address_verification.address_history_2.date_last_seen and
													le.address_verification.input_address_information.date_first_seen >= le.address_verification.address_history_2.date_first_seen => 1,	// if hist 1 is current and input date last seen = hist 2 date last seen and input date first seen >= hist 2 date first seen then input is previous
											 CAaddrChooser=3 and le.address_verification.input_address_information.date_last_seen > le.address_verification.address_history_1.date_last_seen => 1, // if hist 2 is current and input date last seen > hist 1 date last seen then input is previous
											 CAaddrChooser=3 and le.address_verification.input_address_information.date_last_seen = le.address_verification.address_history_1.date_last_seen and
													le.address_verification.input_address_information.date_first_seen >= le.address_verification.address_history_1.date_first_seen => 1,	// if hist 2 is current and input date last seen = hist 1 date last seen and input date first seen >= hist 1 date first seen then input is previous
											 CAaddrChooser=2 => 3,	// if none of the above and hist 1 is current, then hist 2 is previous
											 CAaddrChooser=0 => 0,	// no Current address chosen
											 2);	// if none of the above and hist 2 is current, then hist 1 is previous
	
	// override the previous address chooser to 0 if the address selected as previous doesn't actually exist
	PAaddrChooser := if( (PAaddrChooser_temp=1 and le.address_verification.input_address_information.prim_name='') or
											 (PAaddrChooser_temp=2 and le.address_verification.address_history_1.prim_name='') or
											 (PAaddrChooser_temp=3 and le.address_verification.address_history_2.prim_name=''), 
											 0,
											 PAaddrChooser_temp);
											 
	
	PADateFirstReported := (unsigned)checkDate6(map(PAaddrChooser=1 => le.address_verification.input_address_information.date_first_seen,
																					 PAaddrChooser=2 =>	le.address_verification.address_history_1.date_first_seen,
																					 PAaddrChooser=3 => le.address_verification.address_history_2.date_first_seen,
																					 0) );
	PADateLastReported := (unsigned)checkDate6(map(PAaddrChooser=1 => le.address_verification.input_address_information.date_last_seen,
																							PAaddrChooser=2 => le.address_verification.address_history_1.date_last_seen,
																							PAaddrChooser=3 => le.address_verification.address_history_2.date_last_seen,
																							0));
	
	self.TimeSincePrevAddrFirstSeen := (string)ut.imin2( months_apart(system_yearmonth, PADateFirstReported), cap4byte);

	self.TimeSincePrevAddrLastSeen := (string)ut.imin2( months_apart(system_yearmonth, PADateLastReported), cap4byte);
	
	PALenOfRes := if(PADateFirstReported <> 0 and PADateLastReported <> 0,
																		round((ut.DaysApart((string)PADateFirstReported, 
																												(string)PADateLastReported)) / 30),  0);
	self.PrevAddrLenOfRes := (string)ut.imin2( PALenOfRes, cap3Byte ); 
	self.PrevAddrDwellType := map(PAaddrChooser=1 => if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type),
																	 PAaddrChooser=2 => le.address_verification.addr_type2,
																	 PAaddrChooser=3 => le.address_verification.addr_type3,
																	 '');
	self.PrevAddrLandUseCode := map(PAaddrChooser=1 => le.avm.input_address_information.avm_land_use_code,
																		 PAaddrChooser=2 => le.avm.address_history_1.avm_land_use_code,
																		 PAaddrChooser=3 => le.avm.address_history_2.avm_land_use_code,
																		 '');
	PAAssessedValue:= map(PAaddrChooser=1 => le.address_verification.input_address_information.assessed_amount,
																			 PAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount,
																			 PAaddrChooser=3 => le.address_verification.address_history_2.assessed_amount,
																			 0);
	self.PrevAddrAssessedValue := (string)ut.imin2(PAAssessedValue, cap10byte);
	
	PAisOwnedBySubject := map(PAaddrChooser=1 => le.address_verification.input_address_information.applicant_owned,
														PAaddrChooser=2 => le.address_verification.address_history_1.applicant_owned,
														PAaddrChooser=3 => le.address_verification.address_history_2.applicant_owned,
														false);
	self.PrevAddrApplicantOwned:= checkboolean(PAisOwnedBySubject);
	PAisFamilyOwned := map(PAaddrChooser=1 => le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned,
																			 PAaddrChooser=2 => le.address_verification.address_history_1.family_owned and ~le.address_verification.address_history_1.applicant_owned,
																			 PAaddrChooser=3 => le.address_verification.address_history_2.family_owned and ~le.address_verification.address_history_2.applicant_owned,
																			 false);
	self.PrevAddrFamilyOwned := checkboolean(PAisFamilyOwned);
	PAisOccupantOwned := map(PAaddrChooser=1 => le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																													~le.address_verification.input_address_information.family_owned,
																				 PAaddrChooser=2 => le.address_verification.address_history_1.occupant_owned and ~le.address_verification.address_history_1.applicant_owned and
																													~le.address_verification.address_history_1.family_owned,
																				 PAaddrChooser=3 => le.address_verification.address_history_2.occupant_owned and ~le.address_verification.address_history_2.applicant_owned and
																														~le.address_verification.address_history_2.family_owned,
																				 false);
	self.PrevAddrOccupantOwned := checkboolean(PAisOccupantOwned);
	PALastSaleDate := map(PAaddrChooser=1 => le.address_verification.input_address_information.purchase_date,
												PAaddrChooser=2 => le.address_verification.address_history_1.purchase_date,
												PAaddrChooser=3 => le.address_verification.address_history_2.purchase_date,
												0);
	self.PrevAddrLastSalesDate := (string)if(PALastSaleDate>fullDate, 0, PALastSaleDate);
	PALastSaleAmount := if(PALastSaleDate>fullDate, 0, 
																				map(PAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						PAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						PAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0));
	self.PrevAddrLastSalesAmount := (string)ut.imin2(PALastSaleAmount, cap10byte);
	PAisNotPrimaryRes := map(PAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
													 PAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
													 PAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
													 true);
	self.PrevAddrNotPrimaryRes := checkboolean(PAisNotPrimaryRes);
	PAPhoneListed := map(PAaddrChooser=1 => le.address_verification.edaMatchLevel,
											 PAaddrChooser=2 => le.address_verification.edaMatchLevel2,
											 PAaddrChooser=3 => le.address_verification.edaMatchLevel3,
											 0);
	self.PrevAddrActivePhoneList := (string)PAPhoneListed;
	PAPhoneNumber := map(PAaddrChooser=1 => le.address_verification.activePhone,
											 PAaddrChooser=2 => le.address_verification.activePhone2,
											 PAaddrChooser=3 => le.address_verification.activePhone3,
											 0);
	self.PrevAddrActivePhoneNumber := (string)PAPhoneNumber;
	
	PAMed_HHINC := map(PAaddrChooser=1 => le.ineasi.med_hhinc,
																	 PAaddrChooser=2 => le.easi1.med_hhinc,
																	 PAaddrChooser=3 => le.easi2.med_hhinc,
																	 '');
	self.PrevAddrMedianIncome := PAMed_HHINC;
	
	PAMed_Hval := map(PAaddrChooser=1 => le.ineasi.med_hval,
																	PAaddrChooser=2 => le.easi1.med_hval,
																	PAaddrChooser=3 => le.easi2.med_hval,
																	'');
	self.PrevAddrMedianHomeVal := PAMed_Hval;
	
	self.PrevAddrMurderIndex := map(PAaddrChooser=1 => le.ineasi.murders,
																 PAaddrChooser=2 => le.easi1.murders,
																 PAaddrChooser=3 => le.easi2.murders,
																 '');
	self.PrevAddrCarTheftIndex := map(PAaddrChooser=1 => le.ineasi.cartheft,
																	PAaddrChooser=2 => le.easi1.cartheft,
																	PAaddrChooser=3 => le.easi2.cartheft,
																	'');
	self.PrevAddrBurglaryIndex := map(PAaddrChooser=1 => le.ineasi.burglary,
																	PAaddrChooser=2 => le.easi1.burglary,
																	PAaddrChooser=3 => le.easi2.burglary,
																	'');
	PATotCrime := map(PAaddrChooser=1 => le.ineasi.totcrime,
																	PAaddrChooser=2 => le.easi1.totcrime,
																	PAaddrChooser=3 => le.easi2.totcrime,
																	'');
	self.PrevAddrCrimeIndex := PATotCrime;	
	
	
	self.PrevAddrTaxAssessedYr := map(PAaddrChooser=0 => '',
														PAaddrChooser=1 => le.avm.input_address_information.avm_assessed_value_year,
														PAaddrChooser=2 => le.avm.address_history_1.avm_assessed_value_year,
														le.avm.address_history_2.avm_assessed_value_year);	
	
	
	self.PrevAddrAssessMarket := map(PAaddrChooser=0 => '',
														PAaddrChooser=1 => le.avm.input_address_information.avm_market_total_value,
														PAaddrChooser=2 => le.avm.address_history_1.avm_market_total_value,
														le.avm.address_history_2.avm_market_total_value);	
		
	
	PATaxAssessmentValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
														le.avm.address_history_2.avm_tax_assessment_valuation);	
	self.PrevAddrTaxAssessVal := (string)ut.imin2(PATaxAssessmentValuation, cap10byte);
														
	
	PAPriceIndexValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
														le.avm.address_history_2.avm_price_index_valuation);	
	self.PrevAddrPriceIndVal := (string)ut.imin2(PAPriceIndexValuation, cap10byte);
	
	PAHedonicValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
														le.avm.address_history_2.avm_hedonic_valuation);	
	self.PrevAddrHedVal := (string)ut.imin2(PAHedonicValuation, cap10byte);
			
	
	PAAutomatedValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_Automated_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_Automated_valuation,
														le.avm.address_history_2.avm_Automated_valuation);	
	self.PrevAddrAutoVal := (string)ut.imin2(PAAutomatedValuation, cap10byte);
	
	
	PAConfidenceScore := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
														PAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
														le.avm.address_history_2.avm_confidence_score);	
	self.PrevAddrConfScore := (string)ut.imin2(PAConfidenceScore, cap2byte);
	
	
	PACountyMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
														le.avm.address_history_2.avm_median_fips_level)
																				, cap10byte);
	PATractMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
														le.avm.address_history_2.avm_median_geo11_level)
																				, cap10byte);
	PABlockMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
														le.avm.address_history_2.avm_median_geo12_level)
																				, cap10byte);
																				
	
	self.PrevAddrCountyIndex := formatdecimalstring(PAAutomatedValuation/PACountyMedianValuation, decimal_length);
	self.PrevAddrTractIndex :=  formatdecimalstring(PAAutomatedValuation/PATractMedianValuation, decimal_length);
	self.PrevAddrBlockIndex := formatdecimalstring(PAAutomatedValuation/PABlockMedianValuation, decimal_length);
	
	default_no_distance := 9999;
		
// Differences between Input Address and Current Address
	self.InputAddrCurrAddrMatch := checkboolean(CAaddrChooser=1);
	inputaddrcurraddrdistance := map(CAaddrChooser=1 => 0,// same address as input
																		 CAaddrChooser=2 => le.address_verification.distance_in_2_h1,// compare input to history 1
																		 CAaddrChooser=3 => le.address_verification.distance_in_2_h2,// compare input to history 2
																		 default_no_distance); // no distance calculated
																		 
	self.InputAddrCurrAddrDistance := (string)if(inputaddrcurraddrdistance > default_no_distance, cap4byte, inputaddrcurraddrdistance);
	currAddrSt := map(CAaddrChooser=1 => le.address_verification.input_address_information.st,
										CAaddrChooser=2 => le.address_verification.address_history_1.st,
										CAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');																	 				 
	self.InputAddrCurrAddrStateDiff := checkboolean(currAddrSt<>(StringLib.StringToUpperCase(le.shell_input.in_state)));
	
	assessedDiff := map(
		CAaddrChooser=1 => 0, // same address as input
		CAaddrChooser=2 => le.address_verification.address_history_1.assessed_amount - le.address_verification.input_address_information.assessed_amount,
		CAaddrChooser=3 => le.address_verification.address_history_2.assessed_amount - le.address_verification.input_address_information.assessed_amount,
		0
	);

	self.InputAddrCurrAddrAssessedDiff := (string)ut.imin2(999999,ut.max2(-999999,(integer)assessedDiff));

	self.InputAddrCurrAddrIncomeDiff  := (string)if(CAaddrChooser in [0,1], 0, if(CAaddrChooser=2, (unsigned)CAmed_hhinc - (unsigned)IAmed_hhinc, (unsigned)PAmed_hhinc - (unsigned)IAmed_hhinc));
	self.InputAddrCurrAddrHomeValDiff := (string)if(CAaddrChooser in [0,1], 0, if(CAaddrChooser=2, (unsigned)CAmed_hval - (unsigned)IAmed_hval, (unsigned)PAmed_hval - (unsigned)IAmed_hval));
	self.InputAddrCurrAddrCrimeDiff   := (string)if(CAaddrChooser in [0,1], 0, if(CAaddrChooser=2, (unsigned)CAtotcrime - (unsigned)IAtotcrime, (unsigned)PAtotcrime - (unsigned)IAtotcrime));
	
	inputEcon := EconCode(le.iid.dwelltype, le.address_verification.input_address_information.assessed_amount, 
												le.avm.input_address_information, (unsigned)le.address_verification.input_address_information.census_home_value);
	hist1Econ := EconCode(le.address_verification.addr_type2, le.address_verification.address_history_1.assessed_amount, 
												le.avm.address_history_1, (unsigned)le.address_verification.address_history_1.census_home_value);											
	hist2Econ := EconCode(le.address_verification.addr_type3, le.address_verification.address_history_2.assessed_amount, 
												le.avm.address_history_2, (unsigned)le.address_verification.address_history_2.census_home_value);
																							
	CAeconCode := map(CAaddrChooser=1 => inputEcon,
										CAaddrChooser=2 => hist1Econ,
										CAaddrChooser=3 => hist2Econ,
										'U');
	PAeconCode := map(PAaddrChooser=1 => inputEcon,
										PAaddrChooser=2 => hist1Econ,
										PAaddrChooser=3 => hist2Econ,
										'U');

	self.EconomicTrajectory := CAeconCode+inputEcon;
	
	
	// Differences between Current Address and Previous Address
	prevAddr := map(PAaddrChooser=1 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
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
									PAaddrChooser=3 => Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.address_history_2.prim_range, 
																																 le.address_verification.address_history_2.predir, 
																																 le.address_verification.address_history_2.prim_name,
																																 le.address_verification.address_history_2.addr_suffix, 
																																 le.address_verification.address_history_2.postdir, 
																																 le.address_verification.address_history_2.unit_desig, 
																																 le.address_verification.address_history_2.sec_range),
									'');
	isInputPrevMatch := Risk_Indicators.MOD_AddressClean.street_address('',le.address_verification.input_address_information.prim_range, 
																																le.address_verification.input_address_information.predir, 
																																le.address_verification.input_address_information.prim_name,
																																le.address_verification.input_address_information.addr_suffix, 
																																le.address_verification.input_address_information.postdir, 
																																le.address_verification.input_address_information.unit_desig, 
																																le.address_verification.input_address_information.sec_range) =
																																prevAddr and prevAddr <> '';
	self.InputAddrPrevAddrMatch := checkboolean(isInputPrevMatch);
	
	CurrAddrPrevAddrDistance := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.distance_in_2_h1,
																		CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.distance_in_2_h2,
																		CAaddrChooser=2 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=2 => le.address_verification.distance_h1_2_h2,
																		default_no_distance);
																		
	self.CurrAddrPrevAddrDistance := (string)if(CurrAddrPrevAddrDistance > default_no_distance, cap4byte, CurrAddrPrevAddrDistance);
																		
																		
	prevAddrSt := map(PAaddrChooser=1 => le.address_verification.input_address_information.st,
										PAaddrChooser=2 => le.address_verification.address_history_1.st,
										PAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');
	self.CurrAddrPrevAddrStateDiff:= checkboolean( if(isInputPrevMatch, false, (prevAddrSt<>currAddrSt)) );
	self.CurrAddrPrevAddrAssessedDiff := (string)if(isInputPrevMatch, 0, ut.max2(-999999, ut.imin2(999999,CAAssessedValue - PAAssessedValue)));
	self.CurrAddrPrevAddrIncomeDiff := (string)if(isInputPrevMatch,0, (unsigned)CAmed_hhinc - (unsigned)PAmed_hhinc);
	self.CurrAddrPrevAddrHomeValDiff := (string)if(isInputPrevMatch, 0, (unsigned)CAmed_hval - (unsigned)PAmed_hval);
	self.CurrAddrPrevAddrCrimeDiff := (string)if(isInputPrevMatch,0, (unsigned)CAtotcrime - (unsigned)PAtotcrime);
	self.EconomicTrajectory2 := PAeconCode+CAeconCode;
	
	
// Transient Person Attributes	
	self.AddrStability := le.mobility_indicator;
	
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
	
	self.StatusMostRecent := map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	CAaddrChooser=3 => statusAddr3,
																	'U');
																	
	self.StatusPrevious := map(PAaddrChooser=1 => statusAddr1,
																	 PAaddrChooser=2 => statusAddr2,
																	 PAaddrChooser=3 => statusAddr3,
																	 'U');
	self.StatusNextPrevious := map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => statusAddr3,
																	 CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => statusAddr2,
																	 'U');
	
	// this attribute is redundant, exactly the same as TimeSincePrevAddrFirstSeen, they wanted to keep it in case customers want to only buy certain sections of the attributes
	self.TimeSincePrevAddrDateFirstSeen := (string)ut.imin2( months_apart(system_yearmonth, PADateFirstReported), cap4byte);  
	
	NPADateFirstReported := (unsigned)checkDate6( map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.address_history_2.date_first_seen,
																						CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.address_history_1.date_first_seen,
																						CAaddrChooser=0 => 0,	// if we dont know what current is, then 0
																						if(le.iid.chronodate_first < PADateFirstReported, le.iid.chronodate_first, 
																									if(le.iid.chronodate_first2 < PADateFirstReported, le.iid.chronodate_first2,
																												le.iid.chronodate_first3))) );//assuming one of the chronodates is the third address, pick the one that is less than the pa date
	self.TimeSinceNextPrevDateFirstSeen := (string)ut.imin2( months_apart(system_yearmonth, NPADateFirstReported), cap4byte);
	
	self.addrChanges30 := (string)ut.imin2(le.other_address_info.addrs_last30, cap2byte);
	self.addrChanges90 := (string)ut.imin2(le.other_address_info.addrs_last90, cap2byte);
	self.addrChanges180 := (string)ut.imin2(le.velocity_counters.addrs_per_adl_created_6months, cap2byte);
	self.addrChanges12 := (string)ut.imin2(le.other_address_info.addrs_last12, cap2byte);
	self.addrChanges24 := (string)ut.imin2(le.other_address_info.addrs_last24, cap2byte);
	self.addrChanges36 := (string)ut.imin2(le.other_address_info.addrs_last36, cap2byte);
	self.addrChanges60 := (string)ut.imin2(le.other_address_info.addrs_last_5years, cap2byte);
	
// Property and Asset Information
	self.propertyownedtotal := (string)ut.imin2(le.address_verification.owned.property_total, cap2byte);
	self.propertyownedassessedtotal := (string)ut.imin2(le.address_verification.owned.property_owned_assessed_total, cap13byte);
	self.propertyhistoricallyowned := (string)ut.imin2(le.address_verification.owned.property_total + le.address_verification.sold.property_total + le.address_verification.ambiguous.property_total, cap2byte);
	self.datefirstpurchase := (string)if(le.other_address_info.date_first_purchase>fullDate, 0, le.other_address_info.date_first_purchase);
	self.datemostrecentpurchase := (string)if(le.other_address_info.date_most_recent_purchase>fullDate, 0, le.other_address_info.date_most_recent_purchase);
	self.datemostrecentsale := (string)if(le.other_address_info.date_most_recent_sale>fullDate, 0, le.other_address_info.date_most_recent_sale);
	self.PropPurchased30 := (string)ut.imin2(le.other_address_info.num_purchase30, cap2byte);
	self.PropPurchased90 := (string)ut.imin2(le.other_address_info.num_purchase90, cap2byte);
	self.PropPurchased180 := (string)ut.imin2(le.other_address_info.num_purchase180, cap2byte);
	self.PropPurchased12 := (string)ut.imin2(le.other_address_info.num_purchase12, cap2byte);
	self.PropPurchased24 := (string)ut.imin2(le.other_address_info.num_purchase24, cap2byte);
	self.PropPurchased36 := (string)ut.imin2(le.other_address_info.num_purchase36, cap2byte);
	self.PropPurchased60 := (string)ut.imin2(le.other_address_info.num_purchase60, cap2byte);
	self.PropSold30 := (string)ut.imin2(le.other_address_info.num_sold30, cap2byte);
	self.PropSold90 := (string)ut.imin2(le.other_address_info.num_sold90, cap2byte);
	self.PropSold180 := (string)ut.imin2(le.other_address_info.num_sold180, cap2byte);
	self.PropSold12 := (string)ut.imin2(le.other_address_info.num_sold12, cap2byte);
	self.PropSold24 := (string)ut.imin2(le.other_address_info.num_sold24, cap2byte);
	self.PropSold36 := (string)ut.imin2(le.other_address_info.num_sold36, cap2byte);
	self.PropSold60 := (string)ut.imin2(le.other_address_info.num_sold60, cap2byte);
	self.numWatercraft := (string)ut.imin2(le.watercraft.watercraft_count, cap2byte);
	self.numWatercraft30 := (string)ut.imin2(le.watercraft.watercraft_count30, cap2byte);
	self.numWatercraft90 := (string)ut.imin2(le.watercraft.watercraft_count90, cap2byte);
	self.numWatercraft180 := (string)ut.imin2(le.watercraft.watercraft_count180, cap2byte);
	self.numWatercraft12 := (string)ut.imin2(le.watercraft.watercraft_count12, cap2byte);
	self.numWatercraft24 := (string)ut.imin2(le.watercraft.watercraft_count24, cap2byte);
	self.numWatercraft36 := (string)ut.imin2(le.watercraft.watercraft_count36, cap2byte);
	self.numWatercraft60 := (string)ut.imin2(le.watercraft.watercraft_count60, cap2byte);
	self.numAircraft := (string)ut.imin2(le.aircraft.aircraft_count, cap2byte);
	self.numAircraft30 := (string)ut.imin2(le.aircraft.aircraft_count30, cap2byte);
	self.numAircraft90 := (string)ut.imin2(le.aircraft.aircraft_count90, cap2byte);
	self.numAircraft180 := (string)ut.imin2(le.aircraft.aircraft_count180, cap2byte);
	self.numAircraft12 := (string)ut.imin2(le.aircraft.aircraft_count12, cap2byte);
	self.numAircraft24 := (string)ut.imin2(le.aircraft.aircraft_count24, cap2byte);
	self.numAircraft36 := (string)ut.imin2(le.aircraft.aircraft_count36, cap2byte);
	self.numAircraft60 := (string)ut.imin2(le.aircraft.aircraft_count60, cap2byte);
	self.wealthIndex := le.wealth_indicator;	
	
// Derogatory Public Records
	self.totalnumberderogs := (string)ut.imin2(le.bjl.criminal_count + le.bjl.filing_count + le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, cap2byte);
	date_last_derog := ut.max2(ut.max2(le.bjl.last_criminal_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
	self.datelastderog := (string)if(date_last_derog>fullDate, 0, date_last_derog);
	self.numfelonies := (string)ut.imin2(le.bjl.felony_count, cap2byte);
	self.datelastconviction := (string)if(le.bjl.last_felony_date>fullDate, 0, le.bjl.last_felony_date);
	self.numfelonies30 := (string)ut.imin2(le.bjl.criminal_count30, cap2byte);
	self.numfelonies90 := (string)ut.imin2(le.bjl.criminal_count90, cap2byte);
	self.numfelonies180 := (string)ut.imin2(le.bjl.criminal_count180, cap2byte);
	self.numfelonies12 := (string)ut.imin2(le.bjl.criminal_count12, cap2byte);
	self.numfelonies24 := (string)ut.imin2(le.bjl.criminal_count24, cap2byte);
	self.numfelonies36 := (string)ut.imin2(le.bjl.criminal_count36, cap2byte);
	self.numfelonies60 := (string)ut.imin2(le.bjl.criminal_count60, cap2byte);
	
	self.numarrests := (string)ut.imin2(le.bjl.arrests_count, cap2byte);
	self.datelastarrest := (string)if(le.bjl.date_last_arrest>fullDate, 0, le.bjl.date_last_arrest);
	self.numarrests30 := (string)ut.imin2(le.bjl.arrests_count30, cap2byte);
	self.numarrests90 := (string)ut.imin2(le.bjl.arrests_count90, cap2byte);
	self.numarrests180 := (string)ut.imin2(le.bjl.arrests_count180, cap2byte);
	self.numarrests12 := (string)ut.imin2(le.bjl.arrests_count12, cap2byte);
	self.numarrests24 := (string)ut.imin2(le.bjl.arrests_count24, cap2byte);
	self.numarrests36 := (string)ut.imin2(le.bjl.arrests_count36, cap2byte);
	self.numarrests60 := (string)ut.imin2(le.bjl.arrests_count60, cap2byte);
	
	self.LiensCount:= (string)ut.imin2(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
														 le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, cap2byte);
	self.LiensUnreleasedCount := (string)ut.imin2(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, cap2byte);
	self.MostRecentUnrelDate := (string)if((unsigned)le.bjl.last_liens_unreleased_date>fullDate, 0, (unsigned)le.bjl.last_liens_unreleased_date);
	self.LiensUnreleasedCount30 := (string)ut.imin2(le.bjl.liens_unreleased_count30, cap2byte);
	self.LiensUnreleasedCount90 := (string)ut.imin2(le.bjl.liens_unreleased_count90, cap2byte);
	self.LiensUnreleasedCount180 := (string)ut.imin2(le.bjl.liens_unreleased_count180, cap2byte);
	self.LiensUnreleasedCount12 := (string)ut.imin2(le.bjl.liens_unreleased_count12, cap2byte);
	self.LiensUnreleasedCount24 := (string)ut.imin2(le.bjl.liens_unreleased_count24, cap2byte);
	self.LiensUnreleasedCount36 := (string)ut.imin2(le.bjl.liens_unreleased_count36, cap2byte);
	self.LiensUnreleasedCount60 := (string)ut.imin2(le.bjl.liens_unreleased_count60, cap2byte);
	
	self.LiensReleasedCount := (string)ut.imin2(le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, cap2byte);
	self.MostRecentReleasedDate := (string)if(le.bjl.last_liens_released_date>fullDate, 0, le.bjl.last_liens_released_date);
	self.LiensReleasedCount30 := (string)ut.imin2(le.bjl.liens_released_count30, cap2byte);
	self.LiensReleasedCount90 := (string)ut.imin2(le.bjl.liens_released_count90, cap2byte);
	self.LiensReleasedCount180 := (string)ut.imin2(le.bjl.liens_released_count180, cap2byte);
	self.LiensReleasedCount12 := (string)ut.imin2(le.bjl.liens_released_count12, cap2byte);
	self.LiensReleasedCount24 := (string)ut.imin2(le.bjl.liens_released_count24, cap2byte);
	self.LiensReleasedCount36 := (string)ut.imin2(le.bjl.liens_released_count36, cap2byte);
	self.LiensReleasedCount60 := (string)ut.imin2(le.bjl.liens_released_count60, cap2byte);
	
	self.bankruptCount := (string)ut.imin2(le.bjl.filing_count, cap2byte);
	self.MostRecentBankruptDate := (string)if(le.bjl.date_last_seen>fullDate, 0, le.bjl.date_last_seen);
	self.MostRecentBankruptType := le.bjl.filing_type;
	self.MostRecentBankruptStatus := le.bjl.disposition;
	self.bankruptCount30 := (string)ut.imin2(le.bjl.bk_count30, cap2byte);
	self.bankruptCount90 := (string)ut.imin2(le.bjl.bk_count90, cap2byte);
	self.bankruptCount180 := (string)ut.imin2(le.bjl.bk_count180, cap2byte);
	self.bankruptCount12 := (string)ut.imin2(le.bjl.bk_count12, cap2byte);
	self.bankruptCount24 := (string)ut.imin2(le.bjl.bk_count24, cap2byte);
	self.bankruptCount36 := (string)ut.imin2(le.bjl.bk_count36, cap2byte);
	self.bankruptCount60 := (string)ut.imin2(le.bjl.bk_count60, cap2byte);
	
	self.evictionCount := (string)ut.imin2(le.bjl.eviction_recent_unreleased_count + le.bjl.eviction_historical_unreleased_count +
																	le.bjl.eviction_recent_released_count + le.bjl.eviction_historical_released_count, cap2byte);
	self.MostRecentEvictionDate := (string)if(le.bjl.last_eviction_date>fullDate, 0, le.bjl.last_eviction_date);
	self.evictionCount30 := (string)ut.imin2(le.bjl.eviction_count30, cap2byte);
	self.evictionCount90 := (string)ut.imin2(le.bjl.eviction_count90, cap2byte);
	self.evictionCount180 := (string)ut.imin2(le.bjl.eviction_count180, cap2byte);
	self.evictionCount12 := (string)ut.imin2(le.bjl.eviction_count12, cap2byte);
	self.evictionCount24 := (string)ut.imin2(le.bjl.eviction_count24, cap2byte);
	self.evictionCount36 := (string)ut.imin2(le.bjl.eviction_count36, cap2byte);
	self.evictionCount60 := (string)ut.imin2(le.bjl.eviction_count60, cap2byte);	
	
	// Non-Derogatory Public Records
	self.NonDerogSrcCount := (string)ut.imin2(le.source_verification.num_nonderogs, cap2byte);	
	self.NonDerogSrcCount30 := (string)ut.imin2(le.source_verification.num_nonderogs30, cap2byte);
	self.NonDerogSrcCount90 := (string)ut.imin2(le.source_verification.num_nonderogs90, cap2byte);
	self.NonDerogSrcCount180 := (string)ut.imin2(le.source_verification.num_nonderogs180, cap2byte);
	self.NonDerogSrcCount12 := (string)ut.imin2(le.source_verification.num_nonderogs12, cap2byte);
	self.NonDerogSrcCount24 := (string)ut.imin2(le.source_verification.num_nonderogs24, cap2byte);
	self.NonDerogSrcCount36 := (string)ut.imin2(le.source_verification.num_nonderogs36, cap2byte);
	self.NonDerogSrcCount60 := (string)ut.imin2(le.source_verification.num_nonderogs60, cap2byte);
	
	self.ProfLicCount := (string)ut.imin2(le.professional_license.proflic_count, cap2byte);
	self.MostRecentProfLicDate := (string)if(le.professional_license.date_most_recent>fullDate, 0, le.professional_license.date_most_recent);
	self.MostRecentProfLicExpireDate := (string)le.professional_license.expiration_date;
	self.ProfLicCount30 := (string)ut.imin2(le.professional_license.proflic_count30, cap2byte);
	self.ProfLicCount90 := (string)ut.imin2(le.professional_license.proflic_count90, cap2byte);
	self.ProfLicCount180 := (string)ut.imin2(le.professional_license.proflic_count180, cap2byte);
	self.ProfLicCount12 := (string)ut.imin2(le.professional_license.proflic_count12, cap2byte);
	self.ProfLicCount24 := (string)ut.imin2(le.professional_license.proflic_count24, cap2byte);
	self.ProfLicCount36 := (string)ut.imin2(le.professional_license.proflic_count36, cap2byte);
	self.ProfLicCount60 := (string)ut.imin2(le.professional_license.proflic_count60, cap2byte);
	self.ProfLicExpireCount30 := (string)ut.imin2(le.professional_license.expire_count30, cap2byte);
	self.ProfLicExpireCount90 := (string)ut.imin2(le.professional_license.expire_count90, cap2byte);
	self.ProfLicExpireCount180 := (string)ut.imin2(le.professional_license.expire_count180, cap2byte);
	self.ProfLicExpireCount12 := (string)ut.imin2(le.professional_license.expire_count12, cap2byte);
	self.ProfLicExpireCount24 := (string)ut.imin2(le.professional_license.expire_count24, cap2byte);
	self.ProfLicExpireCount36 := (string)ut.imin2(le.professional_license.expire_count36, cap2byte);
	self.ProfLicExpireCount60 := (string)ut.imin2(le.professional_license.expire_count60, cap2byte);
	
// Higher Risk Address and Phone Attributes																
	self.InputAddrHighRisk := checkboolean( le.iid.hriskaddrflag = '4' );
	self.InputPhoneHighRisk := checkboolean( le.iid.hriskphoneflag = '6' );
	self.sic := MAP(le.iid.addrcommflag = '1' => RiskWise.convertSIC(le.iid.hrisksicphone),
													 le.iid.addrcommflag = '2' => RiskWise.convertSIC(le.iid.hrisksic),
													 '');
	self.InputAddrPrison := checkboolean( le.iid.hriskaddrflag='4' AND le.iid.hrisksic = '2225' );
	self.InputZipPOBox := checkboolean( le.iid.zipclass='P' );
	self.InputZipCorpMil := checkboolean( le.iid.zipclass in ['M','U'] );
	self.InputphoneStatus := map(le.iid.phonedissflag and le.input_validation.homephone => 'D',
																	 le.iid.phonevalflag in ['1','2'] or (le.iid.phonevalflag = '3' and le.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																	 '');
	self.InputPhonePager := checkboolean( le.iid.hriskphoneflag = '2' );
	self.InputPhoneMobile := checkboolean( le.iid.hriskphoneflag = '1' );
	self.InvalidPhoneZip := checkboolean( le.iid.phonezipflag = '1' );
	self.InputPhoneAddrDist := (string)if(le.iid.disthphoneaddr > default_no_distance, cap4byte, le.iid.disthphoneaddr);
	self.PhoneType := le.iid.hphonetypeflag;
  self.ServiceType := risk_indicators.PRIIPhoneRiskFlag('').telcordiaServiceType(le.phone_verification.telcordia_type);
	self.AreaCodeChange := map(le.iid.areacodesplitflag='Y' => '1',
																		 le.iid.reverse_areacodesplitflag='Y' => '2',
																		 '');
	self.addrval := le.iid.addrvalflag;
  self.addrvalErrorCode := riskwise.certErr(le.shell_input.addr_status, le.shell_input.predir, le.shell_input.prim_name,
																								le.shell_input.addr_suffix, le.shell_input.postdir, le.shell_input.st);	
	
	gong_ADL_first_seen_month := (unsigned)checkDate6( (unsigned)le.gong_ADL_dt_first_seen[1..6] );
	gong_ADL_last_seen_month := (unsigned)checkDate6( (unsigned)le.gong_ADL_dt_last_seen[1..6] );	
	self.TimeSinceSubjectPhoneFirstSeen := (string)ut.imin2( months_apart(system_yearmonth, gong_ADL_first_seen_month), cap4byte);
	self.TimeSinceSubjectPhoneLastSeen := (string)ut.imin2( months_apart(system_yearmonth, gong_ADL_first_seen_month), cap4byte);
	
	// default someone to 0 until proven otherwise
	self.DoNotMail := '0';
	
	self.clam := le;
	self.version3 := [];
end;

p := project(clam_with_Easi, map_fields(left));

// output(clam_with_Easi, named('clam_with_Easi'));  // for debugging






renameField( v1_name, v3_name, blank_condition=false, null_9999_condition = FALSE ) := MACRO
	self.v1_name := ''; // blank out the field no longer used (not -1)
	// copy the old value to the new location; convert blank null values to -1
	self.version3.v3_name := if(trim(le.v1_name) IN IF(null_9999_condition, ['', '9999'], ['']) or blank_condition, '-1', le.v1_name );
ENDMACRO;

string calcMonths( integer sysDt, string someDt, integer cap ) := (string)ut.imin2( cap, months_apart( sysDt, (unsigned)someDt ));

// some v1 fields were YYYYMM values, and their updated v3 values are months since instead.
YYYYMM_to_months( v1_name, v3_name, blank_condition=false, cap=9998 ) := MACRO
	self.version3.v3_name := if( trim(le.v1_name) in ['','0'] or blank_condition, '-1', calcMonths(sysdate,le.v1_name,cap));
	self.v1_name := '';
ENDMACRO;

Null_V3( v1_name, blank_condition=false, null_9999_condition = FALSE ) := MACRO
	self.v1_name := if( blank_condition or trim(le.v1_name) IN IF(null_9999_condition, ['', '9999'], ['']), '-1', le.v1_name );
ENDMACRO;
maxout( v ) := MACRO if(v=0, 999999, v) ENDMACRO;

working_layout map_fields_v3( working_layout le ) := TRANSFORM
	// Version 3
	getMin(string l, string r) := IF((unsigned)l < (unsigned)r, l, r);	// get smaller number
	cap150 := '150';
	cap960 := '960';
	sysdate := if(le.clam.historydate <> 999999, (integer)((string)le.clam.historydate[1..6]), (integer)(ut.GetDate[1..6]));


	noAddr    := not le.clam.input_validation.Address;
	noZip     := trim(le.clam.Shell_Input.in_zipcode)='';
	noPhone   := not le.clam.input_validation.homephone;
	noSSN     := not le.clam.input_validation.ssn;
	noDOB     := not le.clam.input_validation.dateofbirth;
	ssnNull   := (noSSN or not le.clam.iid.ssnexists);
	phoneNull := (le.clam.iid.phonephonecount=0 or noPhone);


	sale := le.clam.address_verification.recent_property_sales.sale_price1;
	purch := le.clam.address_verification.recent_property_sales.prev_purch_price1;
	self.version3.PropNewestSalePurchaseIndex := map(
		sale = 0 => '-1',
		purch = 0              => '0', // can't divide by zero
		FormatDecimalString( max(0.1,min(sale/purch,99)), 2 ) // leading zero + decimal + two sig figs fit into four bytes
	);

	// Phone History Attributes
	self.version3.PhoneOtherAgeOldestRecord := getMin(if(le.clam.infutor.infutor_date_first_seen=0, '-1', (string)round((ut.DaysApart((string)le.clam.infutor.infutor_date_first_seen, (string)sysdate)) / 30)), cap960);
	self.version3.PhoneOtherAgeNewestRecord := getMin(if(le.clam.infutor.infutor_date_last_seen=0,  '-1', (string)round((ut.DaysApart((string)le.clam.infutor.infutor_date_last_seen,  (string)sysdate)) / 30)), cap960);


	// Verification Attributes
	firstVerified := le.clam.iid.nap_summary in [3, 4, 8, 9, 10, 12] or le.clam.iid.nas_summary in [3, 4, 8, 9, 10, 12];
	lastVerified  := le.clam.iid.nap_summary in [5, 7, 8, 9, 11, 12] or le.clam.iid.nas_summary in [5, 7, 8, 9, 11, 12];
	self.version3.VerifiedName := map(
		firstVerified and lastVerified => '3',
		lastVerified => '2',
		firstVerified => '1',
		'0'
	);

	self.version3.VerifiedSSN := map(
		ssnNull => '-1',
		le.clam.iid.nas_summary in [7, 9, 10, 11, 12] => '2',
		le.clam.iid.nas_summary = 1 => '1',
		'0'
	);

	self.version3.VerifiedPhone := map(
		noPhone => '-1',
		le.clam.iid.nap_summary in [6, 7, 9, 10, 11, 12] => '2',
		le.clam.iid.nap_summary = 1 => '1',
		'0'
	);

	self.version3.VerifiedAddress := map(
		noAddr => '-1',
		le.clam.iid.nap_summary in [5, 8, 10, 11, 12] => '1',
		le.clam.iid.nas_summary in [5, 8, 10, 11, 12] => '1',
		'0'
	);

	self.version3.VerifiedDOB := map(
		not le.clam.input_validation.dateofbirth => '-1',
		le.clam.dobmatchlevel='8' => '7', // Full Date of Birth verified
		le.clam.dobmatchlevel='5' => '6', // Day and year verified
		le.clam.dobmatchlevel='4' => '5', // Month and day verified
		le.clam.dobmatchlevel='7' => '4', // Month and year verified
		le.clam.dobmatchlevel='6' => '3', // Year only verified
		le.clam.dobmatchlevel='3' => '2', // Month only verified
		le.clam.dobmatchlevel='2' => '1', // Day only verified
		'0'
	);


	// Sub-prime loan solicitation Attributes
	self.version3.SubPrimeSolicitedCount   := (string3)min(le.clam.impulse.count,255);
	self.version3.SubPrimeSolicitedCount01 := (string3)min(le.clam.impulse.count30,255);
	self.version3.SubprimeSolicitedCount03 := (string3)min(le.clam.impulse.count90,255);
	self.version3.SubprimeSolicitedCount06 := (string3)min(le.clam.impulse.count180,255);
	self.version3.SubPrimeSolicitedCount12 := (string3)min(le.clam.impulse.count12,255);
	self.version3.SubPrimeSolicitedCount24 := (string3)min(le.clam.impulse.count24,255);
	self.version3.SubPrimeSolicitedCount36 := (string3)min(le.clam.impulse.count36,255);
	self.version3.SubPrimeSolicitedCount60 := (string3)min(le.clam.impulse.count60,255);
	

	// Predicted Income Attributes
	self.version3.PredictedAnnualIncome := (string)le.clam.estimated_income;

	// Education Attributes
	attendedCollege := map(
		le.clam.student.file_type='H' => '1', 
		le.clam.student.file_type='C' => '1',
		le.clam.student.file_type='M' and (le.clam.student.college_code<>'' or le.clam.student.college_type<>'' or le.clam.student.college_name<>'') => '1',
		'0'
	);
	self.version3.EducationAttendedCollege := attendedCollege;
	self.version3.EducationProgram2Yr := map(
		le.clam.student.file_type='' => '-1',
		le.clam.student.college_code = '2' => '1',
		'0'
	);
	self.version3.EducationProgram4Yr := map(
		le.clam.student.file_type='' => '-1',
		le.clam.student.college_code = '4' => '1',
		'0'
	);
	self.version3.EducationProgramGraduate := map(
		le.clam.student.file_type='' => '-1',
		le.clam.student.college_code = '1' => '1',
		'0'
	);
	self.version3.EducationInstitutionPrivate := map(
		le.clam.student.file_type='' => '-1',
		le.clam.student.college_type = 'P' => '1',
		le.clam.student.college_type = 'R' => '1',
		'0'
	);
	self.version3.EducationInstitutionRating := if(attendedCollege='1', le.clam.student.college_tier, '-1'); // if didn't attended college then null 


	self.version3.EducationFieldofStudyType := map(
		attendedCollege = '0'                                           => '-1', // null
		// le.clam.student.college_major in ['', ' ', 'U', 'X']            => '0', // uncategorized
		le.clam.student.college_major in ['W', 'O']                     => '1', // Art, Music
		le.clam.student.college_major in ['C', 'F', 'I', 'J', 'K', 'Y'] => '2', // Education, Humanities, Religion, Social Sciences, Liberal Arts, English, Journalism
		le.clam.student.college_major in ['B', 'P', 'R', 'S', 'Z']      => '3', // Business, Accounting, Marketing, Finance, Management
		le.clam.student.college_major in ['A', 'H', 'Q']                => '4', // Biological Science, Physical Science, Biology
		le.clam.student.college_major in ['D', 'M', 'N']                => '5', // Engineering, Computers, Architecture
		le.clam.student.college_major in ['G']                          => '6', // Law, Legal Studies
		le.clam.student.college_major in ['E', 'L', 'T', 'V']           => '7', // Health professions, Nursing, Medicine, Chiropractic
		'0'
	);



	// Professional License Type Category attribute
	self.version3.ProfLicTypeCategory := if(le.clam.professional_license.plcategory='', '-1', le.clam.professional_license.plcategory);


	/* Requirement: New Derogatory Attribute
		Incorporate the following Derogatory Attributes: 
		o	Derogatory Severity Index (severity classification of the most severe derogatory records)

		Development Comments: R&D to provide the classification for this.
	*/



	self.version3.RelativesCount             := (string)ut.imin2( le.clam.relatives.relative_count, 255 );
	self.version3.RelativesBankruptcyCount   := (string)ut.imin2( le.clam.relatives.relative_bankrupt_count, 255 );
	self.version3.RelativesFelonyCount       := (string)ut.imin2( le.clam.relatives.relative_felony_count, 255 );
	self.version3.RelativesPropOwnedCount    := (string)ut.imin2( le.clam.relatives.owned.relatives_property_count, 255 );
	self.version3.RelativesPropOwnedTaxTotal := if( le.clam.relatives.owned.relatives_property_owned_assessed_total=0, '-1', (string)ut.imin2( le.clam.relatives.owned.relatives_property_owned_assessed_total, cap13Byte ) );
	self.version3.RelativesDistanceClosest   := map(
		noAddr => '-1',
		le.clam.relatives.relative_within25miles_count  > 0 => '0',
		le.clam.relatives.relative_within100miles_count > 0 => '1',
		le.clam.relatives.relative_within500miles_count > 0 => '2',
		le.clam.relatives.relative_withinother_count    > 0 => '3',
		'-1'
	);

	num_unreleased_liens := le.clam.bjl.liens_historical_unreleased_count + le.clam.bjl.liens_recent_unreleased_count;
	num_released_liens   := le.clam.bjl.liens_historical_released_count + le.clam.bjl.liens_recent_released_count;
	Bankruptcy_Count := le.clam.bjl.filing_count;
	self.version3.DerogSeverityIndex := map(
		le.clam.bjl.Felony_Count       > 0 => '5',
		le.clam.bjl.Eviction_Count     > 0 => '4',
		num_unreleased_liens           > 0 => '3',
		Bankruptcy_Count               > 0 => '2',
		num_released_liens             > 0 => '1',
		'0'
	);



	self.version3.PRSearchCollectionCount := '';
	self.version3.PRSearchCollectionCount01 := '';
	self.version3.PRSearchCollectionCount03 := '';
	self.version3.PRSearchCollectionCount06 := '';
	self.version3.PRSearchCollectionCount12 := '';
	self.version3.PRSearchCollectionCount24 := '';
	self.version3.PRSearchCollectionCount36 := '';
	self.version3.PRSearchCollectionCount60 := '';
	self.version3.PRSearchIDVFraudCount := '';
	self.version3.PRSearchIDVFraudCount01 := '';
	self.version3.PRSearchIDVFraudCount03 := '';
	self.version3.PRSearchIDVFraudCount06 := '';
	self.version3.PRSearchIDVFraudCount12 := '';
	self.version3.PRSearchIDVFraudCount24 := '';
	self.version3.PRSearchIDVFraudCount36 := '';
	self.version3.PRSearchIDVFraudCount60 := '';
	self.version3.PRSearchOtherCount := '';
	self.version3.PRSearchOtherCount01 := '';
	self.version3.PRSearchOtherCount03 := '';
	self.version3.PRSearchOtherCount06 := '';
	self.version3.PRSearchOtherCount12 := '';
	self.version3.PRSearchOtherCount24 := '';
	self.version3.PRSearchOtherCount36 := '';
	self.version3.PRSearchOtherCount60 := '';



	CAaddrChooser := map(le.clam.address_verification.input_address_information.isbestmatch => 1, // input is current
						 le.clam.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
						 le.clam.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
						 0);	// don't know what the current address is
	PAaddrChooser_temp := map(CAaddrChooser=1 => 2, // if input is current, then pick history 1 as previous
														CAaddrChooser=2 and le.clam.address_verification.input_address_information.date_last_seen > le.clam.address_verification.address_history_2.date_last_seen => 1,	// if hist 1 is current and input date last seen > hist 2 date last seen then input is previous
														CAaddrChooser=2 and le.clam.address_verification.input_address_information.date_last_seen = le.clam.address_verification.address_history_2.date_last_seen and
															le.clam.address_verification.input_address_information.date_first_seen >= le.clam.address_verification.address_history_2.date_first_seen => 1,	// if hist 1 is current and input date last seen = hist 2 date last seen and input date first seen >= hist 2 date first seen then input is previous
														CAaddrChooser=3 and le.clam.address_verification.input_address_information.date_last_seen > le.clam.address_verification.address_history_1.date_last_seen => 1, // if hist 2 is current and input date last seen > hist 1 date last seen then input is previous
														CAaddrChooser=3 and le.clam.address_verification.input_address_information.date_last_seen = le.clam.address_verification.address_history_1.date_last_seen and
															le.clam.address_verification.input_address_information.date_first_seen >= le.clam.address_verification.address_history_1.date_first_seen => 1,	// if hist 2 is current and input date last seen = hist 1 date last seen and input date first seen >= hist 1 date first seen then input is previous
														CAaddrChooser=2 => 3,	// if none of the above and hist 1 is current, then hist 2 is previous
														CAaddrChooser=0 => 0,	// no Current address chosen
														2);	// if none of the above and hist 2 is current, then hist 1 is previous

	// override the previous address chooser to 0 if the address selected as previous doesn't actually exist
	PAaddrChooser := if( (PAaddrChooser_temp=1 and le.clam.address_verification.input_address_information.prim_name='') or
											 (PAaddrChooser_temp=2 and le.clam.address_verification.address_history_1.prim_name='') or
											 (PAaddrChooser_temp=3 and le.clam.address_verification.address_history_2.prim_name=''), 
											 0,
											 PAaddrChooser_temp);


	fulldate := (unsigned4)risk_indicators.iid_constants.full_history_date(le.clam.historydate);
	/* Version1 values deprecated by Version3 */
		renameField( NoVerifyNameAddrPhoneSSN, VerificationFailure );
		renameField( InputAddrCurrAddrMatch, InputCurrAddrMatch, noAddr or CAAddrChooser=0 );
		renameField( InputAddrCurrAddrStateDiff, InputCurrAddrStateDiff, noAddr or CAAddrChooser=0, TRUE );
		renameField( InputAddrPrevAddrMatch, InputPrevAddrMatch, noAddr or PAAddrChooser=0 );
		renameField( CurrAddrPrevAddrStateDiff, CurrPrevAddrStateDiff, 0 in [CAAddrChooser,PAAddrChooser], TRUE );
		YYYYMM_to_months( DateFirstPurchase, PropAgeOldestPurchase, cap:=960 );
		YYYYMM_to_months( DateMostRecentPurchase, PropAgeNewestPurchase, cap:=960 );
		YYYYMM_to_months( DateMostRecentSale, PropAgeNewestSale, cap:=960 );
		YYYYMM_to_months( DateLastDerog, DerogAge, cap:=960 );
		YYYYMM_to_months( DateLastConviction, FelonyAge, cap:=960 );
		YYYYMM_to_months( DateLastArrest, ArrestAge, cap:=960 );
		YYYYMM_to_months( MostRecentUnrelDate, LienFiledAge, cap:=960 );
		YYYYMM_to_months( MostRecentReleasedDate, LienReleasedAge, cap:=960 );
		YYYYMM_to_months( MostRecentBankruptDate, BankruptcyAge, cap:=960 );
		renameField( MostRecentBankruptType, BankruptcyType );
		Null_v3( MostRecentBankruptStatus );
		YYYYMM_to_months( MostRecentEvictionDate, EvictionAge, cap:=960 );
		YYYYMM_to_months( MostRecentProfLicDate, ProfLicAge, cap:=960 );
		renameField( PhoneType, InputPhoneType, noPhone );
		renameField( AreaCodeChange, InputAreaCodeChange, noPhone );
		renameField( AddrVal, InputAddrValidation, noAddr );
	/* Version1 values deprecated by Version3 */

	/* STRING1 fields with the same logic and same name but now changed to STRING2 (within v3 section) to allow for '-1' null values instead of '' */
		renameField( InputAddrApplicantOwned, InputAddrApplicantOwned, noAddr );
		renameField( InputAddrFamilyOwned, InputAddrFamilyOwned, noAddr );
		renameField( InputAddrOccupantOwned, InputAddrOccupantOwned, noAddr );
		renameField( InputAddrNotPrimaryRes, InputAddrNotPrimaryRes, noAddr );
		renameField( InputAddrActivePhoneList, InputAddrActivePhoneList, noAddr );
		renameField( CurrAddrDwellType, CurrAddrDwellType, CAAddrChooser=0 );
		renameField( CurrAddrLandUseCode, CurrAddrLandUseCode, CAAddrChooser=0 );
		renameField( CurrAddrActivePhoneList, CurrAddrActivePhoneList, CAAddrChooser=0 );
		renameField( StatusMostRecent, StatusMostRecent, CAAddrChooser=0 );
		renameField( StatusPrevious, StatusPrevious, PAAddrChooser=0 );
		renameField( StatusNextPrevious, StatusNextPrevious, 0 in [CAAddrChooser,PAAddrChooser] );
		renameField( InputPhoneStatus, InputPhoneStatus, noPhone );
		renameField( InputPhonePager, InputPhonePager, noPhone );
		renameField( InputPhoneMobile, InputPhoneMobile, noPhone );
		renameField( InputAddrHighRisk, InputAddrHighRisk, noAddr );
		renameField( InputPhoneHighRisk, InputPhoneHighRisk, noPhone );
		renameField( InputAddrPrison, InputAddrPrison, noAddr );
		Null_v3( InputPhoneAddrDist, noAddr or noPhone, TRUE );
		renameField( InvalidPhoneZip, InvalidPhoneZip, noZip or noPhone );
		renameField( InputZipPOBox, InputZipPOBox, noZip );
		renameField( InputZipCorpMil, InputZipCorpMil, noZip );

	/* */


	/* Fields within v1 that will simply be updated from blank to -1 (their size is >=2, so we don't need to create a new field to fit '-1') */
		Null_v3(SSNIssueState);
		Null_v3(AgeRiskIndicator);

		IAAutomatedValuation    := ut.imin2(le.clam.avm.input_address_information.avm_automated_valuation, cap10Byte);
		IACountyMedianValuation := ut.imin2(le.clam.avm.input_address_information.avm_median_fips_level, cap10byte);
		IATractMedianValuation  := ut.imin2(le.clam.avm.input_address_information.avm_median_geo11_level, cap10byte);
		IABlockMedianValuation  := ut.imin2(le.clam.avm.input_address_information.avm_median_geo12_level, cap10byte);
		self.InputAddrCountyIndex := map( noAddr => '-1', IACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IACountyMedianValuation)), decimal_length));
		self.InputAddrTractIndex  := map( noAddr => '-1', IATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IATractMedianValuation)), decimal_length));
		self.InputAddrBlockIndex  := map( noAddr => '-1', IABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IABlockMedianValuation)), decimal_length));
		Null_v3(InputAddrCurrAddrDistance, noAddr or CAAddrChooser=0, TRUE);
		Null_v3(InputAddrCurrAddrAssessedDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrIncomeDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrHomeValDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrCrimeDiff, noAddr or CAAddrChooser=0);
		self.InputAddrCurrAddrIncomeDiff  := if( noAddr or CAAddrChooser=0, '-1', (string)(integer)le.InputAddrCurrAddrIncomeDiff );
		self.InputAddrCurrAddrHomeValDiff := if( noAddr or CAAddrChooser=0, '-1', (string)(integer)le.InputAddrCurrAddrHomeValDiff);
		self.InputAddrCurrAddrCrimeDiff   := if( noAddr or CAAddrChooser=0, '-1', (string)(integer)le.InputAddrCurrAddrCrimeDiff  );
		Null_v3(EconomicTrajectory, noAddr or 0=CAAddrChooser);
		Null_v3(EconomicTrajectory2, 0 in [CAAddrChooser,PAAddrChooser]);
		Null_v3(InputAddrConfScore, noAddr);
		Null_v3(InputAddrTaxAssessVal, noAddr);
		Null_v3(InputAddrAssessedValue, noAddr);
		Null_v3(InputAddrTaxAssessedYr, noAddr);

		self.CurrAddrPrevAddrIncomeDiff  := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', (string)(integer)le.CurrAddrPrevAddrIncomeDiff );
		self.CurrAddrPrevAddrHomeValDiff := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', (string)(integer)le.CurrAddrPrevAddrHomeValDiff);
		self.CurrAddrPrevAddrCrimeDiff   := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', (string)(integer)le.CurrAddrPrevAddrCrimeDiff  );
		// Null_v3(CurrAddrPrevAddrIncomeDiff, 0 in [CAAddrChooser,PAAddrChooser] );
		// Null_v3(CurrAddrPrevAddrHomeValDiff, 0 in [CAAddrChooser,PAAddrChooser] );
		// Null_v3(CurrAddrPrevAddrCrimeDiff, 0 in [CAAddrChooser,PAAddrChooser] );
		Null_v3(CurrAddrPrevAddrDistance, 0 in [CAAddrChooser,PAAddrChooser], TRUE);
		Null_v3(CurrAddrPrevAddrAssessedDiff, 0 in [CAAddrChooser,PAAddrChooser] );
		Null_v3(ServiceType, noPhone );
		Null_v3(addrvalErrorCode, noAddr );
		
	/* */


	/* Values that did not allow nulls but now do */
		renameField( InvalidSSN, InvalidSSN, noSSN );
		renameField( InvalidAddr, InvalidAddr, noAddr );
		renameField( InvalidPhone, InvalidPhone, noPhone );
		renameField( SSNnotfound, SSNnotfound, noSSN );


		// cap at 960
		self.CurrAddrLenOfRes  := if(CAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.CurrAddrLenOfRes, 960));
		self.PrevAddrLenOfRes  := if(PAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.PrevAddrLenOfRes, 960));
		self.TimeSinceSubjectPhoneFirstSeen := if(le.TimeSinceSubjectPhoneFirstSeen='0', '-1', (string)ut.imin2((unsigned2)le.TimeSinceSubjectPhoneFirstSeen, 960));
		self.TimeSinceSubjectPhoneLastSeen  := if(le.TimeSinceSubjectPhoneLastSeen='0', '-1',  (string)ut.imin2((unsigned2)le.TimeSinceSubjectPhoneLastSeen, 960));

	/* */
	
	/* Other null values: */
		self.SubjectFirstSeen := '';
		hfs := le.clam.ssn_verification.header_first_seen;
		cfs := le.clam.ssn_verification.credit_first_seen;
		fsDate := map(
			hfs = 0 and cfs = 0 => -1,
			hfs = 0             => cfs,
			            cfs = 0 => hfs,
			ut.min2(hfs,cfs)
		);
		self.Version3.AgeOldestRecord := if( fsdate=-1, '-1', (string)ut.imin2( 960, months_apart( sysdate, fsdate ) ));
		
		
		hls := le.clam.ssn_verification.header_last_seen;
		cls := le.clam.ssn_verification.credit_last_seen;
		lsDate := map(
			hls = 0 and cls = 0 => -1,
			hls = 0             => cls,
			            cls = 0 => hls,
			ut.max2(hls,cls)
		);

		self.DateLastUpdate := '';
		self.Version3.AgeNewestRecord := if( lsdate=-1, '-1', (string)ut.imin2( 960, months_apart( sysdate, lsdate)));
		
		renameField( SSNFoundOther, SSNFoundOther, ssnNull );
		renameField( PhoneFullNameMatch, VerifiedPhoneFullName, phoneNull );
		renameField( PhoneLastNameMatch, VerifiedPhoneLastName, phoneNull );
		renameField( PhoneOther, PhoneOther, phoneNull );
		renameField( SSNDeceased, SSNDeceased, ssnNull );
		Null_V3( DateSSNDeceased, le.DateSSNDeceased='0' );
		renameField( SSNIssued, SSNIssued, noSSN );
		renameField( RecentSSN, SSNRecent, noSSN );
		Null_V3( LowIssueDate, le.LowIssueDate='0' );
		Null_V3( HighIssueDate, le.HighIssueDate='0' );
		renameField( NonUSSSN, SSNNonUS, noSSN );
		renameField( SSNIssuedPrior, SSNIssuedPriorDOB, noSSN or noDOB );
		renameField( SSN3Years, SSN3Years, noSSN );
		renameField( SSNAfter5, SSNAfter5, noSSN );
		Null_V3( SSNProbs, noSSN );

		checkDate6(unsigned3 foundDate) := FUNCTION
			outDate := if(foundDate > le.clam.historyDate, getPreviousMonth(le.clam.historyDate), foundDate);
			return (string)outDate;
		END;
		system_yearmonth := if(le.clam.historydate = risk_indicators.iid_constants.default_history_date, (integer)(ut.GetDate[1..6]), le.clam.historydate);
		IADateFirstReported := (unsigned)checkDate6(le.clam.address_verification.input_address_information.date_first_seen);
		IADateLastReported := (unsigned)checkDate6(le.clam.address_verification.input_address_information.date_last_seen);
		self.TimeSinceInputAddrFirstSeen := if( noAddr or le.clam.address_verification.input_address_information.date_first_seen=0, '-1', (string)ut.imin2( months_apart(system_yearmonth, IADateFirstReported), 960));
		self.TimeSinceInputAddrLastSeen  := if( noAddr or le.clam.address_verification.input_address_information.date_last_seen =0, '-1', (string)ut.imin2( months_apart(system_yearmonth, IADateLastReported),  960));
		self.InputAddrLenOfRes := if( le.InputAddrLenOfRes='0', '-1', (string)ut.imin2( (integer)le.InputAddrLenOfRes, 960 ) );
		renameField( InputAddrDwellType, InputAddrDwellType, le.InputAddrDwellType='0' or noAddr );
		renameField( InputAddrLandUseCode, InputAddrLandUseCode, noAddr );
		self.InputAddrLastSalesDate	:= '';
		self.version3.InputAddrAgeLastSale := if( noAddr or le.InputAddrLastSalesDate='0', '-1', calcMonths( sysdate, le.InputAddrLastSalesDate, 960 ));
		Null_V3( InputAddrLastSalesAmount, noAddr or le.clam.address_verification.input_address_information.purchase_date>fullDate );
		Null_V3( InputAddrActivePhoneNumber, noAddr or le.clam.Address_Verification.activePhone=0 );

		Null_V3( InputAddrAssessMarket, noAddr );
		Null_V3( InputAddrPriceIndVal, noAddr );
		Null_V3( InputAddrHedVal, noAddr );
		Null_V3( InputAddrAutoVal, noAddr );
		Null_V3( InputAddrMedianIncome, noAddr or le.clam.ineasi.geolink='' );
		Null_V3( InputAddrMedianHomeVal, noAddr or le.clam.ineasi.geolink='' );
		Null_V3( InputAddrMurderIndex, noAddr or le.clam.ineasi.geolink='' );
		Null_V3( InputAddrCarTheftIndex, noAddr or le.clam.ineasi.geolink='' );
		Null_V3( InputAddrBurglaryIndex, noAddr or le.clam.ineasi.geolink='' );
		Null_V3( InputAddrCrimeIndex, noAddr or le.clam.ineasi.geolink='' );





		// curr addr attribs
			CADateFirstReported := (unsigned)checkDate6(
				map(CAaddrChooser=1 => le.clam.address_verification.input_address_information.date_first_seen,
					CAaddrChooser=2 => le.clam.address_verification.address_history_1.date_first_seen,
					le.clam.address_verification.address_history_2.date_first_seen) );
			CADateLastReported := (unsigned)checkDate6(
				map(CAaddrChooser=1 => le.clam.address_verification.input_address_information.date_last_seen,
					CAaddrChooser=2 => le.clam.address_verification.address_history_1.date_last_seen,
					le.clam.address_verification.address_history_2.date_last_seen) );
			self.TimeSinceCurrAddrFirstSeen := if( CADateFirstReported=0 or CAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.TimeSinceCurrAddrFirstSeen, 960));
			self.TimeSinceCurrAddrLastSeen  := if( CADateLastReported=0  or CAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.TimeSinceCurrAddrLastSeen, 960));

			self.CurrAddrLastSalesDate	:= '';
			self.version3.CurrAddrAgeLastSale := if( le.CurrAddrLastSalesDate='0', '-1', calcMonths( sysdate, le.CurrAddrLastSalesDate, 960 ));
			Null_V3( CurrAddrLastSalesAmount, CAAddrChooser=0 );
			renameField( CurrAddrApplicantOwned, CurrAddrApplicantOwned, CAAddrChooser=0 );
			renameField( CurrAddrFamilyOwned, CurrAddrFamilyOwned, CAAddrChooser=0 );
			renameField( CurrAddrOccupantOwned, CurrAddrOccupantOwned, CAAddrChooser=0 );

			CAPhoneNumber := map(CAaddrChooser=1 => le.clam.address_verification.activePhone,
								 CAaddrChooser=2 => le.clam.address_verification.activePhone2,
								 CAaddrChooser=3 => le.clam.address_verification.activePhone3,
								 0);


			BlankEASI := dataset( [], used_census )[1];
			CAEasi := case( CAAddrChooser, 1 => le.clam.ineasi, 2 => le.clam.easi1, 3 => le.clam.easi2, BlankEASI );
			PAEasi := case( PAAddrChooser, 1 => le.clam.ineasi, 2 => le.clam.easi1, 3 => le.clam.easi2, BlankEASI );
			
			Null_V3(CurrAddrActivePhoneNumber, CAPhoneNumber=0 );
			Null_v3(CurrAddrAssessMarket, CAAddrChooser=0);
			Null_v3(CurrAddrTaxAssessVal, CAAddrChooser=0);
			Null_v3(CurrAddrPriceIndVal, CAAddrChooser=0);
			Null_v3(CurrAddrHedVal, CAAddrChooser=0);
			Null_v3(CurrAddrAutoVal, CAAddrChooser=0);
			Null_V3(CurrAddrAssessedValue, CAAddrChooser=0);
			Null_V3(CurrAddrTaxAssessedYr, CAAddrChooser=0);
			Null_V3(CurrAddrConfScore, CAAddrChooser=0);
			// Null_V3(CurrAddrCountyIndex, CAAddrChooser=0);
			// Null_V3(CurrAddrTractIndex, CAAddrChooser=0);
			// Null_V3(CurrAddrBlockIndex, CAAddrChooser=0);
			CAAutomatedValuation := map(CAaddrChooser=0 => 0,
													CAaddrChooser=1 => le.clam.avm.input_address_information.avm_Automated_valuation,
													CAaddrChooser=2 => le.clam.avm.address_history_1.avm_Automated_valuation,
													le.clam.avm.address_history_2.avm_Automated_valuation);	
			CACountyMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_fips_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_fips_level,
																le.clam.avm.address_history_2.avm_median_fips_level)
																						, cap10byte);
			CATractMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo11_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo11_level,
																le.clam.avm.address_history_2.avm_median_geo11_level)
																						, cap10byte);
			CABlockMedianValuation := ut.imin2(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo12_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo12_level,
																le.clam.avm.address_history_2.avm_median_geo12_level)
																						, cap10byte);
			self.CurrAddrCountyIndex := map( CAAddrChooser=0 => '-1', CACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CACountyMedianValuation)), decimal_length));
			self.CurrAddrTractIndex  := map( CAAddrChooser=0 => '-1', CATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CATractMedianValuation)), decimal_length));
			self.CurrAddrBlockIndex  := map( CAAddrChooser=0 => '-1', CABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CABlockMedianValuation)), decimal_length));

			Null_v3(CurrAddrMedianIncome, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrMedianHomeVal, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrMurderIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrCarTheftIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrBurglaryIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrCrimeIndex, CAAddrChooser=0 or CAEasi.geolink='');
		//

		// prev addr attribs
			PADateFirstReported := (unsigned)checkDate6(map(PAaddrChooser=1 => le.clam.address_verification.input_address_information.date_first_seen,
				PAaddrChooser=2 =>	le.clam.address_verification.address_history_1.date_first_seen,
				PAaddrChooser=3 => le.clam.address_verification.address_history_2.date_first_seen,
				0) );
			PADateLastReported := (unsigned)checkDate6(map(PAaddrChooser=1 => le.clam.address_verification.input_address_information.date_last_seen,
				PAaddrChooser=2 => le.clam.address_verification.address_history_1.date_last_seen,
				PAaddrChooser=3 => le.clam.address_verification.address_history_2.date_last_seen,
				0));

			self.TimeSincePrevAddrFirstSeen := if( PADateFirstReported=0 or PAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.TimeSincePrevAddrFirstSeen, 960));
			self.TimeSincePrevAddrLastSeen  := if( PADateLastReported=0  or PAAddrChooser=0, '-1', (string)ut.imin2((unsigned2)le.TimeSincePrevAddrLastSeen, 960));

			self.PrevAddrLastSalesDate	:= '';
			self.version3.PrevAddrAgeLastSale := if( le.PrevAddrLastSalesDate='0', '-1', calcMonths( sysdate, le.PrevAddrLastSalesDate, 960 ));
			Null_V3( PrevAddrLastSalesAmount, PAAddrChooser=0 );
			renameField( PrevAddrApplicantOwned, PrevAddrApplicantOwned, PAAddrChooser=0 );
			renameField( PrevAddrFamilyOwned, PrevAddrFamilyOwned, PAAddrChooser=0 );
			renameField( PrevAddrOccupantOwned, PrevAddrOccupantOwned, PAAddrChooser=0 );

			PAPhoneNumber := map(PAaddrChooser=1 => le.clam.address_verification.activePhone,
								 PAaddrChooser=2 => le.clam.address_verification.activePhone2,
								 PAaddrChooser=3 => le.clam.address_verification.activePhone3,
								 0);

			Null_V3(PrevAddrActivePhoneNumber, PAphonenumber=0 );
			Null_v3(PrevAddrAssessMarket, PAaddrchooser=0);
			Null_v3(PrevAddrTaxAssessVal, PAaddrchooser=0);
			Null_v3(PrevAddrPriceIndVal, PAaddrchooser=0);
			Null_v3(PrevAddrHedVal, PAaddrchooser=0);
			Null_v3(PrevAddrAutoVal, PAaddrchooser=0);
			Null_V3(PrevAddrAssessedValue, PAaddrchooser=0);
			Null_V3(PrevAddrTaxAssessedYr, PAaddrchooser=0);
			Null_V3(PrevAddrConfScore, PAAddrChooser=0);
			// Null_V3(PrevAddrCountyIndex, PAAddrChooser=0);
			// Null_V3(PrevAddrTractIndex, PAAddrChooser=0);
			// Null_V3(PrevAddrBlockIndex, PAAddrChooser=0);
			PAAutomatedValuation := map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_Automated_valuation,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_Automated_valuation,
																le.clam.avm.address_history_2.avm_Automated_valuation);
			
			PACountyMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_fips_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_fips_level,
																le.clam.avm.address_history_2.avm_median_fips_level)
																						, cap10byte);
			PATractMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo11_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo11_level,
																le.clam.avm.address_history_2.avm_median_geo11_level)
																						, cap10byte);
			PABlockMedianValuation := ut.imin2(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo12_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo12_level,
																le.clam.avm.address_history_2.avm_median_geo12_level)
																						, cap10byte);
			self.PrevAddrCountyIndex := map( PAAddrChooser=0 => '-1', PACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PACountyMedianValuation)), decimal_length));
			self.PrevAddrTractIndex  := map( PAAddrChooser=0 => '-1', PATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PATractMedianValuation)), decimal_length));
			self.PrevAddrBlockIndex  := map( PAAddrChooser=0 => '-1', PABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PABlockMedianValuation)), decimal_length));


			Null_v3(PrevAddrMedianIncome, PAAddrChooser=0 or PAEasi.geolink='');
			Null_v3(PrevAddrMedianHomeVal, PAAddrChooser=0 or PAEasi.geolink='');
			Null_v3(PrevAddrMurderIndex, PAAddrChooser=0 or PAEasi.geolink='');
			Null_v3(PrevAddrCarTheftIndex, PAAddrChooser=0 or PAEasi.geolink='');
			Null_v3(PrevAddrBurglaryIndex, PAAddrChooser=0 or PAEasi.geolink='');
			Null_v3(PrevAddrCrimeIndex, PAAddrChooser=0 or PAEasi.geolink='');
			renameField(PrevAddrActivePhoneList, PrevAddrActivePhoneList, PAAddrChooser=0);
			renameField(PrevAddrDwellType, PrevAddrDwellType, PAAddrChooser=0);
			renameField(PrevAddrLandUseCode, PrevAddrLandUseCode, PAAddrChooser=0);
		//

		Null_v3( MostRecentProfLicExpireDate, le.MostRecentProfLicExpireDate='0' );
		Null_v3( SIC );





	// High Risk Address Attributes
	self.version3.CurrAddrPrison := if( CAAddrChooser=0, '-1', checkBoolean(le.clam.other_address_info.isprison));
	
	prevIsPrison :=
		   PAAddrChooser=1 and exists( risk_indicators.key_HRI_Address_To_SIC(keyed(le.clam.Address_Verification.Input_Address_Information.zip5=z5) and keyed(le.clam.Address_Verification.Input_Address_Information.prim_name=prim_name) and keyed(le.clam.Address_Verification.Input_Address_Information.addr_suffix=suffix) and keyed(le.clam.Address_Verification.Input_Address_Information.predir=predir) and keyed(le.clam.Address_Verification.Input_Address_Information.postdir=postdir) and keyed(le.clam.Address_Verification.Input_Address_Information.prim_range=prim_range) and keyed(le.clam.Address_Verification.Input_Address_Information.sec_range=sec_range) and sic_code=Risk_Indicators.iid_constants.SIC_Prison AND dt_first_seen < le.clam.historydate))
		or PAAddrChooser=2 and exists( risk_indicators.key_HRI_Address_To_SIC(keyed(le.clam.Address_Verification.Address_History_1.zip5=z5) and keyed(le.clam.Address_Verification.Address_History_1.prim_name=prim_name) and keyed(le.clam.Address_Verification.Address_History_1.addr_suffix=suffix) and keyed(le.clam.Address_Verification.Address_History_1.predir=predir) and keyed(le.clam.Address_Verification.Address_History_1.postdir=postdir) and keyed(le.clam.Address_Verification.Address_History_1.prim_range=prim_range) and keyed(le.clam.Address_Verification.Address_History_1.sec_range=sec_range) and sic_code=Risk_Indicators.iid_constants.SIC_Prison AND dt_first_seen < le.clam.historydate))
		or PAAddrChooser=3 and exists( risk_indicators.key_HRI_Address_To_SIC(keyed(le.clam.Address_Verification.Address_History_2.zip5=z5) and keyed(le.clam.Address_Verification.Address_History_2.prim_name=prim_name) and keyed(le.clam.Address_Verification.Address_History_2.addr_suffix=suffix) and keyed(le.clam.Address_Verification.Address_History_2.predir=predir) and keyed(le.clam.Address_Verification.Address_History_2.postdir=postdir) and keyed(le.clam.Address_Verification.Address_History_2.prim_range=prim_range) and keyed(le.clam.Address_Verification.Address_History_2.sec_range=sec_range) and sic_code=Risk_Indicators.iid_constants.SIC_Prison AND dt_first_seen < le.clam.historydate))
	;

	self.version3.PrevAddrPrison := map( PAAddrChooser=0 => '-1', prevIsPrison => '1', '0' );
	self.version3.HistoricalAddrPrison := if( prevIsPrison or CAAddrChooser!=0 and le.clam.other_address_info.isprison or le.InputAddrPrison='1', '1', '0');

	
	// 0-255 fields in v3 that were 0-99 in v1
	numsources := map(
		CAaddrChooser=0 => 0,
		CAaddrChooser=1 => le.clam.address_verification.input_address_information.source_count,
		CAaddrChooser=2 => le.clam.address_verification.address_history_1.source_count,
		le.clam.address_verification.address_history_2.source_count
	);

	update255( v1, v3, val ) := MACRO
		self.v1 := '';
		self.version3.v3 := (string)ut.imin2( val, 255 );
	ENDMACRO;
	//         (version 1 field)     (version 3 field)               (source)
	update255( NumSrcsConfirmIdAddr,      SrcsConfirmIDAddrcount,         numsources );
	update255( SSNPerID,                  SubjectSSNCount,                le.clam.velocity_counters.ssns_per_adl );
	update255( AddrPerID,                 SubjectAddrCount,               le.clam.velocity_counters.addrs_per_adl );
	update255( PhonePerID,                SubjectPhoneCount,              le.clam.velocity_counters.phones_per_adl );
	update255( SSNPerID6,                 SubjectSSNRecentCount,          le.clam.velocity_counters.ssns_per_adl_created_6months );
	update255( AddrPerID6,                SubjectAddrRecentCount,         le.clam.velocity_counters.addrs_per_adl_created_6months );
	update255( PhonePerID6,               SubjectPhoneRecentCount,        le.clam.velocity_counters.phones_per_adl_created_6months );
	update255( IDPerSSN,                  SSNIdentitiesCount,             le.clam.SSN_Verification.adlPerSSN_count );
	update255( AddrPerSSN,                SSNAddrCount,                   le.clam.velocity_counters.addrs_per_ssn );
	update255( IDPerSSN6,                 SSNIdentitiesRecentCount,       le.clam.velocity_counters.adls_per_ssn_created_6months );
	update255( AddrPerSSN6,               SSNAddrRecentCount,             le.clam.velocity_counters.addrs_per_ssn_created_6months );
	update255( IDPerAddr,                 InputAddrIdentitiesCount,       le.clam.velocity_counters.adls_per_addr );
	update255( SSNPerAddr,                InputAddrSSNCount,              le.clam.velocity_counters.ssns_per_addr );
	update255( PhonePerAddr,              InputAddrPhoneCount,            le.clam.velocity_counters.phones_per_addr );
	update255( IDPerAddr6,                InputAddrIdentitiesRecentCount, le.clam.velocity_counters.adls_per_addr_created_6months );
	update255( SSNPerAddr6,               InputAddrSSNRecentCount,        le.clam.velocity_counters.ssns_per_addr_created_6months );
	update255( PhonePerAddr6,             InputAddrPhoneRecentCount,      le.clam.velocity_counters.phones_per_addr_created_6months );
	update255( IDPerPhone,                PhoneIdentitiesCount,           le.clam.velocity_counters.adls_per_phone );
	update255( IDPerPhone6,               PhoneIdentitiesRecentCount,     le.clam.velocity_counters.adls_per_phone_created_6months );

	update255( LastNamePerSSN,            SSNLastNameCount,               le.clam.SSN_Verification.namePerSSN_count );
	update255( LastNamePerID,             SubjectLastNameCount,           le.clam.velocity_counters.lnames_per_adl );

	self.TimeSinceLastName := if(le.clam.name_verification.newest_lname_dt_first_seen>le.clam.historyDate, '-1', (string)ut.imin2( (integer2)le.TimeSinceLastName, 960 )); // aka v3.LastNameChangeAge
	update255( LastNames30,               LastNameChangeCount01,          le.clam.velocity_counters.lnames_per_adl30 );
	update255( LastNames90,               LastNameChangeCount03,          le.clam.velocity_counters.lnames_per_adl90 );
	update255( LastNames180,              LastNameChangeCount06,          le.clam.velocity_counters.lnames_per_adl180 );
	update255( LastNames12,               LastNameChangeCount12,          le.clam.velocity_counters.lnames_per_adl12 );
	update255( LastNames24,               LastNameChangeCount24,          le.clam.velocity_counters.lnames_per_adl24 );
	update255( LastNames36,               LastNameChangeCount36,          le.clam.velocity_counters.lnames_per_adl36 );
	update255( LastNames60,               LastNameChangeCount60,          le.clam.velocity_counters.lnames_per_adl60 );

	update255( IDPerSFDUAddr,             SFDUAddrIdentitiesCount,        if(le.clam.address_validation.error_codes[1]='S', le.clam.velocity_counters.adls_per_addr, -1 ) );
	update255( SSNPerSFDUAddr,            SFDUAddrSSNCount,               if(le.clam.address_validation.error_codes[1]='S', le.clam.velocity_counters.ssns_per_addr, -1 ) );	

	update255( addrChanges30,             AddrChangeCount01,              le.clam.other_address_info.addrs_last30 );
	update255( addrChanges90,             AddrChangeCount03,              le.clam.other_address_info.addrs_last90 );
	update255( addrChanges180,            AddrChangeCount06,              le.clam.velocity_counters.addrs_per_adl_created_6months );
	update255( addrChanges12,             AddrChangeCount12,              le.clam.other_address_info.addrs_last12 );
	update255( addrChanges24,             AddrChangeCount24,              le.clam.other_address_info.addrs_last24 );
	update255( addrChanges36,             AddrChangeCount36,              le.clam.other_address_info.addrs_last36 );
	update255( addrChanges60,             AddrChangeCount60,              le.clam.other_address_info.addrs_last_5years );

	update255( PropertyOwnedTotal,        PropOwnedCount,                 le.clam.address_verification.owned.property_total );
	update255( PropertyHistoricallyOwned, PropOwnedHistoricalCount,       le.clam.address_verification.owned.property_total + le.clam.address_verification.sold.property_total + le.clam.address_verification.ambiguous.property_total );

	update255( PropPurchased30,           PropPurchasedCount01,           le.clam.other_address_info.num_purchase30 );
	update255( PropPurchased90,           PropPurchasedCount03,           le.clam.other_address_info.num_purchase90 );
	update255( PropPurchased180,          PropPurchasedCount06,           le.clam.other_address_info.num_purchase180 );
	update255( PropPurchased12,           PropPurchasedCount12,           le.clam.other_address_info.num_purchase12 );
	update255( PropPurchased24,           PropPurchasedCount24,           le.clam.other_address_info.num_purchase24 );
	update255( PropPurchased36,           PropPurchasedCount36,           le.clam.other_address_info.num_purchase36 );
	update255( PropPurchased60,           PropPurchasedCount60,           le.clam.other_address_info.num_purchase60 );
	update255( PropSold30,                PropSoldCount01,                le.clam.other_address_info.num_sold30 );
	update255( PropSold90,                PropSoldCount03,                le.clam.other_address_info.num_sold90 );
	update255( PropSold180,               PropSoldCount06,                le.clam.other_address_info.num_sold180 );
	update255( PropSold12,                PropSoldCount12,                le.clam.other_address_info.num_sold12 );
	update255( PropSold24,                PropSoldCount24,                le.clam.other_address_info.num_sold24 );
	update255( PropSold36,                PropSoldCount36,                le.clam.other_address_info.num_sold36 );
	update255( PropSold60,                PropSoldCount60,                le.clam.other_address_info.num_sold60 );

	update255( numWatercraft,             WatercraftCount,                le.clam.watercraft.watercraft_count );
	update255( numWatercraft30,           WatercraftCount01,              le.clam.watercraft.watercraft_count30 );
	update255( numWatercraft90,           WatercraftCount03,              le.clam.watercraft.watercraft_count90 );
	update255( numWatercraft180,          WatercraftCount06,              le.clam.watercraft.watercraft_count180 );
	update255( numWatercraft12,           WatercraftCount12,              le.clam.watercraft.watercraft_count12 );
	update255( numWatercraft24,           WatercraftCount24,              le.clam.watercraft.watercraft_count24 );
	update255( numWatercraft36,           WatercraftCount36,              le.clam.watercraft.watercraft_count36 );
	update255( numWatercraft60,           WatercraftCount60,              le.clam.watercraft.watercraft_count60 );

	update255( numAircraft,               AircraftCount,                  le.clam.aircraft.aircraft_count );
	update255( numAircraft30,             AircraftCount01,                le.clam.aircraft.aircraft_count30 );
	update255( numAircraft90,             AircraftCount03,                le.clam.aircraft.aircraft_count90 );
	update255( numAircraft180,            AircraftCount06,                le.clam.aircraft.aircraft_count180 );
	update255( numAircraft12,             AircraftCount12,                le.clam.aircraft.aircraft_count12 );
	update255( numAircraft24,             AircraftCount24,                le.clam.aircraft.aircraft_count24 );
	update255( numAircraft36,             AircraftCount36,                le.clam.aircraft.aircraft_count36 );
	update255( numAircraft60,             AircraftCount60,                le.clam.aircraft.aircraft_count60 );
	update255( TotalNumberDerogs,         DerogCount,                     le.clam.bjl.criminal_count + le.clam.bjl.filing_count + le.clam.bjl.liens_historical_unreleased_count + le.clam.bjl.liens_recent_unreleased_count );

	update255( NumArrests,                ArrestCount,                    le.clam.bjl.arrests_count );
	update255( NumArrests30,              ArrestCount01,                  le.clam.bjl.arrests_count30 );
	update255( NumArrests90,              ArrestCount03,                  le.clam.bjl.arrests_count90 );
	update255( NumArrests180,             ArrestCount06,                  le.clam.bjl.arrests_count180 );
	update255( NumArrests12,              ArrestCount12,                  le.clam.bjl.arrests_count12 );
	update255( NumArrests24,              ArrestCount24,                  le.clam.bjl.arrests_count24 );
	update255( NumArrests36,              ArrestCount36,                  le.clam.bjl.arrests_count36 );
	update255( NumArrests60,              ArrestCount60,                  le.clam.bjl.arrests_count60 );

	update255( NumFelonies,               FelonyCount,                    le.clam.bjl.felony_count );
	update255( NumFelonies30,             FelonyCount01,                  le.clam.bjl.criminal_count30 );
	update255( NumFelonies90,             FelonyCount03,                  le.clam.bjl.criminal_count90 );
	update255( NumFelonies180,            FelonyCount06,                  le.clam.bjl.criminal_count180 );
	update255( NumFelonies12,             FelonyCount12,                  le.clam.bjl.criminal_count12 );
	update255( NumFelonies24,             FelonyCount24,                  le.clam.bjl.criminal_count24 );
	update255( NumFelonies36,             FelonyCount36,                  le.clam.bjl.criminal_count36 );
	update255( NumFelonies60,             FelonyCount60,                  le.clam.bjl.criminal_count60 );

	update255( LiensCount,                LienCount,                      le.clam.bjl.liens_historical_unreleased_count + le.clam.bjl.liens_recent_unreleased_count + le.clam.bjl.liens_historical_released_count + le.clam.bjl.liens_recent_released_count );

	update255( LiensUnreleasedCount,      LienFiledCount,                 le.clam.bjl.liens_historical_unreleased_count + le.clam.bjl.liens_recent_unreleased_count );
	update255( LiensUnreleasedCount30,    LienFiledCount01,               le.clam.bjl.liens_unreleased_count30 );
	update255( LiensUnreleasedCount90,    LienFiledCount03,               le.clam.bjl.liens_unreleased_count90 );
	update255( LiensUnreleasedCount180,   LienFiledCount06,               le.clam.bjl.liens_unreleased_count180 );
	update255( LiensUnreleasedCount12,    LienFiledCount12,               le.clam.bjl.liens_unreleased_count12 );
	update255( LiensUnreleasedCount24,    LienFiledCount24,               le.clam.bjl.liens_unreleased_count24 );
	update255( LiensUnreleasedCount36,    LienFiledCount36,               le.clam.bjl.liens_unreleased_count36 );
	update255( LiensUnreleasedCount60,    LienFiledCount60,               le.clam.bjl.liens_unreleased_count60 );

	update255( LiensReleasedCount,        LienReleasedCount,              le.clam.bjl.liens_historical_released_count + le.clam.bjl.liens_recent_released_count );
	update255( LiensReleasedCount30,      LienReleasedCount01,            le.clam.bjl.liens_released_count30 );
	update255( LiensReleasedCount90,      LienReleasedCount03,            le.clam.bjl.liens_released_count90 );
	update255( LiensReleasedCount180,     LienReleasedCount06,            le.clam.bjl.liens_released_count180 );
	update255( LiensReleasedCount12,      LienReleasedCount12,            le.clam.bjl.liens_released_count12 );
	update255( LiensReleasedCount24,      LienReleasedCount24,            le.clam.bjl.liens_released_count24 );
	update255( LiensReleasedCount36,      LienReleasedCount36,            le.clam.bjl.liens_released_count36 );
	update255( LiensReleasedCount60,      LienReleasedCount60,            le.clam.bjl.liens_released_count60 );

	update255( BankruptCount,             BankruptcyCount,                le.clam.bjl.filing_count );
	update255( BankruptCount30,           BankruptcyCount01,              le.clam.bjl.bk_count30 );
	update255( BankruptCount90,           BankruptcyCount03,              le.clam.bjl.bk_count90 );
	update255( BankruptCount180,          BankruptcyCount06,              le.clam.bjl.bk_count180 );
	update255( BankruptCount12,           BankruptcyCount12,              le.clam.bjl.bk_count12 );
	update255( BankruptCount24,           BankruptcyCount24,              le.clam.bjl.bk_count24 );
	update255( BankruptCount36,           BankruptcyCount36,              le.clam.bjl.bk_count36 );
	update255( BankruptCount60,           BankruptcyCount60,              le.clam.bjl.bk_count60 );

	update255( EvictionCount,             EvictionCount,                  le.clam.bjl.eviction_recent_unreleased_count + le.clam.bjl.eviction_historical_unreleased_count + le.clam.bjl.eviction_recent_released_count + le.clam.bjl.eviction_historical_released_count );
	update255( EvictionCount30,           EvictionCount01,                le.clam.bjl.eviction_count30 );
	update255( EvictionCount90,           EvictionCount03,                le.clam.bjl.eviction_count90 );
	update255( EvictionCount180,          EvictionCount06,                le.clam.bjl.eviction_count180 );
	update255( EvictionCount12,           EvictionCount12,                le.clam.bjl.eviction_count12 );
	update255( EvictionCount24,           EvictionCount24,                le.clam.bjl.eviction_count24 );
	update255( EvictionCount36,           EvictionCount36,                le.clam.bjl.eviction_count36 );
	update255( EvictionCount60,           EvictionCount60,                le.clam.bjl.eviction_count60 );

	update255( NonDerogSrcCount,          NonDerogCount,                  le.clam.source_verification.num_nonderogs );
	update255( NonDerogSrcCount30,        NonDerogCount01,                le.clam.source_verification.num_nonderogs30 );
	update255( NonDerogSrcCount90,        NonDerogCount03,                le.clam.source_verification.num_nonderogs90 );
	update255( NonDerogSrcCount180,       NonDerogCount06,                le.clam.source_verification.num_nonderogs180 );
	update255( NonDerogSrcCount12,        NonDerogCount12,                le.clam.source_verification.num_nonderogs12 );
	update255( NonDerogSrcCount24,        NonDerogCount24,                le.clam.source_verification.num_nonderogs24 );
	update255( NonDerogSrcCount36,        NonDerogCount36,                le.clam.source_verification.num_nonderogs36 );
	update255( NonDerogSrcCount60,        NonDerogCount60,                le.clam.source_verification.num_nonderogs60 );

	update255( ProfLicCount,              ProfLicCount,                   le.clam.professional_license.proflic_count );
	update255( ProfLicCount30,            ProfLicCount01,                 le.clam.professional_license.proflic_count30 );
	update255( ProfLicCount90,            ProfLicCount03,                 le.clam.professional_license.proflic_count90 );
	update255( ProfLicCount180,           ProfLicCount06,                 le.clam.professional_license.proflic_count180 );
	update255( ProfLicCount12,            ProfLicCount12,                 le.clam.professional_license.proflic_count12 );
	update255( ProfLicCount24,            ProfLicCount24,                 le.clam.professional_license.proflic_count24 );
	update255( ProfLicCount36,            ProfLicCount36,                 le.clam.professional_license.proflic_count36 );
	update255( ProfLicCount60,            ProfLicCount60,                 le.clam.professional_license.proflic_count60 );

	update255( ProfLicExpireCount30,      ProfLicExpireCount01,           le.clam.professional_license.expire_count30 );
	update255( ProfLicExpireCount90,      ProfLicExpireCount03,           le.clam.professional_license.expire_count90 );
	update255( ProfLicExpireCount180,     ProfLicExpireCount06,           le.clam.professional_license.expire_count180 );
	update255( ProfLicExpireCount12,      ProfLicExpireCount12,           le.clam.professional_license.expire_count12 );
	update255( ProfLicExpireCount24,      ProfLicExpireCount24,           le.clam.professional_license.expire_count24 );
	update255( ProfLicExpireCount36,      ProfLicExpireCount36,           le.clam.professional_license.expire_count36 );
	update255( ProfLicExpireCount60,      ProfLicExpireCount60,           le.clam.professional_license.expire_count60 );
	// </0-255 fields>
	
	// removed attributes
	self.CurrAddrNotPrimaryRes := '';
	self.PrevAddrNotPrimaryRes := '';
	self.TimeSincePrevAddrDateFirstSeen := '';
	self.TimeSinceNextPrevDateFirstSeen := '';

	self := le;
end;

p3 := project(p, map_fields_v3(left) );


working_layout addInquiries( working_layout le, Risk_Indicators.Key_Inquiry_Table_DID ri ) := TRANSFORM
	self.version3.PRSearchCollectionCount    := (string3)min(ri.Collection.CountTotal, 255 );
	self.version3.PRSearchCollectionCount01  := (string3)min(ri.Collection.Count01, 255 );
	self.version3.PRSearchCollectionCount03  := (string3)min(ri.Collection.Count03, 255 );
	self.version3.PRSearchCollectionCount06  := (string3)min(ri.Collection.Count06, 255 );
	self.version3.PRSearchCollectionCount12  := (string3)min(ri.Collection.Count12, 255 );
	self.version3.PRSearchCollectionCount24  := (string3)min(ri.Collection.Count24, 255 );
	self.version3.PRSearchCollectionCount36  := (string3)min(ri.Collection.Count36, 255 );
	self.version3.PRSearchCollectionCount60  := (string3)min(ri.Collection.Count60, 255 );
	self.version3.PRSearchIDVFraudCount      := (string3)min(ri.AccountOpen.CountTotal, 255 );
	self.version3.PRSearchIDVFraudCount01    := (string3)min(ri.AccountOpen.Count01, 255 );
	self.version3.PRSearchIDVFraudCount03    := (string3)min(ri.AccountOpen.Count03, 255 );
	self.version3.PRSearchIDVFraudCount06    := (string3)min(ri.AccountOpen.Count06, 255 );
	self.version3.PRSearchIDVFraudCount12    := (string3)min(ri.AccountOpen.Count12, 255 );
	self.version3.PRSearchIDVFraudCount24    := (string3)min(ri.AccountOpen.Count24, 255 );
	self.version3.PRSearchIDVFraudCount36    := (string3)min(ri.AccountOpen.Count36, 255 );
	self.version3.PRSearchIDVFraudCount60    := (string3)min(ri.AccountOpen.Count60, 255 );
	self.version3.PRSearchOtherCount         := (string3)min(ri.Other.CountTotal, 255 );
	self.version3.PRSearchOtherCount01       := (string3)min(ri.Other.Count01, 255 );
	self.version3.PRSearchOtherCount03       := (string3)min(ri.Other.Count03, 255 );
	self.version3.PRSearchOtherCount06       := (string3)min(ri.Other.Count06, 255 );
	self.version3.PRSearchOtherCount12       := (string3)min(ri.Other.Count12, 255 );
	self.version3.PRSearchOtherCount24       := (string3)min(ri.Other.Count24, 255 );
	self.version3.PRSearchOtherCount36       := (string3)min(ri.Other.Count36, 255 );
	self.version3.PRSearchOtherCount60       := (string3)min(ri.Other.Count60, 255 );

	self := le;
END;

p3_inq := join( p3, Risk_Indicators.Key_Inquiry_Table_DID, keyed(left.clam.did=right.did), addInquiries(left,right), left outer, keep(1));

working_return := if( version=1, p, p3_inq );


attr := project( working_return, models.layouts.layout_ITA_attributes_batch );

return group(sort(attr,seq),seq);
end;
