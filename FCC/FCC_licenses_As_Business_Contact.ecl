#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;

export FCC_Licenses_as_Business_Contact := fFCC_licenses_As_Business_Contact(Business_HeaderV2.Source_Files.fcc_base.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::FCC::FCC_Licenses_as_Business_Contact');
