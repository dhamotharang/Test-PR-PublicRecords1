import risk_indicators, ut, easi, riskwise, MDR, STD, _Control;
onThor := _Control.Environment.OnThor;

export get_LeadIntegrity_Attributes(grouped dataset(risk_indicators.Layout_Boca_Shell) clam, integer1 version=1) := function

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

	used_census := EASI.Layout_Easi_Census;

	Layout_EasiSeq := record
		unsigned seq := 0;
		used_census easi;
	END;
  
  Layout_EasiSeq easi_census_transform(e_address le, Easi.Key_Easi_Census ri) := TRANSFORM
    self.seq := le.seq;
    self.easi.state := le.st;
    self.easi.tract := le.geo_blk[1..6];
    self.easi.blkgrp := le.geo_blk[7];
    self.easi.county :=  le.county;
    self.easi.geo_blk := le.geo_blk;
    self.easi := ri;
  END;
  
	easi_census_roxie := join(e_address, Easi.Key_Easi_Census,
                            keyed(left.st+left.county+left.geo_blk = right.geolink),
                            easi_census_transform(LEFT, RIGHT), 
                            ATMOST(keyed(left.st+left.county+left.geo_blk = right.geolink), Riskwise.max_atmost), KEEP(1));
                            
	easi_census_thor := join(DISTRIBUTE(e_address, HASH64(st+county+geo_blk)), 
                            DISTRIBUTE(PULL(Easi.Key_Easi_Census), HASH64(geolink)),
                            left.st+left.county+left.geo_blk = right.geolink,
                            easi_census_transform(LEFT, RIGHT), 
                            ATMOST(left.st+left.county+left.geo_blk = right.geolink, Riskwise.max_atmost), KEEP(1), LOCAL);
    
#IF(onThor)
	easi_census := easi_census_thor;
#ELSE
	easi_census := easi_census_roxie;
#END
																						
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
		models.layouts.layout_LeadIntegrity_attributes_batch;
		layout_bseasi clam;
	end;


	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim(((string)(histdate))[5..6])='01';
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;
	
  checkHdrBldDate(unsigned FoundDate, unsigned HdrBldDate) := FUNCTION
			outDate := if(foundDate >= HdrBldDate, HdrBldDate, foundDate);
			return outDate;
	END;

	months_apart(unsigned3 system_yearmonth, unsigned some_yearmonth) := function
		days := ut.DaysApart((string)system_yearmonth + '01', (string)some_yearmonth + '01' );
		days_in_a_month := 30.5;
		calculated_months := days/days_in_a_month;
		months := if(some_yearmonth=0, 0, calculated_months);
		return round(months);
	end;
	
	// this function is for correcting months of 00 in header dates.  
