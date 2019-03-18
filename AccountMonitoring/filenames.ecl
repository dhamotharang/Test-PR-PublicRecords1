IMPORT AccountMonitoring;

// The file names/locations for the products in the various systems (ie: results, history, documents, inquiry tracking, ecm, etc)
EXPORT filenames(unsigned1 pseudo_environment) := MODULE

	// The top most folder in the Account Monitoring structure
	SHARED base_template := AccountMonitoring.constants.filename_cluster + 'base::Account_Monitoring::' + TRIM(AccountMonitoring.constants.pseudo_ext(pseudo_environment));

	// The file name and location of the base, update, archive and remote Portfolio files
	EXPORT portfolio := MODULE
	
		SHARED portfolio_template(string var) := base_template + 'portfolio::' + var;
		EXPORT base            := portfolio_template('base');
		EXPORT update          := portfolio_template('update');
		EXPORT archive         := portfolio_template('archive');
		// EXPORT super           := portfolio_template('super');
		EXPORT remote          := 'portfolio.txt';
	END;

	// The file name and location of the document files (Currently only used in Bankruptcy but 
	//                                                   can be used in any CGM if the CGM is 
	//                                                   programmed to do so).
	EXPORT documents := MODULE
	
		SHARED documents_template(string product) := MODULE
		EXPORT base          := base_template + 'documents::' + product + '::base';
		EXPORT update        := base_template + 'documents::' + product + '::update';
		EXPORT remote        := 'documents.' + product + '.txt';
	END;
		
		EXPORT bankruptcy      := documents_template('bankruptcy');
		EXPORT deceased        := documents_template('deceased');
		EXPORT address         := documents_template('address');
		EXPORT phone           := documents_template('phone');
		EXPORT paw             := documents_template('paw');
		EXPORT property        := documents_template('property');
		EXPORT litigiousdebtor := documents_template('litigiousdebtor');
		EXPORT liens           := documents_template('liens');
		EXPORT criminal        := documents_template('criminal');
		EXPORT phonefeedback   := documents_template('phonefeedback');
		EXPORT foreclosure     := documents_template('foreclosure');
	  EXPORT workplace       := documents_template('workplace');
		EXPORT reverseaddress  := documents_template('reverseaddress');
		EXPORT didupdate  		 := documents_template('didupdate');
		EXPORT bdidupdate  		 := documents_template('bdidupdate');
		EXPORT phoneownership	 := documents_template('phoneownership');
		EXPORT bipbestupdate   := documents_template('bipbestupdate');
		EXPORT sbfe   				 := documents_template('sbfe');
		EXPORT ucc   				 	 := documents_template('ucc');
		EXPORT govtdebarred	 	 := documents_template('govtdebarred');
		EXPORT inquiry			 	 := documents_template('inquiry');
		EXPORT corp					 	 := documents_template('corp');
		EXPORT mvr					 	 := documents_template('mvr');
		EXPORT aircraft			 	 := documents_template('aircraft');
		EXPORT watercraft		 	 := documents_template('watercraft');
		EXPORT personheader		 	 := documents_template('personheader');
	END;
	
	// The file name and location of the history files.  
	// We maintain three versions of the results: current, father and grandfather for each product
	EXPORT history := MODULE
	
		SHARED history_template(string var) := base_template + 'history::' + var;
		EXPORT bankruptcy      := history_template('bankruptcy');
		EXPORT deceased        := history_template('deceased');
		EXPORT phone           := history_template('phone');
		EXPORT address         := history_template('address');
		EXPORT paw             := history_template('paw');
		EXPORT property        := history_template('property');
		EXPORT litigiousdebtor := history_template('litigiousdebtor');
		EXPORT liens           := history_template('liens');
		EXPORT criminal        := history_template('criminal');
		EXPORT phonefeedback   := history_template('phonefeedback');
		EXPORT foreclosure     := history_template('foreclosure');
	  EXPORT workplace       := history_template('workplace');	
		EXPORT reverseaddress  := history_template('reverseaddress');
		EXPORT didupdate  		 := history_template('didupdate');
		EXPORT bdidupdate  		 := history_template('bdidupdate');
		EXPORT phoneownership	 := history_template('phoneownership');
		EXPORT bipbestupdate	 := history_template('bipbestupdate');
		EXPORT sbfe	 					 := history_template('sbfe');
		EXPORT ucc	 					 := history_template('ucc');
		EXPORT govtdebarred		 := history_template('govtdebarred');
		EXPORT inquiry				 := history_template('inquiry');
		EXPORT corp	 					 := history_template('corp');
		EXPORT mvr	 					 := history_template('mvr');
		EXPORT aircraft				 := history_template('aircraft');
		EXPORT watercraft			 := history_template('watercraft');
    EXPORT personheader		 	 := documents_template('personheader');
	END;
	
	// The file name and location of the Inquiry tracking files are used solely for auditing purposes
	EXPORT inquirytracking := base_template + 'inquirytracking';
	
	// The location of the final results file
	EXPORT results := base_template + 'results';

	// The file name & location of the base, results & remote ecm (Enterprise Company Management) files
	//                                                            (Basics: used for companies with 
	//                                                             multiple divisions that monitor the same
	//                                                             products. ECM calculates a percentage
	//                                                             for charging each division based on the 
	//                                                             number of divisions monitoring that record.
	//                                                             IE: two divisions from the same company
	//                                                                 monitoring the same records would each 
	//                                                                 pay fifty percent of the monitoring cost.)
	//                                                             

	EXPORT ecm := MODULE
		SHARED ecm_template(string var) := base_template + 'ecm::' + var;
		EXPORT base                     := ecm_template('base');
		EXPORT results                  := ecm_template('results');
		EXPORT remote                   := 'ecm.txt';
	END;
	
END;