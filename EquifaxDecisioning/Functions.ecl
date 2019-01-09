IMPORT iesp;

EXPORT Functions := 
MODULE
  
  EXPORT fn_appendCode (STRING3 CodeIn, BOOLEAN isFirstCode) := 
  FUNCTION
    RETURN MAP(isFirstCode AND CodeIn != '' => TRIM(CodeIn,LEFT,RIGHT),
               CodeIn != '' => '; ' + TRIM(CodeIn,LEFT,RIGHT),
               '');
  END;
              
  
  // Format the output
  EXPORT fn_formatGatewayUsageOutput (UNSIGNED1 EQUIFAX_GATEWAY_USAGE_in,       
                                      INTEGER  EqfxGatewayErrorStatus_in = 0,
                                      iesp.equifax_ccr_share.t_EqCCRError ErrorIn = ROW([],iesp.equifax_ccr_share.t_EqCCRError),
	                                    iesp.equifax_ccr_share.t_EqCCRModelError ModelErrorIn = ROW([],iesp.equifax_ccr_share.t_EqCCRModelError)) :=
  FUNCTION
    EquifaxDecisioning.Layouts.Eq_DecisioningAttr xfm_output() := 
    TRANSFORM
      SELF.EQUIFAX_GATEWAY_USAGE := EQUIFAX_GATEWAY_USAGE_in;
      SELF.BalOpenAutoAcctsWithin3Months :=  ''; 
      SELF.BalOpenMortgageAcctsWithin3Months :=  '';
      SELF.BalOpenHomeEquityLineAcctsWithin3Months :=  '';
      SELF.NumberUnpaidThirdPartyCollections :=  '';
      SELF.PercentBalToHighCredBankcardsWithin3Months :=  '';
      SELF.PercentBalToTotalLoanAmtAutoWithin3Months :=  '';
      SELF.PercentBalToTotalLoanAmtMortgageWithin3Months :=  '';
      SELF.NumberOfThirdPartyCollections :=  '';
      SELF.BalOpenAutoAcctsWithin3MonthsVal :=  ''; 
      SELF.BalOpenMortgageAcctsWithin3MonthsVal :=  '';
      SELF.BalOpenHomeEquityLineAcctsWithin3MonthsVal :=  '';
      SELF.NumberUnpaidThirdPartyCollectionsVal :=  '';
      SELF.PercentBalToHighCredBankcardsWithin3MonthsVal :=  '';
      SELF.PercentBalToTotalLoanAmtAutoWithin3MonthsVal :=  '';
      SELF.PercentBalToTotalLoanAmtMortgageWithin3MonthsVal :=  '';
      SELF.NumberOfThirdPartyCollectionsVal :=  '';
      SELF.EqfxGatewayErrorStatus := EqfxGatewayErrorStatus_in;
      SELF.EqfxGatewayMessage := IF(EqfxGatewayErrorStatus_in != 0,
                                    EquifaxDecisioning.Constants.GATEWAY_ERROR_NO_HIT_NO_CHG + ': ' + (STRING)EqfxGatewayErrorStatus_in,
                                    '');
      SELF.EqfxGwNumProcessingErrors := IF((UNSIGNED1)ErrorIn.NumberOfProcessingErrors != 0,
                                           ErrorIn.NumberOfProcessingErrors,
                                           '');
      SELF.EqfxGwProcessingErrorCodes := IF((UNSIGNED1)ErrorIn.NumberOfProcessingErrors != 0,
                                             EquifaxDecisioning.Constants.GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG + 'Processing error code(s): ' + fn_appendCode(ErrorIn.ProcessingErrorCode1,TRUE) + fn_appendCode(ErrorIn.ProcessingErrorCode2,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode3,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode4,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode5,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode6,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode7,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode8,FALSE) + fn_appendCode(ErrorIn.ProcessingErrorCode9,FALSE),
                                             '');                                              
      SELF.EqfxGwNumFormatErrors := IF((UNSIGNED1)ErrorIn.NumberOfFormatErrors != 0,
                                        ErrorIn.NumberOfFormatErrors,
                                        '');
      SELF.EqfxGwFormatErrorCodes := IF((UNSIGNED1)ErrorIn.NumberOfFormatErrors != 0,
                                         EquifaxDecisioning.Constants.GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG + 'Format error code(s): ' + fn_appendCode(ErrorIn.FormatErrorCode1,TRUE) + fn_appendCode(ErrorIn.FormatErrorCode2,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode3,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode4,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode5,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode6,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode7,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode8,FALSE) + fn_appendCode(ErrorIn.FormatErrorCode9,FALSE),
                                         ''); 
      SELF.EqfxGwNumValidityErrors := IF((UNSIGNED1)ErrorIn.NumberOfValidityErrors != 0,
                                        ErrorIn.NumberOfValidityErrors,
                                        '');
      SELF.EqfxGwValidityErrorCodes := IF((UNSIGNED1)ErrorIn.NumberOfFormatErrors != 0,
                                         EquifaxDecisioning.Constants.GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG + 'Validity error code(s): ' + fn_appendCode(ErrorIn.ValidityErrorCode1,TRUE) + fn_appendCode(ErrorIn.ValidityErrorCode2,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode3,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode4,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode5,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode6,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode7,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode8,FALSE) + fn_appendCode(ErrorIn.ValidityErrorCode9,FALSE),
                                         '');
      SELF.EqfxGatewayModelErrorCode := IF(ModelErrorIn.ErrorCode != '',
                                        ModelErrorIn.ErrorCode,
                                        '');
      SELF.EqfxGatewayModelMessage :=  IF(ModelErrorIn.ErrorCode != '',
                                       EquifaxDecisioning.Constants.GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG + 'Model error code ' + TRIM(ModelErrorIn.ErrorCode,LEFT,RIGHT) + ': ' + ModelErrorIn.ErrorCodeVerbiage,
                                       '');
    END;   
    RETURN DATASET([xfm_output()]); 
  END;

  EXPORT getAttributeValue(iesp.equifax_attributes.t_EquifaxAttributes gw_attributes, STRING4 CodeValueToReturn) := 
  CASE( CodeValueToReturn,
        gw_attributes.Field1[1..4] => gw_attributes.Field1[6..],
        gw_attributes.Field2[1..4] => gw_attributes.Field2[6..],
        gw_attributes.Field3[1..4] => gw_attributes.Field3[6..],
        gw_attributes.Field4[1..4] => gw_attributes.Field4[6..],
        gw_attributes.Field5[1..4] => gw_attributes.Field5[6..],
        gw_attributes.Field6[1..4] => gw_attributes.Field6[6..],
        gw_attributes.Field7[1..4] => gw_attributes.Field7[6..],
        gw_attributes.Field8[1..4] => gw_attributes.Field8[6..],
        gw_attributes.Field9[1..4] => gw_attributes.Field9[6..],
        gw_attributes.Field10[1..4] => gw_attributes.Field10[6..],
        gw_attributes.Field11[1..4] => gw_attributes.Field11[6..],
        gw_attributes.Field12[1..4] => gw_attributes.Field12[6..],
        gw_attributes.Field13[1..4] => gw_attributes.Field13[6..],
        gw_attributes.Field14[1..4] => gw_attributes.Field14[6..],
        gw_attributes.Field15[1..4] => gw_attributes.Field15[6..],
        gw_attributes.Field16[1..4] => gw_attributes.Field16[6..],
        gw_attributes.Field17[1..4] => gw_attributes.Field17[6..],
        gw_attributes.Field18[1..4] => gw_attributes.Field18[6..],
        gw_attributes.Field19[1..4] => gw_attributes.Field19[6..],
        gw_attributes.Field20[1..4] => gw_attributes.Field20[6..],
                                       '');


  // // Equifax returned attribute value - 3160
  EXPORT fn_processTotalOpenAuto (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  

  // // Equifax returned attribute value - 3165
  EXPORT fn_processTotalOpenMortgage (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3172
  EXPORT fn_processTotalOpenHomeEquity (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.HOME_EQ_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.HOME_EQ_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.HOME_EQ_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.HOME_EQ_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3796
  EXPORT fn_processUnpaid3rdParty (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3854
  EXPORT fn_processPercentBankcards (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_TOTAL_BAL_ZERO,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3857
  EXPORT fn_processPercentAuto (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_PERC_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_PERC_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_PERC_TOTAL_BAL_ZERO,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.AUTO_PERC_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3859
  EXPORT fn_processPercentMortgage (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_PERC_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_PERC_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_PERC_TOTAL_BAL_ZERO,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.MORT_PERC_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3909
  EXPORT fn_processNum3rdParty (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_NO_OPEN_ACCT,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_ACCTS_EXCLUDED,
                   compareVal = EquifaxDecisioning.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_BAL_GREATER_THAN_MAX,
                   EquifaxDecisioning.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
END;

