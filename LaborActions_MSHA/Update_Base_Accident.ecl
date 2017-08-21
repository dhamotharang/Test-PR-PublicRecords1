export Update_Base_Accident(
										dataset(Layouts_Mine.Input)						pUpdate_Mine,
										dataset(Layouts_Accident.Input)				pUpdate_Accident,
										dataset(Layouts_Base_Accident.Base)		pBaseFile_Accident,
										string pversion
									) := function

	dStandardizedInputFile_Accident  := LaborActions_MSHA.StandardizeInputFile_Accident.fAll(
																													  pUpdate_Mine
																													 ,pUpdate_Accident
																													 ,pversion);
	
	update_combined_Accident				 :=	if(LaborActions_MSHA._Flags('Mine','Base_Accident').Update
																		,dStandardizedInputFile_Accident + pBaseFile_Accident
																		,dStandardizedInputFile_Accident
																)  : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Update_Combined_Accident');
	
	dRollupBase_Accident						 := Rollup_Base_Accident (update_combined_Accident);
   
	return dRollupBase_Accident;
end;