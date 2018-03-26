IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Common, STD, ut;

EXPORT Fn_DateMath := MODULE

		SHARED boolean invalidDate(STRING instr) := (instr='' OR length(instr)<8);

		SHARED AgeBy := 84;	//(7*12)														// FCRA cannot go more than 7 years back
		SHARED AgeByHalf := 42;
		SHARED AgeByQuart := 21;
		SHARED SevenYearMonths := -7*12;		//negative						// FCRA cannot go more than 7 years back
		SHARED Today := PRTE2_common.constants.TodayString;
		SHARED LastDay := ut.month_math(Today,SevenYearMonths);	// FCRA cannot go more than 7 years back
		SHARED HalfDay := ut.month_math(Today,-42);
		SHARED QuartDay := ut.month_math(Today,-21);

		SHARED integer getGap(STRING instr) := ut.monthsApart_YYYYMMDD(LastDay,instr) + 3;
		SHARED integer halfGap(STRING instr) := ut.monthsApart_YYYYMMDD(HalfDay,instr) + 3;
		SHARED integer quartGap(STRING instr) := ut.monthsApart_YYYYMMDD(QuartDay,instr) + 3;
		// Warning:  Definition monthsapart_yyyymmdd is marked as deprecated.  Use Std.Date.MonthsBetween instead after checking

		// workaround - pick a date without going past today, worst case keep the original date.
		SHARED PickDate(STRING D1,STRING D2,STRING D3,STRING instr) := FUNCTION
			RETURN IF(D1<=Today,D1,
								IF(D2<=Today,D2,
										IF(D3<=Today,D3,
											instr)));
		END;
		SHARED dateMath(STRING instr) := FUNCTION
			D1 := ut.month_math(instr,ageBy);
			D2 := ut.month_math(instr,AgeByHalf);
			D3 := ut.month_math(instr,AgeByQuart);
			RETURN PickDate(D1,D2,D3,instr);
		END;
		SHARED dateMathGap(STRING instr, STRING fileDate) := FUNCTION
			D1 := ut.month_math(instr,getGap(fileDate));
			D2 := ut.month_math(instr,halfGap(fileDate));
			D3 := ut.month_math(instr,quartGap(fileDate));
			RETURN PickDate(D1,D2,D3,instr);
		END;
		EXPORT STRING FIXYear(STRING instr) := FUNCTION
				RETURN if (invalidDate(instr), 
											instr,
											dateMath(instr));
		END;

		// ensures that the date is within the 7 years for FCRA dates
		SHARED boolean CheckFilingYear(STRING instr) := FUNCTION
				ans1 := FIXYear(instr);
				RETURN (ans1 > LastDay);
		END;

		// ????? Check out what the purpose and logic is here.
		EXPORT STRING FIXYearWithCheck(STRING fileDate, STRING desiredDate) := FUNCTION
			RETURN IF(invalidDate(fileDate), FIXYear(desiredDate),
								IF(CheckFilingYear(fileDate), FIXYear(desiredDate),
										IF (invalidDate(desiredDate), desiredDate,
													dateMathGap(desiredDate,fileDate) )));
		END;

		EXPORT STRING FIXFilingYear(STRING fileDate) := FUNCTION
			RETURN IF(invalidDate(fileDate), fileDate,
								IF(CheckFilingYear(fileDate), FIXYear(fileDate),
										dateMathGap(fileDate,fileDate) ));
		END;

END;