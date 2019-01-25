// This function takes in a SALT profile and then outputs some potential fields that are poorly populated

IMPORT SALT38;

EXPORT SALT_Profile_Poorly_Populated_Fields(DATASET(SALT38.MAC_Character_Counts.ResultLine_Layout) InputSALTProfile, INTEGER NumberOfDataPatternsToShow = 5, REAL MinimumPercentBlank = 50.0) := FUNCTION
	SlimmedSALTProfile := PROJECT(InputSALTProfile, TRANSFORM({RECORDOF(LEFT) - cardinality - minval30 - maxval30 - asnumber_minval - asnumber_maxval - asnumber_mean - asnumber_var - len - words - characters}, SELF := LEFT));
	
	FieldPopulationLayout := RECORD
		UNSIGNED8 Field_Number;
		STRING Field_Name;
		STRING Status;
		REAL Percent_Not_Populated;
		RECORDOF(SlimmedSALTProfile) - fldno - fieldname;
	END;
	
	FieldPopulationLayout getFieldPopulations(SlimmedSALTProfile SALTProfile) := TRANSFORM
		SELF.Field_Number := (UNSIGNED)SALTProfile.Fldno;
		SELF.Field_Name := SALTProfile.FieldName;
		
		zeroFrequentTerms := ROLLUP(SORT(PROJECT(SALTProfile.Frequent_Terms, TRANSFORM(RECORDOF(LEFT), SELF.Val := IF(LENGTH(TRIM(StringLib.StringFilterOut(LEFT.Val, '0123456789'), ALL)) > 0, LEFT.Val, (STRING)((INTEGER)LEFT.Val)); SELF := LEFT)), Val), LEFT.Val = RIGHT.Val, TRANSFORM(RECORDOF(LEFT), SELF.Cnt := LEFT.Cnt + RIGHT.Cnt; SELF.PCNT := LEFT.PCNT + RIGHT.PCNT; SELF := LEFT));
		frequentTermsZero := (REAL)zeroFrequentTerms (LENGTH(TRIM(StringLib.StringFilterOut(Val, '0123456789'), ALL)) = 0 AND (INTEGER)Val = 0)[1].PCNT;
		
		blankPatternsPCNT := (REAL)SALTProfile.Patterns (TRIM(data_pattern) = '')[1].PCNT;
		SELF.Status := MAP(blankPatternsPCNT = 100 OR frequentTermsZero = 100	=> 'Never Populated',
							blankPatternsPCNT >= 99 OR frequentTermsZero >= 99	=> 'Almost Never Populated (< 1%)',
							blankPatternsPCNT >= 97 OR frequentTermsZero >= 97	=> 'Very Rarely Populated (< 3%)',
							blankPatternsPCNT >= 95 OR frequentTermsZero >= 95	=> 'Rarely Populated (< 5%)',
							blankPatternsPCNT >= 90 OR frequentTermsZero >= 90	=> 'Poorly Populated (< 10%)',
														'');
		SELF.Percent_Not_Populated := MAX(blankPatternsPCNT, frequentTermsZero);				
		SELF.Patterns := IF(NumberOfDataPatternsToShow <= 0, SALTProfile.Patterns, CHOOSEN(SALTProfile.Patterns, NumberOfDataPatternsToShow));
		SELF.Frequent_Terms := IF(NumberOfDataPatternsToShow <= 0, SALTProfile.Frequent_Terms, CHOOSEN(SALTProfile.Frequent_Terms, NumberOfDataPatternsToShow));
	END;
	
	WithFieldPopulations := SORT(PROJECT(SlimmedSALTProfile, getFieldPopulations(LEFT)), -Percent_Not_Populated, Field_Number) (Percent_Not_Populated >= MinimumPercentBlank);
								
	RETURN WithFieldPopulations;
END;