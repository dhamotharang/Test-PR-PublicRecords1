import versioncontrol,Medschool_standardization;

export Build_Base:=module
   
	export build_base_medschool_db(string	pversion,boolean pUseProd	= false ) := module
	
			shared MedschoolWordList            := output(Medschool_standardization.update_base(pversion,pUseProd).medschool_wordlist);
			shared full_build_medschool_db	    := sequential(MedschoolWordList
										                                ,Medschool_standardization.Promote.Promote_medschool(pversion, pUseProd).buildfiles.New2Built 
																										,Medschool_standardization.Promote.Promote_medschool_wordlist(pversion, pUseProd).buildfiles.New2Built );
			
			export medschoool_db_all	          :=if(VersionControl.IsValidVersion(pversion),full_build_medschool_db,output('No Valid version parameter passed, skipping medschool build'));
 end;

 export build_base_non_medschool_db(string pversion,boolean	pUseProd = false) := module
	        
			shared NonMedschoolWordList         :=  output(Medschool_standardization.update_base(pversion,pUseProd).nonmedschool_wordlist);
      shared full_build_non_medschool_db	:= sequential(NonMedschoolWordList
								                                       ,Medschool_standardization.Promote.Promote_non_medschool(pversion, pUseProd).buildfiles.New2Built
																											 ,Medschool_standardization.Promote.Promote_non_medschool_wordlist(pversion, pUseProd).buildfiles.New2Built );
		 
		 export non_medschoool_db_all	        := if(VersionControl.IsValidVersion(pversion),full_build_non_medschool_db,output('No Valid version parameter passed, skipping non medschool build'));
	end;

end;