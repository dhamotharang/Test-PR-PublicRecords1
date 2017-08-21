import ut;


 fl_div_dis := dataset('~thor_200::in::mar_div::fl::divorce',
									   marriage_divorce_v2.Layouts_FL_divorce_In.Layout_Divorce_FL_Var_In,
										 csv(heading(1),terminator(['\n','\r\n']),separator('|'),Quote('"')),OPT);
										 
marriage_divorce_v2.Layouts_FL_divorce_In.Layout_Divorce_FL_In trfProject(marriage_divorce_v2.Layouts_FL_divorce_In.Layout_Divorce_FL_Var_In l) :=
transform
	
self := l;
 end;

fl_div_filter:= project(fl_div_dis,trfProject(left));

export File_FL_Divorce_In := fl_div_filter( (trim(husb_name_last)!=''  and trim(husb_name_first)!='') or (trim(wife_name_last)!=''  and trim(wife_name_first)!='')); 		
