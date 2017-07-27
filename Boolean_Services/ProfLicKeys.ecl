export ProfLicKeys := macro
//output(choosen(text_search.Key_Boolean_dictindx('prolic'),10));
output(choosen(text_search.Key_Boolean_dstat('prolic'),10));
output(choosen(text_search.key_Boolean_SegList('prolic'),10));
//output(choosen(text_search.Key_Boolean_nidx('prolic'),10));
output(choosen(text_search.Key_Boolean_dictindx3('prolic'),10));
output(choosen(text_search.Key_Boolean_dtldictx('prolic'),10));
//output(choosen(text_search.Key_Boolean_nidx2('prolic'),10));
output(choosen(text_search.Key_Boolean_nidx3('prolic'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('prolic'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('prolic'),10));
output(choosen(prof_licensev2.Key_Boolean_Map,10));
output(choosen(Prof_LicenseV2.Key_ProfLic_Id,10));
endmacro;


