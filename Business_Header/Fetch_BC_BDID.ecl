IMPORT $, AutoStandardI, doxie, Suppress;

EXPORT Fetch_BC_BDID(UNSIGNED6 bdid_key) := FUNCTION

temp_f_suppress := RECORD
   $.Layout_Business_Contact_Full;
   UNSIGNED4 	global_sid := 0;
	 UNSIGNED8 	record_sid := 0;
END;

keyfile := $.Key_Business_Contacts_BDID;

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

res_key := PROJECT(keyfile(bdid=bdid_key),
         TRANSFORM(temp_f_suppress, SELF := LEFT));
         
outf := Suppress.MAC_SuppressSource(res_key, mod_access);

RETURN PROJECT(outf, $.Layout_Business_Contact_Full);

END;