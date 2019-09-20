import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module


   EXPORT BankCourt_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy' ;
   EXPORT BankCourt_lInputFatherTemplate 	     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy_father';
   EXPORT BankCourt_Base	                     := tools.mod_FilenamesBuild(BankCourt_lInputTemplate, pversion);
	
   EXPORT LienCourt_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien' ;
   EXPORT LienCourt_lInputFatherTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien_father';
   EXPORT LienCourt_Base	                     := tools.mod_FilenamesBuild(LienCourt_lInputTemplate, pversion);
	                                               
	 EXPORT Orbit_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::orbit' ;
	 EXPORT Orbit_lInputFatherTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::orbit_father';
	 EXPORT Orbit_Base	                       := tools.mod_FilenamesBuild(Orbit_lInputTemplate, pversion);
	 
   EXPORT CourtLocator_lInputTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocator' ;
   EXPORT CourtLocator_lInputFatherTemplate    := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocator_father';
   EXPORT CourtLocator_Base	                   := tools.mod_FilenamesBuild(CourtLocator_lInputTemplate, pversion);
	 
   EXPORT MasterList_lInputTemplate 			     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist' ;
   EXPORT MasterList_lInputFatherTemplate 		 := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist_history';
   EXPORT MasterList_Base	                     := tools.mod_FilenamesBuild(MasterList_lInputTemplate, pversion);
	 
   EXPORT CollegeLocator_lInputTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator' ;
   EXPORT CollegeLocator_lInputFatherTemplate  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator_history';
   EXPORT CollegeLocator_Base	                 := tools.mod_FilenamesBuild(CollegeLocator_lInputTemplate, pversion);
	
	 EXPORT lBaseTemplate_built                  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
	 EXPORT lBaseTemplate	                       := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@';
	 EXPORT lKeyTemplate                         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';		
	 EXPORT lInputTemplate                       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::' ;
	 EXPORT lInputHistTemplate                   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::history';
	 EXPORT Base                                 := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
	
 	 EXPORT dAll_filenames :=Base.dAll_filenames;

 
END;
