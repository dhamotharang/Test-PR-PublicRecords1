IMPORT doxie;

EXPORT IParam := MODULE

  EXPORT wildcardParams := INTERFACE (doxie.IDataAccess)
    EXPORT STRING            LicensePlateNum := '';
    EXPORT STRING            vin_in := '';
    EXPORT STRING6           Zip := '';
    EXPORT BOOLEAN           UseTagBlur := FALSE;
    EXPORT BOOLEAN           containsSearch := FALSE;
    EXPORT INTEGER           currentYear := 0;
    EXPORT INTEGER           ageRangeStart := 0;
    EXPORT INTEGER           ageRangeEnd := 0;
    EXPORT INTEGER           modelYearStart := 0;
    EXPORT INTEGER           modelYearEnd := 0;
    EXPORT STRING1           gender := '';
    EXPORT STRING30          County := '';
    EXPORT STRING2           State := '';
    EXPORT SET OF UNSIGNED1  stateCodes := [];
    EXPORT STRING2           regState := '';
    EXPORT UNSIGNED1         regStateCode := 0;
    EXPORT SET OF STRING4    Makes := [];
    EXPORT SET OF UNSIGNED2  makeCodes := [];
    EXPORT SET OF UNSIGNED3  zipCodes := [];
    EXPORT SET OF STRING36   Models := [];
    EXPORT SET OF UNSIGNED2  modelCodes := [];
    EXPORT SET OF STRING36   Bodys := [];
    EXPORT SET OF UNSIGNED2  bodyCodes := [];
    EXPORT SET OF STRING3    majorColors := [];
    EXPORT SET OF UNSIGNED1  majorColorCodes := [];
    EXPORT UNSIGNED8         MaxResultsVal := 2000;
    EXPORT STRING30          FirstName := '';
    EXPORT STRING30          MiddleName := '';
    EXPORT STRING30          LastName := '';
    EXPORT UNSIGNED1         RegistrationType := 0;
    EXPORT SET OF STRING1    RegistrationTypeAllow := [];
    EXPORT BOOLEAN           IncludeCriminalIndicators := FALSE;
    EXPORT BOOLEAN           IncludeNonRegulatedSources := FALSE;
  END;

END;
