IMPORT AutoStandardI, BIPV2, LNSmallBusiness;

EXPORT fn_search_business_ids(DATASET(LNSmallBusiness.BIP_Layouts.Input) input,
															UNSIGNED1	DPPA_Purpose,
															UNSIGNED1	GLBA_Purpose,
															STRING  DataRestrictionMask,
															STRING  DataPermissionMask,
															INTEGER BestInfoNeeded)  := FUNCTION

	global_mod := AutoStandardI.GlobalModule();

	SmallBizCombined_inmod := 
			 MODULE (PROJECT(global_mod ,LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams, OPT));
				 EXPORT DATASET(LNSmallBusiness.BIP_Layouts.Input) ds_SBA_Input := input;
				 EXPORT UNSIGNED1 DPPAPurpose         := DPPA_Purpose; 
				 EXPORT UNSIGNED1 GLBAPurpose         := GLBA_Purpose;
				 EXPORT STRING    DataRestrictionMask := DataRestrictionMask;
				 EXPORT STRING    DataPermissionMask	:= DataPermissionMask;
				 EXPORT BOOLEAN   allowall            := global_mod.allowall;
				 EXPORT BOOLEAN   allowdppa           := global_mod.allowdppa;
				 EXPORT BOOLEAN   allowglb            := global_mod.allowglb;
				 EXPORT UNSIGNED1 glbpurpose          := GLBA_Purpose;
				 EXPORT STRING32  ApplicationType     := global_mod.ApplicationType;
				 EXPORT STRING1   FetchLevel 					:= BIPV2.IDconstants.Fetch_Level_SELEID;  //to change based on input, currently only accounting for seleid
				END;
				

	ds_SBA_Input_withID := 
				MAP(input[1].SeleID != 0  
												=> LNSmallBusiness.fn_addBestInfo(SmallBizCombined_inmod, LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID),
						 input);
						 
						 
	RETURN ds_SBA_Input_withID;					 

END;