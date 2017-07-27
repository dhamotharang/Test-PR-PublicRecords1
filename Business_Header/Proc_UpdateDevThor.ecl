//run on prod...are these all the files we need?
/*
FileServices.GetSuperFileSubName('base::business_header',1);
FileServices.GetSuperFileSubName('base::business_contacts',1);
FileServices.GetSuperFileSubName('base::business_relatives',1);
FileServices.GetSuperFileSubName('base::business_relatives_group',1);
FileServices.GetSuperFileSubName('BASE::Business_Header.Best',1);
FileServices.GetSuperFileSubName('BASE::business_header.CompanyName',1);
FileServices.GetSuperFileSubName('BASE::business_header.CompanyName_Address',1);
FileServices.GetSuperFileSubName('BASE::business_header.CompanyName_FEIN',1);
FileServices.GetSuperFileSubName('BASE::business_header.CompanyName_Phone',1);
*/
//FileServices.Copy does not seem to work right now

//run on dev w/names retrieved from above...should we push the others (base to father...etc)?? only where automatic
//just clear base and add 
//should i add a true to delete these?
/*
FileServices.ClearSuperFile('base::business_header');
FileServices.ClearSuperFile('base::business_contacts');
FileServices.ClearSuperFile('base::business_relatives');
FileServices.ClearSuperFile('base::business_relatives_group');
FileServices.ClearSuperFile('BASE::Business_Header.Best');
FileServices.ClearSuperFile('BASE::business_header.CompanyName');
FileServices.ClearSuperFile('BASE::business_header.CompanyName_Address');
FileServices.ClearSuperFile('BASE::business_header.CompanyName_FEIN');
FileServices.ClearSuperFile('BASE::business_header.CompanyName_Phone');

FileServices.AddSuperFile('base::business_header','base::business_headerw20040922-095224');
FileServices.AddSuperFile('base::business_contacts','base::business_contactsw20041008-153651');
FileServices.AddSuperFile('base::business_relatives','base::business_relativesw20040922-095224');
FileServices.AddSuperFile('base::business_relatives_group','base::business_relatives_groupw20040922-095224');
FileServices.AddSuperFile('BASE::Business_Header.Best','base::business_header.bestw20040923-093723');
FileServices.AddSuperFile('BASE::business_header.CompanyName','base::business_header.companynamew20040923-093723');
FileServices.AddSuperFile('BASE::business_header.CompanyName_Address','base::business_header.companyname_addressw20040923-093723');
FileServices.AddSuperFile('BASE::business_header.CompanyName_FEIN','base::business_header.companyname_feinw20040923-093723');
FileServices.AddSuperFile('BASE::business_header.CompanyName_Phone','base::business_header.companyname_phonew20040923-093723');
*/

//build keys and slimsorts

//Business_Header_SS.Make_Business_Header_Keys

//Business_Header_SS.Make_Business_Search_Keys

//Business_Header.Make_Business_Contacts_Keys