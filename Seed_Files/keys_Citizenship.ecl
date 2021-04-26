IMPORT Data_Services, doxie, Risk_Indicators, Seed_Files, STD;

EXPORT keys_Citizenship := MODULE



	SHARED middleName := 'testseed::' + doxie.Version_SuperKey + '::Citizenship::';
	SHARED locateProd := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::' + middleName;


  SHARED GetIndex(seed, fileName) := FUNCTIONMACRO
    newRecord := RECORD
      DATA16 hashvalue := seed_files.Hash_InstantID(STD.Str.ToUpperCase(TRIM(seed.inFirstName)), // fname,
                                                    STD.Str.ToUpperCase(TRIM(seed.inLastName)),  // lname,
                                                    STD.Str.ToUpperCase(TRIM(seed.inSSN)), // ssn,
                                                    Risk_Indicators.nullstring, // fein -- not used in person,
                                                    STD.Str.ToUpperCase(TRIM(seed.inZip5)), // zip,
                                                    STD.Str.ToUpperCase(TRIM(seed.inPhone)), // phone,
                                                    Risk_Indicators.nullstring); // company_name -- not used in person
      seed;
    END;


    newTable := TABLE(seed, newRecord);


    RETURN INDEX(newTable,{inDatasetName, hashvalue}, {newTable}, locateProd + fileName);
  ENDMACRO;







  //==========================================================
  // Attributes Section
  //==========================================================
  EXPORT RiskIndicatorsSection := FUNCTION
    seedFile := Seed_Files.files_Citizenship.Section_RiskIndicators;

    RETURN GetIndex(seedFile, 'RiskIndicators');
  END;


  //==========================================================
  // Input Echo Section
  //==========================================================
  EXPORT InputEchoSection := FUNCTION
    seedFile := Seed_Files.files_Citizenship.Section_InputEcho;

    RETURN GetIndex(seedFile, 'InputEcho');
  END;

END;
