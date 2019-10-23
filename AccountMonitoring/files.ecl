IMPORT AccountMonitoring;

EXPORT files(UNSIGNED1 pseudo_environment) := MODULE

	EXPORT portfolio := MODULE
	   
		// The Portfolio Base file contains all of the portfolio records we are monitoring
		EXPORT base            := DATASET(AccountMonitoring.filenames(pseudo_environment).portfolio.base, AccountMonitoring.layouts.portfolio.base, THOR, OPT);
		// The Portfolio Archive file (contains all current and historical records)
		EXPORT archive         := DATASET(AccountMonitoring.filenames(pseudo_environment).portfolio.archive, AccountMonitoring.layouts.portfolio.base, THOR, OPT);
		// The Portfolio Update file contains the current changes that need to be made to the Portfolio Base file (ie: add, modify, remove or change product to records being monitored)
		EXPORT update          := DATASET(AccountMonitoring.filenames(pseudo_environment).portfolio.update, AccountMonitoring.layouts.portfolio.update, CSV (SEPARATOR('|'), TERMINATOR(['\n','\r\n']), QUOTE('')));
      // The Portfolio Super file contains the all records from both the portfolio and archive file merged and sorted
		// EXPORT super           := AccountMonitoring.Utilities.Combine_Portfolio_Base_and_Archive_files (pseudo_environment);
			
	END;
	

	// Creates the document datasets 
	// The Document files, which we pass into a cgm as a formal parameter. The documents 
	// consist of the data necesssary to pick out a unique record in the base file.
	// For example,...
	//   A TMSID will find a unique UCC Lien.
	//   A street address plus city, state and zip will find a unique property.
	//   A state death certificate plus state will find a unique death record.
	//   Documents can then be moniroed for changes without regard to the person they're associated with.
	// Docuements as of 11/28/11 are only used for bankruptcy monitoring. 

	EXPORT documents := MODULE
	
		SHARED documents_template(in_product) := MACRO
		
			EXPORT in_product := MODULE
				EXPORT base          := DATASET(AccountMonitoring.filenames(pseudo_environment).documents.in_product.base, AccountMonitoring.layouts.documents.in_product.base, THOR, OPT);
				EXPORT update        := DATASET(AccountMonitoring.filenames(pseudo_environment).documents.in_product.update, AccountMonitoring.layouts.documents.in_product.update, CSV (SEPARATOR('|'), TERMINATOR(['\n','\r\n']), QUOTE('')));
			END;
		
		ENDMACRO;
		
		documents_template(bankruptcy);
		documents_template(deceased);
		documents_template(address);
		documents_template(phone);
		documents_template(paw);
		documents_template(property);
		documents_template(litigiousdebtor);
		documents_template(liens);
		documents_template(criminal);
		documents_template(phonefeedback);
		documents_template(foreclosure);
		documents_template(workplace);
		documents_template(reverseaddress);
		documents_template(didupdate);
		documents_template(bdidupdate);
		documents_template(phoneownership);
		documents_template(bipbestupdate);
		documents_template(sbfe);
		documents_template(ucc);
		documents_template(govtdebarred);
		documents_template(inquiry);
		documents_template(corp);
		documents_template(mvr);
		documents_template(aircraft);
		documents_template(watercraft);
		documents_template(personheader);
	END;
	
	EXPORT history := MODULE
	
		// Creates a Dataset for the product name sent in call to history_template
		SHARED history_template(string filename) := DATASET(filename, AccountMonitoring.layouts.history, THOR, OPT);
		
		// '~' + lib_thorlib.thorlib.cluster()  + '::' + 'base::Account_Monitoring::' + TRIM(AccountMonitoring.constants.pseudo_ext(pseudo_environment)) + 'history' + '<Product_Name ie: bankruptcy>'
		EXPORT bankruptcy      := history_template(filenames(pseudo_environment).history.bankruptcy);
		EXPORT deceased        := history_template(filenames(pseudo_environment).history.deceased);
		EXPORT phone           := history_template(filenames(pseudo_environment).history.phone);
		EXPORT address         := history_template(filenames(pseudo_environment).history.address);
		EXPORT paw             := history_template(filenames(pseudo_environment).history.paw);
		EXPORT property        := history_template(filenames(pseudo_environment).history.property);
		EXPORT litigiousdebtor := history_template(filenames(pseudo_environment).history.litigiousdebtor);
		EXPORT liens           := history_template(filenames(pseudo_environment).history.liens);
		EXPORT criminal        := history_template(filenames(pseudo_environment).history.criminal);
		EXPORT phonefeedback   := history_template(filenames(pseudo_environment).history.phonefeedback);
		EXPORT foreclosure     := history_template(filenames(pseudo_environment).history.foreclosure);
		EXPORT workplace       := history_template(filenames(pseudo_environment).history.workplace);
		EXPORT reverseaddress  := history_template(filenames(pseudo_environment).history.reverseaddress);
		EXPORT didupdate  		 := history_template(filenames(pseudo_environment).history.didupdate);
		EXPORT bdidupdate  		 := history_template(filenames(pseudo_environment).history.bdidupdate);
		EXPORT phoneownership	 := history_template(filenames(pseudo_environment).history.phoneownership);
		EXPORT bipbestupdate	 := history_template(filenames(pseudo_environment).history.bipbestupdate);
		EXPORT sbfe	 					 := history_template(filenames(pseudo_environment).history.sbfe);
		EXPORT ucc	 					 := history_template(filenames(pseudo_environment).history.ucc);
		EXPORT govtdebarred		 := history_template(filenames(pseudo_environment).history.govtdebarred);
		EXPORT inquiry				 := history_template(filenames(pseudo_environment).history.inquiry);
		EXPORT corp	 					 := history_template(filenames(pseudo_environment).history.corp);
		EXPORT mvr	 					 := history_template(filenames(pseudo_environment).history.mvr);
		EXPORT aircraft 			 := history_template(filenames(pseudo_environment).history.aircraft);
		EXPORT watercraft			 := history_template(filenames(pseudo_environment).history.watercraft);
		EXPORT personheader			 := history_template(filenames(pseudo_environment).history.personheader);
	END;
	
	// Creates the dataset that the results will be written to
	EXPORT results := 
		DATASET(
			AccountMonitoring.filenames(pseudo_environment).results, 
			AccountMonitoring.layouts.results, 
			CSV (HEADING(1), SEPARATOR('|'), TERMINATOR('\n'))
		);

	// Creates the dataset used for Enterprise Company Management (Basics: used for companies with 
	//                                                             multiple divisions that monitor the same
	//                                                             products. ECM calculates a percentage
	//                                                             for charging each division based on the 
	//                                                             number of divisions monitoring that record.
	//                                                             IE: two divisions from the same company
	//                                                                 monitoring the same records would each 
	//                                                                 pay fifty percent of the monitoring cost.)
	//                                                             
	EXPORT ecm := MODULE
	
		EXPORT base := DATASET(AccountMonitoring.filenames(pseudo_environment).ecm.base, AccountMonitoring.layouts.ecm.base_layout, CSV (SEPARATOR('|'), TERMINATOR(['\n','\r\n']), QUOTE('')));
	
	END;
	
END;