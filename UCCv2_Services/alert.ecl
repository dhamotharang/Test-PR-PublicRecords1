IMPORT doxie, Alerts;

EXPORT alert := MODULE
  
  SHARED UNSIGNED1 version := 1;

  // shorter names
  SHARED layout_hashval := alerts.layouts.layout_hashval;
  SHARED layout_hash := alerts.layouts.layout_hash;

  layout_hashval calcUCCFilingHashes(layout_ucc_hist l) := TRANSFORM
    SELF.hashval := HASH64(l.filing_number,l.filing_type,l.filing_date,l.filing_status,l.status_type);
  END;


  layout_hashval calcUCCAddrHashes(layout_ucc_party_address l) := TRANSFORM
    SELF.hashval := HASH64(l.address1,l.address2,l.v_city_name,l.st,l.zip5);
  END;

  layout_hashval calcUCCPartyHashes(layout_ucc_party l) := TRANSFORM
    SELF.hashval := HASH64(l.orig_name) +
                    SUM(PROJECT(l.addresses, calcUCCAddrHashes(LEFT)), hashval);
  END;

  EXPORT UNSIGNED8 calcHashval(RECORDOF(layout_ucc_rollup) l) := FUNCTION
     RETURN HASH64(l.orig_filing_number, l.orig_filing_type) +
                   SUM(PROJECT(l.filings, calcUCCFilingHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.debtors, calcUCCPartyHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.secureds, calcUCCPartyHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.assignees, calcUCCPartyHashes(LEFT)), hashval) +
                   SUM(PROJECT(l.creditors, calcUCCPartyHashes(LEFT)), hashval);
  END;

  Alerts.mac_setupAlerts(layout_ucc_rollup, calcHashval, version)
  
END;
