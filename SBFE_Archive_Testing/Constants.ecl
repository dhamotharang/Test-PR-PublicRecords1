IMPORT Data_Services, MDR, RiskWise, SBFE_Archive_Testing;

EXPORT Constants := 
  MODULE

    EXPORT STRING NO := 'N';
    EXPORT STRING YES := 'Y';
    EXPORT STRING GLB := '1';  
    EXPORT STRING DPPA := '3';  
    EXPORT INTEGER ONE_ADJ := 1;
    EXPORT INTEGER MONTH_ADJ := 100;
    EXPORT STRING FETCH_LEVEL := 'S';
    EXPORT STRING INGEST_OLD := 'Old';
    EXPORT INTEGER MONTH_ADJ2 := 8900;
    EXPORT UNSIGNED1 GROUP_SIZE := 150;
    EXPORT STRING SECURED := 'Secured';
    EXPORT STRING UNSECURED := 'Unsecured';
    EXPORT UNSIGNED ONE_YEAR_ADJ := 10000;
    EXPORT UNSIGNED TWO_YEARS_ADJ := 20000;
    EXPORT STRING INCLUDE_BIZ_HDR := 'TRUE';  
    EXPORT UNSIGNED1 NUM_NAME_ADDR_VARS := 9;
    EXPORT STRING DERIVED_COMP_LEGAL := 'LEGAL';
    EXPORT UNSIGNED2 BIPID_WEIGHT_THRESHOLD := 44;
    EXPORT UNSIGNED5 MAX_RESULTS_PER_ACCT := 10000;
    EXPORT UNSIGNED5 MAX_SEARCH_RESULTS_PER_ACCT := 1;
    EXPORT STRING DPM := '1111111111111111111111111111';  
    EXPORT STRING SERVICE_NAME := 'BusinessCredit_Services.CreditBatchService';
    
    
    // Target Roxie:
    // EXPORT STRING roxieIP := RiskWise.Shortcuts.prod_batch_neutral;    // Roxiebatch
    // EXPORT STRING roxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; 
    EXPORT STRING RoxieIP := RiskWise.Shortcuts.staging_neutral_roxieIP; //RiskWise.Shortcuts.Dev192;  

    EXPORT HIST_VAL_IN :=
      MODULE
        EXPORT INTEGER ONE := 1;
        EXPORT INTEGER TWO := 2;
        EXPORT INTEGER THREE := 3;
        EXPORT INTEGER FOUR := 4;
        EXPORT INTEGER FIVE := 5;
        EXPORT INTEGER SIX := 6;
        EXPORT INTEGER SEVEN := 7;
        EXPORT INTEGER NINE := 9;
        EXPORT INTEGER ELEVEN := 11;
        EXPORT INTEGER FIFTEEN := 15;
        EXPORT INTEGER SEVENTEEN := 17;
        EXPORT INTEGER EIGHTEEN := 18;
        EXPORT INTEGER NINTY_NINE := 99;
      END;
      
    EXPORT HIST_CODE_OUT :=
      MODULE
        EXPORT STRING1 CUR_ACCT := '0';
        EXPORT STRING1 ONE_MTH_PAST_DUE := '1';
        EXPORT STRING1 TWO_MTH_PAST_DUE := '2';
        EXPORT STRING1 THREE_MTH_PAST_DUE := '3';
        EXPORT STRING1 FOUR_MTH_PAST_DUE := '4';
        EXPORT STRING1 FIVE_MTH_PAST_DUE := '5';
        EXPORT STRING1 SIX_MTH_PAST_DUE := '6';
        EXPORT STRING1 NO_HIST_AVAIL_PREVIOUSLY := 'B';
        EXPORT STRING1 NO_HIST_THIS_MONTH := 'D';
        EXPORT STRING1 ZERO_BAL_CUR_ACCT := 'E';
        EXPORT STRING1 COLLECTIONS := 'G';
        EXPORT STRING1 FORECLOSURE := 'H';
        EXPORT STRING1 VOL_SURRENDER := 'J';
        EXPORT STRING1 REPOSSESSION := 'K';
        EXPORT STRING1 CHG_OFF := 'L';
      END;
      
    EXPORT SET_EXCLUDED_SOURCES := [ MDR.sourceTools.src_Dunn_Bradstreet,  // aka D&B DMI
	                                    MDR.sourceTools.src_Dunn_Bradstreet_Fein,
                                     MDR.sourceTools.src_EBR,
                                     MDR.sourceTools.src_Experian_CRDB ];
	

    EXPORT AMEX_CONTRIBUTOR_ID := 
      MODULE
        EXPORT STRING CONTRIB_1 := '0001010111ACC0314';	
        EXPORT STRING CONTRIB_2 := '0001010111AEP0101';	
        EXPORT STRING CONTRIB_3 := '0001010111MF10116';	
      END;
    
    EXPORT AMEX_CONTRIBUTOR_OUTPUT_VAL := 
      MODULE 
        EXPORT STRING CONTRIB_1 := '1';	
        EXPORT STRING CONTRIB_2 := '2';	
        EXPORT STRING CONTRIB_3 := '3';	
        EXPORT STRING MASKED_VAL := '0';
      END;
    
    EXPORT MONTHS :=
      MODULE
        EXPORT INTEGER1 ONE := 1;
        EXPORT INTEGER1 TWO := 2;
        EXPORT INTEGER1 THREE := 3;
        EXPORT INTEGER1 FOUR := 4;
        EXPORT INTEGER1 FIVE := 5;
        EXPORT INTEGER1 SIX := 6;
        EXPORT INTEGER1 SEVEN := 7;
        EXPORT INTEGER1 EIGHT := 8;
        EXPORT INTEGER1 NINE := 9;
        EXPORT INTEGER1 TEN := 10;
        EXPORT INTEGER1 ELEVEN := 11;
        EXPORT INTEGER1 TWELVE := 12;
        EXPORT INTEGER1 THIRTEEN := 13;
        EXPORT INTEGER1 TWENTY_FOUR := 24;
      END;  

