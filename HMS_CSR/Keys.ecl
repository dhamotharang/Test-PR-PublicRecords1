IMPORT doxie, tools;

EXPORT Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
MODULE

	//shared Base					:= Files(pversion,pUseProd).Base.Built;
	SHARED csrcredential_Base				:= Files(pversion,pUseProd).csrcredential_Base.Built;
	SHARED csr_Base_lnkey					:= csrcredential_Base(ln_key <> '');
  SHARED csr_Base_ln						:= csrcredential_Base(license_number <> '');
	SHARED csr_Base_dea						:= csrcredential_Base(dea_number <> '');
	SHARED csr_Base_npi						:= csrcredential_Base(npi_number <> '');
	SHARED csr_Base_zip						:= csrcredential_Base(zip <> '');
	SHARED csr_Base_lnpid					:= csrcredential_Base((string)lnpid <> '');

	// shared FilterDids		:= Base(did		!= 0);
	
	// tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did		,Did	 );
	
		// csr cred keys - ln_key, ...
	tools.mac_FilesIndex('csrcredential_base		,{ln_key	}	  ,{csr_Base_lnkey	}'	,keynames(pversion,pUseProd).csrcredential_lnk_key		,csrcredential_lnk_key	 );
	tools.mac_FilesIndex('csrcredential_base		,{license_number	}	  ,{csr_Base_ln	}'	,keynames(pversion,pUseProd).csrcredential_lic_key		,csrcredential_lic_key	 );
	tools.mac_FilesIndex('csrcredential_base		,{dea_number	}	  ,{csr_Base_dea	}'	,keynames(pversion,pUseProd).csrcredential_dea_key		,csrcredential_dea_key	 );
	tools.mac_FilesIndex('csrcredential_base		,{npi_number	}	  ,{csr_Base_npi	}'	,keynames(pversion,pUseProd).csrcredential_npi_key		,csrcredential_npi_key	 );
	tools.mac_FilesIndex('csrcredential_base		,{zip	}	  ,{csr_Base_zip	}'	,keynames(pversion,pUseProd).csrcredential_zip_key		,csrcredential_zip_key	 );
	tools.mac_FilesIndex('csrcredential_base		,{lnpid	}	  ,{csr_Base_lnpid	}'	,keynames(pversion,pUseProd).csrcredential_lnpid_key		,csrcredential_lnpid_key	 );
	
END;
