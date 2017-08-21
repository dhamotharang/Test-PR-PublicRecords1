import tools;

export Keynames(string pversion = '', boolean pUseProd = false, boolean pUseDelta = false) := module

	shared suffix := if(pUseDelta, '::delta::@version@::', '::@version@::');
	
	export mo_file		:= '~thor_data400::key::'	+ _Dataset().name + '::mo' + suffix;
	
	export mo_file_v2	:= '~thor_data400::key::'	+ _Dataset().name + '::mo::v2' + suffix;
	
	export wd_file		:= '~thor_data400::key::'	+ _Dataset().name + '::vehicle' + suffix;
	
	shared mo_leid_key									:= mo_file+'eid';
	export mo_eid_key										:= tools.mod_FilenamesBuild(mo_leid_key,pversion);
	export mo_eid_dAll_filenames				:= mo_eid_key.dAll_filenames;
	
	shared mo_lphone_key								:= mo_file+'phone';
	export mo_phone_key									:= tools.mod_FilenamesBuild(mo_lphone_key,pversion);
	export mo_phone_dAll_filenames			:= mo_phone_key.dAll_filenames;
	
	shared mo_leid_v2_key								:= mo_file_v2+'eid';
	export mo_eid_v2_key								:= tools.mod_FilenamesBuild(mo_leid_v2_key,pversion);
	export mo_eid_v2_dAll_filenames			:= mo_eid_v2_key.dAll_filenames;
	
	shared mo_lphone_v2_key							:= mo_file_v2+'phone';
	export mo_phone_v2_key							:= tools.mod_FilenamesBuild(mo_lphone_v2_key,pversion);
	export mo_phone_v2_dAll_filenames		:= mo_phone_v2_key.dAll_filenames;
	
	shared wd_lveh_key									:= wd_file+'wild';
	export wd_veh_key										:= tools.mod_FilenamesBuild(wd_lveh_key,pversion);
	export wd_veh_dAll_filenames				:= wd_veh_key.dAll_filenames;

	shared wd_lbody_key									:= wd_file+'body';
	export wd_body_key									:= tools.mod_FilenamesBuild(wd_lbody_key,pversion);
	export wd_body_dAll_filenames				:= wd_body_key.dAll_filenames;
	
	shared wd_lmake_key									:= wd_file+'make';
	export wd_make_key									:= tools.mod_FilenamesBuild(wd_lmake_key,pversion);
	export wd_make_dAll_filenames				:= wd_make_key.dAll_filenames;
	
	shared wd_lmodel_key								:= wd_file+'model';
	export wd_model_key									:= tools.mod_FilenamesBuild(wd_lmodel_key,pversion);
	export wd_model_dAll_filenames			:= wd_model_key.dAll_filenames;
	
end;
