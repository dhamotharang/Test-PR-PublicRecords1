import FLAccidents_eCrash, iesp, Accident_services;
  
export Layouts := MODULE

  export report := record
    string40 accident_nbr;
    string2 report_code;
    string2 vehicle_incident_st;
  end;

  export search := record
    string40 accident_nbr;
    boolean isDeepDive := false;
  end;

  export search_did := record
    unsigned6 did;
    boolean isDeepDive := false;
  end;

  export search_bdid := record
    unsigned6 bdid;
    boolean isDeepDive := false;
  end;
  
  export search_dlnbr := record
    string15 dlnbr;
    boolean isDeepDive := false;
  end;
  
  export search_tagnbr := record
    string8 tagnbr;
    boolean isDeepDive := false;
  end;
  
  export search_vin := record
    string22 vin;
    boolean isDeepDive := false;
  end;

  export raw_accnbr := record
    search;
    recordof(FLAccidents_eCrash.key_eCrashV2_accnbrV1);
  end;
  
  export raw_rec := record
    recordof(FLAccidents_eCrash.Key_eCrashV2_AccNbrV1);
    boolean isDeepDive := false;
    unsigned2 penalt := 0;
  end;

  EXPORT accVehRecWithAccNbr := RECORD
    report;
    iesp.accident.t_AccidentReportVehicle;
  END;

  EXPORT accRptRecWithAccNbr := RECORD
    report;
    iesp.accident.t_AccidentReportRecord;
  END;

  EXPORT AccidentInputRequired := RECORD
    INTEGER Bitmap;
  END;
      
  EXPORT AccidentStateRestrictionReportRecord := RECORD
    STRING32 ApplicationType;
    STRING2 AccidentState;
    STRING1 Allowed;
    BOOLEAN InquiryDataAllowed;
    BOOLEAN Aknowledgement;
    BOOLEAN ResaleAllowed;
    INTEGER RestrictedOutputBitmap;
    DATASET(AccidentInputRequired) RequiredInputs {MAXCOUNT(Accident_services.Constants.MAX_REQUIRED_INPUTS)};
  END;

end;
