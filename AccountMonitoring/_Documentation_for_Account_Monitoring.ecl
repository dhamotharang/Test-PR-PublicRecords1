
/*

	********** Modify the following files when adding a new product (cgm) **********
	AccountMonitoring.constants
	AccountMonitoring.filenames
	AccountMonitoring.files
	AccountMonitoring.fn_portfolio_update
	AccountMonitoring.layouts
	AccountMonitoring.proc_input_portfolio_update
	AccountMonitoring.product_configs
	AccountMonitoring.Run
	AccountMonitoring.types
	AccountMonitoring.Utilities
	
	...and...:
	
	AccountMonitoring.product_files
	AccountMonitoring.Get_Dataset_Versions
	AccountMonitoring.fn_generate_ecm_metrics 
	
	********** Raison d'etre **********
	
	"This batch capability/enhancement will effectively and efficiently monitor a customers 
	portfolio for important changes and communicate those changes back to the customer urgently.  
	This solution will build on the successful bankruptcy and deceased monitoring that has been in 
	place for years and the phone and address monitoring that was originally built to service NCO."
	
	                                                      -- Requirements Spec dated 6-24-2009
	
	********** Account Monitoring system description: **********
	
	1. Intial Build: Base/Portfolio and History files are copied from the Batch R3 system to Thor.

	2. Portfolio Changes: Customer supplies LN/Risk with periodic updates. These may be:
	    - a new iteration of the entire portfolio
	    - a delta to modify the existing portfolio

	3. "Daily Delta": Kettle will update Thor with changes to the Portfolio by uploading them to 
	   an FTP server and then spraying them to a superfile on Thor, where Kettle will direct Thor 
		 to pick it up at will.

	NOTE: Processes 1 thru 3 are decoupled completely from the Account Monitoring job process itself.

	4. Job Kickoff: Kettle invokes a Batch Account Monitoring job on Thor, passing a bit mask value
	   that specified which Products to run. It also begins to monitor Thor for job completion.

	5. Perform Monitoring [AccountMonitoring.Run( )]: A predefined process accepts the Batch 
	   Account Monitoring job parameters and selects the Candidate Generation Mechanisms (CGMs) 
		 necessary to expedite the job. Then, the process determines the list of candidates (i.e. 
		 those candidates for whom a change has occurred in one or more associated documents). 
		 Monitoring jobs may be distributed throughout the day to ease system load. That is, 
		 Bankruptcy and Liens may be run during one part of the day, while Property and Address 
		 may be run at another time. The Product IDs bitmask being passed in to Thor will dictate 
		 which Source Doc Files to join to.

	6. Dedup the Results: Once the candidate list is obtained, the process dedupes the list 
	   against the product-specific candidate History files. The result of the dedup function 
		 is a list of candidates that have experienced change since the last time a monitoring 
		 job was run.

	7. Output Results: Thor outputs the Candidate List to file. Each record in the Candidate 
	   list shall contain:
	    - the portfolio input record identifier(s)
	    - the identity of the entity described in the Portfolio (i.e. a DID or BDID), when possible 
	    - the identity the product(s) that registered a hit based on the date filter passed to Thor

	8. Update Candidate History: Thor updates the product-specific candidate History files with 
	   those candidates that survived the dedup function. The candidate History files shall consist 
		 of one file per product (or source document type). 
		 
	9. Retrieve Candidates: The Batch R3 system retrieves the Candidate List file from Thor.  

	10. Request Source Docs: The Batch R3 system invokes one or more batch jobs on Roxie.  The 
	    required Roxie Batch Service(s) retrieve the updated Source Documents.

	11. Return Source Docs: Roxie returns the Source Documents to the Batch R3 system.

	12. Finish Monitoring Process: The Batch R3 system applies any necessary business rules and 
	    formatting to meet specific customer requirements and returns the results to the Customer.
		
	
	********** Account Monitoring Thor subsystem process summary: **********
	
	To accomplish account monitoring, the system must join the Monitoring Portfolio to one or more 
	products (bankruptcy, phone, address, etc.); the system will return all matching records, and 
	all monitorable fields shall be represented by a HASH() value. Next, this result set is joined 
	to one or more associated history files, and the hash values are compared. If they differ, then
	we presume the product record has changed, and the system subsequently desprays to file or a 
	Landing	Zone all records whose hash value is different. The Batch R3 system then retrieves these 
	results from file or the Landing Zone and runs another batch query against Roxie to obtain the 
	actual document records.
	
	The system runs a Monitoring job against 1 to N products based on the bitmask value of the 
	product_mask, which Kettle passes in as a parameter to AccountMonitoring.Run( ). All 
	references to files, filenames, and CGM names are found in the configuration modules named 
	mod_Monitoring_[productname]. This should help this process to scale more easily.
	

	********** Adding a new Product to Account Monitoring: **********

	Note: All attribute names refer to those in the AccountMonitoring module unless otherwise mentioned.

	FILE REFERENCES:
	
	1. Modify BWR_create_history_superfiles by adding the following actions to the attribute:
	
	csfN   := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::[productname]'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::[productname]') );	
	csfN+1 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::[productname]_father'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::[productname]_father');
	csfN+2 := IF( NOT FileServices.SuperfileExists(cluster+'base::Account_Monitoring::history::[productname]_grandfather'),
	               FileServices.CreateSuperFile (cluster+'base::Account_Monitoring::history::[productname]_grandfather');

	...and modify the SEQUENTIAL action at the bottom of the BWR to add the three new CSFs.
	
	2. In the Types attribute (module), add a new value to the Exportable attribute productMask in 
	   the manner found there and redefine the allProducts value to account for your new product value.
		 
	3. Add new Exportable filename to the Files.filenames module in the manner found there.
	
	4. Add new Exportable history file reference to the Files attribute (module) in the manner found for 
	   Bankruptcy, Deceased, etc.
	
	PRODUCT FILE REFERENCES
	
	5. Add a new module having the name of the new product to the Product_Files attribute, and create 
	   however many references you require to the product files located on the Prod Dali (i.e. ut.foreign_prod). 
		 Mind that some files may require some additional logic to be made useful to Account Monitoring. 
		 Some things to keep in mind:
		   o  This is a good place to Persist those files that are updated infrequently to reduce data
			    transmission time.
			 o  This is also a good place to make the files slimmer (to only those fields necessary for running
			    the Account Monitoring job) to reduce the amount of disk space they occupy.

	6. Add a new, local attribute having the name of the new product to AccountMonitoring.Get_Dataset_Versions 
	   and configure it as you see with the other local product attributes there. Union this attribute to the 
		 All_Products local attribute.
	
	CANDIDATE GENERATION MECHANISMS (CGMs)
	
	7. Write a new attribute--a Candidate Generation Mechanism--and ensure that it obeys the interface 
	   definition for all of the other CGMs that have been written thus far (i.e. those attributes named 
		 'fn_cgm_[productname]'), and that you have unit-tested it to the point where it returns the 
		 results it should.
	
	PRODUCT CONFIGURATION MODULE
	
	8. Write a new attribute--a product configuration module--and ensure that it inherits from the 
	   i_Monitoring_Product_Config interface. In this module, make appropriate reference to your new 
		 filename, file, and CGM attributes, See other product configuration modules for examples, e.g.
		  - AccountMonitoring.mod_Monitoring_address
			- AccountMonitoring.mod_Monitoring_bankruptcy
			- AccountMonitoring.mod_Monitoring_deceased
	
	IN THE SERVICE-LEVEL ATTRIBUTE
	
	9. In the Run attribute, add your product to the list of other products, defining the following 
	attributes:

		// ***** [productname] *****
			m_cfg_[productname]               := .....
			candidates_[productname]          := .....
			update_history_file_[productname] := .....

	10. Next, in the Run attribute, add a reference to the attribute candidates_[productname] to the list 
	    of attributes that are unioned together to comprise candidate_all. 
		 
	11. Then, in the Run attribute, add a reference to the attribute update_history_file_[productname] to 
	    the list of Parallel actions that comprise update_history_files.

	DENOUEMENT
	
	12. Shake head in wonder at how easy this was.
	


	********** Invoking in a Builder Window: **********
	
	AccountMonitoring.Run(  AccountMonitoring.types.productMask.bankruptcy 
	                      | AccountMonitoring.types.productMask.phone
												| AccountMonitoring.types.productMask.[productname] 
												// add other products as needed to fulfill the monitoring job requirements.
	                         , '');
													 
													 	
*/