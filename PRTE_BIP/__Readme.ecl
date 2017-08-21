/*

PRTE_BIP - Customer Demo Data Process

		Overview:  The PRTE_BIP module contains two processes.   (PLEASE SEE BOTTOM ON HOW TO VALIDATE PRTE KEYS AGAINST PRODUCTION)!!

							 PROCESS #1:  EXECUTED BY SUBMITTING THE BWR NAMED: PRTE_BIP.BWR_PRTE_LOAD_BH_PER_SLIM_FILE
							 The first process will be used by the data insights team.  This will allow them to create a small
							 csv file in the layout specified in the PRTE_BIP.Layouts (see Input_Slim for the "slim" file 
							 format) and by running PRTE_BIP.BWR_PRTE_LOAD_BH_PER_SLIM_FILE creates a file with fake BIP
							 linkids appended to the file.  NO KEYS ARE CREATED FROM PROCESS #1. 

							 THE STEPS FOR DATA INSIGHTS FOR PROCESS #1 IS AS FOLLOWS:
							 1) Create a "slim" file on edata12 at location /data_999/tkirk/prte_extracts/ (please see
									PRTE_CSV._Constants (sServerIP & sDirectory) for path location in case this gets modified).
									The name of the file must contain "slim" and there can only be one slim file at this location.
									Otherwise, any file that contains the word "slim" will be read in.  (e.g. slim.csv)
							 2) Open the attribute named PRTE_BIP.BWR_PRTE_LOAD_BH_PER_SLIM_FILE into a builder window.
							 3) Submit job.
							 4) When the job is completed you will find the updated "slim" file at the same path location
									as defined in PRTE_CSV._Constants (sServerIP & sDirectory) as the input "slim" file.
									The output "unix" name of the update slim file is as follows:
									thor_data400::prte_bip::CCYYMMDD::updated_slim.csv (desprayed filename)								

							 The "slim" file will exist on thor as the following DURING execution of the job:
							 logical file name:		thor_data400::in::prte_bip::slim::CCYYMMDD::data 
							 superfile name:			thor_data400::in::prte_bip::slim::sprayed::data
							 unix "input" name:		customer_slim.csv  (can be anyname as long as the word "slim" is exists within the name)
							 NOTE:  if multiple files with the word "slim" exists at the path stated below, then all files with "slim"
											in the name will be read and processed.
			 
							 The "slim" files will exist on thor as the following AFTER the processing is completed:
							 logical file name:		thor_data400::in::prte_bip::slim::CCYYMMDD::data 
							 superfile name:			thor_data400::in::prte_bip::slim::used::data
							 unix "output" name:	thor_data400::prte_bip::CCYYMMDD::updated_slim.csv (desprayed filename)j
							 NOTE:  The unix "output" file will also exist on thor with the same name.
							
							 The format of the output file can be found in PRTE_BIP.Layouts
							 (see Output_Slim).  This file will then be desprayed back to edata12 at location 
								/data_999/tkirk/prte_extracts/ for them to use as they continue mocking up the data.

							 In summary, the first process takes a csv file (customer demo data) and sprays the data to thor. Then the
						   data is stamped with fake linkids and two files are created: 1) an updated "slim" file that
							 gets desprayed for data insight's group.  2) the PRTE_BIP Business Header base file is updated
							 with new customer demo data.  NO KEYS ARE CREATED FROM PROCESS #1.

							 Emails generated:
							 An email is generated on the location of the customer demo data (server and directory) that 
							 is read into the process and sprayed.  Also the logical file that gets created from the sprayed
							 data along with its associated superfile name is within the email.

							 At the end of the process an email is generated on the completion of the build if it was successful or 
							 a failure message if the job failed.
							 Note: If a PRTE_BIP Business Header base file already exists with the same build date that is
										 is being run, then a message will be generated that the file already exists and the build
										 is being skipped.


							 PROCESS #2: EXECUTED BY SUBMITTING THE BWR NAMED: PRTE_BIP.BWR_PRTE_BIP
							 The second process's primary goal is to create PRTE BIP Business Header Keys from demo data for various
							 products.  Each product's demo data (as indicated within the attribute PRTE_BIP.SprayFiles) will be
							 sprayed and added to their respective sprayed superfile.  Each product goes through a prep process that
						   prepares them to go through their respective "as_business_linking" (ABL) process.  The output from the 
							 "as_business_linking" process is a uniquely named persist file.
							
							 Two base files are generated from this process:  1) the "as_business_linking" (ABL) file which is the
							 concatenation of all the ABL persist files (the output from the ABL processes) named "abl_full_file". 2) the 
							 base file that is created using the "abl_full_file" that has been stamped with fake linkids and formatted 
							 into the business header layout in order to generate PRTE_BIP Business Header (BH) keys.

							 Emails generated:
							 An email is generated on the location of each products demo "base" file(s) including the server and 
							 directory information.  So several emails will be generated. Also the logical file(s) that gets created
							 from the sprayed data along with its associated superfile name is within the email.

							 At the end of the process an email is generated on the completion of the build if it was successful or 
							 a failure message if the job failed.


							 THE STEPS FOR OPERATIONS TO RUN PROCESS #2 IS AS FOLLOWS:
							 1) Create the "base" file(s) on edata12 at location /data_999/tkirk/prte_extracts/ (please see
									PRTE_CSV._Constants (sServerIP & sDirectory) for path location in case this gets modified).
									NOTE: Currently only prte__base__faa__aircraft_reg_built.csv is being processed.  The PRTE_BIP
												module will need modified to include other products.
							 2) Open the attribute named PRTE_BIP.BWR_PRTE_BIP into a builder window.
							 3) Submit job.
							 4) When the job is completed you will find the following two "prte_bip" base files:
									
									Logical filename: thor_data400::base::prte_bip::business_header::CCYYMMDD::data
									Superfile name:   thor_data400::base::prte_bip::business_header::qa::data

									Logical filename: thor_data400::base::prte_bip::abl_full_file::CCYYMMDD::data
 									Superfile name: 	thor_data400::base::prte_bip::abl_full_file::qa::data

								NOTE: Thor_data400::base::prte_bip::business_header::built::data is used to create the keys
											for the prte BIPV2FullKeys package.

		To Validate Keys:  Execute BIPV2_Build.PRTE_BIPV2FullKeys_Package('20150420e').outputpackage; with the version that you need checked.
								In this example, the version 20150420e is being validated.