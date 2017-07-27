IMPORT infoUSA, standard, ut;

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

  EXPORT ContactTranslated := RECORD (standard.Name)
    InfoUSA.Layout_Key_ABius_ABI_Number.GENDER_CD;
    string7  gender_exp;
    InfoUSA.Layout_Key_ABius_ABI_Number.CONTACT_TITLE;
    string35 title_description;
  END;

  shared Appended := RECORD
    DATASET (ContactTranslated) contact {MAXCOUNT (ut.limits.USABIZ_CONTACTS_MAX)};
    AddressTranslated addr1;
    AddressTranslated addr2;
  end;

  shared Base := RECORD  //
    InfoUSA.Layout_Key_ABius_ABI_Number AND NOT [name, addr1, addr2];
    Appended;
  end; 
  // ---------------------------------------

  shared Slimmed := RECORD
    // secondary SICs will be presented in child table
    Base AND NOT [SECONDARY_SIC_1, SECONDARY_SIC_2, SECONDARY_SIC_3, SECONDARY_SIC_4,
                  secondary_sic_desc1, secondary_sic_desc2, secondary_sic_desc3, secondary_sic_desc4,
                  // contacts will be rolled up into child dataset
		              CONTACT_NAME, CONTACT_LNAME, CONTACT_FNAME, CONTACT_PROF_TITLE, CONTACT_TITLE, GENDER_CD];
		   // FILLER1;
		   // FILLER2;
  end;

  // to hold SICs description
  EXPORT layout_secondary_sic := RECORD
    string6 code := '';
    string50 description := '';
  END;

  EXPORT layout_franchise := RECORD
    string42 description := '';
  END;

  // this is shared between Embedded and Search layout (this is InfoUSA.Layout_DEADCO_Clean_In)
  EXPORT ReportSearchShared := RECORD 
    // NB: penalty is a minimum among penalties calculated using "unpacked" contact child dataset (l-, f-names are there).
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

  // most complete and close to original: SOURCE service (generally, infoUSA.Layout_ABIUS_Company_Base)
  EXPORT DataOutput := RECORD
    InfoUSA.Layout_Key_ABius_ABI_Number;
  END; 

END;
