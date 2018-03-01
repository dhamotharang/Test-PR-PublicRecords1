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
		SELF := le;
		SELF := [];
	END;
	
	final := PROJECT(input, getSubjectLevel(LEFT));
	
	// OUTPUT(CHOOSEN(input, 100), NAMED('SubjLevelInput'));
	// OUTPUT(CHOOSEN(final, 100), NAMED('SubjLevelFinal'));
	
	RETURN(final);
END;