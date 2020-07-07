EXPORT mac_check_access (ds_in, ds_out, mod_access, retain, contact_did_fieldname) := MACRO
IMPORT Suppress;

   #UNIQUENAME(suppressRecs)
   %suppressRecs% := Suppress.MAC_FlagSuppressedSource(ds_in, mod_access, contact_did_fieldname);
	 
	 #IF(retain)
	 ds_out := %suppressRecs%;
	 #ELSE
	 ds_out := project(%suppressRecs%(not is_suppressed), recordof(ds_in));
	 #END
	   

ENDMACRO;
