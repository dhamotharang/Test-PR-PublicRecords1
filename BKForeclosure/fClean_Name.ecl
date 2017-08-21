IMPORT ut, address,nid,BKForeclosure,BIPV2;

EXPORT fClean_Name := module

//Clean Reo name fields
EXPORT REO(DATASET(RECORDOF(Layout_BK.Norm_Addr_reo)) dNormFile) := FUNCTION
CleanNames_full  := Nid.fn_CleanFullNames(dNormFile,name_full,,,,,,,,,,,,,,TRUE,FALSE,,TRUE,,useV2 := true);
Cln_reo          := PROJECT(CleanNames_full,layout_BK.ClnName_REO);
// ds_reo := output(Cln_reo,,'~thor_data400::in::BKForeclosure::Cln_Name_Reo_test',overwrite);
RETURN Cln_reo;
END;


//Clean Nod name fields
EXPORT NOD(DATASET(RECORDOF(Layout_BK.Norm_Addr_nod)) dNormFile) := FUNCTION
CleanNames_full  := Nid.fn_CleanFullNames(dNormFile,name_full,,,,,,,,,,,,,,TRUE,FALSE,,TRUE,,useV2 := true);
Cln_NOD          := PROJECT(CleanNames_full,layout_BK.ClnName_NOD);
// ds_nod := OUTPUT(Cln_Nod,,'~thor_data400::in::BKForeclosure::Cln_Name_Nod_test',overwrite);
RETURN Cln_NOD;
END;

END;