IMPORT	ut;
EXPORT	isDateSSARestricted(STRING	pFileDate) := FUNCTION
	//Check if the date falls under SSA Restrictions
	SSA_Restriction_Date				:=	'20140326';
	Today												:=	WORKUNIT[2..9];
	BOOLEAN	Restricted_SSA_Date	:=	(pFileDate >= SSA_Restriction_Date AND 
																					 ut.date_math(pFileDate,ut.DaysInNYears(3)) > Today);
																					 
	RETURN Restricted_SSA_Date;
END;
