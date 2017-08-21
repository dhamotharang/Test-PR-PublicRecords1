// Filter any bad records from previous Business Contacts file on a new build

export boolean BC_Fix_Filter := 
not(
		///////////////////////////////////////////////////////////////////
		// -- EBR experian business reports
		///////////////////////////////////////////////////////////////////
		(		File_Business_Contacts.source					=	'MV') 

		///////////////////////////////////////////////////////////////////
		// -- Corporations with Blank addresses
		///////////////////////////////////////////////////////////////////
	or	(		File_Business_Contacts.source					= 	'C'
		 and	trim(File_Business_Contacts.company_prim_name)	= 	''
		 and	File_Business_Contacts.company_zip				= 	0
		)

		///////////////////////////////////////////////////////////////////
		// -- Oregon Watercraft records
		///////////////////////////////////////////////////////////////////
	or	(		File_Business_Contacts.source					=	'AW'
		 and	File_Business_Contacts.vendor_id[1..2]			=	'OR'
		)

		///////////////////////////////////////////////////////////////////
		// -- Corporations records with certain bad names
		///////////////////////////////////////////////////////////////////
	or	(		File_Business_Contacts.source					=	'C' 
		 and	File_Business_Contacts.company_name				in [ 'X'
																	,'SAME'
																	,'NATIONAL REGISTERED AGENTS, INC.'
																	,'NATIONAL REGISTERED AGENTS'
																   ]
		) 
);

