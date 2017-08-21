import ut;

 ky_mar_filter := dataset('~thor_200::in::mar_div::ky::marriage',marriage_divorce_v2.Layout_Marriage_KY_In,flat,OPT); 


export File_Marriage_KY_In := ky_mar_filter( (trim(GROOM_NAME_LAST)!=''  and trim(GROOM_NAME_FIRST)!='') or 
																						(trim(BRIDE_NAME_LAST) !=''  and trim(BRIDE_NAME_FIRST)!='')); 		

