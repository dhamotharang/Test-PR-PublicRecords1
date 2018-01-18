import header, doxie, data_services;


export key_livsit_pr_pn_zip := index(
	dedup(header.File_Headers(zip <> '', (prim_name <> '' or prim_range <> '')), zip, prim_range, prim_name, sec_range, did),
	{zip, prim_name, prim_range, sec_range}, 
	{did},
	data_services.data_location.prefix() + 'thor_data400::key::livsit_pr_pn_zip_' + doxie.Version_SuperKey);
	
	/*
	keyn := '~thor_data400::key::livsit_pr_pn_zip';
ut.MAC_SK_BuildProcess(doxie_files.key_livsit_pr_pn_zip,keyn, keyn, k, 2)
k
	
	
	keyn := '~thor_data400::key::livsit_pr_pn_zip';
ut.MAC_SK_Move(keyn ,'Q',k)
k
*/