IMPORT BusinessCredit_Services, LNSmallBusiness;

EXPORT Constants := 
  MODULE
  
    EXPORT AUTHORIZED_REP_TO_USE	:= ENUM(INTEGER, FIRST_PARSED, FIRST_FULL, SECOND_PARSED, SECOND_FULL, THIRD_PARSED, THIRD_FULL ); 
    
    EXPORT RISK_LEVEL_HIGH    := 'HIGH';
		EXPORT RISK_LEVEL_MEDIUM  := 'MEDIUM';
		EXPORT RISK_LEVEL_LOW     := 'LOW';
		EXPORT RISK_LEVEL_NO_HIT  := 'NO HIT';
		EXPORT RISK_LEVEL_DEFAULT := 'UNK';		
    
    EXPORT CURRENT_FLAG       := 'C';
    EXPORT HISTORICAL_FLAG    := 'H';

    EXPORT SMALL_BIZ_ATTR_V1_NAME   	:= 'SmallBusinessAttrV1';
    EXPORT SMALL_BIZ_ATTR_V2_NAME   	:= 'SmallBusinessAttrV2';
    EXPORT SMALL_BIZ_SBFE_ATTR_NAME 	:= 'SmallBusinessAttrSBFE';
		EXPORT SMALL_BIZ_MKT_ATTR_V1_NAME := 'SmBusMktAttrV1';
    EXPORT SMALL_BIZ_ATTR           	:= 'SMALLBUSINESSATTRV';
    EXPORT SMALL_BIZ_SBFE_ATTR      	:= 'SBFEATTRV';
    EXPORT SMALL_BIZ_SBFE_V1_ATTR   	:= 'SBFEATTRV1';
		EXPORT SMALL_BIZ_MKT_ATTR			 		:= 'SMBUSMKTATTRV';
		EXPORT SMALL_BIZ_ATTR_NOFEL			 	:= 'SmallBusinessAttrV101';
    
    EXPORT BEST_INFO_REQ_TYPE	    	:= ENUM(INTEGER, SELEID, PHONE, LEXID_ONLY );
                   
    EXPORT DATASET_MODELS := 
      MODULE
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT         := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
        
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_SLBB        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SLBB], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_BBFM        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_SLBO         := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_SLBO], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_SLBB_SLBO := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBB_SLBO], LNSmallBusiness.Layouts.ModelNameRec); 

        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_SLBBNFEL                 := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SCORE_SLBBNFEL], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_SLBONFEL                  := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_SCORE_SLBONFEL], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_SLBBNFEL_SLBONFEL := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBBNFEL_SLBONFEL], LNSmallBusiness.Layouts.ModelNameRec); 
        
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_ALL := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_ALL], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_ALL              := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_ALL], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) NONE           := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.NONE], LNSmallBusiness.Layouts.ModelNameRec); 
      END;
		
		EXPORT BIPID_WEIGHT_THRESHOLD := 
			MODULE
				EXPORT UNSIGNED2 FOR_SmallBusiness_BIP_Batch_Service       := 44;
				EXPORT UNSIGNED2 FOR_SmallBusiness_BIP_Service             := 44;
				EXPORT UNSIGNED2 FOR_SmallBusiness_Marketing_Batch_Service := 44;
				EXPORT UNSIGNED2 FOR_SmallBusiness_Marketing_Service       := 44;
				EXPORT UNSIGNED2 DEFAULT_VALUE                             :=  0;
			END;

  EXPORT set_Cortera_attributeNames :=
    [
      'B2BProviderAvg12M',
      'B2BProviderDelta12M',
      'B2BProviderDelta24M',
      'B2BSpendCategories12M',
      'B2BSpendTotal12M',
      'B2BSpendDelta12M',
      'B2BSpendDelta24M',
      'B2BDBTAvg03',
      'B2B30DBT12MInd',
      'B2B60DBT12MInd',
      'B2B90DBT12Ind',
      'B2BDBT30Delta12M',
      'B2BDBT30Delta24M',
      'B2BDBT60Delta12M',
      'B2BDBT60Delta24M',
      'B2BPaid12M',
      'B2BBalanceAvg03M'
    ];
    
  Export OutputType := module
      EXPORT string1 PDF_ONLY := 'P';    //Means ‘PDF Only’
      EXPORT string1 PDF_AND_XML := 'B'; //Means ‘PDF and XML’
      EXPORT string1 XML_ONLY := 'X';    //Means ‘XML Only’
      EXPORT string1 BLANK := '';        // Empty/Nothing/NotPresent 
  end;
  END;