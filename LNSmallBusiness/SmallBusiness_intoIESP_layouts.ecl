IMPORT BusinessCredit_Services, iesp, LNSmallBusiness;

EXPORT SmallBusiness_intoIESP_layouts := 
  MODULE
  
    EXPORT fn_SmallBiz_intoESDL(DATASET(LNSmallBusiness.BIP_Layouts.IntermediateLayout) SBA_Results = DATASET([],LNSmallBusiness.BIP_Layouts.IntermediateLayout),
                                DATASET(LNSmallBusiness.Layouts.AttributeGroupRec) AttributesRequested = DATASET([],LNSmallBusiness.Layouts.AttributeGroupRec),
                                STRING20 LNSmallBizModelsType =  BusinessCredit_Services.Constants.SCORE_TYPE.NONE,
																																SET OF STRING NewLNSmallBizModelsType =  BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE
                               ) := 
      FUNCTION
        /* *************************************************************************
         *  Transform the Small Business Attributes and Scores Results into IESP   *
         ***************************************************************************/

        // Create Version 1 Name/Value Pair Attributes
        NameValuePairsVersion1 := NORMALIZE(SBA_Results, 200, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion1(LEFT, COUNTER));

        iesp.smallbusinessanalytics.t_SBAAttributesGroup xfm_SmallBiz_Version1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := 
          TRANSFORM
            SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V1_NAME;
            SELF.Attributes := NameValuePairsVersion1;
          END;

 // Create Version 101 Name/Value Pair Attributes
        NameValuePairsVersion101 := NORMALIZE(SBA_Results, 197, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion101(LEFT, COUNTER));

        iesp.smallbusinessanalytics.t_SBAAttributesGroup xfm_SmallBiz_Version101(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := 
          TRANSFORM
            SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_NOFEL;
            SELF.Attributes := NameValuePairsVersion101;
          END;


        // Create Version 2 Name/Value Pair Attributes
        NameValuePairsVersion2 := NORMALIZE(SBA_Results, 316, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoVersion2(LEFT, COUNTER));
        
        iesp.smallbusinessanalytics.t_SBAAttributesGroup xfm_SmallBiz_Version2(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := TRANSFORM
          SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_ATTR_V2_NAME;
          SELF.Attributes := NameValuePairsVersion2;
        END;
  
        // Create SBFE Name/Value Pair Attributes
				NameValuePairsSBFE := NORMALIZE(SBA_Results, 1841, LNSmallBusiness.SmallBusiness_BIP_Transforms.intoSBFE(LEFT, COUNTER));

        iesp.smallbusinessanalytics.t_SBAAttributesGroup xfm_SmallBiz_SBFEVersion1(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := 
          TRANSFORM
            SELF.Name := LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR_NAME;
            SELF.Attributes := NameValuePairsSBFE;
          END;
        
         set_ScoreTypeFilter := BusinessCredit_Services.Functions.fn_set_ScoreTypeFilter( LNSmallBizModelsType ) + 
														NewLNSmallBizModelsType;

         // Return only the models requested by the user, return empty dataset if none requested
         ds_modelsToReturn := 
          SBA_Results.ModelResults( Name IN set_ScoreTypeFilter );
          
        // Create the final ESDL Layout
        iesp.smallbusinessbipcombinedreport.t_SmallBusinessAnalyticsIDsModelsAttributes xfm_intoSmallBizESDL(LNSmallBusiness.BIP_Layouts.IntermediateLayout le) := 
          TRANSFORM
            SELF.BusinessIDs.PowID := le.PowID;
            SELF.BusinessIDs.ProxID := le.ProxID;
            SELF.BusinessIDs.SeleID := le.SeleID;
            SELF.BusinessIDs.OrgID := le.OrgID;
            SELF.BusinessIDs.UltID := le.UltID;
            SELF.Models := ds_modelsToReturn, 
            SELF.AttributesGroups := IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 1, PROJECT(le, xfm_SmallBiz_Version1(LEFT))) + 
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 101, PROJECT(le, xfm_SmallBiz_Version101(LEFT))) +
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..18] = LNSmallBusiness.Constants.SMALL_BIZ_ATTR)[1].AttributeGroup[19..] = 2, PROJECT(le, xfm_SmallBiz_Version2(LEFT))) +
																	 IF((UNSIGNED)AttributesRequested(AttributeGroup[1..9] = LNSmallBusiness.Constants.SMALL_BIZ_SBFE_ATTR)[1].AttributeGroup[10..] = 1, PROJECT(le, xfm_SmallBiz_SBFEVersion1(LEFT))) +
																	 DATASET([], iesp.smallbusinessanalytics.t_SBAAttributesGroup);
            SELF := [];
          END;

        ds_FinalSmallBizAnaResults := PROJECT(SBA_Results, xfm_intoSmallBizESDL(LEFT))[1];

      RETURN ds_FinalSmallBizAnaResults;  
    END;  // End function
  
  
  END;  // end module