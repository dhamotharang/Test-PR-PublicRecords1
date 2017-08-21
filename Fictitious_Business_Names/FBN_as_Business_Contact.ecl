IMPORT Business_Header, FBN_new,Business_HeaderV2;

export FBN_as_Business_Contact := fFBN_as_Business_Contact(FBN_new.File_FBN_update)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Fictitious_Business_Names::FBN_as_Business_Contact');