IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_coll := RECORD
  k_main.collateral_desc;
  k_main.collateral_count;
  k_main.serial_number;
  k_main.property_desc;
  k_main.collateral_address;
  k_main.filing_number;
  k_main.filing_date;
END;
