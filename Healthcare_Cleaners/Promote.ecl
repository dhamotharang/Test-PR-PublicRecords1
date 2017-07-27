import tools;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote	:= module
		
		
		export Promote_medschool(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  medschool_keynames	(pversion,pUseProd).medschool_msid_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;

export Promote_medschool_wordlist(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  medschool_keynames	(pversion,pUseProd).medschool_wordlist_word_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
	
	
	
export Promote_non_medschool(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  medschool_keynames	(pversion,pUseProd).non_medschool_msid_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;

export Promote_non_medschool_wordlist(
		string								pversion				= 	''
		,boolean							pUseProd			  = 	false
		,string								pFilter					= 	''
		,boolean							pDelete					= 	false
		,boolean							pisTesting			= 	false
		,unsigned1            pnGenerations   = 3 
		,dataset(lay_builds)	pBuildFilenames =  medschool_keynames	(pversion,pUseProd).non_medschool_wordlist_word_key.dAll_filenames	// individual keys - group_key, lnpid
																					//+ keynames  (pversion,pUseProd).individual_lnpid.dAll_filenames
		) :=	module
			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		
		end;
	end;