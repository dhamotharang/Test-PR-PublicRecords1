import tools,Medschool_standardization;
lay_builds 	:= tools.Layout_FilenameVersions.builds;
export Promote	:= module
		
		
		export Promote_medschool
		(
  		 string								pversion				= 	''
			,boolean							pUseProd			  = 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,unsigned1            pnGenerations   = 2 
			,dataset(lay_builds)	pBuildFilenames = Medschool_standardization.Filenames(pversion,pUseProd).medschool_base.dAll_filenames
																						+ Medschool_standardization.keynames	(pversion,pUseProd).medschool_msid_key.dAll_filenames	
    ):=	module

		   	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		end;

    export Promote_medschool_wordlist
    (
			 string								pversion				= 	''
			,boolean							pUseProd			  = 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,unsigned1            pnGenerations   = 2 
			,dataset(lay_builds)	pBuildFilenames =  Medschool_standardization.Filenames(pversion,pUseProd).medschool_wordlist_Base.dAll_filenames
																						 +Medschool_standardization.keynames	(pversion,pUseProd).medschool_wordlist_word_key.dAll_filenames	
		) :=	module

	 		    export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		end;
	
		export Promote_non_medschool
		(
			 string								pversion				= 	''
			,boolean							pUseProd			  = 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,unsigned1            pnGenerations   = 2 
			,dataset(lay_builds)	pBuildFilenames = Medschool_standardization.Filenames(pversion,pUseProd).non_medschool_base.dAll_filenames
																						+ Medschool_standardization.keynames	(pversion,pUseProd).non_medschool_msid_key.dAll_filenames	
			) :=	module
			  
				export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		end;

    export Promote_non_medschool_wordlist
		(
			 string								pversion				= 	''
			,boolean							pUseProd			  = 	false
			,string								pFilter					= 	''
			,boolean							pDelete					= 	false
			,boolean							pisTesting			= 	false
			,unsigned1            pnGenerations   = 2 
			,dataset(lay_builds)	pBuildFilenames = Medschool_standardization.Filenames(pversion,pUseProd).non_medschool_wordlist_Base.dAll_filenames
																							+Medschool_standardization.keynames	(pversion,pUseProd).non_medschool_wordlist_word_key.dAll_filenames	
		) :=	module

			export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete:=true,pisTesting:=false, pnGenerations:= 2 );
		end;
	end;