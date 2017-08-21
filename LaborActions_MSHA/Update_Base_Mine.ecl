export Update_Base_Mine(
										dataset(Layouts_Mine.Input)						 	pUpdate_Mine,
										dataset(Layouts_Controller_Hist.Input) 	pUpdate_Controller_Hist,
										dataset(Layouts_Operator_Hist.Input) 		pUpdate_Operator_Hist,
										dataset(Layouts_Base_Mine.Base)					pBaseFile_Mine,
										string pversion
									) := function

	dStandardizedInputFile_Mine  := 	LaborActions_MSHA.StandardizeInputFile_Mine.fAll(
																													  pUpdate_Mine
																													 ,pUpdate_Controller_Hist
																													 ,pUpdate_Operator_Hist
																													 ,pversion);
	
	update_combined_Mine					:=	if(LaborActions_MSHA._Flags('Mine','Base_Mine').Update
																		,dStandardizedInputFile_Mine + pBaseFile_Mine
																		,dStandardizedInputFile_Mine
																) : persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Update_Combined_Mine');
	
	dRollupBase_Mine							:= 	Rollup_Base_Mine	(update_combined_Mine);
   
	return dRollupBase_Mine;
end;