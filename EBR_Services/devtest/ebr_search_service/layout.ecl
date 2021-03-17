IMPORT ebr_services;

EXPORT layout := MODULE

  EXPORT request := RECORD
    string BDID;
    string CompanyName;
    string Addr;
    string City;
    string State;
    string Zip;
    string County;
    string Phone;
    string DPPAPurpose;
    string GLBPurpose;
    string DataRestrictionMask;
    string DataPermissionMask;
    string MaxResults;
    string MaxResultsThisTime;
  END;

  EXPORT response := RECORD
    boolean isdeepdive;
    ebr_services.Layout_EBR_Search;
  END;

END;
