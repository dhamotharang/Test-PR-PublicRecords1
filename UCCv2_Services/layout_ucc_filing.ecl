IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_filing := RECORD
  k_main.tmsid;
  k_main.filing_jurisdiction;
  STRING25 filing_jurisdiction_name;
  k_main.orig_filing_number;
  k_main.orig_filing_type;
  k_main.orig_filing_date;
  DATASET(layout_filing_status) filing_status{MAXCOUNT(10)};
END;
