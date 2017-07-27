IMPORT TAXPRO, standard, ut;

EXPORT layouts := MODULE

  EXPORT id := RECORD
    string10 tmsid;
    string30 acctno := ''; //for batch purposes
  END;

  EXPORT search_ids := RECORD (id)
    boolean isDeepDive := false;
  END;

  shared AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
    // those are copies rfom vendors' addresses, not cleaned!
    // string7  FOREIGN_ZIP;
    // string35 FOREIGN_COUNTRY_NAME;
  end;

	EXPORT Layout_Common := record 
    unsigned2 penalt := 0; // not calculated in report
//    string10 tmsid;
    TAXPRO.Layout.Taxpro_Standard_Base AND NOT [name, addr];

    //cleaned fields
    AddressTranslated address;
    boolean is_foreign;
    standard.Name name;
  end;
  
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

