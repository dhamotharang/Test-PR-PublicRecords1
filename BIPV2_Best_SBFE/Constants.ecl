IMPORT	BIPV2_Best_SBFE,	Business_Credit,	MDR,	ut;
EXPORT	Constants(string	pFileDate='')	:=
MODULE

	//	Source
	EXPORT	source		:=	MDR.sourceTools.src_Business_Credit;
		
	//	Build Types
	EXPORT	buildType :=	Business_Credit.Constants(pFileDate).buildType;
	
END;