// header dates are unsigned3 values, even though layout_address_informationv3 allows unsigned4, the values are still YYYYMM 										
 unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );

	checkBoolean(boolean x) := if(x, '1', '0');
	cap1Byte := 9;
	cap2Byte := 99;
	cap3Byte := 999;
	cap4Byte := 9998;  // use 9998 because 9999 is a default value for distance not calculated
	cap6Byte := 999999;
	cap10Byte := 9999999999;
	cap12Byte := 999999999999;
	cap13byte := 9999999999999;
	cap960 := 960;
	cap255 := 255;
	capZero := 0;
	capAtOne := 1;
	decimal_length := 1;

	capU(UNSIGNED input, UNSIGNED lower, UNSIGNED upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	capI(INTEGER input, INTEGER lower, INTEGER upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	capR(REAL input, REAL lower, REAL upper) := FUNCTION
		RETURN(IF(input <= lower, lower, IF(input >= upper, upper, input)));
	END;
	capS(STRING input, INTEGER lower, INTEGER upper) := FUNCTION
		RETURN(IF(TRIM(input) = '', '', IF((INTEGER)input <= (INTEGER)lower, (STRING)lower, IF((INTEGER)input >= (INTEGER)upper, (STRING)upper, input))));
	END;
	
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
  self.did := le.did;
	system_yearmonth := if(le.historydate = risk_indicators.iid_constants.default_history_date, (integer)(((STRING8)Std.Date.Today())[1..6]), le.historydate);
	
	fulldate := (unsigned4)risk_indicators.iid_constants.full_history_date(le.historydate);
	
	checkDate6(unsigned3 foundDate) := FUNCTION
		outDate := if(foundDate > le.historyDate, getPreviousMonth(le.historyDate), foundDate);
		return (string)outDate;
	END;
	
	/* The following accounts for randomized socials - This code is located within Risk_Indicators.iid_getSSNFlags:
				ssnLowIssue - If possibly randomized, set low issue to the first date of randomization - June 25th, 2011
				ssnHighIssue - If possibly randomized, set to the current date (Or archive date if running in archive mode)
	*/
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.shell_input.ssn, le.iid.socsvalflag, le.iid.socllowissue, le.iid.socsRCISflag);
	ssnLowIssue := le.iid.socllowissue;
	ssnHighIssue := le.iid.soclhighissue;	
	
	self.seq := (string)le.seq;
	self.acctno := '';

	// Identity Authentication Attributes	
	self.SubjectFirstSeen := TRIM((string)ut.Min2(le.ssn_verification.header_first_seen, le.ssn_verification.credit_first_seen));
	last_seen := MAX(le.ssn_verification.header_last_seen, le.ssn_verification.credit_last_seen);
	self.DateLastUpdate := checkDate6(last_seen);
	today := ((STRING8)Std.Date.Today());
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
	self.datessndeceased := TRIM((string)if(le.ssn_verification.Validation.deceasedDate>fullDate, 0, le.ssn_verification.Validation.deceasedDate));
	self.SSNIssued := checkboolean( le.SSN_Verification.Validation.valid and le.shell_input.ssn<>'' );
	self.RecentSSN := checkboolean(  (system_yearmonth - (INTEGER)(le.iid.soclhighissue[1..6])) < 100 AND system_yearmonth <= Risk_Indicators.iid_constants.randomSSN1Year);
	self.LowIssueDate := TRIM((string)if((unsigned)ssnLowIssue>fullDate, 0, (unsigned)ssnLowIssue));
	self.HighIssueDate := TRIM((string)if((unsigned)ssnHighIssue>fullDate, 0, (unsigned)ssnHighIssue));
	self.SSNIssueState := le.iid.soclstate;
	self.NonUSssn := checkboolean(le.iid.non_us_ssn OR 
																(le.shell_input.ssn[1]='9' and le.shell_input.ssn[4] in ['7','8']));// ITIN logic
	self.ssn3years := checkboolean(// If it is not a randomized social and only issued within the last 36 months
																(~randomizedSocial AND (system_yearmonth - (INTEGER)(le.iid.socllowissue[1..6])) < 300) OR 
																// Or it was possibly randomized and the date is prior to June 25th, 2014
																(randomizedSocial AND system_yearmonth <= Risk_Indicators.iid_constants.randomSSN3Years));
	self.ssnAFter5 := checkboolean( ((INTEGER)(le.iid.socllowissue[1..6]) - (INTEGER)(le.shell_input.Dob[1..6])) > 500 AND (INTEGER)(le.shell_input.Dob[1..4]) > 1990 AND (INTEGER)(le.shell_input.Dob[1..6]) < 200606);
	self.ssnprobs := le.ssn_verification.validation.inputsocscode;
	
// Evidence of Compromised Identity
	self.SSNNotFound := checkboolean( ~le.iid.ssnexists );
	self.SSNFoundOther := checkboolean( le.iid.nas_summary in [1,2,3,4,5,8] and le.iid.ssnExists and ~le.iid.lastssnmatch2 );
	self.SSNIssuedPrior := checkboolean( le.ssn_verification.validation.dob_mismatch );
	self.PhoneOther := checkboolean( le.iid.phonelastcount=0 AND le.iid.phoneaddrcount=0 AND le.iid.phonephonecount>0 and ~le.iid.phonevalflag='0' );
	self.SSNPerID := TRIM((string)capU(le.velocity_counters.ssns_per_adl, capZero, cap255));
	self.AddrPerID := TRIM((string)capU(le.velocity_counters.addrs_per_adl, capZero, cap255));
	self.PhonePerID := TRIM((string)capU(le.velocity_counters.phones_per_adl, capZero, cap255));
	self.IDPerSSN := TRIM((string)capU(le.SSN_Verification.adlPerSSN_count, capZero, cap255));
	self.AddrPerSSN := TRIM((string)capU(le.velocity_counters.addrs_per_ssn, capZero, cap255));
	self.IDPerAddr := TRIM((string)capU(le.velocity_counters.adls_per_addr, capZero, cap255));
	self.SSNPerAddr := TRIM((string)capU(le.velocity_counters.ssns_per_addr, capZero, cap255));
	self.PhonePerAddr := TRIM((string)capU(le.velocity_counters.phones_per_addr, capZero, cap255));
	self.IDPerPhone := TRIM((string)capU(le.velocity_counters.adls_per_phone, capZero, cap255));
	self.SSNPerID6 := TRIM((string)capU(le.velocity_counters.ssns_per_adl_created_6months, capZero, cap255));
	self.AddrPerID6 := TRIM((string)capU(le.velocity_counters.addrs_per_adl_created_6months, capZero, cap255));
	self.PhonePerID6 := TRIM((string)capU(le.velocity_counters.phones_per_adl_created_6months, capZero, cap255));
	self.IDPerSSN6 := TRIM((string)capU(le.velocity_counters.adls_per_ssn_created_6months, capZero, cap255));
	self.AddrPerSSN6 := TRIM((string)capU(le.velocity_counters.addrs_per_ssn_created_6months, capZero, cap255));
	self.IDPerAddr6 := TRIM((string)capU(le.velocity_counters.adls_per_addr_created_6months, capZero, cap255));
	self.SSNPerAddr6 := TRIM((string)capU(le.velocity_counters.ssns_per_addr_created_6months, capZero, cap255));
	self.PhonePerAddr6 := TRIM((string)capU(le.velocity_counters.phones_per_addr_created_6months, capZero, cap255));
	self.IDPerPhone6 := TRIM((string)capU(le.velocity_counters.adls_per_phone_created_6months, capZero, cap255));	

// Identity Change Information
	self.LastNamePerSSN := TRIM((string)capU( le.SSN_Verification.namePerSSN_count, capZero, cap255));
	self.LastNamePerID := TRIM((string)capU( le.velocity_counters.lnames_per_adl, capZero, cap255));
	DateLastNameChange := if(le.name_verification.newest_lname_dt_first_seen>le.historyDate, 0, le.name_verification.newest_lname_dt_first_seen);
	self.TimeSinceLastName := TRIM((string)capU( months_apart(system_yearmonth, datelastnamechange), capZero, IF(version = 1, cap255, cap960)));
	self.LastNames30 := TRIM((string)capU( le.velocity_counters.lnames_per_adl30, capZero, cap255));
	self.LastNames90 := TRIM((string)capU( le.velocity_counters.lnames_per_adl90, capZero, cap255));
	self.LastNames180 := TRIM((string)capU( le.velocity_counters.lnames_per_adl180, capZero, cap255));
	self.LastNames12 := TRIM((string)capU( le.velocity_counters.lnames_per_adl12, capZero, cap255));
	self.LastNames24 := TRIM((string)capU( le.velocity_counters.lnames_per_adl24, capZero, cap255));
	self.LastNames36 := TRIM((string)capU( le.velocity_counters.lnames_per_adl36, capZero, cap255));
	self.LastNames60 := TRIM((string)capU( le.velocity_counters.lnames_per_adl60, capZero, cap255));
	self.IDPerSFDUAddr := TRIM((string)capU( if(le.address_validation.error_codes[1]='S', le.velocity_counters.adls_per_addr, 0), capZero, cap255));
	self.SSNPerSFDUAddr := TRIM((string)capU( if(le.address_validation.error_codes[1]='S', le.velocity_counters.ssns_per_addr, 0), capZero, cap255));
	
// Characteristics of Input Address	


  IADateFirstReported := (unsigned)checkDate6(le.address_verification.input_address_information.date_first_seen);
	IADateLastReported := (unsigned)checkDate6(le.address_verification.input_address_information.date_last_seen);
	self.TimeSinceInputAddrFirstSeen:= TRIM((string)capU( months_apart(system_yearmonth, IADateFirstReported), capZero, cap3byte));
	self.TimeSinceInputAddrLastSeen:= TRIM((string)capU( months_apart(system_yearmonth, IADateLastReported), capZero, cap3byte));
	IALenOfRes := if(IADateFirstReported <> 0 and IADateLastReported <> 0,
																		round((ut.DaysApart((string)IADateFirstReported, 
																												(string)IADateLastReported)) / 30),  0);
	self.InputAddrLenOfRes := TRIM((string)capU(IALenOfRes, capZero, cap3Byte)); 

	self.InputAddrDwellType := if(le.shell_input.addr_type='S' and le.iid.addrvalflag='N', '', le.shell_input.addr_type);
	self.InputAddrLandUseCode := le.avm.input_address_information.avm_land_use_code;
	self.InputAddrAssessedValue := TRIM((string)capU(le.address_verification.input_address_information.assessed_amount, capZero, cap10Byte));
	self.InputAddrApplicantOwned := checkboolean( le.address_verification.input_address_information.applicant_owned );
	self.InputAddrFamilyOwned := checkboolean( le.address_verification.input_address_information.family_owned and ~le.address_verification.input_address_information.applicant_owned );
	self.InputAddrOccupantOwned := checkboolean( le.address_verification.input_address_information.occupant_owned and ~le.address_verification.input_address_information.applicant_owned and
																		 ~le.address_verification.input_address_information.family_owned );
	self.InputAddrLastSalesDate := TRIM((string)if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_date));
	self.InputAddrLastSalesAmount := TRIM((string)capU(if(le.address_verification.input_address_information.purchase_date>fullDate, 0, le.address_verification.input_address_information.purchase_amount), capZero, cap10byte));
	self.InputAddrNotPrimaryRes := checkboolean( ~le.address_verification.input_address_information.isbestmatch );
	self.InputAddrActivePhoneList := TRIM((string)capU(le.Address_Verification.edaMatchLevel, capZero, 4));
	self.InputAddrActivePhoneNumber := TRIM((string)le.Address_Verification.activePhone);
	IAMed_hhinc := le.ineasi.med_hhinc;
	self.InputAddrMedianIncome := TRIM(capS(IAMed_hhinc, capZero, cap6Byte));
	IAMed_hval := le.ineasi.med_hval;
	self.InputAddrMedianHomeVal := TRIM(capS(IAMed_hval, capZero, cap6Byte));
	self.InputAddrMurderIndex := TRIM(capS(le.ineasi.murders, capZero, 200));
	self.InputAddrCarTheftIndex := TRIM(capS(le.ineasi.cartheft, capZero, 200));
	self.InputAddrBurglaryIndex := TRIM(capS(le.ineasi.burglary, capZero, 200));
	IAtotcrime := le.ineasi.totcrime;
	self.InputAddrCrimeIndex := TRIM(capS(IAtotcrime, capZero, 200));
	self.InputAddrTaxAssessedYr := le.avm.input_address_information.avm_assessed_value_year;
	self.InputAddrAssessMarket := TRIM(capS(le.avm.input_address_information.avm_market_total_value, capZero, cap10Byte));
	self.InputAddrTaxAssessVal := TRIM((string)capU(le.avm.input_address_information.avm_tax_assessment_valuation, capZero, cap10Byte));
	self.InputAddrPriceIndVal := TRIM((string)capU(le.avm.input_address_information.avm_price_index_valuation, capZero, cap10Byte));
	self.InputAddrHedVal := TRIM((string)capU(le.avm.input_address_information.avm_hedonic_valuation, capZero, cap10Byte));
	
	IAAutomatedValuation := capU(le.avm.input_address_information.avm_automated_valuation, capZero, cap10Byte);
	self.InputAddrAutoVal := TRIM((string)IAAutomatedValuation);
	self.InputAddrConfScore := TRIM((string)capU(le.avm.input_address_information.avm_confidence_score, capZero, cap2byte));
	
	IACountyMedianValuation := MIN(le.avm.input_address_information.avm_median_fips_level, cap10byte);
	IATractMedianValuation := MIN(le.avm.input_address_information.avm_median_geo11_level, cap10byte);
	IABlockMedianValuation := MIN(le.avm.input_address_information.avm_median_geo12_level, cap10byte);
	
	self.InputAddrCountyIndex := TRIM((string)capR((REAL)formatdecimalstring(IAAutomatedValuation/IACountyMedianValuation, decimal_length), (REAL)capZero, 99.9));
	self.InputAddrTractIndex :=  TRIM((string)capR((REAL)formatdecimalstring(IAAutomatedValuation/IATractMedianValuation, decimal_length), (REAL)capZero, 99.9));
	self.InputAddrBlockIndex := TRIM((string)capR((REAL)formatdecimalstring(IAAutomatedValuation/IABlockMedianValuation, decimal_length), (REAL)capZero, 99.9));

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
	self.NumSrcsConfirmIDAddr := TRIM((string)capU(numsources, capZero, cap255));

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

	self.TimeSinceCurrAddrFirstSeen := TRIM((string)capU(months_apart(system_yearmonth, CADateFirstReported), capZero, cap3Byte));
	self.TimeSinceCurrAddrLastSeen := TRIM((string)capU(months_apart(system_yearmonth, CADateLastReported), capZero, cap3Byte));
	
	CALenOfRes := if(CADateFirstReported <> 0 and CADateLastReported <> 0,
																		round((ut.DaysApart((string)CADateFirstReported, 
																												(string)CADateLastReported)) / 30),  0);
	self.CurrAddrLenOfRes := TRIM((string)capU(CALenOfRes, capZero, cap3Byte)); 
	
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
	
	self.CurrAddrAssessedValue := TRIM((string)capU(CAAssessedValue, capZero, cap10byte));
															
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
										
	self.CurrAddrLastSalesDate := TRIM((string)if(CALastSaleDate>fullDate, 0, CALastSaleDate));
	
	CALastSaleAmount := if(CALastSaleDate>fullDate, 0, 
																				map(CAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						CAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						CAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0));
	self.CurrAddrLastSalesAmount := TRIM((string)capU(CALastSaleAmount, capZero, cap10Byte));
	
	CAisNotPrimaryRes := map(CAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
																				 CAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
																				 CAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
																				 true);
	self.CurrAddrNotPrimaryRes := checkboolean( CAisNotPrimaryRes );
	
	CAPhoneListed := map(CAaddrChooser=1 => le.address_verification.edaMatchLevel,
																		 CAaddrChooser=2 => le.address_verification.edaMatchLevel2,
																		 CAaddrChooser=3 => le.address_verification.edaMatchLevel3,
																		 0);
	self.CurrAddrActivePhoneList := TRIM((string)caphoneListed);
	
	CAPhoneNumber := map(CAaddrChooser=1 => le.address_verification.activePhone,
																		 CAaddrChooser=2 => le.address_verification.activePhone2,
																		 CAaddrChooser=3 => le.address_verification.activePhone3,
																		 0);
	self.CurrAddrActivePhoneNumber := TRIM((string)caphoneNumber);
	
	CAMed_HHINC := map(CAaddrChooser=0 => '',
													CAaddrChooser=1 => le.ineasi.med_hhinc,
													CAaddrChooser=2 => le.easi1.med_hhinc,
													le.easi2.med_hhinc);															 
	self.CurrAddrMedianIncome := TRIM(capS(CAMed_HHINC, capZero, cap6Byte));
	
	CAMED_HVAL := map(CAaddrChooser=0 => '',
													CAaddrChooser=1 => le.ineasi.med_hval,
													CAaddrChooser=2 => le.easi1.med_hval,
													le.easi2.med_hval);
													
	self.CurrAddrMedianHomeVal := TRIM(capS(CAMED_HVAL, capZero, cap6Byte));
																	
	self.CurrAddrMurderIndex := TRIM(capS(map(CAaddrChooser=0 => '',
												CAaddrChooser=1 => le.ineasi.murders,
												CAaddrChooser=2 => le.easi1.murders,
												le.easi2.murders), capZero, 200));
												
	self.CurrAddrCarTheftIndex := TRIM(capS(map(CAaddrChooser=0 => '',
												 CAaddrChooser=1 => le.ineasi.cartheft,
												 CAaddrChooser=2 => le.easi1.cartheft,
												 le.easi2.cartheft), capZero, 200));
												 
	self.CurrAddrBurglaryIndex := TRIM(capS(map(CAaddrChooser=0 => '',
												CAaddrChooser=1 => le.ineasi.burglary,
												CAaddrChooser=2 => le.easi1.burglary,
												le.easi2.burglary), capZero, 200));
	
	CATotCrime := map(CAaddrChooser=0 => '',
												 CAaddrChooser=1 => le.ineasi.totcrime,
												 CAaddrChooser=2 => le.easi1.totcrime,
												 le.easi2.totcrime);
	self.CurrAddrCrimeIndex := TRIM(capS(CATotCrime, capZero, 200));
	
	self.CurrAddrTaxAssessedYr := map(CAaddrChooser=0 => '',
														CAaddrChooser=1 => le.avm.input_address_information.avm_assessed_value_year,
														CAaddrChooser=2 => le.avm.address_history_1.avm_assessed_value_year,
														le.avm.address_history_2.avm_assessed_value_year);	
	
	
	self.CurrAddrAssessMarket := TRIM(capS(map(CAaddrChooser=0 => '',
														CAaddrChooser=1 => le.avm.input_address_information.avm_market_total_value,
														CAaddrChooser=2 => le.avm.address_history_1.avm_market_total_value,
														le.avm.address_history_2.avm_market_total_value), capZero, cap10Byte));	
		
	
	CATaxAssessmentValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
														le.avm.address_history_2.avm_tax_assessment_valuation);	
	self.CurrAddrTaxAssessVal := TRIM((string)capU(CATaxAssessmentValuation, capZero, cap10byte));
														
	
	CAPriceIndexValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
														le.avm.address_history_2.avm_price_index_valuation);	
	self.CurrAddrPriceIndVal := TRIM((string)capU(CAPriceIndexValuation, capZero, cap10byte));
	
	CAHedonicValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
														le.avm.address_history_2.avm_hedonic_valuation);	
	self.CurrAddrHedVal := TRIM((string)capU(CAHedonicValuation, capZero, cap10byte));
			
	
	CAAutomatedValuation := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_Automated_valuation,
														CAaddrChooser=2 => le.avm.address_history_1.avm_Automated_valuation,
														le.avm.address_history_2.avm_Automated_valuation);	
	self.CurrAddrAutoVal := TRIM((string)capU(CAAutomatedValuation, capZero, cap10byte));
	
	
	CAConfidenceScore := map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
														CAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
														le.avm.address_history_2.avm_confidence_score);	
	self.CurrAddrConfScore := TRIM((string)capU(CAConfidenceScore, capZero, cap2byte));
	
	
	CACountyMedianValuation := MIN(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
														le.avm.address_history_2.avm_median_fips_level)
																				, cap10byte);
	CATractMedianValuation := MIN(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
														le.avm.address_history_2.avm_median_geo11_level)
																				, cap10byte);
	CABlockMedianValuation := MIN(map(CAaddrChooser=0 => 0,
														CAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
														CAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
														le.avm.address_history_2.avm_median_geo12_level)
																				, cap10byte);
																				
	
	self.CurrAddrCountyIndex := TRIM((STRING)capR((REAL)formatdecimalstring(CAAutomatedValuation/CACountyMedianValuation, decimal_length), (REAL)capZero, 99.9));
	self.CurrAddrTractIndex :=  TRIM((STRING)capR((REAL)formatdecimalstring(CAAutomatedValuation/CATractMedianValuation, decimal_length), (REAL)capZero, 99.9));
	self.CurrAddrBlockIndex := TRIM((STRING)capR((REAL)formatdecimalstring(CAAutomatedValuation/CABlockMedianValuation, decimal_length), (REAL)capZero, 99.9));
	
	
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

  
	self.TimeSincePrevAddrFirstSeen := TRIM((string)capU( months_apart(system_yearmonth, PADateFirstReported), capZero, cap3Byte));

	self.TimeSincePrevAddrLastSeen := TRIM((string)capU( months_apart(system_yearmonth, PADateLastReported), capZero, cap3Byte));
	
	PALenOfRes := if(PADateFirstReported <> 0 and PADateLastReported <> 0,
																		round((ut.DaysApart((string)PADateFirstReported, 
																												(string)PADateLastReported)) / 30),  0);

	self.PrevAddrLenOfRes := TRIM((string)capU(PALenOfRes, capZero, cap3Byte)); 
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
	self.PrevAddrAssessedValue := TRIM((string)capU(PAAssessedValue, capZero, cap10byte));
	
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
	self.PrevAddrLastSalesDate := TRIM((string)if(PALastSaleDate>fullDate, 0, PALastSaleDate));
	PALastSaleAmount := if(PALastSaleDate>fullDate, 0, 
																				map(PAaddrChooser=1 => le.address_verification.input_address_information.purchase_amount,
																						PAaddrChooser=2 => le.address_verification.address_history_1.purchase_amount,
																						PAaddrChooser=3 => le.address_verification.address_history_2.purchase_amount,
																						0));
	self.PrevAddrLastSalesAmount := TRIM((string)capU(PALastSaleAmount, capZero, cap10byte));
	PAisNotPrimaryRes := map(PAaddrChooser=1 => ~le.address_verification.input_address_information.isbestmatch,
													 PAaddrChooser=2 => ~le.address_verification.address_history_1.isbestmatch,
													 PAaddrChooser=3 => ~le.address_verification.address_history_2.isbestmatch,
													 true);
	self.PrevAddrNotPrimaryRes := checkboolean(PAisNotPrimaryRes);
	PAPhoneListed := map(PAaddrChooser=1 => le.address_verification.edaMatchLevel,
											 PAaddrChooser=2 => le.address_verification.edaMatchLevel2,
											 PAaddrChooser=3 => le.address_verification.edaMatchLevel3,
											 0);
	self.PrevAddrActivePhoneList := TRIM((string)PAPhoneListed);
	PAPhoneNumber := map(PAaddrChooser=1 => le.address_verification.activePhone,
											 PAaddrChooser=2 => le.address_verification.activePhone2,
											 PAaddrChooser=3 => le.address_verification.activePhone3,
											 0);
	self.PrevAddrActivePhoneNumber := TRIM((string)PAPhoneNumber);
	
	PAMed_HHINC := map(PAaddrChooser=1 => le.ineasi.med_hhinc,
																	 PAaddrChooser=2 => le.easi1.med_hhinc,
																	 PAaddrChooser=3 => le.easi2.med_hhinc,
																	 '');
	self.PrevAddrMedianIncome := TRIM(capS(PAMed_HHINC, capZero, cap6Byte));
	
	PAMed_Hval := map(PAaddrChooser=1 => le.ineasi.med_hval,
																	PAaddrChooser=2 => le.easi1.med_hval,
																	PAaddrChooser=3 => le.easi2.med_hval,
																	'');
	self.PrevAddrMedianHomeVal := TRIM(capS(PAMed_Hval, capZero, cap6Byte));
	
	self.PrevAddrMurderIndex := TRIM(capS(map(PAaddrChooser=1 => le.ineasi.murders,
																 PAaddrChooser=2 => le.easi1.murders,
																 PAaddrChooser=3 => le.easi2.murders,
																 ''), capZero, 200));
	self.PrevAddrCarTheftIndex := TRIM(capS(map(PAaddrChooser=1 => le.ineasi.cartheft,
																	PAaddrChooser=2 => le.easi1.cartheft,
																	PAaddrChooser=3 => le.easi2.cartheft,
																	''), capZero, 200));
	self.PrevAddrBurglaryIndex := TRIM(capS(map(PAaddrChooser=1 => le.ineasi.burglary,
																	PAaddrChooser=2 => le.easi1.burglary,
																	PAaddrChooser=3 => le.easi2.burglary,
																	''), capZero, 200));
	PATotCrime := map(PAaddrChooser=1 => le.ineasi.totcrime,
																	PAaddrChooser=2 => le.easi1.totcrime,
																	PAaddrChooser=3 => le.easi2.totcrime,
																	'');
	self.PrevAddrCrimeIndex := TRIM(capS(PATotCrime, capZero, 200));	
	
	
	self.PrevAddrTaxAssessedYr := map(PAaddrChooser=0 => '',
														PAaddrChooser=1 => le.avm.input_address_information.avm_assessed_value_year,
														PAaddrChooser=2 => le.avm.address_history_1.avm_assessed_value_year,
														le.avm.address_history_2.avm_assessed_value_year);	
	
	
	self.PrevAddrAssessMarket := capS(map(PAaddrChooser=0 => '',
														PAaddrChooser=1 => le.avm.input_address_information.avm_market_total_value,
														PAaddrChooser=2 => le.avm.address_history_1.avm_market_total_value,
														le.avm.address_history_2.avm_market_total_value), capZero, cap10Byte);	
		
	
	PATaxAssessmentValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_tax_assessment_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_tax_assessment_valuation,
														le.avm.address_history_2.avm_tax_assessment_valuation);	
	self.PrevAddrTaxAssessVal := TRIM((string)capU(PATaxAssessmentValuation, capZero, cap10byte));
														
	
	PAPriceIndexValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_price_index_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_price_index_valuation,
														le.avm.address_history_2.avm_price_index_valuation);	
	self.PrevAddrPriceIndVal := TRIM((string)capU(PAPriceIndexValuation, capZero, cap10byte));
	
	PAHedonicValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_hedonic_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_hedonic_valuation,
														le.avm.address_history_2.avm_hedonic_valuation);	
	self.PrevAddrHedVal := TRIM((string)capU(PAHedonicValuation, capZero, cap10byte));
			
	
	PAAutomatedValuation := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_Automated_valuation,
														PAaddrChooser=2 => le.avm.address_history_1.avm_Automated_valuation,
														le.avm.address_history_2.avm_Automated_valuation);	
	self.PrevAddrAutoVal := TRIM((string)capU(PAAutomatedValuation, capZero, cap10byte));
	
	
	PAConfidenceScore := map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_confidence_score,
														PAaddrChooser=2 => le.avm.address_history_1.avm_confidence_score,
														le.avm.address_history_2.avm_confidence_score);	
	self.PrevAddrConfScore := TRIM((string)capU(PAConfidenceScore, capZero, cap2byte));
	
	
	PACountyMedianValuation := MIN(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
														le.avm.address_history_2.avm_median_fips_level)
																				, cap10byte);
	PATractMedianValuation := MIN(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo11_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo11_level,
														le.avm.address_history_2.avm_median_geo11_level)
																				, cap10byte);
	PABlockMedianValuation := MIN(map(PAaddrChooser=0 => 0,
														PAaddrChooser=1 => le.avm.input_address_information.avm_median_geo12_level,
														PAaddrChooser=2 => le.avm.address_history_1.avm_median_geo12_level,
														le.avm.address_history_2.avm_median_geo12_level)
																				, cap10byte);
																				
	self.PrevAddrCountyIndex := TRIM((STRING)capR((REAL)formatdecimalstring(PAAutomatedValuation/PACountyMedianValuation, decimal_length), (REAL)capZero, 99.0));
	self.PrevAddrTractIndex :=  TRIM((STRING)capR((REAL)formatdecimalstring(PAAutomatedValuation/PATractMedianValuation, decimal_length), (REAL)capZero, 99.0));
	self.PrevAddrBlockIndex := TRIM((STRING)capR((REAL)formatdecimalstring(PAAutomatedValuation/PABlockMedianValuation, decimal_length), (REAL)capZero, 99.0));

	
	default_no_distance := 9999;
		
