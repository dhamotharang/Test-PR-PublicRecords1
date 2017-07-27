export SanctnKeys := macro
		//output(choosen(text_search.Key_Boolean_dictindx('sanctn'),10));
		output(choosen(text_search.Key_Boolean_dstat('sanctn'),10));
	output(choosen(text_search.Key_Boolean_Seglist('sanctn'),10));
	//output(choosen(text_search.Key_Boolean_nidx('sanctn'),10));
	// output(choosen(text_search.Key_Boolean_dictindx3('sanctn'),10));
output(choosen(text_search.Key_Boolean_dictindx3('sanctn'),10));
output(choosen(text_search.Key_Boolean_dtldictx('sanctn'),10));
//output(choosen(text_search.Key_Boolean_nidx2('sanctn'),10));
output(choosen(text_search.Key_Boolean_nidx3('sanctn'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('sanctn'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('sanctn'),10));
		output(choosen(sanctn.Key_SANCTN_Map,10));
		output(choosen(sanctn.Key_SANCTN_incident,10));
		output(choosen(sanctn.Key_SANCTN_party,10));
endmacro;