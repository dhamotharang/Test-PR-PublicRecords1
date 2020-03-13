IMPORT iesp, Std;

EXPORT fn_getSearchInput(iesp.homestead_exemption_search.t_HomesteadExemptionSearchBy srchBy) := FUNCTION

  // convert ESDL search by inputs to batch input layout
  HomesteadExemptionV2_Services.Layouts.inputRec setOwners(iesp.homestead_exemption_search.t_HEOwner L,INTEGER cnt) := TRANSFORM
    SELF.acctno      := IF(cnt<=iesp.Constants.hmstdExmptn.MAX_OWNERS,(STRING)cnt,SKIP);
    // decimal 32 is ASCII blank, cnt+95, decimal 97 is ASCII lowercase 'a', values 1, 1a, 1b, 1c
    SELF.clientid    := TRIM('1'+TRANSFER(IF(cnt=1,32,cnt+95),STRING1));
    SELF.name_full   := L.Name.Full;
    SELF.name_first  := L.Name.First;
    SELF.name_middle := L.Name.Middle;
    SELF.name_last   := L.Name.Last;
    SELF.name_suffix := L.Name.Suffix;
    SELF.SSN         := Std.Str.Filter(L.SSN,'0123456789');
    DOB:=iesp.ECL2ESP.DateToString(L.DOB);
    SELF.DOB         := IF((UNSIGNED)DOB=0,'',DOB);
    SELF.addr        := L.Address.StreetAddress1+' '+L.Address.StreetAddress2;
    SELF.prim_range  := L.Address.StreetNumber;
    SELF.predir      := L.Address.StreetPreDirection;
    SELF.prim_name   := L.Address.StreetName;
    SELF.addr_suffix := L.Address.StreetSuffix;
    SELF.postdir     := L.Address.StreetPostDirection;
    SELF.unit_desig  := L.Address.UnitDesignation;
    SELF.sec_range   := L.Address.UnitNumber;
    SELF.p_city_name := L.Address.City;
    SELF.st          := L.Address.State;
    SELF.z5          := L.Address.Zip5;
    SELF.zip4        := L.Address.Zip4;
    SELF.county_name := L.Address.County;
    currentYear:=(STRING)Std.Date.Year(Std.Date.Today());
    SELF.tax_year    := IF(srchBy.TaxYear='',currentYear,srchBy.TaxYear);
    SELF.tax_state   := IF(srchBy.TaxState='',L.Address.State,srchBy.TaxState);
  END;

  RETURN PROJECT(srchBy.Owners,setOwners(LEFT,COUNTER));
END;
