export IngenixKeys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('ingenix::sanctions'),10));
output(choosen(text_search.Key_Boolean_dstat('ingenix::sanctions'),10));
output(choosen(text_search.key_Boolean_SegList('ingenix::sanctions'),10));
//output(choosen(text_search.Key_Boolean_nidx('ingenix::sanctions'),10));
//output(choosen(text_search.Key_Boolean_dictindx('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_dstat('ingenix::provider'),10));
output(choosen(text_search.key_Boolean_SegList('ingenix::provider'),10));
//output(choosen(text_search.Key_Boolean_nidx('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_dictindx3('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_dtldictx('ingenix::provider'),10));
//output(choosen(text_search.Key_Boolean_nidx2('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_nidx3('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_dictindx3('ingenix::sanctions'),10));
output(choosen(text_search.Key_Boolean_dtldictx('ingenix::sanctions'),10));
//output(choosen(text_search.Key_Boolean_nidx2('ingenix::sanctions'),10));
output(choosen(text_search.Key_Boolean_nidx3('ingenix::sanctions'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('ingenix::provider'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('ingenix::provider'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('ingenix::sanctions'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('ingenix::sanctions'),10));
output(choosen(ingenix_natlprof.Key_Boolean_Map,10));
output(choosen(ingenix_natlprof.Key_Boolean_Provider_Map,10));
output(choosen(doxie_files.key_provider_id,10));
output(choosen(ingenix_natlprof.key_license_providerid,10));
output(choosen(doxie_files.key_sanctions_sancid,10));
output(choosen(Ingenix_NatlProf.key_NPI_providerid,10));
output(choosen(Ingenix_NatlProf.key_ProviderID_UPIN,10));
endmacro;