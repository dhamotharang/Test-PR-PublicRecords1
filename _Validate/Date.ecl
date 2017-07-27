import _Validate;
_Flag	:=	unsigned4;

export Date
 :=
  module
	shared	lValidYearLow	:=	1600		:	stored('_Validate_Year_Range_Low');
	shared	lValidYearHigh	:=	2999		:	stored('_Validate_Year_Range_High');
	
	export	boolean		fIsLeapYear(integer pYear)
							:=	_Validate.Date_New(lValidYearLow, lValidYearHigh).fIsLeapYear(pYear);
							
	export	integer		fDaysInMonth(integer pYear, integer pMonth)
							:=	_Validate.Date_New(lValidYearLow, lValidYearHigh).fDaysInMonth(pYear, pMonth);
	
	export	Rules	:=	_Validate.Date_New(lValidYearLow, lValidYearHigh).Rules;
				
	export	string	fGetRulesFromFlags(_Flag pFlags)
	 :=	_Validate.Date_New(lValidYearLow, lValidYearHigh).fGetRulesFromFlags(pFlags);
	  
	export	boolean	fIsValid(string pDateString, _Flag pRuleFlags = Rules.DayValid, boolean pZeroMonthOkay=false, boolean pZeroDayOkay=false)
	 := _Validate.Date_New(lValidYearLow, lValidYearHigh).fIsValid(pDateString, pRuleFlags, pZeroMonthOkay, pZeroDayOkay);

	export	_Flag	fInvalidFlags(string pDateString, boolean pZeroMonthOkay=false, boolean pZeroDayOkay=false)
	 := _Validate.Date_New(lValidYearLow, lValidYearHigh).fInvalidFlags(pDateString, pZeroMonthOkay, pZeroDayOkay);
	
	export	string8	fCorrectedDateString(string pDateString, boolean pUseOneInsteadOfZero=false)
	 := _Validate.Date_New(lValidYearLow, lValidYearHigh).fCorrectedDateString(pDateString, pUseOneInsteadOfZero);
	
  end
 ;
