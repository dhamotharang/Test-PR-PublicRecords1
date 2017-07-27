export fGov_Phones_As_Business_Contact(dataset(Layout_Gov_Phones_Base) pBasefile) :=
function

gov_base := pBasefile(name_last <> '');

gp_contacts_init := PROJECT(gov_base(agency <> ''), TRA_Gov_Phone_To_Business_Contact(LEFT));


return gp_contacts_init;

end;
