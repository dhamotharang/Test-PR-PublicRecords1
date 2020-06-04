IMPORT STD;

EXPORT mod_Utilities := MODULE

   //CurrentDate in Local   
	 EXPORT SysDate := Std.Date.CurrentDate(TRUE):INDEPENDENT;
	 // str CurrentDate in Local
	 EXPORT strSysDate := (STRING) SysDate;
	 //CurrentTime(MMSS) in Local
	 EXPORT SysTime := Std.Date.CurrentTime(TRUE):INDEPENDENT;
	 //Fn to Trim and convert to Uppercase
	 EXPORT Str_fnTrim2Upper(STRING pStr) := Std.Str.touppercase(Std.str.cleanspaces(pStr));
	 EXPORT Str_fnTrim2Lower(STRING pStr) := Std.Str.tolowercase(Std.str.cleanspaces(pStr));
	 //Number (0-365) 
	 EXPORT DayofTheYear(UNSIGNED pDate) := Std.Date.DayOfYear(pDate);
   //Current Date in STRING format
	 SHARED STRING8 STR_CURRENT_DATE := (STRING8) SysDate:INDEPENDENT;
	 
		 TimeSecs        := Std.Date.CurrentTimestamp(true) DIV 1000000;
     TimeSecsStr     := Std.Date.SecondsToString(TimeSecs, '%H%M%S');
     TimeFraction    := TimeSecs % 1000000;
	 //Current Time in STRING format	 
   EXPORT TIME_MILLI := (STRING) (TimeSecsStr + TimeFraction):INDEPENDENT;	 
	 
	 SHARED FORMAT_TIME := TIME_MILLI[1..2] + ':' + TIME_MILLI[3..4] + ':' + TIME_MILLI[5..6]+ '.' + TIME_MILLI[7..9];
	 
	 SHARED FORMAT_TIMEHHMMSS := TIME_MILLI[1..2] + ':' + TIME_MILLI[3..4] + ':' + TIME_MILLI[5..6]; 
	 
	 SHARED CURRENT_DATE := STR_CURRENT_DATE[1..4] + '-' + STR_CURRENT_DATE[5..6]+ '-' + STR_CURRENT_DATE[7..8];
	 
	 EXPORT StartDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).StartDate;
	 
	 EXPORT EndDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).EndDate;

	 EXPORT StartDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).StartDate;
	 
	 EXPORT EndDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).EndDate;
	
	 EXPORT AdjustDate(UNSIGNED4 idate, INTEGER offset) := STD.Date.AdjustDate(idate,,,offset);
	 
	 EXPORT DaysBetween(UNSIGNED4 FromDate, UNSIGNED4 ToDate) := STD.Date.DaysBetween(FromDate, ToDate);
	 
	 EXPORT CurrentDateUTC := STD.Date.CurrentDate(FALSE):INDEPENDENT;  

	 // Time Stamp (14 bytes) in YYYYMMDDHHMMSS
	 EXPORT TIME_STAMP := STD.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'):INDEPENDENT;

   // Figure out which day of the month this is
	 EXPORT DAY_OF_MONTH := (UNSIGNED3) STR_CURRENT_DATE[7..8];
	 
	 // Formating the current Date with Time in the 2015-07-27 10:00:00.000 format
	 EXPORT CURRENT_DATE_TIME := CURRENT_DATE + ' ' + FORMAT_TIME;
	 
	 // Formating the current Date with Time in the 2015-07-27 10:00:00 format
	 EXPORT CURRENT_DATE_TIMEHHMMSS := CURRENT_DATE + ' ' + FORMAT_TIMEHHMMSS;
	 
	 EXPORT UNSIGNED2 REPORT_DAY_OF_WEEK := STD.DATE.DayOfWeek(SysDate);
																													 
	 // Day of the Year in YYJJJ format
  EXPORT JulianDayOfTheYear(UNSIGNED4  pDate) := Std.Date.DayOfYear(pDate);
	 
	 EXPORT STRING8 ConvertSlashedMDYtoCYMD(STRING pDate) :=	INTFORMAT((INTEGER2) REGEXREPLACE('.*/.*/([0-9]+)',pDate,'$1'),4,1) +
																																																										INTFORMAT((INTEGER1) REGEXREPLACE('([0-9]+)/.*/.*',pDate,'$1'),2,1) + 
																																																										INTFORMAT((INTEGER1) REGEXREPLACE('.*/([0-9]+)/.*',pDate,'$1'),2,1);
																																																										
END;