import iesp, InstantID_Archiving, doxie, Gateway;
/*This attribute retrieves data for  the instantId archiving and reporting project. 
	- retrieves data for the summaryReport_FlexId
	- runs standalone
	- minimum criteria is start date otherwise functions will set a default value
	- retrieves data from deltabase and keys to run algorithms on the data to put it in a statistical format
*/
EXPORT SummaryReport_FlexId_Records := MODULE
	EXPORT doSummaryFlexIDReport(IParam.Summary_params in_mod, DATASET(Gateway.Layouts.Config) dGateways) := FUNCTION
		ds_DB_flexid := Raw.summaryFlexidViaDeltaBase(in_mod, dGateways); 
		//get keys here
		ds_keys_flexid := Raw.summaryFlexIdViakeys(in_mod);	
		//-----------------remove below when good data---------
		ds_combined_recs := ds_DB_flexid + ds_keys_flexid;
		//---------------------------
		ds_flexid_cvi_deduped := DEDUP(SORT(ds_combined_recs, transaction_id, cvi, RECORD), transaction_id, cvi);	
		flexid_trans_cnt := COUNT(ds_flexid_cvi_deduped);
	//-------------------------------FLEXID - CVI SUMMARY header --------------------------	
		ds_cvi_base := Macros.mac_GetCVISummary( ds_flexid_cvi_deduped, iesp.flexidsummary.t_FlexIDCVISummary)	;
	//-----------------------FLEXID - CVI SUMMARY nas----------------------
		//already depduped on cvi and since nas is 1 to 1 like cvi we shouldn't have to resort
		//gets the counts for the break down of the non-ALL rows			
		tbl_flexid_nas_cnts := table(ds_flexid_cvi_deduped, {cvi, value := nas, cvi_cnt:=count(group)}, cvi, nas); 			
		tbl_nas_cnts := table(ds_flexid_cvi_deduped, {value := nas, cnt:=count(group)}, nas); 
	//puts all the counts together for the Nas/CVI section		
		ds_nas_all_cvi_types :=Macros.mac_GetCnts_nonRisk(tbl_nas_cnts, tbl_flexid_nas_cnts, 
					Layouts.CVIwithReportElementXWithSeq, ds_cvi_base, flexid_trans_cnt, Constants.NasElements(value != '13'),
					Constants.cviTypes);		
	//-----------------------FLEXID - CVI SUMMARY nap----------------------
		//already depduped on cvi and since nap is 1 to 1 like cvi we shouldn't have to resort
		//gets the counts for the break down of the non-ALL rows			
		tbl_flexid_nap_cnts := table(ds_flexid_cvi_deduped, {cvi, value := nap, cvi_cnt:=count(group)}, cvi, nap);	
		tbl_nap_cnts := table(ds_flexid_cvi_deduped, {value := nap, cnt:=count(group)}, nap); 
	//puts all the counts together for the NaP/CVI section		
		ds_nap_all_cvi_types :=Macros.mac_GetCnts_nonRisk(tbl_nap_cnts, tbl_flexid_nap_cnts, 
				Layouts.CVIwithReportElementXWithSeq, ds_cvi_base, flexid_trans_cnt, Constants.NapElements,
					Constants.cviTypes );		
	//-----------------------FLEXID - Risk Indicators Report----------------------
		//redo the dedupe as we want all the risk_codes. 1 to many relationship in terms of cvi to risk code
		//do upper to ensure we dedup and sort properly on matching cases of risk code. Case ensured further down
		ds_flexid_risks_deduped := DEDUP(SORT(ds_combined_recs(Risk_code != ''), transaction_id, cvi, 
			StringLib.StringToUppercase(risk_code)), transaction_id, cvi, StringLib.StringToUppercase(risk_code));
	//gets the counts for the break down of the non-ALL rows			
		tbl_flexid_riskInd_cnts := table(ds_flexid_risks_deduped, {cvi, value := risk_code, cvi_cnt:=count(group)}, cvi, risk_code); 	
		tbl_riskInd_cnts := table(ds_flexid_risks_deduped, {value := risk_code, description, cnt:=count(group)}, risk_code, description); 
		//puts all the counts together for the RiskCode/CVI section		
		ds_flexid_riskInd_cvi :=Macros.mac_GetCnts_withOrder(tbl_riskInd_cnts, tbl_flexid_riskInd_cnts,
				Layouts.CVIwithReportElementXWithSeq, ds_cvi_base, flexid_trans_cnt );		
		//-----------------------FLEXID - Verified Report----------------------							 
		//verified counts in main table so it's a 1 to 1 with transaction id. So shouldn't need new dedupe
		tbl_flexid_verified_cnts := table(ds_flexid_cvi_deduped, {cvi, 
				first_name_verified_cnt:=count(group, first_name_verified = '1'),
				last_name_verified_cnt:=count(group, last_name_verified = '1'),
				state_verified_cnt :=count(group, state_verified = '1'), 
				ssn_verified_cnt :=count(group, ssn_verified = '1'),
				zip_verified_cnt :=count(group, zip_verified = '1'), 
				street_address_verified_cnt :=count(group, street_address_verified = '1'),
				city_verified_cnt :=count(group, city_verified = '1'), 
				dob_verified_cnt :=count(group, dob_verified = '1'),
				home_phone_verified_cnt :=count(group, home_phone_verified = '1'),
				dl_verified_cnt :=count(group, dl_verified = '1')}, 
					cvi); 
	//gets the percents for each type of verified data
	ds_VerifiedCnts := Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(first_name_verified_cnt >=0), first_name_verified_cnt, '0', flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(last_name_verified_cnt >=0), last_name_verified_cnt, '1', flexid_trans_cnt, ds_cvi_base) + 
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(state_verified_cnt >=0), state_verified_cnt, '2', flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(ssn_verified_cnt >=0), ssn_verified_cnt, '3', flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(zip_verified_cnt >=0), zip_verified_cnt, '4', flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(street_address_verified_cnt >=0), street_address_verified_cnt, '5',flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(city_verified_cnt >=0), city_verified_cnt, '6',flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(dob_verified_cnt >=0), dob_verified_cnt, '7',flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(home_phone_verified_cnt >=0), home_phone_verified_cnt, '8', flexid_trans_cnt, ds_cvi_base) +
		Macros.mac_GetVerfiedCnts(tbl_flexid_verified_cnts(dl_verified_cnt >=0), dl_verified_cnt, '9', flexid_trans_cnt, ds_cvi_base);	
		//populate with the verified elements
		ds_verification_output := JOIN(ds_VerifiedCnts, Constants.VerifiedElements,
								StringLib.StringToUppercase(LEFT.IdentityElementVerification) = StringLib.StringToUppercase(RIGHT.Value),
								TRANSFORM(Layouts.rec_verify_summ, 
										SELF.Percent := LEFT.Percent,
										SELF.IdentityElementVerification := RIGHT.description,
										SELF.cvi := LEFT.cvi),
								LEFT OUTER);				
		ds_flexid_cviReport := project(ds_cvi_base, transform(iesp.flexidsummary.t_FlexIDCVISummary, 
					SELF.Percent := LEFT.Percent, 
					SELF.NumberOfCases := LEFT.NumberOfCases,
					tmp_ComprehensiveVerificationIndex := LEFT.ComprehensiveVerificationIndex;
					SELF.ComprehensiveVerificationIndex := tmp_ComprehensiveVerificationIndex,
						SELF.NameAddressSSN :=	PROJECT(ds_nas_all_cvi_types(CVI = tmp_ComprehensiveVerificationIndex),
									TRANSFORM(	iesp.iidsummary_share.t_ReportElement, 
										SELF.Percent := LEFT.Percent,
										SELF.value := LEFT.Description)),
						SELF.NameAddressPhone :=	PROJECT(ds_nap_all_cvi_types(CVI = tmp_ComprehensiveVerificationIndex),
									TRANSFORM(	iesp.iidsummary_share.t_ReportElement, 
										SELF.Percent := LEFT.Percent,
										SELF.Value := LEFT.description)),
						SELF.RiskIndicators := PROJECT(ds_flexid_riskInd_cvi(CVI = tmp_ComprehensiveVerificationIndex),
								TRANSFORM(iesp.iidsummary_share.t_ReportElementex, 
										SELF.Percent := LEFT.Percent,
										SELF.Value := LEFT.Value,
										SELF.Description := LEFT.description)),
						SELF.VerifiedElements	:= PROJECT(ds_verification_output(cvi = tmp_ComprehensiveVerificationIndex), 
								TRANSFORM(iesp.flexidsummary.t_FlexIDSummaryVerifiedElementSummary, 
										SELF.Percent := LEFT.Percent,
										SELF.IdentityElementVerification := LEFT.IdentityElementVerification));
					));

		//--------------------------------------fraud pt----------------
		//--------------------------------------fraud risk results---------------------
		//Tell FraudPoint Report to run based on Flexid Data 
		ds_fraudPt := InstantID_Archiving_Services.SummaryReport_FraudPoint_Records.doSummary_FraudPointReport(in_mod, Constants.Flexid, dGateways);
		//empty output if no option to display fraud point is selected
		ds_no_fraudPt := ROW([],	iesp.iidfraudpointsummary.t_FraudPointSummaryResult);
		ds_fraudPt_result := if(in_mod.IncludeFraudPoint, ds_fraudPt.Results, ds_no_fraudPt);	
		//Adds the CVI Summary	
		iesp.flexidsummary.t_FlexIDSummaryResult CreateFlexidResult() := TRANSFORM
					SELF.CVISummary := CHOOSEN(ds_flexid_cviReport, iesp.Constants.IIDReporting.MaxCVIElements);
					self.FraudPoint.FraudPointSummary := CHOOSEN(ds_fraudPt_result.FraudPointSummary, iesp.Constants.IIDReporting.MaxFraudPointSummary);
					self.FraudPoint.CVIFraudPointWarnings := CHOOSEN(ds_fraudPt_result.CVIFraudPointWarnings, iesp.Constants.IIDReporting.MaxFraudPointWarnings); 
					SELF.FraudPoint.FraudRiskIndexSummary := [];
		END;
		rw_flexid_result := ROW(CreateFlexidResult());
		iesp.flexidsummary.t_FlexIDSummaryReportResponse CreateFlexidResponse() := TRANSFORM
			SELF.Result := rw_flexid_result;
			SELF._Header   := iesp.ECL2ESP.GetHeaderRow();
		END;
		rw_flexid_response_tmp := ROW(CreateFlexidResponse());
		
		flexid_response_error := map(in_mod.CompanyId = '' => doxie.ErrorCodes(301), 
				ds_DB_flexid.Exceptions.exceptions[1].message != '' => ds_DB_flexid.Exceptions.exceptions[1].message,
				ds_keys_flexid.exceptions.exceptions[1].message != '' => ds_keys_flexid.exceptions.exceptions[1].message,
				in_mod.IncludeFraudPoint AND ds_fraudPt.rw_fraudPtresponse_errors != '' => ds_fraudPt.rw_fraudPtresponse_errors,
				''); 
		rw_flexid_response := if(flexid_response_error != '', 		
					Macros.mac_GetDisplayRowErrors(flexid_response_error, iesp.flexidsummary.t_FlexIDSummaryReportResponse),
				rw_flexid_response_tmp);
	
		RETURN rw_flexid_response;
	END;
END;