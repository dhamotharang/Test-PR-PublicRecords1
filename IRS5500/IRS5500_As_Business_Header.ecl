#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header,Business_HeaderV2;

EXPORT IRS5500_As_Business_Header 
	:= fIRS5500_As_Business_Header(Business_HeaderV2.Source_Files.irs5500.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::IRS5500::IRS5500_As_Business_Header')
	;