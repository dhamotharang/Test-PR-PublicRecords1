IMPORT Address, doxie, Advo, Address_Services, iesp, dx_header, Suppress;

EXPORT SearchRecords(dataset(iesp.addresssearch.t_AddressSearchBy) in_ds, Doxie.IDataAccess mod_access) := FUNCTION
    
  Address_Services.Layouts.clean_rec cleanInput(in_ds Le) := transform
    L := Le.Address;
    boolean is_cleanable := ((l.City !='') and (l.State != '')) or (l.Zip5 != '');
    addr_1 := Address.Addr1FromComponents(l.StreetNumber, l.StreetPreDirection, l.StreetName,
                                                 l.StreetSuffix, l.StreetPostDirection,
                                                 l.UnitDesignation, l.UnitNumber);
    addr_2 := Address.Addr2FromComponents(l.City, l.State, l.Zip5);
    addr_line_1 := if (addr_1 = '', l.StreetAddress1, addr_1);
    clean_addr := address.GetCleanAddress(addr_line_1,addr_2,address.Components.country.US);
    ca := clean_addr.results;
    self.prim_range := if (is_cleanable, ca.prim_range, l.StreetNumber);
    self.prim_name := if (is_cleanable, ca.prim_name, l.StreetName);
    self.sec_range := if (is_cleanable, ca.sec_range, l.UnitNumber);
    self.addr_suffix := if (is_cleanable, ca.suffix, l.StreetSuffix);
    self.predir := if (is_cleanable, ca.predir, l.StreetPreDirection);
    self.postdir := if (is_cleanable, ca.postdir, l.StreetPostDirection);
    self.unit_desig := if (is_cleanable, ca.unit_desig, l.UnitDesignation);
    self.p_city_name := if (is_cleanable, ca.p_city, l.City);
    self.zip := if (is_cleanable, ca.zip, l.Zip5);
    self.st := if (is_cleanable, ca.state, l.State);
  end;
  clean_in := PROJECT(in_ds, cleanInput(LEFT));
  
  pre_header_addr := JOIN(clean_in, dx_header.key_header_address(),
    KEYED(LEFT.prim_name = RIGHT.prim_name) AND
    KEYED(LEFT.zip = RIGHT.zip) AND
    KEYED(LEFT.prim_range = RIGHT.prim_range) AND
    KEYED(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range),
    TRANSFORM(RIGHT),
    LIMIT(0), KEEP(Address_Services.Constants.MAX_HEADER_ADDR));
  
  pre_header_addr_suppressed := Suppress.MAC_SuppressSource(pre_header_addr, mod_access);

  header_addr_filt := doxie.compliance.MAC_FilterSources(pre_header_addr_suppressed, src, mod_access.DataRestrictionMask);
  
  header_addr := project(header_addr_filt,
    TRANSFORM(Address_Services.Layouts.int_rec,
      SELF := LEFT,
      SELF.p_city_name := LEFT.city_name,
      SELF.addr_suffix := LEFT.suffix,
      SELF.valid := FALSE));
  header_recs := dedup(sort(header_addr, prim_range, prim_name, addr_suffix, sec_range, zip), prim_range, prim_name, addr_suffix, sec_range, zip);
  
  advo_zip := join(clean_in, Advo.Key_Addr1,
    KEYED(LEFT.zip != '' AND LEFT.zip = RIGHT.zip) AND
    KEYED(LEFT.prim_range = RIGHT.prim_range) AND
    KEYED(LEFT.prim_name = RIGHT.prim_name) AND
    KEYED(LEFT.addr_suffix = RIGHT.addr_suffix) AND
    KEYED(LEFT.predir = RIGHT.predir) AND
    KEYED(LEFT.postdir = RIGHT.postdir) AND
    KEYED(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range),
    TRANSFORM(Address_Services.Layouts.int_rec,
      SELF := RIGHT,
      SELF.valid := TRUE),
    LIMIT(0), KEEP(Address_Services.Constants.MAX_ADVO_ADDR));

  advo_city_state := join(clean_in, Advo.Key_Addr2,
    KEYED(LEFT.zip = '' AND LEFT.st != '' AND LEFT.p_city_name != '' AND LEFT.st = RIGHT.st) AND
    KEYED(LEFT.p_city_name = RIGHT.v_city_name) AND
    KEYED(LEFT.prim_range = RIGHT.prim_range) AND
    KEYED(LEFT.prim_name = RIGHT.prim_name) AND
    KEYED(LEFT.sec_range = '' or LEFT.sec_range = RIGHT.sec_range),
    TRANSFORM(Address_Services.Layouts.int_rec,
      SELF := RIGHT,
      SELF.valid := TRUE),
    LIMIT(0), KEEP(Address_Services.Constants.MAX_ADVO_ADDR));

  advo_recs := IF(NOT mod_access.isAdvoRestricted(), advo_zip + advo_city_state);
  
  iesp.addresssearch.t_AddressSearchRecord xformOut (Address_Services.Layouts.int_rec L, Address_Services.Layouts.int_rec R) := TRANSFORM
    SELF.Valid := R.valid; //if an address is found in Advo, we consider it to be valid; otherwise we do not
    left_addr1 := address.Addr1FromComponents(L.prim_range,L.predir,L.prim_name,L.addr_suffix,
      L.postdir,'',L.sec_range);
    left_addr2 := Address.Addr2FromComponents(L.p_city_name, L.st, L.zip);
    LeftRecord := iesp.ECL2ESP.SetAddress (
      L.prim_name, L.prim_range, L.predir, L.postdir,
      L.addr_suffix, L.unit_desig, L.sec_range, L.p_city_name,
      L.st, L.zip, '', '',
      '', left_addr1, left_addr2, '');
    right_addr1 := address.Addr1FromComponents(R.prim_range,R.predir,R.prim_name,R.addr_suffix,
      R.postdir,'',R.sec_range);
    right_addr2 := Address.Addr2FromComponents(R.p_city_name, R.st, R.zip);
    RightRecord := iesp.ECL2ESP.SetAddress (
      R.prim_name, R.prim_range, R.predir, R.postdir,
      R.addr_suffix, R.unit_desig, R.sec_range, R.p_city_name,
      R.st, R.zip, '', '',
      '', right_addr1, right_addr2, '');
    boolean hasLeftRecord := L.prim_name <> '';
    SELF.Address := if(hasLeftRecord, LeftRecord, RightRecord);
  END;
  
  results := JOIN(header_recs, advo_recs,
    LEFT.prim_range = RIGHT.prim_range AND
    LEFT.prim_name = RIGHT.prim_name AND
    LEFT.addr_suffix= RIGHT.addr_suffix AND
    LEFT.sec_range = RIGHT.sec_range,
    xformOut(LEFT, RIGHT),
    FULL OUTER);
  
  RETURN choosen(sort(results, -valid, Address.UnitNumber), iesp.constants.Address.MAX_COUNT_SEARCH_RESPONSE_RECORDS);
END;
