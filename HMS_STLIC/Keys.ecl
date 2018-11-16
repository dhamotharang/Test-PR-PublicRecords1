IMPORT doxie, tools;

EXPORT Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
MODULE

	shared key_layout := record
		HMS_STLIC.Layouts.statelicense_base - [xadl2_weight, xadl2_score, xadl2_distance, xadl2_keys_used, 
								xadl2_keys_desc, xadl2_matches, xadl2_matches_desc];
	end;

	SHARED statelicense_Base				:= project(Files(pversion,pUseProd).statelicense_Base.Built, key_layout);
	SHARED stlicrollup_Base					:= project(Files(pversion,pUseProd).stlicrollup_Base.Built, key_layout);
	SHARED stlic_Base_lnkey					:= statelicense_Base(ln_key <> '');
	SHARED stlic_Base_lnpid					:= statelicense_Base(lnpid > 0);
	SHARED stlic_Base_sourcerid			:= statelicense_Base(source_rid > 0);
	
	SHARED stlicrollup_Base_sourcerid					:= stlicrollup_Base(source_rid > 0);

		// state license keys - ln_key, ...
	tools.mac_FilesIndex('statelicense_base		,{ln_key	}	  ,{stlic_Base_lnkey	}'	,keynames(pversion,pUseProd).statelicense_lnk_key		,statelicense_lnk_key	 );
	tools.mac_FilesIndex('statelicense_base(lnpid > 0)		,{lnpid	}	  ,{stlic_Base_lnpid	}'	,keynames(pversion,pUseProd).statelicense_lnpid_key		,statelicense_lnpid_key	 );
	tools.mac_FilesIndex('statelicense_base(source_rid > 0)		,{source_rid	}	  ,{stlic_Base_sourcerid	}'	,keynames(pversion,pUseProd).statelicense_sourcerid_key		,statelicense_sourcerid_key	 );
	/*HMS replacement for AMS*/
	tools.mac_FilesIndex('stlicrollup_Base(source_rid > 0)		,{source_rid	}	  ,{stlicrollup_Base_sourcerid	}'	,keynames(pversion,pUseProd).stlicrollup_sourcerid_key		,stlicrollup_sourcerid_key	 );
	/*HMS replacement for AMS*/
END;
