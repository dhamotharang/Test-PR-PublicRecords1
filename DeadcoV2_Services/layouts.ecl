IMPORT infoUSA, standard;

EXPORT layouts := MODULE

  EXPORT id := RECORD
    string9 abi_number;
    string30 acctno := ''; //for batch purposes
  END;

  EXPORT search_ids := RECORD (id)
    boolean isDeepDive := false;
  END;

  shared AddressTranslated := RECORD
    standard.L_Address.base;
    standard.L_Address.translated;
  end;

  SHARED Appended := RECORD
    string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
    standard.Name name;
    string7  gender_exp;
    AddressTranslated addr;
  END;

  SHARED Clean_In := RECORD   //should be same as InfoUSA.Layout_DEADCO_Clean_In 
    infoUSA.Layout_DEADCO_In;
    Appended;
  END;

  // description of encoded fields
  SHARED Translation := RECORD
    string15 AD_SIZE;
    string20 POPULATION;
    string20 EMPLOYEE_SIZE;
    string30 SALES_VOLUME;
    string40 INDUSTRY_desc;
    string12 BUSINESS_STATUS;
    string10 OFFICE_SIZE;
    string12 TOTAL_EMPLOYEE_SIZE;
    string30 TOTAL_OUTPUT_SALES;
    string5  STOCK_EXCHANGE;
    string27 CREDIT_DESC;
    string10 INDIVIDUAL_FIRM;
//    string42 Franchise_desc;
    string50 sic_desc;
    // string50 secondary_sic_desc1;  //do not need those, will fold into child dataset
    // string50 secondary_sic_desc2;
    // string50 secondary_sic_desc3;
    // string50 secondary_sic_desc4;
  END;

  SHARED Base := RECORD  //should be same as InfoUSA.Layout_deadco_Base
    unsigned6 bdid :=0;
//    qstring34 vendor_id;
    Clean_In;
    Translation;
  END; 
  // ---------------------------------------

  // secondary SICs will be presented in child table
  SHARED Slimmed := RECORD
    Base AND NOT [SECONDARY_SIC_1, SECONDARY_SIC_2, SECONDARY_SIC_3, SECONDARY_SIC_4]; 
  END;

  // to hold SICs description
  EXPORT layout_secondary_sic := RECORD
    string6 code := '';
    string50 description := '';
  END;

  // to hold the franchise descriptions
  EXPORT layout_franchise := RECORD
    string42 description := '';
  END;

  // this is shared between Embedded and Search layout (this is InfoUSA.Layout_DEADCO_Clean_In)
  EXPORT ReportSearchShared := RECORD 
    unsigned2 penalt := 0;
    Slimmed;  // includes infoUSA.Layout_DEADCO_In + Appended
    DATASET (layout_secondary_sic) SECONDARY_SIC {MAXCOUNT(4)};
    DATASET (layout_franchise) franchise {MAXCOUNT(6)};
  END; 

  // output for SEARCH service 
  EXPORT SearchOutput := RECORD (ReportSearchShared)
  END; 

  // Complete stand-alone SOURCE/REPORT service
  EXPORT SourceOutput := RECORD (ReportSearchShared)
  END; 

  // SUBREPORT (as part of CRS, for instanse) //so far is same as SearchOutput, but shall be different
  EXPORT EmbeddedOutput := RECORD (ReportSearchShared)
  END; 

  // most complete and close to original: SOURCE service (generally, about same as InfoUSA.Layout_deadco_Base)
  EXPORT DataOutput := RECORD (Base) 
  END; 

END;
