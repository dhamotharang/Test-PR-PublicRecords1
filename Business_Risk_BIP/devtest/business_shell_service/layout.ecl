IMPORT Business_Risk_BIP;

//non-ESDL input/output
EXPORT layout := MODULE

  SHARED permissions := RECORD
    unsigned1 dppa_purpose;
    unsigned1 glba_purpose;
    string50 data_permission_mask;
    string50 data_restriction_mask;
    string industryclass;
    unsigned1 marketingmode;
  END;

  EXPORT request := RECORD (permissions)
    Business_Risk_BIP.Layouts.Input;
    //If need, add CorteraRetrotestRecords, Wathlist, etc. inputs here
  END;

  EXPORT response := Business_Risk_BIP.Layouts.OutputLayout;

END;