// AccountComments1 / AccountComments2	
     EXPORT ACCOUNT_COMMENT_TYPES := 
       MODULE
         EXPORT STRING3 ITEM_IN_DISPUTE              := '001'; 	
         EXPORT STRING3 ACCT_SOLD_TRANS              := '002'; 	
         EXPORT STRING3 LOST_STOLEN                  := '003'; 	
         EXPORT STRING3 VOL_REFINANCE_RENEW          := '004'; 	
         EXPORT STRING3 SUSPEND_CLOSED               := '005'; 	
         EXPORT STRING3 FORCLOSURE                   := '006';  	
         EXPORT STRING3 MOD_PENDING                  := '007'; 	
         EXPORT STRING3 DIS_IN_BANK                  := '008'; 	
         EXPORT STRING3 PAID_OFF                     := '009'; 	
         EXPORT STRING3 NON_ACCRUAL                  := '010'; 	
         EXPORT STRING3 CHARGE_OFF_WHOLE_BAL         := '011';   	
         EXPORT STRING3 HIST_CASH_ON_DEMAND          := '012'; 
         EXPORT STRING3 BLANK                        := '013'; 
         EXPORT STRING3 INVOL_HARDSHIP_RESTRUCT      := '014'; 
         EXPORT STRING3 FIRST_PMT_DEFAULT            := '015';
         EXPORT STRING3 ACCT_PAID_IN_FULL            := '016'; 
         EXPORT STRING3 ACCT_IN_COL                  := '017'; 
         EXPORT STRING3 VOL_SURRENDER                := '018'; 
         EXPORT STRING3 PMT_DEFERRED                 := '019'; 
         EXPORT STRING3 BIZ_AFFECT_NAT_DISASTER      := '020'; 
         EXPORT STRING3 RPT_SUSP_DUE_TO_NAT_DISASTER := '021'; 
         EXPORT STRING3 SETTLED_LESS_THAN_AMT_DUE    := '022'; 
		    END;

     EXPORT ACCOUNT_COMMENT_VALS := 
       MODULE
         EXPORT STRING ITEM_IN_DISPUTE              := 'Item in dispute';	
         EXPORT STRING ACCT_SOLD_TRANS              := 'Account Sold/ Transferred';	
         EXPORT STRING LOST_STOLEN                  := 'Lost or Stolen Card';	
         EXPORT STRING VOL_REFINANCE_RENEW          := 'Voluntary Refinance or Renewal';	
         EXPORT STRING SUSPEND_CLOSED               := 'Suspended or Closed Account';	
         EXPORT STRING FORCLOSURE                   := 'Foreclosure';	
         EXPORT STRING MOD_PENDING                  := 'Modification Pending';	
         EXPORT STRING DIS_IN_BANK                  := 'Discharged in Bankruptcy';	
         EXPORT STRING PAID_OFF                     := 'Paid Charge Off';	
         EXPORT STRING NON_ACCRUAL                  := 'Non-accrual';	
         EXPORT STRING CHARGE_OFF_WHOLE_BAL         := 'Charge Off Whole Balance';  	
         EXPORT STRING HIST_CASH_ON_DEMAND          := 'Cash on Demand';
         EXPORT STRING BLANK                        := 'Blank';
         EXPORT STRING INVOL_HARDSHIP_RESTRUCT      := 'Involuntary Hardship Restructure';
         EXPORT STRING FIRST_PMT_DEFAULT            := 'First Payment Default';
         EXPORT STRING ACCT_PAID_IN_FULL            := 'Account Paid in Full - for Portion of Balance';
         EXPORT STRING ACCT_IN_COL                  := 'Account in Collection';
         EXPORT STRING VOL_SURRENDER                := 'Voluntary Surrender';
         EXPORT STRING PMT_DEFERRED                 := 'Payment Deferred';
         EXPORT STRING BIZ_AFFECT_NAT_DISASTER      := 'Business Affected by Natural/ Declared Disaster';
         EXPORT STRING RPT_SUSP_DUE_TO_NAT_DISASTER := 'Reporting Suspended Due to Natural/ Declared Disaster';
         EXPORT STRING SETTLED_LESS_THAN_AMT_DUE    := 'Settled for Less than Amount Due';
		    END;

    EXPORT ACCOUNT_TYPE_REPORTED_CODE :=
      MODULE 
         EXPORT STRING3 TERM_LOAN              := '001';	 
         EXPORT STRING3 LINE_OF_CREDIT         := '002';	 
         EXPORT STRING3 COMMERCIAL_CREDIT      := '003';	 
         EXPORT STRING3 BUSINESS_LEASE         := '004';	
         EXPORT STRING3 LETTER_OF_CREDIT       := '005';
         EXPORT STRING3 OPEN_ENDED_CREDIT_LINE := '006';
         EXPORT STRING3 OTHER                  := '099';
      END; 

    EXPORT ACCOUNT_TYPE_REPORTED_VALS :=
      MODULE 
         EXPORT STRING TERM_LOAN              := 'Term Loan';	 
         EXPORT STRING LINE_OF_CREDIT         := 'Line of Credit';	 
         EXPORT STRING COMMERCIAL_CREDIT      := 'Commercial Card';	 
         EXPORT STRING BUSINESS_LEASE         := 'Business Lease';	
         EXPORT STRING LETTER_OF_CREDIT       := 'Letter of Credit';
         EXPORT STRING OPEN_ENDED_CREDIT_LINE := 'Open Ended Credit Line';
         EXPORT STRING OTHER                  := 'Other';
      END; 

    EXPORT CHARGE_OFF_TYPES	:=
      MODULE
        EXPORT STRING3 PRINCIPAL_ONLY    := '001';	
        EXPORT STRING3 PRINCIPAL_AND_INT := '002'; 	
        EXPORT STRING3 BAD_DEBT_RESERVE  := '003'; 	
     END;
     
    EXPORT CHARGE_OFF_VALS :=
      MODULE
        EXPORT STRING PRINCIPAL_ONLY    := 'Principal Only';	
        EXPORT STRING PRINCIPAL_AND_INT := 'Principal and Interest';	
        EXPORT STRING BAD_DEBT_RESERVE  := 'Amount Equal to Bad Debt Reserve';	
     END;
     
    EXPORT ACCOUNT_CLOSURE_REASONS := 
      MODULE
        EXPORT STRING2 VOL_BY_ACT_HOLDER    := 'V'; 	
        EXPORT STRING2 INVOL_BY_CREDITOR    := 'X'; 	
        EXPORT STRING2 INVOL_bY_CRED_FRAUD  := 'F'; 	
        EXPORT STRING2 INVOL_BIZ_FILED_BANK := 'B'; 	
        EXPORT STRING2 INVOL_POOR_PMT_HIST  := 'P'; 
        EXPORT STRING2 INVOL_OTHER_BY_CRED  := 'O'; 
      END;

    EXPORT ACCOUNT_CLOSURE_VALS := 
      MODULE
        EXPORT STRING VOL_BY_ACT_HOLDER    := 'Voluntarily Closed By Account Holder';	
        EXPORT STRING INVOL_BY_CREDITOR    := 'Involuntarily Closed By Creditor';	
        EXPORT STRING INVOL_bY_CRED_FRAUD  := 'Involuntarily Closed By Creditor Due to Fraud';	
        EXPORT STRING INVOL_BIZ_FILED_BANK := 'Involuntarily Closed - Business Filed for Bankruptcy';	
        EXPORT STRING INVOL_POOR_PMT_HIST  := 'Involuntarily Closed Due to Poor Payment History';
        EXPORT STRING INVOL_OTHER_BY_CRED  := 'Other Involuntary Closure By Creditor';
      END;
		
    EXPORT GOV_GUARANTEE_CATS :=
      MODULE
        EXPORT STRING3 SBA7A        := '001'; 
        EXPORT STRING3 SBA_LOW_DOC  := '002'; 
        EXPORT STRING3 SBA_EXP      := '003'; 
        EXPORT STRING3 SBA_COMM_EXP := '004'; 	
        EXPORT STRING3 SBA_COMM_ADJ := '005'; 
        EXPORT STRING3 SBA_CERT_DEV := '006'; 
        EXPORT STRING3 SBA_CAP_LN   := '007'; 
        EXPORT STRING3 US_TRES      := '100'; 
        EXPORT STRING3 USDA         := '200'; 
        EXPORT STRING3	HUD          := '300';  
        EXPORT STRING3 VA_UNKNOWN   := '400'; 
        EXPORT STRING3 US_DOE       := '500'; 
        EXPORT STRING3 TBA          := '600'; 
        EXPORT STRING3 STATE        := '700'; 
        EXPORT STRING3 COUNTY       := '800'; 
        EXPORT STRING3 CITY         := '810'; 
      END;
      
    EXPORT GOV_GUARANTEE_VALS :=
      MODULE
        EXPORT STRING SBA7A        := 'SBA7A';
        EXPORT STRING SBA_LOW_DOC  := 'SBA Low Doc';
        EXPORT STRING SBA_EXP      := 'SBA Express';
        EXPORT STRING SBA_COMM_EXP := 'SBA Community Express';	
        EXPORT STRING SBA_COMM_ADJ := 'SBA Community Adj and Invest Program (CAIP)';
        EXPORT STRING SBA_CERT_DEV := 'SBA Certified Development Co (CDC 504)';
        EXPORT STRING SBA_CAP_LN   := 'SBA CAP Lines';
        EXPORT STRING US_TRES      := 'US Treasury - Program Type Unknown';
        EXPORT STRING USDA         := 'USDA - Program Type Unknown';
        EXPORT STRING	HUD          := 'HUD - Program Type Unknown'; 
        EXPORT STRING VA_UNKNOWN   := 'VA - Program Type Unknown';
        EXPORT STRING US_DOE       := 'US DOE - Program Type Unknown';
        EXPORT STRING TBA          := 'To be determined';
        EXPORT STRING STATE        := 'State - State/Program Type Unknown';
        EXPORT STRING COUNTY       := 'County - County/Program Type Unknown';
        EXPORT STRING CITY         := 'City - City/Program Type Unknown';
      END;  
 
    EXPORT PAYMENT_FREQ :=
      MODULE
        EXPORT STRING2 ANNUAL     := 'A'; 
	       EXPORT STRING2 BI_MONTH   := 'BM';	
	       EXPORT STRING2 BI_WEEK    := 'BW';	
	       EXPORT STRING2 DAILY      := 'D';	
	       EXPORT STRING2 MONTH      := 'M';	 
	       EXPORT STRING2 QUARTERLY  := 'Q'; 
	       EXPORT STRING2 SEASONAL   := 'S'; 
        EXPORT STRING2 SEMI_ANN   := 'SA';  
        EXPORT STRING2 SEMI_MON   := 'SM'; 
        EXPORT STRING2 SINGLE_PMT := 'SP'; 
        EXPORT STRING2 WEEKLY     := 'W';
      END;

    EXPORT PAYMENT_FREQ_VALS :=
      MODULE
        EXPORT STRING ANNUAL     := 'Annually';	
	       EXPORT STRING BI_MONTH   := 'Bi-Monthly';	
	       EXPORT STRING BI_WEEK    := 'Bi-Weekly';	
	       EXPORT STRING DAILY      := 'Daily';	
	       EXPORT STRING MONTH      := 'Monthly';	 
	       EXPORT STRING QUARTERLY  := 'Quarterly';
	       EXPORT STRING SEASONAL   := 'Seasonal';
        EXPORT STRING SEMI_ANN   := 'Semiannually'; 
        EXPORT STRING SEMI_MON   := 'Semi-Monthly'; 
        EXPORT STRING SINGLE_PMT := 'Single Payment'; 
        EXPORT STRING WEEKLY     := 'Weekly';
      END;
 
  END;