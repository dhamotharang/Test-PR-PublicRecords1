import versioncontrol,tools;

export Filenames(string pVersion = '', boolean pFCRA = false, boolean pDaily = true) := module

	shared fcra 			:= if(pFCRA, '::fcra::', '::nonfcra::');
	shared bldtype		:= if(pDaily, 'daily::', 'weekly::');
		
	shared INQL_lBase 							:= INQL_v2._Constants.prefix + 'base::' + INQL_v2._Constants.DatasetName + fcra;
	shared INQL_lBaseTemplate				:= INQL_lBase + bldtype + '@version@';
	export INQL_Base								:= tools.mod_FilenamesBuild(INQL_lBaseTemplate, pVersion);
	export INQL_Base_Daily_history	:= INQL_lBase + 'daily::history';
	export INQL_Base_In_Bldg				:= INQL_lBase + if(pDaily, 'In_Bldg_Daily', 'In_Bldg_Weekly');	
	
	shared SBA_lBase 					:= INQL_v2._Constants.prefix + 'base::SBA' + fcra;
	shared SBA_lBaseTemplate	:= SBA_lBase + bldtype + '@version@';
	export SBA_Base						:= tools.mod_FilenamesBuild(SBA_lBaseTemplate, pVersion);
	
	shared Batch_PIIs_lBase 					:= INQL_v2._Constants.prefix + 'base::Batch_PIIs' + fcra;
	shared Batch_PIIs_lBaseTemplate	  := Batch_PIIs_lBase + bldtype + '@version@';
	export Batch_PIIs_Base						:= tools.mod_FilenamesBuild(Batch_PIIs_lBaseTemplate, pVersion);	
	
	shared MBS_Deconfliction_lBase 					:= INQL_v2._Constants.prefix + 'base::mbs::Deconfliction' + fcra;
	shared MBS_Deconfliction_lBaseTemplate	:= MBS_Deconfliction_lBase + bldtype + '@version@';
	export MBS_Deconfliction_Base						:= tools.mod_FilenamesBuild(MBS_Deconfliction_lBaseTemplate, pVersion);
	
	shared MBS_Transaction_lBase 					:= INQL_v2._Constants.prefix + 'base::mbs::Transaction' + fcra;
	shared MBS_Transaction_lBaseTemplate	:= MBS_Transaction_lBase + bldtype + '@version@';
	export MBS_Transaction_Base						:= tools.mod_FilenamesBuild(MBS_Transaction_lBaseTemplate, pVersion);
    
  export DeployedDelta := INQL_v2._Constants.prefix + 'out' + fcra + 'last_delta_deployed';
	
end;
