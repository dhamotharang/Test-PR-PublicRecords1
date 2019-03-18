IMPORT AutoKeyI, AutoHeaderI, BatchShare, suppress,FCRA, BIPV2;
EXPORT Interfaces := MODULE
	
	shared common_params := INTERFACE
		export string32 	seqk 										      := '';		
		export string30 	wk 											      := '';	
		export string30 	hull_num 								      := '';
		export string50 	vesl_nam 								      := '';
    export string6 		ssn_mask 								      := 'NONE';
		export unsigned2 	pt 											      := 10;
		export string10   off_num 								      := '';
		export integer1   non_subject_suppression       := Suppress.Constants.NonSubjectSuppression.doNothing;
		export boolean    include_non_regulated_sources := false;
	END;
		
	export ak_params := interface(
		AutoKeyI.AutoKeyStandardFetchBaseInterface,
		AutoHeaderI.LIBIN.FetchI_Hdr_Indv.base,
		AutoHeaderI.LIBIN.FetchI_Hdr_Biz.base)
		export boolean nodeepdive := false;
	end;
	
	export search_params := INTERFACE(common_params, ak_params,FCRA.iRules)
		export unsigned2	min_vesl_len	:= 0;
		export unsigned2	max_vesl_len	:= 0;
	END;
		
	export report_params := INTERFACE(common_params, ak_params,FCRA.iRules)
		export boolean   summarize 	:= false;
	END;
	
	export batch_params := INTERFACE(BatchShare.IParam.BatchParamsV2,FCRA.iRules)
		export integer1 non_subject_suppression := Suppress.Constants.NonSubjectSuppression.doNothing;
		export boolean    include_non_regulated_sources := false;
		export string1 BIPFetchLevel := BIPV2.IDconstants.Fetch_Level_SELEID;
	end;
	
END;
