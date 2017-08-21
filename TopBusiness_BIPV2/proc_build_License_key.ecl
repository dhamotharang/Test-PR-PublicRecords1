import tools;

export proc_build_License_key(string pversion) :=
module

	shared names := keynames(pversion);
	
  export BuildLinkIdsKey := tools.macf_writeindex('Key_License_Linkids.key, names.License_LinkIds.new');

	export full_build := 
	sequential(
    parallel(
      BuildLinkIdsKey		
    )
    ,Promote(pversion).New2Built
	);
	
END;