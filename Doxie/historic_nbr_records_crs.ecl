IMPORT $;

export historic_nbr_records_crs(boolean checkRNA=true) := FUNCTION
doxie.MAC_Header_Field_Declare(); //dppa_ok, glb_ok, GLB_Purpose, DPPA_Purpose
mod_access := $.functions.GetGlobalDataAccessModule();
doxie.MAC_Selection_Declare();

doxie.historic_nbr_records(doxie.header_records(),a,checkRNA, mod_access);

ut.PermissionTools.GLB.mac_FilterOutMinors(a,afil,,,dob)
RETURN afil;
END;