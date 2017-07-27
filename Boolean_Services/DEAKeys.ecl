export DEAKeys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('dea'),10));
output(choosen(text_search.Key_Boolean_dstat('dea'),10));
output(choosen(text_search.Key_Boolean_seglist('dea'),10));
//output(choosen(text_search.Key_Boolean_nidx('dea'),10));
output(choosen(text_search.Key_Boolean_dictindx3('dea'),10));
output(choosen(text_search.Key_Boolean_dtldictx('dea'),10));
//output(choosen(text_search.Key_Boolean_nidx2('dea'),10));
output(choosen(text_search.Key_Boolean_nidx3('dea'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('dea'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('dea'),10));
output(choosen(dea.Key_Boolean_Map,10));
output(choosen(dea.Key_dea_reg_num,10));
endmacro;