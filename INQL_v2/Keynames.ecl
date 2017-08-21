import tools;

EXPORT Keynames(
	 string		pversion	= '',
   boolean 	pUseProd 	= false
) :=
MODULE

	Accurint_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Accurint_leid_key				:= Accurint_lFileTemplate + 'eid';
	export Accurint_eid_key	:= tools.mod_FilenamesBuild(Accurint_leid_key	,pversion);

	Custom_lFileTemplate		:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Custom_leid_key					:= Custom_lFileTemplate + 'eid';
	export Custom_eid_key		:= tools.mod_FilenamesBuild(Custom_leid_key	,pversion);
	
	Banko_lFileTemplate			:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Banko_leid_key					:= Banko_lFileTemplate + 'eid';
	export Banko_eid_key		:= tools.mod_FilenamesBuild(Banko_leid_key	,pversion);
	
	Batch_lFileTemplate			:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Batch_leid_key					:= Batch_lFileTemplate + 'eid';
	export Batch_eid_key		:= tools.mod_FilenamesBuild(Batch_leid_key	,pversion);
	
	BatchR3_lFileTemplate		:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	BatchR3_leid_key				:= BatchR3_lFileTemplate + 'eid';
	export BatchR3_eid_key	:= tools.mod_FilenamesBuild(BatchR3_leid_key	,pversion);
	
	Bridger_lFileTemplate		:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Bridger_leid_key				:= Bridger_lFileTemplate + 'eid';
	export Bridger_eid_key	:= tools.mod_FilenamesBuild(Bridger_leid_key	,pversion);
	
	Riskwise_lFileTemplate	:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	Riskwise_leid_key				:= Riskwise_lFileTemplate + 'eid';
	export Riskwise_eid_key	:= tools.mod_FilenamesBuild(Riskwise_leid_key	,pversion);
	
	IDM_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	IDM_leid_key						:= IDM_lFileTemplate + 'eid';
	export IDM_eid_key			:= tools.mod_FilenamesBuild(IDM_leid_key	,pversion);
	
	SBA_lFileTemplate				:= _Dataset(pUseProd).thor_cluster_files	+ 'key::'	+ _Dataset().name + '::@version@::'	;
	SBA_leid_key						:= SBA_lFileTemplate + 'eid';
	export SBA_eid_key			:= tools.mod_FilenamesBuild(SBA_leid_key	,pversion);
	
END;