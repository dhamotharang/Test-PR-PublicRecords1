/*
	Link2tek:
	
		Data Description: The wireless file provided by Link2tek is created by multiple sources of data. One of the largest initial sources that is compiled 
											is the portability file and the NANP (North American Numbering Plan) file. Those phone numbers are then matched to a consumer file 
											(Gathered from opt-in sources).  After that compilation, the file is then taken against the telco real-time network. The wireless 
											file is  built using corroboration of multiple sources and verification codes are provided from the telco network for every record so 
											that users better understand the linkage of name, address, landlines, and then mobile compared to the telecom data.
		
		Input File Data Dictionary:
				Field Name											Len							Definition
				-----------------------------------------------------------------------------------------------
				Phone														10							Mobile telephone number for the individual
				First Name											15							First name of the individual
				Middle Initial									 1							Middile initial
				Last Name												20							Last name of the individual
				Primary Street Number						10							House number
				Primary Street Pre Dir Abbrev		 2							Street pre direction: N, S, E, W, NE, SW, etc.
				Primary Street Name							28							Street name of PO Box ###, or RR ### Box ###, or HC ### Box ###
				Primary Street Suffix						 4							e.g. ST, AVE, PL, BLVD, PKWY, etc.
				Primary Street Post Dir Abbrev	 2							Street post direction: N, S, E, W, NE, etc.
				Secondary Address Type					 4							Apt. v Ste.
				Secondary Address Number				 8							Apt. # or Suite #
				City														28							As listed in USPS Publication 26, Directory of Post Offices.  Post Office names in excess of 28 positions have
																													been abbreviated by USPS.
				State														 2							2 character representation of state
				ZIP_Code												 5							5 digit zip code
				ZIP_Plus4												 4							Four-position numeric ZIP+4, ZIP code extension
				USPS ZIP+4 Types								 1							Address type for given Zip+4
																													Blank = Z4 type could not be determined
																													F = Firm
																													G = General delivery
																													H = High-rise
																													P = PO Box
																													R = Rural Route
																													S = Street
				Latitude												11							Latitude
				Longitude												11							Longitude
				CRTE														 4							Carrier route
				DPC															 3							Delivery point code with check digit
				Verified												 1							A - Name, Address and Phone match
																												B - Phone and Name match
																												C - Phone and Address match
																												D - Name and Address match
																												E - Not enough corroborating data to determine match


		The Build:
			
			Quick Documentation to run the thor build:

				Thor Module			: Link2tek
				Orbit Build			: Link2tek
				DOPS package		: There are no request for keys at the time 
				Frequency				: Quarterly
				Landing Path		: \\tapeload02b\k\eval\miscellaneous_people\link2tek_(ei)\
				
				1. 	FTP file to //edata12/hds_180/link2tek/[version]
				2.	Open Link2tek._BWR_Build and execute the code in that attribute.  Change the version to the files date (YYYYMMDD).
						That should the same date used for the folder created in step 1.  
				3.	In Orbit, create a build instance of the "Link2tek" build.  
				5.	The build will send you an email when it finishes successfully, or a fail email if it fails.

			
*/
						
	
	