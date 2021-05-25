IMPORT Risk_Indicators, dx_BancorpRCDList;

//usage: this helper function will be used when the new PayPal custom CVI model is requested (e.g. CCVI2105_1)
//functionality: checks whether a SSN is on the Bancorp blacklist data file within the InstantID real time service request
//then adds an additional risk indicator to the indicators returned in the standard CVI structure of the service if the SSN is part of the blacklist
//key used: dx_BancorpRCDList.key_SSN


EXPORT setRiskIndicatorsForCCVI2105_1(DATASET(Risk_Indicators.Layouts.Layout_Desc_Plus_Seq) inStandardRiskIndicators, 
                                      STRING9 inSocialSecurityNumber) := FUNCTION

  STRING2 riskIndicator := 'BL';
  kBancorpData := dx_BancorpRCDList.key_SSN();


  isOnBancorpList := EXISTS(kBancorpData(KEYED(ssn = TRIM(inSocialSecurityNumber, ALL))));

  riskIndicatorToInclude := DATASET([{1, riskIndicator, Risk_Indicators.getHRIDesc(riskIndicator)}], Risk_indicators.Layouts.Layout_Desc_Plus_Seq);

  riskIndicatorsTable := riskIndicatorToInclude + inStandardRiskIndicators;

  resequencedRiskIndicatorsTable := PROJECT(riskIndicatorsTable, TRANSFORM({RECORDOF(LEFT)},
                                                                           SELF.seq := COUNTER;
                                                                           SELF := LEFT;));

  withAdditionalRiskIndicator := IF(isOnBancorpList, resequencedRiskIndicatorsTable, inStandardRiskIndicators);



  //debugging options
  // OUTPUT(kBancorpData, NAMED('kBancorpData'));
  // OUTPUT(isOnBancorpList, NAMED('isOnBancorpList'));
  // OUTPUT(riskIndicatorToInclude, NAMED('riskIndicatorToInclude'));
  // OUTPUT(inStandardRiskIndicators, NAMED('inStandardRiskIndicators'));
  // OUTPUT(riskIndicatorsTable, NAMED('riskIndicatorsTable'));
  // OUTPUT(resequencedRiskIndicatorsTable, NAMED('resequencedRiskIndicatorsTable'));

  RETURN CHOOSEN(withAdditionalRiskIndicator, 6);

END;