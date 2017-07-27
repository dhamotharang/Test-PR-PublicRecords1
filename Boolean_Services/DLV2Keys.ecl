export DLV2Keys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('dlv2'),10));
output(choosen(text_search.Key_Boolean_dstat('dlv2'),10));
output(choosen(text_search.Key_Boolean_seglist('dlv2'),10));
//output(choosen(text_search.Key_Boolean_nidx('dlv2'),10));
output(choosen(text_search.Key_Boolean_dictindx3('dlv2'),10));
output(choosen(text_search.Key_Boolean_dtldictx('dlv2'),10));
//output(choosen(text_search.Key_Boolean_nidx2('dlv2'),10));
output(choosen(text_search.Key_Boolean_nidx3('dlv2'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('dlv2'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('dlv2'),10));
output(choosen(driversv2.Key_DL_Seq,10));
output(choosen(DriversV2.Key_DL_DID,10));
endmacro;