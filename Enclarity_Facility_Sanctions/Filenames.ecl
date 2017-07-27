IMPORT Enclarity_Facility_Sanctions,versioncontrol,tools;

EXPORT Filenames(string pversion = '', boolean pUseProd = false) := MODULE  
  EXPORT facility_sanctions_lBaseTemplate_built	:= Enclarity_Facility_Sanctions._Dataset(pUseProd).thor_cluster_files + 'base::' + Enclarity_Facility_Sanctions._Dataset().name + '::facility_sanctions::built';
	EXPORT facility_sanctions_lBaseTemplate				:= Enclarity_Facility_Sanctions._Dataset(pUseProd).thor_cluster_files + 'base::' + Enclarity_Facility_Sanctions._Dataset().name + '::facility_sanctions::@version@';
	EXPORT facility_sanctions_lKeyTemplate	  		:= Enclarity_Facility_Sanctions._Dataset(pUseProd).thor_cluster_files + 'base::' + Enclarity_Facility_Sanctions._Dataset().name + '_keybuild' + '::facility_sanctions::@version@';		
	EXPORT facility_sanctions_lInputTemplate 			:= Enclarity_Facility_Sanctions._Dataset(pUseProd).thor_cluster_files + 'in::'   + Enclarity_Facility_Sanctions._Dataset().name + '::facility_sanctions' ;
	EXPORT facility_sanctions_lInputHistTemplate 	:= Enclarity_Facility_Sanctions._Dataset(pUseProd).thor_cluster_files + 'in::'   + Enclarity_Facility_Sanctions._Dataset().name + '::facility_sanctions::history';
	EXPORT facility_sanctions_Base		  					:= tools.mod_FilenamesBuild(facility_sanctions_lBaseTemplate, pversion);
END;