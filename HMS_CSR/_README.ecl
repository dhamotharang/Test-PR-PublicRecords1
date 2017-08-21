/*
	HMS State Controlled Substance Registration Numbers (CSRs):
	
		Overview: State Controlled Substance Registration Numbers (CSRs)  - Data received from Health Market Science.
							CSRs are issued and enforced by approximately 22 States and territories in the US to regulate the 
							amount and class of drugs being prescribed and dispensed in their state. Each state is in charge of 
							managing their own data sets and provide us with extracts on a recurring basis of their current roster. 
							We need to get this data loaded and made available for our customers so they are able to make intelligent 
							decisions as to whether providers are allowed to prescribe in a specific state and what type of drugs 
							they are allowed to prescribe.

		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: HMS_CSR
				Orbit Build			: HMS HMS State Controlled Substance Registration Numbers
				DOPS package		: There are no request for keys at the time 
				Frequency				: Daily/Weekly/Monthly
				Landing Path		: \\tapeload02b\k\healthcare\hms_lexisnexis_(ei)\HMSCSR\
				
				1. 	FTP daily file to //edata12/hms/hms_csr/[version]
				2.	Open HMS_CSR._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMMDD).
						That should the same date used for the folder created in step 1.  
				3.	In Orbit, create a build instance of the "HMS State Controlled Substance Registration Numbers" build.  
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			

						
	
	