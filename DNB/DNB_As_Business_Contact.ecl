IMPORT Business_Header,Business_HeaderV2;

export DNB_As_Business_Contact := fDNB_As_Business_Contact(Business_HeaderV2.Source_Files.dnb_contacts.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::DNB::DNB_As_Business_Contact');