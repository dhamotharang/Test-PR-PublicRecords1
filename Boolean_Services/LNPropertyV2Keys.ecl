export LNPropertyV2Keys := macro
//output(choosen(text_search.Key_Boolean_dictindx2('ln_propertyv2::assessment'),10));
//output(choosen(text_search.Key_Boolean_nidx2('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_nidx3('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_dstat('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_Seglist('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_dictindx3('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_dtldictx('ln_propertyv2::assessment'),10));
//output(choosen(text_search.Key_Boolean_dictindx2('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_dictindx3('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_dtldictx('ln_propertyv2::deeds'),10));
//output(choosen(text_search.Key_Boolean_nidx2('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_nidx3('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_dstat('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_Seglist('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_EKeyIn('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('ln_propertyv2::deeds'),10));
output(choosen(text_search.Key_Boolean_EKeyIn('ln_propertyv2::assessment'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('ln_propertyv2::assessment'),10));

output(choosen(ln_propertyv2.Key_Boolean_Map,10));
output(choosen(ln_propertyv2.Key_Deed_Boolean_Map,10));
output(choosen(LN_PropertyV2.key_addl_fares_deed_fid,10));
output(choosen(LN_PropertyV2.key_addl_fares_tax_fid,10));
output(choosen(LN_PropertyV2.key_addl_legal_fid,10));
output(choosen(LN_PropertyV2.key_assessor_fid,10));
output(choosen(LN_PropertyV2.key_deed_fid,10));
output(choosen(LN_PropertyV2.key_search_fid,10));
// output(choosen(LN_PropertyV2.key_addl_fares_deed_plus_fid,10));
// output(choosen(LN_PropertyV2.key_addl_fares_tax_plus_fid,10));
// output(choosen(LN_PropertyV2.key_assessor_plus_fid,10));
output(choosen(LN_PropertyV2.key_addl_names,10));
endmacro;