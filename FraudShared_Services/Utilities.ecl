IMPORT ut, std, iesp;

EXPORT Utilities := MODULE

  EXPORT FailMeWithCode(code) := FUNCTIONMACRO
    RETURN FAIL(code, ut.MapMessageCodes(code));
  ENDMACRO;
    
  EXPORT ErrorMeWithCode(code) := FUNCTIONMACRO
    RETURN ERROR(code, ut.MapMessageCodes(code));
  ENDMACRO;

  // For quickly building SQL queries (double quotes around a string)
  EXPORT string dqString(string argument) := FUNCTION
    RETURN '"' + TRIM(argument,LEFT,RIGHT) + '"';
  END;

  //Convert a dataset to set
  EXPORT convertToSet(DATASET(iesp.frauddefensenetwork.t_FDNFileType) ft) := FUNCTION
  
    convert_layout := {string result};      
    
    prep := PROJECT(ft, TRANSFORM(convert_layout, SELF.result := dqString((string)LEFT.FileType)));

    rollUp_result  := ROLLUP(prep, TRUE, TRANSFORM(convert_layout, SELF.result := LEFT.result + ',' + RIGHT.result));    
    results := rollUp_result[1].result;

    RETURN results;
  END;
  
  // Date Conversion - Getting YYYY-MM-DD HH:MM:SS format from YYYYMMDD and HHMMSS
  EXPORT string20 TimeFormatStamp(
    string8 strYYYYMMDD = (string8)Std.Date.Today(),
    string6 strHHMMSS = ut.getTime()
  ) := FUNCTION
    result := strYYYYMMDD[1..4] + '-'  
      + strYYYYMMDD[5..6] + '-'   
      + strYYYYMMDD[7..8] + ' '
      + strHHMMSS[1..2] + ':'
      + strHHMMSS[3..4] + ':'
      + strHHMMSS[5..6];   
    RETURN result;
  END;
     
  EXPORT TodayDate   := TimeFormatStamp();
  EXPORT offset3Days := TimeFormatStamp(ut.getDateOffset(-3));
     
  //Getting YYYYMMDD format from TimeFormatStamp
  EXPORT string8 convertDate(string20 tfs) := FUNCTION
    result := tfs[1..4] + tfs[6..7] + tfs[9..10];
    RETURN result;
  END;

  //Getting HHMMSS format from TimeFormatStamp
  EXPORT string6 convertTime(string20 tfs) := FUNCTION
    result := tfs[12..13] + tfs[15..16] + tfs[18..19];
    RETURN result;      
  END;

END;
