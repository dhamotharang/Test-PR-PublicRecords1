import iesp, InstantID_Archiving, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the summaryReport_InstantIdInternational
	- runs standalone
	- minimum criteria is start date otherwise functions will set a default value
	- retrieves data from deltabase and keys to run algorithms on the data to put it in a statistical format
*/
EXPORT SummaryReport_IIDI2_Records := MODULE
	EXPORT doSummaryIIDI2Report(IParam.IIDI2_summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		ds_DB_iidi_ivi := Raw.summaryIIDI2iviViaDeltaBase(in_mod, dGateways);
		ds_keys_for_iidi_ivi := Raw.summaryIIDI2IVIViakeys(in_mod);	
		ds_combined_iidi_all := ds_DB_iidi_ivi + ds_keys_for_iidi_ivi;
		ds_combined_iidi := ds_combined_iidi_all(ivi != '');
		ds_iidi_trans_deduped := DEDUP(SORT(ds_combined_iidi, transaction_id, ivi), transaction_id,ivi);

		//count how many unique rows there are	
		iidi_trans_cnt := count(ds_iidi_trans_deduped);
		//-------------------------------IIDI - IVI SUMMARY header --------------------------			
		//Group by IVI value and then set the counts for the summary header
		tbl_ivi_cnts := table(ds_iidi_trans_deduped, {ivi, ivicnt:=count(group)}, ivi); 
		cnt_ivi := SUM(tbl_ivi_cnts, ivicnt);		
		ds_all_ivi_types :=	 join(Constants.iviTypes, tbl_ivi_cnts,
			LEFT.ivi = RIGHT.ivi,
			TRANSFORM(Layouts.iviInfo, 
										SELF.ivi := LEFT.ivi, 
										SELF.ivi_cnt := if(LEFT.ivi = Constants.ForAll, cnt_ivi, RIGHT.ivicnt),
										SELF.ivi_total := cnt_ivi,
										SELF.order := LEFT.order),
		 LEFT OUTER);
		 ds_all_ivi_types_sorted := SORT(ds_all_ivi_types, order);
		//fills in the CVI summary header
		ds_ivi_base := project(ds_all_ivi_types_sorted, transform(iesp.iidi2summary.t_InstantIDIntl2IVIRiskIndicatorSummary, 
					SELF.Percent := (LEFT.ivi_cnt / LEFT.ivi_total) *100; 
					SELF.NumberOfCases := LEFT.ivi_cnt,
					SELF.IVIIndex := LEFT.ivi,
					self := [];//RiskIndicators
					));
		//-------------------------------IIDI - IVI SUMMARY counts --------------------------						
		//Get the counts by IVI and Risk code
		ds_iidi_ivi_deduped := DEDUP(SORT(ds_combined_iidi, transaction_id, ivi, StringLib.StringToUppercase(risk_code)),
			transaction_id,ivi, StringLib.StringToUppercase(risk_code));
		//gets the counts for each risk code per ivi value	
		tbl_ivi_riskCode_cnts := table(ds_iidi_ivi_deduped, {ivi, risk_code, ivi_cnt:=count(group)}, ivi, risk_code); 
		//get the counts per risk code for the ALL column
		tbl_riskCode_cnts := table(ds_iidi_ivi_deduped, {risk_code, description, risk_cnt:=count(group)}, risk_code, description); 
		//Makes the IVI ALL for the ALL column
		ds_ALL_percents := PROJECT(tbl_riskCode_cnts,			
			TRANSFORM(Layouts.IIwithReportElementX, 
				SELF.IVI := Constants.ForAll,//ALL
				SELF.VALUE := LEFT.RISK_CODE,
				SELF.Percent := ((INTEGER) LEFT.risk_cnt / iidi_trans_cnt) *100,
				SELF.Description := LEFT.Description));	
		ds_sorted_All_Percents := SORT(ds_ALL_percents, -Percent, RECORD);		
		Layouts.IIwithReportElementX AddIID_Order(Layouts.IIwithReportElementX L, INTEGER C):= TRANSFORM
				SELF.Order := c;
				SELF := L;
		END;
		ds_All_PercentsWithOrder := PROJECT(ds_sorted_All_Percents, AddIID_Order(LEFT, COUNTER));
		//gets the percents for all the nonALL IVI values		
		//but only show the risk codes the client received back but for all ivi values	
		ds_found_risks_for_ivis := JOIN(tbl_riskCode_cnts, ds_ivi_base(IVIIndex != Constants.ForAll),
			TRUE,
			TRANSFORM(Layouts.IIwithReportElementX, 
				SELF.IVI := RIGHT.IVIIndex;
				self.value := LEFT.risk_code;
				SELF.CNT := RIGHT.NumberOfCases;
				SELF.percent := 0;
				SELF.Description := LEFT.Description),
			LEFT OUTER, ALL, KEEP(Constants.MAX_COUNT_RECORDS));
		ds_row_percents := JOIN(ds_found_risks_for_ivis,	tbl_ivi_riskCode_cnts	,
				LEFT.IVI = RIGHT.IVI AND
				StringLib.StringToUppercase(LEFT.VALUE) = StringLib.StringToUppercase(RIGHT.Risk_Code),
				TRANSFORM(Layouts.IIwithReportElementX, 
					SELF.IVI := LEFT.ivi;
					self.value := LEFT.value;
					SELF.CNT := LEFT.CNT;
					SELF.percent := ((INTEGER) RIGHT.IVI_cnt / (INTEGER) LEFT.CNT) *100,
					SELF.Description := LEFT.Description),
				LEFT OUTER);	
		ds_row_percentsWithOrder := JOIN(ds_All_PercentsWithOrder, ds_row_percents,
			StringLib.StringToUppercase(LEFT.value) = StringLib.StringToUppercase(RIGHT.Value),
			TRANSFORM(Layouts.IIwithReportElementX,
					SELF.Order := LEFT.Order,
					SELF := RIGHT));
		ds_percent_for_all_rows := ds_All_PercentsWithOrder + ds_row_percentsWithOrder;
		ds_rows_sorted := SORT(ds_percent_for_all_rows, IVI, Order);
		//Creates the InstantIDIntl2IVIRiskIndicatorSummary section of the report
		ds_iviReport := PROJECT(ds_ivi_base, transform(iesp.iidi2summary.t_InstantIDIntl2IVIRiskIndicatorSummary, 
						SELF.Percent := LEFT.Percent, 
						SELF.NumberOfCases := LEFT.NumberOfCases,
						base_iviIndex :=	LEFT.IVIIndex;	
						SELF.IVIIndex := base_iviIndex,
						SELF.RiskIndicators := PROJECT(ds_rows_sorted(IVI = base_iviIndex),
								TRANSFORM(iesp.iidsummary_share.t_ReportElementEx,
									SELF.Percent := LEFT.Percent,
									SELF.value := LEFT.Value,
									SELF.Description := LEFT.Description));
						));		
		ds_DB_verified := Raw.summaryIIDI2VerifiedViaDeltaBase(in_mod, dGateways);	
		ds_key_verified := Raw.summaryIIDI2VerifiedViakeys(in_mod);
		ds_verified := ds_DB_verified + ds_key_verified;

		//We need the names associated with each transaction to give the counts correctly but at this point we dont't
		// need to include the source_count.
		ds_iidi_verified_deduped := DEDUP(SORT(ds_verified, transaction_id, name), transaction_id, name);
		//get counts for each name per source
		tbl_verified_cnts := table(ds_iidi_verified_deduped, {name, source_count, src_cnt :=count(group)}, name, source_count); 	
		tbl_verifiedname_cnts := table(ds_iidi_verified_deduped((integer) Source_count >= 1), {name, src_cnt :=count(group)}, name); 
		
		// Verified fields per Country
  inCountry := trim(UnicodeLib.UnicodeToUpperCase(in_mod.CountryId));
		VerifiedLayout := map(inCountry = InstantID_Archiving_Services.Constants.Australia => Constants.iidi2_Australia_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Austria => Constants.iidi2_Austria_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Brazil => Constants.iidi2_Brazil_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Canada => Constants.iidi2_Canada_Elements,
													inCountry = InstantID_Archiving_Services.Constants.China => Constants.iidi2_China_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Germany => Constants.iidi2_Germany_Elements,
													inCountry = InstantID_Archiving_Services.Constants.HongKong => Constants.iidi2_Hong_Kong_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Ireland => Constants.iidi2_Ireland_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Japan => Constants.iidi2_Japan_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Luxembourg => Constants.iidi2_Luxembourg_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Mexico => Constants.iidi2_Mexico_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Netherlands => Constants.iidi2_Netherlands_Elements,
													inCountry = InstantID_Archiving_Services.Constants.NewZealand => Constants.iidi2_New_Zealand_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Singapore => Constants.iidi2_Singapore_Elements,
													inCountry = InstantID_Archiving_Services.Constants.SouthAfrica => Constants.iidi2_South_Africa_Elements,
													inCountry = InstantID_Archiving_Services.Constants.Switzerland => Constants.iidi2_Switzerland_Elements,
													inCountry = InstantID_Archiving_Services.Constants.UnitedKingdom => Constants.iidi2_United_Kingdom_Elements,
																										 InstantID_Archiving_Services.Constants. iidi_verifiedElements); //old layout, leave here? Shouldn't ever hit it.
		//gets the counts for each source type 
		ds_srcCnt_Eq_one := Macros.mac_GetIIDI2Counts(tbl_verified_cnts((INTEGER) Source_count = 1), iidi_trans_cnt, '2', VerifiedLayout); 
		ds_srcCnt_Eq_two := Macros.mac_GetIIDI2Counts(tbl_verified_cnts((INTEGER) Source_count = 2), iidi_trans_cnt, '3', VerifiedLayout);
		ds_srcCnt_Eq_three := Macros.mac_GetIIDI2Counts(tbl_verified_cnts((INTEGER) Source_count > 2), iidi_trans_cnt, '4', VerifiedLayout);
		ds_srcCnt_overall := Macros.mac_GetIIDI2Counts(tbl_verifiedname_cnts, iidi_trans_cnt, '1', VerifiedLayout); 
		//append the all the sources together	
		ds_src_cnt := ds_srcCnt_Eq_one + ds_srcCnt_Eq_two + ds_srcCnt_Eq_three + ds_srcCnt_overall;
		//get the hard coded verbage and description for a good join match
		ds_verified_names_tmp := JOIN(Constants.iidi_Matching_sources, ds_src_cnt, 
			LEFT.Value = RIGHT.Value,
			TRANSFORM(Layouts.rec_src_cnts, SELF.Description := LEFT.Description, SELF := RIGHT),
				LEFT OUTER);
		//put in the output layout		
		ds_verified_names :=PROJECT(VerifiedLayout, 
					TRANSFORM(iesp.iidi2summary.t_InstantIDIntl2FieldVerification, 
					tmpFieldVerification := LEFT.Description;
					SELF.FieldName := tmpFieldVerification, 				
					SELF.MatchingSources := PROJECT(ds_verified_names_tmp(FieldVerification = tmpFieldVerification), 	
						TRANSFORM(iesp.iidsummary_share.t_ReportElementEx,
									SELF.Description := TRIM(LEFT.Description, LEFT, RIGHT),
									SELF.Percent := LEFT.Percent,
									SELF :=  []
									));
					)); 
		iesp.iidi2summary.t_InstantIDIntl2SummaryResult CreateiidiResult() := TRANSFORM
			SELF.IVIRiskIndicatorSummary := CHOOSEN(ds_iviReport, iesp.Constants.IIDReporting.MaxIVIRiskIndicators);
			SELF.FieldVerification := CHOOSEN(ds_verified_names, iesp.Constants.IIDReporting.MaxFieldVerification);
		END;
		rw_iidi_SummaryResult := ROW(CreateiidiResult());
		iesp.iidi2summary.t_InstantIDIntl2SummaryReportResponse CreateiidiResponse() := TRANSFORM
			SELF.Result := rw_iidi_SummaryResult;
			SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
		END;		
		
		rw_iidi_SummaryResponse := ROW(CreateiidiResponse());
		iidi_summary_reponse_errors := MAP(in_mod.CompanyId = '' or in_mod.CountryId = '' => Doxie.ErrorCodes(301),
			ds_DB_iidi_ivi.Exceptions.exceptions[1].message != '' => ds_DB_iidi_ivi.Exceptions.exceptions[1].message,
			ds_keys_for_iidi_ivi.Exceptions.exceptions[1].message != '' => ds_DB_iidi_ivi.Exceptions.exceptions[1].message,
			'');
		
		rw_iidi_Summary_Response :=	if(iidi_summary_reponse_errors != '', 
					Macros.mac_GetDisplayRowErrors(iidi_summary_reponse_errors, iesp.iidi2summary.t_InstantIDIntl2SummaryReportResponse),
					rw_iidi_SummaryResponse);
					
		//**************Testing Outputs**********************
		// output(ds_DB_iidi_ivi);
		// output(ds_keys_for_iidi_ivi, named('ds_keys_for_iidi_ivi'));
		// output(ds_iidi_trans_deduped, named('ds_iidi_trans_deduped'));
		// output(ds_ivi_base, named('ds_ivi_base'));
		// output(ds_DB_verified, named('ds_DB_verified'));
		// output(ds_key_verified, named('ds_key_verified'));
		// output(tbl_verified_cnts,named('tbl_verified_cnts'));
		// output(ds_verified_names_tmp,named('ds_verified_names_tmp'));
		// output(ds_verified_names,named('ds_verified_names'));
		//***************************************************		
		
		RETURN rw_iidi_Summary_Response;

	END;
END;