import doxie, ut,data_services;

uspis_hotlist_base 		:= project(USPIS_Hotlist.File_USPIS_Hotlist_Base, transform(USPIS_Hotlist.Layouts.Base, self := left));

export key_addr_search_state	:= INDEX(uspis_hotlist_base, 
							 {st, v_city_name, prim_range, prim_name, sec_range},
							 {uspis_hotlist_base},
							 Keynames(doxie.Version_SuperKey).AddrState.Logical);
							 //data_services.foreign_prod + data_services.data_location.prefix() + 'thor_data400::key::uspis_hotlist::' + doxie.Version_SuperKey + '::addr_search_state');
