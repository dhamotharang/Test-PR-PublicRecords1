IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInput_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout) ds_input = DATASET([],PublicRecords_KEL.ECL_Functions.Input_ALL_Layout)) := 
  FUNCTION
    IsBlank := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank;
    IsBlank2Fields := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank2Fields;
    Constants := PublicRecords_KEL.ECL_Functions.Constants;     

    PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputCleaned(PublicRecords_KEL.ECL_Functions.Input_ALL_Layout le, INTEGER C) := transform
			//Input Echo perserved
			SELF.InputAccountEcho := le.InputAccountEcho;
			SELF.InputLexIDEcho := le.InputLexIDEcho;
			SELF.InputFirstNameEcho := le.InputFirstNameEcho;
			SELF.InputMiddleNameEcho := le.InputMiddleNameEcho;
			SELF.InputLastNameEcho := le.InputLastNameEcho;			
			SELF.InputAddressEcho := le.InputAddressEcho;
			SELF.InputCityEcho := le.InputCityEcho;
			SELF.InputStateEcho := le.InputStateEcho; 
			SELF.InputZipEcho := le.InputZipEcho;
			SELF.InputHomePhoneEcho := le.InputHomePhoneEcho;
			SELF.InputWorkPhoneEcho := le.InputWorkPhoneEcho;
			SELF.InputEmailEcho := le.InputEmailEcho; 
			SELF.InputArchiveDateEcho := le.InputArchiveDateEcho;
			SELF.InputArchiveDateClean := le.InputArchiveDateEcho; 
			SELF.InputUIDAppend := le.InputUIDAppend;
			SELF.InputSSNEcho := le.InputSSNEcho;
			SELF.InputDateOfBirthEcho := le.InputDateOfBirthEcho;
			SELF.InputDLNumberEcho := le.InputDLNumberEcho;
			SELF.InputDLStateEcho := le.InputDLStateEcho;
     // Clean input
      cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.InputZipEcho);
      cleaned_Addr      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.InputAddressEcho, le.InputCityEcho, le.InputStateEcho, cleaned_zip);
      cleaned_DL        := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLNumber(le.InputDLNumberEcho);
      cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.InputEmailEcho);
      cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.InputHomePhoneEcho);
      cleaned_workphone := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.InputWorkPhoneEcho);
      cleaned_SSN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.InputSSNEcho);
      DOB_dates         := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.InputDateOfBirthEcho);
      cleaned_DOB       := DOB_dates[1];
      cleaned_name      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Name_Roxie(le.InputFirstNameEcho, le.InputMiddleNameEcho, le.InputLastNameEcho);
 
	  NameNotPopulated := IF(le.InputFirstNameEcho = '' AND le.InputMiddleNameEcho = '' AND le.InputLastNameEcho = '', '', le.InputLastNameEcho);
      /*
      // We need to revisit this logic below. InputCleanMiddleName may be populated after
      // cleaning if the input firstname contains both the firstname and the middlename.
      */
		SELF.InputSuffixClean := IsBlank2Fields(NameNotPopulated, Constants.MISSING_INPUT_DATA,
			cleaned_name.name_suffix, Constants.NO_DATA_FOUND);
		SELF.InputFirstNameClean := IsBlank2Fields(le.InputFirstNameEcho, Constants.MISSING_INPUT_DATA,
			cleaned_name.fname, Constants.NO_DATA_FOUND);
		SELF.InputMiddleNameClean := IsBlank2Fields(le.InputMiddleNameEcho, Constants.MISSING_INPUT_DATA,
			cleaned_name.mname, Constants.NO_DATA_FOUND);
		SELF.InputLastNameClean := IsBlank2Fields(le.InputLastNameEcho, Constants.MISSING_INPUT_DATA,
			cleaned_name.lname, Constants.NO_DATA_FOUND);
		SELF.InputPrefixClean := IsBlank2Fields(NameNotPopulated, Constants.MISSING_INPUT_DATA,
			cleaned_name.title, Constants.NO_DATA_FOUND);

		SELF.InputPrimaryRangeClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.prim_range, Constants.NO_DATA_FOUND);
		SELF.InputPreDirectionClean :=  IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.predir, Constants.NO_DATA_FOUND);
		SELF.InputPrimaryNameClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.prim_name, Constants.NO_DATA_FOUND);
		SELF.InputAddressSuffixClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.addr_suffix, Constants.NO_DATA_FOUND);
		SELF.InputPostDirectionClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.postdir, Constants.NO_DATA_FOUND);
		SELF.InputUnitDesigClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.unit_desig, Constants.NO_DATA_FOUND);
		SELF.InputSecondaryRangeClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.sec_range, Constants.NO_DATA_FOUND);
		SELF.InputCityNameClean := IsBlank2Fields(le.InputCityEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.p_city_name, Constants.NO_DATA_FOUND);
		SELF.InputStateClean :=  IsBlank2Fields(le.InputStateEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.st, Constants.NO_DATA_FOUND);
		SELF.InputZip5Clean :=  IsBlank2Fields(le.InputZipEcho[1..5], Constants.MISSING_INPUT_DATA,
				cleaned_Addr.zip, Constants.NO_DATA_FOUND);
		SELF.InputZip4Clean := IsBlank2Fields(le.InputZipEcho[6..9], Constants.MISSING_INPUT_DATA,
				cleaned_Addr.zip4, Constants.NO_DATA_FOUND);
		SELF.InputLatitudeClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_lat, Constants.NO_DATA_FOUND);
		SELF.InputLongitudeClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_long, Constants.NO_DATA_FOUND);
		SELF.InputAddressTypeClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.rec_type, Constants.NO_DATA_FOUND);
		SELF.InputAddressStatusClean :=  IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.err_stat, Constants.NO_DATA_FOUND);
		SELF.InputCountyClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.county, Constants.NO_DATA_FOUND);
		SELF.InputGeoblockClean := IsBlank2Fields(le.InputAddressEcho, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_blk, Constants.NO_DATA_FOUND);

		SELF.InputEmailClean := IsBlank2Fields(le.InputEmailEcho, Constants.MISSING_INPUT_DATA,
				cleaned_email, Constants.NO_DATA_FOUND);

			SELF.InputHomePhoneClean := IsBlank2Fields(le.InputHomePhoneEcho, Constants.MISSING_INPUT_DATA,
				cleaned_phone10, Constants.NO_DATA_FOUND);
		SELF.InputWorkPhoneClean := IsBlank2Fields(le.InputWorkPhoneEcho, Constants.MISSING_INPUT_DATA,
				cleaned_workphone, Constants.NO_DATA_FOUND);
		SELF.InputSSNClean := cleaned_SSN;
		SELF.InputDOBClean := cleaned_DOB.ValidPortion_00; 
		SELF.InputDLNumberClean := cleaned_DL;  
			SELF.InputDLStateClean := le.InputDLStateEcho;  

		SELF.DateAsNumsOnly := cleaned_DOB.DateAsNumsOnly; 
		SELF.result := cleaned_DOB.result;  
		SELF.Populated := cleaned_DOB.Populated; 
		SELF.YearFilled := cleaned_DOB.YearFilled; 
		SELF.MonthFilled := cleaned_DOB.MonthFilled; 
		SELF.DayFilled := cleaned_DOB.MonthFilled;  
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

		SELF := [];
    END;

    cleanInput := PROJECT(ds_input, GetInputCleaned(LEFT, COUNTER));

    RETURN cleanInput;

  END;