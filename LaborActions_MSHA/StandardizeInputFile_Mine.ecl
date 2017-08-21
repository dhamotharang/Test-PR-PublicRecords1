import Address, Ut, lib_word, lib_stringlib, _Control, business_header,_Validate, idl_header;

export StandardizeInputFile_Mine := module

	export fPreProcess(dataset(LaborActions_MSHA.Layouts_Mine.Input) 							pRawFileInput_Mine
										,dataset(LaborActions_MSHA.Layouts_Controller_Hist.Input) 	pRawFileInput_Controller_Hist
										,dataset(LaborActions_MSHA.Layouts_Operator_Hist.Input) 		pRawFileInput_Operator_Hist
										,string pversion) := function  

		Std_Mine 						:= Standardize_Mine.fAll(pRawFileInput_Mine);
		Std_Controller_Hist := Standardize_Controller_Hist.fAll(pRawFileInput_Controller_Hist);
		Std_Operator_Hist	 	:= Standardize_Operator_Hist.fAll(pRawFileInput_Operator_Hist);
	
		Joined_File_Mine := fJoin_Mine_ControllerHist_OperatorHist(
																								Std_Mine
																							 ,Std_Controller_Hist
																							 ,Std_Operator_Hist
																							 ,pversion);
		return Joined_File_Mine;

	end; //end fPreProcess function
	
		
 	export fAll( dataset(LaborActions_MSHA.Layouts_Mine.Input) 										pRawFileInput_Mine
							,dataset(LaborActions_MSHA.Layouts_Controller_Hist.Input) 				pRawFileInput_Controller_Hist
							,dataset(LaborActions_MSHA.Layouts_Operator_Hist.Input) 					pRawFileInput_Operator_Hist
							,string pversion) := function

		dPreprocess	:= fPreProcess(pRawFileInput_Mine
															,pRawFileInput_Controller_Hist
															,pRawFileInput_Operator_Hist
															,pversion);

		return dPreprocess;

	end; //end fAll

end; //end StandardizeInputFile_Mine 