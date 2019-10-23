import versioncontrol,tools, data_services;

export Filenames(string pVersion = '', boolean pFCRA = false, boolean pDaily = true) := module

	shared fcra 					:= if(pFCRA, '::fcra::', '::nonfcra::');
	shared bldtype				:= if(pDaily, 'daily::', 'weekly::');
	
	shared prefix     		:= if( pFCRA or pDaily
															,INQL_v2._Constants.USPR_PREFIX
															,INQL_v2._Constants.NONFCRA_PREFIX);
		
	shared INQL_lBase 		:= if(pFCRA or pDaily
	                           ,prefix + INQL_v2._Constants.DatasetName + fcra + 'base::' // fcra and nonfcra daily - uspr format 
														 ,prefix + 'base::' + INQL_v2._Constants.DatasetName + fcra // nonfcra weekly - thor_data format 
															);

	shared INQL_lBaseTemplate				:= INQL_lBase + bldtype + '@version@';
	export INQL_Base								:= tools.mod_FilenamesBuild(INQL_lBaseTemplate, pVersion);
	export INQL_Base_Daily_history	:= INQL_lBase + 'daily::history';
	export INQL_Base_In_Bldg				:= INQL_lBase + if(pDaily, 'In_Bldg_Daily', 'In_Bldg_Weekly');	

	shared INQL_lBaseHistAppTemplate	:= data_services.foreign_prod+'thor_data400::out::inquiry_tracking::weekly_historical::@version@';	
	export INQL_Base_History_Appended	:= tools.mod_FilenamesBuild(INQL_lBaseHistAppTemplate, pVersion,,2);
	
  shared INQL_lBaseHistNewIdsTemplate	:= data_services.foreign_prod+'thor_data400::out::inquiry_acclogs' + fcra + 'reappend_records::@version@';	
	export INQL_Base_History_NewIds			:= tools.mod_FilenamesBuild(INQL_lBaseHistNewIdsTemplate, pVersion);

	shared SBA_lBaseTemplate	:= INQL_lBase + bldtype + '@version@' + '::sba';
	export SBA_Base						:= tools.mod_FilenamesBuild(SBA_lBaseTemplate, pVersion);

	shared Batch_PIIs_lBaseTemplate					:= INQL_lBase + bldtype + '@version@' + '::batch_PIIs';
	export Batch_PIIs_Base									:= tools.mod_FilenamesBuild(Batch_PIIs_lBaseTemplate, pVersion);	
	
  shared BillGroups_DID_lBaseTemplate			:= INQL_lBase + bldtype + '@version@' + '::BillGroups_DID';
	export BillGroups_DID_Base							:= tools.mod_FilenamesBuild(BillGroups_DID_lBaseTemplate, pVersion);		
	
	shared MBS_Deconfliction_lBase 					:= INQL_v2._Constants.NONFCRA_PREFIX + 'base::mbs::Deconfliction' + fcra;
	shared MBS_Deconfliction_lBaseTemplate	:= MBS_Deconfliction_lBase + bldtype + '@version@';
	export MBS_Deconfliction_Base						:= tools.mod_FilenamesBuild(MBS_Deconfliction_lBaseTemplate, pVersion);
	
	shared MBS_Transaction_lBase 						:= INQL_v2._Constants.NONFCRA_PREFIX + 'base::mbs::Transaction' + fcra;
	shared MBS_Transaction_lBaseTemplate		:= MBS_Transaction_lBase + bldtype + '@version@';
	export MBS_Transaction_Base							:= tools.mod_FilenamesBuild(MBS_Transaction_lBaseTemplate, pVersion);
    
  export DeployedDelta 										:= INQL_v2._Constants.NONFCRA_PREFIX + 'out' + fcra + 'last_delta_deployed';
	
end;
