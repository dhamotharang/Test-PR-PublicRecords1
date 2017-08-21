import tools;

export Keynames(string pversion = '', boolean pUseProd = false, boolean pUseDelta = false) := module

	shared suffix := if(pUseDelta, '::delta::@version@::', '::@version@::');
	
	export cfs_lFileTemplate	    						:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::cfs' + suffix;
	export mo_event_lFileTemplate	    				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::mo' + suffix;
	export mo_udfv2_event_lFileTemplate   		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::mo_udfv2' + if(pUseDelta, '::delta::@version@', '::@version@');
	export persons_event_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::persons' + suffix;
	export persons_udfv2_event_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::persons_udfv2' + if(pUseDelta, '::delta::@version@', '::@version@');
	export vehicle_event_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::vehicle' + suffix;
	export DataProvider_lFileTemplate	     		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::DataProvider::@version@::';
	export group_access_event_lFileTemplate		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::group_access::@version@::';
	export offenders_lFileTemplate	    			:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::offenders' + suffix;
	export intel_lFileTemplate	    					:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::intel' + suffix;
	export crash_lFileTemplate	    					:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::crash' + suffix;
	export licenseplateevent_lFileTemplate 		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::licenseplateevent' + suffix;
	export Shotspotter_lFileTemplate	     		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::Shotspotter' + suffix;
	export notes_lFileTemplate	     					:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::notes' + suffix;
	export images_lFileTemplate	     					:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::images' + suffix;
	export Classification_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::Classification::@version@::';
	export geohash_lFileTemplate	     				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::geohash' + if(pUseDelta, '::delta::@version@', '::@version@');
	export geohash_lpr_lFileTemplate	     		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::geohash::lpr' + if(pUseDelta, '::delta::@version@', '::@version@');
	export cfs_v2_lFileTemplate	    					:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::cfs::v2' + suffix;
	export cfs_officer_v2_lFileTemplate	    	:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::cfs::officer::v2' + suffix;
	export crash_v2_lFileTemplate	    				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::crash::v2' + suffix;
	export crash_per_v2_lFileTemplate	    		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::crash::person::v2' + suffix;
	export crash_veh_v2_lFileTemplate	    		:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::crash::vehicle::v2' + suffix;
	export intel_v2_lFileTemplate	    				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::intel::v2' + suffix;
	
	shared cfs_leid_key														:= cfs_lFileTemplate + 'eid';
	export cfs_eid_key														:= tools.mod_FilenamesBuild(cfs_leid_key	,pversion);
	export cfs_eid_dAll_filenames									:= cfs_eid_key.dAll_filenames;
	
	shared mo_event_leid_key											:= mo_event_lFileTemplate + 'eid';
	export mo_event_eid_key												:= tools.mod_FilenamesBuild(mo_event_leid_key	,pversion);
	export mo_event_eid_dAll_filenames						:= mo_event_eid_key.dAll_filenames;
	
	export mo_udfv2_key														:= tools.mod_FilenamesBuild(mo_udfv2_event_lFileTemplate	,pversion);
	export mo_udfv2_dAll_filenames								:= mo_udfv2_key.dAll_filenames;
	
	shared persons_event_leid_key									:= persons_event_lFileTemplate + 'eid';
	export persons_event_eid_key									:= tools.mod_FilenamesBuild(persons_event_leid_key	,pversion);
	export persons_event_eid_dAll_filenames				:= persons_event_eid_key.dAll_filenames;
	
	export persons_udfv2_key											:= tools.mod_FilenamesBuild(persons_udfv2_event_lFileTemplate	,pversion);
	export persons_udfv2_dAll_filenames						:= persons_udfv2_key.dAll_filenames;
	
	shared vehicle_event_leid_key									:= vehicle_event_lFileTemplate + 'eid';
	export vehicle_event_eid_key									:= tools.mod_FilenamesBuild(vehicle_event_leid_key	,pversion);
	export vehicle_event_eid_dAll_filenames				:= vehicle_event_eid_key.dAll_filenames;
	
	shared DataProvider_lid_key										:= DataProvider_lFileTemplate + 'data_provider_id';
	export DataProvider_id_key										:= tools.mod_FilenamesBuild(DataProvider_lid_key, pversion);
	export DataProvider_id_dAll_filenames					:= DataProvider_id_key.dAll_filenames;	
	
	shared group_access_event_lori_key						:= group_access_event_lFileTemplate + 'ori';
	export group_access_event_ori_key							:= tools.mod_FilenamesBuild(group_access_event_lori_key	,pversion);
	export group_access_event_ori_dAll_filenames	:= group_access_event_ori_key.dAll_filenames;
	
	shared offenders_leid_key											:= offenders_lFileTemplate + 'eid';
	export offenders_eid_key											:= tools.mod_FilenamesBuild(offenders_leid_key	,pversion);
	export offenders_eid_dAll_filenames						:= offenders_eid_key.dAll_filenames;
	
	shared intel_leid_key													:= intel_lFileTemplate + 'eid';
	export intel_eid_key													:= tools.mod_FilenamesBuild(intel_leid_key	,pversion);
	export intel_eid_dAll_filenames								:= intel_eid_key.dAll_filenames;
	
	shared crash_leid_key													:= crash_lFileTemplate + 'eid';
	export crash_eid_key													:= tools.mod_FilenamesBuild(crash_leid_key	,pversion);
	export crash_eid_dAll_filenames								:= crash_eid_key.dAll_filenames;
	
	shared licenseplateevent_leid_key							:= licenseplateevent_lFileTemplate + 'eid';
	export licenseplateevent_eid_key							:= tools.mod_FilenamesBuild(licenseplateevent_leid_key	,pversion);
	export licenseplateevent_eid_dAll_filenames		:= licenseplateevent_eid_key.dAll_filenames;
	
	shared Shotspotter_leid_key										:= Shotspotter_lFileTemplate + 'eid';
	export Shotspotter_eid_key										:= tools.mod_FilenamesBuild(Shotspotter_leid_key	,pversion);
	export Shotspotter_eid_dAll_filenames					:= Shotspotter_eid_key.dAll_filenames;
	
	shared notes_leid_key													:= notes_lFileTemplate + 'eid';
	export notes_eid_key													:= tools.mod_FilenamesBuild(notes_leid_key	,pversion);
	export notes_eid_dAll_filenames								:= notes_eid_key.dAll_filenames;	
	
	shared images_leid_key												:= images_lFileTemplate + 'eid';
	export images_eid_key													:= tools.mod_FilenamesBuild(images_leid_key	,pversion);
	export images_eid_dAll_filenames							:= images_eid_key.dAll_filenames;	
	
	export geohash_key														:= tools.mod_FilenamesBuild(geohash_lFileTemplate	,pversion);
	export geohash_dAll_filenames									:= geohash_key.dAll_filenames;
	
	export geohash_lpr_key												:= tools.mod_FilenamesBuild(geohash_lpr_lFileTemplate	,pversion);
	export geohash_lpr_dAll_filenames							:= geohash_lpr_key.dAll_filenames;
	
	shared Classification_lori_key								:= Classification_lFileTemplate + 'ori';
	export Classification_ori_key									:= tools.mod_FilenamesBuild(Classification_lori_key	,pversion);
	export Classification_ori_dAll_filenames			:= Classification_ori_key.dAll_filenames;
	
	shared cfs_v2_leid_key												:= cfs_v2_lFileTemplate + 'eid';
	export cfs_v2_eid_key													:= tools.mod_FilenamesBuild(cfs_v2_leid_key	,pversion);
	export cfs_v2_eid_dAll_filenames							:= cfs_v2_eid_key.dAll_filenames;
	
	shared cfs_officer_v2_leid_key								:= cfs_officer_v2_lFileTemplate + 'eid';
	export cfs_officer_v2_eid_key									:= tools.mod_FilenamesBuild(cfs_officer_v2_leid_key	,pversion);
	export cfs_officer_v2_eid_dAll_filenames			:= cfs_officer_v2_eid_key.dAll_filenames;
	
	shared crash_v2_leid_key											:= crash_v2_lFileTemplate + 'eid';
	export crash_v2_eid_key												:= tools.mod_FilenamesBuild(crash_v2_leid_key	,pversion);
	export crash_v2_eid_dAll_filenames						:= crash_v2_eid_key.dAll_filenames;
	
	shared crash_per_v2_leid_key									:= crash_per_v2_lFileTemplate + 'eid';
	export crash_per_v2_eid_key										:= tools.mod_FilenamesBuild(crash_per_v2_leid_key	,pversion);
	export crash_per_v2_eid_dAll_filenames				:= crash_per_v2_eid_key.dAll_filenames;
	
	shared crash_veh_v2_leid_key									:= crash_veh_v2_lFileTemplate + 'eid';
	export crash_veh_v2_eid_key										:= tools.mod_FilenamesBuild(crash_veh_v2_leid_key	,pversion);
	export crash_veh_v2_eid_dAll_filenames				:= crash_veh_v2_eid_key.dAll_filenames;
	
	shared intel_v2_leid_key											:= intel_v2_lFileTemplate + 'eid';
	export intel_v2_eid_key												:= tools.mod_FilenamesBuild(intel_v2_leid_key	,pversion);
	export intel_v2_eid_dAll_filenames						:= intel_v2_eid_key.dAll_filenames;
	
end;