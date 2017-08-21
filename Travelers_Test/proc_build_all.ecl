import VersionControl;

export proc_build_all(

	 string		pversion
	,boolean	pOverwrite = false
	,boolean	pUseOtherEnvironment = false


) :=
module
	
	shared linputfile := files(,pUseOtherEnvironment).input.sprayed;
	
	export lNormalize_Input_Names			:= Normalize_Input.Names				(linputfile							);
	export lStandardize_Input					:= Standardize_Input.fAll				(lNormalize_Input_Names	);
	export lAppend_Ids								:= Append_Ids										(lStandardize_Input			);
	export lfillholesformeraddr				:= Fill_Holes.Get_Former_Address(lAppend_Ids						);
	export lfillholesssn							:= Fill_Holes.Get_SSN						(lfillholesformeraddr		);
	export lfillholesMisc							:= Fill_Holes.Get_Misc					(lfillholesssn					);
	export lfillholesDLState					:= Fill_Holes.Get_DL_State			(lfillholesMisc					);


	export lNormalize_Input_Vehicles	:= Normalize_Input.Vehicles			(files(,pUseOtherEnvironment).input.sprayed	);
	export lGet_Vin_Stuff							:= Fill_Holes.Get_Vin_Stuff			(lNormalize_Input_Vehicles									);
	
	export lreadyoutput								:= Ready_Output(lfillholesDLState,lGet_Vin_Stuff,linputfile);
	
	shared dsortSubject		:= sort(lfillholesDLState	, quoteback);
	shared dsortVehicles	:= sort(lGet_Vin_Stuff		, quoteback,vehicle_num);

	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.new							,dsortSubject	,Build_out_File			,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.new + '::vehs'	,dsortVehicles,Build_out_veh_File	,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.new + '::all'		,lreadyoutput	,Build_out_all_File	,pOverwrite := pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.new + '::allpipedelimited'		,lreadyoutput	,Build_out_all_File_Pipe	,pOverwrite := pOverwrite,pCsvout := true,pSeparator := '|');
                                                              
	// -- stats
	dinputstats		:= Travelers_Test.Stats(linputfile		,'Input'	);
	doutputstats	:= Travelers_Test.Stats(lreadyoutput	,'Output'	);
	
	dallstats := dinputstats + doutputstats;
	
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).stats.new		,dallstats	,Build_stats_File	,pOverwrite := pOverwrite);
	
	export build_all :=
	sequential(
		 Build_out_File    	
		,Build_out_veh_File	   
		,Build_out_all_File	   
		,Build_out_all_File_Pipe
		,Build_stats_File		   
	);
	
																															
end;