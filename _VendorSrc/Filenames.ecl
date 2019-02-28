IMPORT versioncontrol,tools;

EXPORT Filenames(STRING pversion = '', BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Base_Data_lBaseTemplate_built         := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Base_Data::built';
	EXPORT Base_Data_lBaseTemplate               := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Base_Data::@version@';
	EXPORT Base_data_lKeyTemplate	              := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Base_Data::@version@';		
	EXPORT Base_Data_lInputTemplate              := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Base_Data';
	EXPORT Base_Data_lInputHistTemplate          := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Base_Data::history';
	EXPORT Base_Data_Base		                    := tools.mod_FilenamesBuild(Base_Data_lBaseTemplate, pversion);
	
  // EXPORT Old_Vendor_Src_lBaseTemplate_built		:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Old_Vendor_Src::built';
	// EXPORT Old_Vendor_Src_lBaseTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Old_Vendor_Src::@version@';
	// EXPORT Old_Vendor_Src_lKeyTemplate	  			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Old_Vendor_Src::@version@';		
	// EXPORT Old_Vendor_Src_lInputTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Old_Vendor_Src' ;
	// EXPORT Old_Vendor_Src_lInputHistTemplate 	  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Old_Vendor_Src::history';
	// EXPORT Old_Vendor_Src_Base	                := tools.mod_FilenamesBuild(Old_Vendor_Src_lBaseTemplate, pversion);
  
	EXPORT Bank_Court_lBaseTemplate_built			  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Bank_Court::built';
	EXPORT Bank_Court_lBaseTemplate					    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Bank_Court::@version@';
	EXPORT Bank_Court_lKeyTemplate	  			    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Bank_Court::@version@';		
	EXPORT Bank_Court_lInputTemplate 					  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Bank_Court' ;
	EXPORT Bank_Court_lInputHistTemplate 			  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Bank_Court::history';
	EXPORT Bank_Court_Base	                    := tools.mod_FilenamesBuild(Bank_Court_lBaseTemplate, pversion);
	
	EXPORT Lien_Court_lBaseTemplate_built			  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Lien_Court::built';
	EXPORT Lien_Court_lBaseTemplate					    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::Lien_Court::@version@';
	EXPORT Lien_Court_lKeyTemplate	  			    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Lien_Court::@version@';		
	EXPORT Lien_Court_lInputTemplate 					  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Lien_Court' ;
	EXPORT Lien_Court_lInputHistTemplate 			  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Lien_Court::history';
	EXPORT Lien_Court_Base	                    := tools.mod_FilenamesBuild(Lien_Court_lBaseTemplate, pversion);
	
	EXPORT Riskview_FFD_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Riskview_FFD::built';
	EXPORT Riskview_FFD_lBaseTemplate					  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Riskview_FFD::@version@';
	EXPORT Riskview_FFD_lKeyTemplate	  			  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Riskview_FFD::@version@';		
	EXPORT Riskview_FFD_lInputTemplate 					:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Riskview_FFD' ;
	EXPORT Riskview_FFD_lInputHistTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Riskview_FFD::history';
	EXPORT Riskview_FFD_Base	                  := tools.mod_FilenamesBuild(Riskview_FFD_lBaseTemplate, pversion);
	
	EXPORT Court_Locations_lBaseTemplate_built	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Court_Locations::built';
	EXPORT Court_Locations_lBaseTemplate				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Court_Locations::@version@';
	EXPORT Court_Locations_lKeyTemplate	  			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Court_Locations::@version@';		
	EXPORT Court_Locations_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Court_Locations' ;
	EXPORT Court_Locations_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Court_Locations::history';
	EXPORT Court_Locations_Base	                := tools.mod_FilenamesBuild(Court_Locations_lBaseTemplate, pversion);
	
	
	EXPORT Master_List_lBaseTemplate_built			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Master_List::built';
	EXPORT Master_List_lBaseTemplate					  := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::Master_List::@version@';
	EXPORT Master_List_lKeyTemplate	  			    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::Master_List::@version@';		
	EXPORT Master_List_lInputTemplate 			    := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Master_List' ;
	EXPORT Master_List_lInputHistTemplate 		  := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::Master_List::history';
	EXPORT Master_List_Base	                    := tools.mod_FilenamesBuild(Master_List_lBaseTemplate, pversion);
	
  EXPORT College_Locator_lBaseTemplate_built	:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::College_Locator::built';
	EXPORT College_Locator_lBaseTemplate				:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + ' ::College_Locator::@version@';
	EXPORT College_Locator_lKeyTemplate	  			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::College_Locator::@version@';		
	EXPORT College_Locator_lInputTemplate 			:= _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::College_Locator' ;
	EXPORT College_Locator_lInputHistTemplate   := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset().name + '::College_Locator::history';
	EXPORT College_Locator_Base	                := tools.mod_FilenamesBuild(College_Locator_lBaseTemplate, pversion);
		
		
	//export gk_to_provID_lBaseTemplate					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::gk_to_provID::@version@';
	//export gk_to_provID_Base									:= tools.mod_FilenamesBuild(gk_to_provID_lBaseTemplate, pversion);
	
	
//	EXPORT dAll_filenames :=Base.dAll_filenames		 ;

END;
