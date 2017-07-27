export MDV2Keys := macro
	output(choosen(text_search.key_Boolean_SegList('md'),10));
//output(choosen(text_search.Key_Boolean_dictindx('md'),10));
output(choosen(text_search.Key_Boolean_dstat('md'),10));
//output(choosen(text_search.Key_Boolean_nidx('md'),10));
//output(choosen(text_search.Key_Boolean_dictindx2('md'),10));
output(choosen(text_search.Key_Boolean_dictindx3('md'),10));
output(choosen(text_search.Key_Boolean_dtldictx('md'),10));
//output(choosen(text_search.Key_Boolean_nidx2('md'),10));
output(choosen(text_search.Key_Boolean_nidx3('md'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('md'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('md'),10));
output(choosen(marriage_divorce_v2.key_mar_div_id_main,10));
output(choosen(marriage_divorce_v2.key_mar_div_id_search,10));
endmacro;