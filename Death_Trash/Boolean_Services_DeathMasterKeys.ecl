export DeathMasterKeys := macro
	//output(choosen(text_search.Key_Boolean_dictindx('death_master'),10));
output(choosen(text_search.Key_Boolean_seglist('death_master'),10));
output(choosen(text_search.Key_Boolean_dstat('death_master'),10));
//output(choosen(text_search.Key_Boolean_nidx('death_master'),10));
output(choosen(text_search.Key_Boolean_dictindx3('death_master'),10));
output(choosen(text_search.Key_Boolean_dtldictx('death_master'),10));
//output(choosen(text_search.Key_Boolean_nidx2('death_master'),10));
output(choosen(text_search.Key_Boolean_nidx3('death_master'),10));
	output(choosen(text_search.Key_Boolean_EKeyIn('death_master'),10));
output(choosen(text_search.Key_Boolean_EKeyOut('death_master'),10));
output(choosen(Death_Master.Key_Boolean_ID,10));
output(choosen(death_master.key_death_id_supplemental,10));
output(choosen(death_master.key_death_id_base,10));
output(choosen(Doxie.key_death_masterV2_DID,10));

endmacro;