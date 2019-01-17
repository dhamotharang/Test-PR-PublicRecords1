IMPORT $;

EXPORT historic_nbr_records_crs(boolean checkRNA=true) := FUNCTION
mod_access := $.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
glb_ok := mod_access.isValidGLB();
dppa_ok := mod_access.isValidDPPA();
doxie.MAC_Selection_Declare();

doxie.historic_nbr_records(doxie.header_records(), hist_nbr, checkRNA, mod_access);

afil := $.compliance.MAC_FilterOutMinors (hist_nbr, , dob, mod_access.show_minors);
RETURN afil;
END;