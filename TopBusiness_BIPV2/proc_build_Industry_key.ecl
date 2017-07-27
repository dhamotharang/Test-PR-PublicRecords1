import tools;

export proc_build_Industry_key(string pversion) :=
module

	shared names := keynames(pversion);
	
	export BuildLinkIdsKey := tools.macf_writeindex('Key_Industry_Linkids.key, names.Industry_LinkIds.new');
	
	export full_build := 
	sequential(
    parallel(
      BuildLinkIdsKey		
    )
    ,Promote(pversion).New2Built
	);
	
END;