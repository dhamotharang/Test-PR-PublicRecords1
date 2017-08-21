IMPORT _validate,ut,hms_csr;

EXPORT fn_cleanDate(string in_Date) := FUNCTION
			inDate := regexreplace('[()\"]*',in_Date,'');
		  outDate := if(length(trim(inDate,left,right))<4,'',if(Dates.ChkDtStr(StringLib.StringCleanSpaces(inDate)),_validate.date.fCorrectedDateString(Dates.CvtDate( Dates.CvtDateEx(Dates.PrepDtStr(trim(StringLib.StringCleanSpaces(inDate),left,right)) ) ,'%Y%m%d'),false),_validate.date.fCorrectedDateString(Dates.ChkRevDtStr(trim(StringLib.StringCleanSpaces(inDate),left,right)),false)));
  RETURN outDate;
END;