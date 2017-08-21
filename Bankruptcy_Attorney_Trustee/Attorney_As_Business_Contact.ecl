#OPTION('multiplePersistInstances',FALSE);
import business_header,Business_HeaderV2;

export Attorney_As_Business_Contact := fAttorney_As_Business_Contact(Business_HeaderV2.Source_Files.bankruptcy_Attorney.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::BAT::Attorney_As_Business_Contact');