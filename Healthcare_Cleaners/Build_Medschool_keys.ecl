import doxie, VersionControl;

export Build_Medschool_keys := module
   
	
		export Build_Keys_medschool(string pversion, boolean pUseProd = false) := module


				VersionControl.macBuildNewLogicalKey(Medschool_Keys(pversion,pUseProd).medschool_msid_key.New		,Buildmedschool_msid_key);
																	  
				shared full_build :=
					sequential(
						Buildmedschool_msid_key,
						Promote.promote_medschool(pversion,pUseProd).buildfiles.New2Built
					);
		
				export medschool_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool  keys atribute')
					);
	end;


export Build_Keys_medschool_wordlist(string pversion, boolean pUseProd = false) := module


				VersionControl.macBuildNewLogicalKey(Medschool_Keys(pversion,pUseProd).medschool_wordlist_word_key.New		,Buildmedschool_wordlist_word_key);
																	  
				shared full_build :=
					sequential(
						Buildmedschool_wordlist_word_key,
						Promote.Promote_medschool_wordlist(pversion,pUseProd).buildfiles.New2Built
					);
		
				export medschool_wordlist_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool wordlist keys atribute')
					);
	end;
	
	
	
		export Build_Keys_non_medschool(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Medschool_Keys(pversion,pUseProd).non_medschool_msid_key.New		,Buildnon_medschool_msid_key);
																	  
				shared full_build :=
					sequential(
						Buildnon_medschool_msid_key,
						Promote.promote_non_medschool(pversion,pUseProd).buildfiles.New2Built
					);
		
				export non_medschool_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool  keys atribute')
					);
	end;


export Build_Keys_non_medschool_wordlist(string pversion, boolean pUseProd = false) := module

				//call_queue_bad_lu  keys - codekey
				VersionControl.macBuildNewLogicalKey(Medschool_Keys(pversion,pUseProd).non_medschool_wordlist_word_key.New		,Buildnon_medschool_wordlist_word_key);
																	  
				shared full_build :=
					sequential(
						Buildnon_medschool_wordlist_word_key,
						Promote.Promote_non_medschool_wordlist(pversion,pUseProd).buildfiles.New2Built
					);
		
				export non_medschool_wordlist_All :=
					if(VersionControl.IsValidVersion(pversion)
					,full_build
					,output('No Valid version parameter passed, skipping medschool wordlist keys atribute')
					);
	end;
	
	
	
	end;