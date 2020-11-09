IMPORT BatchShare, FraudShared, UT;

EXPORT IParam := MODULE

 EXPORT Params := INTERFACE (BatchShare.IParam.BatchParams)
  EXPORT boolean IsOnline := false;
  EXPORT UNSIGNED3 DIDScoreThreshold;
  EXPORT unsigned6 GlobalCompanyId;
  EXPORT unsigned2 IndustryType;
  EXPORT string IndustryTypeName;
  EXPORT unsigned6 ProductCode;
  EXPORT string FraudPlatform;
  EXPORT boolean AppendBest := TRUE;
  EXPORT string InquiryReason; //added for RIN API request only.
 END;

 // **************************************************************************************
 //  This is where the service options should be read from #store.
 //  The module parameter should be passed along to the underlying attributes.
 // **************************************************************************************
 EXPORT getParams() := FUNCTION
  IndustryType_Name := '' : STORED('IndustryTypeName');
  IndustryTypeCode := FraudShared.Key_MbsFdnIndType(RiskIntelligenceNetwork_Services.Constants.FRAUD_PLATFORM)
                             (keyed(description = ut.CleanSpacesAndUpper(IndustryType_Name)))[1].ind_type;

  base_params := BatchShare.IParam.getBatchParams();
  in_mod := MODULE(PROJECT(base_params, Params, OPT))
     EXPORT boolean IsOnline	:= FALSE: STORED('IsOnline');
     EXPORT unsigned3 DIDScoreThreshold:= 80 : STORED('DIDScoreThreshold');
     EXPORT unsigned6 GlobalCompanyId := 0 : STORED('GlobalCompanyId');
     EXPORT unsigned2 IndustryType := IndustryTypeCode;
     EXPORT string IndustryTypeName := IndustryType_Name;
     EXPORT unsigned6 ProductCode := 0 : STORED('ProductCode');
     EXPORT string FraudPlatform := RiskIntelligenceNetwork_Services.Constants.FRAUD_PLATFORM : STORED('FraudPlatform');
     EXPORT boolean AppendBest := TRUE: STORED('AppendBest');
     EXPORT string InquiryReason := '' : STORED('InquiryReason'); //added for RIN API request only.
  END;

  RETURN in_mod;
 END;
END;