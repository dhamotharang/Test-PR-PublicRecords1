IMPORT SANCTN, standard;


EXPORT layouts := module
	
  // With the release of the Midex project, the existing key was renamed to: SANCTN.layout_SANCTN_party_clean_orig
  // and the existing key name used in this service now has two additional fields.  
  EXPORT layoutSanctnClean :=
    RECORD
      SANCTN.layout_SANCTN_party_clean_orig;
      unsigned4 global_sid;
      unsigned8 record_sid;
      unsigned6 DID;
    END;
  
  EXPORT layoutSanctnCleanPlusIsSupp :=
    RECORD
      layoutSanctnClean;
      boolean is_suppressed;
    END;
    
  EXPORT id := RECORD
    string8 batch_number;
		string8 incident_number;
    string30 acctno := ''; //for (our) batch purposes
  END;
  
  EXPORT search_ids := RECORD (id)
    // boolean isDeepDive := false;
  END;

  shared AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
  end;

  // those 2 layouts, generally, inherit from layout_SANCTN_party_clean
  EXPORT PartyInfo := RECORD
    unsigned2 ORDER_NUMBER;
    string party_text {MAXLENGTH (16000)};
  END;
 
 EXPORT rec_party := record
    unsigned1 penalt;
    SANCTN.layout_SANCTN_party_in AND NOT [RECORD_TYPE, ORDER_NUMBER];
    DATASET (PartyInfo) info {MAXCOUNT (1)}; // =1 by usage; probably, a design defect
    standard.Name name;
    string45 cname := '';
    AddressTranslated address;
    BOOLEAN is_suppressed;
  end;
  
  // this may be redundant, but I want the output to be same as before
  EXPORT Party := RECORD
    rec_party and not [penalt, BATCH_NUMBER, INCIDENT_NUMBER];
  END;

  // those 2 layouts, generally, inherit from SANCTN.layout_SANCTN_incident_in
  EXPORT IncidentInfo := RECORD
    unsigned2 ORDER_NUMBER;
    string incident_text {MAXLENGTH (SANCTN_Services.Constants.incident_text_length)};
  END;

  EXPORT Incident := RECORD 
    STRING8  BATCH_NUMBER;
    STRING8  INCIDENT_NUMBER;
    STRING8  AG_CODE;
    STRING20 CASE_NUMBER;
    STRING8  INCIDENT_DATE;
    STRING90 JURISDICTION;
    STRING70 SOURCE_DOCUMENT;
    STRING70 ADDITIONAL_INFO;
    STRING70 AGENCY;
    DATASET (IncidentInfo) info {MAXCOUNT (Constants.TEXT_PER_INCIDENT)};
    STRING10 ALLEGED_AMOUNT;
    STRING10 ESTIMATED_LOSS;
    STRING10 FCR_DATE;
    STRING1  OK_FOR_FCR;
  	string8 incident_date_clean := '';
    string8 fcr_date_clean := '';
    BOOLEAN is_suppressed;
  END;

  // Complete stand-alone SOURCE/REPORT service
  EXPORT SourceOutput := RECORD
    unsigned1 penalt := 0;
    Incident;
    DATASET (Party) parties {MAXCOUNT (Constants.PARTY_PER_INCIDENT)};
  END; 

  EXPORT SearchOutput := RECORD  (SourceOutput)
  END;

  // SUBREPORT (as part of CRS, for instanse) //so far is same as SearchOutput, but shall be different
  EXPORT EmbeddedOutput := RECORD (SearchOutput)
  END; 

  // most complete and close to original: SOURCE service (generally, infoUSA.Layout_ABIUS_Company_Base)
  EXPORT DataOutput := RECORD (SearchOutput)
  END; 

END;

