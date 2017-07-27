export fbn2Keys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('fbn'),10));
output(choosen(text_search.Key_Boolean_dstat('fbn'),10));
output(choosen(text_search.Key_Boolean_seglist('fbn'),10));
//output(choosen(text_search.Key_Boolean_nidx('fbn'),10));
output(choosen(text_search.Key_Boolean_dictindx3('fbn'),10));
output(choosen(text_search.Key_Boolean_dtldictx('fbn'),10));
//output(choosen(text_search.Key_Boolean_nidx2('fbn'),10));
output(choosen(text_search.Key_Boolean_nidx3('fbn'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('fbn'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('fbn'),10));
//output(text_search.File_Boolean_dstat('fbn'));
output(choosen(fbnv2.Key_Boolean_Fbnkey_map,10));
//output(text_search.File_Boolean_SegList('fbn'));
output(choosen(fbnv2.Key_Rmsid_Business,10));
output(choosen(fbnv2.Key_Rmsid_contact,10));
endmacro;