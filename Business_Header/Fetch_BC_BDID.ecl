IMPORT $, AutoStandardI, doxie, Suppress;

EXPORT Fetch_BC_BDID(UNSIGNED6 bdid_key) := FUNCTION

keyfile := $.Key_Business_Contacts_BDID;

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

res_key := PROJECT(keyfile(bdid=bdid_key),
         TRANSFORM(LEFT));
         
outf := Suppress.MAC_SuppressSource(res_key, mod_access);

RETURN PROJECT(outf, $.Layout_Business_Contact_Full);

END;