export Update_Base_Events (
											dataset(Layouts_Mine.Input)					pUpdate_Mine,
											dataset(Layouts_Inspection.Input)		pUpdate_Inspection,
											dataset(Layouts_Violation.Input)		pUpdate_Violation,
											dataset(Layouts_Base_Events.Base)		pBaseFile_Events,
											string pversion) := function

	dStandardizedInputFile_Events  := LaborActions_MSHA.StandardizeInputFile_Events.fAll(
																														pUpdate_Mine
																													 ,pUpdate_Inspection
																													 ,pUpdate_Violation
																													 ,pversion);

	update_combined_Events					:= if(LaborActions_MSHA._Flags('Mine','Base_Events').Update	
																				,dStandardizedInputFile_Events + pBaseFile_Events
																				,dStandardizedInputFile_Events
																			 ) : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Update_Combined_Events');
	
	dRollupBase_Events							:= Rollup_Base_Events	(update_combined_Events);
   
	return dRollupBase_Events;
end;