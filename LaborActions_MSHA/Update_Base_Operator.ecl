export Update_Base_Operator(
										dataset(Layouts_Mine.Input)						 				pUpdate_Mine,
										dataset(Layouts_Operator_CY_Employment.Input) pUpdate_Operator_CY_Employment,
										dataset(Layouts_Operator_QT_Employment.Input) pUpdate_Operator_QT_Employment,
										dataset(Layouts_Base_Operator.Base)					 	pBaseFile_Operator,
										string pversion) := function

	dStandardizedInputFile_Operator  := LaborActions_MSHA.StandardizeInputFile_Operator.fAll(
																													  pUpdate_Mine
																													 ,pUpdate_Operator_CY_Employment
																													 ,pUpdate_Operator_QT_Employment
																													 ,pversion);
	
	update_combined_Operator				 := if(LaborActions_MSHA._Flags('Mine','Base_Operator').Update
																					,dStandardizedInputFile_Operator + pBaseFile_Operator
																					,dStandardizedInputFile_Operator
																				 ) 	: persist(_dataset().thor_cluster_Persists + 'persist::LaborActions_MSHA::Update_Combined_Operator');
	
	dRollupBase_Operator						 := Rollup_Base_Operator	(update_combined_Operator);
   
	return dRollupBase_Operator;
end;