IMPORT tools;

EXPORT BusReg_Keyfilenames(STRING		pversion							= ''
                        	,BOOLEAN	pUseOtherEnvironment	= FALSE) := MODULE

  SHARED lkeyTemplateFCRA				 	:=  IF (pversion <> ''
																				 ,PRTE_CSV._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::busreg::'
																				 ,PRTE_CSV._Dataset(pUseOtherEnvironment).prte_thor_cluster_files + 'key::busreg');
			
  EXPORT company_bdid							:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::company_bdid');
  EXPORT company_linkids					:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::company_linkids');
  EXPORT contact_bdid							:= tools.mod_FilenamesBuild(lkeyTemplateFCRA + pversion	+ '::contact_bdid');

  EXPORT dAll_filenames 					:= company_bdid.dAll_filenames
																	 + company_linkids.dAll_filenames
																	 + contact_bdid.dAll_filenames; 

END;