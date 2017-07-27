import Census_Data, DriversV2;
export Functions := MODULE

	EXPORT myRec := RECORD
		STRING2 State;
		STRING  CountyCode;
	END;

	export String getCensusCountyDecode(string2 in_dlState, String in_CountyCode):= FUNCTION
		String clnCode := if(length(trim(in_CountyCode))>=5,in_CountyCode[LENGTH(trim(in_CountyCode))-2..],Trim(in_CountyCode));
		String resizeCode := INTFORMAT((integer)clnCode, 3, 1);
		result := Census_Data.Key_Fips2County(state_code=in_dlState,county_fips=resizeCode);
		retval := if(exists(result),result[1].county_name,'');
		return retval;
	END;
	
	export String getStateSpecificCountyDecode(string in_CountyCode):= FUNCTION
		String inState := in_CountyCode[1..2];
		String decode := map(inState = 'OH'  => StringLib.StringSubstituteOut(DriversV2.Tables_CP_OH.COURT_CODE(in_CountyCode),'|',' '),
												 inState = 'MO'  => DriversV2.Tables_CP_MO.Court(in_CountyCode),
												 '');
		return decode;
	END;
	
End;