// Differences between Input Address and Current Address
	self.InputAddrCurrAddrMatch := checkboolean(CAaddrChooser=1);
	inputaddrcurraddrdistance := map(CAaddrChooser=1 => 0,// same address as input
																		 CAaddrChooser=2 => le.address_verification.distance_in_2_h1,// compare input to history 1
																		 CAaddrChooser=3 => le.address_verification.distance_in_2_h2,// compare input to history 2
																		 default_no_distance); // no distance calculated
																		 
	self.InputAddrCurrAddrDistance := TRIM((string)capU(inputaddrcurraddrdistance, capZero, cap4byte));
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

	self.InputAddrCurrAddrAssessedDiff := TRIM((string)MIN(9999999999,MAX(-9999999999,(integer)assessedDiff)));

	self.InputAddrCurrAddrIncomeDiff  := TRIM((string)MAP(CAaddrChooser = 2 => capI(((INTEGER)CAmed_hhinc - (INTEGER)IAmed_hhinc), -cap10Byte, cap10Byte),
																												CAaddrChooser = 3 => capI(((INTEGER)PAmed_hhinc - (INTEGER)IAmed_hhinc), -cap10Byte, cap10Byte),
																												0));
	self.InputAddrCurrAddrHomeValDiff := TRIM((string)MAP(CAaddrChooser = 2 => capI(((INTEGER)CAmed_hval - (INTEGER)IAmed_hval), -cap10Byte, cap10Byte),
																												CAaddrChooser = 3 => capI(((INTEGER)PAmed_hval - (INTEGER)IAmed_hval), -cap10Byte, cap10Byte),
																												0));
	self.InputAddrCurrAddrCrimeDiff   := TRIM((string)MAP(CAaddrChooser = 2 => capI(((INTEGER)CAtotcrime - (INTEGER)IAtotcrime), -200, 200),
																												CAaddrChooser = 3 => capI(((INTEGER)PAtotcrime - (INTEGER)IAtotcrime), -200, 200),
																												0));
	
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
																		
	self.CurrAddrPrevAddrDistance := TRIM((string)capU(CurrAddrPrevAddrDistance, capZero, cap4byte));
																		
																		
	prevAddrSt := map(PAaddrChooser=1 => le.address_verification.input_address_information.st,
										PAaddrChooser=2 => le.address_verification.address_history_1.st,
										PAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');
	self.CurrAddrPrevAddrStateDiff:= checkboolean( if(isInputPrevMatch, false, (prevAddrSt<>currAddrSt)) );
	self.CurrAddrPrevAddrAssessedDiff := TRIM((string)if(isInputPrevMatch, 0, MAX(-9999999999, MIN(9999999999,CAAssessedValue - PAAssessedValue))));
	self.CurrAddrPrevAddrIncomeDiff := TRIM((string)if(isInputPrevMatch,0, capI(((INTEGER)CAmed_hhinc - (INTEGER)PAmed_hhinc), -cap10Byte, cap10Byte)));
	self.CurrAddrPrevAddrHomeValDiff := TRIM((string)if(isInputPrevMatch, 0, capI(((INTEGER)CAmed_hval - (INTEGER)PAmed_hval), -cap10Byte, cap10Byte)));
	self.CurrAddrPrevAddrCrimeDiff := TRIM((string)if(isInputPrevMatch,0, capI(((INTEGER)CAtotcrime - (INTEGER)PAtotcrime), -200, 200)));
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
	self.TimeSincePrevAddrDateFirstSeen := TRIM((string)capU( months_apart(system_yearmonth, PADateFirstReported), capZero, cap3Byte));  
	
	NPADateFirstReported := (unsigned)checkDate6( map(CAaddrChooser=1 and PAaddrChooser=2 OR CAaddrChooser=2 and PAaddrChooser=1 => le.address_verification.address_history_2.date_first_seen,
																						CAaddrChooser=1 and PAaddrChooser=3 OR CAaddrChooser=3 and PAaddrChooser=1 => le.address_verification.address_history_1.date_first_seen,
																						CAaddrChooser=0 => 0,	// if we dont know what current is, then 0
																						if(le.iid.chronodate_first < PADateFirstReported, le.iid.chronodate_first, 
																									if(le.iid.chronodate_first2 < PADateFirstReported, le.iid.chronodate_first2,
																												le.iid.chronodate_first3))) );//assuming one of the chronodates is the third address, pick the one that is less than the pa date
	self.TimeSinceNextPrevDateFirstSeen := TRIM((string)capU( months_apart(system_yearmonth, NPADateFirstReported), capZero, cap3Byte));
	
	self.addrChanges30 := TRIM((string)capU(le.other_address_info.addrs_last30, capZero, cap255));
	self.addrChanges90 := TRIM((string)capU(le.other_address_info.addrs_last90, capZero, cap255));
	self.addrChanges180 := TRIM((string)capU(le.velocity_counters.addrs_per_adl_created_6months, capZero, cap255));
	self.addrChanges12 := TRIM((string)capU(le.other_address_info.addrs_last12, capZero, cap255));
	self.addrChanges24 := TRIM((string)capU(le.other_address_info.addrs_last24, capZero, cap255));
	self.addrChanges36 := TRIM((string)capU(le.other_address_info.addrs_last36, capZero, cap255));
	self.addrChanges60 := TRIM((string)capU(le.other_address_info.addrs_last_5years, capZero, cap255));
	
// Property and Asset Information
	self.propertyownedtotal := TRIM((string)capU(le.address_verification.owned.property_total, capZero, cap255));
	self.propertyownedassessedtotal := TRIM((string)capU(le.address_verification.owned.property_owned_assessed_total, capZero, cap12Byte));
	self.propertyhistoricallyowned := TRIM((string)capU(le.address_verification.owned.property_total + le.address_verification.sold.property_total + le.address_verification.ambiguous.property_total, capZero, cap255));
	self.datefirstpurchase := TRIM((string)if(le.other_address_info.date_first_purchase>fullDate, 0, le.other_address_info.date_first_purchase));
	self.datemostrecentpurchase := TRIM((string)if(le.other_address_info.date_most_recent_purchase>fullDate, 0, le.other_address_info.date_most_recent_purchase));
	self.datemostrecentsale := TRIM((string)if(le.other_address_info.date_most_recent_sale>fullDate, 0, le.other_address_info.date_most_recent_sale));
	self.PropPurchased30 := TRIM((string)capU(le.other_address_info.num_purchase30, capZero, cap255));
	self.PropPurchased90 := TRIM((string)capU(le.other_address_info.num_purchase90, capZero, cap255));
	self.PropPurchased180 := TRIM((string)capU(le.other_address_info.num_purchase180, capZero, cap255));
	self.PropPurchased12 := TRIM((string)capU(le.other_address_info.num_purchase12, capZero, cap255));
	self.PropPurchased24 := TRIM((string)capU(le.other_address_info.num_purchase24, capZero, cap255));
	self.PropPurchased36 := TRIM((string)capU(le.other_address_info.num_purchase36, capZero, cap255));
	self.PropPurchased60 := TRIM((string)capU(le.other_address_info.num_purchase60, capZero, cap255));
	self.PropSold30 := TRIM((string)capU(le.other_address_info.num_sold30, capZero, cap255));
	self.PropSold90 := TRIM((string)capU(le.other_address_info.num_sold90, capZero, cap255));
	self.PropSold180 := TRIM((string)capU(le.other_address_info.num_sold180, capZero, cap255));
	self.PropSold12 := TRIM((string)capU(le.other_address_info.num_sold12, capZero, cap255));
	self.PropSold24 := TRIM((string)capU(le.other_address_info.num_sold24, capZero, cap255));
	self.PropSold36 := TRIM((string)capU(le.other_address_info.num_sold36, capZero, cap255));
	self.PropSold60 := TRIM((string)capU(le.other_address_info.num_sold60, capZero, cap255));
	self.numWatercraft := TRIM((string)capU(le.watercraft.watercraft_count, capZero, cap255));
	self.numWatercraft30 := TRIM((string)capU(le.watercraft.watercraft_count30, capZero, cap255));
	self.numWatercraft90 := TRIM((string)capU(le.watercraft.watercraft_count90, capZero, cap255));
	self.numWatercraft180 := TRIM((string)capU(le.watercraft.watercraft_count180, capZero, cap255));
	self.numWatercraft12 := TRIM((string)capU(le.watercraft.watercraft_count12, capZero, cap255));
	self.numWatercraft24 := TRIM((string)capU(le.watercraft.watercraft_count24, capZero, cap255));
	self.numWatercraft36 := TRIM((string)capU(le.watercraft.watercraft_count36, capZero, cap255));
	self.numWatercraft60 := TRIM((string)capU(le.watercraft.watercraft_count60, capZero, cap255));
	self.numAircraft := TRIM((string)capU(le.aircraft.aircraft_count, capZero, cap255));
	self.numAircraft30 := TRIM((string)capU(le.aircraft.aircraft_count30, capZero, cap255));
	self.numAircraft90 := TRIM((string)capU(le.aircraft.aircraft_count90, capZero, cap255));
	self.numAircraft180 := TRIM((string)capU(le.aircraft.aircraft_count180, capZero, cap255));
	self.numAircraft12 := TRIM((string)capU(le.aircraft.aircraft_count12, capZero, cap255));
	self.numAircraft24 := TRIM((string)capU(le.aircraft.aircraft_count24, capZero, cap255));
	self.numAircraft36 := TRIM((string)capU(le.aircraft.aircraft_count36, capZero, cap255));
	self.numAircraft60 := TRIM((string)capU(le.aircraft.aircraft_count60, capZero, cap255));
	self.wealthIndex := le.wealth_indicator;	
	
// Derogatory Public Records
	self.totalnumberderogs := TRIM((string)capU(le.bjl.criminal_count + le.bjl.filing_count + le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, capZero, cap255));
	date_last_derog := MAX(MAX(le.bjl.last_criminal_date, (integer)le.bjl.last_liens_unreleased_date),le.bjl.date_last_seen);
	self.datelastderog := TRIM((string)if(date_last_derog>fullDate, 0, date_last_derog));
	self.numfelonies := TRIM((string)capU(le.bjl.felony_count, capZero, cap255));
	self.datelastconviction := TRIM((string)if(le.bjl.last_felony_date>fullDate, 0, le.bjl.last_felony_date));
	self.numfelonies30 := TRIM((string)capU(le.bjl.criminal_count30, capZero, cap255));
	self.numfelonies90 := TRIM((string)capU(le.bjl.criminal_count90, capZero, cap255));
	self.numfelonies180 := TRIM((string)capU(le.bjl.criminal_count180, capZero, cap255));
	self.numfelonies12 := TRIM((string)capU(le.bjl.criminal_count12, capZero, cap255));
	self.numfelonies24 := TRIM((string)capU(le.bjl.criminal_count24, capZero, cap255));
	self.numfelonies36 := TRIM((string)capU(le.bjl.criminal_count36, capZero, cap255));
	self.numfelonies60 := TRIM((string)capU(le.bjl.criminal_count60, capZero, cap255));
	
	self.numarrests := TRIM((string)capU(le.bjl.arrests_count, capZero, cap255));
	self.datelastarrest := TRIM((string)if(le.bjl.date_last_arrest>fullDate, 0, le.bjl.date_last_arrest));
	self.numarrests30 := TRIM((string)capU(le.bjl.arrests_count30, capZero, cap255));
	self.numarrests90 := TRIM((string)capU(le.bjl.arrests_count90, capZero, cap255));
	self.numarrests180 := TRIM((string)capU(le.bjl.arrests_count180, capZero, cap255));
	self.numarrests12 := TRIM((string)capU(le.bjl.arrests_count12, capZero, cap255));
	self.numarrests24 := TRIM((string)capU(le.bjl.arrests_count24, capZero, cap255));
	self.numarrests36 := TRIM((string)capU(le.bjl.arrests_count36, capZero, cap255));
	self.numarrests60 := TRIM((string)capU(le.bjl.arrests_count60, capZero, cap255));
	
	self.LiensCount:= TRIM((string)capU(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count +
														 le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, capZero, cap255));
	self.LiensUnreleasedCount := TRIM((string)capU(le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count, capZero, cap255));
	self.MostRecentUnrelDate := TRIM((string)if((unsigned)le.bjl.last_liens_unreleased_date>fullDate, 0, (unsigned)le.bjl.last_liens_unreleased_date));
	self.LiensUnreleasedCount30 := TRIM((string)capU(le.bjl.liens_unreleased_count30, capZero, cap255));
	self.LiensUnreleasedCount90 := TRIM((string)capU(le.bjl.liens_unreleased_count90, capZero, cap255));
	self.LiensUnreleasedCount180 := TRIM((string)capU(le.bjl.liens_unreleased_count180, capZero, cap255));
	self.LiensUnreleasedCount12 := TRIM((string)capU(le.bjl.liens_unreleased_count12, capZero, cap255));
	self.LiensUnreleasedCount24 := TRIM((string)capU(le.bjl.liens_unreleased_count24, capZero, cap255));
	self.LiensUnreleasedCount36 := TRIM((string)capU(le.bjl.liens_unreleased_count36, capZero, cap255));
	self.LiensUnreleasedCount60 := TRIM((string)capU(le.bjl.liens_unreleased_count60, capZero, cap255));
	
	self.LiensReleasedCount := TRIM((string)capU(le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count, capZero, cap255));
	self.MostRecentReleasedDate := TRIM((string)if(le.bjl.last_liens_released_date>fullDate, 0, le.bjl.last_liens_released_date));
	self.LiensReleasedCount30 := TRIM((string)capU(le.bjl.liens_released_count30, capZero, cap255));
	self.LiensReleasedCount90 := TRIM((string)capU(le.bjl.liens_released_count90, capZero, cap255));
	self.LiensReleasedCount180 := TRIM((string)capU(le.bjl.liens_released_count180, capZero, cap255));
	self.LiensReleasedCount12 := TRIM((string)capU(le.bjl.liens_released_count12, capZero, cap255));
	self.LiensReleasedCount24 := TRIM((string)capU(le.bjl.liens_released_count24, capZero, cap255));
	self.LiensReleasedCount36 := TRIM((string)capU(le.bjl.liens_released_count36, capZero, cap255));
	self.LiensReleasedCount60 := TRIM((string)capU(le.bjl.liens_released_count60, capZero, cap255));
	
	self.bankruptCount := TRIM((string)capU(le.bjl.filing_count, capZero, cap255));
	self.MostRecentBankruptDate := TRIM((string)if(le.bjl.date_last_seen>fullDate, 0, le.bjl.date_last_seen));
	self.MostRecentBankruptType := le.bjl.filing_type;
	self.MostRecentBankruptStatus := le.bjl.disposition;
	self.bankruptCount30 := TRIM((string)capU(le.bjl.bk_count30, capZero, cap255));
	self.bankruptCount90 := TRIM((string)capU(le.bjl.bk_count90, capZero, cap255));
	self.bankruptCount180 := TRIM((string)capU(le.bjl.bk_count180, capZero, cap255));
	self.bankruptCount12 := TRIM((string)capU(le.bjl.bk_count12, capZero, cap255));
	self.bankruptCount24 := TRIM((string)capU(le.bjl.bk_count24, capZero, cap255));
	self.bankruptCount36 := TRIM((string)capU(le.bjl.bk_count36, capZero, cap255));
	self.bankruptCount60 := TRIM((string)capU(le.bjl.bk_count60, capZero, cap255));
	
	self.evictionCount := TRIM((string)capU(le.bjl.eviction_recent_unreleased_count + le.bjl.eviction_historical_unreleased_count +
																	le.bjl.eviction_recent_released_count + le.bjl.eviction_historical_released_count, capZero, cap255));
	self.MostRecentEvictionDate := TRIM((string)if(le.bjl.last_eviction_date>fullDate, 0, le.bjl.last_eviction_date));
	self.evictionCount30 := TRIM((string)capU(le.bjl.eviction_count30, capZero, cap255));
	self.evictionCount90 := TRIM((string)capU(le.bjl.eviction_count90, capZero, cap255));
	self.evictionCount180 := TRIM((string)capU(le.bjl.eviction_count180, capZero, cap255));
	self.evictionCount12 := TRIM((string)capU(le.bjl.eviction_count12, capZero, cap255));
	self.evictionCount24 := TRIM((string)capU(le.bjl.eviction_count24, capZero, cap255));
	self.evictionCount36 := TRIM((string)capU(le.bjl.eviction_count36, capZero, cap255));
	self.evictionCount60 := TRIM((string)capU(le.bjl.eviction_count60, capZero, cap255));	
	
	// Non-Derogatory Public Records
	self.NonDerogSrcCount := TRIM((string)capU(le.source_verification.num_nonderogs, capZero, cap255));	
	self.NonDerogSrcCount30 := TRIM((string)capU(le.source_verification.num_nonderogs30, capZero, cap255));
	self.NonDerogSrcCount90 := TRIM((string)capU(le.source_verification.num_nonderogs90, capZero, cap255));
	self.NonDerogSrcCount180 := TRIM((string)capU(le.source_verification.num_nonderogs180, capZero, cap255));
	self.NonDerogSrcCount12 := TRIM((string)capU(le.source_verification.num_nonderogs12, capZero, cap255));
	self.NonDerogSrcCount24 := TRIM((string)capU(le.source_verification.num_nonderogs24, capZero, cap255));
	self.NonDerogSrcCount36 := TRIM((string)capU(le.source_verification.num_nonderogs36, capZero, cap255));
	self.NonDerogSrcCount60 := TRIM((string)capU(le.source_verification.num_nonderogs60, capZero, cap255));
	
	self.ProfLicCount := TRIM((string)capU(le.professional_license.proflic_count, capZero, cap255));
	self.MostRecentProfLicDate := TRIM((string)if(le.professional_license.date_most_recent>fullDate, 0, le.professional_license.date_most_recent));
	self.MostRecentProfLicExpireDate := IF( (UNSIGNED)(((STRING)le.professional_license.expiration_date)[1..4]) > 2100 OR (UNSIGNED)(((STRING)le.professional_license.expiration_date)[1..4]) < 1989, '', TRIM((string)le.professional_license.expiration_date));
	self.ProfLicCount30 := TRIM((string)capU(le.professional_license.proflic_count30, capZero, cap255));
	self.ProfLicCount90 := TRIM((string)capU(le.professional_license.proflic_count90, capZero, cap255));
	self.ProfLicCount180 := TRIM((string)capU(le.professional_license.proflic_count180, capZero, cap255));
	self.ProfLicCount12 := TRIM((string)capU(le.professional_license.proflic_count12, capZero, cap255));
	self.ProfLicCount24 := TRIM((string)capU(le.professional_license.proflic_count24, capZero, cap255));
	self.ProfLicCount36 := TRIM((string)capU(le.professional_license.proflic_count36, capZero, cap255));
	self.ProfLicCount60 := TRIM((string)capU(le.professional_license.proflic_count60, capZero, cap255));
	self.ProfLicExpireCount30 := TRIM((string)capU(le.professional_license.expire_count30, capZero, cap255));
	self.ProfLicExpireCount90 := TRIM((string)capU(le.professional_license.expire_count90, capZero, cap255));
	self.ProfLicExpireCount180 := TRIM((string)capU(le.professional_license.expire_count180, capZero, cap255));
	self.ProfLicExpireCount12 := TRIM((string)capU(le.professional_license.expire_count12, capZero, cap255));
	self.ProfLicExpireCount24 := TRIM((string)capU(le.professional_license.expire_count24, capZero, cap255));
	self.ProfLicExpireCount36 := TRIM((string)capU(le.professional_license.expire_count36, capZero, cap255));
	self.ProfLicExpireCount60 := TRIM((string)capU(le.professional_license.expire_count60, capZero, cap255));
	
// Higher Risk Address and Phone Attributes																
	self.InputAddrHighRisk := checkboolean( le.iid.hriskaddrflag = '4' );
	self.InputPhoneHighRisk := checkboolean( le.iid.hriskphoneflag = '6' );
	self.sic := TRIM(capS(MAP(le.iid.addrcommflag = '1' => RiskWise.convertSIC(le.iid.hrisksicphone),
													 le.iid.addrcommflag = '2' => RiskWise.convertSIC(le.iid.hrisksic),
													 ''), capZero, 9999));
	self.InputAddrPrison := checkboolean( le.iid.hriskaddrflag='4' AND le.iid.hrisksic = '2225' );
	self.InputZipPOBox := checkboolean( le.iid.zipclass='P' );
	self.InputZipCorpMil := checkboolean( le.iid.zipclass in ['M','U'] );
	self.InputphoneStatus := map(le.iid.phonedissflag and le.input_validation.homephone => 'D',
																	 le.iid.phonevalflag in ['1','2'] or (le.iid.phonevalflag = '3' and le.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																	 '');
	self.InputPhonePager := checkboolean( le.iid.hriskphoneflag = '2' );
	self.InputPhoneMobile := checkboolean( le.iid.hriskphoneflag = '1' );
	self.InvalidPhoneZip := checkboolean( le.iid.phonezipflag = '1' );
	self.InputPhoneAddrDist := TRIM((string)if(le.iid.disthphoneaddr > default_no_distance, cap4byte, le.iid.disthphoneaddr));
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
	self.TimeSinceSubjectPhoneFirstSeen := TRIM((string)capU( months_apart(system_yearmonth, gong_ADL_first_seen_month), capZero, cap3Byte));
	self.TimeSinceSubjectPhoneLastSeen := TRIM((string)capU( months_apart(system_yearmonth, gong_ADL_last_seen_month), capZero, cap3Byte));
	
	// default someone to 0 until proven otherwise
	self.DoNotMail := '0';
	
	self.clam := le;
	self.version3 := [];
	self.version4 := [];
end;

p := project(clam_with_Easi, map_fields(left));

// output(clam_with_Easi, named('clam_with_Easi'));  // for debugging






renameField( v1_name, v3_name, blank_condition=false, null_9999_condition = FALSE ) := MACRO
	self.v1_name := ''; // blank out the field no longer used (not -1)
	// copy the old value to the new location; convert blank null values to -1
	self.version3.v3_name := if(trim(le.v1_name) IN IF(null_9999_condition, ['', '9999'], ['']) or blank_condition, '-1', le.v1_name );
ENDMACRO;

string calcMonths( integer sysDt, string someDt, integer cap ) := (string)MIN( cap, months_apart( sysDt, (unsigned)someDt ));

// some v1 fields were YYYYMM values, and their updated v3 values are months since instead.
YYYYMM_to_months( v1_name, v3_name, blank_condition=false, cap=9998 ) := MACRO
	self.version3.v3_name := if( trim(le.v1_name) in ['','0'] or blank_condition, '-1', TRIM(calcMonths(sysdate,le.v1_name,cap)));
	self.v1_name := '';
ENDMACRO;

Null_V3( v1_name, blank_condition=false, null_9999_condition = FALSE ) := MACRO
	self.v1_name := if( blank_condition or trim(le.v1_name) IN IF(null_9999_condition, ['', '9999'], ['']), '-1', TRIM(le.v1_name) );
ENDMACRO;
maxout( v ) := MACRO if(v=0, 999999, v) ENDMACRO;

working_layout map_fields_v3( working_layout le ) := TRANSFORM
	// Version 3
	getMin(string l, string r) := IF((unsigned)l < (unsigned)r, l, r);	// get smaller number
	cap150 := 150;
	cap960 := 960;
	capNull := -1;
	
	sysdate := if(le.clam.historydate <> 999999, (integer)(((string)le.clam.historydate)[1..6]), (integer)(((STRING8)Std.Date.Today())[1..6]));


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
	self.version3.PhoneOtherAgeOldestRecord := TRIM(if(le.clam.infutor.infutor_date_first_seen=0, '-1', capS((string)round((ut.DaysApart((string)le.clam.infutor.infutor_date_first_seen, (string)sysdate)) / 30), capNull, cap960)));
	self.version3.PhoneOtherAgeNewestRecord := TRIM(if(le.clam.infutor.infutor_date_last_seen=0,  '-1', capS((string)round((ut.DaysApart((string)le.clam.infutor.infutor_date_last_seen,  (string)sysdate)) / 30), capNull, cap960)));


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
	self.version3.SubPrimeSolicitedCount   := TRIM((string3)capU(le.clam.impulse.count, capZero, cap255));
	self.version3.SubPrimeSolicitedCount01 := TRIM((string3)capU(le.clam.impulse.count30, capZero, cap255));
	self.version3.SubprimeSolicitedCount03 := TRIM((string3)capU(le.clam.impulse.count90, capZero, cap255));
	self.version3.SubprimeSolicitedCount06 := TRIM((string3)capU(le.clam.impulse.count180, capZero, cap255));
	self.version3.SubPrimeSolicitedCount12 := TRIM((string3)capU(le.clam.impulse.count12, capZero, cap255));
	self.version3.SubPrimeSolicitedCount24 := TRIM((string3)capU(le.clam.impulse.count24, capZero, cap255));
	self.version3.SubPrimeSolicitedCount36 := TRIM((string3)capU(le.clam.impulse.count36, capZero, cap255));
	self.version3.SubPrimeSolicitedCount60 := TRIM((string3)capU(le.clam.impulse.count60, capZero, cap255));
	

	// Predicted Income Attributes
	self.version3.PredictedAnnualIncome := TRIM((string)capU(le.clam.estimated_income, capZero, 250999));

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



	self.version3.RelativesCount             := TRIM((string)capU(le.clam.relatives.relative_count, capZero, cap255));
	self.version3.RelativesBankruptcyCount   := TRIM((string)capU( le.clam.relatives.relative_bankrupt_count, capZero, cap255));
	self.version3.RelativesFelonyCount       := TRIM((string)capU( le.clam.relatives.relative_felony_count, capZero, cap255));
	self.version3.RelativesPropOwnedCount    := TRIM((string)capU( le.clam.relatives.owned.relatives_property_count, capZero, cap255));
	self.version3.RelativesPropOwnedTaxTotal := TRIM(if(le.clam.relatives.owned.relatives_property_owned_assessed_total=0, '-1', capS((string)le.clam.relatives.owned.relatives_property_owned_assessed_total, capNull, cap13Byte)));
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

		IAAutomatedValuation    := capU(le.clam.avm.input_address_information.avm_automated_valuation, capZero, cap10Byte);
		IACountyMedianValuation := capU(le.clam.avm.input_address_information.avm_median_fips_level, capZero, cap10byte);
		IATractMedianValuation  := capU(le.clam.avm.input_address_information.avm_median_geo11_level, capZero, cap10byte);
		IABlockMedianValuation  := capU(le.clam.avm.input_address_information.avm_median_geo12_level, capZero, cap10byte);
		self.InputAddrCountyIndex := TRIM(map( noAddr => '-1', IACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IACountyMedianValuation)), decimal_length)));
		self.InputAddrTractIndex  := TRIM(map( noAddr => '-1', IATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IATractMedianValuation)), decimal_length)));
		self.InputAddrBlockIndex  := TRIM(map( noAddr => '-1', IABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,IAAutomatedValuation/IABlockMedianValuation)), decimal_length)));
		Null_v3(InputAddrCurrAddrDistance, noAddr or CAAddrChooser=0, TRUE);
		Null_v3(InputAddrCurrAddrAssessedDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrIncomeDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrHomeValDiff, noAddr or CAAddrChooser=0);
		// Null_v3(InputAddrCurrAddrCrimeDiff, noAddr or CAAddrChooser=0);
		self.InputAddrCurrAddrIncomeDiff  := if( noAddr or CAAddrChooser=0, '-1', TRIM((string)(integer)le.InputAddrCurrAddrIncomeDiff));
		self.InputAddrCurrAddrHomeValDiff := if( noAddr or CAAddrChooser=0, '-1', TRIM((string)(integer)le.InputAddrCurrAddrHomeValDiff));
		self.InputAddrCurrAddrCrimeDiff   := if( noAddr or CAAddrChooser=0, '-1', TRIM((string)(integer)le.InputAddrCurrAddrCrimeDiff));
		Null_v3(EconomicTrajectory, noAddr or 0=CAAddrChooser);
		Null_v3(EconomicTrajectory2, 0 in [CAAddrChooser,PAAddrChooser]);
		Null_v3(InputAddrConfScore, noAddr);
		Null_v3(InputAddrTaxAssessVal, noAddr);
		Null_v3(InputAddrAssessedValue, noAddr);
		Null_v3(InputAddrTaxAssessedYr, noAddr);

		self.CurrAddrPrevAddrIncomeDiff  := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', TRIM((string)(integer)le.CurrAddrPrevAddrIncomeDiff));
		self.CurrAddrPrevAddrHomeValDiff := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', TRIM((string)(integer)le.CurrAddrPrevAddrHomeValDiff));
		self.CurrAddrPrevAddrCrimeDiff   := if( PAAddrChooser=0 or CAAddrChooser=0, '-1', TRIM((string)(integer)le.CurrAddrPrevAddrCrimeDiff));
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

		phonefound := le.TimeSinceSubjectPhoneFirstSeen<>'0' or le.TimeSinceSubjectPhoneLastSeen<>'0';
		self.TimeSinceSubjectPhoneFirstSeen := if(le.TimeSinceSubjectPhoneFirstSeen='0', '-1', TRIM((string)capU((unsigned)le.TimeSinceSubjectPhoneFirstSeen, capZero, cap960)));
		self.TimeSinceSubjectPhoneLastSeen  := if(not phoneFound, '-1',  TRIM((string)capU((unsigned)le.TimeSinceSubjectPhoneLastSeen, capZero, cap960)));

	/* */
		system_yearmonth_hdrbldDate := if(le.clam.historydate = risk_indicators.iid_constants.default_history_date, le.clam.header_summary.header_build_date, le.clam.historydate);

	/* Other null values: */
		self.SubjectFirstSeen := '';
		hfs := fixYYYY00(if(le.clam.historydate = 999999, checkHdrBldDate(le.clam.ssn_verification.header_first_seen, le.clam.header_summary.header_build_date), le.clam.ssn_verification.header_first_seen));
		cfs := fixYYYY00(if(le.clam.historydate = 999999, checkHdrBldDate(le.clam.ssn_verification.credit_first_seen, le.clam.header_summary.header_build_date), le.clam.ssn_verification.credit_first_seen));
		fsDate := map(
			hfs = 0 and cfs = 0 => -1,
			hfs = 0             => cfs,
			            cfs = 0 => hfs,
			ut.min2(hfs,cfs)
		);
		self.Version3.AgeOldestRecord := if( fsdate=-1, '-1', TRIM((string)capU(months_apart(system_yearmonth_hdrbldDate, fsdate ), capAtOne, cap960)));
		
		
		hls := fixYYYY00(if(le.clam.historydate = 999999,checkHdrBldDate(le.clam.ssn_verification.header_last_seen, le.clam.header_summary.header_build_date), le.clam.ssn_verification.header_last_seen));
		cls := fixYYYY00(if(le.clam.historydate = 999999,checkHdrBldDate(le.clam.ssn_verification.credit_last_seen, le.clam.header_summary.header_build_date), le.clam.ssn_verification.credit_last_seen));
		lsDate := map(
			hls = 0 and cls = 0 => -1,
			hls = 0             => cls,
			cls = 0 						=> hls,
			MAX(hls,cls)
		);

		self.DateLastUpdate := '';
		self.Version3.AgeNewestRecord := if( lsdate=-1, '-1', TRIM((string)capU(months_apart( system_yearmonth_hdrbldDate, lsdate), capAtOne, cap960)));
		
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
		system_yearmonth := if(le.clam.historydate = risk_indicators.iid_constants.default_history_date, (integer)(((STRING8)Std.Date.Today())[1..6]), le.clam.historydate);
				
		IADateFirstReported := fixYYYY00((unsigned)checkDate6(le.clam.address_verification.input_address_information.date_first_seen));
		IADateLastReported := fixYYYY00((unsigned)checkDate6(le.clam.address_verification.input_address_information.date_last_seen));
														
		IADateFirstReportedV3 := if(le.clam.historydate = 999999, checkHdrBldDate(IADateFirstReported, le.clam.header_summary.header_build_date), IADateFirstReported);
	
	  IADateLastReportedV3  := if(le.clam.historydate = 999999, checkHdrBldDate(IADateLastReported, le.clam.header_summary.header_build_date), IADateLastReported);
													
		TimeSinceInputAddrFirstSeen := if( noAddr or le.clam.address_verification.input_address_information.date_first_seen=0, '-1', 
																							TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, IADateFirstReportedV3), capAtOne, cap960)));		
		
		self.TimeSinceInputAddrFirstSeen := TimeSinceInputAddrFirstSeen;
		
		TimeSinceInputAddrLastSeen  := if( noAddr or le.clam.address_verification.input_address_information.date_last_seen =0, '-1', 
																					TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, IADateLastReportedV3), capAtOne, cap960)));
		
		self.TimeSinceInputAddrLastSeen  := 	TimeSinceInputAddrLastSeen;																			
		TrueTimeSinceIAFirstSeen :=  if( noAddr or le.clam.address_verification.input_address_information.date_first_seen=0, -1, months_apart(system_yearmonth_hdrbldDate, IADateFirstReportedV3));
		self.InputAddrLenOfRes := if(IADateFirstReported=0 or IADateLastReported = 0, '-1', TRIM((string)capI((integer)TrueTimeSinceIAFirstSeen - (integer)TimeSinceInputAddrLastSeen,capAtone, cap960)));

		renameField( InputAddrDwellType, InputAddrDwellType, le.InputAddrDwellType='0' or noAddr );
		renameField( InputAddrLandUseCode, InputAddrLandUseCode, noAddr );
		self.InputAddrLastSalesDate	:= '';
		self.version3.InputAddrAgeLastSale := if( noAddr or le.InputAddrLastSalesDate='0', '-1', TRIM(capS(calcMonths( sysdate, le.InputAddrLastSalesDate, 960 ), capZero, cap960)));
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
			CADateFirstReported := fixYYYY00((unsigned)checkDate6(
				map(CAaddrChooser=1 => le.clam.address_verification.input_address_information.date_first_seen,
					CAaddrChooser=2 => le.clam.address_verification.address_history_1.date_first_seen,
					le.clam.address_verification.address_history_2.date_first_seen) ));
			CADateLastReported := fixYYYY00((unsigned)checkDate6(
				map(CAaddrChooser=1 => le.clam.address_verification.input_address_information.date_last_seen,
					CAaddrChooser=2 => le.clam.address_verification.address_history_1.date_last_seen,
					le.clam.address_verification.address_history_2.date_last_seen) ));
			
			CADateFirstReportedV3 := if(le.clam.historydate = 999999, checkHdrBldDate(CADateFirstReported, le.clam.header_summary.header_build_date), CADateFirstReported);
	
	    CADateLastReportedV3  := if(le.clam.historydate = 999999, checkHdrBldDate(CADateLastReported, le.clam.header_summary.header_build_date), CADateLastReported);
			trueCATimeSinceFirstSeen := months_apart(system_yearmonth_hdrbldDate, CADateFirstReportedV3)	;		
			TimeSinceCurrAddrFirstSeen := if( CADateFirstReportedV3=0 or CAAddrChooser=0, '-1', TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, CADateFirstReportedV3), capAtOne, cap960)));
			TimeSinceCurrAddrLastSeen  := if( CADateLastReportedV3=0  or CAAddrChooser=0, '-1', TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, CADateLastReportedV3), capAtOne, cap960)));

		self.TimeSinceCurrAddrFirstSeen := TimeSinceCurrAddrFirstSeen;
		self.TimeSinceCurrAddrLastSeen  := TimeSinceCurrAddrLastSeen;
	
	// cap at 960

		self.CurrAddrLenOfRes  := if(CAAddrChooser=0, '-1', TRIM((string)capI((integer)trueCATimeSinceFirstSeen -(integer)TimeSinceCurrAddrLastSeen, capAtone, cap960)));

			self.CurrAddrLastSalesDate	:= '';
			self.version3.CurrAddrAgeLastSale := if( le.CurrAddrLastSalesDate='0', '-1', TRIM(capS(calcMonths( sysdate, le.CurrAddrLastSalesDate, 960 ), capZero, cap960)));
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
			CACountyMedianValuation := MIN(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_fips_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_fips_level,
																le.clam.avm.address_history_2.avm_median_fips_level)
																						, cap10byte);
			CATractMedianValuation := MIN(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo11_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo11_level,
																le.clam.avm.address_history_2.avm_median_geo11_level)
																						, cap10byte);
			CABlockMedianValuation := MIN(map(CAaddrChooser=0 => 0,
																CAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo12_level,
																CAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo12_level,
																le.clam.avm.address_history_2.avm_median_geo12_level)
																						, cap10byte);
			self.CurrAddrCountyIndex := TRIM(map( CAAddrChooser=0 => '-1', CACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CACountyMedianValuation)), decimal_length)));
			self.CurrAddrTractIndex  := TRIM(map( CAAddrChooser=0 => '-1', CATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CATractMedianValuation)), decimal_length)));
			self.CurrAddrBlockIndex  := TRIM(map( CAAddrChooser=0 => '-1', CABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,CAAutomatedValuation/CABlockMedianValuation)), decimal_length)));

			Null_v3(CurrAddrMedianIncome, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrMedianHomeVal, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrMurderIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrCarTheftIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrBurglaryIndex, CAAddrChooser=0 or CAEasi.geolink='');
			Null_v3(CurrAddrCrimeIndex, CAAddrChooser=0 or CAEasi.geolink='');
		//

		// prev addr attribs
			PADateFirstReported := fixYYYY00((unsigned)checkDate6(map(PAaddrChooser=1 => le.clam.address_verification.input_address_information.date_first_seen,
				PAaddrChooser=2 =>	le.clam.address_verification.address_history_1.date_first_seen,
				PAaddrChooser=3 => le.clam.address_verification.address_history_2.date_first_seen,
				0) ));
			PADateLastReported := fixYYYY00((unsigned)checkDate6(map(PAaddrChooser=1 => le.clam.address_verification.input_address_information.date_last_seen,
				PAaddrChooser=2 => le.clam.address_verification.address_history_1.date_last_seen,
				PAaddrChooser=3 => le.clam.address_verification.address_history_2.date_last_seen,
				0)));
				
			PADateFirstReportedV3 := if(le.clam.historydate = 999999, checkHdrBldDate(PADateFirstReported, le.clam.header_summary.header_build_date), PADateFirstReported);
	
			PADateLastReportedV3  := if(le.clam.historydate = 999999, checkHdrBldDate(PADateLastReported, le.clam.header_summary.header_build_date), PADateLastReported);
						

			TimeSincePrevAddrFirstSeen := if( PADateFirstReportedV3=0 or PAAddrChooser=0, '-1', TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, PADateFirstReportedV3), capAtOne, cap960)));
			self.TimeSincePrevAddrFirstSeen := TimeSincePrevAddrFirstSeen;
			
			truePATimeSinceFirstSeen := months_apart(system_yearmonth_hdrbldDate, PADateFirstReportedV3)	;		

			TimeSincePrevAddrLastSeen  := if( PADateLastReportedV3=0  or PAAddrChooser=0, '-1', TRIM((string)capU( months_apart(system_yearmonth_hdrbldDate, PADateLastReportedV3), capAtOne, cap960)));
			self.TimeSincePrevAddrLastSeen  :=  TimeSincePrevAddrLastSeen;

			self.PrevAddrLenOfRes  := 	 if(PAAddrChooser=0 or PADateLastReported=0, '-1',TRIM((string)capI((integer)truePATimeSinceFirstSeen -(integer)TimeSincePrevAddrLastSeen, capAtone, cap960)));
																		
			self.PrevAddrLastSalesDate	:= '';
			self.version3.PrevAddrAgeLastSale := if( le.PrevAddrLastSalesDate='0', '-1', TRIM(capS(calcMonths( sysdate, le.PrevAddrLastSalesDate, 960 ), capZero, cap960)));
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
			
			PACountyMedianValuation := MIN(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_fips_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_fips_level,
																le.clam.avm.address_history_2.avm_median_fips_level)
																						, cap10byte);
			PATractMedianValuation := MIN(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo11_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo11_level,
																le.clam.avm.address_history_2.avm_median_geo11_level)
																						, cap10byte);
			PABlockMedianValuation := MIN(map(PAaddrChooser=0 => 0,
																PAaddrChooser=1 => le.clam.avm.input_address_information.avm_median_geo12_level,
																PAaddrChooser=2 => le.clam.avm.address_history_1.avm_median_geo12_level,
																le.clam.avm.address_history_2.avm_median_geo12_level)
																						, cap10byte);
			self.PrevAddrCountyIndex := TRIM(map( PAAddrChooser=0 => '-1', PACountyMedianValuation=0 => '0', formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PACountyMedianValuation)), decimal_length)));
			self.PrevAddrTractIndex  := TRIM(map( PAAddrChooser=0 => '-1', PATractMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PATractMedianValuation)), decimal_length)));
			self.PrevAddrBlockIndex  := TRIM(map( PAAddrChooser=0 => '-1', PABlockMedianValuation=0 => '0',  formatdecimalstring(max(0.1,min(99,PAAutomatedValuation/PABlockMedianValuation)), decimal_length)));


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

	le_clam := row( le.clam, risk_indicators.Layout_Boca_Shell );
	attr_master := models.Attributes_Master( le_clam, false );

	self.version3.PrevAddrPrison := attr_master.PrevAddrCorrectional;
	self.version3.HistoricalAddrPrison := attr_master.HistoricalAddrCorrectional;

	
	// 0-255 fields in v3 that were 0-99 in v1
	numsources := map(
		CAaddrChooser=0 => 0,
		CAaddrChooser=1 => le.clam.address_verification.input_address_information.source_count,
		CAaddrChooser=2 => le.clam.address_verification.address_history_1.source_count,
		le.clam.address_verification.address_history_2.source_count
	);

	update255( v1, v3, val ) := MACRO
		self.v1 := '';
		self.version3.v3 := TRIM((string)capU(val, capZero, cap255));
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

	self.TimeSinceLastName := if(le.clam.name_verification.newest_lname_dt_first_seen>le.clam.historyDate, '-1', TRIM((string)capU((unsigned)le.TimeSinceLastName, capZero, cap960))); // aka v3.LastNameChangeAge
	update255( LastNames30,               LastNameChangeCount01,          le.clam.velocity_counters.lnames_per_adl30 );
	update255( LastNames90,               LastNameChangeCount03,          le.clam.velocity_counters.lnames_per_adl90 );
	update255( LastNames180,              LastNameChangeCount06,          le.clam.velocity_counters.lnames_per_adl180 );
	update255( LastNames12,               LastNameChangeCount12,          le.clam.velocity_counters.lnames_per_adl12 );
	update255( LastNames24,               LastNameChangeCount24,          le.clam.velocity_counters.lnames_per_adl24 );
	update255( LastNames36,               LastNameChangeCount36,          le.clam.velocity_counters.lnames_per_adl36 );
	update255( LastNames60,               LastNameChangeCount60,          le.clam.velocity_counters.lnames_per_adl60 );

	self.IDPerSFDUAddr  := '';
	self.version3.SFDUAddrIdentitiesCount := if(le.clam.address_validation.error_codes[1]='S', TRIM((string)capU(le.clam.velocity_counters.adls_per_addr, capZero, cap255)), '-1' );
	self.SSNPerSFDUAddr := '';
	self.version3.SFDUAddrSSNCount        := if(le.clam.address_validation.error_codes[1]='S', TRIM((string)capU(le.clam.velocity_counters.ssns_per_addr, capZero, cap255)), '-1' );

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
	
	self.version3.CreditBureauRecord := IF((StringLib.StringContains(le.clam.iid.sources, MDR.sourceTools.src_Experian_Credit_Header, TRUE) OR
																				StringLib.StringContains(le.clam.iid.sources, MDR.sourceTools.src_Equifax, TRUE)), '1', '0');
	
	// removed attributes
	self.CurrAddrNotPrimaryRes := '';
	self.PrevAddrNotPrimaryRes := '';
	self.TimeSincePrevAddrDateFirstSeen := '';
	self.TimeSinceNextPrevDateFirstSeen := '';

	self := le;
