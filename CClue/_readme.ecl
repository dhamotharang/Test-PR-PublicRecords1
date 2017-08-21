/*
	Commercial Clue - CClue:
	
		Overview: CClue (Commercial Comprehensive Loss. Underwriting Exchange) provides the commercial claim information across all standard lines of business data. 
 							
		Remote copy a base file from Insurance Thors, and use it to update(full file replace) the base file on thor.

		The Build:
			
			Quick Documentation to run the thor build:

				Insurance Thor					: 10.194.12.1
				Remote Superfile name		: thor::base::cclue::qa::search::output
				Remote logical name			: thor::base::cclue::<version date>::it01::search::output
				Thor Module							: CClue
				Orbit Build							: CClue
				Frequency								: By Weekly
				
				1.	Open CClue._bwr_Build_All in a builder window. Change the pversion to today's date or the logical file version date 
						of the insurance base file that needs to be remote copied from insurance Thor. 
						To get to insurance eclwatch page :- http://10.194.12.2:8010
						ex:- superfile name   : thor::base::cclue::qa::search::output
								 Logicalfile name : thor::base::cclue::20150405::it01::search::output
				2.  Execute it.
				3.	In Orbit, create a build instance of the "CClue" build.  Add the update file(s) used in the build.
						When the build finishes and goes up into roxie dev, update the roxie production status to 
						"On Development".
				4.	The build will send you an email when it finishes successfully, or a fail email if it fails.
			
				Thor Part(CClue._bwr_Build_All):
						1. RemoteCopy the file & add to sprayed superfile
						2. Build the base files
						3. Build the Roxie keys
						4. Build Strata
						5. Update DOPS
						
	
	Notes:
		
		The thor process uses the following attribute's email address to send emails:
			_control.MyInfo.EmailAddressNotify
		
		Please sandbox this attribute with your email address.  Do not check it in.
		
*/