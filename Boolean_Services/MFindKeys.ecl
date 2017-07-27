export MFindKeys := macro
	output(choosen(mfind.key_boolean_tmsid,10));
	//output(choosen(text_search.Key_Boolean_dictindx('mfind'),10));
	output(choosen(text_search.Key_Boolean_seglist('mfind'),10));
	output(choosen(text_search.Key_Boolean_dstat('mfind'),10));
	//output(choosen(text_search.Key_Boolean_nidx('mfind'),10));
	//output(choosen(text_search.Key_Boolean_nidx2('mfind'),10));
	output(choosen(text_search.Key_Boolean_nidx3('mfind'),10));
output(choosen(text_search.Key_Boolean_dictindx3('mfind'),10));
output(choosen(text_search.Key_Boolean_dtldictx('mfind'),10));
	output(choosen(Mfind.Key_MFind_VID,10));
	output(choosen(text_search.Key_Boolean_EKeyIn('mfind'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('mfind'),10));
endmacro;