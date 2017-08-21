#OPTION('multiplePersistInstances',FALSE);
import business_headerV2,Business_Header;

EXPORT FCC_licenses_As_Business_Header := fFCC_Licenses_As_Business_Header(Business_HeaderV2.Source_Files.fcc_base.BusinessHeader)
	: PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::FCC::FCC_licenses_As_Business_Header');