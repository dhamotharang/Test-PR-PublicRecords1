import business_header,ut;

dSicLookup := files().SicLookup.built;

export Key_Sic_Description := index(dSicLookup, 
                                       {sic_code},
                                       {sic_description},
                                       keynames().SicCodeDesc.qa);