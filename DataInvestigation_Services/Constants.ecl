EXPORT Constants := 
  MODULE
  
    EXPORT STRING1   BANKRUPTCY_PARTY_TYPE_DEBTOR := 'D';
        
    EXPORT UNSIGNED2 BANKRUPTCY_KEY_JOIN_LIMIT    := 10000;  
    EXPORT UNSIGNED2 LIENS_KEY_JOIN_LIMIT         := 10000;   
    
    EXPORT UNSIGNED2 FETCH_LIMIT                  := 25000;
    EXPORT UNSIGNED2 SCORE_THRESHOLD              := 0;
    
    EXPORT STRING200 ROXIE_INFO := 'INFO-- Data Investigation Raw Data Service - This service returns the raw key records for the Bankruptcy and Liens and Judgments returned in the BusinessCredit_Services.CreditReport.';


  END;