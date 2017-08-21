// Filter any bad records from previous Business Header file on a new build

export boolean BH_Fix_Filter := 
not(
	///////////////////////////////////////////////////////////////////
	// -- EBR experian business reports
	///////////////////////////////////////////////////////////////////
	(		File_Business_Header.source						=	'MV') 

	///////////////////////////////////////////////////////////////////
	// -- Corporations with Blank addresses
	///////////////////////////////////////////////////////////////////
or	(		File_Business_Header.source						= 	'C'
	 and	trim(File_Business_Header.prim_name)			= 	''
	 and	File_Business_Header.zip						= 	0
	)

	///////////////////////////////////////////////////////////////////
	// -- Oregon Watercraft records
	///////////////////////////////////////////////////////////////////
or	(		File_Business_Header.source						= 	'AW'
	 and	File_Business_Header.vendor_id[1..2]			=	'OR'
	)

	///////////////////////////////////////////////////////////////////
	// -- Corporations records with certain bad names
	///////////////////////////////////////////////////////////////////
or	(		File_Business_Header.source						=	'C' 
	 and	File_Business_Header.company_name				in [ 'X'
																,'SAME'
																,'NATIONAL REGISTERED AGENTS, INC.'
																,'NATIONAL REGISTERED AGENTS'
															   ]
	) 
);