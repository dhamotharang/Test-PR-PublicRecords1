IMPORT $, RoxieKeyBuild, PromoteSupers, Orbit3;

EXPORT proc_build_all (STRING filedate)	:= FUNCTION
	//Build NOD
	Nod_Base := Build_base_nod.DeNorm_Nod;
	
	PromoteSupers.Mac_SF_BuildProcess(Nod_Base,'~thor_data400::base::bkforeclosure::nod',build_nod_base,3,,true);
	
	NodPopulationStats	:= BKForeclosure.Strata_Population_Stats_Nod(filedate);
	
	Nodbuilt := SEQUENTIAL( OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.Nod_File),NAMED('Total_NOD_in'))
													,BKForeclosure.Fn_NodRaw_scrubs(BKForeclosure.File_BK_Foreclosure.Nod_File, filedate, Roxie_email_list)
													,build_nod_base
													,OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.fNod(Delete_Flag = 'DELETE')),NAMED('TotalDel_NOD_out'))//True Deletes
													,OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.fNod(Delete_Flag <> 'DELETE')),NAMED('Total_NOD_out'))
													,NodPopulationStats
													);
													
	//Build REO
	Reo_Base	:= Build_base_reo.DeNorm_Reo;
	
	PromoteSupers.Mac_SF_BuildProcess(Reo_Base,'~thor_data400::base::bkforeclosure::reo',build_reo_base,3,,true);
	
	ReoPopulationStats	:= BKForeclosure.Strata_Population_Stats_Reo(filedate);
	
	Reobuilt := SEQUENTIAL( OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.Reo_File),NAMED('Total_Reo_in'))
													,BKForeclosure.Fn_ReoRaw_scrubs(BKForeclosure.File_BK_Foreclosure.Reo_File, filedate, Roxie_email_list)
													,build_reo_base
													,OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.fReo(Delete_Flag = 'DELETE')),NAMED('TotalDel_REO_out'))//True Deletes
													,OUTPUT(COUNT(BKForeclosure.File_BK_Foreclosure.fReo(Delete_Flag <> 'DELETE')),NAMED('Total_REO_out'))
													,ReoPopulationStats
													);												

	orbit_update := sequential(Orbit3.Proc_Orbit3_CreateBuild('Black Knight Foreclosures',filedate,is_npf := true)
														);

	BuildAll	:= SEQUENTIAL(Nodbuilt, Reobuilt, orbit_update);
	
RETURN BuildAll;

END;