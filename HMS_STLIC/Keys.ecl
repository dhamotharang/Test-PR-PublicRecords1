IMPORT doxie, tools;

EXPORT Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
MODULE

	//shared Base					:= Files(pversion,pUseProd).Base.Built;
	SHARED statelicense_Base				:= Files(pversion,pUseProd).statelicense_Base.Built;//dataset('~thor400_data::base::hms_stl::hms_statelicense::temp::20161107',hms_stlic.Layouts.statelicense_base,thor);
	SHARED stlicrollup_Base					:= Files(pversion,pUseProd).stlicrollup_Base.Built;
	SHARED stlic_Base_lnkey					:= statelicense_Base(ln_key <> '');
  // SHARED stlic_Base_ln						:= statelicense_Base(license_number <> '');
	// SHARED stlic_Base_dea						:= statelicense_Base(dea_number <> '');
	// SHARED stlic_Base_npi						:= statelicense_Base(npi_number <> '');
	// SHARED stlic_Base_zip						:= statelicense_Base(zip <> '');
	SHARED stlic_Base_lnpid					:= statelicense_Base(lnpid > 0);
	SHARED stlic_Base_sourcerid					:= statelicense_Base(source_rid > 0);
	
	SHARED stlicrollup_Base_sourcerid					:= stlicrollup_Base(source_rid > 0);

	// shared FilterDids		:= Base(did		!= 0);
	
	// tools.mac_FilesIndex('FilterDids		,{did	}	  ,{FilterDids	}'	,keynames(pversion,pUseProd).Did		,Did	 );
	
		// state license keys - ln_key, ...
	tools.mac_FilesIndex('statelicense_base		,{ln_key	}	  ,{stlic_Base_lnkey	}'	,keynames(pversion,pUseProd).statelicense_lnk_key		,statelicense_lnk_key	 );
	// tools.mac_FilesIndex('statelicense_base		,{license_number	}	  ,{stlic_Base_ln	}'	,keynames(pversion,pUseProd).statelicense_lic_key		,statelicense_lic_key	 );
	// tools.mac_FilesIndex('statelicense_base		,{dea_number	}	  ,{stlic_Base_dea	}'	,keynames(pversion,pUseProd).statelicense_dea_key		,statelicense_dea_key	 );
	// tools.mac_FilesIndex('statelicense_base		,{npi_number	}	  ,{stlic_Base_npi	}'	,keynames(pversion,pUseProd).statelicense_npi_key		,statelicense_npi_key	 );
	// tools.mac_FilesIndex('statelicense_base		,{zip	}	  ,{stlic_Base_zip	}'	,keynames(pversion,pUseProd).statelicense_zip_key		,statelicense_zip_key	 );
	tools.mac_FilesIndex('statelicense_base(lnpid > 0)		,{lnpid	}	  ,{stlic_Base_lnpid	}'	,keynames(pversion,pUseProd).statelicense_lnpid_key		,statelicense_lnpid_key	 );
	tools.mac_FilesIndex('statelicense_base(source_rid > 0)		,{source_rid	}	  ,{stlic_Base_sourcerid	}'	,keynames(pversion,pUseProd).statelicense_sourcerid_key		,statelicense_sourcerid_key	 );
	/*HMS replacement for AMS*/
	tools.mac_FilesIndex('stlicrollup_Base(source_rid > 0)		,{source_rid	}	  ,{stlicrollup_Base_sourcerid	}'	,keynames(pversion,pUseProd).stlicrollup_sourcerid_key		,stlicrollup_sourcerid_key	 );
	/*HMS replacement for AMS*/
END;
