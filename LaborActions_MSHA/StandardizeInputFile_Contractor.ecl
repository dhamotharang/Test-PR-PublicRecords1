import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile_Contractor := module	

	export fPreProcess(
										 dataset(LaborActions_MSHA.Layouts_Mine.Input) 											pRawFileInput_Mine
										,dataset(LaborActions_MSHA.Layouts_Contractor.Input) 								pRawFileInput_Contractor
										,dataset(LaborActions_MSHA.Layouts_Contractor_CY_Employment.Input) 	pRawFileInput_Contractor_CY_Employment
										,dataset(LaborActions_MSHA.Layouts_Contractor_QT_Employment.Input) 	pRawFileInput_Contractor_QT_Employment
										,string pversion) := function    

		Std_Mine 				:= Standardize_Mine.fAll(pRawFileInput_Mine);
		Std_Contractor 	:= Standardize_Contractor.fAll(pRawFileInput_Contractor);
		Std_Contractor_CY_Employment := Standardize_Contractor_CY_Employment.fAll(pRawFileInput_Contractor_CY_Employment);
		Std_Contractor_QT_Employment := Standardize_Contractor_QT_Employment.fAll(pRawFileInput_Contractor_QT_Employment);

		Joined_File_Contractor := fJoin_Contractor_CY_QT(Std_Mine
																							 ,Std_Contractor
																							 ,Std_Contractor_CY_Employment
																							 ,Std_Contractor_QT_Employment
																							 ,pversion);
		
		return Joined_File_Contractor;

	end; //end fPreProcess function
	
 	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) 											pRawFileInput_Mine							
							,dataset(LaborActions_MSHA.Layouts_Contractor.Input) 								pRawFileInput_Contractor
							,dataset(LaborActions_MSHA.Layouts_Contractor_CY_Employment.Input) 	pRawFileInput_Contractor_CY_Employment
							,dataset(LaborActions_MSHA.Layouts_Contractor_QT_Employment.Input) 	pRawFileInput_Contractor_QT_Employment
							,string pversion) := function

		dPreprocess	:= fPreProcess(pRawFileInput_Mine
															,pRawFileInput_Contractor
															,pRawFileInput_Contractor_CY_Employment
															,pRawFileInput_Contractor_QT_Employment
															,pversion);

		return dPreprocess;

	end; //end fAll

end; //end StandardizeInputFile_Contractor 