import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile_Accident := module	

	export fPreProcess(
										 dataset(LaborActions_MSHA.Layouts_Mine.Input) 			pRawFileInput_Mine
										,dataset(LaborActions_MSHA.Layouts_Accident.Input)	pRawFileInput_Accident
										,string pversion) := function    

		Std_Mine 				:= Standardize_Mine.fAll(pRawFileInput_Mine);
		Std_Accident	 	:= Standardize_Accident.fAll(pRawFileInput_Accident);

		Joined_File_Accident := fJoin_Accident(
																					 Std_Mine
																					,Std_Accident
																					,pversion
																					);
		
		return Joined_File_Accident;

	end; //end fPreProcess function
	
 	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) 			pRawFileInput_Mine
							,dataset(LaborActions_MSHA.Layouts_Accident.Input) 	pRawFileInput_Accident
							,string pversion) := function

		dPreprocess	:= fPreProcess(pRawFileInput_Mine
															,pRawFileInput_Accident
															,pversion);

		return dPreprocess;

	end; //end fAll

end; //end StandardizeInputFile_Accident 