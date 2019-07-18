﻿IMPORT MDR;

EXPORT Constants := MODULE

		EXPORT STRING2  DATASOURCE_CODE_BUSINESS_CREDIT := MDR.sourceTools.src_Business_Credit;  
		EXPORT BUSINESS_CREDIT_INDICATOR 								:= ENUM(INTEGER, HEADER_FILE_ONLY, BUSINESS_CREDIT_ONLY, BOTH );
          EXPORT  UNSIGNED4 BestKfetchMaxLimit                 := 1000;
		EXPORT UNSIGNED4	KFETCH_MAX_LIMIT				:= 10000;
		EXPORT UNSIGNED4	JOIN_LIMIT							:= 5000;
		EXPORT INTEGER 		PAST84MONTHSInDays			:= -2556;
		EXPORT INTEGER 		PAST24MONTHSInDays 			:= -730;
		EXPORT INTEGER 		ONE_MONTH								:= -30;
		EXPORT INTEGER 		SIX_MONTHS							:= -180;
		EXPORT INTEGER 		NINE_MONTHS							:= -270;
		EXPORT INTEGER 		ONE_YEAR								:= -365; 
		
		EXPORT STRING1        SBFEDataBusinessCreditReport := '1'; // default
		EXPORT STRING1        LNOnlyBusinessCreditReport := '2';
		
		EXPORT UNSIGNED1	TWO_YR_PAYMENT_HISTORY      := 24;  // Small Bus credit Report SBFE Addition
		EXPORT UNSIGNED1  TOPCHARGEOFFCOUNT := 10; // Small Bus credit Report SBFE Addition
		EXPORT UNSIGNED1  TOTALTRADELINECOUNT := 50; // Small Bus credit Report SBFE Addition

		EXPORT UNSIGNED2 	DBT_MIN_RANGE						        := 0;
		EXPORT UNSIGNED2 	DBT_MAX_RANGE						        := 105;
		EXPORT STRING3		MIN_SCORE_RANGE					        := '0';
		EXPORT STRING3		MAX_SCORE_RANGE					        := '900';
		EXPORT STRING15		CREDIT_SCORE_MODEL			        := 'SBOM1601_0_0';
		EXPORT STRING15		BLENDED_SCORE_MODEL	   	        := 'SBBM1601_0_0';
		EXPORT STRING15		CREDIT_SCORE_SLBO	  	          := 'SLBO1702_0_2';
		EXPORT STRING15		BLENDED_SCORE_SLBB		          := 'SLBB1702_0_2';
		EXPORT STRING15		BLENDED_SCORE_BBFM		          := 'BBFM1808_1_0';
		EXPORT STRING15		BLENDED_SCORE_BBFM_SBFEATTR		  := 'BBFM1811_1_0';
		EXPORT STRING15		CREDIT_SCORE_BOFM		            := 'BOFM1812_1_0';
    EXPORT STRING15		CREDIT_SCORE_SLBONFEL           := 'SLBO1809_0_0';
    EXPORT STRING15		BLENDED_SCORE_SLBBNFEL	        := 'SLBB1809_0_0';
		EXPORT UNSIGNED1	MAX_ACTIVITIES					        := 4;
		EXPORT UNSIGNED1	MAX_CREDIT_SCORE_REASON	        := 4;
		EXPORT UNSIGNED1	MAX_HISTORICAL_DBT			        := 6;
		EXPORT UNSIGNED1	MAX_HISTORICAL_SCORES		        := 12;
		EXPORT UNSIGNED1	MAX_YEARLY_CREDIT_UTIL	        := 7;
		EXPORT UNSIGNED1	MAX_PAYMENT_HISTORY			        := 84;
		EXPORT UNSIGNED1  MaxSearchResultsPerAcct	        := 5;
		EXPORT UNSIGNED1  MaxResultsPerAcct				        := 25;
		EXPORT UNSIGNED1	SBFESrc									        := 1;
		EXPORT UNSIGNED1	HeaderSrc								        := 2;

		EXPORT SET OF STRING	SET_ALLOWED_ACCOUNT						 := ['002' , '003' , '006']; 
    EXPORT SET OF STRING	SET_CHARGEOFF_STATUS := ['009','011'];

    EXPORT SCORE_TYPE := 
      MODULE
        EXPORT STRING20   BLENDED        := 'BLENDED_SCORE';
        EXPORT STRING20   CREDIT         := 'CREDIT_SCORE';
        EXPORT STRING20   CREDIT_BLENDED := 'CREDIT_BLENDED';
        EXPORT STRING20   NONE           := '';
      END;
    
    EXPORT MODEL_NAME_SETS := 
      MODULE
        EXPORT SET OF STRING	BLENDED     			                := [BLENDED_SCORE_MODEL];
        EXPORT SET OF STRING	BLENDED_SLBB 		                  := [BLENDED_SCORE_SLBB];
        EXPORT SET OF STRING	BLENDED_BBFM 		                  := [BLENDED_SCORE_BBFM];
        EXPORT SET OF STRING	BLENDED_BBFM_SBFEATTR 		        := [BLENDED_SCORE_BBFM_SBFEATTR];
        EXPORT SET OF STRING	CREDIT_BLENDED_BBFM_SBFEATTR 		  := [CREDIT_SCORE_MODEL, BLENDED_SCORE_BBFM_SBFEATTR	];
        EXPORT SET OF STRING	CREDIT_BOFM 		                  := [CREDIT_SCORE_BOFM];
        EXPORT SET OF STRING	BLENDED_SCORE_SLBBNFEL 		        := [BLENDED_SCORE_SLBBNFEL];
        EXPORT SET OF STRING	CREDIT    				                := [CREDIT_SCORE_MODEL];
        EXPORT SET OF STRING	CREDIT_SLBO  		                  := [CREDIT_SCORE_SLBO];
        EXPORT SET OF STRING	CREDIT_SCORE_SLBONFEL 		        := [CREDIT_SCORE_SLBONFEL];
        EXPORT SET OF STRING	CREDIT_BLENDED                    := [CREDIT_SCORE_MODEL , BLENDED_SCORE_MODEL];
        EXPORT SET OF STRING	CREDIT_BLENDED_SLBB_SLBO          := [CREDIT_SCORE_SLBO, BLENDED_SCORE_SLBB];
        EXPORT SET OF STRING	CREDIT_BLENDED_SLBBNFEL_SLBONFEL  := [CREDIT_SCORE_SLBONFEL, BLENDED_SCORE_SLBBNFEL];
        EXPORT SET OF STRING	CREDIT_BLENDED_ALL                := [CREDIT_SCORE_MODEL, BLENDED_SCORE_MODEL, CREDIT_SCORE_SLBO, BLENDED_SCORE_SLBB, BLENDED_SCORE_BBFM,CREDIT_SCORE_BOFM,BLENDED_SCORE_BBFM_SBFEATTR];		
        EXPORT SET OF STRING	BLENDED_ALL                       := [BLENDED_SCORE_MODEL,BLENDED_SCORE_SLBB,BLENDED_SCORE_BBFM, BLENDED_SCORE_SLBBNFEL,BLENDED_SCORE_BBFM_SBFEATTR];		
        EXPORT SET OF STRING	NONE    			 := [''];
				
		  END;
    EXPORT SET OF STRING EXCLUDED_EXPERIAN_SRC  := [MDR.sourceTools.src_EBR, MDR.sourceTools.src_Experian_CRDB];  //experian source removal
     
    EXPORT SET OF STRING Closed_Account_Status_Codes := ['002','003','004','005','008','009','011','016','017','018','022'];	
			
		EXPORT STRING3 NO_HIT_SCORE := '222';
		
		EXPORT UNSIGNED2 BIPID_WEIGHT_THRESHOLD := 44;
		EXPORT STRING20 PrincipalOnly:= 'Principal Only';
		EXPORT  STRING30 PrincipalAndInterest := 'Principal and Interest';
		EXPORT STRING35 AmountEqualToBadDebtReserve  := 'Amount Equal to Bad Debt Reserve';
		EXPORT STRING1 Delimiter := '|';
END;
