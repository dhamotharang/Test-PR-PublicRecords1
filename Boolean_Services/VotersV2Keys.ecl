export VotersV2Keys := macro

output(choosen(text_search.key_Boolean_SegList('votersv2'),10));
//output(choosen(text_search.Key_Boolean_dictindx('votersv2'),10));
output(choosen(text_search.Key_Boolean_dstat('votersv2'),10));
//output(choosen(text_search.Key_Boolean_nidx('votersv2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('votersv2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('votersv2'),10));
// output(choosen(text_search.Key_Boolean_nidx2('votersv2'),10));
output(choosen(text_search.Key_Boolean_nidx3('votersv2'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('votersv2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('votersv2'),10));
output(choosen(votersv2.Key_Boolean_vtid_Map,10));
output(choosen(votersv2.Key_Voters_VTID,10));
endmacro;