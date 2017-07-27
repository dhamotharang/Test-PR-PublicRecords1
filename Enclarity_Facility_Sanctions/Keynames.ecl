import tools;

export Keynames(string		pversion			= '',   boolean pUseProd = false) := module

	export facility_sanctions_lFileTemplate	    := _Dataset(pUseProd).thor_cluster_files		+ 'key::'	+ _Dataset().name + '::facility_sanctions::@version@::'	;
	
	export facility_sanctions_llnfid				:= facility_sanctions_lFileTemplate + 'lnfid';
	export facility_sanctions_lnfid					:= tools.mod_FilenamesBuild(facility_sanctions_llnfid	,pversion);
	export facility_sanctions_lnfid_dAll_filenames	:= facility_sanctions_lnfid.dAll_filenames;
	
	export facility_sanctions	:= facility_sanctions_lnfid.dAll_filenames;

end;

