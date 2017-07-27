/*
AUTHOR: JSARDESHMUKH
1. PRE-PROCESS SUPPLIED XML FILES WITH PERL UTILITY BEFORE THE SPRAY
   The XML files supplied are not well formed XML. They are missing the '<subscriber>'
	 tag for the root element, resulting in unmatched tag , as there is a </subscriber> closing
	 tag.
	 
	 I wrote a PERL utility to cycle thru the files on the landing zone to prepend the tag
	 to every file. The 'fixed' files all have a '_fixed.xml' in the name
	 
	 Lookout for the following in the input XML files..
	 We(BOB) contacted the vendor regarding another XML issue that needed correction. 
	 They were including a '#' character in a tag. This is illegal causing ECL to break while processing XML.
	 New files were supplied. BUT be on the lookout for this issue
	                         
	 
2. LIMITED TESTING DONE FOR DELETES 
   Note Limited testing for deletes has been as only 4 sample records were supplied 
	 This needs to be investigated further.
	 
3. OVERVIEW OF key attributes
   3.1 fnDateTime 
	     ==========
	     is a function to standardize the different TIMESTAMP and DATE formats
	     in the XML file. : ALL dates are converted to CCYYMMDD format and timestamps are
			 converted to CCMMYYDD-HHNNSS.fs-Zone(3 char ie EST ,MDT etc)
	 3.2 prep_booking_files_from_xml
	     ===========================
	     a) reads the sprayed xml files  from  a holding superfile
			 b) denormalizes the BOOKING records and the associated CHARGE_DETAIL records
			 c) fixes all date and timestamps to standard format
			 e) cleans names , addresses 
			 f) Adds DID and SSN using the appropriate MACRO
		3.3 prep_agency_delete_files_from_xml
		   ===================================
			 a) just a straight forward read from sprayed XML file. 
			 
4. ONLY BOOKING and CHILD CHARGE_DETAIL NOTES are handled and tested so far
	

*/
export _readme := 'open to readme';