export mac_date_ids(date_field, date_value, key) := macro
import death_master,doxie,_validate,NID,ut;

export valid_input(string8 d) := _Validate.Date.fIsValid(d);

doxie.MAC_Header_Field_Declare()
k := key;
outrec := deathV2_Services.layouts.search_id;

mk := k(valid_input((string8)date_value) and
				(state_value <> '' or lname_value <> '' or fname_value <> '') and
			  keyed(date_field = (string8)date_value) and
				keyed(state_value = '' or state = state_value) and
				keyed(lname_value = '' or dph_lname = metaphonelib.DMetaPhone1(lname_value)) and
				keyed(fname_value = '' or pfname = NID.PreferredFirstNew(fname_value, true) 
				                       or pfname = NID.PreferredFirstNew(fname_value, false)));
lk := limit(mk, ut.limits.default, skip);

export result := project(lk, outrec);

endmacro;