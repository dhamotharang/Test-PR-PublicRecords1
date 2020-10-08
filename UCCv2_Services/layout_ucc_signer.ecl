IMPORT uccv2;

k_main := uccv2.layout_UCC_common.layout_ucc_new;

EXPORT layout_ucc_signer := RECORD
  k_main.signer_name;
  k_main.title;
END;
