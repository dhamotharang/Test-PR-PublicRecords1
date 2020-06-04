IMPORT $, dx_Gong, gong;

hist_in := $.File_History_Full_Prepped_for_Keys((unsigned)phone10<>0, listing_type_bus<>'', listed_name<>'');
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

hist_filtered := hist_out_new(listed_name_new<>'');
EXPORT data_key_history_companyname := PROJECT (hist_filtered, TRANSFORM(dx_Gong.layouts.i_history_companyname,
                                                                         SELF.current_flag := LEFT.current_record_flag='Y',
                                                                         SELF := LEFT));