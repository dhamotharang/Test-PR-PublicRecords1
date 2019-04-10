
EXPORT BWR_create_history_superfiles(UNSIGNED1 pseudo_environment) := FUNCTION

	cluster := AccountMonitoring.constants.filename_cluster;
	ext     := AccountMonitoring.constants.pseudo_ext(pseudo_environment);
	
	pf1 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base'),
							  FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base') );	
	pf2 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base_father'),
							  FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base_father') );	
	pf3 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base_grandfather'),
							  FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::base_grandfather') );	
	
	pfu1 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update'),
			 				   FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update') );	
	pfu2 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update_father'),
			 				   FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update_father') );	
	pfu3 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update_grandfather'),
			 				   FileServices.CreateSuperFile(cluster+'base::Account_Monitoring::' + ext + 'portfolio::update_grandfather') );	
	
	
	csf0 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'results'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'results') );	
	csf1 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'results_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'results_father') );
	csf2 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'results_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'results_grandfather') );
							 
							 
	csf3  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy') );	
	csf4  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy_father') );
	csf5  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::bankruptcy_grandfather') );

	csf6  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::deceased'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::deceased') );	
	csf7  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::deceased_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::deceased_father') );
	csf8  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::deceased_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::deceased_grandfather') );

	csf9  := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::phone'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::phone') );	
	csf10 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::phone_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::phone_father') );
	csf11 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::phone_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::phone_grandfather') );

	csf12 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::address'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::address') );	
	csf13 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::address_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::address_father') );
	csf14 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::address_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::address_grandfather') );

	csf15 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::paw'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::paw') );	
	csf16 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::paw_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::paw_father') );
	csf17 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::paw_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::paw_grandfather') );

	csf18 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::property'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::property') );	
	csf19 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::property_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::property_father') );
	csf20 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::property_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::property_grandfather') );

	csf21 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor') );	
	csf22 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor_father') );
	csf23 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::litigiousdebtor_grandfather') );

	csf24 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::liens'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::liens') );	
	csf25 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::liens_father'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::liens_father') );
	csf26 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::' + ext + 'history::liens_grandfather'),
							 FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::' + ext + 'history::liens_grandfather') );
  
  csf27   := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::personheader'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::personheader') );	
	csf28 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::personheader_father'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::personheader_father'));
	csf29 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::personheader_grandfather'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::personheader_grandfather'));


	RETURN SEQUENTIAL( 
		// pf1,   pf2,   pf3, 
		// pfu1,  pfu2,  pfu3, 
		// csf0,  csf1,  csf2,  
		// csf3,  csf4,  csf5,  
		// csf6,  csf7,  csf8,  
		// csf9,  csf10, csf11, 
		// csf12, csf13, csf14, 
		// csf15, csf16, csf17, 
		// csf18, csf19, csf20, 
		// csf21, csf22, csf23,
		//csf24, csf25, csf26,
		csf27, csf28, csf29
		);
END;

// Invoke, e.g.

// SEQUENTIAL( AccountMonitoring.BWR_create_history_superfiles(AccountMonitoring.constants.pseudo.DEV) );