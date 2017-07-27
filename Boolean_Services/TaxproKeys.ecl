export TaxproKeys := macro
//output(choosen(text_search.Key_Boolean_dictindx('taxpro'),10));
output(choosen(text_search.Key_Boolean_dstat('taxpro'),10));
output(choosen(text_search.key_Boolean_SegList('taxpro'),10));
//output(choosen(text_search.Key_Boolean_nidx('taxpro'),10));
// output(choosen(text_search.Key_Boolean_nidx2('taxpro'),10));
output(choosen(text_search.Key_Boolean_nidx3('taxpro'),10));
output(choosen(text_search.Key_Boolean_dictindx3('taxpro'),10));
output(choosen(text_search.Key_Boolean_dtldictx('taxpro'),10));
output(choosen(taxpro.key_boolean_taxpro_map,10));
output(choosen(taxpro.Key_Tmsid,10));
output(choosen(text_search.Key_Boolean_EKeyIn('taxpro'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('taxpro'),10));
endmacro;