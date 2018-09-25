import business_header;

FileName := alertlist.constants.prefix + 'base::key_business_contacts_did';

EXPORT Key_Business_Contacts_did := INDEX(AlertList.File_Business_Contacts,{did}, {bdid, company_name;company_prim_range;company_predir;company_prim_name;company_addr_suffix;company_postdir;company_unit_desig;company_sec_range;company_city;company_state;company_zip;company_zip4;company_phone;company_fein}, FileName);