import iesp, InstantID_Archiving, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the summaryReport_InstantId
	- runs standalone
	- minimum criteria is start date otherwise functions will set a default value
	- retrieves data from deltabase and keys to run algorithms on the data to put it in a statistical format
*/
EXPORT SummaryReport_InstantID_Records := MODULE
	EXPORT get_NAS_NAP_summary(IParam.summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways ) :=
		MODULE//FUNCTION
			// Note: NAS = 'Name-Address-SSN'; NAP = 'Name-Address-Phone'.
			
			// ---------------[ Via DeltaBase ]---------------
			SHARED ds_deltabase_recs := raw.summaryNASNAPViaDeltaBase(in_mod, dGateways);
			EXPORT NasNapError := ds_deltabase_recs.exceptions.exceptions[1].message;
			// ---------------[ Via Roxie ]---------------
			ds_roxie_recs := raw.summaryNASNAPViaAutokeys(in_mod);
			// ---------------[ Union, sort, dedup ]---------------
			//can run IID with only redflags so if they do strip them off	
			ds_all_nasnap_recs :=
				DEDUP( 
					SORT( 
						(ds_deltabase_recs  + ds_roxie_recs), 
						transaction_id, nas, nap
					), 
					transaction_id, nas, nap 
				);
			count_transactions := COUNT( TABLE( ds_all_nasnap_recs, {transaction_id}, transaction_id ) );
			// Count NAP values for each NAS.
			tbl_nas_nap_count :=
					TABLE( ds_all_nasnap_recs, {nas, nap, cnt := COUNT(GROUP)}, nas, nap );

			// Count total NAP values for 'ALL'.
			rec_NASNAPSummary_flat_count := RECORD
				STRING3 nas;
				STRING3 nap;
				UNSIGNED cnt;
			END;			

			ds_nas_nap_ALL_count :=
				DATASET(
					[ // Note: the value '13' will be converted to 'ALL' later in the code.
						{ '13', '0' , SUM( tbl_nas_nap_count(nap = '0') , cnt ) },
						{ '13', '1' , SUM( tbl_nas_nap_count(nap = '1') , cnt ) },
						{ '13', '2' , SUM( tbl_nas_nap_count(nap = '2') , cnt ) },
						{ '13', '3' , SUM( tbl_nas_nap_count(nap = '3') , cnt ) },
						{ '13', '4' , SUM( tbl_nas_nap_count(nap = '4') , cnt ) },
						{ '13', '5' , SUM( tbl_nas_nap_count(nap = '5') , cnt ) },
						{ '13', '6' , SUM( tbl_nas_nap_count(nap = '6') , cnt ) },
						{ '13', '7' , SUM( tbl_nas_nap_count(nap = '7') , cnt ) },
						{ '13', '8' , SUM( tbl_nas_nap_count(nap = '8') , cnt ) },
						{ '13', '9' , SUM( tbl_nas_nap_count(nap = '9') , cnt ) },
						{ '13', '10', SUM( tbl_nas_nap_count(nap = '10'), cnt ) },
						{ '13', '11', SUM( tbl_nas_nap_count(nap = '11'), cnt ) },
						{ '13', '12', SUM( tbl_nas_nap_count(nap = '12'), cnt ) }
					],
					rec_NASNAPSummary_flat_count
				);			
			
			// Union the two datasets having counts together.
			ds_total_nas_nap_count := 
					PROJECT( tbl_nas_nap_count, rec_NASNAPSummary_flat_count ) + ds_nas_nap_ALL_count;	
			// ---------------[ Begin rolling up data ]---------------

			ds_NASNAPSummary_with_counts := 
				JOIN(
					Constants.ds_nasnap_categories, ds_total_nas_nap_count,
					LEFT.NameAddressSSN = RIGHT.nas AND
					LEFT.Value =  RIGHT.nap,
					TRANSFORM( Layouts.rec_NASNAPSummary_flat,
						SELF.NAPPercent := (RIGHT.cnt / count_transactions) * 100,
						SELF := LEFT
					), ATMOST(Constants.Max_RISK_COUNT),
					LEFT OUTER
				);	
				
			ds_NASNAPSummary_grouped :=
				GROUP( 
					SORT( 
						ds_NASNAPSummary_with_counts, 
						(UNSIGNED)NameAddressSSN, (UNSIGNED)value 
					), 
					NameAddressSSN 
				);
			rec_nasnap := record
				iesp.iidsummary_share.t_NASNAPSummary ;
				integer order;
			end;
			
			rec_nasnap
					doRollup_1(Layouts.rec_NASNAPSummary_flat le, DATASET(Layouts.rec_NASNAPSummary_flat) allRows) :=
						TRANSFORM
								num_cases := SUM( ds_total_nas_nap_count(nas = le.NameAddressSSN), cnt );
							SELF.NameAddressSSN := le.NameAddressSSN,
							SELF.NumberOfCases  := num_cases,
							SELF.Percent        := (num_cases / count_transactions) * 100,
							SELF.order 					:= le.order,
							SELF.NameAddressPhone :=
								PROJECT( 
									allRows,
									TRANSFORM( iesp.iidsummary_share.t_ReportElement,
										SELF.Value   := LEFT.Value,
										SELF.Percent := LEFT.NAPPercent
									)
								);
						END;
			
			ds_NASNAPSummary_pre := 
					ROLLUP( ds_NASNAPSummary_grouped, GROUP, doRollup_1(LEFT, ROWS(LEFT)) );
		 ds_NASNAPSummary_SORTED := SORT(ds_NASNAPSummary_pre, order);

			SHARED ds_NASNAPSummary_tmp := 
				PROJECT(
					ds_NASNAPSummary_SORTED,
					TRANSFORM( iesp.iidsummary_share.t_NASNAPSummary,
						SELF.NameAddressSSN := IF( LEFT.NameAddressSSN = '13', Constants.ForAll, LEFT.NameAddressSSN ),
						SELF := LEFT
					)
				);	
			
			EXPORT ds_NASNAPSummary := ds_NASNAPSummary_tmp;
		END;
	
	EXPORT doSummaryIIDReport(IParam.summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways ) := FUNCTION
		ds_db_results := Raw.summaryInstantIdViaDeltaBase(in_mod, dGateways);
		//keys
		ds_keys_results := Raw.summaryInstantIdViakeys(in_mod);
		ds_combined := ds_db_results+ ds_keys_results;//(CVI !='')
		//can run IID with only redflags so if they do strip them off
		ds_iid_cvi_deduped := DEDUP(SORT(ds_combined, transaction_id, cvi, RECORD), transaction_id,cvi);
		iid_trans_cnt := COUNT(ds_iid_cvi_deduped);
		//-------------------------------IID - CVI SUMMARY header --------------------------	
		ds_all_cvi_types_iid := Macros.mac_GetCVISummary(ds_iid_cvi_deduped, iesp.iidsummary.t_IIDSummary);
		//-----------------------IID - CVI SUMMARY nas----------------------
		//gets the counts for the break down of the non-ALL rows
		tbl_cvi_nas_cnts := table(ds_iid_cvi_deduped, {cvi, value := nas, cvi_cnt:=count(group)}, cvi, nas); 
	 //gets the counts for the break down of the ALL rows		
		tbl_nas_cnts := table(ds_iid_cvi_deduped, {value := nas, cnt:=count(group)}, nas); 
		//puts all the counts together for the Nas/CVI section
		ds_nas_all_cvi_iid_types_ := Macros.mac_GetCnts_nonRisk(tbl_nas_cnts, tbl_cvi_nas_cnts, 
					Layouts.CVIwithReportElementXWithSeq, ds_all_cvi_types_iid, iid_trans_cnt, 
					Constants.NasElements(value != '13'), Constants.cviTypes);
		//-----------------------IID - CVI SUMMARY nap----------------------
		//gets the counts for the break down of the non-ALL rows	
		tbl_cvi_nap_cnts := table(ds_iid_cvi_deduped, {cvi, value := nap, cvi_cnt:=count(group)}, cvi, nap); 
	 //gets the counts for the break down of the ALL rows			
		tbl_nap_cnts := table(ds_iid_cvi_deduped, {value := nap, cnt:=count(group)}, nap); 
		//puts all the counts together for the NaP/CVI section	
		ds_nap_all_cvi_iid_types :=Macros.mac_GetCnts_nonRisk(tbl_nap_cnts, tbl_cvi_nap_cnts, 
					Layouts.CVIwithReportElementXWithSeq, ds_all_cvi_types_iid, iid_trans_cnt, Constants.NapElements, 
					Constants.cviTypes );
		//-----------------------IID - CVI SUMMARY DOB verified-------------
		//gets the counts for the break down of the non-ALL rows		
		tbl_iid_dob_cnts := table(ds_iid_cvi_deduped, {cvi, value := dob_verified, cvi_cnt := count(group)}, cvi, dob_verified); 
		//gets the counts for the break down of the ALL rows			
		tbl_dob_cnts := table(ds_iid_cvi_deduped, {value := dob_verified, cnt:=count(group)}, dob_verified); 		
		//puts all the counts together for the dob/CVI section	
		ds_dob_all_cvi_iid_types :=Macros.mac_GetCnts_nonRisk(tbl_dob_cnts, tbl_iid_dob_cnts, 
					Layouts.CVIwithReportElementXWithSeq, ds_all_cvi_types_iid, iid_trans_cnt, Constants.DOBVerifiedElements, 
					Constants.cviTypes);				 
	//-----------------------IID - Risk Indicators Report----------------------
		//gets the counts for the break down of the non-ALL rows		
		//ensuring the case matches on risk code since alpha-numeric. 
		ds_iid_risk_deduped := DEDUP(SORT(ds_combined(risk_code != ''), transaction_id, cvi, StringLib.StringToUppercase(risk_code)),
				transaction_id, cvi, StringLib.StringToUppercase(risk_code));	
		tbl_iid_riskInd_cnts := table(ds_iid_risk_deduped, {cvi, value := risk_code, cvi_cnt:=count(group)}, cvi, risk_code); 
		//gets the counts for the break down of the ALL rows
		tbl_riskInd_cnts := table(ds_iid_risk_deduped, {value := risk_code, description, cnt:=count(group)}, risk_code, description); 
		//puts all the counts together for the NaP/CVI section		
		ds_iid_riskInd_cvi :=Macros.mac_GetCnts_withOrder(tbl_riskInd_cnts, tbl_iid_riskInd_cnts, 
					Layouts.CVIwithReportElementXWithSeq, ds_all_cvi_types_iid, iid_trans_cnt );		
		//-----------------------IID - CVI Summary Report--------------------------					 					 
		ds_iid_cviReport := project(ds_all_cvi_types_iid, transform(iesp.iidsummary.t_IIDSummary, 
						SELF.Percent := LEFT.Percent, 
						SELF.NumberOfCases := LEFT.NumberOfCases,
						iid_ComprehensiveVerificationIndex := LEFT.ComprehensiveVerificationIndex;
						SELF.ComprehensiveVerificationIndex := iid_ComprehensiveVerificationIndex,
						SELF.NameAddressSSN :=	PROJECT(ds_nas_all_cvi_iid_types_(Cvi = iid_ComprehensiveVerificationIndex),
									TRANSFORM(	iesp.iidsummary_share.t_ReportElement, 
										SELF.Percent := LEFT.Percent,
										SELF.value := LEFT.Description)),
						SELF.NameAddressPhone := PROJECT(ds_nap_all_cvi_iid_types(Cvi = iid_ComprehensiveVerificationIndex),
									TRANSFORM(	iesp.iidsummary_share.t_ReportElement, 
										SELF.Percent := LEFT.Percent,
										SELF.Value := LEFT.description)),
						SELF.DobVerified := PROJECT(ds_dob_all_cvi_iid_types(Cvi = iid_ComprehensiveVerificationIndex),
									TRANSFORM(	iesp.iidsummary_share.t_ReportElement, 
										SELF.Percent := LEFT.Percent,
										SELF.Value := LEFT.description)),
						SELF.RiskIndicators := PROJECT(ds_iid_riskInd_cvi(cvi = iid_ComprehensiveVerificationIndex),
								TRANSFORM(iesp.iidsummary_share.t_ReportElementex, 
										SELF.Percent := LEFT.Percent,
										SELF.Value := LEFT.Value,
										SELF.Description := LEFT.description))
					));							
		//-----------------------IID - NAS/NAP Report----------------------
		ds_NASNAP_summary_response := get_NAS_NAP_summary(in_mod, dGateways);	
		ds_NASNAP_summary := ds_NASNAP_summary_response.ds_NASNAPSummary;	
		//-----------------------IID - REDFLAGS----------------------
		redflags:= SummaryReport_RedFlags_Records.doSummaryRedFlagsReport(in_mod, dGateways);
		//-----------------------IID - Fraud point----------------------
		//Tell FraudPoint Report to run based on InstantId Data 
		fraudpoint := SummaryReport_FraudPoint_Records.doSummary_FraudPointReport(in_mod, Constants.InstantId, dGateways);		
		rw_no_fraudPt := ROW([],	iesp.iidfraudpointsummary.t_FraudPointSummaryResult);
		rw_no_redflags := ROW([],	iesp.iidredflagsummary.t_RedFlagsSummaryResult);
		
		rw_fraudPt_results := if(in_mod.IncludeFraudPoint, fraudpoint.Results, rw_no_fraudPt);	
		rw_redFlags_results := IF(in_mod.IncludeRedFlags, redflags.rw_redFlagResult, rw_no_redflags);
		
		iesp.iidsummary.t_InstantIDSummaryResult CreateiidResult() := TRANSFORM
				SELF.CVISummary			:= CHOOSEN(ds_iid_cviReport, iesp.Constants.IIDReporting.MaxCVIElements);
				SELF.NASNAPSummary		:= CHOOSEN(ds_NASNAP_summary, iesp.Constants.IIDReporting.MaxNASNAP);
				SELF.FraudPoint.FraudPointSummary := CHOOSEN(rw_fraudPt_results.FraudPointSummary,  iesp.Constants.IIDReporting.MaxFraudPointSummary);
				SELF.FraudPoint.FraudRiskIndexSummary := CHOOSEN(rw_fraudPt_results.FraudRiskIndexSummary, iesp.Constants.IIDReporting.MaxFraudRiskIndex);
				SELF.FraudPoint.CVIFraudPointWarnings := CHOOSEN(rw_fraudPt_results.CVIFraudPointWarnings, iesp.Constants.IIDReporting.MaxFraudPointWarnings);
				SELF.RedFlags.RedFlagsSummary := CHOOSEN(rw_redFlags_results.RedFlagsSummary, iesp.Constants.IIDReporting.MaxRedFlagsSummary);
		END;
		rw_iid_SummaryResult := ROW(CreateiidResult());
	
		iesp.iidsummary.t_InstantIDSummaryReportResponse CreateiidResponse() := TRANSFORM
			SELF.Result := rw_iid_SummaryResult;
			SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
		END;
		
		rw_iid_SummaryResponse := ROW(CreateiidResponse());
		rw_iid_Summary_errors := MAP(in_mod.CompanyId = '' => doxie.ErrorCodes(301),
				ds_db_results.exceptions.exceptions[1].message != '' => ds_db_results.exceptions.exceptions[1].message,
				ds_keys_results.exceptions.exceptions[1].message != '' => ds_keys_results.exceptions.exceptions[1].message,
				ds_NASNAP_summary_response.NasNapError != '' => ds_NASNAP_summary_response.NasNapError,
				in_mod.IncludeRedFlags = false AND in_mod.IncludeFraudPoint = false => '',
				in_mod.IncludeRedFlags AND redflags.RedFlagsError != '' => redflags.RedFlagsError,  
				in_mod.IncludeFraudPoint AND fraudpoint.rw_fraudPtresponse_errors != '' => fraudpoint.rw_fraudPtresponse_errors,
				'');
			
		rw_iid_Summary_Response := if(rw_iid_Summary_errors != '',
					Macros.mac_GetDisplayRowErrors(rw_iid_Summary_errors, iesp.iidsummary.t_InstantIDSummaryReportResponse),
					rw_iid_SummaryResponse);	

		RETURN rw_iid_Summary_Response;
	END;

END;