#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut,business_headerv2;

export Cleaned_TXBUS_As_Business_Contact
	:= fCleaned_TXBUS_As_Business_Contact(Business_HeaderV2.Source_Files.txbus.businessheader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::TXBUS::Cleaned_TXBUS_As_Business_Contact')
	;