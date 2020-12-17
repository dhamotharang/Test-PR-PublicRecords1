﻿IMPORT $, AutoKeyI, BIPV2, Business_Credit_Scoring, BusinessCredit_Services, iesp, LNSmallBusiness, Risk_Indicators, std;

EXPORT SmallBusiness_BIP_Combined_Service_Records (LNSmallBusiness.IParam.LNSmallBiz_BIP_CombinedReport_IParams SmallBizCombined_inmod ) := 
  FUNCTION
    set_modelsRequested := SET(SmallBizCombined_inmod.ModelsRequested, ModelName); 
    
 		 isBIPIDSearch := SmallBizCombined_inmod.ds_SBA_Input[1].UltID != 0 OR SmallBizCombined_inmod.ds_SBA_Input[1].OrgID != 0 OR SmallBizCombined_inmod.ds_SBA_Input[1].SeleID != 0;
     
     // we disable the use of SBFE data if the request type is one of the LN-only variants
     disallowSBFE := SmallBizCombined_inmod.BusinessCreditReportType IN LNSmallBusiness.Constants.LNOnlyCreditSet;

     // check to see if we are fetching Cortera trade results
     use_b2b_results := SmallBizCombined_inmod.BusinessCreditReportType = LNSmallBusiness.Constants.LNOnlyB2BCombinedCreditReport;

   /* ************************************************************************
	  *         Get the Small Business Attributes and Scores Results           *
	  ************************************************************************ */
    
     ds_inCreditScoreRequested  := SmallBizCombined_inmod.ModelsRequested(ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL, BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO,BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL]);
		 ds_inBlendedScoreRequested := SmallBizCombined_inmod.ModelsRequested(ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL, BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB,BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL, BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR]);

    // See if the LN Small Business Scores have been requested.
    // If not requested, substitue with the Credit Report scores request.
     LNSmallBizModelsType := 
      MAP( EXISTS(ds_inCreditScoreRequested) AND 
             EXISTS(ds_inBlendedScoreRequested)   => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED,
           EXISTS(ds_inCreditScoreRequested)      => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,
           EXISTS(ds_inBlendedScoreRequested)     => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,
                                                     BusinessCredit_Services.Constants.SCORE_TYPE.NONE );
 
     CreditReportModelsType := 
      MAP( SmallBizCombined_inmod.IncludeCreditReport AND
          (SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID != 0 OR SmallBizCombined_inmod.MinInputMetForAuthRepPopulated)
             => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED, 
           SmallBizCombined_inmod.IncludeCreditReport AND NOT
           SmallBizCombined_inmod.MinInputMetForAuthRepPopulated 
             => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,
                BusinessCredit_Services.Constants.SCORE_TYPE.NONE ); 
                
