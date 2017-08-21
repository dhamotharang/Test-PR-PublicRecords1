import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile_Operator := module

	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Mine.Input) 										pRawFileInput_Mine
										,dataset(LaborActions_MSHA.Layouts_Operator_CY_Employment.Input) 	pRawFileInput_Operator_CY_Employment
										,dataset(LaborActions_MSHA.Layouts_Operator_QT_Employment.Input)	pRawFileInput_Operator_QT_Employment
										,string pversion) := function  

		Std_Mine 	:= Standardize_Mine.fAll(pRawFileInput_Mine);
		Std_Operator_CY_Employment	:= Standardize_Operator_CY_Employment.fAll(pRawFileInput_Operator_CY_Employment);
		Std_Operator_QT_Employment	:= Standardize_Operator_QT_Employment.fAll(pRawFileInput_Operator_QT_Employment);
	
		Joined_File_Operator := fJoin_Operator_CY_QT(Std_Mine
																								,Std_Operator_CY_Employment
																								,Std_Operator_QT_Employment
																								,pversion);
																								
		return Joined_File_Operator;

	end; //end fPreProcess function
	
		
 	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) 										pRawFileInput_Mine
							,dataset(LaborActions_MSHA.Layouts_Operator_CY_Employment.Input) 	pRawFileInput_Operator_CY_Employment
							,dataset(LaborActions_MSHA.Layouts_Operator_QT_Employment.Input)	pRawFileInput_Operator_QT_Employment
							,string pversion) := function

		dPreprocess	:= fPreProcess(pRawFileInput_Mine
															,pRawFileInput_Operator_CY_Employment
															,pRawFileInput_Operator_QT_Employment
															,pversion);

		return dPreprocess;

	end; //end fAll

end; //end StandardizeInputFile_Operator 