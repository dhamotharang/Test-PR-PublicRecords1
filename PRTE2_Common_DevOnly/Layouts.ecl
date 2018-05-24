IMPORT IDLExternalLinking;

EXPORT Layouts := MODULE
	
	EXPORT Layout_HeaderSearchIn := RECORD
		INTEGER	UniqueID		{XPATH('UniqueID')};
		STRING	SNAME				{XPATH('SNAME')}; 
		STRING	FNAME				{XPATH('FNAME')}; 
		STRING	MNAME				{XPATH('MNAME')}; 
		STRING	LNAME				{XPATH('LNAME')};
		STRING	GENDER			{XPATH('GENDER')};
		STRING	PRIM_RANGE	{XPATH('PRIM_RANGE')};
		STRING	PRIM_NAME		{XPATH('PRIM_NAME')}; 
		STRING	SEC_RANGE		{XPATH('SEC_RANGE')};
		STRING	CITY				{XPATH('CITY')};
		STRING	ST					{XPATH('ST')};
		STRING	ZIP					{XPATH('ZIP')};
		STRING	SSN					{XPATH('SSN')};
		STRING	DOB					{XPATH('DOB')};
		STRING	DL_STATE		{XPATH('DL_STATE')};
		STRING	DL_NBR			{XPATH('DL_NBR')};
	END;
	
	//EXPORT Layout_HeaderSearchOut := IDLExternalLinking.layout_recs_withindistance;
	EXPORT Layout_HeaderSearchOut := RECORD
		INTEGER UniqueID;
		INTEGER did;
		INTEGER Weight;
	END;
	EXPORT Layout_HeaderSearchWeight := RECORD
		INTEGER xjoinidx;
		INTEGER did;
		INTEGER Weight;
	END;
	EXPORT STRING1 highrise_ind;
	EXPORT STRING1 resi_or_busi_ind;
		
END;