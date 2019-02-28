import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module


//EXPORT BankCourt_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy' ;
//EXPORT BankCourt_lInputFatherTemplate 	     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::bankruptcy::father';
	
	EXPORT BankCourt_lInputTemplate              := '~thor_data400::in::vendorsrc::bankruptcy';
	EXPORT BankCourt_lInputFatherTemplate	       := '~thor_data400::in::vendorsrc::bankruptcy::father';
	EXPORT BankCourt_Base	                       := tools.mod_FilenamesBuild(BankCourt_lInputTemplate, pversion);
 

//EXPORT LienCourt_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien' ;
//EXPORT LienCourt_lInputFatherTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::lien::father';
	
	EXPORT LienCourt_lInputTemplate              := '~thor_data400::in::vendorsrc::lien';
	EXPORT LienCourt_lInputFatherTemplate	       := '~thor_data400::in::vendorsrc::lien::father';
	EXPORT LienCourt_Base	                       := tools.mod_FilenamesBuild(LienCourt_lInputTemplate, pversion);
	
	
	EXPORT RiskView_lInputTemplate 			         := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::riskviewFFD' ;
	EXPORT RiskView_lInputFatherTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::riskviewFFD::father';
	EXPORT RiskView_Base	                       := tools.mod_FilenamesBuild(RiskView_lInputTemplate, pversion);
 
 	
		
//EXPORT CourtLocations_lInputTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocations' ;
//EXPORT CourtLocations_lInputFatherTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::courtlocations::father';
	
	EXPORT CourtLocations_lInputTemplate         := '~thor_data400::in::vendorsrc::courtlocations';
	EXPORT CourtLocations_lInputFatherTemplate	 := '~thor_data400::in::vendorsrc::courtlocations::father';
	EXPORT CourtLocations_Base	                 := tools.mod_FilenamesBuild(CourtLocations_lInputTemplate, pversion);
 
 	
//EXPORT MasterList_lInputTemplate 			       := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist' ;
//EXPORT MasterList_lInputFatherTemplate 		   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::masterlist::history';
	
	EXPORT MasterList_lInputTemplate             := '~thor_data400::in::vendorsrc::masterlist';
	EXPORT MasterList_lInputFatherTemplate	     := '~thor_data400::in::vendorsrc::masterlist::father';
	EXPORT MasterList_Base	                     := tools.mod_FilenamesBuild(MasterList_lInputTemplate, pversion);
 
  
 		
//EXPORT CollegeLocator_lInputTemplate 		     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator' ;
//EXPORT CollegeLocator_lInputFatherTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::collegelocator::history';
	
	EXPORT CollegeLocator_lInputTemplate         := '~thor_data400::in::vendorsrc::collegelocator';
	EXPORT CollegeLocator_lInputFatherTemplate	 := '~thor_data400::in::vendorsrc::collegelocator::father';
	EXPORT CollegeLocator_Base	                 := tools.mod_FilenamesBuild(CollegeLocator_lInputTemplate, pversion);
	
	
	EXPORT lBaseTemplate_built                   := '~thor_data400::base::vendorsrc::built';
	EXPORT lBaseTemplate	                       := '~thor_data400::base::vendorsrc::@version@';
	EXPORT lKeyTemplate                          := '~thor_data400::base::vendorsrc::_keybuild' + '::@version@';
	EXPORT lInputTemplate                        := '~thor_data400::in::vendorsrc::';
	EXPORT lInputHistTemplate                    := '~thor_data400::in::vendorsrc::history';
	EXPORT Base                                  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
	
	
	//                                  			   := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
	//							                             := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::@version@';
	// 	  					                             := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';		
	//  						                             := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::' ;
	//  			                                   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::history';
	//                      	  							 	 := tools.mod_FilenamesBuild(facility_lBaseTemplate, pversion);
	
	export dAll_filenames :=Base.dAll_filenames;

 
end;
