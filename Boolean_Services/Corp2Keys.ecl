export Corp2Keys := macro
	output(choosen(text_search.key_Boolean_SegList('corp2'),10));
	//output(choosen(text_search.Key_Boolean_dictindx('corp2'),10));
	//output(choosen(text_search.Key_Boolean_nidx('corp2'),10));
	output(choosen(text_search.Key_Boolean_dstat('corp2'),10));
	//output(choosen(text_search.Key_Boolean_nidx2('corp2'),10));
	output(choosen(text_search.Key_Boolean_nidx3('corp2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('corp2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('corp2'),10));
output(choosen(text_search.Key_Boolean_EKeyIn('corp2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('corp2'),10));
	output(choosen(Corp2.Key_Boolean_Map,10));
	output(choosen(corp2.Key_Cont_Corpkey,10));
	output(choosen(corp2.Key_corp_Corpkey,10));
endmacro;