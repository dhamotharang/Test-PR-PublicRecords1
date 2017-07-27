export DEADCOKeys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('deadco'),10));
	output(choosen(text_search.Key_Boolean_dictindx3('deadco'),10));
	output(choosen(text_search.Key_Boolean_dtldictx('deadco'),10));
	output(choosen(text_search.Key_Boolean_seglist('deadco'),10));
	output(choosen(text_search.Key_Boolean_dstat('deadco'),10));
	//output(choosen(text_search.Key_Boolean_nidx('deadco'),10));
	//output(choosen(text_search.Key_Boolean_nidx2('deadco'),10));
	output(choosen(text_search.Key_Boolean_nidx3('deadco'),10));
	output(choosen(InfoUSA.Key_Boolean_Deadco_Map,10));
	//output(choosen(infousa.Key_Deadco_ABI_number,10));
	output(choosen(text_search.Key_Boolean_EKeyIn('deadco'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('deadco'),10));
endmacro;