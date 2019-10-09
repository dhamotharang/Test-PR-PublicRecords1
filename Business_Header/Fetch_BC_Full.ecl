EXPORT  Fetch_BC_Full(DATASET(business_header.layout_filepos) ds_fp) := 
FUNCTION

IMPORT Doxie, AutoStandardI, Suppress;

k := business_header.Key_Business_Contacts_FP;

j := JOIN(ds_fp, k, LEFT.fp > 0 AND LEFT.fp = RIGHT.fp, TRANSFORM(RIGHT));

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

res_contacts_pre := Suppress.MAC_SuppressSource(j, mod_access);

res_contacts_full := PROJECT(res_contacts_pre, business_header.Layout_Business_Contact_Full);

RETURN res_contacts_full;

END;