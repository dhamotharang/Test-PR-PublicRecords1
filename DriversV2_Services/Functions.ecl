IMPORT Census_Data, DriversV2, STD;
EXPORT Functions := MODULE

  EXPORT myRec := RECORD
    STRING2 State;
    STRING CountyCode;
  END;

  EXPORT STRING getCensusCountyDecode(STRING2 in_dlState, STRING in_CountyCode):= FUNCTION
    STRING clnCode := IF(LENGTH(TRIM(in_CountyCode))>=5,in_CountyCode[LENGTH(TRIM(in_CountyCode))-2..],TRIM(in_CountyCode));
    STRING resizeCode := INTFORMAT((INTEGER)clnCode, 3, 1);
    result := Census_Data.Key_Fips2County(state_code=in_dlState,county_fips=resizeCode);
    retval := IF(EXISTS(result),result[1].county_name,'');
    RETURN retval;
  END;
  
  EXPORT STRING getStateSpecificCountyDecode(STRING in_CountyCode):= FUNCTION
    STRING inState := in_CountyCode[1..2];
    STRING decode := MAP(inState = 'OH' => STD.STR.SubstituteIncluded(DriversV2.Tables_CP_OH.COURT_CODE(in_CountyCode),'|',' '),
                         inState = 'MO' => DriversV2.Tables_CP_MO.Court(in_CountyCode),
                         '');
    RETURN decode;
  END;
  
END;
