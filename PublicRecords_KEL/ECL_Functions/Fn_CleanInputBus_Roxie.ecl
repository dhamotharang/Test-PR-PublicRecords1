IMPORT PublicRecords_KEL, STD;

EXPORT Fn_CleanInputBus_Roxie( DATASET(PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout) ds_input) := FUNCTION

    PublicRecords_KEL.ECL_Functions.Input_ALL_Bus_Layout GetInputCleaned( RECORDOF(ds_input) le ) := 
      TRANSFORM
        SELF.InputID := le.InputID; 
				
				SELF.Account := le.AccountNumber;
				SELF.FirstName := le.Rep1firstname;
				SELF.Rep1MiddleName := le.MiddleName;
				SELF.LastName := le.Rep1lastname;
				SELF.StreetAddress := le.Rep1Addr;
				SELF.City := le.Rep1City;
				SELF.State := le.Rep1State;
				SELF.Zip := le.Rep1Zip;
				SELF.HomePhone := le.Rep1HomePhone;
				SELF.SSN := le.Rep1SSN;
				SELF.DateOfBirth := le.Rep1DOB;
				SELF.DLNumber := le.Rep1DLNumber;
				SELF.DLState := le.Rep1DLState; 
				SELF.FormerName := le.Rep1FormerLastName ;
				SELF.EMAIL := le.Rep1EmailAddress; 
				SELF.LexID := le.Rep1LexID; 
				SELF.HistoryDate := le.ArchiveDate;
				SELF := le;
        SELF := [];
      END;

      cleanInput := PROJECT(ds_input, GetInputCleaned(LEFT));
          
      RETURN cleanInput;

    END;