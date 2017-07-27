export UCCV2Keys := macro
//output(choosen(text_search.Key_Boolean_dictindx('uccv2'),10));
output(choosen(text_search.Key_Boolean_dstat('uccv2'),10));
output(choosen(text_search.key_Boolean_SegList('uccv2'),10));
//output(choosen(text_search.Key_Boolean_nidx('uccv2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('uccv2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('uccv2'),10));
//output(choosen(text_search.Key_Boolean_nidx2('uccv2'),10));
output(choosen(text_search.Key_Boolean_nidx3('uccv2'),10));
output(choosen(uccv2.key_boolean_map,10));
output(choosen(uccv2.Key_Rmsid_Main(),10));
output(choosen(uccv2.Key_Rmsid_party(),10));
output(choosen(text_search.Key_Boolean_EKeyIn('uccv2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('uccv2'),10));
endmacro;