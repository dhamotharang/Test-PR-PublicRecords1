EXPORT Constants := 
  MODULE

    EXPORT EQUIFAX_GATEWAY_USAGE := ENUM(UNSIGNED1, GATEWAY_NOT_REQUESTED, GATEWAY_NOT_CALLED, RESULTS_RETURNED, NO_DID_MATCH, NO_GATEWAY_ATTRIBUTES_RETURNED, GATEWAY_ERROR_RETURNED ); 
    
    EXPORT STRING GATEWAY_END_USER_COMPANY_NAME := 'LexisNexis';
    EXPORT STRING GATEWAY_END_USER_PERMISABLE_PURPOSE := '04';
    EXPORT STRING GATEWAY_MODEL_NUMBER := '05391';
    EXPORT STRING GATEWAY_XPATH := 'EquifaxAttributesResponseEx';
    EXPORT STRING GATEWAY_ERROR_NO_HIT_NO_CHG := 'NO HIT/NO CHARGE- Service to Equifax is currently disconnected.  If you continue to receive this message after 24 hours have elapsed, please contact LN Customer Service or your Sales Rep. with the following:';
    EXPORT STRING GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG := 'NO HIT/NO CHARGE- Service to Equifax is currently generating an error. If you receive an error repeatedly, please contact LN Customer Service or your Sales Rep. with the following:';

    EXPORT  ATTRIBUTE_TYPES :=
      MODULE
        EXPORT STRING4 BAL_OPEN_AUTO_3MONTHS := '3160';
        EXPORT STRING4 BAL_OPEN_MORT_3MONTHS := '3165';
        EXPORT STRING4 BAL_OPEN_HOME_EQ_3MONTHS := '3172';
        EXPORT STRING4 NUM_UNPAID_3RD_PARTY_COL := '3796';
        EXPORT STRING4 PERCENT_BAL_TO_HIGH_CRED_BANKCARD_3MONTHS := '3854';
        EXPORT STRING4 PERCENT_BAL_TO_TOTAL_AUTO_LOAN_3MONTHS := '3857';
        EXPORT STRING4 PERCENT_BAL_TO_TOTAL_MORT_LOAN_3MONTHS := '3859';
        EXPORT STRING4 NUM_3RD_PARTY_COLLECTIONS := '3909';
     END;  
    
    EXPORT  EQ_CODE_VALS :=
      MODULE
        EXPORT UNSIGNED N0_ACCOUNT_ANY_KIND_FOR_STRING7 := 9999999;  
        EXPORT UNSIGNED N0_ACCOUNT_ANY_KIND_FOR_STRING5 := 99999; 
        EXPORT UNSIGNED N0_ACCOUNT_ANY_KIND_FOR_STRING2 := 99;
        EXPORT UNSIGNED N0_OPEN_ACT_FOR_STRING7 := 9999998;  
        EXPORT UNSIGNED N0_OPEN_ACT_FOR_STRING5 := 99998;    
        EXPORT UNSIGNED ACCTS_EXCLUDED_FOR_STRING7 := 9999997;
        EXPORT UNSIGNED ACCTS_EXCLUDED_FOR_STRING5 := 99997;
        EXPORT UNSIGNED ACCTS_EXCLUDED_FOR_STRING2 := 97;
        EXPORT UNSIGNED NO_BAL_NO_AVAIL_DATE_FOR_STRING7 := 9999996;  
        EXPORT UNSIGNED NO_BAL_NO_AVAIL_DATE_FOR_STRING5 := 99996;    
        EXPORT UNSIGNED PERCENT_ZERO_FOR_STRING5 := 99994;
        EXPORT UNSIGNED BAL_GREATER_THAN_MAX_FOR_STRING7 := 9999992; 
        EXPORT UNSIGNED BAL_GREATER_THAN_MAX_FOR_STRING5 := 99992;
        EXPORT UNSIGNED BAL_GREATER_THAN_MAX_FOR_STRING2 := 92;
      END;
      
    EXPORT  EQ_CODE_MESSAGE :=
      MODULE
        EXPORT STRING N0_ACCOUNT_ANY_KIND := 'No account of any kind on file';
        
        // 3160 - Balance Open Auto Finance Trades with Update within 3 months
        EXPORT STRING AUTO_NO_OPEN_ACCT := 'No open auto account on file';
        EXPORT STRING AUTO_ACCTS_EXCLUDED := 'All open auto accounts on file that can be considered fall into an exclusion category';
        EXPORT STRING AUTO_NO_BAL_NO_AVAIL_DATE := 'All open auto accounts on file that can be considered either (1) have an available date within 3 months but no available balance, or (2) have no available date within 3 months';
        EXPORT STRING AUTO_BAL_GREATER_THAN_MAX  := 'Total balance for open auto accounts on file with update within 3 months equals $9999992 or more';
        
        // 3165 - Balance Open Mortgage Trades with Update within 3 months
        EXPORT STRING MORT_NO_OPEN_ACCT := 'No open mortgage account on file';
        EXPORT STRING MORT_ACCTS_EXCLUDED := 'All open mortgage accounts on file that can be considered fall into an exclusion category';
        EXPORT STRING MORT_NO_BAL_NO_AVAIL_DATE := 'All open mortgage accounts on file that can be considered either (1) have an available date within 3 months but no available balance, or (2) have no available date within 3 months';
        EXPORT STRING MORT_BAL_GREATER_THAN_MAX  := 'Total balance for open mortgage accounts on file with update within 3 months equals $9999992 or more';
        
        // 3172 - Total Balance Open Home Equity Line Accounts with Updates within 3 months
        EXPORT STRING HOME_EQ_NO_OPEN_ACCT := 'No open home equity line account on file';
        EXPORT STRING HOME_EQ_ACCTS_EXCLUDED := 'All open home equity line accounts on file that can be considered fall into an exclusion category';
        EXPORT STRING HOME_EQ_NO_BAL_NO_AVAIL_DATE := 'All open home equity line accounts on file that can be considered either (1) have an available date within 3 months but no available balance, or (2) have no available date within 3 months';
        EXPORT STRING HOME_EQ_BAL_GREATER_THAN_MAX  := 'Total balance for open home equity line accounts on file with update within 3 months equals $9999992 or more';
        
        // 3796 - Number Unpaid 3rd Party Collections
        EXPORT STRING THIRD_PARTY_NUM_UNPAID_NO_OPEN_ACCT := 'No account of any kind on file and no public record/collection item on file';
        EXPORT STRING THIRD_PARTY_NUM_UNPAID_ACCTS_EXCLUDED := 'All unpaid 3rd party collections accounts and 3rd party collections public record/collection items on file that can be considered fall into an exclusion category';
        EXPORT STRING THIRD_PARTY_NUM_UNPAID_BAL_GREATER_THAN_MAX  := 'Number unpaid 3rd party collections on file equals 92 or more';
        
        // 3854 - Percent Balance High Credit Open Bankcard Trads with Update within 3 months
        EXPORT STRING CARD_HIGH_BAL_PERC_NO_OPEN_ACCT := 'No open bankcard account on file';
        EXPORT STRING CARD_HIGH_BAL_PERC_ACCTS_EXCLUDED := 'All open bankcard accounts being excluded';
        EXPORT STRING CARD_HIGH_BAL_PERC_NO_BAL_NO_AVAIL_DATE := 'No valid high credit within 3 months or no valid date within 3 months open bankcard account';
        EXPORT STRING CARD_HIGH_BAL_PERC_TOTAL_BAL_ZERO := 'Valid total balance open bankcard accounts with update within 3 months and total high credit open bankcard accounts with update within 3 months=0';
        EXPORT STRING CARD_HIGH_BAL_PERC_GREATER_THAN_MAX  := 'Percent balance to high credit open bankcard accounts with update within 3 months >= 999.92%';
        
        // 3857 - Percent Balance to Total Loan Amount Open Auto Finance Trades with Update within 3 months
        EXPORT STRING AUTO_PERC_NO_OPEN_ACCT := 'No open auto account on file';
        EXPORT STRING AUTO_PERC_ACCTS_EXCLUDED := 'All open auto accounts being excluded';
        EXPORT STRING AUTO_PERC_NO_BAL_NO_AVAIL_DATE := 'No valid high credit within 3 months or no valid date within 3 months open auto account on file';
        EXPORT STRING AUTO_PERC_TOTAL_BAL_ZERO := 'Valid total balance open auto accounts with update within 3 months and total high credit open auto accounts with update within 3 months=0';
        EXPORT STRING AUTO_PERC_BAL_GREATER_THAN_MAX  := 'Percent balance to loan amount open auto accounts with update within 3 months >= 999.92%';
        
        // 3859 - Percent Balance to Total Loan Amount Open Mortgage Trades with Update within 3 months 
        EXPORT STRING MORT_PERC_NO_OPEN_ACCT := 'No open mortgage account on file';
        EXPORT STRING MORT_PERC_ACCTS_EXCLUDED := 'All open mortgage accounts being excluded'; //'All open mortgages fall into an exclusion category';
        EXPORT STRING MORT_PERC_NO_BAL_NO_AVAIL_DATE := 'No valid high credit within 3 months or no valid date within 3 months open mortgage account on file';
        EXPORT STRING MORT_PERC_TOTAL_BAL_ZERO := 'Valid total balance open mortgage accounts with update within 3 months and total high credit open mortgage accounts with update within 3 months=0';
        EXPORT STRING MORT_PERC_BAL_GREATER_THAN_MAX  := 'Percent balance to loan amount open mortgage accounts with update within 3 months >= 999.92%';
        
        // 3909 - Number 3rd Party Collections
        EXPORT STRING THIRD_PARTY_NUM_ACCTS_EXCLUDED := 'All 3rd party collections accounts and 3rd party collections Public Record/Collection Items on file that can be considered fall into an exclusion category';
        EXPORT STRING THIRD_PARTY_NUM_BAL_GREATER_THAN_MAX  := 'Number 3rd party collections on file equals 92 or more';
        
        EXPORT STRING VALUE_NOT_DEFINED := 'A code has been returned that was not defined by Equifax.  Please contact LN Customer Support so the Product Team can be engaged.';
     END; 
    
  END;