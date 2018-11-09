IMPORT Business_Credit, SBFE_ARCHIVE_TESTING; 
 
EXPORT Functions := 
  MODULE

    EXPORT getAcctComment (STRING3 accountStatus) :=
      FUNCTION
        TYPES := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_COMMENT_TYPES;
        VALS  := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_COMMENT_VALS;
        
        RETURN CASE(accountStatus, 
                    TYPES.ITEM_IN_DISPUTE => VALS.ITEM_IN_DISPUTE, 	
                    TYPES.ACCT_SOLD_TRANS => VALS.ACCT_SOLD_TRANS, 	
                    TYPES.LOST_STOLEN => VALS.LOST_STOLEN, 	
                    TYPES.VOL_REFINANCE_RENEW => VALS.VOL_REFINANCE_RENEW, 	
                    TYPES.SUSPEND_CLOSED => VALS.SUSPEND_CLOSED, 	
                    TYPES.FORCLOSURE => VALS.FORCLOSURE,  	
                    TYPES.MOD_PENDING => VALS.MOD_PENDING, 	
                    TYPES.DIS_IN_BANK => VALS.DIS_IN_BANK, 	
                    TYPES.PAID_OFF => VALS.PAID_OFF, 	
                    TYPES.NON_ACCRUAL => VALS.NON_ACCRUAL, 	
                    TYPES.CHARGE_OFF_WHOLE_BAL => VALS.CHARGE_OFF_WHOLE_BAL,   	
                    TYPES.HIST_CASH_ON_DEMAND => VALS.HIST_CASH_ON_DEMAND, 
                    TYPES.BLANK => VALS.BLANK, 
                    TYPES.INVOL_HARDSHIP_RESTRUCT => VALS.INVOL_HARDSHIP_RESTRUCT, 
                    TYPES.FIRST_PMT_DEFAULT => VALS.FIRST_PMT_DEFAULT,
                    TYPES.ACCT_PAID_IN_FULL => VALS.ACCT_PAID_IN_FULL, 
                    TYPES.ACCT_IN_COL => VALS.ACCT_IN_COL, 
                    TYPES.VOL_SURRENDER => VALS.VOL_SURRENDER, 
                    TYPES.PMT_DEFERRED => VALS.PMT_DEFERRED, 
                    TYPES.BIZ_AFFECT_NAT_DISASTER => VALS.BIZ_AFFECT_NAT_DISASTER, 
                    TYPES.RPT_SUSP_DUE_TO_NAT_DISASTER => VALS.RPT_SUSP_DUE_TO_NAT_DISASTER, 
                    TYPES.SETTLED_LESS_THAN_AMT_DUE => VALS.SETTLED_LESS_THAN_AMT_DUE, 
                    '');
      END;
          

      EXPORT getAcctTypeReported (STRING3 account_type_reported) :=
        FUNCTION
          TYPES := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_TYPE_REPORTED_CODE;
          VALS  := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_TYPE_REPORTED_VALS;
          
          RETURN CASE(account_type_reported, 
                      TYPES.TERM_LOAN => VALS.TERM_LOAN, 	
                      TYPES.LINE_OF_CREDIT => VALS.LINE_OF_CREDIT, 	
                      TYPES.COMMERCIAL_CREDIT => VALS.COMMERCIAL_CREDIT, 	
                      TYPES.BUSINESS_LEASE => VALS.BUSINESS_LEASE, 	
                      TYPES.LETTER_OF_CREDIT => VALS.LETTER_OF_CREDIT, 	
                      TYPES.OPEN_ENDED_CREDIT_LINE => VALS.OPEN_ENDED_CREDIT_LINE,  	
                      TYPES.OTHER => VALS.OTHER, 	
                      '');
        END;
        
     EXPORT getChargeOffValue	(STRING3 chargeOffType) :=
      FUNCTION
        TYPES := SBFE_ARCHIVE_TESTING.Constants.CHARGE_OFF_TYPES;
        VALS  := SBFE_ARCHIVE_TESTING.Constants.CHARGE_OFF_VALS;
          
        RETURN CASE(chargeOffType,
                    TYPES.PRINCIPAL_ONLY    => VALS.PRINCIPAL_ONLY,
                    TYPES.PRINCIPAL_AND_INT => VALS.PRINCIPAL_AND_INT,
                    TYPES.BAD_DEBT_RESERVE  => VALS.BAD_DEBT_RESERVE,
                    '');
     END;   
   
   EXPORT getAcctClosureReason (STRING2 acctClosureReasons) :=
     FUNCTION
        TYPES := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_CLOSURE_REASONS;
        VALS  := SBFE_ARCHIVE_TESTING.Constants.ACCOUNT_CLOSURE_VALS;
       
       RETURN CASE(acctClosureReasons,
                   TYPES.VOL_BY_ACT_HOLDER    => VALS.VOL_BY_ACT_HOLDER,
                   TYPES.INVOL_BY_CREDITOR    => VALS.INVOL_BY_CREDITOR,
                   TYPES.INVOL_BY_CRED_FRAUD  => VALS.INVOL_BY_CRED_FRAUD,
                   TYPES.INVOL_BIZ_FILED_BANK => VALS.INVOL_BIZ_FILED_BANK,
                   TYPES.INVOL_POOR_PMT_HIST  => VALS.INVOL_POOR_PMT_HIST,
                   TYPES.INVOL_OTHER_BY_CRED  => VALS.INVOL_OTHER_BY_CRED,
                   '');
     END;

    EXPORT getGovGuaranteeCat (STRING3 govGuaranteeVal) :=
      FUNCTION
        TYPES := SBFE_ARCHIVE_TESTING.Constants.GOV_GUARANTEE_CATS;
        VALS  := SBFE_ARCHIVE_TESTING.Constants.GOV_GUARANTEE_VALS;
       
        RETURN CASE(govGuaranteeVal,
                    TYPES.SBA7A        => VALS.SBA7A,
                    TYPES.SBA_LOW_DOC  => VALS.SBA_LOW_DOC,
                    TYPES.SBA_EXP      => VALS.SBA_EXP,
                    TYPES.SBA_COMM_EXP => VALS.SBA_COMM_EXP,
                    TYPES.SBA_COMM_ADJ => VALS.SBA_COMM_ADJ,
                    TYPES.SBA_CERT_DEV => VALS.SBA_CERT_DEV,
                    TYPES.SBA_CAP_LN   => VALS.SBA_CAP_LN,
                    TYPES.US_TRES      => VALS.US_TRES,
                    TYPES.USDA         => VALS.USDA,
                    TYPES.HUD          => VALS.HUD,
                    TYPES.VA_UNKNOWN   => VALS.VA_UNKNOWN,
                    TYPES.US_DOE       => VALS.US_DOE,
                    TYPES.TBA          => VALS.TBA,
                    TYPES.STATE        => VALS.STATE,
                    TYPES.COUNTY       => VALS.COUNTY,
                    TYPES.CITY         => VALS.CITY,
                    '');
      END;

   EXPORT getPaymentFreq (STRING2 paymentFreq) :=
     FUNCTION
        TYPES := SBFE_ARCHIVE_TESTING.Constants.PAYMENT_FREQ;
        VALS  := SBFE_ARCHIVE_TESTING.Constants.PAYMENT_FREQ_VALS;
       
       RETURN CASE(paymentFreq,
                   TYPES.ANNUAL     => VALS.ANNUAL,
                   TYPES.BI_MONTH   => VALS.BI_MONTH,
                   TYPES.BI_WEEK    => VALS.BI_WEEK,
                   TYPES.DAILY      => VALS.DAILY,
                   TYPES.MONTH      => VALS.MONTH,
                   TYPES.QUARTERLY  => VALS.QUARTERLY,
                   TYPES.SEASONAL   => VALS.SEASONAL,
                   TYPES.SEMI_ANN   => VALS.SEMI_ANN,
                   TYPES.SEMI_MON   => VALS.SEMI_MON,
                   TYPES.SINGLE_PMT => VALS.SINGLE_PMT,
                   TYPES.WEEKLY     => VALS.WEEKLY,
                   '');
     END;

      EXPORT getContributorVal (STRING sbfe_Contributor_Number) :=
        FUNCTION
          AmexContribId := SBFE_Archive_Testing.Constants.AMEX_CONTRIBUTOR_ID;
          AmexContribOut := SBFE_Archive_Testing.Constants.AMEX_CONTRIBUTOR_OUTPUT_VAL;
          RETURN  CASE(sbfe_Contributor_Number,
                       AmexContribId.CONTRIB_1 => 
                          AmexContribOut.CONTRIB_1,
                       AmexContribId.CONTRIB_2 => 
                          AmexContribOut.CONTRIB_2,
                       AmexContribId.CONTRIB_3 => 
                          AmexContribOut.CONTRIB_3,
                          AmexContribOut.MASKED_VAL);
        END;

      EXPORT getDate_xMonthsBack (STRING8 inDate, INTEGER1 numMonthsBack) :=
        FUNCTION  
          MONTH := SBFE_Archive_Testing.Constants.MONTHS;
          CON   := SBFE_Archive_Testing.Constants;
          filterDate := 
            MAP( numMonthsBack < MONTH.TWELVE AND (INTEGER)inDate[5..6] > numMonthsBack
                     => (INTEGER)inDate - (numMonthsBack * CON.MONTH_ADJ),
                 numMonthsBack < MONTH.TWELVE AND (INTEGER)inDate[5..6] <= numMonthsBack
                     => (INTEGER)inDate - (CON.MONTH_ADJ2 + ((numMonthsBack - CON.ONE_ADJ) * CON.MONTH_ADJ)),
                 numMonthsBack % MONTH.TWELVE = 0
                     => (INTEGER)inDate - ((numMonthsBack DIV MONTH.TWELVE)* CON.ONE_YEAR_ADJ),
                 (INTEGER)inDate[5..6] > (numMonthsBack % MONTH.TWELVE)
                     => ((INTEGER)inDate - ((numMonthsBack DIV MONTH.TWELVE) * CON.ONE_YEAR_ADJ) )  // adjust for year
                          - ((numMonthsBack % MONTH.TWELVE) * CON.MONTH_ADJ),  // adjust additional months
                     /* default */
                        ((INTEGER)inDate - ((numMonthsBack DIV MONTH.TWELVE) * CON.ONE_YEAR_ADJ) )   // adjust for year
                          - (CON.MONTH_ADJ2 + (((numMonthsBack % MONTH.TWELVE) - CON.ONE_ADJ) * CON.MONTH_ADJ)) // adjust additional months
               );
          RETURN (STRING8)filterDate;
        END;

      EXPORT getPmtHistCode(SBFE_Archive_Testing.Layouts.combinedLayout inRow, STRING8 inDate) :=
        FUNCTION
          histIn := SBFE_Archive_Testing.Constants.HIST_VAL_IN;
          histOut := SBFE_Archive_Testing.Constants.HIST_CODE_OUT;
          RETURN 
            MAP(inRow.Date_Account_Opened > inDate                                                   
                    => histOut.NO_HIST_AVAIL_PREVIOUSLY,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.TWO AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.TWO AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = 0     // handles '0' '00' & '000'                                    
                   => histOut.CUR_ACCT,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.THREE AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.THREE AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = 0
                   => histOut.CUR_ACCT,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.SIX AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.SIX AND
                (INTEGER)inRow.Remaining_Balance > 0 AND
                (INTEGER)inRow.payment_status_category = 0
                    => histOut.CUR_ACCT,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.ONE AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.ONE AND
                (INTEGER)inRow.payment_status_category = 0
                    => histOut.CUR_ACCT,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.FOUR AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.FOUR AND
                (INTEGER)inRow.payment_status_category = 0 
                    => histOut.CUR_ACCT,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.NINTY_NINE AND
                (INTEGER)inRow.payment_status_category = histIn.ONE       
                    => histOut.CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.NINTY_NINE AND
                (INTEGER)inRow.payment_status_category = 0 
                    => histOut.CUR_ACCT,
                
                (INTEGER)inRow.payment_status_category = histIn.TWO       
                    => histOut.ONE_MTH_PAST_DUE,
                (INTEGER)inRow.payment_status_category = histIn.THREE     
                    => histOut.TWO_MTH_PAST_DUE,
                (INTEGER)inRow.payment_status_category = histIn.FOUR      
                    => histOut.THREE_MTH_PAST_DUE,
                (INTEGER)inRow.payment_status_category = histIn.FIVE      
                    => histOut.FOUR_MTH_PAST_DUE,
                (INTEGER)inRow.payment_status_category = histIn.SIX       
                    => histOut.FIVE_MTH_PAST_DUE,
                (INTEGER)inRow.payment_status_category = histIn.SEVEN     
                    => histOut.SIX_MTH_PAST_DUE,
                
                (INTEGER)inRow.Account_Type_Reported = histIn.TWO AND
                (INTEGER)inRow.Remaining_Balance <= 0
                    => histOut.ZERO_BAL_CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.THREE AND
                (INTEGER)inRow.Remaining_Balance <= 0
                    => histOut.ZERO_BAL_CUR_ACCT,
                (INTEGER)inRow.Account_Type_Reported = histIn.SIX AND
                (INTEGER)inRow.Remaining_Balance <= 0
                    => histOut.ZERO_BAL_CUR_ACCT,
                (INTEGER)inRow.Account_Status_1 = histIn.SEVENTEEN        
                    => histOut.COLLECTIONS,
                (INTEGER)inRow.Account_Status_1 = histIn.SIX              
                    => histOut.FORECLOSURE,
                (INTEGER)inRow.Account_Status_1 = histIn.EIGHTEEN         
                    => histOut.VOL_SURRENDER,
                (INTEGER)inRow.Account_Status_1 = histIn.FIFTEEN          
                    => histOut.REPOSSESSION,
                (INTEGER)inRow.Account_Status_1 = histIn.NINE             
                    => histOut.CHG_OFF,
                (INTEGER)inRow.Account_Status_1 = histIn.ELEVEN           
                    => histOut.CHG_OFF,
                       histOut.NO_HIST_THIS_MONTH
               );
      END;

      EXPORT getPaymentHistory (DATASET(SBFE_Archive_Testing.Layouts.combinedLayout) inRows, 
                                INTEGER1 previousMonths,
                                STRING8 referenceDate) := 
        FUNCTION
       
          date1MonthBack   := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.ONE);
          date2MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.TWO);
          date3MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.THREE);
          date4MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.FOUR);
          date5MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.FIVE);
          date6MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.SIX);
          date7MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.SEVEN);
          date8MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.EIGHT);
          date9MonthsBack  := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.NINE);
          date10MonthsBack := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.TEN);
          date11MonthsBack := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.ELEVEN);
          date12MonthsBack := getDate_xMonthsBack(referenceDate, SBFE_Archive_Testing.Constants.MONTHS.TWELVE);
          
          pmtHist := getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date1MonthBack[1..6])[1],  date1MonthBack)   +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date2MonthsBack[1..6])[1], date2MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date3MonthsBack[1..6])[1], date3MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date4MonthsBack[1..6])[1], date4MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date5MonthsBack[1..6])[1], date5MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date6MonthsBack[1..6])[1], date6MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date7MonthsBack[1..6])[1], date7MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date8MonthsBack[1..6])[1], date8MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date9MonthsBack[1..6])[1], date9MonthsBack)  +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date10MonthsBack[1..6])[1],date10MonthsBack) +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date11MonthsBack[1..6])[1],date11MonthsBack) +
                     getPmtHistCode(inRows((STRING8)Cycle_End_Date[1..6] = date12MonthsBack[1..6])[1],date12MonthsBack);
          RETURN pmtHist;
        END;
  END;