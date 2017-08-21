import ut;

nc_mar_filter := dataset('~thor_200::in::mar_div::nc::marriage',marriage_divorce_v2.Layout_Marriage_NC_In,flat,OPT);

export File_Marriage_NC_In := nc_mar_filter( (trim(groom_last_name)!='' and trim(groom_first_name)!='') or 
																						(trim(bride_last_name) !='' and trim(bride_first_name)!='')); 		



