IMPORT ebr_services;

EXPORT layout := MODULE

  EXPORT request := RECORD
    string dppapurpose;
    string glbpurpose;
    string bdid;
    string filenumber;
  END;

  EXPORT response := RECORD
    ebr_services.Layout_EBR_Report;
  END;

END;