end;

p3 := project(p, map_fields_v3(left) );


working_layout addInquiries( working_layout le, Risk_Indicators.Key_Inquiry_Table_DID ri ) := TRANSFORM
	self.version3.PRSearchCollectionCount    := TRIM((string3)capU(ri.Collection.CountTotal, capZero, cap255));
	self.version3.PRSearchCollectionCount01  := TRIM((string3)capU(ri.Collection.Count01, capZero, cap255));
	self.version3.PRSearchCollectionCount03  := TRIM((string3)capU(ri.Collection.Count03, capZero, cap255));
	self.version3.PRSearchCollectionCount06  := TRIM((string3)capU(ri.Collection.Count06, capZero, cap255));
	self.version3.PRSearchCollectionCount12  := TRIM((string3)capU(ri.Collection.Count12, capZero, cap255));
	self.version3.PRSearchCollectionCount24  := TRIM((string3)capU(ri.Collection.Count24, capZero, cap255));
	self.version3.PRSearchCollectionCount36  := TRIM((string3)capU(ri.Collection.Count36, capZero, cap255));
	self.version3.PRSearchCollectionCount60  := TRIM((string3)capU(ri.Collection.Count60, capZero, cap255));
	self.version3.PRSearchIDVFraudCount      := TRIM((string3)capU(ri.AccountOpen.CountTotal, capZero, cap255));
	self.version3.PRSearchIDVFraudCount01    := TRIM((string3)capU(ri.AccountOpen.Count01, capZero, cap255));
	self.version3.PRSearchIDVFraudCount03    := TRIM((string3)capU(ri.AccountOpen.Count03, capZero, cap255));
	self.version3.PRSearchIDVFraudCount06    := TRIM((string3)capU(ri.AccountOpen.Count06, capZero, cap255));
	self.version3.PRSearchIDVFraudCount12    := TRIM((string3)capU(ri.AccountOpen.Count12, capZero, cap255));
	self.version3.PRSearchIDVFraudCount24    := TRIM((string3)capU(ri.AccountOpen.Count24, capZero, cap255));
	self.version3.PRSearchIDVFraudCount36    := TRIM((string3)capU(ri.AccountOpen.Count36, capZero, cap255));
	self.version3.PRSearchIDVFraudCount60    := TRIM((string3)capU(ri.AccountOpen.Count60, capZero, cap255));
	self.version3.PRSearchOtherCount         := TRIM((string3)capU(ri.Other.CountTotal, capZero, cap255));
	self.version3.PRSearchOtherCount01       := TRIM((string3)capU(ri.Other.Count01, capZero, cap255));
	self.version3.PRSearchOtherCount03       := TRIM((string3)capU(ri.Other.Count03, capZero, cap255));
	self.version3.PRSearchOtherCount06       := TRIM((string3)capU(ri.Other.Count06, capZero, cap255));
	self.version3.PRSearchOtherCount12       := TRIM((string3)capU(ri.Other.Count12, capZero, cap255));
	self.version3.PRSearchOtherCount24       := TRIM((string3)capU(ri.Other.Count24, capZero, cap255));
	self.version3.PRSearchOtherCount36       := TRIM((string3)capU(ri.Other.Count36, capZero, cap255));
	self.version3.PRSearchOtherCount60       := TRIM((string3)capU(ri.Other.Count60, capZero, cap255));

	self := le;
