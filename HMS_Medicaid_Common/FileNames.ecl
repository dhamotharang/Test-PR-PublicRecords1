import versioncontrol,tools,HMS_Medicaid_Common;

export Filenames(STRING2 Medicaid_State, string pversion = '', boolean pUseProd = false) := module
  export lBaseTemplate_built := HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_files + 'base::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + '::built';
	export lBaseTemplate	:= 	HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_files + 'base::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name+ '::@version@';
	export lKeyTemplate	  := 	HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_files + 'base::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + '_keybuild' + '::@version@';		
	export lInputTemplate := HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_files + 'in::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name  ;
	export lInputHistTemplate := HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).thor_cluster_files + 'in::' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + '::history';
	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
  
	
	export dAll_filenames :=  Base.dAll_filenames;
end;