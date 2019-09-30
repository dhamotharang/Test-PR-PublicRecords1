﻿EXPORT  Fetch_BC_Full(DATASET(business_header.layout_filepos) ds_fp) := 
FUNCTION

IMPORT Doxie, AutoStandardI, Suppress;

k := business_header.Key_Business_Contacts_FP;

rec_f_suppress := record
 business_header.Layout_Business_Contact_Full;
 unsigned4 	global_sid := 0;
 unsigned8 	record_sid := 0;
end;


rec_f_suppress tra(k r) := TRANSFORM
	self := r;
end;

j := JOIN(ds_fp, k, LEFT.fp > 0 AND LEFT.fp = RIGHT.fp, tra(RIGHT));

mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());

res_contacts_pre := Suppress.MAC_SuppressSource(j, mod_access);

res_contacts_full := project(res_contacts_pre, business_header.Layout_Business_Contact_Full);

RETURN res_contacts_full;

END;