import ut;
 ky_div_filter := dataset('~thor_200::in::mar_div::ky::divorce',marriage_divorce_v2.Layout_Divorce_KY_In,flat,OPT);

export File_Divorce_KY_In := ky_div_filter( (trim(husband_last_name)!=''  and trim(husband_first_name)!='') or 
																						(trim(wife_maiden_name) !=''  and trim(wife_first_name)   !='')); 		
