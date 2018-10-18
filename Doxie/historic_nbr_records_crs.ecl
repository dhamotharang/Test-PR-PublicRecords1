IMPORT $;

EXPORT historic_nbr_records_crs(boolean checkRNA=true) := FUNCTION
doxie.MAC_Header_Field_Declare(); //dppa_ok, glb_ok, GLB_Purpose, DPPA_Purpose
mod_access := $.functions.GetGlobalDataAccessModule();
doxie.MAC_Selection_Declare();

doxie.historic_nbr_records(doxie.header_records(), hist_nbr, checkRNA, mod_access);

afil := $.functions.MAC_FilterOutMinors (hist_nbr, , dob, mod_access.show_minors);
RETURN afil;
END;