EXPORT Layouts := 
  MODULE
  
  EXPORT Eq_DecisioningAttr :=
    RECORD
      UNSIGNED1 EQUIFAX_GATEWAY_USAGE :=  0;  //ENUM(UNSIGNED1, GATEWAY_NOT_REQUESTED, GATEWAY_NOT_CALLED, RESULTS_RETURNED, NO_DID_MATCH, NO_GATEWAY_ATTRIUBTES_RETURNED, GATEWAY_ERROR_RETURNED ); 
      STRING50 BalOpenAutoAcctsWithin3Months :=  ''; 
      STRING50 BalOpenMortgageAcctsWithin3Months :=  '';
      STRING50 BalOpenHomeEquityLineAcctsWithin3Months :=  '';
      STRING50 NumberUnpaidThirdPartyCollections :=  '';
      STRING50 PercentBalToHighCredBankcardsWithin3Months :=  '';
      STRING50 PercentBalToTotalLoanAmtAutoWithin3Months :=  '';
      STRING50 PercentBalToTotalLoanAmtMortgageWithin3Months :=  '';
      STRING50 NumberOfThirdPartyCollections :=  '';
      STRING   BalOpenAutoAcctsWithin3MonthsVal :=  ''; 
      STRING   BalOpenMortgageAcctsWithin3MonthsVal :=  '';
      STRING   BalOpenHomeEquityLineAcctsWithin3MonthsVal :=  '';
      STRING   NumberUnpaidThirdPartyCollectionsVal :=  '';
      STRING   PercentBalToHighCredBankcardsWithin3MonthsVal :=  '';
      STRING   PercentBalToTotalLoanAmtAutoWithin3MonthsVal :=  '';
      STRING   PercentBalToTotalLoanAmtMortgageWithin3MonthsVal :=  '';
      STRING   NumberOfThirdPartyCollectionsVal :=  '';
      INTEGER  EqfxGatewayErrorStatus := 0;
      STRING   EqfxGatewayMessage := '';
      STRING1  EqfxGwNumProcessingErrors := '';
      STRING   EqfxGwProcessingErrorCodes := '';
      STRING1  EqfxGwNumFormatErrors := '';
      STRING   EqfxGwFormatErrorCodes := '';
      STRING1  EqfxGwNumValidityErrors := '';
      STRING   EqfxGwValidityErrorCodes := '';
      STRING6  EqfxGatewayModelErrorCode := '';
      STRING   EqfxGatewayModelMessage := '';
    END;
  
  END;