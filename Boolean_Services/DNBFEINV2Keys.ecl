export DNBFEINV2Keys := macro
	output(choosen(text_search.key_Boolean_SegList('feinv2'),10));
	//output(choosen(text_search.Key_Boolean_dictindx('feinv2'),10));
	output(choosen(text_search.Key_Boolean_dstat('feinv2'),10));
	//output(choosen(text_search.Key_Boolean_nidx('feinv2'),10));
	//output(choosen(text_search.Key_Boolean_nidx2('feinv2'),10));
	output(choosen(text_search.Key_Boolean_nidx3('feinv2'),10));
	output(choosen(text_search.Key_Boolean_dictindx3('feinv2'),10));
	output(choosen(text_search.Key_Boolean_dtldictx('feinv2'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('feinv2'),10));
	output(choosen(text_search.Key_Boolean_EKeyOut('feinv2'),10));
	output(choosen(DNB_FEINV2.Key_Boolean_Map,10));
	output(choosen(dnb_feinv2.key_dnb_fein_tmsid,10));
endmacro;