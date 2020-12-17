IMPORT doxie, Alerts;

EXPORT alert := MODULE

  SHARED UNSIGNED1 version := 1;
  
  // shorter names
  SHARED layout_hashval := alerts.layouts.layout_hashval;
  SHARED layout_hash := alerts.layouts.layout_hash;

 layout_hashval calcBkDebtorNameHashes(layouts.layout_name l) := TRANSFORM
    SELF.hashval := HASH64(l.fname,l.lname,l.mname,l.cname);
  END;

 layout_hashval calcBkDebtorAddrHashes(layouts.layout_address l) := TRANSFORM
    SELF.hashval := HASH64(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,l.v_city_name,l.st,l.zip);
  END;

  layout_hashval calcBkDebtorHashes(layouts.layout_party l) := TRANSFORM
    SELF.hashval := HASH64(l.ssn,l.tax_id) +
                    SUM(PROJECT(l.names, calcBKDebtorNameHashes(LEFT)), hashval) +
                    SUM(PROJECT(l.addresses, calcBKDebtorAddrHashes(LEFT)), hashval);
  END;
  
  layout_hashval calcBkStatusHashes(layouts.layout_status l) := TRANSFORM
    SELF.hashval := HASH64(l.status_date,l.status_type);
  END;

  EXPORT UNSIGNED8 calcHashval(RECORDOF(layouts.layout_rollup) l) := FUNCTION
    // using case_number in lieu of orig_case_number
    RETURN HASH64(l.case_number) +
                  SUM(PROJECT(l.debtors, calcBKDebtorHashes(LEFT)), hashval) +
                  SUM(PROJECT(l.status_history, calcBKStatusHashes(LEFT)),hashval);
  END;
  
  Alerts.mac_setupAlerts(layouts.layout_rollup, calcHashval, version)
  
END;
