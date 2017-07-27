/*2013-10-14T16:07:02Z (Andi Koenen)
RR: 132414 and 131247: added companyId as required field
*/
import iesp, InstantID_Archiving, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the summaryReport_FraudPoint
	- FraudPoint can be ran standalone - it will run combining the results of Flexid and Instantid
	- FraudPoint can be an option on the summaryReport_Flexid and summaryReport_Instantid, 
					it will run for the appropriate products
*/
EXPORT SummaryReport_FraudPoint_Records := MODULE

EXPORT doSummary_FraudPointReport(IParam.summary_params in_mod, string20 ProductType = Constants.Both, 
						DATASET(Gateway.Layouts.Config) dGateways ) := MODULE

		//we don't have a way to figure out which product to run when stand alone so we union Flexid and 
		//Instantid together, which is why we use BOTH.
	//-----------------------CVI Fraud Point Warning Code  --------------------------	
		SHARED ds_db_Cvi_fraudPt := Raw.summaryFraudPtCVIViaDeltaBase(in_mod, ProductType, dGateways);
		SHARED FraudPointDB_Error := ds_db_Cvi_fraudPt.Exceptions.exceptions[1].message;
		SHARED ds_db_FdPTRpt_fraudPt := Raw.summaryFraudPtRptViaDeltaBase(in_mod, ProductType, dGateways);
		SHARED FraudPointRptDB_Error := ds_db_FdPTRpt_fraudPt.Exceptions.exceptions[1].message;
		SHARED ds_db_FRiskIndexiid := Raw.summaryFraudRiskIndexViaDeltaBase(in_mod, ProductType, dGateways);	
		SHARED FraudPointIndxDB_Error := ds_db_FRiskIndexiid.Exceptions.exceptions[1].message;	
		//Get the archived data from the keys 
		SHARED ds_keys_FdPT_CVI_keys := RAW.summaryFraudPtCVISummaryViakeys(in_mod, ProductType);
		SHARED FdPT_CVI_keys_error := ds_keys_FdPT_CVI_keys.Exceptions.exceptions[1].message;
		SHARED ds_combined_recs := ds_db_Cvi_fraudPt + ds_keys_FdPT_CVI_keys;
		//only want counts at the transaction level, which means don't include risk_code
		SHARED ds_fraudPt_trans_deduped := DEDUP(SORT(ds_combined_recs, transaction_id, cvi), transaction_id, cvi);
		SHARED frdpt_trans_cnt := COUNT(ds_fraudPt_trans_deduped);
		//-------------------------------FraudPt - CVI SUMMARY header --------------------------	
		ds_cvi_header :=Macros.mac_GetCVISummary( ds_fraudPt_trans_deduped, iesp.iidfraudpointsummary.t_CVIFraudPointWarningSummary)	;	
		//-----------------------FraudPt - CVI SUMMARY - Warning Codes----------------------
		//changed dedupe to not just be trans id	
		//want to ensure risk code is all case...it's maintained through rest of process when checked
		ds_fraudPt_CVI_deduped := DEDUP(SORT(ds_combined_recs(risk_code != ''), transaction_id, cvi, StringLib.StringToUppercase(risk_code)),
			transaction_id, cvi, StringLib.StringToUppercase(risk_code));	
		//gets the counts for the break down of the non-ALL rows			
		tbl_fraudPt_cnts := table(ds_fraudPt_CVI_deduped, {cvi, value := risk_code, cvi_cnt:=count(group)}, cvi, risk_code); 			//gets the counts for the break down of the ALL rows	
		tbl_riskCode_cnts := table(ds_fraudPt_CVI_deduped, {value := risk_code, description, cnt:=count(group)}, risk_code);
		ds_fraudPt_Cnts :=Macros.mac_GetCnts_withOrder(tbl_riskCode_cnts, tbl_fraudPt_cnts, Layouts.CVIwithReportElementXWithSeq, ds_cvi_header, frdpt_trans_cnt );		
		//-----------------------FraudPt - t_CVIFraudPointWarningSummary----------------------
		SHARED ds_FRPt_cviReport := project(ds_cvi_header, transform(iesp.iidfraudpointsummary.t_CVIFraudPointWarningSummary, 
						SELF.Percent := LEFT.Percent, 
						SELF.NumberOfCases := LEFT.NumberOfCases,
						header_cvi := LEFT.ComprehensiveVerificationIndex;
						SELF.ComprehensiveVerificationIndex := header_cvi,				
						SELF.FraudPointWarnings :=PROJECT(ds_fraudPt_Cnts(cvi = header_cvi), 
									TRANSFORM(iesp.iidsummary_share.t_ReportElementEx,
										SELF.Percent := LEFT.Percent,
										SELF.description := LEFT.description,
										SELF.Value := LEFT.Value)))) ;
	//--------------------------------------fraud pt Report----------------
		
		//Get the archived data from the keys
		SHARED ds_keys_FdPTRpt_fraudPt := RAW.summaryFraudPtReportViakeys(in_mod, ProductType);
		SHARED FdPTRpt_fraudPt_error := ds_keys_FdPTRpt_fraudPt.Exceptions.exceptions[1].message;	
		ds_combined_fdPTRpt_all_scores := ds_db_FdPTRpt_fraudPt + ds_keys_FdPTRpt_fraudPt;
		ds_combined_fdPTRpt := ds_combined_fdPTRpt_all_scores(score != '' and score >= '0');
		//find the largest score so we can determine the score_type - batch doesn't return score type
		// We do it in ECL because the changes to batch seemed to raise too high of a risk right now for their clients
		ds_maximum_score := MAX(ds_combined_fdPTRpt, (INTEGER) ds_combined_fdPTRpt.Score);
		SHARED ds_of_score_types := PROJECT(ds_combined_fdPTRpt, 
							TRANSFORM(Layouts.FraudPt_Records, 
							SELF.Score_Type := MAP(LEFT.Score_type = '' and (integer) LEFT.score > 90 => '0 to 999',
																		 //If a score greater than > 50 exists, with no scores above 90 then the score type is 10 -90. 
																		 LEFT.Score_type = '' and (integer) LEFT.score > 50 and ds_maximum_score <= 90 => '10 to 90', 
																		 //If a score less than < 50 exists, with no scores above 90 then the score type is 10 -50. 
																		 LEFT.Score_type = '' and (integer) LEFT.score <= 50 and ds_maximum_score <= 50 => '10 to 50',
																		 LEFT.score_type); 
							SELF := LEFT));
		//check to see if the client ran more than 1 type of model in the specified time range
		//if any are blank bc we couldn't figure out what they are they will be blank and will count as score_range
		tbl_fraud_score_Type := TABLE(ds_of_score_types, {score_Type}, score_Type);
		SHARED CntOfScoreType := COUNT(tbl_fraud_score_Type);		
		//gets the count of valid transactions that have a valid score
		ds_fraudPt_FdPTRpt_deduped := DEDUP(SORT(ds_of_score_types, transaction_id, StringLib.StringToUppercase(risk_code), score), 
				transaction_id, StringLib.StringToUppercase(risk_code), score);		
		//put scores in buckets that represent the score ranges for all records
		//only want the unique transaction ids for the header
		TypeOfScore := ds_fraudPt_FdPTRpt_deduped[1];
		//determine which score is used so we can grab the header information
		Score_model := CASE(TypeOfScore.score_type, '10 to 50' => Constants.ScoreTypes_50,
			'10 to 90' => Constants.ScoreTypes_90,
			 Constants.ScoreTypes); 
		//get the "type" field populated based on the score model
		ds_FraudPt_999 := PROJECT(ds_fraudPt_FdPTRpt_deduped, transforms.xfm_GetFraudPtRpt(left));
		ds_FraudPt_50 := PROJECT(ds_fraudPt_FdPTRpt_deduped, transforms.xfm_GetFraudPtRpt_50(left));
		ds_FraudPt_90 := PROJECT(ds_fraudPt_FdPTRpt_deduped, transforms.xfm_GetFraudPtRpt_90(left));
		//only run the model that is being used
		ds_FraudPt_all := CASE(TypeOfScore.score_type, '10 to 50' => ds_FraudPt_50,
				'10 to 90' => ds_FraudPt_90,
				ds_FraudPt_999); 
		//transaction level data for model type
		ds_FraudPt_slim_deduped := DEDUP(SORT(ds_FraudPt_all, transaction_id), transaction_id);
		cnt_fraudPtType := COUNT(ds_FraudPt_slim_deduped);
		//count based on the score buckets
		tbl_fraud_type_cnts := TABLE(ds_FraudPt_slim_deduped, {type, typeCnt := count(group)}, type);
		//gets the header info into header format
		sorted_scores := SORT(Score_model, type);
		ds_fraudPtRpt_Hdr :=	JOIN(sorted_scores, tbl_fraud_type_cnts,
			LEFT.type = RIGHT.type,
			TRANSFORM(iesp.iidfraudpointsummary.t_FraudPointSummary,
				SELF.Score := LEFT.Score,
				// Type of 1 below is ALL
				SELF.NumberOfCases := IF(LEFT.Type = 1, cnt_fraudPtType, RIGHT.typeCnt),
				SELF.Percent := ((SELF.NumberOfCases / cnt_fraudPtType) * 100),
				SELF := []), //fraudpointWarnings
			LEFT OUTER);	
			//gets counts per risk code per type (range)
		tbl_fraud_typeRisk_cnts := table(ds_FraudPt_all, {type, risk_code, typeCnt := count(group)}, type, risk_code);
		tbl_fraud_Risk_cnts := table(ds_FraudPt_all, {risk_code, description, RiskCnt := count(group)}, risk_code, description);
		//gets the percentages for the ALL column now that we have an ALL RiskCodes		
		ds_ALL_percents := PROJECT(tbl_fraud_Risk_cnts,			
			TRANSFORM(Layouts.ScoreInfo, 
				SELF.Score := Constants.ForAll,//ALL
				SELF.Type := 1,
				SELF.score_cnt := (INTEGER) LEFT.RiskCnt,
				SELF.Risk_code := LEFT.Risk_code,
				SELF.Percent := ((INTEGER) SELF.score_cnt / frdpt_trans_cnt) *100,
				SELF.Description := LEFT.Description,
				SELF.Order := 0));
		//Need ALL to be ordered by Percent Descending
		ds_ALL_percents_sorted := SORT(ds_ALL_percents, -Percent, RECORD);
		//Set the order field
		Layouts.ScoreInfo AddFP_Order(Layouts.ScoreInfo L, INTEGER C):= TRANSFORM
					SELF.Order := c;
					SELF := L;
		END;	
		//Add order to output
		ds_All_PercentsGetOrder := PROJECT(ds_ALL_percents_sorted, AddFP_Order(LEFT, COUNTER));	
		//get all values from ALL and add them to all possible CVI values
		ds_All_output := JOIN(ds_All_PercentsGetOrder, sorted_scores,
				TRUE,
				TRANSFORM(Layouts.ScoreInfo,
					SELF.Type := RIGHT.Type,
					SELF.Score := RIGHT.Score,
					SELF.Risk_code := LEFT.Risk_code,
					SELF.Percent := if(RIGHT.Type = 1, LEFT.Percent, 0);
					SELF.score_cnt := 0,
					SELF.description := LEFT.Description,
					self := left),
					LEFT OUTER, ALL, KEEP(Constants.MAX_COUNT_RECORDS));
		//Join the counts with the Score header counts to so we can get correct percentages
		ds_typeRisk_cnts :=	JOIN(tbl_fraud_typeRisk_cnts,  tbl_fraud_type_cnts,
			left.Type = RIGHT.Type,
			TRANSFORM(Layouts.ScoreInfo, 
				SELF.Score := '',
				SELF.Type := LEFT.Type,
				SELF.score_cnt := LEFT.typeCnt,
				SELF.Risk_code := LEFT.Risk_code,
				SELF.Percent := ((INTEGER) LEFT.typeCnt / (INTEGER) RIGHT.typeCnt) *100),
				LEFT OUTER);	
		ds_fraud_typeRisk_cnts :=	JOIN(ds_All_output, ds_typeRisk_cnts,
			LEFT.Type = RIGHT.Type and 
				StringLib.StringToUppercase(LEFT.Risk_code) = StringLib.StringToUppercase(RIGHT.Risk_code),
			TRANSFORM(Layouts.ScoreInfo, 
				SELF.Score := LEFT.Score,
				SELF.Type := LEFT.Type,
				SELF.score_cnt := 0,
				SELF.Risk_code := LEFT.Risk_code,
				SELF.Percent := IF(LEFT.Type = 1, LEFT.Percent, RIGHT.Percent),
				SELF.Order := LEFT.Order,
				SELF.description := LEFT.Description),
				LEFT OUTER);		
		ds_fraud_typeRisk_sorted := SORT(ds_fraud_typeRisk_cnts, Score, Order);
		//add all the row information together			
		//fill in the summary data
		SHARED ds_fraudPtRpt := PROJECT(ds_fraudPtRpt_Hdr, TRANSFORM(iesp.iidfraudpointsummary.t_FraudPointSummary,
				Parent_score := LEFT.Score;
				SELF.Score := Parent_score,
				SELF.NumberOfCases := LEFT.NumberOfCases,
				SELF.Percent := LEFT.Percent,
				SELF.FraudPointWarnings := PROJECT(ds_fraud_typeRisk_sorted(Score = Parent_score),
					TRANSFORM(iesp.iidsummary_share.t_ReportElementEx, 
							SELF.Description := LEFT.Description,
							SELF.Value := LEFT.Risk_Code, 
							SELF.Percent := LEFT.Percent));
				));
	//--------------------------------------fraud risk index report----------------
		//only runs on iid .... no risk index table for flexid
		
		//Get the archived data from the keys
			SHARED ds_keys_FRiskIndexiid := Raw.summaryFraudPtRiskIndexViakeys(in_mod, ProductType);	
			SHARED FRiskIndexiid_ERROR := ds_keys_FRiskIndexiid.Exceptions.exceptions[1].message;
			SHARED ds_combined_FRiskIndex := ds_db_FRiskIndexiid + ds_keys_FRiskIndexiid;				
		//gets the counts per score(value) and name	(ensure name is same case)
			ds_FRiskIndex_deduped := DEDUP(SORT(ds_combined_FRiskIndex, transaction_id, StringLib.StringToUppercase(name), score), 
					transaction_id, StringLib.StringToUppercase(name), score);
			//get distinct transaction for ALL count
			ds_FRiskTrans_deduped := DEDUP(SORT(ds_combined_FRiskIndex, transaction_id), transaction_id);	
			FRiskTrans_cnt := COUNT(ds_FRiskTrans_deduped);
		//gets the counts for the ALL column but disregard the empty values as don't return them
			ds_idx_cnts := table(ds_FRiskIndex_deduped(name != ''), {name, idx_cnt:=count(group)}, name);
		//Get the counts per name/value for the rows but disregard the empty values as don't return them
			tbl_FRiskNamesScores := table(ds_FRiskIndex_deduped(name != ''), {name, score, idx_cnt:=count(group)}, name, score);
			//fill in ALL for the ALL row for counts
			ds_namesForAll := PROJECT(ds_idx_cnts,	
				TRANSFORM(Layouts.risk_name_cnts, 
					SELF.Idx := Constants.ForAll, //ALL
					SELF.name := LEFT.Name,
					SELF.CNT := LEFT.idx_cnt,
					SELF.Percent := (SELF.cnt / FRiskTrans_cnt ) * 100));	
			ds_possiblitiesForAll := JOIN(Constants.ds_Fraud_index_Possiblities, ds_namesForAll,
				StringLib.StringToUppercase(LEFT.Idx) = StringLib.StringToUppercase(RIGHT.Idx) and
					StringLib.StringToUppercase(LEFT.Name) = StringLib.StringToUppercase(RIGHT.Name),
					TRANSFORM(Layouts.risk_name_cnts, 
					SELF.Idx := LEFT.Idx,
					SELF.Name := LEFT.Name,
					SELF.Percent := RIGHT.Percent,
					SELF.Cnt := RIGHT.Cnt),
					LEFT OUTER);
			//gets the percents and info for non ALL columns
			ds_names_forNonALL := JOIN(ds_idx_cnts, tbl_FRiskNamesScores,
				StringLib.StringToUppercase(LEFT.name) = StringLib.StringToUppercase(RIGHT.name),
				TRANSFORM(Layouts.risk_name_cnts, 
					SELF.Idx := RIGHT.score,
					SELF.Name := RIGHT.name,
					SELF.Cnt := RIGHT.idx_cnt,
					SELF.Percent := ( SELF.Cnt / LEFT.idx_cnt) * 100),
					LEFT OUTER);
			ds_namesAndIndexes := JOIN(ds_possiblitiesForAll, ds_names_forNonALL,
							StringLib.StringToUppercase(LEFT.name) = StringLib.StringToUppercase(RIGHT.name)
							AND LEFT.Idx = RIGHT.Idx, 					
								TRANSFORM(Layouts.risk_name_cnts,
									SELF.Name := LEFT.Name,
									SELF.Cnt := if(LEFT.Idx = Constants.ForAll, LEFT.Cnt, RIGHT.Cnt),
									SELF.Percent := IF(LEFT.Idx = Constants.ForAll, LEFT.Percent, RIGHT.Percent),
									SELF.Idx := LEFT.Idx),
							LEFT OUTER);			
			//gets header for Risk indexes
			ds_idx_hdr := project(Constants.FraudRiskIndexTypes, transform(Layouts.idx_rec, 
						SELF.RiskIndex := LEFT.Description,
						SELF.idx := LEFT.Value,
						SELF := [];));	//NumberOfCases, dataset...called RiskIndexScore
			//Add all the additional information			
			ds_idx_info:= project(ds_idx_hdr, transform(iesp.iidfraudpointsummary.t_FraudRiskIndexSummary, 
						SELF.RiskIndex := LEFT.RiskIndex,				
						hdr_idx := LEFT.idx;					
						SELF.RiskIndexScore := PROJECT(ds_namesAndIndexes(Idx = hdr_idx), 			
								TRANSFORM(iesp.iidfraudpointsummary.t_RiskIndexReportElement,
									SELF.Value := LEFT.Name,
									SELF.NumberOfCases := LEFT.Cnt,
									SELF.Percent := LEFT.Percent));
						));		
	//--------------------------------------fraud risk results---------------------
		iesp.iidfraudpointsummary.t_FraudPointSummaryResult CreateFrdPtResult() := TRANSFORM
				SELF.FraudRiskIndexSummary := CHOOSEN(ds_idx_info, iesp.Constants.IIDReporting.MaxFraudRiskIndex),
				SELF.FraudPointSummary := CHOOSEN(ds_fraudPtRpt, iesp.Constants.IIDReporting.MaxFraudPointSummary);
				SELF.CVIFraudPointWarnings := CHOOSEN(ds_FRPt_cviReport, iesp.Constants.IIDReporting.MaxFraudPointWarnings);
		END;
	  

		SHARED rw_fraudPt_result := ROW(CreateFrdPtResult());
		
		iesp.iidfraudpointsummary.t_FraudPointSummaryReportResponse CreateFrdPtResponse() := TRANSFORM
			SELF.Result := rw_fraudPt_result;
			SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
		END;
		
		SHARED rw_fraudPt_response := ROW(CreateFrdPtResponse());
	  EXPORT Results := rw_fraudPt_result; 
	//Display an error if more than 1 score_type was found
		FraudPointTooManyScoreTypesDBError := if(CntOfScoreType > 1, 'Multiple FraudPoint score types found','');
		EXPORT rw_fraudPtresponse_errors := MAP(in_mod.CompanyId = '' => doxie.ErrorCodes(301),
					FraudPointDB_Error != '' => FraudPointDB_Error,
					FdPT_CVI_keys_error != '' => FdPT_CVI_keys_error,
					FraudPointIndxDB_Error != '' => FraudPointIndxDB_Error,
					FRiskIndexiid_ERROR != '' => FRiskIndexiid_ERROR,
					FraudPointRptDB_Error != '' => FraudPointRptDB_Error, 
					FdPTRpt_fraudPt_error != '' => FdPTRpt_fraudPt_error, 
					FraudPointTooManyScoreTypesDBError != '' => FraudPointTooManyScoreTypesDBError,
					'');
		rw_fraudPtresponse := if(rw_fraudPtresponse_errors != '',
				Macros.mac_GetDisplayRowErrors(rw_fraudPtresponse_errors, iesp.iidfraudpointsummary.t_FraudPointSummaryReportResponse ),
				rw_fraudPt_response);
   
	  EXPORT Response := rw_fraudPtresponse;
		
	END;

	//Tell FraudPoint Report to run based on Flexid and Instantid Data, since when stand alone we have to union the data
	EXPORT doSummaryFraudPtReport(IParam.Summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION
		ds_FraudReportSummary := doSummary_FraudPointReport(in_mod, Constants.Both, dGateways);
		ds_FraudReportSummaryResponse := ds_FraudReportSummary.Response;	

		ds_FraudReportSummary_error := ds_FraudReportSummary.rw_fraudPtresponse_errors;
		
		ds_FraudReportSummary_Response := if(ds_FraudReportSummary_error != '', 
						Macros.mac_GetDisplayRowErrors(ds_FraudReportSummary_error, iesp.iidfraudpointsummary.t_FraudPointSummaryReportResponse),
						ds_FraudReportSummaryResponse);				
		
		RETURN ds_FraudReportSummary_Response;
	END;

END;
