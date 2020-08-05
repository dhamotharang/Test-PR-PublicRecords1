IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_coll_src := RECORD
  k_main.collateral_desc;
  k_main.prim_machine;
  k_main.sec_machine;
  k_main.manufacturer_code;
  k_main.manufacturer_name;
  k_main.model;
  k_main.model_year;
  k_main.model_desc;
  k_main.collateral_count;
  k_main.manufactured_year;
  k_main.new_used;
  k_main.serial_number;
  k_main.property_desc;
  k_main.borough;
  k_main.block;
  k_main.lot;
  k_main.collateral_address;
  k_main.air_rights_indc;
  k_main.subterranean_rights_indc;
  k_main.easment_indc;
  k_main.filing_number;
  k_main.filing_date;
END;
