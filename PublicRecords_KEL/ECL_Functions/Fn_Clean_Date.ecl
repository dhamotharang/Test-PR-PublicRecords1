/*Cleans the input DOB or other dates
Strip off any non number from the input Date (example: DOB).
Default valid low year is 1800
Default valid high year is 100 + the current year
If SetDefault is TRUE and no value is passed in for InDate, we will set the datetimestamp to the current time (UTC).
*/

IMPORT _Validate, PublicRecords_KEL, STD, ut;

EXPORT Fn_Clean_Date (STRING InDate, 
											INTEGER LowYear = PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_LOW_DEFAULT, 
											INTEGER HighDate = PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_HIGH_DEFAULT,
											BOOLEAN SetDefault = FALSE
											) := FUNCTION

	InDateWithDefault := IF(SetDefault AND TRIM(InDate) = '', ut.now('%Y%m%d%T', FALSE), InDate);// we know this produces an ECL warning about ut.now being deprecated, but switching to STD.Date causes the ECL compiler to crash
	FullInDateinNums := STD.Str.Filter(InDateWithDefault, '0123456789');
	InDateinNums := (STRING8)FullInDateinNums[1..8];
	
	Validate_Date := PublicRecords_KEL.ECL_Functions.validate_date_mas(LowYear, HighDate);

	UNSIGNED lTestFlags := Validate_Date.Rules.YearValid 
                        |  Validate_Date.Rules.MonthValid 
                        |  Validate_Date.Rules.DayValid ; 

	PublicRecords_KEL.ECL_Functions.Cleaned_Date_Layout ClndDate() := TRANSFORM
			SELF.DateAsNumsOnly              := InDateinNums; 
			SELF.result             := Validate_Date.fInvalidFlags(InDateinNums); 
			SELF.Populated          := if(SELF.result & Validate_Date.Rules.Optional <> 0, FALSE, TRUE); 
			SELF.YearFilled         := if(SELF.result & Validate_Date.Rules.YearFilled <> 0, FALSE, TRUE); 
			SELF.MonthFilled        := if(SELF.result & Validate_Date.Rules.MonthFilled <> 0, FALSE, TRUE); 
			SELF.DayFilled          := if(SELF.result & Validate_Date.Rules.DayFilled <> 0, FALSE, TRUE); 
			SELF.YearNonZero        := if(SELF.result & Validate_Date.Rules.YearNonZero <> 0, FALSE, TRUE); 
			SELF.MonthNonZero       := if(SELF.result & Validate_Date.Rules.MonthNonZero <> 0, FALSE, TRUE); 
			SELF.DayNonZero         := if(SELF.result & Validate_Date.Rules.DayNonZero <> 0, FALSE, TRUE); 
			SELF.YearValid          := if(SELF.result & Validate_Date.Rules.YearValid <> 0, FALSE, TRUE); 
			SELF.MonthValid         := if(SELF.result & Validate_Date.Rules.MonthValid <> 0, FALSE, TRUE); 
			SELF.DayValid           := if(SELF.result & Validate_Date.Rules.DayValid <> 0, FALSE, TRUE); 
			SELF.InPast             := if(SELF.result & Validate_Date.Rules.DateInPast <> 0, FALSE, TRUE); 
			SELF.InvalidChars       := if(SELF.result & Validate_Date.Rules.InvalidCharacters <> 0, FALSE, TRUE); 
			SELF.ChronStateUnknown  := if(SELF.result & Validate_Date.Rules.ChronStateUnknown <> 0,FALSE, TRUE); 
			SELF.DateValid          := if(Validate_Date.fIsValid(InDateinNums, lTestFlags),TRUE, FALSE); 
			SELF.ValidPortion_00    := Validate_Date.fCorrectedDateString(InDateinNums); 
			SELF.ValidPortion_01    := Validate_Date.fCorrectedDateString(InDateinNums, TRUE); 
			
			SELF.TimeStamp					:= if(SELF.DateValid, IF(LENGTH(FullInDateinNums[9..]) = 5, '0' + FullInDateinNums[9..], FullInDateinNums[9..]), '');
   END;  
 
  RETURN DATASET([ClndDate()]);
END;