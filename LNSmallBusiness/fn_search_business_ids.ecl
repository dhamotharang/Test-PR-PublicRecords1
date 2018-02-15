IMPORT AutoStandardI, BIPV2, LNSmallBusiness;

EXPORT fn_search_business_ids(DATASET(LNSmallBusiness.BIP_Layouts.Input) input,
															UNSIGNED1	DPPA_Purpose,
															UNSIGNED1	GLBA_Purpose,
															STRING  DataRestrictionMask,
															STRING  DataPermissionMask,
															INTEGER BestInfoNeeded)  := FUNCTION

	global_mod := AutoStandardI.GlobalModule();



businessData := project(input, transform(LNSmallBusiness.BIP_Layouts.Input,

  leftData := dataset([transform(LNSmallBusiness.BIP_Layouts.Input, self := left;)]);

	SmallBizCombined_inmod := 
			 MODULE (PROJECT(global_mod ,LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams, OPT));
				 EXPORT DATASET(LNSmallBusiness.BIP_Layouts.Input) ds_SBA_Input := 
				      leftData
						 ;
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

      selecheck :=
			   map(left.seleid != 0
			        => LNSmallBusiness.fn_addBestInfo(SmallBizCombined_inmod, LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID),
							   leftData);
						
						resultcheck :=
						map(BestInfoNeeded = LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID
             and selecheck[1].seleid != 0 => selecheck,
		        leftData);
						
						self := resultcheck[1];
    ));		 
						 
	RETURN businessData;	

END;