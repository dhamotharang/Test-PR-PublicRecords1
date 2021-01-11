IMPORT doxie, liensv2, Alerts;

EXPORT alert := MODULE

  SHARED UNSIGNED1 version := 1;

  // short names
  SHARED layout_hashval := alerts.layouts.layout_hashval;
  SHARED layout_hash := alerts.layouts.layout_hash;
  
  layout_hashval calcLienStatusHashes(liensv2.Layout_liens_main_module.layout_filing_status l) := TRANSFORM
    SELF.hashval := HASH64(l.filing_status);
  END;

  layout_hashval calcLienFilingHashes(layout_lien_history l) := TRANSFORM
    SELF.hashval := HASH64(l.filing_number,l.filing_type_desc,l.filing_date);
  END;

  layout_hashval calcLienAddrHashes(layout_lien_party_address l) := TRANSFORM
    SELF.hashval := HASH64(l.prim_range,l.predir,l.prim_name,l.addr_suffix,l.postdir,l.sec_range,
                           l.v_city_name,l.st,l.zip);
  END;
  
  layout_hashval calcLienPartyHashes(layout_lien_party l) := TRANSFORM
    SELF.hashval := HASH64(l.orig_name) +
                    SUM(PROJECT(l.addresses, calcLienAddrHashes(LEFT)), hashval);
  END;

  // need to export this for single-source alert processing
  EXPORT UNSIGNED8 calcHashval(RECORDOF(layout_lien_rollup) l) := FUNCTION
     RETURN HASH64(l.case_number,l.orig_filing_type,l.orig_filing_date,l.orig_filing_number) +
                   SUM(PROJECT(l.filing_status, calcLienStatusHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.filings, calcLienFilingHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.debtors, calcLienPartyHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.creditors, calcLienPartyHashes(LEFT)), hashval);
  END;
  
  Alerts.mac_setupAlerts(layout_lien_rollup, calcHashval, version)


END;
