import gong, doxie, ut, gong_services;

hist_in := Gong.File_History_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'', current_record_flag<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

export key_cn_to_company := index(hist_out,
												  			  {listed_name, st, p_city_name, z5, phone10}, 
																	{hist_out},
                                   '~thor_data400::key::gong_cn_to_company_' + doxie.Version_SuperKey);

