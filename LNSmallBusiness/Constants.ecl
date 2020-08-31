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
		
    EXPORT STRING1        SBFEDataBusinessCreditReport := '1'; // default
    EXPORT STRING1        LNOnlyBusinessCreditReport := '2';
 		EXPORT STRING1        LNOnlyB2BCombinedCreditReport := '3';
  	EXPORT SET OF STRING1 LNOnlyCreditSet := [LNOnlyBusinessCreditReport, LNOnlyB2BCombinedCreditReport];

    EXPORT SMALL_BIZ_ATTR_V1_NAME   	:= 'SmallBusinessAttrV1';
    EXPORT SMALL_BIZ_ATTR_V2_NAME   	:= 'SmallBusinessAttrV2';
    EXPORT SMALL_BIZ_ATTR_V21_NAME   	:= 'SmallBusinessAttrV21';
    EXPORT SMALL_BIZ_SBFE_ATTR_NAME 	:= 'SmallBusinessAttrSBFE';
    EXPORT SMALL_BIZ_SBFEINS_ATTR_NAME:= 'SmallBusinessAttrSBFEIns'; 
		EXPORT SMALL_BIZ_MKT_ATTR_V1_NAME := 'SmBusMktAttrV1';
    EXPORT SMALL_BIZ_ATTR           	:= 'SMALLBUSINESSATTRV';
    EXPORT SMALL_BIZ_SBFE_ATTR      	:= 'SBFEATTRV';
    EXPORT SMALL_BIZ_SBFE_V1_ATTR   	:= 'SBFEATTRV1';
    EXPORT SMALL_BIZ_SBFE_V1_ATTR_INS := 'SBFEATTRV1INS';
		EXPORT SMALL_BIZ_MKT_ATTR			 		:= 'SMBUSMKTATTRV';
		EXPORT SMALL_BIZ_ATTR_NOFEL			 	:= 'SmallBusinessAttrV101';
    
    EXPORT BEST_INFO_REQ_TYPE	    	:= ENUM(INTEGER, SELEID, PHONE, LEXID_ONLY );
    
    EXPORT set_SBFE_models :=
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT;

    EXPORT set_BusShellv22_models :=
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBB_SLBO + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BOFM + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM_SBFEATTR + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.BBFM1906_1_0 + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM_NSBFEWITHEXP + 
        BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_SLBBNFEL_SLBONFEL;

    EXPORT DATASET_MODELS := 
      MODULE
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT         := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED], LNSmallBusiness.Layouts.ModelNameRec); 
        
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_SLBB        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_SLBB], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_BBFM        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) BLENDED_BBFM_SBFEATTR       := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.BLENDED_BBFM_SBFEATTR], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BLENDED_BBFM_SBFEATTR       := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BLENDED_BBFM_SBFEATTR], LNSmallBusiness.Layouts.ModelNameRec); 
        EXPORT DATASET(LNSmallBusiness.Layouts.ModelNameRec) CREDIT_BOFM        := DATASET([BusinessCredit_Services.Constants.MODEL_NAME_SETS.CREDIT_BOFM], LNSmallBusiness.Layouts.ModelNameRec); 
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
	
	EXPORT SET_TARGUS_SERVICENAMES := 
		[
			'targus',
			'targuse3220'
		];

  EXPORT IndustrySegment := MODULE
    EXPORT string Material := 'MATERIAL';
    EXPORT string Operations := 'OPERATIONS';
    EXPORT string Carrier := 'CARRIER';
    EXPORT string Fleet := 'FLEET';
    EXPORT string Other := 'OTHER';

    EXPORT Set_Material := [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25];
    EXPORT Set_Operations := [26, 27, 28, 29, 30, 31, 32, 33, 34, 35];
    EXPORT Set_Carrier := [1, 4, 5, 6, 8];
    EXPORT Set_Fleet := [2, 3, 9];
  END;

  EXPORT B2BAccountStatus := MODULE
    EXPORT string Inactive := 'INACTIVE';
    EXPORT string Current := 'CURRENT';
    EXPORT string Overdue := 'OVERDUE';
  END;

  END;