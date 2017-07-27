gov_base := File_Gov_Phones_Base(name_last <> '' /*, zip != '', prim_name != '' */);

gp_contacts_init := PROJECT(gov_base(agency <> ''), TRA_Gov_Phone_To_Business_Contact(LEFT));


EXPORT Gov_Phones_As_Business_Contact := gp_contacts_init : PERSIST('TEMP::Gov_Phones_Contacts_Rollup');