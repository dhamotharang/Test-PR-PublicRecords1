import doxie, address, risk_indicators, iesp, business_risk, models, ut, riskwise, business_risk,
       autostandardi, autokeyi, incomeRisk_services,gateway,Risk_Indicators;
export ReportService_records := module

		 export incomeRisk_services.layouts.income_risk_batch_input   
	              file_inRiskAssessBatchMaster(BOOLEAN forceSeq = FALSE) := function 							 							 
		//
		// generic layout with income risk assessment specific information information added
		// use to sequence the incoming batch records
		//
		  rec := incomeRisk_services.layouts.income_risk_batch_input;

		  raw1 := DATASET([], rec) : STORED('batch_in', FEW);
		  raw0 := raw1 : GLOBAL;

		  rec tra(rec l) := TRANSFORM
			  SELF.max_results := if( (UNSIGNED8) l.max_results > 0, l.max_results, (string4) incomeRisk_services.Constants.SEQ_MAX_LIMIT);
			  SELF := l;
		  end;

		  raw := PROJECT(raw0, tra(LEFT));

		  ut.MAC_Sequence_Records(raw, seq, raw_seq)

		  income_assess_file := IF(NOT forceSeq AND EXISTS(raw(seq > 0)), raw, raw_seq);				
		
		  return income_assess_file;
	
    end;	


// this will call Business_Risk.InstantID_Batch_Service_record which is same as below.
// some of these params will be defaulted to have a particular value.
// defaults on all incoming params modeled after business_risk instantID_service
export records(dataset(Gateway.Layouts.Config)  gateways_in,
                                 dataset(business_risk.Layout_Input_Moxie_2) df,
																 boolean hb,
																 unsigned2 glb=0,
																 unsigned2 dppa=0,
																 boolean isUtility,
																 boolean ln_branded_value,
																 string4 tribcode,
																 boolean excludeWatchLists=false,
																 boolean ofac_only=false,
																 unsigned1 ofac_version=1,
																 boolean include_ofac=false,
																 boolean include_additional_watchlists=false,
																 real global_watchlist_threshold=.84,
																 integer2 dob_radius_use=-1,
																 boolean isPOBoxCompliant,
																 //bsversion // set directly,
																 //exactMatchLevel set directly,
																 boolean IncludeTargus3220,
																 string50 DataRestriction,
																 boolean includeMSoverride,
																 boolean IncludeDLverification,
																 
																 dataset(iesp.share.t_StringArrayItem) watchlists_request,
																 boolean suppressNearDups=false,
																 boolean require2ele=false,
																 boolean fromBiid=false,
																 boolean isFCRA=false,
																 boolean from_IT1O=false,
																 boolean nugen=true,
																 string Model_name,
																 boolean IncludeFraudScores=true,
																 string50 DataPermission=Risk_Indicators.iid_constants.default_DataPermission
																 ) := function
																 
																 
ret  := Business_Risk.InstantID_Batch_Service_records(gateways_in,
                                                       df,
																											  hb,
																												glb,
																												dppa,
																												isUtility,
																												ln_branded_value,
																												tribcode,
																												excludeWatchLists,
																												ofac_only,
																												ofac_version,
																												include_ofac,
																												include_additional_watchlists,
																												global_watchlist_threshold,
																												dob_radius_use,
																												isPOBoxCompliant,
																 //bsversion // set directly,
																 //exactMatchLevel set directly,
																												IncludeTargus3220,
																												DataRestriction,
																												includeMSoverride,
																												IncludeDLverification,																 
																												watchlists_request,
																												suppressNearDups,
																												require2ele,
																												fromBiid,
																												isFCRA,
																												from_IT1O,
																												nugen,
																												Model_name,
																												IncludeFraudScores,
																												/* IncludeRepAttributes */FALSE,
																												DataPermission);

	// slim off the acct no

	layout_final := record
		business_risk.Layout_Final_Denorm - Attributes;
		DATASET(Models.Layout_Model) models;
	end;

	final_ret := project(ret, transform(layout_final, self := left,
                  self := []
									));

	//output(ret);
	return(final_ret);

	end;
																 																
end; // module


