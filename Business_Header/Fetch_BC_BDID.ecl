outrec := business_header.Layout_Business_Contact_Full;
keyfile := Business_Header.Key_Business_Contacts_BDID;

EXPORT Fetch_BC_BDID(UNSIGNED6 bdid_key) := 
   project(keyfile(bdid=bdid_key),
         transform(outrec, self := LEFT));