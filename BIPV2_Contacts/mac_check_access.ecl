EXPORT mac_check_access (ds_in, ds_out, mod_access) := MACRO
  IMPORT BIPV2_Contacts, Suppress, MDR;
  
  #UNIQUENAME(ds_DnB_access);
  %ds_DnB_access% := ds_in(source <> MDR.sourceTools.src_Dunn_Bradstreet OR mod_access.use_DnB());

  ds_out := Suppress.MAC_SuppressSource(%ds_DnB_access%, mod_access, contact_did);

ENDMACRO;  
