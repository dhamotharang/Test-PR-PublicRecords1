import advo, doxie, data_services;

advo_b := project(advo.Files(,false).Base.built(street_name <> 'PO BOX'), transform(advo.Layouts.Layout_Common_Out_k, self := left));
export key_advo_addr := INDEX(advo_b, 
							 {zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range},
							 {advo_b},
							  data_services.data_location.prefix() + 'thor_data400::key::advo::' + doxie.Version_SuperKey + '::addr_search1');