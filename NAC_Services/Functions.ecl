IMPORT NAC_Services,NAC_V2_Services,ut,STD,AutoKeyI;
EXPORT FUNCTIONs := MODULE	

	EXPORT isMatchInputMet(STRING1 program_code,STRING6 in_month,STRING2 in_state,BOOLEAN hasNoPII) := FUNCTION
		hasNoDates := TRIM(in_month)='';
		in_date    := (STD.Date.Date_t)(in_month + '01');
		hasInValidDates	:= ~STD.Date.IsValidDate(in_date);

	  hasNoProgramCode      := program_code = '';
	  hasInValidProgramCode := program_code NOT IN NAC_V2_Services.Constants.SNAP_DSNAP_SET;
		
		// Config error - Because its auto-populated by MBS
	  hasNoSourceState := in_state = '';

		RETURN MAP(hasNoDates OR hasNoProgramCode OR hasNoPII => AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT
							,hasNoSourceState                           => AutoKeyI.errorcodes._codes.CONFIG_ERR
							,hasInValidDates OR hasInValidProgramCode   => AutoKeyI.errorcodes._codes.INVALID_INPUT
							,0);
	END;

	EXPORT concatenateTwelveMonthString(DATASET(NAC_Services.Layouts.nac_raw_rec) ds_in) := FUNCTION
		// The field twelve_month_history should be returned IN the format:
		//benefit_month1,benefit_month2,etc. ex - 201303,201302,201301"

		// Initialize twelve months history STRING with benefit_month
		ds_proj	:= PROJECT(ds_in, TRANSFORM(NAC_Services.Layouts.hist_roll_rec,
																		SELF.twelve_month_history := LEFT.benefit_month,
																		SELF := LEFT));

		NAC_Services.Layouts.hist_roll_rec xformRoll(NAC_Services.Layouts.hist_roll_rec L,
		                                             NAC_Services.Layouts.hist_roll_rec R) := TRANSFORM
			benefit_month_match_str		:= IF(L.benefit_month_matched = '', L.benefit_month, L.benefit_month_matched);
			SELF.benefit_month_matched:= benefit_month_match_str;
			                             // We don't want to repeat the same months over AND over
			benefitMonthIsOk	        := R.benefit_month NOT IN L.benefit_month_set AND R.benefit_month <> benefit_month_match_str AND 
			                             // The benefit month should be withIN 12 months of the benefit month matched
																	 ut.MonthsApart(R.benefit_month, benefit_month_match_str) < 12 AND 
																	 // The benefit month should be historical when compared to the benefit month matched
																	 R.benefit_month < benefit_month_match_str AND
																	 // Only 'E' (eligible) records are used for the rollup
																	 R.client_eligible_status_indicator = NAC_V2_Services.Constants.ELIGIBLE;
			SELF.benefit_month_set 		:= IF(L.benefit_month_set = [],
			                               [L.benefit_month],
																		  L.benefit_month_set) + IF(benefitMonthIsOk, [R.benefit_month], []);
			SELF.twelve_month_history	:= L.twelve_month_history + IF(benefitMonthIsOk, ',' + R.benefit_month, '');
			SELF := L;
		END;

		ds_sort := SORT(ds_proj, acctno, case_identifier, client_identifier, case_state_abbreviation, case_benefit_type, 
										// If the benefit_month is provided AND a match we want to favOR that month IN the rollup;
										//otherwise we want to keep the oldest month
										-isBenefitMonthMatch, -benefit_month, 
										// If benefit_type is provided we want that type to be favored IN the rollup
										-isBenefitTypeMatch,
										// If eligible status is provided we want that status to be favored IN the rollup
										-isEligibleStatusMatch);

		ds_rolled := ROLLUP(ds_SORT, LEFT.acctno = RIGHT.acctno AND 
																 LEFT.case_identifier = RIGHT.case_identifier AND
																 LEFT.client_identifier = RIGHT.client_identifier AND
																 LEFT.case_state_abbreviation = RIGHT.case_state_abbreviation AND
																 LEFT.case_benefit_type = RIGHT.case_benefit_type,
																 xformRoll(LEFT, RIGHT));

		ds_out := PROJECT(ds_rolled, NAC_Services.Layouts.nac_raw_rec);

		// Debug
	  #IF(NAC_Services.Constants.Debug)
			OUTPUT(ds_sort,  NAMED('pre_history_rollup'));
			OUTPUT(ds_rolled,NAMED('post_history_rollup'));
		#END
		RETURN ds_out;
	END;

	EXPORT norm_Nac2_to_Nac1(DATASET(NAC_V2_Services.Layouts.nac_raw_rec) Nac2recs) := FUNCTION
	  // Normalize range records to single month records
		// Can't normalize on LEFT.eligible_period_count_months for non 'E' records since they are set to 0
		Nac2_To_Nac1 := NORMALIZE(Nac2recs, IF(LEFT.eligibility_status_indicator=NAC_V2_Services.Constants.ELIGIBLE,
		                                       LEFT.eligible_period_count_months,
																					 STD.Date.MonthsBetween(LEFT.eligibility_period_start,LEFT.eligibility_period_end)+1),
											TRANSFORM(NAC_Services.Layouts.nac_raw_rec,
											// Go from ex - ranges 20140516-20140822 TO months - 201405,201406,201407,201408
												str_month:= ((STRING)STD.date.AdjustDate(LEFT.eligibility_period_start,,COUNTER-1))[..6];
												month:= (UNSIGNED)str_month;
												SELF.benefit_month:= str_month;
												SELF.case_benefit_month:= str_month; 
												SELF.case_state := LEFT.case_program_state;
												SELF.case_state_abbreviation := LEFT.case_program_state;
												SELF.case_benefit_type := LEFT.case_program_code;
												SELF.client_eligible_status_indicator := LEFT.eligibility_status_indicator;
												SELF.client_eligible_status_date := LEFT.eligibility_status_date;
												SELF.isBenefitMonthMatch := ( LEFT.nac1_in_month = str_month) AND
																			// OR if we are using benefit_month interval AND it is a match
																			(LEFT.nac1_in_start_month = '' AND LEFT.nac1_in_end_month = '' OR 
																									(month >= (UNSIGNED)LEFT.nac1_in_start_month AND 
																									 month <= (UNSIGNED)LEFT.nac1_in_end_month));
												SELF:=LEFT;
												SELF:=[]));
		// Debug
	  #IF(NAC_Services.Constants.Debug)
			OUTPUT(Nac2recs,     NAMED('Nac2recs'));
			OUTPUT(Nac2_To_Nac1, NAMED('Nac2_To_Nac1'));
		#END
		RETURN Nac2_To_Nac1;
	END;

END;