//mod_Utilities

IMPORT STD, Ecrash_Common, _control, Data_Services;

EXPORT mod_Utilities := MODULE

	 EXPORT EnvName := _control.ThisEnvironment.Name;
	 
	 EXPORT Location := IF(EnvName = 'Prod_Thor', '~', Data_Services.Foreign_Prod);

   //CurrentDate in Local   
	 EXPORT SysDate := Std.Date.CurrentDate(TRUE):INDEPENDENT;
	 
	 // str CurrentDate in Local
	 EXPORT StrSysDate := (STRING8) SysDate;
	 
	 //CurrentTime(MMSS) in Local
	 EXPORT SysTime := Std.Date.CurrentTime(TRUE):INDEPENDENT;
	 
	 EXPORT CurrentDateTimeStamp := Std.Date.SecondsToString(STD.Date.CurrentSeconds(TRUE), '%Y%m%d%H%M%S'):INDEPENDENT;
	 EXPORT strCurrentDateTimeStamp := (STRING14) CurrentDateTimeStamp;
	 
 	 EXPORT StrSysSeconds := Std.Date.SecondsToString(Std.date.CurrentSeconds(TRUE), '%H%M%S');
	 
	 EXPORT StrDateTimeToUnsigned(STRING19 dateTimeStamp) := Ecrash_Common.fn_ConvertDateTime(dateTimeStamp);
	 
	 EXPORT StrDateTimeToDate(STRING19 dateTimeStamp) := Ecrash_Common.fn_ConvertDate(dateTimeStamp);
	 
	 EXPORT STRING8 ConvertSlashedMDYtoCYMD(STRING pDate) :=	INTFORMAT((INTEGER2) REGEXREPLACE('.*/.*/([0-9]+)',pDate,'$1'),4,1) +
                                                            INTFORMAT((INTEGER1) REGEXREPLACE('([0-9]+)/.*/.*',pDate,'$1'),2,1) + 
                                                            INTFORMAT((INTEGER1) REGEXREPLACE('.*/([0-9]+)/.*',pDate,'$1'),2,1);
																														
	 EXPORT ConvDtTimeStampToYYYYMMDD(STRING DtTimeStamp ) := IF(TRIM(DtTimeStamp, LEFT, RIGHT)[1..10] <> '0000-00-00',
																												       STD.Str.FilterOut(TRIM(DtTimeStamp, LEFT, RIGHT)[1..10], '-'),
																												       '');
																																																										
	 EXPORT StartDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).StartDate;
	 
	 EXPORT EndDateOfWeek(UNSIGNED4 DateIn) := STD.Date.DatesForWeek(DateIn).EndDate;

	 EXPORT StartDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).StartDate;
	 
	 EXPORT EndDateOfMonth(UNSIGNED4 DateIn) := STD.Date.DatesForMonth(DateIn).EndDate;
	
	 EXPORT AdjustDate(UNSIGNED4 idate, INTEGER offset) := STD.Date.AdjustDate(idate,,,offset);
	 
	 EXPORT DaysBetween(UNSIGNED4 FromDate, UNSIGNED4 ToDate) := STD.Date.DaysBetween(FromDate, ToDate);
	 
	 EXPORT CurrentDateUTC := STD.Date.CurrentDate(FALSE):INDEPENDENT;  	
	 
	 EXPORT BOOLEAN fn_isFileExists(STRING SuperFile) := FUNCTION
		RETURN STD.File.FileExists(SuperFile);
	 END;
	
	 // 0 <-  Doesnt Exists
	 // <> 0 <-  Exists
	 EXPORT BOOLEAN fn_isSuperFileSubNameExists(STRING SuperFile, STRING LogicalFile) := FUNCTION
	  isReadyToAddFile := STD.File.FindSuperFileSubName(SuperFile, LogicalFile) <> 0;
	  RETURN isReadyToAddFile;
	 END;
	
	 EXPORT fn_CreateSuperFile(STRING SuperFile) := FUNCTION
	  RETURN IF (~fn_isFileExists(SuperFile), STD.File.CreateSuperFile(SuperFile));
   END;
	
	 EXPORT fn_AddSuperFile(STRING SuperFile, STRING LogicalFile) := FUNCTION
    isReadyToAddFile := fn_isSuperFileSubNameExists(SuperFile, LogicalFile);
		AddSF := STD.File.AddSuperFile(SuperFile, LogicalFile);	
    RETURN IF (~isReadyToAddFile, AddSF);
   END;
	 
	 EXPORT fn_ClearSuperFile(STRING SuperFile) := FUNCTION
		ClearSF := SEQUENTIAL(FileServices.StartSuperFileTransaction(),
                          FileServices.ClearSuperFile(SuperFile, FALSE),
                          FileServices.FinishSuperFileTransaction());
		RETURN IF(fn_isFileExists(SuperFile), ClearSF);											
	 END;
																								
END;