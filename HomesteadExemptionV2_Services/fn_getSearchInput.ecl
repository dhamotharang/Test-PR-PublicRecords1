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
    SELF.addr        := srchBy.Address.StreetAddress1+' '+srchBy.Address.StreetAddress2;
    SELF.prim_range  := srchBy.Address.StreetNumber;
    SELF.predir      := srchBy.Address.StreetPreDirection;
    SELF.prim_name   := srchBy.Address.StreetName;
    SELF.addr_suffix := srchBy.Address.StreetSuffix;
    SELF.postdir     := srchBy.Address.StreetPostDirection;
    SELF.unit_desig  := srchBy.Address.UnitDesignation;
    SELF.sec_range   := srchBy.Address.UnitNumber;
    SELF.p_city_name := srchBy.Address.City;
    SELF.st          := srchBy.Address.State;
    SELF.z5          := srchBy.Address.Zip5;
    SELF.zip4        := srchBy.Address.Zip4;
    SELF.county_name := srchBy.Address.County;
    currentYear:=(STRING)Std.Date.Year(Std.Date.Today());
    SELF.tax_year    := IF(srchBy.TaxYear='',currentYear,srchBy.TaxYear);
    SELF.tax_state   := IF(srchBy.TaxState='',srchBy.Address.State,srchBy.TaxState);
  END;

  RETURN PROJECT(srchBy.Owners,setOwners(LEFT,COUNTER));
END;
