/* ************************************************************************
 * This function gathers the Subject_Level attributes.										*
 ************************************************************************ */

IMPORT Phone_Shell, Risk_Indicators, RiskWise, UT;

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Get_Attributes_Subject_Level (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input) := FUNCTION
	Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus getSubjectLevel(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le) := TRANSFORM
		SELF.Subject_Level.Subject_SSN_Mismatch := MAP(
																										TRIM(le.Clean_Input.SSN) = '' OR TRIM(le.Clam.iid.bestssn) = '' => -1,
																										TRIM(le.Clean_Input.SSN) = TRIM(le.Clam.iid.bestssn)						=> 0,
																																																											 1
																										);
		// These are calculated in Phone_Shell.Search_Gateway_Experian so that we don't hit the same key twice
		SELF.Subject_Level.Experian_Num_Duplicate := le.Subject_Level.Experian_Num_Duplicate;
		SELF.Subject_Level.Experian_Num_Insufficient_Score := le.Subject_Level.Experian_Num_Insufficient_Score;
		
		SELF := le;
	END;
	
	final := PROJECT(input, getSubjectLevel(LEFT));
	
	// OUTPUT(CHOOSEN(input, 100), NAMED('SubjLevelInput'));
	// OUTPUT(CHOOSEN(final, 100), NAMED('SubjLevelFinal'));
	
	RETURN(final);
END;