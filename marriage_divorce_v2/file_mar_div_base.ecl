export file_mar_div_base := project(marriage_divorce_v2.file_mar_div_intermediate
																		,transform(marriage_divorce_v2.layout_mar_div_base
																		,self := left));

//export file_mar_div_base := dataset('~thor_data400::base::mar_div::base',marriage_divorce_v2.layout_mar_div_base,flat);
