IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInput_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) ds_input = DATASET([],PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) := 
  FUNCTION
    IsBlank := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank;
    IsBlank2Fields := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank2Fields;
    Constants := PublicRecords_KEL.ECL_Functions.Constants;     

    PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputCleaned(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII le, INTEGER C) := transform
		//Input Echo perserved
		SELF.InputUIDAppend := le.InputUIDAppend;
		SELF.BusInputUIDAppend := le.BusInputUIDAppend;
		SELF.InputAccountEcho := le.InputAccountEcho;
		SELF.InputLexIDEcho := le.InputLexIDEcho;
		SELF.InputFirstNameEcho := le.InputFirstNameEcho;
		SELF.InputMiddleNameEcho := le.InputMiddleNameEcho;
		SELF.InputLastNameEcho := le.InputLastNameEcho;			
		SELF.InputStreetEcho := le.InputStreetEcho;
		SELF.InputCityEcho := le.InputCityEcho;
		SELF.InputStateEcho := le.InputStateEcho; 
		SELF.InputZipEcho := le.InputZipEcho;
		SELF.InputHomePhoneEcho := le.InputHomePhoneEcho;
		SELF.InputWorkPhoneEcho := le.InputWorkPhoneEcho;
		SELF.InputEmailEcho := le.InputEmailEcho; 
		SELF.InputArchiveDateEcho := le.InputArchiveDateEcho;
		SELF.InputArchiveDateClean := le.InputArchiveDateEcho; 
		SELF.InputSSNEcho := le.InputSSNEcho;
		SELF.InputDOBEcho := le.InputDOBEcho;
		SELF.InputDLEcho := le.InputDLEcho;
		SELF.InputDLStateEcho := le.InputDLStateEcho;
		// Clean input
		cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.InputZipEcho);
		cleaned_Addr      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.InputStreetEcho, le.InputCityEcho, le.InputStateEcho, cleaned_zip);
		cleaned_DL        := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLNumber(le.InputDLEcho);
		cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.InputEmailEcho);
		cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.InputHomePhoneEcho);
		cleaned_workphone := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.InputWorkPhoneEcho);
		cleaned_SSN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.InputSSNEcho);
		DOB_dates         := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.InputDOBEcho);
		cleaned_DOB       := DOB_dates[1];
		cleaned_name      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Name_Roxie(le.InputFirstNameEcho, le.InputMiddleNameEcho, le.InputLastNameEcho);

		NameNotPopulated := IF(le.InputFirstNameEcho = '' AND le.InputMiddleNameEcho = '' AND le.InputLastNameEcho = '', '', le.InputLastNameEcho);
		/*
		// We need to revisit this logic below. InputCleanMiddleName may be populated after
		// cleaning if the input firstname contains both the firstname and the middlename.
		*/
		SELF.InputSuffixClean := cleaned_name.name_suffix;
		SELF.InputFirstNameClean := cleaned_name.fname;
		SELF.InputMiddleNameClean := cleaned_name.mname;
		SELF.InputLastNameClean := cleaned_name.lname;
		SELF.InputPrefixClean := cleaned_name.title;
			
		SELF.InputPrimaryRangeClean := cleaned_Addr.prim_range;
		SELF.InputPreDirectionClean := cleaned_Addr.predir;
		SELF.InputPrimaryNameClean := cleaned_Addr.prim_name;
		SELF.InputAddressSuffixClean := cleaned_Addr.addr_suffix;
		SELF.InputPostDirectionClean := cleaned_Addr.postdir;
		SELF.InputUnitDesigClean := cleaned_Addr.unit_desig;
		SELF.InputSecondaryRangeClean :=cleaned_Addr.sec_range;
		SELF.InputCityClean := cleaned_Addr.p_city_name;
		SELF.InputStateClean := cleaned_Addr.st;
		SELF.InputZip5Clean := cleaned_Addr.zip;
		SELF.InputZip4Clean := cleaned_Addr.zip4;
		SELF.InputLatitudeClean := cleaned_Addr.geo_lat;
		SELF.InputLongitudeClean :=	cleaned_Addr.geo_long;
		SELF.InputAddressTypeClean := cleaned_Addr.rec_type;
		SELF.InputAddressStatusClean :=	cleaned_Addr.err_stat;
		SELF.InputCountyClean := cleaned_Addr.county;
		SELF.InputGeoblockClean := cleaned_Addr.geo_blk;
		SELF.InputEmailClean :=cleaned_email;
		SELF.InputHomePhoneClean := cleaned_phone10;
		SELF.InputWorkPhoneClean := cleaned_workphone;
		SELF.InputSSNClean := cleaned_SSN;
		SELF.InputDOBClean := cleaned_DOB.ValidPortion_00; 
		SELF.InputDLClean := cleaned_DL;  
		SELF.InputDLStateClean := le.InputDLStateEcho;  
		
		// Cleaned DOB metadata
		SELF.DateAsNumsOnly := cleaned_DOB.DateAsNumsOnly; 
		SELF.result := cleaned_DOB.result;  
		SELF.Populated := cleaned_DOB.Populated; 
		SELF.YearFilled := cleaned_DOB.YearFilled; 
		SELF.MonthFilled := cleaned_DOB.MonthFilled; 
		SELF.DayFilled := cleaned_DOB.DayFilled;  
		SELF.YearNonZero := cleaned_DOB.YearNonZero; 
		SELF.MonthNonZero := cleaned_DOB.MonthNonZero; 
		SELF.DayNonZero := cleaned_DOB.DayNonZero;  
		SELF.YearValid := cleaned_DOB.YearValid;  
		SELF.MonthValid := cleaned_DOB.MonthValid; 
		SELF.DayValid := cleaned_DOB.DayValid; 
		SELF.InPast := cleaned_DOB.InPast; 
		SELF.InvalidChars := cleaned_DOB.InvalidChars;  
		SELF.ChronStateUnknown := cleaned_DOB.ChronStateUnknown;  
		SELF.DateValid := cleaned_DOB.DateValid;  
		SELF.ValidPortion_00 := cleaned_DOB.ValidPortion_00; 
		SELF.ValidPortion_01 := cleaned_DOB.ValidPortion_01; 
		
		SELF.RepNumber := le.RepNumber;
		SELF := le;
		SELF := [];
    END;

    cleanInput := PROJECT(ds_input, GetInputCleaned(LEFT, COUNTER));

    RETURN cleanInput;

  END;