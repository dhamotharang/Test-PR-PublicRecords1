import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile_Events := module	

	export fPreProcess(
										 dataset(LaborActions_MSHA.Layouts_Mine.Input) 				pRawFileInput_Mine
										,dataset(LaborActions_MSHA.Layouts_Inspection.Input) 	pRawFileInput_Inspection
										,dataset(LaborActions_MSHA.Layouts_Violation.Input) 	pRawFileInput_Violation
										,string pversion) := function    

		Std_Mine 				:= Standardize_Mine.fAll(pRawFileInput_Mine);
		Std_Inspection 	:= Standardize_Inspection.fAll(pRawFileInput_Inspection);
		Std_Violation	 	:= Standardize_Violation.fAll(pRawFileInput_Violation);

		Joined_File_Events := fJoin_Inspection_Violation(
																								Std_Mine
																							 ,Std_Inspection
																							 ,Std_Violation
																							 ,pversion
																							 );
		
		return Joined_File_Events;

	end; //end fPreProcess function
	
 	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) 				pRawFileInput_Mine
							,dataset(LaborActions_MSHA.Layouts_Inspection.Input) 	pRawFileInput_Inspection
							,dataset(LaborActions_MSHA.Layouts_Violation.Input) 	pRawFileInput_Violation
							,string pversion) := function

		dPreprocess	:= fPreProcess(pRawFileInput_Mine
															,pRawFileInput_Inspection
															,pRawFileInput_Violation
															,pversion);

		return dPreprocess;

	end; //end fAll

end; //end StandardizeInputFile_Events 