#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;

export Cleaned_TXBUS_As_Business_Header
	:= fCleaned_TXBUS_As_Business_Header(Business_HeaderV2.Source_Files.txbus.businessheader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::TXBUS::Cleaned_TXBUS_As_Business_Header');