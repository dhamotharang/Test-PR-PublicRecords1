
export proc_build_keys(string filedate = '') := function
	
	keys := CNLD_Facilities.index_files();

	build_deanbr := BUILDINDEX(keys.key_deanbr, OVERWRITE);
	build_taxid := BUILDINDEX(keys.key_taxid, OVERWRITE);
	build_license := BUILDINDEX(keys.key_license, OVERWRITE);
	build_ncpdp := BUILDINDEX(keys.key_ncpdp, OVERWRITE);
	build_npi := BUILDINDEX(keys.key_npi, OVERWRITE);
	build_bdid := BUILDINDEX(keys.key_dbid, OVERWRITE);
   	
   	return SEQUENTIAL(
		build_deanbr, 
		build_taxid, 
		build_license, 
		build_ncpdp, 
		build_npi,
		build_bdid
	);
end;
