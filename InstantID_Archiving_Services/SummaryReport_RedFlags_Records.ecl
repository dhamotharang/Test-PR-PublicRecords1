import iesp, InstantID_Archiving, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
		-	retrieves data for the summaryReport_RedFlags
		- runs standalone
		- minimum criteria is start date otherwise functions will set a default value
		- retrieves data from deltabase and keys to run algorithms on the data to put it in a statistical format
		- RedFlags can be ran standalone - it will run combining the results of Instantid
*/
EXPORT SummaryReport_RedFlags_Records := MODULE
    	
	EXPORT doSummaryRedFlagsReport(IParam.summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways ) := MODULE
	// ---------------[ Via DeltaBase ]---------------
		SHARED ds_RI_deltabase_recs := Raw.summaryRedflagsViaDeltaBase(in_mod, dGateways);		
		// ---------------[ Via Roxie ]---------------
		SHARED ds_redflag_from_keys := raw.summaryRedflagsViakeys(in_mod);
	  SHARED RF_Error := MAP(in_mod.CompanyId = '' => Doxie.ErrorCodes(301),
					ds_RI_deltabase_recs.Exceptions.exceptions[1].message != '' => ds_RI_deltabase_recs.Exceptions.exceptions[1].message,
					ds_redflag_from_keys.Exceptions.exceptions[1].message != '' => ds_redflag_from_keys.Exceptions.exceptions[1].message,
					'');
		// ---------------[ Union, sort, dedup ]---------------
		SHARED ds_all_redflags_recs_filtered := ds_RI_deltabase_recs(cvi >= '0') + ds_redflag_from_keys(cvi >= '0') ;
		//we do upper here to ensure we have the same case on the risk_code. Below we will do upper to maintain
		// it when matching on risk code.
		ds_all_redflags_recs :=
			DEDUP( 
				SORT( 
					(ds_all_redflags_recs_filtered), 
					transaction_id, cvi, StringLib.StringToUppercase(risk_code)
				), 
				transaction_id, cvi, StringLib.StringToUppercase(risk_code) 
			);
		tbl_transactions := TABLE( ds_all_redflags_recs, {transaction_id, cvi}, transaction_id, cvi );
		
		count_transactions := COUNT( tbl_transactions );
			
		// Count the Risk Indicators per cvi value...		
		ds_RIs_by_cvi := TABLE( ds_all_redflags_recs, {cvi, risk_code, cnt := COUNT(GROUP)}, cvi,risk_code );
		ds_RIs_by_cvi_counts := PROJECT(ds_RIs_by_cvi, Layouts.cvi_riskcode_counts);
		
		// And count the Risk Indicators regardless of cvi value, for cvi = Constants.ForAll.
		ds_RIs_all := TABLE( ds_all_redflags_recs, {risk_code, cnt := COUNT(GROUP)}, risk_code );
		ds_RIs_all_counts := PROJECT(ds_RIs_all,TRANSFORM(Layouts.cvi_riskcode_counts, 
					SELF.cvi := Constants.ForAll, SELF := LEFT ) );

		ds_RIs_combined_counts := ds_RIs_by_cvi_counts + ds_RIs_all_counts;
		
		// ...and calculate percentages.		
		ds_RIs_by_cvi_percentage :=
			PROJECT(
				ds_RIs_combined_counts,
				TRANSFORM(Layouts.RI_elements,
					SELF.cvi := LEFT.cvi,
					SELF.Value := LEFT.risk_code,
					SELF.Percent := (LEFT.cnt / count_transactions) * 100,
					SELF.Description := Constants.RiskIndicatorElements(value = LEFT.risk_code)[1].description;
				)
			);

		// Finally, join the actual data to the categories.
					
		ds_categorized_data :=
			JOIN(
				Constants.ds_all_categories, ds_RIs_by_cvi_percentage,
				StringLib.StringToUppercase(LEFT.cvi) = StringLib.StringToUppercase(RIGHT.cvi) AND
				StringLib.StringToUppercase(LEFT.value) = StringLib.StringToUppercase(RIGHT.value),
				TRANSFORM(Layouts.redflags_flat,
					SELF.cvi          := LEFT.cvi;
					SELF.redflag_id   := LEFT.redflag_id;
					SELF.redflag_desc := LEFT.redflag_desc;
					SELF.value        := LEFT.value;
					SELF.percent      := RIGHT.percent;
					SELF.description  := LEFT.description;
				),
				LEFT OUTER
			);

		// Begin rolling up data.
		ds_categorized_data_grpd :=
			GROUP( SORT( ds_categorized_data, cvi, (UNSIGNED)redflag_id ), cvi, (UNSIGNED)redflag_id );
		
		// First roll up Risk Indicators.		
		Layouts.t_RedFlagsElement_plus_cvi_redflags 
				doRollup_1(Layouts.redflags_flat l, DATASET(Layouts.redflags_flat) allRows) :=
					TRANSFORM
							decimal5_2 sum_percentage := SUM( allRows, percent );
							decimal5_2 ceiling := 100;
						SELF.cvi := l.cvi;
						SELF.redflag_id := l.redflag_id;
						SELF.Name := l.redflag_desc;
						SELF.Percent := MIN( sum_percentage, ceiling );
						SELF.RiskIndicators :=
							PROJECT(
								allRows, 
								TRANSFORM( iesp.iidsummary_share.t_ReportElementEx,
									SELF.Value := LEFT.value,
									SELF.Percent := LEFT.percent,
									SELF.Description := LEFT.description
								)	);
					END;
		
		ds_rollup_1 := 
			ROLLUP(
				ds_categorized_data_grpd,
				GROUP,
				doRollup_1(LEFT, ROWS(LEFT))
			);
		
		// Next, project the Risk Indicators into the RedFlags child dataset.
		iesp.iidredflagsummary.t_RedFlagsSummary 
				xfm_into_redflags(Layouts.t_RedFlagsElement_plus_cvi_redflags le) := 
					TRANSFORM
						SELF.ComprehensiveVerificationIndex := le.cvi;
						SELF.NumberOfCases := 0;
						SELF.Percent := 0;
						SELF.RedFlags := 
							PROJECT( 
								le, 
								TRANSFORM( iesp.iidredflagsummary.t_RedFlagsElement, 
									SELF.Name := le.Name,
									SELF.Percent := le.Percent,
									SELF.RiskIndicators := le.RiskIndicators,
								) 
							);
					END;
					
		ds_rollup_2_pre := PROJECT( ds_rollup_1, xfm_into_redflags(LEFT) );
		// Then roll up the RedFlags child datasets within each cvi value (0, 10, 20, 30, 40, 50, ALL).
		iesp.iidredflagsummary.t_RedFlagsSummary 
				doRollup_2(iesp.iidredflagsummary.t_RedFlagsSummary le, iesp.iidredflagsummary.t_RedFlagsSummary ri) := 
					TRANSFORM
						SELF.ComprehensiveVerificationIndex := ri.ComprehensiveVerificationIndex;
						SELF.NumberOfCases := 0;
						SELF.Percent := 0;
						SELF.RedFlags := le.RedFlags + ri.RedFlags;
					END;
					
		ds_rollup_2 := 
			ROLLUP(
				ds_rollup_2_pre,
				LEFT.ComprehensiveVerificationIndex = RIGHT.ComprehensiveVerificationIndex,
				doRollup_2(LEFT, RIGHT)
			);
			
		rec_redflags := RECORD
			iesp.iidredflagsummary.t_RedFlagsSummary ;
			INTEGER order := 0;
		END;

		// Now do some basic math and finish the RedFlags summary data.
		rec_redflags 
				xfm_add_num_cases(iesp.iidredflagsummary.t_RedFlagsSummary le) :=
					TRANSFORM
							num_cases := COUNT( tbl_transactions(cvi = le.ComprehensiveVerificationIndex) );
						SELF.NumberOfCases := IF(StringLib.StringToUppercase(le.ComprehensiveVerificationIndex) = StringLib.StringToUppercase(Constants.ForAll),
											COUNT(tbl_transactions), num_cases);
						SELF.Percent       := (SELF.NumberOfCases / count_transactions) * 100;
						SELF               := le;
					END;
			
		ds_redflags_summary_tmp := PROJECT( ds_rollup_2, xfm_add_num_cases(LEFT) );
	
		ds_redflags_summary_for_sort := JOIN(ds_redflags_summary_tmp, Constants.cviTypes,
			StringLib.StringToUppercase(LEFT.ComprehensiveVerificationIndex) = StringLib.StringToUppercase(RIGHT.CVI),
			TRANSFORM(rec_redflags, SELF.Order := RIGHT.Order, SELF := LEFT));
		
		ds_redflags_summary_sorted := SORT(ds_redflags_summary_for_sort, ORDER);
     
		ds_redflags_summary := PROJECT(ds_redflags_summary_sorted, TRANSFORM(iesp.iidredflagsummary.t_RedFlagsSummary, SELF := LEFT));
		// Final packaging for output. 	
		EXPORT RedflagsSummary := ds_redflags_summary;
    Iesp.iidredflagsummary.t_RedFlagsSummaryResult createRedFlagsResult() :=
			TRANSFORM
				SELF.RedFlagsSummary := CHOOSEN(RedflagsSummary, iesp.Constants.IIDReporting.MaxRedFlagsSummary);
			END;
		
		EXPORT rw_redFlagResult := ROW(createRedFlagsResult());
		iesp.iidredflagsummary.t_RedFlagsSummaryReportResponse createResponse() :=
			TRANSFORM
				SELF._Header                := iesp.ECL2ESP.GetHeaderRow();
				SELF.Result									:= rw_redFlagResult;
			END;

		rw_Response_tmp := ROW(createResponse());

		// Debugs:
		// EXPORT RIs_combined_counts := ds_RIs_combined_counts;
		// EXPORT RIs_by_cvi_percentage := ds_RIs_by_cvi_percentage;
		// EXPORT rollup_1 := ds_rollup_1;
		// EXPORT rollup_2_pre := ds_rollup_2_pre;
		// EXPORT rollup_2 := ds_rollup_2;

		// Exportables:		
			
		rw_Response := if(RF_Error != '',
					Macros.mac_GetDisplayRowErrors(RF_Error, iesp.iidredflagsummary.t_RedFlagsSummaryReportResponse),
					rw_Response_tmp);

		EXPORT Response        := rw_Response;
    EXPORT RedFlagsError   := RF_Error;	
	END;

END;