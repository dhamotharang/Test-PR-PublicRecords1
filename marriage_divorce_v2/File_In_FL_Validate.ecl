EXPORT File_In_FL_Validate := function

fl_div_dis := dataset('~thor_200::in::mar_div::fl::divorce',
									   marriage_divorce_v2.Layouts_FL_divorce_In.Layout_Divorce_FL_Var_In,
										 csv(heading(1),terminator(['\n','\r\n']),separator('|'),Quote('"')),OPT) ;

div_val :=  if (  count(fl_div_dis( regexfind ( '\\x000',EVENT_YEAR))) > 1  ,FAIL ('FL Divorce file has non printable characters'));

fl_mar_dis :=  dataset('~thor_200::in::mar_div::fl::marriage',
									   marriage_divorce_v2.Layouts_FL_Marriage_In.Layout_Marriage_FL_Var_In,
										 csv(heading(1),terminator('\r\n'),separator('|'),Quote('"')),OPT);
										 
mar_val:=  if (  count(fl_mar_dis( regexfind ( '\\x000',EVENT_YEAR))) > 1  ,FAIL ('FL Marriage file has non printable characters'));

return Sequential( div_val,mar_val);

end;
										 