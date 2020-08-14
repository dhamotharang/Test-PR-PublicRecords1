IMPORT doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

EXPORT UCC_Records(DATASET(doxie_cbrs.layout_references) bdids, STRING6 SSNMask = 'NONE') := FUNCTION

raw := doxie_cbrs_raw.UCC_Legacy(bdids,Include_UCCFilings_val, max_UCCFilings_val,SSNMask,'D').records;

RETURN IF(UccVersion IN [0,1],SORT(
          raw, -orig_filing_date, -filing_date,
          debtor_name, secured_name));
END;
