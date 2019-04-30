import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module


   //EXPORT BankCourt_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy' ;
   //EXPORT BankCourt_lInputFatherTemplate 	     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy_father';
   //EXPORT BankCourt_Base	                     := tools.mod_FilenamesBuild(BankCourt_lInputTemplate, pversion);
	
	 EXPORT BankCourt_lInputTemplate               := '~thor_data400::in::vendor_src::bankruptcy';
	 EXPORT BankCourt_lInputFatherTemplate	       := '~thor_data400::in::vendor_src::bankruptcy_father';
	 EXPORT BankCourt_Base	                       := tools.mod_FilenamesBuild(BankCourt_lInputTemplate, pversion);
 
   // EXPORT LienCourt_lInputTemplate 			     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien' ;
   // EXPORT LienCourt_lInputFatherTemplate 		 := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien_father';
   // EXPORT LienCourt_Base	                     := tools.mod_FilenamesBuild(LienCourt_lInputTemplate, pversion);
	 
	 EXPORT LienCourt_lInputTemplate               := '~thor_data400::in::vendor_src::lien';
	 EXPORT LienCourt_lInputFatherTemplate	       := '~thor_data400::in::vendor_src::lien_father';
	 EXPORT LienCourt_Base	                       := tools.mod_FilenamesBuild(LienCourt_lInputTemplate, pversion);
	
	
	 EXPORT RiskView_lInputTemplate 			         := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::riskviewFFD' ;
	 EXPORT RiskView_lInputFatherTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::riskviewFFD_father';
	 EXPORT RiskView_Base	                         := tools.mod_FilenamesBuild(RiskView_lInputTemplate, pversion);
	 
   // EXPORT CourtLocator_lInputTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocator' ;
   // EXPORT CourtLocator_lInputFatherTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocator_father';
   // EXPORT CourtLocator_Base	                 := tools.mod_FilenamesBuild(CourtLocator_lInputTemplate, pversion);
	 
	 EXPORT CourtLocator_lInputTemplate            := '~thor_data400::in::vendor_src::courtlocator';
	 EXPORT CourtLocator_lInputFatherTemplate	     := '~thor_data400::in::vendor_src::courtlocator_father';
	 EXPORT CourtLocator_Base	                     := tools.mod_FilenamesBuild(CourtLocator_lInputTemplate, pversion);
 
	
   // EXPORT MasterList_lInputTemplate 			     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist' ;
   // EXPORT MasterList_lInputFatherTemplate 		 := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist_history';
   // EXPORT MasterList_Base	                   := tools.mod_FilenamesBuild(MasterList_lInputTemplate, pversion);
	 
	 EXPORT MasterList_lInputTemplate              := '~thor_data400::in::vendor_src::masterlist';
	 EXPORT MasterList_lInputFatherTemplate	       := '~thor_data400::in::vendor_src::masterlist_father';
	 EXPORT MasterList_Base	                       := tools.mod_FilenamesBuild(MasterList_lInputTemplate, pversion);
 
   //EXPORT CollegeLocator_lInputTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator' ;
   //EXPORT CollegeLocator_lInputFatherTemplate  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator_history';
   //EXPORT CollegeLocator_Base	                 := tools.mod_FilenamesBuild(CollegeLocator_lInputTemplate, pversion);
	
	 EXPORT CollegeLocator_lInputTemplate        := '~thor_data400::in::vendor_src::collegelocator';
	 EXPORT CollegeLocator_lInputFatherTemplate	 := '~thor_data400::in::vendor_src::collegelocator_father';
	 EXPORT CollegeLocator_Base	                 := tools.mod_FilenamesBuild(CollegeLocator_lInputTemplate, pversion);
	 
// EXPORT lBaseTemplate_built                  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
// EXPORT lBaseTemplate							           := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@';
// EXPORT lKeyTemplate 	  					           := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';		
// EXPORT lInputTemplate  						         := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::' ;
// EXPORT lInputHistTemplate  			           := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::history';
// EXPORT Base                      	  	     := tools.mod_FilenamesBuild(facility_lBaseTemplate, pversion);	
	
	 EXPORT lBaseTemplate_built                  := '~thor_data400::base::vendor_src::built';
	 EXPORT lBaseTemplate	                       := '~thor_data400::base::vendor_src::@version@';
	 EXPORT lKeyTemplate                         := '~thor_data400::base::vendor_src::_keybuild' + '::@version@';
	 EXPORT lInputTemplate                       := '~thor_data400::in::vendor_src::';
	 EXPORT lInputHistTemplate                   := '~thor_data400::in::vendor_src::history';
	 EXPORT Base                                 := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
	
 	 EXPORT dAll_filenames :=Base.dAll_filenames;

 
END;
