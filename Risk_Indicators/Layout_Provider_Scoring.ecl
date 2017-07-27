EXPORT Layout_Provider_Scoring := MODULE

	EXPORT Input := RECORD
		UNSIGNED6 seq := 0; // Internal Sequence Number
		STRING30  AcctNo := ''; // Provider ID
		STRING120 Provider_Full_Name := '';
		STRING30  Provider_First_Name := '';
		STRING30  Provider_Middle_Name := '';
		STRING30  Provider_Last_Name := '';
		STRING120 Provider_Business_Name := '';
		STRING9   SSN := '';
		STRING8   DateOfBirth := '';
		STRING120 StreetAddress1 := '';
		STRING120 StreetAddress2 := '';
		STRING25  City := '';
		STRING2   St := '';
		STRING5   Zip := '';
		STRING4   Postal_Code := '';
		STRING10  BusinessPhone := '';
		STRING9   FEIN := '';
		STRING100 Medical_License := '';
		STRING10  NPI := '';
		STRING9   DEA_Number := '';
		STRING6   UPIN := '';
		STRING20  Claim_Amount := '';
		STRING150 Filler_Field_1 := '';
		STRING150 Filler_Field_2 := '';
		UNSIGNED3 HistoryDateYYYYMM := 0;
	END;
	
	EXPORT BatchOut := RECORD
		STRING30 AcctNo := '';
		STRING3 Score := '';
		STRING5 RC1 := '';
		STRING5 RC2 := '';
		STRING5 RC3 := '';
		STRING5 RC4 := '';
		STRING5 RC5 := '';
		STRING5 RC6 := '';
		STRING5 RC7 := '';
		STRING5 RC8 := '';
	END;
	
	EXPORT Clam_Plus := RECORD
		Risk_Indicators.Layout_Boca_Shell;
		DATASET({UNSIGNED6 bdid}) bdids {MAXCOUNT(6)};
	END;
	
	EXPORT Clam_Plus_Healthcare := RECORD
		UNSIGNED4 input_seq;
		STRING30 AcctNo;
		Clam_Plus BocaShell;
		Risk_Indicators.Layouts.Layout_Healthcare_Shell HealthCareShell;
	END;

END;