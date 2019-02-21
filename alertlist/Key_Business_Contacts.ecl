import business_header;

//FileName := alertlist.constants.prefix + 'base::key_business_contacts';
FileName := '~thordev_socialthor_50::base::key_business_contacts';

EXPORT Key_Business_Contacts := INDEX(AlertList.File_Business_Contacts,{bdid}, {did, company_name;company_prim_range;company_predir;company_prim_name;company_addr_suffix;company_postdir;company_unit_desig;company_sec_range;company_city;company_state;company_zip;company_zip4;company_phone;company_fein}, FileName);
