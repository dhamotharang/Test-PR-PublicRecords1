export Layout_Business_Relative := record
unsigned6 bdid1;
unsigned6 bdid2;
boolean corp_charter_number := false;
boolean business_registration := false;
boolean bankruptcy_filing := false;
boolean duns_number := false;
boolean duns_tree := false;  // might point to a group
boolean edgar_cik := false;
boolean name := false;  // might point to a group
boolean name_address := false;
boolean name_phone := false;
boolean gong_group := false;
boolean ucc_filing := false;
boolean fbn_filing := false;
boolean fein := false;
boolean phone := false;
boolean addr := false;
boolean mail_addr := false;
boolean dca_company_number := false;  // Directory of Corporate Affilications Company Number (Root and Sub)
boolean dca_hierarchy := false;
boolean abi_number := false;     // InfoUSA - American Business ID Company Number
boolean abi_hierarchy := false;
boolean lien_properties := false;
boolean liens_v2 := false;
//boolean shared_contacts := false;
boolean rel_group := false;
end;