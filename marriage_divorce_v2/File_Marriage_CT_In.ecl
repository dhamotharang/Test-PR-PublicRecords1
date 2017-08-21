ct_mar_file := dataset('~thor_200::in::mar_div::ct::marriage',marriage_divorce_v2.Layout_Marriage_CT_In,csv(heading(1), separator(','), terminator(['\n','\r\n']), quote('"')),OPT);
                              
export File_Marriage_CT_In	:= 	ct_mar_file( (trim(groom_last_name)!=''  and trim(groom_first_name)!='') or 
																						(trim(bride_last_name) !=''  and trim(bride_first_name)!='')); 		
