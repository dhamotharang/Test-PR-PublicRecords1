// Contains common functions used in the Suspicious Fraud products

IMPORT Models, Risk_Indicators, RiskWise, Suspicious_Fraud_LN, UT;

EXPORT Common := MODULE
	// Generates the Suspicious Fraud Risk Code Dataset including Risk Code description
	EXPORT genRiskCode(STRING4 RiskCode) := DATASET([{RiskCode, Suspicious_Fraud_LN.getSusCodeDesc(RiskCode)}], Suspicious_Fraud_LN.Layouts.Risk_Indicators);

	// Given a Dataset, field in that Dataset to create the Delimited list from, and the Delimiter, will output a STRING field delimited list
	/* Usage: 
RiskCodeRecord := RECORD
	STRING SuspiciousRiskCode := '';
	STRING SuspiciousRiskCodeDescription := '';
END;
SetToConvert := DATASET([{'S01', ''},
												 {'S02', ''},
												 {'S04', ''},
												 {'S03', ''}], RiskCodeRecord);
converted := Suspicious_Fraud_LN.Common.convertDelimited(SetToConvert, SuspiciousRiskCode, ',');
OUTPUT(SetToConvert, NAMED('Set_To_Convert'));
OUTPUT(converted, NAMED('Converted_Set'));
	*/
	EXPORT convertDelimited(myDataset, field, delimiter, rollConditions = 'TRUE') := FUNCTIONMACRO
		myConvertRecord := RECORD
			RECORDOF(myDataset);
			STRING finalizedDelimitedList := '';
		END;

		prep := PROJECT(myDataset, TRANSFORM(myConvertRecord, SELF.finalizedDelimitedList := (STRING)LEFT.field; SELF := LEFT));
	
		roll := ROLLUP(prep, #EXPAND(rollConditions), TRANSFORM(myConvertRecord, SELF.finalizedDelimitedList := TRIM(LEFT.finalizedDelimitedList) + TRIM(delimiter) + TRIM(RIGHT.finalizedDelimitedList); SELF := LEFT));
	
		RETURN(roll[1].finalizedDelimitedList);
	ENDMACRO;
	
	// Generates a dataset from a delimited string field
	EXPORT fromDelimited(field, delimiter) := FUNCTIONMACRO
		outputLayout := RECORD
			STRING fieldValues := '';
		END;
		
		myDataset := Models.Common.Zip2(field, field, delimiter);
		
		final := PROJECT(myDataset, TRANSFORM(outputLayout, SELF.fieldValues := LEFT.Str1));
		
		RETURN(final);
	ENDMACRO;
	
	EXPORT padDate(STRING8 Date) := MAP(TRIM(Date, ALL) = '' OR (UNSIGNED)Date = 0 => '',
																			(UNSIGNED)(Date[5..8]) = 0 => Date[1..4] + '0101',
																			(UNSIGNED)(Date[7..8]) = 0 => Date[1..6] + '01',
																																		Date);
END;