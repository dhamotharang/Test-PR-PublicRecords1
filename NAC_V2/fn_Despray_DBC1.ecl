
IMPORT NAC_V2, NAC, STD;


EXPORT fn_despray_dbc1 (DATASET(NAC.Layouts.Collisions) ds_NAC_collissions) := FUNCTION


 NAC.Layouts.DBC xformtoNAC1DBC(NAC.Layouts.Collisions  l) := TRANSFORM
    SELF.ActivityType := l.ActivityType;
    SELF.BuildVersion := l.BuildVersion;
    SELF.BenefitState := l.BenefitState;
    SELF.SearchCaseID := l.SearchCaseID;
    SELF.SearchClientID := l.SearchClientID;
    SELF.SearchBenefitType := l.SearchBenefitType;
    SELF.SearchBenefitMonth := l.SearchBenefitMonth;
    SELF.SearchLastName := l.SearchLastName;
    SELF.SearchFirstName := l.SearchFirstName;
    SELF.SearchMiddleName := l.SearchMiddleName;
    SELF.SearchSSN := l.SearchSSN;
    SELF.SearchDOB := l.SearchDOB;
    SELF.SearchAddress1StreetAddress1 := l.SearchAddress1StreetAddress1;
    SELF.SearchAddress1StreetAddress2 := l.SearchAddress1StreetAddress2;
    SELF.SearchAddress1City := l.SearchAddress1City;
    SELF.SearchAddress1State := l.SearchAddress1State;
    SELF.SearchAddress1Zip := l.SearchAddress1Zip;
    SELF.SearchAddress2StreetAddress1 := l.SearchAddress2StreetAddress1;
    SELF.SearchAddress2StreetAddress2 := l.SearchAddress2StreetAddress2;
    SELF.SearchAddress2City := l.SearchAddress2City;
    SELF.SearchAddress2State := l.SearchAddress2State;
    SELF.SearchAddress2Zip := l.SearchAddress2Zip;
    SELF.CaseState := l.CaseState;
    SELF.CaseBenefitType := l.CaseBenefitType;
    SELF.CaseBenefitMonth := l.CaseBenefitMonth;
    SELF.CaseID := l.CaseID;
    SELF.CaseLastName := l.CaseLastName;
    SELF.CaseFirstName := l.CaseFirstName;
    SELF.CaseMiddleName := l.CaseMiddleName;
    SELF.CasePhone1 := l.CasePhone1;
    SELF.CasePhone2 := l.CasePhone2;
    SELF.CaseEmail := l.CaseEmail;
    SELF.CasePhysicalStreet1 := l.CasePhysicalStreet1;
    SELF.CasePhysicalStreet2 := l.CasePhysicalStreet2;
    SELF.CasePhysicalCity := l.CasePhysicalCity;
    SELF.CasePhysicalState := l.CasePhysicalState;
    SELF.CasePhysicalZip := l.CasePhysicalZip;
    SELF.casemailstreet1 := l.CaseMailStreet1;
    SELF.CaseMailStreet2 := l.CaseMailStreet2;
    SELF.CaseMailCity := l.CaseMailCity;
    SELF.CaseMailState := l.CaseMailState;
    SELF.CaseMailZip := l.CaseMailZip;
    SELF.CaseCountyParishCode := l.CaseCountyParishCode;
    SELF.CaseCountyParishName := l.CaseCountyParishName;
    SELF.ClientID := l.ClientID;
    SELF.ClientLastName := l.ClientLastName;
    SELF.ClientFirstName := l.ClientFirstName;
    SELF.ClientMiddleName := l.ClientMiddleName;
    SELF.ClientGender := l.ClientGender;
    SELF.ClientRace := l.ClientRace;
    SELF.ClientEthnicity := l.ClientEthnicity;
    SELF.ClientSSN := l.ClientSSN;
    SELF.ClientSSNType := l.ClientSSNType;
    SELF.ClientDOB := l.ClientDOB;
    SELF.ClientDOBType := l.ClientDOBType;
    SELF.ClientEligibilityStatus := l.ClientEligibilityStatus;
    SELF.ClientEligibilityDate := l.ClientEligibilityDate;
    SELF.ClientPhone := l.ClientPhone;
    SELF.ClientEmail := l.ClientEmail;
    SELF.StateContactName := l.StateContactName;
    SELF.StateContactPhone := l.StateContactPhone;
    SELF.StateContactPhoneExtension := l.StateContactPhoneExtension;
    SELF.StateContactEmail := l.StateContactEmail;
    SELF.LexIdScore := l.LexIdScore;
    SELF.MatchCodes := l.MatchCodes;
    SELF.SequenceNumber := l.SearchSequenceNumber;
    SELF.LF := '\n';
END;


    despray_dbc_nac1_file := FUNCTION	 
        suffix := STD.Str.FindReplace(workunit[2..16], '-', '_');
        dbcFname := '~nac::v2::xx_dbc_' + suffix;
        dbc := PROJECT(ds_NAC_collissions , xformtoNAC1DBC(LEFT));
        writethorfile := OUTPUT(dbc, , dbcFname, COMPRESSED, OVERWRITE);
        desprayfilename:='xx_dbc_' + suffix;  
        //  destinationfolder := '/data/hds_180/nac/drupal/';
        destinationfolder := NAC_V2.Constants.LandingZonePathBase + '/test/';       
        pDestinationFile := destinationfolder + trim(desprayfilename) + '.dat';          
        despray := FileServices.Despray(dbcFname, NAC_V2.Constants.LandingZoneServer, pDestinationFile,,,,TRUE);
        RETURN SEQUENTIAL(writethorfile, despray); 
    END;

    RETURN despray_dbc_nac1_file; 
END;



