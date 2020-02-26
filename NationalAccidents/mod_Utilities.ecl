//mod_Utilities

IMPORT STD, Ecrash_Common;

EXPORT mod_Utilities := MODULE

   //CurrentDate in Local   
	 EXPORT SysDate := Std.Date.CurrentDate(TRUE):INDEPENDENT;
	 
	 // str CurrentDate in Local
	 EXPORT strSysDate := (STRING) SysDate;
	 
	 //CurrentTime(MMSS) in Local
	 EXPORT SysTime := Std.Date.CurrentTime(TRUE):INDEPENDENT;
	 
	 EXPORT StrDateTimeToUnsigned(STRING19 dateTimeStamp) := Ecrash_Common.fn_ConvertDateTime(dateTimeStamp);
	 
	 EXPORT StrDateTimeToDate(STRING19 dateTimeStamp) := Ecrash_Common.fn_ConvertDate(dateTimeStamp);
	 
	 EXPORT STRING8 ConvertSlashedMDYtoCYMD(STRING pDate) :=	INTFORMAT((INTEGER2) REGEXREPLACE('.*/.*/([0-9]+)',pDate,'$1'),4,1) +
																																																										INTFORMAT((INTEGER1) REGEXREPLACE('([0-9]+)/.*/.*',pDate,'$1'),2,1) + 
																																																										INTFORMAT((INTEGER1) REGEXREPLACE('.*/([0-9]+)/.*',pDate,'$1'),2,1);
																																																										
	 EXPORT StartDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).StartDate;
	 
	 EXPORT EndDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).EndDate;

	 EXPORT StartDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).StartDate;
	 
	 EXPORT EndDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).EndDate;
	
	 EXPORT AdjustDate(UNSIGNED4 idate, INTEGER offset) := STD.Date.AdjustDate(idate,,,offset);
	 
	 EXPORT DaysBetween(UNSIGNED4 FromDate, UNSIGNED4 ToDate) := STD.Date.DaysBetween(FromDate, ToDate);
	 
	 EXPORT CurrentDateUTC := STD.Date.CurrentDate(FALSE):INDEPENDENT;  
																								
END;