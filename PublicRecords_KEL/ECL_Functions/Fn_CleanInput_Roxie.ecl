IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInput_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_Layout) ds_input = DATASET([],PublicRecords_KEL.ECL_Functions.Input_Layout)) := 
  FUNCTION
    IsBlank := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank;
    IsBlank2Fields := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank2Fields;
    Constants := PublicRecords_KEL.ECL_Functions.Constants;     

    // Clean input
    PublicRecords_KEL.ECL_Functions.Input_ALL_Layout GetInputCleaned(PublicRecords_KEL.ECL_Functions.Input_Layout le, INTEGER C) := transform

      SELF.Account := IsBlank(le.Account, Constants.MISSING_INPUT_DATA);
      SELF.InputID := C;
 	  SELF.InputLexid := (INTEGER) le.LexID;
      SELF.InputFirstName := IsBlank(STD.Str.Touppercase(le.FirstName), Constants.MISSING_INPUT_DATA);
      SELF.InputAddress := IsBlank(le.StreetAddress, Constants.MISSING_INPUT_DATA);
      SELF.InputCity := IsBlank(le.City, Constants.MISSING_INPUT_DATA);
      SELF.InputState := IsBlank(le.State, Constants.MISSING_INPUT_DATA);
      SELF.InputZip := IsBlank(le.Zip, Constants.MISSING_INPUT_DATA);
      SELF.InputHomePhone := IsBlank(le.HomePhone, Constants.MISSING_INPUT_DATA);
      SELF.InputWorkPhone := IsBlank(le.WorkPhone, Constants.MISSING_INPUT_DATA);
      SELF.InputEmail := IsBlank(le.EMAIL, Constants.MISSING_INPUT_DATA);
      SELF.InputArchiveDate := IsBlank(le.historydate, Constants.MISSING_INPUT_DATA);
      SELF.ArchiveDate := le.historydate;
 
      cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.Zip);
      cleaned_Addr      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.StreetAddress, le.City, le.State, cleaned_zip);
      cleaned_DL        := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLNumber(le.DLNumber);
      cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.EMAIL);
      cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.HomePhone);
      cleaned_workphone := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.WorkPhone);
      cleaned_SSN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.SSN);
      DOB_dates         := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.DateOfBirth);
      cleaned_DOB       := DOB_dates[1];
      cleaned_name      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Name_Roxie(le.FirstName, le.MiddleName, le.LastName);
 
			NameNotPopulated := IF(le.FirstName = '' AND le.MiddleName = '' AND le.LastName = '', '', le.FirstName);
      /*
      // We need to revisit this logic below. InputCleanMiddleName may be populated after
      // cleaning if the input firstname contains both the firstname and the middlename.
      */
      SELF.InputCleanSuffix := IsBlank2Fields(NameNotPopulated, Constants.MISSING_INPUT_DATA,
				cleaned_name.name_suffix, Constants.NO_DATA_FOUND);
			SELF.InputCleanFirstName := IsBlank2Fields(le.FirstName, Constants.MISSING_INPUT_DATA,
				cleaned_name.fname, Constants.NO_DATA_FOUND);
			SELF.InputCleanMiddleName := IsBlank2Fields(le.MiddleName, Constants.MISSING_INPUT_DATA,
				cleaned_name.mname, Constants.NO_DATA_FOUND);
      SELF.InputCleanLastName := IsBlank2Fields(le.LastName, Constants.MISSING_INPUT_DATA,
				cleaned_name.lname, Constants.NO_DATA_FOUND);
      SELF.InputCleanPrefix := IsBlank2Fields(NameNotPopulated, Constants.MISSING_INPUT_DATA,
				cleaned_name.title, Constants.NO_DATA_FOUND);
 
      SELF.InputCleanPrimaryRange := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.prim_range, Constants.NO_DATA_FOUND);
      SELF.InputCleanPreDirection :=  IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.predir, Constants.NO_DATA_FOUND);
      SELF.InputCleanPrimaryName := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.prim_name, Constants.NO_DATA_FOUND);
      SELF.InputCleanAddressSuffix := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.addr_suffix, Constants.NO_DATA_FOUND);
      SELF.InputCleanPostDirection := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.postdir, Constants.NO_DATA_FOUND);
      SELF.InputCleanUnitDesig := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.unit_desig, Constants.NO_DATA_FOUND);
      SELF.InputCleanSecondaryRange := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.sec_range, Constants.NO_DATA_FOUND);
      SELF.InputCleanCityName := IsBlank2Fields(le.City, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.p_city_name, Constants.NO_DATA_FOUND);
      SELF.InputCleanState :=  IsBlank2Fields(le.State, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.st, Constants.NO_DATA_FOUND);
      SELF.InputCleanZip5 :=  IsBlank2Fields(le.Zip[1..5], Constants.MISSING_INPUT_DATA,
				cleaned_Addr.zip, Constants.NO_DATA_FOUND);
      SELF.InputCleanZip4 := IsBlank2Fields(le.Zip[6..9], Constants.MISSING_INPUT_DATA,
				cleaned_Addr.zip4, Constants.NO_DATA_FOUND);
      SELF.InputCleanLatitude := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_lat, Constants.NO_DATA_FOUND);
      SELF.InputCleanLongitude := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_long, Constants.NO_DATA_FOUND);
      SELF.InputCleanAddressType := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.rec_type, Constants.NO_DATA_FOUND);
      SELF.InputCleanAddressStatus :=  IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.err_stat, Constants.NO_DATA_FOUND);
      SELF.InputCleanCounty := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.county, Constants.NO_DATA_FOUND);
      SELF.InputCleanGeoblock := IsBlank2Fields(le.StreetAddress, Constants.MISSING_INPUT_DATA,
				cleaned_Addr.geo_blk, Constants.NO_DATA_FOUND);

      SELF.InputCleanEMail := IsBlank2Fields(le.Email, Constants.MISSING_INPUT_DATA,
				cleaned_email, Constants.NO_DATA_FOUND);
      
			SELF.InputCleanHomePhone := IsBlank2Fields(le.HomePhone, Constants.MISSING_INPUT_DATA,
				cleaned_phone10, Constants.NO_DATA_FOUND);
      SELF.InputCleanWorkPhone := IsBlank2Fields(le.WorkPhone, Constants.MISSING_INPUT_DATA,
				cleaned_workphone, Constants.NO_DATA_FOUND);
      SELF.InputCleanSSN := cleaned_SSN;
      SELF.InputCleanDOB := cleaned_DOB.ValidPortion_00; 
      SELF.InputCleanDLNumber := cleaned_DL;  
			SELF.InputCleanDLState := le.DLState;  
	
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