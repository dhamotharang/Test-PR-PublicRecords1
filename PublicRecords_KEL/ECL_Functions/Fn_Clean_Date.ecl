/*Cleans the input DOB or other dates
Strip off any non number from the input Date (example: DOB).
Set the year low to be 1800
Set the year high to be 100 + the current year
*/

IMPORT _Validate, STD, PublicRecords_KEL;

EXPORT Fn_Clean_Date (STRING InDate) := FUNCTION

	InDateinNums := (STRING8) STD.Str.Filter(InDate, '0123456789');
	
	HighRange := ((INTEGER)(((STRING8)Std.Date.Today())[1..4]) +100);
	#STORED ('_Validate_Year_Range_Low', '1800'); 
	#STORED ('_Validate_Year_Range_High', (STRING4) HighRange);

	UNSIGNED lTestFlags := _Validate.Date.Rules.YearValid 
                        |  _Validate.Date.Rules.MonthValid 
                        |  _Validate.Date.Rules.DayValid ; 

	PublicRecords_KEL.ECL_Functions.Cleaned_Date_Layout ClndDate() := TRANSFORM
			SELF.DateAsNumsOnly              := InDateinNums; 
			SELF.result             := _Validate.Date.fInvalidFlags(InDateinNums); 
			Date := _Validate.date;
			SELF.Populated          := if(SELF.result & Date.Rules.Optional <> 0, FALSE, TRUE); 
			SELF.YearFilled         := if(SELF.result & Date.Rules.YearFilled <> 0, FALSE, TRUE); 
			SELF.MonthFilled        := if(SELF.result & Date.Rules.MonthFilled <> 0, FALSE, TRUE); 
			SELF.DayFilled          := if(SELF.result & Date.Rules.DayFilled <> 0, FALSE, TRUE); 
			SELF.YearNonZero        := if(SELF.result & Date.Rules.YearNonZero <> 0, FALSE, TRUE); 
			SELF.MonthNonZero       := if(SELF.result & Date.Rules.MonthNonZero <> 0, FALSE, TRUE); 
			SELF.DayNonZero         := if(SELF.result & Date.Rules.DayNonZero <> 0, FALSE, TRUE); 
			SELF.YearValid          := if(SELF.result & Date.Rules.YearValid <> 0, FALSE, TRUE); 
			SELF.MonthValid         := if(SELF.result & Date.Rules.MonthValid <> 0, FALSE, TRUE); 
			SELF.DayValid           := if(SELF.result & Date.Rules.DayValid <> 0, FALSE, TRUE); 
			SELF.InPast             := if(SELF.result & Date.Rules.DateInPast <> 0, FALSE, TRUE); 
			SELF.InvalidChars       := if(SELF.result & Date.Rules.InvalidCharacters <> 0, FALSE, TRUE); 
			SELF.ChronStateUnknown  := if(SELF.result & Date.Rules.ChronStateUnknown <> 0,FALSE, TRUE); 
			SELF.DateValid          := if(_Validate.Date.fIsValid(InDateinNums, lTestFlags),TRUE, FALSE); 
			SELF.ValidPortion_00    := _Validate.Date.fCorrectedDateString(InDateinNums); 
			SELF.ValidPortion_01    := _Validate.Date.fCorrectedDateString(InDateinNums, TRUE); 
   END;  
 
  RETURN DATASET([ClndDate()]);
END;