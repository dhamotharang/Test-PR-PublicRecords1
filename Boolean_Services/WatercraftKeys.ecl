export WatercraftKeys := macro
//output(choosen(text_search.Key_Boolean_dictindx('watercraft'),10));
output(choosen(watercraft.key_boolean_uid,10));
output(text_search.Key_Boolean_dstat('watercraft'));
output(text_search.Key_Boolean_seglist('watercraft'));
//output(choosen(text_search.Key_Boolean_nidx('watercraft'),10));
//output(choosen(text_search.Key_Boolean_nidx2('watercraft'),10));
output(choosen(text_search.Key_Boolean_nidx3('watercraft'),10));
output(choosen(text_search.Key_Boolean_dictindx3('watercraft'),10));
output(choosen(text_search.Key_Boolean_dtldictx('watercraft'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('watercraft'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('watercraft'),10));
output(choosen(watercraft.key_watercraft_cid(),10));
output(choosen(watercraft.key_watercraft_sid(),10));
output(choosen(watercraft.key_watercraft_wid(),10));
endmacro;