import tools;

export Keynames(string pversion = '', boolean pUseProd = false, boolean pUseDelta = false) := module

	shared suffix := if(pUseDelta, '::delta::@version@::', '::@version@::');
	
	export AgencyLayer_lFileTemplate	    				:= _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::agency_layers' + suffix;
	
	
	shared agencylayer_lsearch_key								:= AgencyLayer_lFileTemplate + 'search';
	export agencylayer_search_key									:= tools.mod_FilenamesBuild(agencylayer_lsearch_key	,pversion);
	export agencylayer_search_dAll_filenames			:= agencylayer_search_key.dAll_filenames;
	
	shared agencylayer_lpayload_key								:= AgencyLayer_lFileTemplate + 'layerid';
	export agencylayer_payload_key								:= tools.mod_FilenamesBuild(agencylayer_lpayload_key	,pversion);
	export agencylayer_payload_dAll_filenames			:= agencylayer_payload_key.dAll_filenames;
end;