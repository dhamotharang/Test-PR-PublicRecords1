import gong, doxie, ut, gong_services;

hist_in := Gong.File_History_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

hist_out_new_rec := record
	hist_out;
	string120 listed_name_new;
end;

hist_out_new := project(hist_out, transform(hist_out_new_rec, 
                                            self.listed_name_new := StringLib.StringCleanSpaces(
																						                        StringLib.StringSubstituteOut(left.listed_name,
																						                                                      '~`!@#$%^&*()-_+={[}]|\\;:"\'<,>.?/',
																																																	' ')
																																																), 
                                            self:=left));

export key_history_companyname := index(hist_out_new(listed_name_new<>''),
																			  {listed_name_new, st, p_city_name, boolean current_flag := if(current_record_flag='Y',true,false)}, 
																				{hist_out_new},
                                        '~thor_data400::key::gong_history_companyname_' + doxie.Version_SuperKey);
