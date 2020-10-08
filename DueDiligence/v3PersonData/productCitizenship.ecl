IMPORT DueDiligence, Risk_Indicators;


EXPORT productCitizenship(DATASET(Risk_Indicators.Layout_Boca_Shell) inData,
                          DATASET(DueDiligence.Citizenship.Layouts.IndicatorLayout) riskIndicators,
                          BOOLEAN modelValidation) := FUNCTION
    
    rawCit := DueDiligence.Citizenship.getCitizenship(inData, riskIndicators, modelValidation);
    
    convertToOutput := PROJECT(rawCit, TRANSFORM(DueDiligence.v3Layouts.DDOutput.PersonResults,
                                                 SELF.seq := LEFT.seq;
                                                 SELF := LEFT;
                                                 SELF := [];));


    // OUTPUT(rawCit, NAMED('rawCit'));
    // OUTPUT(convertToOutput, NAMED('convertToOutput'));
    
    
    RETURN convertToOutput;
END;