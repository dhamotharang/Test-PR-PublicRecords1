export BankruptcyV2Keys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('bankruptcyv2'),10));
	output(choosen(text_search.Key_Boolean_dstat('bankruptcyv2'),10));
	output(choosen(text_search.Key_Boolean_seglist('bankruptcyv2'),10));
	//output(choosen(text_search.Key_Boolean_nidx('bankruptcyv2'),10));
	output(choosen(text_search.Key_Boolean_dtldictx('bankruptcyv2'),10));
	output(choosen(text_search.Key_Boolean_dictindx3('bankruptcyv2'),10));
	//output(choosen(text_search.Key_Boolean_nidx2('bankruptcyv2'),10));
	output(choosen(text_search.Key_Boolean_nidx3('bankruptcyv2'),10));
	output(choosen(bankruptcyv2.Key_Boolean_TMSID,10));
	output(choosen(bankruptcyv2.key_bankruptcy_main_full(),10));
	output(choosen(bankruptcyv2.key_bankruptcy_search_full(),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('bankruptcyv2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('bankruptcyv2'),10));
endmacro;