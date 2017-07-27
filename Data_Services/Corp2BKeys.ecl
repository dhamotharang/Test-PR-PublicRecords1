export Corp2BKeys := macro
	output(choosen(text_search.File_Boolean_dstat('corp2'),10));
	output(choosen(text_search.File_Boolean_dstat1('corp2'),10));
	output(choosen(text_search.File_Boolean_SegList('corp2'),10));
	output(choosen(text_search.Key_Boolean_dictindx('corp2'),10));
	output(choosen(text_search.Key_Boolean_nidx('corp2'),10));
	output(choosen(text_search.Key_Boolean_dstat('corp2'),10));
	output(choosen(Corp2.Key_Boolean_Map,10));
endmacro;