// Rules for MAP( ) statement below, per Lewis Hughes:
/*
    SmallBusiness_BIP_Combined_Service processes the following models:

    BusinessCredit_Services.Constants. …	AKA…:
    CREDIT_SCORE_MODEL	                  SBOM1601_0_0
    BLENDED_SCORE_MODEL		                SBBM1601_0_0
    CREDIT_SCORE_SLBO		                  SLBO1702_0_2
    BLENDED_SCORE_SLBB		                SLBB1702_0_2
    BLENDED_SCORE_BBFM_SBFEATTR           BBFM1811_1_0

    Lewis expressed to me a couple of things:
      •	These should be seen as pairs of models, and it is expected that the customer would request either SBOM1601 and SBBM1601; or 
        SLBO1601 and SLBB1601. We would not expect to see “cross-pollination” (Lewis’s words) between model pairs, e.g. SBOM1601 and SLBB1601. 
      •	Although a customer can request a “BO” model on its own, they cannot request a “BB” model on its own. To get a “BB” model 
        they must request a “BO” model also.

    These rules apply in the same way to the new models SLBO1809_0_0 and SLBB1809_0_0.

    I believe we can simplify the MAP( ) statement somewhat based on these rules; for the near term though, I’ll focus on getting the MAP( ) statement to play nice with the new models Alek has been working on.
*/

    
    ds_CombinedModelsRequested := 
      MAP( 
						//SLBO and SLBB and SBBM and SBOM
								((LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED or
								CreditReportModelsType = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED) and
									 (SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO]) and
										(SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB])	and	
									 (SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL]) and
										(SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL]))
															=> LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_BLENDED_ALL,
                              
										//SLBO and SLBB
									(LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED and
									 (SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO]) and
										(SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB])) 
                 => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_BLENDED_SLBB_SLBO,
                 
                  // SLBONFEL and SLBBNFEL  BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL IN set_modelsRequested 
                 (LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED and
									BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL IN set_modelsRequested   and	
                  BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL IN set_modelsRequested)                  
                 => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_BLENDED_SLBBNFEL_SLBONFEL,
                 
										//SLBO
										(LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT and
											(SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO]))
                 => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_SLBO,		
                 
										(LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED and
											(SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or
											SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB] or	
											SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB]))
                 => LNSmallBusiness.Constants.DATASET_MODELS.BLENDED_SLBB,	

										//SLBONFEL
										(LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT and
										 BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL IN set_modelsRequested)
                 => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_SLBONFEL,	
                 
                // //SBOM and BBFM
                 
                 	(LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED and
                 (SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
                  SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
                  SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or
                  SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL] or   
                  SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL]) and
                 (SmallBizCombined_inmod.ModelsRequested[1].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR] or
                  SmallBizCombined_inmod.ModelsRequested[2].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR] or
                  SmallBizCombined_inmod.ModelsRequested[3].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR] or
                  SmallBizCombined_inmod.ModelsRequested[4].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR] or     
                  SmallBizCombined_inmod.ModelsRequested[5].ModelName in [BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR])) 
              => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_BLENDED_BBFM_SBFEATTR,


																		 
                 
                    // We're not testing for the SLBBNFEL model only, since the rules listed above indicate that the system must not run a BB model by itself.
                 
									//Old flagships - SBBM and SBOM
           LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED OR   
           CreditReportModelsType = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT_BLENDED 
                                  => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT_BLENDED,
           LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT OR   
           CreditReportModelsType = BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT 
                                  => LNSmallBusiness.Constants.DATASET_MODELS.CREDIT,
           LNSmallBizModelsType   = BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED
                                  => LNSmallBusiness.Constants.DATASET_MODELS.BLENDED,
                                     LNSmallBusiness.Constants.DATASET_MODELS.NONE );
																		 
   // Per meeting with Lewis 7-13-2016:
		//   o  if a seleID is input for the company, get all company info from best.
		//   o  if lexids are provided for the AuthReps, it evaluates to SmallBizCombined_inmod.ds_SBA_Input
    //   o  otherwise send user entered input through (SmallBizCombined_inmod.ds_SBA_Input). 
    ds_SBA_Input_withCompPhone := 
      MAP( SmallBizCombined_inmod.ds_SBA_Input[1].SeleID != 0  
             => LNSmallBusiness.fn_addBestInfo(SmallBizCombined_inmod, LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.SELEID),
           // can comment out for testing so that fn_addBestInfo is not called twice in order to output debug attrs within fn_addBestInfo function.
           SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID != 0  OR
           SmallBizCombined_inmod.ds_SBA_Input[1].Rep_2_LexID != 0  OR
           SmallBizCombined_inmod.ds_SBA_Input[1].Rep_3_LexID != 0 
             => LNSmallBusiness.fn_addBestInfo(SmallBizCombined_inmod, LNSmallBusiness.Constants.BEST_INFO_REQ_TYPE.LEXID_ONLY),
           SmallBizCombined_inmod.ds_SBA_Input );

    SBA_Results_Temp_with_PhoneSources := 
      LNSmallBusiness.SmallBusiness_BIP_Function(ds_SBA_Input_withCompPhone,
                                                 SmallBizCombined_inmod.DPPAPurpose,
                                                 SmallBizCombined_inmod.GLBAPurpose,
                                                 (STRING50)SmallBizCombined_inmod.DataRestrictionMask,
                                                 (STRING50)SmallBizCombined_inmod.DataPermissionMask,
                                                 SmallBizCombined_inmod.IndustryClass,
                                                 SmallBizCombined_inmod.LinkSearchLevel,
                                                 SmallBizCombined_inmod.MarketingMode,
                                                 SmallBizCombined_inmod.AllowedSources,
                                                 SmallBizCombined_inmod.OFAC_Version,
                                                 SmallBizCombined_inmod.Global_Watchlist_Threshold,
                                                 SmallBizCombined_inmod.Watchlists_Requested,
                                                 SmallBizCombined_inmod.Gateways,
                                                 SmallBizCombined_inmod.AttributesRequested,
                                                 ds_CombinedModelsRequested,
                                                 SmallBizCombined_inmod.ModelOptions,
                                                 SmallBizCombined_inmod.DisableIntermediateShellLogging,
                                                 SmallBizCombined_inmod.IncludeTargusGateway,
                                                 SmallBizCombined_inmod.RunTargusGateway, /* for testing purposes only */
                                                 BusinessCredit_Services.Constants.BIPID_WEIGHT_THRESHOLD, 
                                                 DisableSBFE := disallowSBFE,
												 LexIdSourceOptout := SmallBizCombined_inmod.in_LexIdSourceOptout, 
                                                 TransactionID := SmallBizCombined_inmod.in_TransactionID, 
                                                 BatchUID := SmallBizCombined_inmod.in_BatchUID, 
                                                 GlobalCompanyID := SmallBizCombined_inmod.in_GlobalCompanyID);


	  SBA_Results_Temp := 
      PROJECT(SBA_Results_Temp_with_PhoneSources, 
              LNSmallBusiness.BIP_Layouts.IntermediateLayout );
              
	  SBA_Results := 
     IF(~SmallBizCombined_inmod.TestDataEnabled, 
        SBA_Results_Temp,
        LNSmallBusiness.SmallBusiness_BIP_Testseed_Function(SmallBizCombined_inmod.ds_SBA_Input,
                                                            (STRING32)SmallBizCombined_inmod.TestDataTableName,
                                                            SmallBizCombined_inmod.DataPermissionMask,
                                                            ds_CombinedModelsRequested));

    ds_NewModels:=	if(EXISTS(ds_CombinedModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB)),
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SLBB, 
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE) +
						if(EXISTS(ds_CombinedModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO)),
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_SLBO, 
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE) + 
            	if(EXISTS(ds_CombinedModelsRequested(ModelName = BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL)),
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_SCORE_SLBONFEL, 
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE)+
              	if(EXISTS(ds_CombinedModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL)),
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SCORE_SLBBNFEL, 
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE)+  
              	if(EXISTS(ds_CombinedModelsRequested(ModelName = BusinessCredit_Services.Constants.BLENDED_SCORE_BBFM_SBFEATTR)),
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_BBFM_SBFEATTR, 
							BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE); 
	
		isGoodHit := SBA_Results[1].MatchWeight >= BusinessCredit_Services.Constants.BIPID_WEIGHT_THRESHOLD;
		
   /* ****************************************************************************
    *                    Business Credit Report Input                            *
    ******************************************************************************/ 	
  
    BIPV2.IDlayouts.l_xlink_ids2 xfm_getLinkIds() := 
      TRANSFORM  
        SELF.SeleID := SBA_Results[1].SeleID;
        SELF.OrgID  := SBA_Results[1].OrgID;
        SELF.UltID  := SBA_Results[1].UltID;  
        SELF := [];
      END;
    ds_BizLinkIds := DATASET([xfm_getLinkIds()]);  
    
    CreditReportInput_mod := 
      MODULE (PROJECT(SmallBizCombined_inmod, BusinessCredit_Services.Iparam.reportrecords, OPT));
        EXPORT DATASET (BIPV2.IDlayouts.l_xlink_ids2) BusinessIds := ds_BizLinkIds;
        EXPORT UNSIGNED1 GLBPurpose             := SmallBizCombined_inmod.GLBAPurpose;
        EXPORT STRING32  ApplicationType        := SmallBizCombined_inmod.ApplicationType;
        EXPORT STRING14  DID                    := (STRING14)SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_LexID;
       
				// Include_businessCredit Always true when called from here
				// in order to keep boolean true and have backward compability this SmallBizCombined_inmod.BusinessCreditReportType needs to be set
				// to the option of '1'  by default in the top level service ( LNSmallBusiness.SmallBusiness_BIP_Combined_Service)
				// which is the value of BusinessCredit_Services.Constants.SBFEDataBusinessCreditReport if nothing or '1'  is passed in.
				// in the future when a '2' or '3' is passed for BusinessCreditReportType meaning LnOnly Credit then this will ensure that Include_businessCredit
				// is false meaning no SBFE data in that particular version of the report.
        EXPORT BOOLEAN   Include_BusinessCredit :=   SmallBizCombined_inmod.BusinessCreditReportType = 
		                                                                                         BusinessCredit_Services.Constants.SBFEDataBusinessCreditReport; 

        EXPORT BOOLEAN  LimitPaymentHistory24Months  :=  SmallBizCombined_inmod. LimitPaymentHistory24Months; // small bus Credit Report w SBFE addition
        EXPORT STRING     SBFEContributorIds  := SmallBizCombined_inmod.SBFEContributorIds; // small bus Credit Report w SBFE addition
        EXPORT STRING1 BusinessCreditReportType :=  SmallBizCombined_inmod.BusinessCreditReportType;  // use input iparam for requirement 1.3.3 
        EXPORT STRING1   FetchLevel 					  := BIPV2.IDconstants.Fetch_Level_SELEID;
        EXPORT BOOLEAN   IncludeScores          := FALSE; // Don't return scores becasue we are getting them from LNSmallBizAna 
        EXPORT BOOLEAN   AllowAll               := FALSE;
        EXPORT BOOLEAN   AllowDPPA              := FALSE;
        EXPORT BOOLEAN   AllowGLB               := FALSE;
        EXPORT BOOLEAN   includeMinors          := FALSE; 
        EXPORT BOOLEAN   TestDataEnabled        := SmallBizCombined_inmod.TestDataEnabled; 
        EXPORT STRING    TestDataTableName      := SmallBizCombined_inmod.TestDataTableName; 
        EXPORT companyname                      := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Company_Name;
        EXPORT company_streetaddress1           := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Street_Address1;
        EXPORT company_city                     := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_City;
        EXPORT company_state                    := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_State;
        EXPORT company_zip                      := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Zip;
        EXPORT company_phone                    := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_Phone10;
        EXPORT tin                              := SmallBizCombined_inmod.ds_SBA_Input[1].Bus_FEIN;
        EXPORT firstname                        := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_First_Name;
        EXPORT middlename                       := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Middle_Name;
        EXPORT lastname                         := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Last_Name;
        EXPORT authrep_streetaddress1           := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Street_Address1;
        EXPORT authrep_city                     := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_City;
        EXPORT authrep_state                    := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_State;
        EXPORT authrep_zip                      := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Zip;
        EXPORT authrep_phone                    := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_Phone10;
        EXPORT ssn                              := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_SSN;
        EXPORT dob                              := (INTEGER)SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_DOB;
        EXPORT dlnumber                         := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_DL_Number;
        EXPORT dlstate                          := SmallBizCombined_inmod.ds_SBA_Input[1].Rep_1_DL_State;
        EXPORT BOOLEAN UseInputDataAsIs         := SmallBizCombined_inmod.UseInputDataAsIs;
      END;

    iesp.businesscreditreport.t_BusinessCreditReportRecord bizCred_null_trans() := TRANSFORM
      SELF := [];
    END;

    ds_BizCredRecord_raw	:= IF(SmallBizCombined_inmod.IncludeCreditReport, 
                                BusinessCredit_Services.CreditReport_Records(CreditReportInput_mod),
                                DATASET([bizCred_null_trans()]));

    ds_BizCredRecord_results := PROJECT(ds_BizCredRecord_raw, 
      TRANSFORM(iesp.smallbusinessbipcombinedreport.t_CombinedSmallBusinessCreditReportRecord, 
        SELF := LEFT, 
        SELF := []));

    // -----------------------------------------------------------------------------------------
    // ----------------------------- LN-Only (Cortera) B2B Trade Data --------------------------
    // -----------------------------------------------------------------------------------------
    ds_b2bTrade_LNResults := LNSmallBusiness.LN_Tradeline_Functions(ds_BizLinkIds).compose_b2b_trade_data();
    ds_b2bTrade_TestSeedResults := LNSmallBusiness.getCorteraTestSeedData(SmallBizCombined_inmod.ds_SBA_Input,
                                                                         (STRING20)SmallBizCombined_inmod.TestDataTableName);
    ds_b2bTrade_results_nohit := 
      LNSmallBusiness.LN_Tradeline_Functions(ds_BizLinkIds).compose_b2b_trade_data_nohit(
        (string)AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT, 
        AutoKeyI.errorcodes._msgs(AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT)
      );
   
    ds_b2bTrade_results := IF(SmallBizCombined_inmod.TestDataEnabled,
                              ds_b2bTrade_TestSeedResults, 
                              ds_b2bTrade_LNResults);

   /* ****************************************************************************
    *        Business Credit Report: get historical scores using index           *
    ******************************************************************************/ 	

    set_ScoreTypeFilter := BusinessCredit_Services.Functions.fn_set_ScoreTypeFilter( CreditReportModelsType ) +
      ds_newModels;

	  ds_HistoricalCreditScoringRecs := 
      Business_Credit_Scoring.Key_ScoringIndex().kFetch2(ds_BizLinkIds,
                                                         SmallBizCombined_inmod.FetchLevel,,
                                                         SmallBizCombined_inmod.DataPermissionMask, 
                                                         BusinessCredit_Services.Constants.JOIN_LIMIT);
                                                         
    ds_hist_scores_tmp		:= 
      CHOOSEN(PROJECT(ds_HistoricalCreditScoringRecs, 
                      TRANSFORM(iesp.businesscreditreport.t_BusinessCreditScoring,
                        SELF.DateScored 									:= iesp.ECL2ESP.toDatestring8(LEFT.version),
                        SELF.CurrentPriorFlag							:= LNSmallBusiness.Constants.HISTORICAL_FLAG,
                        SELF.PrimaryIndustryCode					:= LEFT.Classification_Code,
                        SELF.PrimaryIndustryDescription		:= LEFT.Classification_Code_Description,
                        SELF.IndustryScore								:= (INTEGER)LEFT.Industry_Score_Avg,
                        SELF.Scores												:= CHOOSEN(PROJECT(LEFT.Scores , 
                                                                      TRANSFORM(iesp.businesscreditreport.t_BusinessCreditScore,
                                                                        SELF.ScoreType		 	:=	LEFT.Score_Name; 
                                                                        SELF.MinScoreRange 	:=	LEFT.Min_Score_Range;
                                                                        SELF.MaxScoreRange 	:=	LEFT.Max_Score_Range;
                                                                        SELF.Score					:= 	LEFT.Score;
                                                                        SELF.ScoreRiskLevel	:=	MAP(
                                                                                                    (UNSIGNED)LEFT.Score BETWEEN 501 AND 650 => LNSmallBusiness.Constants.RISK_LEVEL_HIGH,
                                                                                                    (UNSIGNED)LEFT.Score BETWEEN 651 AND 750 => LNSmallBusiness.Constants.RISK_LEVEL_MEDIUM,
                                                                                                    (UNSIGNED)LEFT.Score BETWEEN 751 AND 900 => LNSmallBusiness.Constants.RISK_LEVEL_LOW,
                                                                                                    (UNSIGNED)LEFT.Score = 222               => LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT,
                                                                                                    /* default...........................: */   LNSmallBusiness.Constants.RISK_LEVEL_DEFAULT
                                                                                                ); //Logic to determine High/Med/Low scores given by scoring team.
                                                                        SELF.ScoreReasons		:= 	CHOOSEN(PROJECT(LEFT.ScoreReasons, iesp.businesscreditreport.t_BusinessCreditScoreReason),BusinessCredit_Services.Constants.MAX_CREDIT_SCORE_REASON);
                                                                      )), iesp.constants.BusinessCredit.MaxScores);
                    )), BusinessCredit_Services.Constants.Max_Historical_Scores);

    // do not return historical scores for SBFE-restricted queries
    ds_hist_scores := IF(disallowSBFE, 
      DATASET([], iesp.businesscreditreport.t_BusinessCreditScoring),
      ds_hist_scores_tmp
    );

   /* *****************************************************************************************
    * Business Credit Report: get Current scores for Credit Report from LNSmallBizAna results *
    *******************************************************************************************/ 	
 
    ds_model_results	          := NORMALIZE(SBA_Results, LEFT.ModelResults, TRANSFORM(RIGHT));
	  ds_modelScores_res_filtered := ds_model_results( Name IN set_ScoreTypeFilter );

    iesp.businesscreditreport.t_BusinessCreditScore xfm_current_scores(RECORDOF(ds_model_results) L) := 
      TRANSFORM  
        SELF.ScoreType		 	:=	CASE(L.Name, 
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,  
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,  
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED, 
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED, 
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT, 
                                     ''
                                    );
        SELF.MinScoreRange 	:=	(UNSIGNED2)BusinessCredit_Services.Constants.MIN_SCORE_RANGE;
        SELF.MaxScoreRange 	:=	(UNSIGNED2)BusinessCredit_Services.Constants.MAX_SCORE_RANGE;
        SELF.Score					:= 	(INTEGER)L.Scores[1].Value;
        SELF.ScoreRiskLevel	:=	MAP((UNSIGNED)L.Scores[1].Value BETWEEN 501 AND 650 => LNSmallBusiness.Constants.RISK_LEVEL_HIGH,
                                    (UNSIGNED)L.Scores[1].Value BETWEEN 651 AND 750 => LNSmallBusiness.Constants.RISK_LEVEL_MEDIUM,
                                    (UNSIGNED)L.Scores[1].Value BETWEEN 751 AND 900 => LNSmallBusiness.Constants.RISK_LEVEL_LOW,
                                    (UNSIGNED)L.Scores[1].Value = 222               => LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT,
                                     /* default......................: */              LNSmallBusiness.Constants.RISK_LEVEL_DEFAULT
                                    ); //Logic to determine High/Med/Low scores given by scoring team.
        SELF.ScoreReasons		:=	CHOOSEN(PROJECT(L.Scores[1].ScoreReasons, 
                                  TRANSFORM(iesp.businesscreditreport.t_BusinessCreditScoreReason, 
                                            SELF.Description := (STRING100)LEFT.Description,
                                            SELF             := LEFT
                                           )), BusinessCredit_Services.Constants.MAX_CREDIT_SCORE_REASON);
        SELF := [];
      END;

		// Correct the output so the Blended score within the credit report response returns 
		// a 222 where the business is not found. This shall only affect the scores in the 
		// credit report section within the Combined Report service response.
    iesp.businesscreditreport.t_BusinessCreditScore xfm_current_scores_no_hit(RECORDOF(ds_model_results) L) := 
      TRANSFORM  
				NoHit_ReasonCode := 'B068';

        SELF.ScoreType		 	:=	CASE(L.Name, 
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_MODEL	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,  
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_MODEL => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_SLBO	 => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,  
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_SLBB => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,  
                                     BusinessCredit_Services.Constants.BLENDED_SCORE_SLBBNFEL => BusinessCredit_Services.Constants.SCORE_TYPE.BLENDED,  
                                     BusinessCredit_Services.Constants.CREDIT_SCORE_SLBONFEL => BusinessCredit_Services.Constants.SCORE_TYPE.CREDIT,  
                                     ''
                                    );
        SELF.MinScoreRange 	:=	(UNSIGNED2)BusinessCredit_Services.Constants.MIN_SCORE_RANGE;
        SELF.MaxScoreRange 	:=	(UNSIGNED2)BusinessCredit_Services.Constants.MAX_SCORE_RANGE;
        SELF.Score					:= 	222;
        SELF.ScoreRiskLevel	:=	LNSmallBusiness.Constants.RISK_LEVEL_NO_HIT;
        SELF.ScoreReasons		:=	DATASET( 
																	[
																		{'1', NoHit_ReasonCode, Risk_Indicators.getHRIDesc(NoHit_ReasonCode)},
																		{'2',               '',                                           ''},
																		{'3',               '',                                           ''},
																		{'4',               '',                                           ''}
																	], iesp.businesscreditreport.t_BusinessCreditScoreReason );
        SELF := [];
      END;
			
    _curr_Scores_good_hit	:= PROJECT(ds_modelScores_res_filtered , xfm_current_scores(LEFT));
		_curr_Scores_no_hit   := PROJECT(ds_modelScores_res_filtered , xfm_current_scores_no_hit(LEFT));
		
		_curr_Scores := IF( isGoodHit OR SmallBizCombined_inmod.TestDataEnabled, 
      _curr_Scores_good_hit, 
      _curr_Scores_no_hit
    );
		
    iesp.businesscreditreport.t_BusinessCreditScoring xfm_CurrScores_toIESP_Layout() := 
      TRANSFORM
        SELF.DateScored 									:= iesp.ECL2ESP.toDatestring8((STRING8)Std.Date.Today()),
        SELF.CurrentPriorFlag 						:= LNSmallBusiness.Constants.CURRENT_FLAG,
        SELF.Scores 											:= PROJECT(_curr_Scores , TRANSFORM(LEFT)), 
        SELF															:= [];
    END;
    
    ds_curr_Scores := DATASET([xfm_CurrScores_toIESP_Layout()]);

   /* ****************************************************************************
    *  Business Credit Report: get historical scores using index       *
    ******************************************************************************/ 	
	
    ds_CreditReportCurAndHistScores := SORT(ds_curr_Scores + ds_hist_scores, -(CurrentPriorFlag = LNSmallBusiness.Constants.CURRENT_FLAG), -DateScored);
  
  	ds_Phone_Sources := NORMALIZE(SBA_Results_Temp_with_PhoneSources, LEFT.PhoneSources, TRANSFORM(RIGHT));
	  ds_CreditReportPhoneSources := 
      PROJECT(ds_Phone_Sources, 
        TRANSFORM(iesp.businesscreditreport.t_BusinessCreditPhoneSources,
                  SELF.DateFirstSeen:= iesp.ECL2ESP.toDatestring8(LEFT.DateFirstSeen+'00'),
                  SELF.DateLastSeen	:= iesp.ECL2ESP.toDatestring8(LEFT.DateLastSeen+'00'),
                  SELF							:= LEFT));

    // Add LN Small Biz Scores  and LN Small Biz phone sources to Credit Report Records 
    ds_Final_CreditReportRecords := 
      PROJECT(ds_bizCredRecord_results,
        TRANSFORM(iesp.smallbusinessbipcombinedreport.t_CombinedSmallBusinessCreditReportRecord,
          SELF.Scorings := CHOOSEN(ds_CreditReportCurAndHistScores, iesp.constants.BusinessCredit.MaxSection),
          SELF.PhoneSources	:= CHOOSEN(ds_CreditReportPhoneSources, iesp.constants.BusinessCredit.MaxSection),
          SELF.B2BTradeData := IF(use_b2b_results, ds_b2bTrade_results[1]),
          SELF := LEFT,
          SELF := []
      ));

    ds_Final_CreditReportRecords_NoHit := 
      PROJECT(ds_bizCredRecord_results,
              TRANSFORM(iesp.smallbusinessbipcombinedreport.t_CombinedSmallBusinessCreditReportRecord,
                        SELF.Scorings := ds_curr_Scores, // Omit historical Scores; current Scores indicate a no-hit.
                        SELF.B2BTradeData := if(use_b2b_results, ds_b2bTrade_results_nohit[1]), 
                        SELF := []
              ));

    LNSmallBusiness.Layouts.SmallBusinessBipCombinedReportIntermediateResponse xfm_transform_SmallBusinessBipCombinedReportResponse() := 
      TRANSFORM
        SELF._Header := IF( ~SmallBizCombined_inmod.TestDataEnabled, iesp.ECL2ESP.GetHeaderRow()); //Don't populate the header row if testseeds are requested.
        SELF.InputEcho := ROW([],iesp.smallbusinessbipcombinedreport.t_SmallBusinessBipCombinedReportSearchBy); 
        SELF.BillingHit := (INTEGER)SBA_Results[1].BillingHit;
        SELF.SmallBusinessAnalyticsResults := ROW([],iesp.smallbusinessbipcombinedreport.t_SmallBusinessAnalyticsIDsModelsAttributes);
        SELF.CreditReportRecords := ds_Final_CreditReportRecords;	
        SELF.SBA_Results := SBA_Results; 
        SELF.SmallBiz_SBFE_Royalty := (INTEGER)SBA_Results[1].SBFEAccountCount > 0;
        SELF.Rep_LexID := SBA_Results[1].Rep_LexID;
        SELF.LNSmallBizModelsType := LNSmallBizModelsType;
        SELF.NewLNSmallBizModelsType := ds_NewModels;       
       END;
    
    ds_results_Hit := DATASET([xfm_transform_SmallBusinessBipCombinedReportResponse()]) ;
 
    LNSmallBusiness.Layouts.SmallBusinessBipCombinedReportIntermediateResponse xfm_transform_NoHit() := 
      TRANSFORM
        SELF._Header := IF( ~SmallBizCombined_inmod.TestDataEnabled, iesp.ECL2ESP.GetHeaderRow()); //Don't populate the header row if testseeds are requested.
        SELF.InputEcho := ROW([],iesp.smallbusinessbipcombinedreport.t_SmallBusinessBipCombinedReportSearchBy);
        SELF.BillingHit := (INTEGER)SBA_Results[1].BillingHit;
        SELF.SmallBusinessAnalyticsResults := ROW([],iesp.smallbusinessbipcombinedreport.t_SmallBusinessAnalyticsIDsModelsAttributes);
        SELF.CreditReportRecords := ds_Final_CreditReportRecords_NoHit;	
        SELF.SBA_Results := SBA_Results; 
        SELF.SmallBiz_SBFE_Royalty := (INTEGER)SBA_Results[1].SBFEAccountCount > 0;
        SELF.Rep_LexID  := 0;
        SELF.LNSmallBizModelsType := LNSmallBizModelsType;
        SELF.NewLNSmallBizModelsType := ds_NewModels;       
      END;
      
    ds_results_NoHit := DATASET([xfm_transform_NoHit()]) ;
		
		ds_results := IF( isGoodHit OR isBIPIDSearch OR SmallBizCombined_inmod.TestDataEnabled, ds_results_Hit, ds_results_NoHit );

   RETURN ds_results;
  
END;
