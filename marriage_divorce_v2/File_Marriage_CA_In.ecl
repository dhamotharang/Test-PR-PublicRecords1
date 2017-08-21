import ut;

ca_mar_filter := dataset('~thor_200::in::mar_div::ca::marriage',marriage_divorce_v2.Layout_Marriage_CA_In,flat,OPT);

export File_Marriage_CA_In := ca_mar_filter( (trim(groom_last_name)!=''  and trim(groom_first_name)!='') or 
																						 (trim(bride_last_name)!=''  and trim(bride_first_name)!='')); 	