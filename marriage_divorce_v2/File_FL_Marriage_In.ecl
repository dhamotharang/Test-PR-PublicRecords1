import ut;


 fl_mar_dis :=  dataset('~thor_200::in::mar_div::fl::marriage',
									   marriage_divorce_v2.Layouts_FL_Marriage_In.Layout_Marriage_FL_Var_In,
										 csv(heading(1),terminator('\r\n'),separator('|'),Quote('"')),OPT);
										 

										 

marriage_divorce_v2.Layouts_FL_Marriage_In.Layout_Marriage_FL_In trfProject(marriage_divorce_v2.Layouts_FL_Marriage_In.Layout_Marriage_FL_Var_In l) :=
transform
 self := l;	

end;

fl_mar_filter := project(fl_mar_dis,trfProject(left));


export File_FL_Marriage_In := fl_mar_filter( (trim(groom_name_last)!=''  and trim(groom_name_first)!='') or 
																						 (trim(bride_name_last)!=''  and trim(bride_name_first)!='')); 		
