IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_filofc := RECORD
  k_main.filing_agency;
  k_main.address;
  k_main.city;
  k_main.state;
  k_main.county;
  k_main.zip;
END;
