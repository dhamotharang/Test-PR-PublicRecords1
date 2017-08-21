#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut, Business_HeaderV2;

EXPORT ABIUS_Company_As_Business_Header 
	:= fABIUS_Company_As_Business_Header(Business_HeaderV2.Source_Files.abius.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::ABIUS_Company_As_Business_Header')
	;