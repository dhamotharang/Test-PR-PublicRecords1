export FCCKeys := macro
output(choosen(FCC.Key_FCC_seq,10));
//output(choosen(text_search.Key_Boolean_dictindx('fcc'),10));
output(choosen(text_search.Key_Boolean_dstat('fcc'),10));
output(choosen(text_search.Key_Boolean_seglist('fcc'),10));
//output(choosen(text_search.Key_Boolean_nidx('fcc'),10));
//output(choosen(text_search.Key_Boolean_nidx2('fcc'),10));
output(choosen(text_search.Key_Boolean_nidx3('fcc'),10));
output(choosen(text_search.Key_Boolean_dictindx3('fcc'),10));
output(choosen(text_search.Key_Boolean_dtldictx('fcc'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('fcc'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('fcc'),10));

endmacro;