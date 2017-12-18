import doxie,data_services;

uspis_hotlist_base 		:= project(USPIS_Hotlist.File_USPIS_Hotlist_Base, transform(USPIS_Hotlist.Layouts.Base, self := left));

export key_addr_search_zip 	:= INDEX(uspis_hotlist_base, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {uspis_hotlist_base},
							 Keynames(doxie.Version_SuperKey).AddrZip.Logical);
							 //data_services.foreign_prod + 'thor_data400::key::uspis_hotlist::' + doxie.Version_SuperKey + '::addr_search_zip');



