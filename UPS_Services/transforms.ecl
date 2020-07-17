IMPORT BIPV2, ut;
EXPORT transforms := MODULE
  
  EXPORT BIPV2.IDfunctions.rec_SearchInput ConstructBipInput(UPS_Services.SearchParams si) := TRANSFORM
    SELF.company_name := si.NameQueryInputs.CompanyName;
    SELF.prim_range := si.AddrQueryInputs.StreetNumber;
    SELF.prim_name := si.AddrQueryInputs.StreetName;
    SELF.zip5 := si.AddrQueryInputs.Zip5;
    SELF.sec_range := si.AddrQueryInputs.UnitNumber;
    SELF.city := si.AddrQueryInputs.City;
    SELF.state := si.AddrQueryInputs.State;
    SELF.phone10 := si.PhoneQueryInput;
    SELF.contact_fname := si.NameQueryInputs.first;
    SELF.contact_mname := si.NameQueryInputs.middle;
    SELF.contact_lname := si.NameQueryInputs.last;
    SELF.acctno := '1';
    SELF.results_limit := 0;
    SELF.allow7digitmatch := FALSE;
    SELF :=[];
  END;
  

  EXPORT BIPV2.IDfunctions.rec_SearchInput adjustSearchInput(BIPV2.IDfunctions.rec_SearchInput l, BOOLEAN isAlternameSearch,STRING inName, STRING inphone) :=
    TRANSFORM
        SELF.company_name := IF(isAlternameSearch,ut.mod_AmpersandTools.createAlternativeName(inName) ,inName );
        SELF.phone10 := IF(isAlternameSearch,l.phone10 ,inPhone );
        SELF.hsort := FALSE;
        SELF := l;
    END;

  
END;
