/* 
   Source							Mississippi Secretary of State				
	 Update Frequency		Monthly												
	 Update Type				Updates Only												
	 				
	 Data Description		The state sends updates to historical and current business entity filings.  The layout was
											developed by the state's third party IT developer for use by multiple states.  Many of the 
											record files are not mapped since they contain internal information or do not apply to the
											MS Secretary of State.												
										
	 Source Notes				Vendor provides data in XML format with the extract folder containing three subdirectories: 
											Forms, Profiles, and XML. 

  â€œProfilesâ€ directory â€“ contains a single tab-delimited text file. The â€œProfilesâ€ file is intended to serve as
     a â€œCard Catalogâ€ for the XML. This text file contains a list of all profiles that were created/modified after
     the date provided to the system.

  All profile XMLs are located in the â€œXMLâ€ directory. The profile text file contains a link to the XML for each
     profile generated. Please note that the folder â€œ\Extractsâ€ should be replaced with path to which the Extract 
     ZIP file was extracted. 

  "Formsâ€ directory also contains a single tab-delimited file. The â€œformsâ€ file lists all forms that were created
     or modified for the business profiles specified in the â€œProfileâ€ file.												
*/