export Update_Base_Contractor (
											dataset(Layouts_Mine.Input)											pUpdate_Mine,
											dataset(Layouts_Contractor.Input)								pUpdate_Contractor,
											dataset(Layouts_Contractor_CY_Employment.Input)	pUpdate_Contractor_CY_Employment,
											dataset(Layouts_Contractor_QT_Employment.Input)	pUpdate_Contractor_QT_Employment,
											dataset(Layouts_Base_Contractor.Base)						pBaseFile_Contractor,
											string pversion
											) := function

	dStandardizedInputFile_Contractor  := LaborActions_MSHA.StandardizeInputFile_Contractor.fAll(
																														pUpdate_Mine
																													 ,pUpdate_Contractor																													 
																													 ,pUpdate_Contractor_CY_Employment
																													 ,pUpdate_Contractor_QT_Employment
																													 ,pversion);

	update_combined_Contractor				 :=	if(LaborActions_MSHA._Flags('Mine','Base_Contractor').Update	
																					,dStandardizedInputFile_Contractor + pBaseFile_Contractor
																					,dStandardizedInputFile_Contractor
																					) : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Update_Combined_Contractor');
	
	dRollupBase_Contractor						 := Rollup_Base_Contractor (update_combined_Contractor);
   
	return dRollupBase_Contractor;
end;