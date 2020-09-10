IMPORT TAXPRO, standard, ut;

EXPORT layouts := MODULE

  EXPORT id := RECORD
    STRING10 tmsid;
    STRING30 acctno := ''; //for batch purposes
  END;

  EXPORT search_ids := RECORD (id)
    BOOLEAN isDeepDive := FALSE;
  END;

  SHARED AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
    // those are copies rfom vendors' addresses, not cleaned!
    // string7 FOREIGN_ZIP;
    // string35 FOREIGN_COUNTRY_NAME;
  END;

  EXPORT Layout_Common := RECORD
    UNSIGNED2 penalt := 0; // NOT calculated in report
// string10 tmsid;
    TAXPRO.Layout.Taxpro_Standard_Base AND NOT [name, addr];

    //cleaned fields
    AddressTranslated address;
    BOOLEAN is_foreign;
    standard.Name name;
  END;
  
  // Full layout is relatively small, so there will be same output layout for all services

  // output for SEARCH service
  EXPORT SearchOutput := RECORD (Layout_Common)
  END;

  // SUBREPORT (as part of CRS, for instanse)
  EXPORT EmbeddedOutput := RECORD (Layout_Common)
  END;

  EXPORT SourceOutput := RECORD (Layout_Common)
  END;

  // most complete and close to original
  EXPORT DataOutput := RECORD (Layout_Common)
  END;

END;

