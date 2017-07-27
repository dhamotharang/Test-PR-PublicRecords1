IMPORT CALBUS, standard, ut;

EXPORT layouts := MODULE

  EXPORT id := RECORD
    string13 account_number;
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

	EXPORT Layout_Common := record // change when layouts will containe named address portions
    unsigned2 penalt := 0; // not calculated in report
    unsigned6 bdid;
    string8   Process_date;
	  string8   dt_first_seen;
	  string8   dt_last_seen;
	  calbus.layouts_calbus.layout_raw;
	  string45  Tax_code_full_desc;
	  string100 Industry_code_desc;
	  string40  County_code_desc;
	  string40  Ownership_code_desc;
      //Business clean address
    AddressTranslated business;
    AddressTranslated mailing;
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
    // DATASET (Accident) accidents {MAXCOUNT (ACCIDENT_MAX)}; // from other key
  END; 

  // most complete and close to original
  EXPORT DataOutput := RECORD (Layout_Common)
  END; 

END;

