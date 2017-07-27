export LiensV2Keys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('liensv2'),10));
output(choosen(text_search.Key_Boolean_dstat('liensv2'),10));
output(choosen(text_search.Key_Boolean_seglist('liensv2'),10));
//output(choosen(text_search.Key_Boolean_nidx('liensv2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('liensv2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('liensv2'),10));
//output(choosen(text_search.Key_Boolean_nidx2('liensv2'),10));
output(choosen(text_search.Key_Boolean_nidx3('liensv2'),10));
output(choosen(Liensv2.key_boolean_tmsid,10));
output(choosen(liensv2.key_liens_main_ID,10));
output(choosen(liensv2.key_liens_party_ID,10));
	output(choosen(text_search.Key_Boolean_EKeyIn('liensv2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('liensv2'),10));
endmacro;