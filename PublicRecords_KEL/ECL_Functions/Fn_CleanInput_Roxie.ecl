IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInput_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) ds_input = DATASET([],PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII)) := 
  FUNCTION
    IsBlank := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank;
    IsBlank2Fields := PublicRecords_KEL.ECL_Functions.SetConstants.IsBlank2Fields;
    Constants := PublicRecords_KEL.ECL_Functions.Constants;     

    PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII GetInputCleaned(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII le, INTEGER C) := transform
		//Input Echo perserved
		SELF.G_ProcUID := le.G_ProcUID;
		SELF.G_ProcBusUID := le.G_ProcBusUID;
		SELF.P_InpAcct := le.P_InpAcct;
		SELF.P_InpLexID := le.P_InpLexID;
		SELF.P_InpNameFirst := le.P_InpNameFirst;
		SELF.P_InpNameMid := le.P_InpNameMid;
		SELF.P_InpNameLast := le.P_InpNameLast;			
		SELF.P_InpAddrLine1 := le.P_InpAddrLine1;
		SELF.P_InpAddrLine2 := le.P_InpAddrLine2;
		SELF.P_InpAddrCity := le.P_InpAddrCity;
		SELF.P_InpAddrState := le.P_InpAddrState; 
		SELF.P_InpAddrZip := le.P_InpAddrZip;
		SELF.P_InpPhoneHome := le.P_InpPhoneHome;
		SELF.P_InpPhoneWork := le.P_InpPhoneWork;
		SELF.P_InpEmail := le.P_InpEmail;
		SELF.P_InpIPAddr := le.P_InpIPAddr; 
		SELF.P_InpArchDt := le.P_InpArchDt;
		SELF.P_InpSSN := le.P_InpSSN;
		SELF.P_InpDOB := le.P_InpDOB;
		SELF.P_InpDL := le.P_InpDL;
		SELF.P_InpDLState := le.P_InpDLState;
		// Clean input
		cleaned_archivedate := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.P_InpArchDt, 
															PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_LOW_ARCHIVEDATE, 
															PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_HIGH_ARCHIVEDATE,
															SetDefault := TRUE /*if no date was input, set to current date/time*/)[1];		
		cleaned_zip       := PublicRecords_KEL.ECL_Functions.Fn_Clean_Zip(le.P_InpAddrZip);
		cleaned_Addr      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Address_Roxie(le.P_InpAddrLine1 + ' ' + le.P_InpAddrLine2, le.P_InpAddrCity, le.P_InpAddrState, cleaned_zip);
		cleaned_DL        := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLNumber(le.P_InpDL);
		cleaned_DLState   := PublicRecords_KEL.ECL_Functions.Fn_Clean_DLState(le.P_InpDLState);   //afa 2019026
		cleaned_email     := PublicRecords_KEL.ECL_Functions.Fn_Clean_Email(le.P_InpEmail);
		cleaned_phone10   := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.P_InpPhoneHome);
		cleaned_workphone := PublicRecords_KEL.ECL_Functions.Fn_Clean_Phone(le.P_InpPhoneWork);
		cleaned_SSN       := PublicRecords_KEL.ECL_Functions.Fn_Clean_SSN(le.P_InpSSN);
		DOB_dates         := PublicRecords_KEL.ECL_Functions.Fn_Clean_Date(le.P_InpDOB, 
															PublicRecords_KEL.ECL_Functions.Constants.VALIDATE_DATE_RANGE_LOW_DEFAULT, 
															(INTEGER)cleaned_archivedate.ValidPortion_01);
		cleaned_DOB       := DOB_dates[1];
		cleaned_name      := PublicRecords_KEL.ECL_Functions.Fn_Clean_Name_Roxie(le.P_InpNameFirst, le.P_InpNameMid, le.P_InpNameLast);
  


		// Cleaned Archive Date
		SELF.P_InpClnArchDt := cleaned_archivedate.ValidPortion_01 + cleaned_archivedate.TimeStamp; 

		NameNotPopulated := IF(le.P_InpNameFirst = '' AND le.P_InpNameMid = '' AND le.P_InpNameLast = '', '', le.P_InpNameLast);
		/*
		// We need to revisit this logic below. InputCleanMiddleName may be populated after
		// cleaning if the input firstname contains both the firstname and the middlename.
		*/
		SELF.P_InpClnNameSffx := cleaned_name.name_suffix;
		SELF.P_InpClnNameFirst := cleaned_name.fname;
		SELF.P_InpClnNameMid := cleaned_name.mname;
		SELF.P_InpClnNameLast := cleaned_name.lname;
		
		surname1:=SELF.P_InpClnNameLast;
		Surname1_filtered :=Std.Str.Find(TRIM(surname1),'-');
		Valid_surname1:=IF(Surname1_filtered =0 ,STD.str.ToUpperCase(surname1[Surname1_filtered+1..]),TRIM(STD.str.ToUpperCase(surname1[1..Surname1_filtered-1]), LEFT, RIGHT));
		Valid_surname2:=IF(Surname1_filtered =0,'',TRIM(STD.str.ToUpperCase(surname1[Surname1_filtered+1..]), LEFT, RIGHT));
		
		SELF.P_InpClnSurname1  := Valid_surname1;
		SELF.P_InpClnSurname2  := Valid_surname2;
		SELF.P_InpClnNamePrfx := cleaned_name.title;
			
		SELF.P_InpClnAddrPrimRng := cleaned_Addr.prim_range;
		SELF.P_InpClnAddrPreDir := cleaned_Addr.predir;
		SELF.P_InpClnAddrPrimName := cleaned_Addr.prim_name;
		SELF.P_InpClnAddrSffx := cleaned_Addr.addr_suffix;
		SELF.P_InpClnAddrPostDir := cleaned_Addr.postdir;
		SELF.P_InpClnAddrUnitDesig := cleaned_Addr.unit_desig;
		SELF.P_InpClnAddrSecRng :=cleaned_Addr.sec_range;
		SELF.P_InpClnAddrCity := cleaned_Addr.v_city_name;
		SELF.P_InpClnAddrCityPost := cleaned_Addr.p_city_name;
		SELF.P_InpClnAddrState := cleaned_Addr.st;
		SELF.P_InpClnAddrZip5 := cleaned_Addr.zip;
		SELF.P_InpClnAddrZip4 := cleaned_Addr.zip4;
		SELF.P_InpClnAddrLat := cleaned_Addr.geo_lat;
		SELF.P_InpClnAddrLng :=	cleaned_Addr.geo_long;
		SELF.P_InpClnAddrType := cleaned_Addr.rec_type;
		SELF.P_InpClnAddrStatus :=	cleaned_Addr.err_stat;
		SELF.P_InpClnAddrStateCode    := cleaned_Addr.county[1..2];
		SELF.P_InpClnAddrCnty := cleaned_Addr.county[3..5];
		SELF.P_InpClnAddrGeo := cleaned_Addr.geo_blk;
		SELF.P_InpClnEmail :=cleaned_email;
		SELF.P_InpClnPhoneHome := cleaned_phone10;
		SELF.P_InpClnPhoneWork := cleaned_workphone;
		SELF.P_InpClnSSN := cleaned_SSN;
		SELF.P_InpClnDOB := cleaned_DOB.ValidPortion_00; 
		SELF.P_InpClnDL := cleaned_DL;  
		SELF.P_InpClnDLState := cleaned_DLState ;  
		SELF.AddressGeoLink := (trim(SELF.P_InpClnAddrStateCode, left, right) + trim(SELF.P_InpClnAddrCnty, left, right) + trim(SELF.P_InpClnAddrGeo, left, right)),

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