import lib_fileservices,_control,lib_stringlib,versioncontrol;

export CreateSuperFileNames := module

	export Create_Input_Superfiles(string st)	:=	function
		/* 
			Creates an empty superfile; The false optional parameter indicates whether the sub-files 
      must be sequentiallynumbered; The last optional parameter is missing and defaults to false
			indicating that an error is posted if the superfile already exists.
		*/
		CreateInputSuper := nothor(apply(Laboractions_msha.filenames(st,).Input.dAll_superfilenames, versioncontrol.mUtilities.createsuper(name)));
		/* 
			Checks the existence of the superfile; if the superfile doesn't exist it CreateSuper is called
			(see above).
		*/								
		CreateInputSuperfileIfNotExist := if(NOT FileServices.SuperFileExists(laboractions_msha.filenames(st,).Input.Sprayed),CreateInputSuper);
		
		return CreateInputSuperfileIfNotExist;		
	end;

	export Create_Base_Superfiles(string st)	:=	function
		/* 
			Creates an empty superfile; The false optional parameter indicates whether the sub-files 
      must be sequentiallynumbered; The last optional parameter is missing and defaults to false
			indicating that an error is posted if the superfile already exists.
		*/
		CreateBaseSuper	 := nothor(apply(Laboractions_msha.filenames(st,).Base.dAll_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))));
		/* 
			Checks the existence of the superfile; if the superfile doesn't exist it CreateSuper is called
			(see above).
		*/								
		CreateBaseSuperfileIfNotExist := if(NOT FileServices.SuperFileExists(laboractions_msha.filenames(st,).Base.qa),CreateBaseSuper);
		
		return CreateBaseSuperfileIfNotExist;		
	end;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	///// Spray all msha files sequentially 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	export fCreateInputBaseSuperfiles	:=	function

		create_all_msha_input_base_superfiles := 	sequential(
																	 Create_Input_Superfiles('accident')
																	,Create_Input_Superfiles('contractor')
																	,Create_Input_Superfiles('contractor_cy_employment')
																	,Create_Input_Superfiles('contractor_qt_employment')
																	,Create_Input_Superfiles('controller_hist')
																	,Create_Input_Superfiles('inspection')
																	,Create_Input_Superfiles('mine')
																	,Create_Input_Superfiles('operator_cy_employment')
																	,Create_Input_Superfiles('operator_hist')
																	,Create_Input_Superfiles('operator_qt_employment')
																	,Create_Input_Superfiles('violation')
																	,Create_Base_Superfiles('base_accident')
																	,Create_Base_Superfiles('base_contractor')																
																	,Create_Base_Superfiles('base_events')
																	,Create_Base_Superfiles('base_mine')	
																	,Create_Base_Superfiles('base_operator')	
																);
																
	return create_all_msha_input_base_superfiles;
	end;

end;