END;

p3_inq := join( p3, Risk_Indicators.Key_Inquiry_Table_DID, keyed(left.clam.did=right.did), addInquiries(left,right), left outer, keep(1));


fn_format_InputAddrMobilityIndex(STRING indexValue) := FUNCTION
  indexValue_temp := TRIM((STRING)capR((REAL)indexValue, -1.0, 99.0), ALL)[1..3];
  RETURN IF( indexValue_temp[3] = '.', indexValue_temp[1..2], indexValue_temp); // for RQ-16680 "Remove extra decimal..."
END;

working_layout map_fields_v4( working_layout le ) := TRANSFORM
	self.seq    := le.seq;
	self.acctno := le.acctno;
	self.did := le.did;
	le_clam := row( le.clam, risk_indicators.Layout_Boca_Shell );
	attr := models.Attributes_Master(le_clam, false, le.clam.inEasi, le.clam.easi1, le.clam.easi2);

	self.version4.AgeOldestRecord                      := attr.AgeOldestRecord_buildDate;
	self.version4.AgeNewestRecord                      := attr.AgeNewestRecord_buildDate;
	self.version4.RecentUpdate                         := attr.RecentUpdate_buildDate;
	self.version4.SrcsConfirmIDAddrCount               := attr.SrcsConfirmIDAddrCount;
	self.version4.CreditBureauRecord                   := le.Version3.CreditBureauRecord;
	self.version4.VerificationFailure                  := attr.VerificationFailure;
	self.version4.SSNNotFound                          := attr.SSNNotFound;
	self.version4.SSNFoundOther                        := le.Version3.SSNFoundOther;
	self.version4.VerifiedName                         := attr.VerifiedName;
	self.version4.VerifiedSSN                          := attr.VerifiedSSN;
	self.version4.VerifiedPhone                        := attr.VerifiedPhone;
	self.version4.VerifiedAddress                      := attr.VerifiedAddress;
	self.version4.VerifiedDOB                          := attr.VerifiedDOB;
	self.version4.AgeRiskIndicator                     := le.AgeRiskIndicator;
	self.version4.SubjectSSNCount                      := attr.SubjectSSNCount;
	self.version4.SubjectAddrCount                     := attr.SubjectAddrCount;
	self.version4.SubjectPhoneCount                    := attr.SubjectPhoneCount;
	self.version4.SubjectSSNRecentCount                := attr.SubjectSSNRecentCount;
	self.version4.SubjectAddrRecentCount               := attr.SubjectAddrRecentCount;
	self.version4.SubjectPhoneRecentCount              := attr.SubjectPhoneRecentCount;
	self.version4.SSNIdentitiesCount                   := attr.SSNIdentitiesCount;
	self.version4.SSNAddrCount                         := attr.SSNAddrCount;
	self.version4.SSNIdentitiesRecentCount             := attr.SSNIdentitiesRecentCount;
	self.version4.SSNAddrRecentCount                   := attr.SSNAddrRecentCount;
	self.version4.InputAddrPhoneCount                  := attr.InputAddrPhoneCount;
	self.version4.InputAddrPhoneRecentCount            := attr.InputAddrPhoneRecentCount;
	self.version4.PhoneIdentitiesCount                 := attr.PhoneIdentitiesCount;
	self.version4.PhoneIdentitiesRecentCount           := attr.PhoneIdentitiesRecentCount;
	self.version4.PhoneOther                           := le.Version3.PhoneOther;
	self.version4.SSNLastNameCount                     := le.Version3.SSNLastNameCount;
	self.version4.SubjectLastNameCount                 := le.Version3.SubjectLastNameCount;
	self.version4.LastNameChangeAge                    := le.TimeSinceLastName;
	self.version4.LastNameChangeCount01                := le.Version3.LastNameChangeCount01;
	self.version4.LastNameChangeCount03                := le.Version3.LastNameChangeCount03;
	self.version4.LastNameChangeCount06                := le.Version3.LastNameChangeCount06;
	self.version4.LastNameChangeCount12                := le.Version3.LastNameChangeCount12;
	self.version4.LastNameChangeCount24                := le.Version3.LastNameChangeCount24;
	self.version4.LastNameChangeCount60                := le.Version3.LastNameChangeCount60;
	self.version4.SFDUAddrIdentitiesCount              := le.Version3.SFDUAddrIdentitiesCount;
	self.version4.SFDUAddrSSNCount                     := le.Version3.SFDUAddrSSNCount;
	self.version4.SSNAgeDeceased                       := attr.SSNAgeDeceased;
	self.version4.SSNRecent                            := attr.SSNRecent;
	self.version4.SSNLowIssueAge                       := attr.SSNLowIssueAge;
	self.version4.SSNHighIssueAge                      := attr.SSNHighIssueAge;
	self.version4.SSNIssueState                        := attr.SSNIssueState;
	self.version4.SSNNonUS                             := attr.SSNNonUS;
	self.version4.SSN3Years                            := attr.SSN3Years;
	self.version4.SSNAfter5                            := attr.SSNAfter5;
	self.version4.SSNProblems                          := attr.SSNProblems;
	self.version4.RelativesCount                       := le.Version3.RelativesCount;
	self.version4.RelativesBankruptcyCount             := le.Version3.RelativesBankruptcyCount;
	self.version4.RelativesFelonyCount                 := le.Version3.RelativesFelonyCount;
	self.version4.RelativesPropOwnedCount              := le.Version3.RelativesPropOwnedCount;
	self.version4.RelativesPropOwnedTaxTotal           := attr.RelativesPropOwnedTaxTotal;
	self.version4.RelativesDistanceClosest             := le.Version3.RelativesDistanceClosest;
	self.version4.InputAddrAgeOldestRecord             := attr.InputAddrAgeOldestRecord_buildDate;
	self.version4.InputAddrAgeNewestRecord             := attr.InputAddrAgeNewestRecord_buildDate;
	self.version4.InputAddrHistoricalMatch             := attr.InputAddrHistoricalMatch;
	self.version4.InputAddrLenOfRes                    := attr.InputAddrLenOfRes_buildDate;
	self.version4.InputAddrDwellType                   := attr.InputAddrDwellType;
	self.version4.InputAddrDelivery                    := attr.InputAddrDelivery;
	self.version4.InputAddrApplicantOwned              := attr.InputAddrApplicantOwned;
	self.version4.InputAddrFamilyOwned                 := attr.InputAddrFamilyOwned;
	self.version4.InputAddrOccupantOwned               := attr.InputAddrOccupantOwned;
	self.version4.InputAddrAgeLastSale                 := attr.InputAddrAgeLastSale;
	self.version4.InputAddrLastSalesPrice              := attr.InputAddrLastSalesPrice;
	self.version4.InputAddrMortgageType                := attr.InputAddrMortgageType;
	self.version4.InputAddrNotPrimaryRes               := attr.InputAddrNotPrimaryRes;
	self.version4.InputAddrActivePhoneList             := attr.InputAddrActivePhoneList;
	self.version4.InputAddrTaxValue                    := attr.InputAddrTaxValue;
	self.version4.InputAddrTaxYr                       := attr.InputAddrTaxYr;
	self.version4.InputAddrTaxMarketValue              := attr.InputAddrTaxMarketValue;
	self.version4.InputAddrAVMValue                    := attr.InputAddrAVMValue;
	self.version4.InputAddrAVMValue12                  := attr.InputAddrAVMValue12;
	self.version4.InputAddrAVMValue60                  := attr.InputAddrAVMValue60;
	self.version4.InputAddrCountyIndex                 := attr.InputAddrCountyIndex;
	self.version4.InputAddrTractIndex                  := attr.InputAddrTractIndex;
	self.version4.InputAddrBlockIndex                  := attr.InputAddrBlockIndex;
	self.version4.InputAddrMedianIncome                := attr.IACensus.MedianIncome;
	self.version4.InputAddrMedianValue                 := attr.IACensus.MedianValue;
	self.version4.InputAddrMurderIndex                 := le.InputAddrMurderIndex;
	self.version4.InputAddrCarTheftIndex               := le.InputAddrCarTheftIndex;
	self.version4.InputAddrBurglaryIndex               := le.InputAddrBurglaryIndex;
	self.version4.InputAddrCrimeIndex                  := le.InputAddrCrimeIndex;
	self.version4.InputAddrMobilityIndex               := fn_format_InputAddrMobilityIndex(attr.InputAddrMobilityIndex);
	self.version4.InputAddrVacantPropCount             := attr.InputAddrVacantPropCount;
	self.version4.InputAddrBusinessCount               := attr.InputAddrBusinessCount;
	self.version4.InputAddrSingleFamilyCount           := attr.InputAddrSingleFamilyCount;
	self.version4.InputAddrMultiFamilyCount            := attr.InputAddrMultiFamilyCount;
	self.version4.CurrAddrAgeOldestRecord              := attr.CurrAddrAgeOldestRecord_buildDate;
	self.version4.CurrAddrAgeNewestRecord              := attr.CurrAddrAgeNewestRecord_buildDate;
	self.version4.CurrAddrLenOfRes                     := attr.CurrAddrLenOfRes_buildDate;
	self.version4.CurrAddrDwellType                    := attr.CurrAddrDwellType;
	self.version4.CurrAddrApplicantOwned               := attr.CurrAddrApplicantOwned;
	self.version4.CurrAddrFamilyOwned                  := attr.CurrAddrFamilyOwned;
	self.version4.CurrAddrOccupantOwned                := attr.CurrAddrOccupantOwned;
	self.version4.CurrAddrAgeLastSale                  := attr.CurrAddrAgeLastSale;
	self.version4.CurrAddrLastSalesPrice               := attr.CurrAddrLastSalesPrice;
	self.version4.CurrAddrMortgageType                 := attr.CurrAddrMortgageType;
	self.version4.CurrAddrActivePhoneList              := attr.CurrAddrActivePhoneList;
	self.version4.CurrAddrTaxValue                     := attr.CurrAddrTaxValue;
	self.version4.CurrAddrTaxYr                        := attr.CurrAddrTaxYr;
	self.version4.CurrAddrTaxMarketValue               := attr.CurrAddrTaxMarketValue;
	self.version4.CurrAddrAVMValue                     := attr.CurrAddrAVMValue;
	self.version4.CurrAddrAVMValue12                   := attr.CurrAddrAVMValue12;
	self.version4.CurrAddrAVMValue60                   := attr.CurrAddrAVMValue60;
	self.version4.CurrAddrCountyIndex                  := attr.CurrAddrCountyIndex;
	self.version4.CurrAddrTractIndex                   := attr.CurrAddrTractIndex;
	self.version4.CurrAddrBlockIndex                   := attr.CurrAddrBlockIndex;
	self.version4.CurrAddrMedianIncome                 := attr.CACensus.MedianIncome;
	self.version4.CurrAddrMedianValue                  := attr.CACensus.MedianValue;
	self.version4.CurrAddrMurderIndex                  := le.CurrAddrMurderIndex;
	self.version4.CurrAddrCarTheftIndex                := le.CurrAddrCarTheftIndex;
	self.version4.CurrAddrBurglaryIndex                := le.CurrAddrBurglaryIndex;
	self.version4.CurrAddrCrimeIndex                   := le.CurrAddrCrimeIndex;
	self.version4.PrevAddrAgeOldestRecord              := attr.PrevAddrAgeOldestRecord_buildDate;
	self.version4.PrevAddrAgeNewestRecord              := attr.PrevAddrAgeNewestRecord_buildDate;
	self.version4.PrevAddrLenOfRes                     := attr.PrevAddrLenOfRes_buildDate;
	self.version4.PrevAddrDwellType                    := attr.PrevAddrDwellType;
	self.version4.PrevAddrApplicantOwned               := attr.PrevAddrApplicantOwned;
	self.version4.PrevAddrFamilyOwned                  := attr.PrevAddrFamilyOwned;
	self.version4.PrevAddrOccupantOwned                := attr.PrevAddrOccupantOwned;
	self.version4.PrevAddrAgeLastSale                  := attr.PrevAddrAgeLastSale;
	self.version4.PrevAddrLastSalesPrice               := attr.PrevAddrLastSalesPrice;
	self.version4.PrevAddrTaxValue                     := attr.PrevAddrTaxValue;
	self.version4.PrevAddrTaxYr                        := attr.PrevAddrTaxYr;
	self.version4.PrevAddrTaxMarketValue               := attr.PrevAddrTaxMarketValue;
	self.version4.PrevAddrAVMValue                     := attr.PrevAddrAVMValue;
	self.version4.PrevAddrCountyIndex                  := attr.PrevAddrCountyIndex;
	self.version4.PrevAddrTractIndex                   := attr.PrevAddrTractIndex;
	self.version4.PrevAddrBlockIndex                   := attr.PrevAddrBlockIndex;
	self.version4.PrevAddrMedianIncome                 := attr.PACensus.MedianIncome;
	self.version4.PrevAddrMedianValue                  := attr.PACensus.MedianValue;
	self.version4.PrevAddrMurderIndex                  := le.PrevAddrMurderIndex;
	self.version4.PrevAddrCarTheftIndex                := le.PrevAddrCarTheftIndex;
	self.version4.PrevAddrBurglaryIndex                := le.PrevAddrBurglaryIndex;
	self.version4.PrevAddrCrimeIndex                   := le.PrevAddrCrimeIndex;
	self.version4.AddrMostRecentDistance               := attr.AddrMostRecentDistance;
	self.version4.AddrMostRecentStateDiff              := attr.AddrMostRecentStateDiff;
	self.version4.AddrMostRecentTaxDiff                := attr.AddrMostRecentTaxDiff;
	self.version4.AddrMostRecentMoveAge                := attr.AddrMostRecentMoveAge_buildDate;
	self.version4.AddrMostRecentIncomeDiff             := attr.AddrMostRecentIncomeDiff;
	self.version4.AddrMostRecentValueDIff              := attr.AddrMostRecentValueDIff;
	self.version4.AddrMostRecentCrimeDiff              := attr.AddrMostRecentCrimeDiff;
	self.version4.AddrRecentEconTrajectory             := attr.AddrRecentEconTrajectory;
	self.version4.AddrRecentEconTrajectoryIndex        := attr.AddrRecentEconTrajectoryIndex;
	self.version4.EducationAttendedCollege             := attr.EducationAttendedCollege;
	self.version4.EducationProgram2Yr                  := attr.EducationProgram2Yr;
	self.version4.EducationProgram4Yr                  := attr.EducationProgram4Yr;
	self.version4.EducationProgramGraduate             := attr.EducationProgramGraduate;
	self.version4.EducationInstitutionPrivate          := attr.EducationInstitutionPrivate;
	self.version4.EducationInstitutionRating           := attr.EducationInstitutionRating;
	self.version4.EducationFieldofStudyType            := attr.EducationFieldofStudyType;
	self.version4.AddrStability                        := attr.AddrStability;
	self.version4.StatusMostRecent                     := attr.StatusMostRecent;
	self.version4.StatusPrevious                       := attr.StatusPrevious;
	self.version4.StatusNextPrevious                   := attr.StatusNextPrevious;
	self.version4.AddrChangeCount01                    := attr.AddrChangeCount01;
	self.version4.AddrChangeCount03                    := attr.AddrChangeCount03;
	self.version4.AddrChangeCount06                    := attr.AddrChangeCount06;
	self.version4.AddrChangeCount12                    := attr.AddrChangeCount12;
	self.version4.AddrChangeCount24                    := attr.AddrChangeCount24;
	self.version4.AddrChangeCount60                    := attr.AddrChangeCount60;
	self.version4.EstimatedAnnualIncome                := attr.EstimatedAnnualIncome;
	self.version4.AssetOwner                           := attr.AssetOwner;
	self.version4.PropertyOwner                        := attr.PropertyOwner;
	self.version4.PropOwnedCount                       := attr.PropOwnedCount;
	self.version4.PropOwnedTaxTotal                    := attr.PropOwnedTaxTotal;
	self.version4.PropOwnedHistoricalCount             := attr.PropOwnedHistoricalCount;
	self.version4.PropAgeOldestPurchase                := attr.PropAgeOldestPurchase;
	self.version4.PropAgeNewestPurchase                := attr.PropAgeNewestPurchase;
	self.version4.PropAgeNewestSale                    := attr.PropAgeNewestSale;
	self.version4.PropNewestSalePrice                  := attr.PropNewestSalePrice;
	self.version4.PropNewestSalePurchaseIndex          := attr.PropNewestSalePurchaseIndex;
	self.version4.PropPurchasedCount01                 := attr.PropPurchasedCount01;
	self.version4.PropPurchasedCount03                 := attr.PropPurchasedCount03;
	self.version4.PropPurchasedCount06                 := attr.PropPurchasedCount06;
	self.version4.PropPurchasedCount12                 := attr.PropPurchasedCount12;
	self.version4.PropPurchasedCount24                 := attr.PropPurchasedCount24;
	self.version4.PropPurchasedCount60                 := attr.PropPurchasedCount60;
	self.version4.PropSoldCount01                      := attr.PropSoldCount01;
	self.version4.PropSoldCount03                      := attr.PropSoldCount03;
	self.version4.PropSoldCount06                      := attr.PropSoldCount06;
	self.version4.PropSoldCount12                      := attr.PropSoldCount12;
	self.version4.PropSoldCount24                      := attr.PropSoldCount24;
	self.version4.PropSoldCount60                      := attr.PropSoldCount60;
	self.version4.WatercraftOwner                      := attr.WatercraftOwner;
	self.version4.WatercraftCount                      := attr.WatercraftCount;
	self.version4.WatercraftCount01                    := attr.WatercraftCount01;
	self.version4.WatercraftCount03                    := attr.WatercraftCount03;
	self.version4.WatercraftCount06                    := attr.WatercraftCount06;
	self.version4.WatercraftCount12                    := attr.WatercraftCount12;
	self.version4.WatercraftCount24                    := attr.WatercraftCount24;
	self.version4.WatercraftCount60                    := attr.WatercraftCount60;
	self.version4.AircraftOwner                        := attr.AircraftOwner;
	self.version4.AircraftCount                        := attr.AircraftCount;
	self.version4.AircraftCount01                      := attr.AircraftCount01;
	self.version4.AircraftCount03                      := attr.AircraftCount03;
	self.version4.AircraftCount06                      := attr.AircraftCount06;
	self.version4.AircraftCount12                      := attr.AircraftCount12;
	self.version4.AircraftCount24                      := attr.AircraftCount24;
	self.version4.AircraftCount60                      := attr.AircraftCount60;
	self.version4.WealthIndex                          := attr.WealthIndex;
	self.version4.BusinessActiveAssociation            := attr.BusinessActiveAssociation;
	self.version4.BusinessInactiveAssociation          := attr.BusinessInactiveAssociation;
	self.version4.BusinessAssociationAge               := attr.BusinessAssociationAge;
	self.version4.BusinessTitle                        := attr.BusinessTitle;
	self.version4.BusinessInputAddrCount               := attr.BusinessInputAddrCount;
	self.version4.DerogSeverityIndex                   := attr.DerogSeverityIndex;
	self.version4.DerogCount                           := attr.DerogCount;
	self.version4.DerogRecentCount                     := attr.DerogRecentCount;
	self.version4.DerogAge                             := attr.DerogAge;
	self.version4.FelonyCount                          := attr.FelonyCount;
	self.version4.FelonyAge                            := attr.FelonyAge;
	self.version4.FelonyCount01                        := attr.FelonyCount01;
	self.version4.FelonyCount03                        := attr.FelonyCount03;
	self.version4.FelonyCount06                        := attr.FelonyCount06;
	self.version4.FelonyCount12                        := attr.FelonyCount12;
	self.version4.FelonyCount24                        := attr.FelonyCount24;
	self.version4.FelonyCount60                        := attr.FelonyCount60;
	self.version4.ArrestCount                          := le.Version3.ArrestCount;
	self.version4.ArrestAge                            := le.Version3.ArrestAge;
	self.version4.ArrestCount01                        := le.Version3.ArrestCount01;
	self.version4.ArrestCount03                        := le.Version3.ArrestCount03;
	self.version4.ArrestCount06                        := le.Version3.ArrestCount06;
	self.version4.ArrestCount12                        := le.Version3.ArrestCount12;
	self.version4.ArrestCount24                        := le.Version3.ArrestCount24;
	self.version4.ArrestCount60                        := le.Version3.ArrestCount60;
	self.version4.LienCount                            := attr.LienCount;
	self.version4.LienFiledCount                       := attr.LienFiledCount;
	self.version4.LienFiledTotal                       := attr.LienFiledTotal;
	self.version4.LienFiledAge                         := attr.LienFiledAge;
	self.version4.LienFiledCount01                     := attr.LienFiledCount01;
	self.version4.LienFiledCount03                     := attr.LienFiledCount03;
	self.version4.LienFiledCount06                     := attr.LienFiledCount06;
	self.version4.LienFiledCount12                     := attr.LienFiledCount12;
	self.version4.LienFiledCount24                     := attr.LienFiledCount24;
	self.version4.LienFiledCount60                     := attr.LienFiledCount60;
	self.version4.LienReleasedCount                    := attr.LienReleasedCount;
	self.version4.LienReleasedTotal                    := attr.LienReleasedTotal;
	self.version4.LienReleasedAge                      := attr.LienReleasedAge;
	self.version4.LienReleasedCount01                  := attr.LienReleasedCount01;
	self.version4.LienReleasedCount03                  := attr.LienReleasedCount03;
	self.version4.LienReleasedCount06                  := attr.LienReleasedCount06;
	self.version4.LienReleasedCount12                  := attr.LienReleasedCount12;
	self.version4.LienReleasedCount24                  := attr.LienReleasedCount24;
	self.version4.LienReleasedCount60                  := attr.LienReleasedCount60;
	self.version4.BankruptcyCount                      := attr.BankruptcyCount;
	self.version4.BankruptcyAge                        := attr.BankruptcyAge;
	self.version4.BankruptcyType                       := attr.BankruptcyType;
	self.version4.BankruptcyStatus                     := attr.BankruptcyStatus;
	self.version4.BankruptcyCount01                    := attr.BankruptcyCount01;
	self.version4.BankruptcyCount03                    := attr.BankruptcyCount03;
	self.version4.BankruptcyCount06                    := attr.BankruptcyCount06;
	self.version4.BankruptcyCount12                    := attr.BankruptcyCount12;
	self.version4.BankruptcyCount24                    := attr.BankruptcyCount24;
	self.version4.BankruptcyCount60                    := attr.BankruptcyCount60;
	self.version4.EvictionCount                        := attr.EvictionCount;
	self.version4.EvictionAge                          := attr.EvictionAge;
	self.version4.EvictionCount01                      := attr.EvictionCount01;
	self.version4.EvictionCount03                      := attr.EvictionCount03;
	self.version4.EvictionCount06                      := attr.EvictionCount06;
	self.version4.EvictionCount12                      := attr.EvictionCount12;
	self.version4.EvictionCount24                      := attr.EvictionCount24;
	self.version4.EvictionCount60                      := attr.EvictionCount60;
	self.version4.AccidentCount                        := attr.AccidentCount;
	self.version4.AccidentAge                          := attr.AccidentAge;
	self.version4.RecentActivityIndex                  := attr.RecentActivityIndex;
	self.version4.NonDerogCount                        := attr.NonDerogCount;
	self.version4.NonDerogCount01                      := attr.NonDerogCount01;
	self.version4.NonDerogCount03                      := attr.NonDerogCount03;
	self.version4.NonDerogCount06                      := attr.NonDerogCount06;
	self.version4.NonDerogCount12                      := attr.NonDerogCount12;
	self.version4.NonDerogCount24                      := attr.NonDerogCount24;
	self.version4.NonDerogCount60                      := attr.NonDerogCount60;
	self.version4.VoterRegistrationRecord              := attr.VoterRegistrationRecord;
	self.version4.ProfLicCount                         := attr.ProfLicCount;
	self.version4.ProfLicAge                           := attr.ProfLicAge;
	self.version4.ProfLicTypeCategory                  := attr.ProfLicTypeCategory;
	self.version4.ProfLicExpired                       := attr.ProfLicExpired;
	self.version4.ProfLicCount01                       := attr.ProfLicCount01;
	self.version4.ProfLicCount03                       := attr.ProfLicCount03;
	self.version4.ProfLicCount06                       := attr.ProfLicCount06;
	self.version4.ProfLicCount12                       := attr.ProfLicCount12;
	self.version4.ProfLicCount24                       := attr.ProfLicCount24;
	self.version4.ProfLicCount60                       := attr.ProfLicCount60;
	self.version4.PRSearchLocateCount                  := attr.PRSearchLocateCount;
	self.version4.PRSearchLocateCount01                := attr.PRSearchLocateCount01;
	self.version4.PRSearchLocateCount03                := attr.PRSearchLocateCount03;
	self.version4.PRSearchLocateCount06                := attr.PRSearchLocateCount06;
	self.version4.PRSearchLocateCount12                := attr.PRSearchLocateCount12;
	self.version4.PRSearchLocateCount24                := attr.PRSearchLocateCount24;
	self.version4.PRSearchPersonalFinanceCount         := attr.PRSearchPersonalFinanceCount;
	self.version4.PRSearchPersonalFinanceCount01       := attr.PRSearchPersonalFinanceCount01;
	self.version4.PRSearchPersonalFinanceCount03       := attr.PRSearchPersonalFinanceCount03;
	self.version4.PRSearchPersonalFinanceCount06       := attr.PRSearchPersonalFinanceCount06;
	self.version4.PRSearchPersonalFinanceCount12       := attr.PRSearchPersonalFinanceCount12;
	self.version4.PRSearchPersonalFinanceCount24       := attr.PRSearchPersonalFinanceCount24;
	self.version4.PRSearchOtherCount                   := attr.PRSearchOtherCount;
	self.version4.PRSearchOtherCount01                 := attr.PRSearchOtherCount01;
	self.version4.PRSearchOtherCount03                 := attr.PRSearchOtherCount03;
	self.version4.PRSearchOtherCount06                 := attr.PRSearchOtherCount06;
	self.version4.PRSearchOtherCount12                 := attr.PRSearchOtherCount12;
	self.version4.PRSearchOtherCount24                 := attr.PRSearchOtherCount24;
	self.version4.PRSearchIdentitySSNs                 := attr.PRSearchIdentitySSNs;
	self.version4.PRSearchIdentityAddrs                := attr.PRSearchIdentityAddrs;
	self.version4.PRSearchIdentityPhones               := attr.PRSearchIdentityPhones;
	self.version4.PRSearchSSNIdentities                := attr.PRSearchSSNIdentities;
	self.version4.PRSearchAddrIdentities               := attr.PRSearchAddrIdentities;
	self.version4.PRSearchPhoneIdentities              := attr.PRSearchPhoneIdentities;
	self.version4.SubPrimeOfferRequestCount            := attr.SubPrimeOfferRequestCount;
	self.version4.SubPrimeOfferRequestCount01          := attr.SubPrimeOfferRequestCount01;
	self.version4.SubPrimeOfferRequestCount03          := attr.SubPrimeOfferRequestCount03;
	self.version4.SubPrimeOfferRequestCount06          := attr.SubPrimeOfferRequestCount06;
	self.version4.SubPrimeOfferRequestCount12          := attr.SubPrimeOfferRequestCount12;
	self.version4.SubPrimeOfferRequestCount24          := attr.SubPrimeOfferRequestCount24;
	self.version4.SubPrimeOfferRequestCount60          := attr.SubPrimeOfferRequestCount60;
	self.version4.InputPhoneMobile                     := attr.InputPhoneMobile;
	self.version4.InputPhoneType                       := le.Version3.InputPhoneType;
	self.version4.InputPhoneServiceType                := le.ServiceType;
	self.version4.InputAreaCodeChange                  := le.Version3.InputAreaCodeChange;
	self.version4.PhoneEDAAgeOldestRecord              := attr.PhoneEDAAgeOldestRecord;
	self.version4.PhoneEDAAgeNewestRecord              := attr.PhoneEDAAgeNewestRecord;
	self.version4.PhoneOtherAgeOldestRecord            := attr.PhoneOtherAgeOldestRecord;
	self.version4.PhoneOtherAgeNewestRecord            := attr.PhoneOtherAgeNewestRecord;
	self.version4.InputPhoneHighRisk                   := attr.InputPhoneHighRisk;
	self.version4.InputPhoneProblems                   := attr.InputPhoneProblems;
	self.version4.OnlineDirectory                      := attr.OnlineDirectory;
	self.version4.InputAddrSICCode                     := le.SIC;
	self.version4.InputAddrValidation                  := le.Version3.InputAddrValidation;
	self.version4.InputAddrErrorCode                   := le.AddrValErrorCode;
	self.version4.InputAddrHighRisk                    := attr.InputAddrHighRisk;
	self.version4.CurrAddrCorrectional                 := attr.CurrAddrCorrectional;
	self.version4.PrevAddrCorrectional                 := attr.PrevAddrCorrectional;
	self.version4.HistoricalAddrCorrectional           := attr.HistoricalAddrCorrectional;
	self.version4.InputAddrProblems                    := attr.InputAddrProblems;
	self.version4.DoNotMail                            := le.DoNotMail;
	
	// New attributes added to version 4.1 (Part of the 4.0 product)
	SELF.version4.IdentityRiskLevel										:= attr.IdentityRiskLevel;
	SELF.version4.IDVerRiskLevel											:= attr.IDVerRiskLevel;
	SELF.version4.IDVerAddressAssocCount							:= attr.VerAddressAssocCount;
	SELF.version4.IDVerSSNCreditBureauCount						:= attr.VerSSNCreditBureauCount;
	SELF.version4.IDVerSSNCreditBureauDelete					:= attr.IDVerSSNCreditBureauDelete;
	SELF.version4.SourceRiskLevel											:= attr.SourceRiskLevel;
	SELF.version4.SourceWatchList											:= attr.SourceWatchList;
	SELF.version4.SourceOrderActivity									:= attr.SourceOrderActivity;
	SELF.version4.SourceOrderSourceCount							:= attr.SourceOrderSourceCount;
	SELF.version4.SourceOrderAgeLastOrder							:= attr.SourceOrderAgeLastOrder;
	SELF.version4.VariationRiskLevel									:= attr.VariationRiskLevel;
	SELF.version4.VariationIdentityCount							:= attr.VariationIdentityCount;
	SELF.version4.VariationMSourcesSSNCount						:= attr.VariationMSourcesSSNCount;
	SELF.version4.VariationMSourcesSSNUnrelCount			:= attr.VariationMSourcesSSNUnrelCount;
	SELF.version4.VariationDOBCount										:= attr.VariationDOBCount;
	SELF.version4.VariationDOBCountNew								:= attr.VariationDOBCountNew;
	SELF.version4.SearchVelocityRiskLevel							:= attr.PRSearchVelocityRiskLevel;
	SELF.version4.SearchUnverifiedSSNCountYear				:= attr.PRSearchUnverifiedSSNCountYear;
	SELF.version4.SearchUnverifiedAddrCountYear				:= attr.PRSearchUnverifiedAddrCountYear;
	SELF.version4.SearchUnverifiedDOBCountYear				:= attr.PRSearchUnverifiedDOBCountYear;
	SELF.version4.SearchUnverifiedPhoneCountYear			:= attr.PRSearchUnverifiedPhoneCountYear;
	SELF.version4.AssocRiskLevel											:= attr.AssocRiskLevel;
	SELF.version4.AssocSuspicousIdentitiesCount				:= attr.AssocSuspicousIdentitiesCount;
	SELF.version4.AssocCreditBureauOnlyCount					:= attr.AssocCreditBureauOnlyCount;
	SELF.version4.AssocCreditBureauOnlyCountNew				:= attr.AssocCreditBureauOnlyCountNew;
	SELF.version4.AssocCreditBureauOnlyCountMonth			:= attr.AssocCreditBureauOnlyCountMonth;
	SELF.version4.AssocHighRiskTopologyCount					:= attr.AssocHighRiskTopologyCount;
	SELF.version4.ValidationRiskLevel									:= attr.ValidationRiskLevel;
	SELF.version4.CorrelationRiskLevel								:= attr.CorrelationRiskLevel;
	SELF.version4.DivRiskLevel												:= attr.DivRiskLevel;
	SELF.version4.DivSSNIdentityMSourceCount					:= attr.DivSSNIdentityMSourceCount;
	SELF.version4.DivSSNIdentityMSourceUrelCount			:= attr.DivSSNIdentityMSourceUrelCount;
	SELF.version4.DivSSNLNameCountNew									:= attr.DivSSNLNameCountNew;
	SELF.version4.DivSSNAddrMSourceCount							:= attr.DivSSNAddrMSourceCount;
	SELF.version4.DivAddrIdentityCount								:= attr.DivAddrIdentityCount;
	SELF.version4.DivAddrIdentityCountNew							:= attr.DivAddrIdentityCountNew;
	SELF.version4.DivAddrIdentityMSourceCount					:= attr.DivAddrIdentityMSourceCount;
	SELF.version4.DivAddrSuspIdentityCountNew					:= attr.DivAddrSuspIdentityCountNew;
	SELF.version4.DivAddrSSNCount											:= attr.DivAddrSSNCount;
	SELF.version4.DivAddrSSNCountNew									:= attr.DivAddrSSNCountNew;
	SELF.version4.DivAddrSSNMSourceCount							:= attr.DivAddrSSNMSourceCount;
	SELF.version4.DivSearchAddrSuspIdentityCount			:= attr.DivSearchAddrSuspIdentityCount;
	SELF.version4.SearchComponentRiskLevel						:= attr.PRSearchComponentRiskLevel;
	SELF.version4.SearchSSNSearchCount								:= attr.PRSearchSSNSearchCount;
	SELF.version4.SearchAddrSearchCount								:= attr.PRSearchAddrSearchCount;
	SELF.version4.SearchPhoneSearchCount							:= attr.PRSearchPhoneSearchCount;
	SELF.version4.ComponentCharRiskLevel							:= attr.ComponentCharRiskLevel;

	self := [];
END;
p4 := project( p3, map_fields_v4(left) ); // use p3 instead of p3_inq. version 4 doesn't need data from Key_Inquiry_Table_DID, as it's already built into shell 4.0



working_return := case( version,
	1 => ungroup(p),
	3 => ungroup(p3_inq),
	4 => ungroup(p4),
	0 => dataset( [], working_layout ),
	fail( working_layout, 'Invalid attributes version requested (' + (string)version + ')')
);


attr := project( working_return, models.layouts.layout_LeadIntegrity_attributes_batch );

#if(_control.Environment.OnThor)
	return attr;
#else
	return group(sort(attr,seq),seq);
#end

end;