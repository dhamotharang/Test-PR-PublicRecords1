import ut;

nc_div_filter := dataset('~thor_200::in::mar_div::nc::divorce',marriage_divorce_v2.Layout_Divorce_NC_In,flat,OPT);

export File_Divorce_NC_In := nc_div_filter( (trim(plntf_last_name) !='' and trim(plntf_first_name) !='') or 
																						(trim(dfndnt_last_name)!='' and trim(dfndnt_last_name) !='')); 		



