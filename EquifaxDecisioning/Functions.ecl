IMPORT $,iesp,STD;

EXPORT Functions := 
MODULE

  EXPORT fn_checkEfxGwError(iesp.equifax_attributes.t_EquifaxAttributesResponse resp) := 
     (UNSIGNED) resp.Report.Error.NumberOfProcessingErrors > 0 OR  
     (UNSIGNED) resp.Report.Error.NumberOfFormatErrors > 0 OR
     (UNSIGNED) resp.Report.Error.NumberOfValidityErrors > 0 OR 
     TRIM(resp.Report.ModelError.ErrorCode, LEFT, RIGHT) != ''; 

  EXPORT fn_checkGwError(iesp.equifax_attributes.t_EquifaxAttributesResponse resp) := 
        resp._Header.Status != 0 OR fn_checkEfxGwError(resp); 

  EXPORT fn_ProcessingCodes(iesp.equifax_ccr_share.t_EqCCRError eqError) :=
       IF((UNSIGNED)eqError.NumberOfProcessingErrors > 0,
        ' Processing['+ eqError.NumberOfProcessingErrors 
        + ', EC1=' + TRIM(eqError.ProcessingErrorCode1,RIGHT) 
         + IF(eqError.ProcessingErrorCode2 != '',', EC2=' + TRIM(eqError.ProcessingErrorCode2,RIGHT),'')  
          + IF(eqError.ProcessingErrorCode3 != '',', EC3=' + TRIM(eqError.ProcessingErrorCode3,RIGHT),'')  
           + IF(eqError.ProcessingErrorCode4 != '',', EC4=' + TRIM(eqError.ProcessingErrorCode4,RIGHT),'')  
            + IF(eqError.ProcessingErrorCode5 != '',', EC5=' + TRIM(eqError.ProcessingErrorCode5,RIGHT),'')  
             + IF(eqError.ProcessingErrorCode6 != '',', EC6=' + TRIM(eqError.ProcessingErrorCode6,RIGHT),'')  
              + IF(eqError.ProcessingErrorCode7 != '',', EC7=' + TRIM(eqError.ProcessingErrorCode7,RIGHT),'')  
               + IF(eqError.ProcessingErrorCode8 != '',', EC8=' + TRIM(eqError.ProcessingErrorCode8,RIGHT),'')
                + IF(eqError.ProcessingErrorCode9 != '',', EC9=' + TRIM(eqError.ProcessingErrorCode9,RIGHT),'')
                 + ']', '');

  EXPORT fn_FormatCodes(iesp.equifax_ccr_share.t_EqCCRError eqError) :=
       IF((UNSIGNED)eqError.NumberOfFormatErrors > 0,
        ' Format['+ eqError.NumberOfFormatErrors 
        + ', EC1=' + TRIM(eqError.FormatErrorCode1,RIGHT) 
         + IF(eqError.FormatErrorCode2 != '',', EC2=' + TRIM(eqError.FormatErrorCode2,RIGHT), '')  
          + IF(eqError.FormatErrorCode3 != '',', EC3=' + TRIM(eqError.FormatErrorCode3,RIGHT), '')  
           + IF(eqError.FormatErrorCode4 != '',', EC4=' + TRIM(eqError.FormatErrorCode4,RIGHT), '')  
            + IF(eqError.FormatErrorCode5 != '',', EC5=' + TRIM(eqError.FormatErrorCode5,RIGHT), '')  
             + IF(eqError.FormatErrorCode6 != '',', EC6=' + TRIM(eqError.FormatErrorCode6,RIGHT), '')  
              + IF(eqError.FormatErrorCode7 != '',', EC7=' + TRIM(eqError.FormatErrorCode7,RIGHT), '')  
               + IF(eqError.FormatErrorCode8 != '',', EC8=' + TRIM(eqError.FormatErrorCode8,RIGHT), '')
                + IF(eqError.FormatErrorCode9 != '',', EC9=' + TRIM(eqError.FormatErrorCode9,RIGHT), '')
                 + ']', '');       

  EXPORT fn_ValidityCodes(iesp.equifax_ccr_share.t_EqCCRError eqError) :=
       IF((UNSIGNED)eqError.NumberOfValidityErrors > 0,
        ' Validity['+ eqError.NumberOfValidityErrors 
        + ', EC1=' + TRIM(eqError.ValidityErrorCode1,RIGHT)
         + IF(eqError.ValidityErrorCode2 != '',', EC2=' + TRIM(eqError.ValidityErrorCode2,RIGHT), '')  
          + IF(eqError.ValidityErrorCode3 != '',', EC3=' + TRIM(eqError.ValidityErrorCode3,RIGHT), '')  
           + IF(eqError.ValidityErrorCode4 != '',', EC4=' + TRIM(eqError.ValidityErrorCode4,RIGHT), '')  
            + IF(eqError.ValidityErrorCode5 != '',', EC5=' + TRIM(eqError.ValidityErrorCode5,RIGHT), '')  
             + IF(eqError.ValidityErrorCode6 != '',', EC6=' + TRIM(eqError.ValidityErrorCode6,RIGHT), '')  
              + IF(eqError.ValidityErrorCode7 != '',', EC7=' + TRIM(eqError.ValidityErrorCode7,RIGHT), '')  
               + IF(eqError.ValidityErrorCode8 != '',', EC8=' + TRIM(eqError.ValidityErrorCode8,RIGHT), '')
                + IF(eqError.ValidityErrorCode9 != '',', EC9=' + TRIM(eqError.ValidityErrorCode9,RIGHT), '')
                 + ']', '');                              

  EXPORT fn_ModelCodes(iesp.equifax_ccr_share.t_EqCCRModelError eqModelError) := 
    IF(eqModelError.ErrorCode != '', ' Model[' + TRIM(eqModelError.ErrorCode,RIGHT) + ': ' + TRIM(eqModelError.ErrorCodeVerbiage,RIGHT) + ']', '');

  // Format the output
  EXPORT fn_formatGatewayUsageOutput (UNSIGNED1 EQUIFAX_GATEWAY_USAGE_in,   
                                      iesp.equifax_attributes.t_EquifaxAttributesResponse resp = 
                                      ROW([],  iesp.equifax_attributes.t_EquifaxAttributesResponse)) :=
  FUNCTION
    $.Layouts.Eq_DecisioningAttr xfm_output() := 
    TRANSFORM
      SELF.EQUIFAX_GATEWAY_USAGE := EQUIFAX_GATEWAY_USAGE_in;
      eqError := resp.Report.Error;
      modelError := resp.Report.ModelError;
      errMsg := 
        IF(fn_checkEfxGwError(resp), $.Constants.GATEWAY_EQFX_ERROR_NO_HIT_NO_CHG, $.Constants.GATEWAY_ERROR_NO_HIT_NO_CHG) 
        + IF(resp._Header.Status != 0, ' [status=' + resp._Header.Status + ']', '')
        + fn_ProcessingCodes(eqError)
        + fn_FormatCodes(eqError)
        + fn_ValidityCodes(eqError)
        + fn_ModelCodes(modelError);
      SELF.Equifax_gateway_usage_Status := IF (fn_checkGwError(resp), STD.Str.CleanSpaces(errMsg), '');
      SELF := [];
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
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.AUTO_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.AUTO_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.AUTO_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.AUTO_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  

  // // Equifax returned attribute value - 3165
  EXPORT fn_processTotalOpenMortgage (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.MORT_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.MORT_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.MORT_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.MORT_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3172
  EXPORT fn_processTotalOpenHomeEquity (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.HOME_EQ_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.HOME_EQ_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.HOME_EQ_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING7 => $.Constants.EQ_CODE_MESSAGE.HOME_EQ_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3796
  EXPORT fn_processUnpaid3rdParty (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3854
  EXPORT fn_processPercentBankcards (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_TOTAL_BAL_ZERO,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.CARD_HIGH_BAL_PERC_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3857
  EXPORT fn_processPercentAuto (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.AUTO_PERC_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.AUTO_PERC_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.AUTO_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.AUTO_PERC_TOTAL_BAL_ZERO,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.AUTO_PERC_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3859
  EXPORT fn_processPercentMortgage (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    DECIMAL10_2 amtDecimal := compareVal/100;  // Limit decimal places to 2
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => (STRING)amtDecimal,  // valid range
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.N0_ACCOUNT_ANY_KIND,
                   compareVal = $.Constants.EQ_CODE_VALS.N0_OPEN_ACT_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.MORT_PERC_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.MORT_PERC_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.NO_BAL_NO_AVAIL_DATE_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.MORT_PERC_NO_BAL_NO_AVAIL_DATE,
                   compareVal = $.Constants.EQ_CODE_VALS.PERCENT_ZERO_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.MORT_PERC_TOTAL_BAL_ZERO,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING5 => $.Constants.EQ_CODE_MESSAGE.MORT_PERC_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
  // Equifax returned attribute value - 3909
  EXPORT fn_processNum3rdParty (STRING10 inVal) :=
  FUNCTION
    compareVal := (INTEGER5)inVal;
    retVal := MAP( inVal = '' => inVal,
                   compareVal >= 0 AND 
                   compareVal < $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => (STRING)compareVal,  // valid range with leading zeros removed
                   compareVal = $.Constants.EQ_CODE_VALS.N0_ACCOUNT_ANY_KIND_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_UNPAID_NO_OPEN_ACCT,
                   compareVal = $.Constants.EQ_CODE_VALS.ACCTS_EXCLUDED_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_ACCTS_EXCLUDED,
                   compareVal = $.Constants.EQ_CODE_VALS.BAL_GREATER_THAN_MAX_FOR_STRING2 => $.Constants.EQ_CODE_MESSAGE.THIRD_PARTY_NUM_BAL_GREATER_THAN_MAX,
                   $.Constants.EQ_CODE_MESSAGE.VALUE_NOT_DEFINED);
    RETURN retVal; 
  END;
  
END;