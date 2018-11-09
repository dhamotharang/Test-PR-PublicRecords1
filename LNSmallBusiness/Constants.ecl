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
    EXPORT SMALL_BIZ_SBFE_ATTR_NAME 	:= 'SmallBusinessAttrSBFE';
		EXPORT SMALL_BIZ_MKT_ATTR_V1_NAME := 'SmBusMktAttrV1';
    EXPORT SMALL_BIZ_ATTR           	:= 'SMALLBUSINESSATTRV';
    EXPORT SMALL_BIZ_SBFE_ATTR      	:= 'SBFEATTRV';
    EXPORT SMALL_BIZ_SBFE_V1_ATTR   	:= 'SBFEATTRV1';
		EXPORT SMALL_BIZ_MKT_ATTR			 		:= 'SMBUSMKTATTRV';
    
    EXPORT BEST_INFO_REQ_TYPE	    	:= ENUM(INTEGER, SELEID, PHONE, LEXID_ONLY );
                   
    EXPORT DATASET_MODELS := 
      MODULE
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT         := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
	       EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_SLBB        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SLBB], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_SLBO         := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_SLBO], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_SLBB_SLBO := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBB_SLBO], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_ALL := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_ALL], LNSmallBusiness.Layouts.ModelNameRec); 
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

  END;