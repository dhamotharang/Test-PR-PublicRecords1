IMPORT Data_Services, doxie, Risk_Indicators, Seed_Files, STD;

EXPORT keys_DueDiligenceBusinessReport := MODULE



	SHARED middleName := 'testseed::' + doxie.Version_SuperKey + '::DueDiligenceBusinessReport::';
	SHARED locateProd := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::' + middleName;


  SHARED GetIndex(seed, fileName) := FUNCTIONMACRO
    newRecord := RECORD
      DATA16 hashvalue := seed_files.Hash_InstantID(Risk_Indicators.nullstring, //fname -- not used in business,
                                                    Risk_Indicators.nullstring, //lname -- not used in business,
                                                    Risk_Indicators.nullstring, //ssn -- not used in business,
                                                    STD.Str.ToUpperCase(TRIM(seed.inFEIN)), //fein,
                                                    STD.Str.ToUpperCase(TRIM(seed.inZip5)), //zip,
                                                    STD.Str.ToUpperCase(TRIM(seed.inPhone)), //phone,
                                                    STD.Str.ToUpperCase(TRIM(seed.inCompanyName))); //company_name
      seed;
    END;


    newTable := TABLE(seed, newRecord);


    RETURN INDEX(newTable,{inDatasetName, hashvalue}, {newTable}, locateProd + fileName);
  ENDMACRO;







  //==========================================================
  // Attributes Section
  //==========================================================
  EXPORT AttributesSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligenceBusinessReport.Section_Attributes;

    RETURN GetIndex(seedFile, 'Attributes');
  END;


  //==========================================================
  // Input Echo Section
  //==========================================================
  EXPORT InputEchoSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligenceBusinessReport.Section_InputEcho;

    RETURN GetIndex(seedFile, 'InputEcho');
  END;

END;
