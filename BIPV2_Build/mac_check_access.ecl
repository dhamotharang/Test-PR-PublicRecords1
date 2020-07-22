EXPORT mac_check_access (ds_in, ds_out, mod_access, retain, contact_did_fieldname) := MACRO

  #IF(retain)
  #UNIQUENAME(newLayout)
  %newLayout% := record
    ds_in;
    boolean is_suppressed := false;
  end;
  ds_out := project(ds_in, %newLayout%);
  #ELSE
  ds_out := ds_in;
  #END

ENDMACRO;  
