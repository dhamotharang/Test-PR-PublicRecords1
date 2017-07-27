import address, fcra_opt_out, Risk_Indicators, ut;

export getCBDAttributes(
	grouped DATASET(Risk_Indicators.Layout_BocaShell_BtSt_Out) btst_clam,
	string30 account_value,
	DATASET(Layout_Chargeback_In) indata,
	unsigned1 version
	) := FUNCTION


Layout_CBDAttributes intoAttributes(btst_clam le, indata ri) := TRANSFORM
	self.seq := ri.seq;
	self.AccountNumber:= account_value;
	
	
	getPreviousMonth(unsigned histdate) := FUNCTION
			rollBack := trim((string)(histdate)[5..6])='01';
			histYear := if(rollBack, (unsigned)((trim((string)histdate)[1..4]))-1, (unsigned)(trim((string)histdate)[1..4]));
			histMonth := if(rollBack, 12, (unsigned)((trim((string)histdate)[5..6]))-1);
			return (unsigned)(intformat(histYear,4,1) + intformat(histMonth,2,1));
	END;

	checkDate6(unsigned3 foundDate) := FUNCTION
			outDate := if(foundDate >= le.bill_to_out.historyDate, getPreviousMonth(le.bill_to_out.historyDate), foundDate);
			return outDate;
	END;
	
	checkBoolean(boolean x) := if(x, '1', '0');
	cap150 := '150';
	cap960 := '960';
	getMin(string l, string r) := IF((unsigned)l < (unsigned)r, l, r);	// get smaller number
	
	fullDate := (unsigned4)risk_indicators.iid_constants.myGetDate(le.Bill_To_Out.historyDate);
	
	
	// Identity V1 ---------------------------------------------------------------------------------------------
	btSubjectFirstSeen := ut.Min2(le.bill_to_out.ssn_verification.header_first_seen, le.bill_to_out.ssn_verification.credit_first_seen);
	stSubjectFirstSeen := ut.Min2(le.ship_to_out.ssn_verification.header_first_seen, le.ship_to_out.ssn_verification.credit_first_seen);
	self.identityv1.BillToAgeOldestRecord := getMin(if(btSubjectFirstSeen=0, '', (string)round((ut.DaysApart((string)btSubjectFirstSeen, fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToAgeOldestRecord := getMin(if(stSubjectFirstSeen=0, '', (string)round((ut.DaysApart((string)stSubjectFirstSeen, fullDate[1..6])) / 30)), cap960);
	
	btSubjectLastSeen := checkDate6(ut.max2(le.bill_to_out.ssn_verification.header_last_seen, le.bill_to_out.ssn_verification.credit_last_seen));
	stSubjectLastSeen := checkDate6(ut.max2(le.ship_to_out.ssn_verification.header_last_seen, le.ship_to_out.ssn_verification.credit_last_seen));
	
	btanr := getMin(if(btSubjectLastSeen=0, '', (string)round((ut.DaysApart((string)btSubjectLastSeen, fullDate[1..6])) / 30)), cap960);
	stanr := getMin(if(stSubjectLastSeen=0, '', (string)round((ut.DaysApart((string)stSubjectLastSeen, fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToAgeNewestRecord := btanr;
	self.identityv1.ShipToAgeNewestRecord := stanr;
	self.identityv1.BillToRecentUpdate := checkBoolean((unsigned)btanr<=12 and btanr<>'') ;
	self.identityv1.ShipToRecentUpdate := checkBoolean((unsigned)stanr<=12 and stanr<>'');
	
	// current address pick for matching isbestmatch, assuming 1 of the 3 addresses are best
	btCAaddrChooser := map(	le.bill_to_out.address_verification.input_address_information.isbestmatch => 1, // input is current
													le.bill_to_out.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
													le.bill_to_out.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
													4);	// don't know what the current address is
	stCAaddrChooser := map(	le.ship_to_out.address_verification.input_address_information.isbestmatch => 1, // input is current
													le.ship_to_out.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
													le.ship_to_out.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
													4);	// don't know what the current address is
	
	self.identityv1.BillToSrcsConfirmIDAddrCount := map(btCAaddrChooser=1 => (string)le.bill_to_out.address_verification.input_address_information.source_count,
																										btCAaddrChooser=2 => (string)le.bill_to_out.address_verification.address_history_1.source_count,
																										btCAaddrChooser=3 => (string)le.bill_to_out.address_verification.address_history_2.source_count,
																										'0');
	self.identityv1.ShipToSrcsConfirmIDAddrCount := map(stCAaddrChooser=1 => (string)le.ship_to_out.address_verification.input_address_information.source_count,
																										stCAaddrChooser=2 => (string)le.ship_to_out.address_verification.address_history_1.source_count,
																										stCAaddrChooser=3 => (string)le.ship_to_out.address_verification.address_history_2.source_count,
																										'0');
																										
	btAddrNotInput :=  ~(	(le.bill_to_out.shell_input.in_StreetAddress<>'' and le.bill_to_out.shell_input.in_City<>'' and le.bill_to_out.shell_input.in_State<>'') or 
												(le.bill_to_out.shell_input.in_StreetAddress<>'' and le.bill_to_out.shell_input.in_Zipcode<>''));
	// I am not sure naprop is the universal way to show no property found, so we should check addrNotFound=true and the value is a false type
	btAddrNotFound :=  btAddrNotInput or le.bill_to_out.address_verification.input_address_information.naprop=0;	
	
	stAddrNotInput :=  ~(	(le.ship_to_out.shell_input.in_StreetAddress<>'' and le.ship_to_out.shell_input.in_City<>'' and le.ship_to_out.shell_input.in_State<>'') or 
												(le.ship_to_out.shell_input.in_StreetAddress<>'' and le.ship_to_out.shell_input.in_Zipcode<>''));
	// I am not sure naprop is the universal way to show no property found, so we should check addrNotFound=true and the value is a false type
	stAddrNotFound :=  stAddrNotInput or le.ship_to_out.address_verification.input_address_information.naprop=0;
	self.identityv1.BillToInvalidAddr := if(btAddrNotInput, '', checkBoolean(le.bill_to_out.iid.addrvalflag='N')); 
	self.identityv1.ShipToInvalidAddr := if(stAddrNotInput, '', checkBoolean(le.ship_to_out.iid.addrvalflag='N'));
	
	btPhoneNotInput := le.bill_to_out.shell_input.phone10='';
	btPhoneNotFound := le.bill_to_out.shell_input.phone10='' or le.bill_to_out.iid.phonephonecount=0;
	
	stPhoneNotInput := le.ship_to_out.shell_input.phone10='';
	stPhoneNotFound := le.ship_to_out.shell_input.phone10='' or le.ship_to_out.iid.phonephonecount=0;
	self.identityv1.BillToInvalidPhone := if(btPhoneNotInput, '', checkBoolean(le.bill_to_out.iid.phonetype <> '1' and le.bill_to_out.shell_input.phone10 <> ''));
	self.identityv1.ShipToInvalidPhone := if(stPhoneNotInput, '', checkBoolean(le.ship_to_out.iid.phonetype <> '1' and le.ship_to_out.shell_input.phone10 <> ''));
	
	self.identityv1.BillToVerificationFailure := checkBoolean(le.bill_to_out.iid.nas_summary <= 4 and le.bill_to_out.iid.nap_summary <= 4 and le.bill_to_out.address_verification.input_address_information.naprop <= 2);
	self.identityv1.ShipToVerificationFailure := checkBoolean(le.ship_to_out.iid.nas_summary <= 4 and le.ship_to_out.iid.nap_summary <= 4 and le.ship_to_out.address_verification.input_address_information.naprop <= 2);
	
	btFirstVerified := le.bill_to_out.iid.nap_summary in [3, 4, 8, 9, 10, 12] or le.bill_to_out.iid.nas_summary in [3, 4, 8, 9, 10, 12];
	btLastVerified := le.bill_to_out.iid.nap_summary in [5, 7, 8, 9, 11, 12] or le.bill_to_out.iid.nas_summary in [5, 7, 8, 9, 11, 12];
	
	stFirstVerified := le.ship_to_out.iid.nap_summary in [3, 4, 8, 9, 10, 12] or le.ship_to_out.iid.nas_summary in [3, 4, 8, 9, 10, 12];
	stLastVerified := le.ship_to_out.iid.nap_summary in [5, 7, 8, 9, 11, 12] or le.ship_to_out.iid.nas_summary in [5, 7, 8, 9, 11, 12];
	
	btFirstNotInput := le.bill_to_out.shell_input.fname='';
	btLastNotInput := le.bill_to_out.shell_input.lname='';
	
	stFirstNotInput := le.ship_to_out.shell_input.fname='';
	stLastNotInput := le.ship_to_out.shell_input.lname='';
	self.identityv1.BillToVerifiedName := map(btFirstNotInput or btLastNotInput => '',
																						btFirstVerified and btLastVerified => '3',
																						btLastVerified => '2',
																						btFirstVerified => '1',
																						'0');
	self.identityv1.ShipToVerifiedName := map(stFirstNotInput or stLastNotInput => '',
																						stFirstVerified and stLastVerified => '3',
																						stLastVerified => '2',
																						stFirstVerified => '1',
																						'0');
	self.identityv1.BillToVerifiedPhone := map(	btPhoneNotInput => '',
																							le.bill_to_out.iid.nap_summary in [6, 7, 9, 10, 11, 12] => '2',
																							le.bill_to_out.iid.nap_summary = 1 => '1',	
																							'0');
	self.identityv1.ShipToVerifiedPhone := map(	stPhoneNotInput => '',
																							le.ship_to_out.iid.nap_summary in [6, 7, 9, 10, 11, 12] => '2',
																							le.ship_to_out.iid.nap_summary = 1 => '1',	
																							'0');
	self.identityv1.BillToVerifiedPhoneFullName := if(btPhoneNotFound, '', checkBoolean(le.bill_to_out.iid.nap_summary in [9,12]));
	self.identityv1.ShipToVerifiedPhoneFullName := if(stPhoneNotFound, '', checkBoolean(le.ship_to_out.iid.nap_summary in [9,12]));
	self.identityv1.BillToVerifiedPhoneLastName := if(btPhoneNotFound, '', checkBoolean(le.bill_to_out.iid.nap_summary in [7,9,11,12])); 
	self.identityv1.ShipToVerifiedPhoneLastName := if(stPhoneNotFound, '', checkBoolean(le.ship_to_out.iid.nap_summary in [7,9,11,12]));
	self.identityv1.BillToVerifiedAddress := map(	btAddrNotInput => '',
																								le.bill_to_out.iid.nap_summary in [5, 8, 10, 11, 12] => '1',
																								le.bill_to_out.iid.nas_summary in [5, 8, 10, 11, 12] => '1', 
																								'0');
	self.identityv1.ShipToVerifiedAddress := map(	stAddrNotInput => '',
																								le.ship_to_out.iid.nap_summary in [5, 8, 10, 11, 12] => '1',
																								le.ship_to_out.iid.nas_summary in [5, 8, 10, 11, 12] => '1', 
																								'0');;
	self.identityv1.BillToInferredMinimumAge := getMin(if(le.bill_to_out.inferred_age=0, '', (string)le.bill_to_out.inferred_age), cap150);
	self.identityv1.ShipToInferredMinimumAge := getMin(if(le.ship_to_out.inferred_age=0, '', (string)le.ship_to_out.inferred_age), cap150);
	self.identityv1.BillToAddrIdentitiesCount := (string)le.bill_to_out.velocity_counters.adls_per_addr;
	self.identityv1.ShipToAddrIdentitiesCount := (string)le.ship_to_out.velocity_counters.adls_per_addr;
	self.identityv1.BillToAddrPhoneCount := (string)le.bill_to_out.velocity_counters.phones_per_addr;
	self.identityv1.ShipToAddrPhoneCount := (string)le.ship_to_out.velocity_counters.phones_per_addr;
	self.identityv1.BillToAddrIdentitiesRecentCount := (string)le.bill_to_out.velocity_counters.adls_per_addr_created_6months;
	self.identityv1.ShipToAddrIdentitiesRecentCount := (string)le.ship_to_out.velocity_counters.adls_per_addr_created_6months;
	self.identityv1.BillToAddrPhoneRecentCount := (string)le.bill_to_out.velocity_counters.phones_per_addr_created_6months;
	self.identityv1.ShipToAddrPhoneRecentCount := (string)le.ship_to_out.velocity_counters.phones_per_addr_created_6months;
	self.identityv1.BillToPhoneIdentitiesCount := (string)le.bill_to_out.velocity_counters.adls_per_phone;
	self.identityv1.ShipToPhoneIdentitiesCount := (string)le.ship_to_out.velocity_counters.adls_per_phone;
	self.identityv1.BillToPhoneListedDifferentNameAddress := map(	le.bill_to_out.shell_input.phone10='' => '',
																																le.bill_to_out.iid.nap_summary=1 => '1',
																																'0');	
	self.identityv1.ShipToPhoneListedDifferentNameAddress := map(	le.ship_to_out.shell_input.phone10='' => '',
																																le.ship_to_out.iid.nap_summary=1 => '1',
																																'0');	
	self.identityv1.BillToPhoneIdentitiesRecentCount := (string)le.bill_to_out.velocity_counters.adls_per_phone_created_6months;
	self.identityv1.ShipToPhoneIdentitiesRecentCount := (string)le.ship_to_out.velocity_counters.adls_per_phone_created_6months;
	self.identityv1.BillToAddrStability := le.bill_to_out.mobility_indicator;
	self.identityv1.ShipToAddrStability := le.ship_to_out.mobility_indicator;
	
	btStatusAddr1 := map(	le.bill_to_out.address_verification.input_address_information.applicant_owned or 
														le.bill_to_out.address_verification.input_address_information.applicant_sold or
														le.bill_to_out.address_verification.input_address_information.family_owned or 
														le.bill_to_out.address_verification.input_address_information.family_sold => 'O',// owned
												~le.bill_to_out.address_verification.input_address_information.occupant_owned and
														le.bill_to_out.iid.dwelltype not in ['','S'] => 'R',// rent,
												'U');// unknown
	btStatusAddr2 := map(	le.bill_to_out.address_verification.address_history_1.applicant_owned or 
														le.bill_to_out.address_verification.address_history_1.applicant_sold or
														le.bill_to_out.address_verification.address_history_1.family_owned or 
														le.bill_to_out.address_verification.address_history_1.family_sold => 'O',// owned
												~le.bill_to_out.address_verification.address_history_1.occupant_owned and 
														le.bill_to_out.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
												'U');// unknown;
	btStatusAddr3 := map(	le.bill_to_out.address_verification.address_history_2.applicant_owned or 
														le.bill_to_out.address_verification.address_history_2.applicant_sold or
														le.bill_to_out.address_verification.address_history_2.family_owned or 
														le.bill_to_out.address_verification.address_history_2.family_sold => 'O',// owned
												~le.bill_to_out.address_verification.address_history_2.occupant_owned and 
														le.bill_to_out.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
												'U');// unknown;
										 
	stStatusAddr1 := map(	le.ship_to_out.address_verification.input_address_information.applicant_owned or 
														le.ship_to_out.address_verification.input_address_information.applicant_sold or
														le.ship_to_out.address_verification.input_address_information.family_owned or 
														le.ship_to_out.address_verification.input_address_information.family_sold => 'O',// owned
												~le.ship_to_out.address_verification.input_address_information.occupant_owned and
														le.ship_to_out.iid.dwelltype not in ['','S'] => 'R',// rent,
												'U');// unknown
	stStatusAddr2 := map(	le.ship_to_out.address_verification.address_history_1.applicant_owned or 
														le.ship_to_out.address_verification.address_history_1.applicant_sold or
														le.ship_to_out.address_verification.address_history_1.family_owned or 
														le.ship_to_out.address_verification.address_history_1.family_sold => 'O',// owned
												~le.ship_to_out.address_verification.address_history_1.occupant_owned and 
														le.ship_to_out.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
												'U');// unknown;
	stStatusAddr3 := map(	le.ship_to_out.address_verification.address_history_2.applicant_owned or 
														le.ship_to_out.address_verification.address_history_2.applicant_sold or
														le.ship_to_out.address_verification.address_history_2.family_owned or 
														le.ship_to_out.address_verification.address_history_2.family_sold => 'O',// owned
												~le.ship_to_out.address_verification.address_history_2.occupant_owned and 
														le.ship_to_out.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
												'U');// unknown;
	self.identityv1.BillToStatusMostRecent := map(btCAaddrChooser=1 => btStatusAddr1,
																							btCAaddrChooser=2 => btStatusAddr2,
																							btCAaddrChooser=3 => btStatusAddr3,
																							'');
	self.identityv1.ShipToStatusMostRecent := map(stCAaddrChooser=1 => stStatusAddr1,
																							stCAaddrChooser=2 => stStatusAddr2,
																							stCAaddrChooser=3 => stStatusAddr3,
																							'');
	self.identityv1.BillToAddrChangeCount03 := (string)le.bill_to_out.other_address_info.addrs_last90;
	self.identityv1.ShipToAddrChangeCount03 := (string)le.ship_to_out.other_address_info.addrs_last90;
	self.identityv1.BillToPropOwnedCount := (string)le.bill_to_out.address_verification.owned.property_total;
	self.identityv1.ShipToPropOwnedCount := (string)le.ship_to_out.address_verification.owned.property_total;
	self.identityv1.BillToPropOwnedTaxTotal := getMin((string)le.bill_to_out.address_verification.owned.property_owned_assessed_total, '9999999999');	// documentation says string10, need to cap this
	self.identityv1.ShipToPropOwnedTaxTotal := getMin((string)le.ship_to_out.address_verification.owned.property_owned_assessed_total, '9999999999');	// documentation says string10, need to cap this
	self.identityv1.BillToWatercraftCount := (string)le.bill_to_out.watercraft.watercraft_count;
	self.identityv1.ShipToWatercraftCount := (string)le.ship_to_out.watercraft.watercraft_count;
	self.identityv1.BillToAircraftCount := (string)le.bill_to_out.aircraft.aircraft_count;
	self.identityv1.ShipToAircraftCount := (string)le.ship_to_out.aircraft.aircraft_count;
	self.identityv1.BillToWealthIndex := le.bill_to_out.wealth_indicator;
	self.identityv1.ShipToWealthIndex := le.ship_to_out.wealth_indicator;
	
	btEviction_count := le.bill_to_out.BJL.eviction_historical_unreleased_count + le.bill_to_out.BJL.eviction_recent_unreleased_count;	// get only unreleased evictions, just like liens
	stEviction_count := le.ship_to_out.BJL.eviction_historical_unreleased_count + le.ship_to_out.BJL.eviction_recent_unreleased_count;	// get only unreleased evictions, just like liens
	btDerogCount := le.bill_to_out.bjl.felony_count + le.bill_to_out.bjl.filing_count + le.bill_to_out.bjl.liens_historical_unreleased_count + le.bill_to_out.bjl.liens_recent_unreleased_count +
									le.bill_to_out.bjl.arrests_count + btEviction_count;
	
	stDerogCount := le.ship_to_out.bjl.felony_count + le.ship_to_out.bjl.filing_count + le.ship_to_out.bjl.liens_historical_unreleased_count + le.ship_to_out.bjl.liens_recent_unreleased_count +
									le.ship_to_out.bjl.arrests_count + stEviction_count;
	self.identityv1.BillToDerogCount := (string)btDerogCount;
	self.identityv1.ShipToDerogCount := (string)stDerogCount;
	
	btDate_last_derogv31 := ut.max2(le.bill_to_out.bjl.last_felony_date, (integer)le.bill_to_out.bjl.last_liens_unreleased_date);
	btDate_last_derogv32 := ut.max2(le.bill_to_out.bjl.date_last_seen, if(btEviction_count>0, le.bill_to_out.bjl.last_eviction_date, 0));	// only use the eviction date if there is an unreleased eviction
	btDate_last_derogv33 := ut.max2(btDate_last_derogv31, btDate_last_derogv32);
	btDate_last_derogv3  := ut.max2(le.bill_to_out.bjl.date_last_arrest, btDate_last_derogv33);
	
	btDLD := if(btDate_last_derogv3>fullDate, 0, btDate_last_derogv3);
	
	stDate_last_derogv31 := ut.max2(le.ship_to_out.bjl.last_felony_date, (integer)le.ship_to_out.bjl.last_liens_unreleased_date);
	stDate_last_derogv32 := ut.max2(le.ship_to_out.bjl.date_last_seen, if(btEviction_count>0, le.ship_to_out.bjl.last_eviction_date, 0));	// only use the eviction date if there is an unreleased eviction
	stDate_last_derogv33 := ut.max2(btDate_last_derogv31, btDate_last_derogv32);
	stDate_last_derogv3  := ut.max2(le.ship_to_out.bjl.date_last_arrest, btDate_last_derogv33);
	
	stDLD := if(btDate_last_derogv3>fullDate, 0, btDate_last_derogv3);
	self.identityv1.BillToDerogAge := getMin(if(btDLD=0, '', (string)round((ut.DaysApart((string)btDLD, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToDerogAge := getMin(if(stDLD=0, '', (string)round((ut.DaysApart((string)stDLD, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToFelonyCount := (string)le.bill_to_out.bjl.felony_count;
	self.identityv1.ShipToFelonyCount := (string)le.ship_to_out.bjl.felony_count;
	
	btLFD := if(le.bill_to_out.bjl.last_felony_date>fullDate, 0, le.bill_to_out.bjl.last_felony_date);
	stLFD := if(le.ship_to_out.bjl.last_felony_date>fullDate, 0, le.ship_to_out.bjl.last_felony_date);
	self.identityv1.BillToFelonyAge := getMin(if(btLFD=0, '', (string)round((ut.DaysApart((string)btLFD, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToFelonyAge := getMin(if(stLFD=0, '', (string)round((ut.DaysApart((string)stLFD, (string)fullDate[1..6])) / 30)), cap960);
	
	btLED := if(le.bill_to_out.bjl.last_eviction_date>fullDate, 0, if(btEviction_count>0, le.bill_to_out.bjl.last_eviction_date, 0));	// only use the eviction date if unreleased
	stLED := if(le.ship_to_out.bjl.last_eviction_date>fullDate, 0, if(stEviction_count>0, le.ship_to_out.bjl.last_eviction_date, 0));	// only use the eviction date if unreleased
	self.identityv1.BillToEvictionAge := getMin(if(btLED=0, '', (string)round((ut.DaysApart((string)btLED, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToEvictionAge := getMin(if(stLED=0, '', (string)round((ut.DaysApart((string)stLED, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToEvictionCount := 	(string)(	btEviction_count);	// only count unreleased evictions
	self.identityv1.ShipToEvictionCount := 	(string)(	stEviction_count);	// only count unreleased evictions
	
	btPLDMR := if(le.bill_to_out.professional_license.date_most_recent>fullDate, 0, le.bill_to_out.professional_license.date_most_recent);
	stPLDMR := if(le.ship_to_out.professional_license.date_most_recent>fullDate, 0, le.ship_to_out.professional_license.date_most_recent);
	self.identityv1.BillToProfLicAge := getMin(if(btPLDMR=0, '', (string)round((ut.DaysApart((string)btPLDMR, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToProfLicAge := getMin(if(stPLDMR=0, '', (string)round((ut.DaysApart((string)stPLDMR, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToProfLicCount := (string)le.bill_to_out.professional_license.proflic_count;
	self.identityv1.ShipToProfLicCount := (string)le.ship_to_out.professional_license.proflic_count;
	self.identityv1.BillToPhoneStatus := if(btPhoneNotInput, '',																											
																						map(le.bill_to_out.iid.phonedissflag and le.bill_to_out.input_validation.homephone => 'D',
																								le.bill_to_out.iid.phonevalflag in ['1','2'] or (le.bill_to_out.iid.phonevalflag = '3' and le.bill_to_out.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																								''));
	self.identityv1.ShipToPhoneStatus := if(stPhoneNotInput, '',
																						map(le.ship_to_out.iid.phonedissflag and le.ship_to_out.input_validation.homephone => 'D',
																								le.ship_to_out.iid.phonevalflag in ['1','2'] or (le.ship_to_out.iid.phonevalflag = '3' and le.ship_to_out.iid.phonephonecount>0) => 'C',	// unknown phone usage but a phone hit (removed phones we dont know about)
																								''));
	self.identityv1.BillToPhonePager := if(btPhoneNotInput, '', checkBoolean(le.bill_to_out.iid.hriskphoneflag = '2'));
	self.identityv1.ShipToPhonePager := if(stPhoneNotInput, '', checkBoolean(le.ship_to_out.iid.hriskphoneflag = '2'));
	self.identityv1.BillToPhoneMobile := if(btPhoneNotInput, '', checkBoolean(le.bill_to_out.iid.hriskphoneflag = '1'));
	self.identityv1.ShipToPhoneMobile := if(stPhoneNotInput, '', checkBoolean(le.ship_to_out.iid.hriskphoneflag = '1'));
	self.identityv1.BillToPhoneEDAAgeOldestRecord := getMin(if(le.bill_to_out.phone_verification.gong_did.gong_adl_dt_first_seen_full='', '', 
																																	(string)round((ut.DaysApart((string)le.bill_to_out.phone_verification.gong_did.gong_adl_dt_first_seen_full, (string)fullDate)) / 30)), cap960);
	self.identityv1.ShipToPhoneEDAAgeOldestRecord := getMin(if(le.ship_to_out.phone_verification.gong_did.gong_adl_dt_first_seen_full='', '', 
																																	(string)round((ut.DaysApart((string)le.ship_to_out.phone_verification.gong_did.gong_adl_dt_first_seen_full, (string)fullDate)) / 30)), cap960);
	self.identityv1.BillToPhoneEDAAgeNewestRecord := getMin(if(le.bill_to_out.phone_verification.gong_did.gong_adl_dt_last_seen_full='', '', 
																																	(string)round((ut.DaysApart((string)le.bill_to_out.phone_verification.gong_did.gong_adl_dt_last_seen_full, (string)fullDate)) / 30)), cap960);
	self.identityv1.ShipToPhoneEDAAgeNewestRecord := getMin(if(le.ship_to_out.phone_verification.gong_did.gong_adl_dt_last_seen_full='', '', 
																																	(string)round((ut.DaysApart((string)le.ship_to_out.phone_verification.gong_did.gong_adl_dt_last_seen_full, (string)fullDate)) / 30)), cap960);
	self.identityv1.BillToPhoneOtherAgeOldestRecord := getMin(if(le.bill_to_out.infutor.infutor_date_first_seen=0, '', (string)round((ut.DaysApart((string)le.bill_to_out.infutor.infutor_date_first_seen, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToPhoneOtherAgeOldestRecord := getMin(if(le.ship_to_out.infutor.infutor_date_first_seen=0, '', (string)round((ut.DaysApart((string)le.ship_to_out.infutor.infutor_date_first_seen, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToPhoneOtherAgeNewestRecord := getMin(if(le.bill_to_out.infutor.infutor_date_last_seen=0, '', (string)round((ut.DaysApart((string)le.bill_to_out.infutor.infutor_date_last_seen, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.ShipToPhoneOtherAgeNewestRecord := getMin(if(le.ship_to_out.infutor.infutor_date_last_seen=0, '', (string)round((ut.DaysApart((string)le.ship_to_out.infutor.infutor_date_last_seen, (string)fullDate[1..6])) / 30)), cap960);
	self.identityv1.BillToInvalidPhoneZip := if(btPhoneNotInput or le.bill_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.bill_to_out.iid.phonezipflag = '1'));
	self.identityv1.ShipToInvalidPhoneZip := if(stPhoneNotInput or le.ship_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.ship_to_out.iid.phonezipflag = '1'));
	self.identityv1.BillToPhoneAddrDist := if(btPhoneNotInput or btAddrNotInput, '', (string)le.bill_to_out.iid.disthphoneaddr);
	self.identityv1.ShipToPhoneAddrDist := if(stPhoneNotInput or stAddrNotInput, '', (string)le.ship_to_out.iid.disthphoneaddr);
	self.identityv1.BillToAddrHighRisk := if(btAddrNotInput, '', checkBoolean(le.bill_to_out.iid.hriskaddrflag = '4'));
	self.identityv1.ShipToAddrHighRisk := if(stAddrNotInput, '', checkBoolean(le.ship_to_out.iid.hriskaddrflag = '4'));
	self.identityv1.BillToInputPhoneHighRisk := if(btPhoneNotInput, '', checkBoolean(le.bill_to_out.iid.hriskphoneflag = '6'));
	self.identityv1.ShipToInputPhoneHighRisk := if(stPhoneNotInput, '', checkBoolean(le.ship_to_out.iid.hriskphoneflag = '6'));
	self.identityv1.BillToInputAddrPrison := if(btAddrNotInput, '', checkBoolean(le.bill_to_out.iid.hriskaddrflag='4' AND le.bill_to_out.iid.hrisksic = '2225'));
	self.identityv1.ShipToInputAddrPrison := if(stAddrNotInput, '', checkBoolean(le.ship_to_out.iid.hriskaddrflag='4' AND le.ship_to_out.iid.hrisksic = '2225'));
	self.identityv1.BillToInputZipPOBox := if(le.bill_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.bill_to_out.iid.zipclass='P'));
	self.identityv1.ShipToInputZipPOBox := if(le.ship_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.ship_to_out.iid.zipclass='P'));
	self.identityv1.BillToInputZipCorpMil := if(le.bill_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.bill_to_out.iid.zipclass in ['M','U']));
	self.identityv1.ShipToInputZipCorpMil := if(le.ship_to_out.shell_input.in_Zipcode='', '', checkBoolean(le.ship_to_out.iid.zipclass in ['M','U']));
	
	// Relationship V1
	knownBT := le.bill_to_out.did<>0;
	knownST := le.ship_to_out.did<>0;
	self.relationshipv1.BillToShipToSameIdentity := map(~knownBT or ~knownST => '',
																											le.bill_to_out.did=le.ship_to_out.did => '1',
																											'0');
	self.relationshipv1.BillToShipToSameName := map(le.bill_to_out.shell_input.fname='' or le.bill_to_out.shell_input.lname='' or
																												le.ship_to_out.shell_input.fname='' or le.ship_to_out.shell_input.lname='' => '',	
																									risk_indicators.iid_constants.g((unsigned)le.eddo.firstscore) and risk_indicators.iid_constants.g((unsigned)le.eddo.lastscore) => '1',
																									'0');	
	self.relationshipv1.BillToShipToSameAddr := map(btAddrNotInput or stAddrNotInput => '',
																									risk_indicators.iid_constants.ga((unsigned)le.eddo.addrscore) => '1',
																									'0');	
	self.relationshipv1.BillToFNameFoundEmail := map(	le.bill_to_out.shell_input.fname='' or le.bill_to_out.shell_input.email_address='' => '',
																										(integer)le.eddo.efirstscore > 0 => '1',
																										'0');	
	self.relationshipv1.BillToLNameFoundEmail := map(	le.bill_to_out.shell_input.lname='' or le.bill_to_out.shell_input.email_address='' => '',
																										(integer)le.eddo.elastscore > 0 => '1',
																										'0');	
	self.relationshipv1.ShipToFNameFoundEmail := map(	le.ship_to_out.shell_input.fname='' or le.bill_to_out.shell_input.email_address='' => '',
																										(integer)le.eddo.efirst2score > 0 => '1',
																										'0');	
	self.relationshipv1.ShipToLNameFoundEmail := map(	le.ship_to_out.shell_input.lname='' or le.bill_to_out.shell_input.email_address='' => '',
																										(integer)le.eddo.elast2score > 0 => '1',
																										'0');	
	self.relationshipv1.BillToPhoneBillToAddrDist := if(btPhoneNotInput or btAddrNotInput, '', le.eddo.distphoneaddr);
	self.relationshipv1.ShipToPhoneShipToAddrDist := if(stPhoneNotInput or stAddrNotInput, '', le.eddo.distphone2addr2);
	self.relationshipv1.BillToPhoneShipToAddrDist := if(btPhoneNotInput or stAddrNotInput, '', le.eddo.distphoneaddr2);
	self.relationshipv1.BillToShipToPhoneDist := if(btPhoneNotInput or stPhoneNotInput, '', le.eddo.distphonephone2);
	self.relationshipv1.BillToShipToAddrDist := if(btAddrNotInput or stAddrNotInput, '', le.eddo.distaddraddr2);
	self.relationshipv1.BillToAddrShipToPhoneDist := if(btAddrNotInput or stPhoneNotInput, '', le.eddo.distaddrphone2);
	self.relationshipv1.BillToShipToRelative := map(~knownBT or ~knownST => '',
																									le.eddo.btst_are_relatives => '1',
																									'0');
	self.relationshipv1.BillToShipToCommonRelative := map(~knownBT or ~knownST => '',
																												le.eddo.btst_relatives_in_common => '1',
																												'0');	
	self.IdentityV4 := [];
	self.RelationshipV4 := [];
	self.VelocityV4 := [];
END;
out1 := join(btst_clam, indata, left.bill_to_out.seq=(right.seq*2), intoAttributes(left,right));		// do I need a right outer or anything?


Layout_CBDAttributes intoAttributes4( btst_clam le ) := TRANSFORM
	self.seq := le.bill_to_out.seq / 2;
	self.AccountNumber:= account_value;

	bt_attr := models.Attributes_Master( le.bill_to_out, isFCRA := false, BillToShipTo := le );
	st_attr := models.Attributes_Master( le.ship_to_out, isFCRA := false );

	self.IdentityV4.BillToAgeOldestRecord                 := bt_attr.AgeOldestRecord;
	self.IdentityV4.ShipToAgeOldestRecord                 := st_attr.AgeOldestRecord;
	self.IdentityV4.BillToAgeNewestRecord                 := bt_attr.AgeNewestRecord;
	self.IdentityV4.ShipToAgeNewestRecord                 := st_attr.AgeNewestRecord;
	self.IdentityV4.BillToRecentUpdate                    := bt_attr.RecentUpdate;
	self.IdentityV4.ShipToRecentUpdate                    := st_attr.RecentUpdate;
	self.IdentityV4.BillToSrcsConfirmIDAddrCount          := bt_attr.SrcsConfirmIDAddrCount;
	self.IdentityV4.ShipToSrcsConfirmIDAddrCount          := st_attr.SrcsConfirmIDAddrCount;
	self.IdentityV4.BillToVerificationFailure             := bt_attr.VerificationFailure;
	self.IdentityV4.ShipToVerificationFailure             := st_attr.VerificationFailure;
	self.IdentityV4.BillToVerifiedName                    := bt_attr.VerifiedName;
	self.IdentityV4.ShipToVerifiedName                    := st_attr.VerifiedName;
	self.IdentityV4.BillToVerifiedPhone                   := bt_attr.VerifiedPhone;
	self.IdentityV4.ShipToVerifiedPhone                   := st_attr.VerifiedPhone;
	self.IdentityV4.BillToVerifiedAddress                 := bt_attr.VerifiedAddress;
	self.IdentityV4.ShipToVerifiedAddress                 := st_attr.VerifiedAddress;
	self.IdentityV4.BillToAssetVerifiedIdentity           := bt_attr.AssetVerifiedIdentity;
	self.IdentityV4.ShipToAssetVerifiedIdentity           := st_attr.AssetVerifiedIdentity;
	self.IdentityV4.BillToPropRealVerifiedIdentity        := bt_attr.PropRealVerifiedIdentity;
	self.IdentityV4.ShipToPropRealVerifiedIdentity        := st_attr.PropRealVerifiedIdentity;
	self.IdentityV4.BillToPropRealSourceCount             := bt_attr.PropRealSourceCount;
	self.IdentityV4.ShipToPropRealSourceCount             := st_attr.PropRealSourceCount;
	self.IdentityV4.BillToPropPersVerifiedIdentity        := bt_attr.PropPersVerifiedIdentity;
	self.IdentityV4.ShipToPropPersVerifiedIdentity        := st_attr.PropPersVerifiedIdentity;
	self.IdentityV4.BillToPropPersSourceCount             := bt_attr.PropPersSourceCount;
	self.IdentityV4.ShipToPropPersSourceCount             := st_attr.PropPersSourceCount;
	self.IdentityV4.BillToInferredMinimumAge              := bt_attr.InferredMinimumAge(false);
	self.IdentityV4.ShipToInferredMinimumAge              := st_attr.InferredMinimumAge(false);
	self.IdentityV4.BillToAddrIdentityCount               := bt_attr.AddrIdentitiesCount;
	self.IdentityV4.ShipToAddrIdentityCount               := st_attr.AddrIdentitiesCount;
	self.IdentityV4.BillToAddrPhoneCount                  := bt_attr.InputAddrPhoneCount;
	self.IdentityV4.ShipToAddrPhoneCount                  := st_attr.InputAddrPhoneCount;
	self.IdentityV4.BillToAddrIdentityRecentCount         := bt_attr.AddrIdentitiesRecentCount;
	self.IdentityV4.ShipToAddrIdentityRecentCount         := st_attr.AddrIdentitiesRecentCount;
	self.IdentityV4.BillToAddrPhoneRecentCount            := bt_attr.InputAddrPhoneRecentCount;
	self.IdentityV4.ShipToAddrPhoneRecentCount            := st_attr.InputAddrPhoneRecentCount;
	self.IdentityV4.BillToPhoneIdentityCount              := bt_attr.PhoneIdentitiesCount;
	self.IdentityV4.ShipToPhoneIdentityCount              := st_attr.PhoneIdentitiesCount;
	self.IdentityV4.BillToPhoneIdentityRecentCount        := bt_attr.PhoneIdentitiesRecentCount;
	self.IdentityV4.ShipToPhoneIdentityRecentCount        := st_attr.PhoneIdentitiesRecentCount;
	self.IdentityV4.BillToAddrStability                   := bt_attr.AddrStability;
	self.IdentityV4.ShipToAddrStability                   := st_attr.AddrStability;
	self.IdentityV4.BillToStatusMostRecent                := bt_attr.StatusMostRecent;
	self.IdentityV4.ShipToStatusMostRecent                := st_attr.StatusMostRecent;
	self.IdentityV4.BillToAddrChangeCount03               := bt_attr.AddrChangeCount03;
	self.IdentityV4.ShipToAddrChangeCount03               := st_attr.AddrChangeCount03;
	self.IdentityV4.BillToFraudDerogSeverityIndex         := bt_attr.FraudDerogSeverityIndex;
	self.IdentityV4.ShipToFraudDerogSeverityIndex         := st_attr.FraudDerogSeverityIndex;
	self.IdentityV4.BillToDerogCount                      := bt_attr.DerogCount;
	self.IdentityV4.ShipToDerogCount                      := st_attr.DerogCount;
	self.IdentityV4.BillToDerogRecentCount                := bt_attr.DerogRecentCount;
	self.IdentityV4.ShipToDerogRecentCount                := st_attr.DerogRecentCount;
	self.IdentityV4.BillToDerogAge                        := bt_attr.DerogAge;
	self.IdentityV4.ShipToDerogAge                        := st_attr.DerogAge;
	self.IdentityV4.BillToFelonyCount                     := bt_attr.FelonyCount;
	self.IdentityV4.ShipToFelonyCount                     := st_attr.FelonyCount;
	self.IdentityV4.BillToFelonyAge                       := bt_attr.FelonyAge;
	self.IdentityV4.ShipToFelonyAge                       := st_attr.FelonyAge;
	self.IdentityV4.BillToEvictionCount                   := bt_attr.EvictionCount;
	self.IdentityV4.ShipToEvictionCount                   := st_attr.EvictionCount;
	self.IdentityV4.BillToEvictionAge                     := bt_attr.EvictionAge;
	self.IdentityV4.ShipToEvictionAge                     := st_attr.EvictionAge;
	self.IdentityV4.BillToProfLicCount                    := bt_attr.ProfLicCount;
	self.IdentityV4.ShipToProfLicCount                    := st_attr.ProfLicCount;
	self.IdentityV4.BillToPhoneMobile                     := bt_attr.InputPhoneMobile;
	self.IdentityV4.ShipToPhoneMobile                     := st_attr.InputPhoneMobile;
	self.IdentityV4.BillToProfLicAge                      := bt_attr.ProfLicAge;
	self.IdentityV4.ShipToProfLicAge                      := st_attr.ProfLicAge;
	self.IdentityV4.BillToPhoneEDAAgeOldestRecord         := bt_attr.PhoneEDAAgeOldestRecord;
	self.IdentityV4.ShipToPhoneEDAAgeOldestRecord         := st_attr.PhoneEDAAgeOldestRecord;
	self.IdentityV4.BillToPhoneEDAAgeNewestRecord         := bt_attr.PhoneEDAAgeNewestRecord;
	self.IdentityV4.ShipToPhoneEDAAgeNewestRecord         := st_attr.PhoneEDAAgeNewestRecord;
	self.IdentityV4.BillToPhoneOthAgeOldestRecord         := bt_attr.PhoneOtherAgeOldestRecord;
	self.IdentityV4.ShipToPhoneOthAgeOldestRecord         := st_attr.PhoneOtherAgeOldestRecord;
	self.IdentityV4.BillToPhoneOthAgeNewestRecord         := bt_attr.PhoneOtherAgeNewestRecord;
	self.IdentityV4.ShipToPhoneOthAgeNewestRecord         := st_attr.PhoneOtherAgeNewestRecord;
	self.IdentityV4.BillToAddrHighRisk                    := bt_attr.InputAddrHighRisk;
	self.IdentityV4.ShipToAddrHighRisk                    := bt_attr.InputAddrHighRisk;
	self.IdentityV4.BillToInputPhoneHighRisk              := bt_attr.InputPhoneHighRisk;
	self.IdentityV4.ShipToInputPhoneHighRisk              := st_attr.InputPhoneHighRisk;
	self.IdentityV4.BillToInputPhoneProblems              := bt_attr.InputPhoneProblems;
	self.IdentityV4.ShipToInputPhoneProblems              := st_attr.InputPhoneProblems;
	self.IdentityV4.BillToInputAddrProblems               := bt_attr.InputAddrProblems;
	self.IdentityV4.ShipToInputAddrProblems               := st_attr.InputAddrProblems;


	self.RelationshipV4.BillToShipToSameIdentity          := bt_attr.BillToShipToSameIdentity;
	self.RelationshipV4.BillToShipToSameName              := bt_attr.BillToShipToSameName;
	self.RelationshipV4.BillToShipToSameAddr              := bt_attr.BillToShipToSameAddr;
	self.RelationshipV4.BillToFNameFoundEmail             := bt_attr.BillToFNameFoundEmail;
	self.RelationshipV4.ShipToFNameFoundEmail             := bt_attr.ShipToFNameFoundEmail;
	self.RelationshipV4.BillToLNameFoundEmail             := bt_attr.BillToLNameFoundEmail;
	self.RelationshipV4.ShipToLNameFoundEmail             := bt_attr.ShipToLNameFoundEmail;
	self.RelationshipV4.BillToPhoneBillToAddrDist         := bt_attr.BillToPhoneBillToAddrDist;
	self.RelationshipV4.ShipToPhoneShipToAddrDist         := bt_attr.ShipToPhoneShipToAddrDist;
	self.RelationshipV4.BillToPhoneShipToAddrDist         := bt_attr.BillToPhoneShipToAddrDist;
	self.RelationshipV4.BillToShipToPhoneDist             := bt_attr.BillToShipToPhoneDist;
	self.RelationshipV4.BillToShipToAddrDist              := bt_attr.BillToShipToAddrDist;
	self.RelationshipV4.BillToAddrShipToPhoneDist         := bt_attr.BillToAddrShipToPhoneDist;
	self.RelationshipV4.BillToShipToRelative              := bt_attr.BillToShipToRelative;
	self.RelationshipV4.BillToShipToCommonRelative        := bt_attr.BillToShipToCommonRelative;


	self.VelocityV4.BillToSearchCBDAgeOldestRecord        := bt_attr.SearchCBDAgeOldestRecord;
	self.VelocityV4.ShipToSearchCBDAgeOldestRecord        := st_attr.SearchCBDAgeOldestRecord;
	self.VelocityV4.BillToSearchCBDAgeNewestRecord        := bt_attr.SearchCBDAgeNewestRecord;
	self.VelocityV4.ShipToSearchCBDAgeNewestRecord        := st_attr.SearchCBDAgeNewestRecord;
	self.VelocityV4.BillToSearchCBDCount                  := bt_attr.SearchCBDCount;
	self.VelocityV4.ShipToSearchCBDCount                  := st_attr.SearchCBDCount;
	self.VelocityV4.BillToSearchCBDCount01                := bt_attr.SearchCBDCount01;
	self.VelocityV4.ShipToSearchCBDCount01                := st_attr.SearchCBDCount01;
	self.VelocityV4.BillToSearchCBDIdentityAddr           := bt_attr.SearchCBDIdentityAddrs;
	self.VelocityV4.ShipToSearchCBDIdentityAddr           := st_attr.SearchCBDIdentityAddrs;
	self.VelocityV4.BillToSearchCBDAddrIdentity           := bt_attr.SearchCBDAddrIdentities;
	self.VelocityV4.ShipToSearchCBDAddrIdentity           := st_attr.SearchCBDAddrIdentities;
	self.VelocityV4.BillToSearchCBDIdentityPhone          := bt_attr.SearchCBDIdentityPhones;
	self.VelocityV4.ShipToSearchCBDIdentityPhone          := st_attr.SearchCBDIdentityPhones;
	self.VelocityV4.BillToSearchOthAgeOldestRecord        := bt_attr.SearchNonCBDAgeOldestRecord;
	self.VelocityV4.ShipToSearchOthAgeOldestRecord        := st_attr.SearchNonCBDAgeOldestRecord;
	self.VelocityV4.BillToSearchOthAgeNewestRecord        := bt_attr.SearchNonCBDAgeNewestRecord;
	self.VelocityV4.ShipToSearchOthAgeNewestRecord        := st_attr.SearchNonCBDAgeNewestRecord;
	self.VelocityV4.BillToSearchOthCount                  := bt_attr.SearchOthCount;
	self.VelocityV4.ShipToSearchOthCount                  := st_attr.SearchOthCount;
	self.VelocityV4.BillToSearchOthCount01                := bt_attr.SearchOthCount01;
	self.VelocityV4.ShipToSearchOthCount01                := st_attr.SearchOthCount01;
	self.VelocityV4.BillToSearchLocateCount               := bt_attr.PRSearchLocateCount;
	self.VelocityV4.ShipToSearchLocateCount               := st_attr.PRSearchLocateCount;
	self.VelocityV4.BillToSearchLocateCount01             := bt_attr.PRSearchLocateCount01;
	self.VelocityV4.ShipToSearchLocateCount01             := st_attr.PRSearchLocateCount01;
	self.VelocityV4.BillToSearchRetailCount               := bt_attr.PRSearchRetailCount;
	self.VelocityV4.ShipToSearchRetailCount               := st_attr.PRSearchRetailCount;
	self.VelocityV4.BillToSearchRetailCount01             := bt_attr.PRSearchRetailCount01;
	self.VelocityV4.ShipToSearchRetailCount01             := st_attr.PRSearchRetailCount01;
	self.VelocityV4.BillToSearchOthAddrIdentity           := bt_attr.PRSearchAddrIdentities;
	self.VelocityV4.ShipToSearchOthAddrIdentity           := st_attr.PRSearchAddrIdentities;


	self.IdentityV1     := [];
	self.RelationshipV1 := [];
END;

out4 := ungroup(project( btst_clam, intoAttributes4(left) ));

out := case( version,
	1 => out1,
	4 => out4,
	dataset( [], Layout_CBDAttributes )
);

return out;

END;