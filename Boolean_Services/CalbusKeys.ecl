export CalbusKeys := macro
//output(choosen(text_search.Key_Boolean_dictindx('calbus'),10));
output(choosen(text_search.Key_Boolean_dstat('calbus'),10));
output(choosen(text_search.Key_Boolean_seglist('calbus'),10));
//output(choosen(text_search.Key_Boolean_nidx('calbus'),10));
output(choosen(text_search.Key_Boolean_dictindx3('calbus'),10));
output(choosen(text_search.Key_Boolean_dtldictx('calbus'),10));
//output(choosen(text_search.Key_Boolean_nidx2('calbus'),10));
output(choosen(text_search.Key_Boolean_nidx3('calbus'),10));
output(choosen(CALBUS.Key_Boolean_Map,10));
output(choosen(calbus.Key_Calbus_Account_Nbr,10));
	output(choosen(text_search.Key_Boolean_EKeyIn('calbus'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('calbus'),10));
endmacro;