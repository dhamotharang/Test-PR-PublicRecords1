export TxbusKeys := macro
//output(choosen(text_search.Key_Boolean_dictindx('txbus'),10));
output(choosen(text_search.Key_Boolean_dstat('txbus'),10));
output(choosen(text_search.key_Boolean_SegList('txbus'),10));
//output(choosen(text_search.Key_Boolean_nidx('txbus'),10));
output(choosen(text_search.Key_Boolean_dictindx3('txbus'),10));
output(choosen(text_search.Key_Boolean_dtldictx('txbus'),10));
//output(choosen(text_search.Key_Boolean_nidx2('txbus'),10));
output(choosen(text_search.Key_Boolean_nidx3('txbus'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('txbus'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('txbus'),10));
output(choosen(txbus.key_boolean_map,10));
output(choosen(txbus.Key_Txbus_Taxpayer_Nbr,10));
endmacro;