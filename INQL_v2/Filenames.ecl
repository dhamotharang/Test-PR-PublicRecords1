import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module

  export Accurint_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Accurint::built';
	export Accurint_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Accurint::@version@';
	export Accurint_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Accurint::@version@';		
	export Accurint_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Accurint';
	export Accurint_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Accurint::history';
	export Accurint_Base
		:= tools.mod_FilenamesBuild(Accurint_lBaseTemplate, pversion);
  
	export Custom_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Custom::built';
	export Custom_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Custom::@version@';
	export Custom_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Custom::@version@';		
	export Custom_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Custom';
	export Custom_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Custom::history';
	export Custom_Base
		:= tools.mod_FilenamesBuild(Custom_lBaseTemplate, pversion);
		
	export Banko_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Banko::built';
	export Banko_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Banko::@version@';
	export Banko_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Banko::@version@';		
	export Banko_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Banko';
	export Banko_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Banko::history';
	export Banko_Base
		:= tools.mod_FilenamesBuild(Banko_lBaseTemplate, pversion);	
	
	export Batch_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Batch::built';
	export Batch_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Batch::@version@';
	export Batch_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Batch::@version@';		
	export Batch_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Batch';
	export Batch_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Batch::history';
	export Batch_Base
		:= tools.mod_FilenamesBuild(Batch_lBaseTemplate, pversion);
	
	export BatchR3_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::BatchR3::built';
	export BatchR3_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::BatchR3::@version@';
	export BatchR3_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::BatchR3::@version@';		
	export BatchR3_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::BatchR3';
	export BatchR3_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::BatchR3::history';
	export BatchR3_Base
		:= tools.mod_FilenamesBuild(BatchR3_lBaseTemplate, pversion);
		
	export Bridger_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Bridger::built';
	export Bridger_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Bridger::@version@';
	export Bridger_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Bridger::@version@';		
	export Bridger_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Bridger';
	export Bridger_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Bridger::history';
	export Bridger_Base
		:= tools.mod_FilenamesBuild(Bridger_lBaseTemplate, pversion);
	
	export Riskwise_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Riskwise::built';
	export Riskwise_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Riskwise::@version@';
	export Riskwise_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Riskwise::@version@';		
	export Riskwise_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Riskwise';
	export Riskwise_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::Riskwise::history';
	export Riskwise_Base
		:= tools.mod_FilenamesBuild(Riskwise_lBaseTemplate, pversion);
	
	export IDM_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::IDM::built';
	export IDM_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::IDM::@version@';
	export IDM_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::IDM::@version@';		
	export IDM_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::IDM';
	export IDM_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::IDM::history';
	export IDM_Base
		:= tools.mod_FilenamesBuild(IDM_lBaseTemplate, pversion);
		
	export SBA_lBaseTemplate_built
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::SBA::built';
	export SBA_lBaseTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::SBA::@version@';
	export SBA_lKeyTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::SBA::@version@';		
	export SBA_lInputTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::SBA';
	export SBA_lInputHistTemplate
		:= _Dataset(pUseProd).thor_cluster_files + 'in::' 	+ _Dataset().name + '::SBA::history';
	export SBA_Base
		:= tools.mod_FilenamesBuild(SBA_lBaseTemplate, pversion);
		
end;
