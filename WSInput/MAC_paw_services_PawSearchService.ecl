EXPORT MAC_paw_services_PawSearchService := MACRO

  #WEBSERVICE(FIELDS(

    /*---- COMPLIANCE SEETINGS ----*/
    'DPPAPurpose',
    'GLBPurpose',
    'DataRestrictionMask',

    /*---- Search By ID NUMBERS ----*/
    'ContactID',
    'DID',
    'BDID',
    'SELEID',

    /*---- AUTOKEY SEARCH FIELDS ----*/
    'SSN',
    'FirstName',
    'MiddleName',
    'LastName',
    'FEIN',
    'CompanyName',
    'Addr',
    'City',
    'State',
    'Zip',
    'Phone',

    /*---- AUTOKEY OPTIONS ----*/
    'AllowNickNames',
    'PhoneticMatch',
    'ZipRadius',

    /*---- ROLLUP OPTIONS ----*/
    'ECL_NegateTrueDefaults',
    'ReqAddrsPerEmployer',
    'ReqCompanyNamesPerEmployer',
    'ReqDatesPerEmployer',
    'ReqDatesPerPosition',
    'ReqEmployersPerPerson',
    'ReqFeinsPerEmployer',
    'ReqNamesPerPerson',
    'ReqPhonesPerAddr',
    'ReqPositionsPerEmployer',
    'ReqSsnsPerPerson',
    'ReturnAlsoFound',

    /*---- ADDITIONAL OPTIONS ----*/
    'PenaltThreshold',
    'SSNMask',
    'NoDeepDive',
    'IncludeCriminalIndicators',

    /*---- RESULTS LIST MANAGEMENT ----*/
    'MaxResults',
    'MaxResultsThisTime',
    'SkipRecords'
  ));

ENDMACRO;
