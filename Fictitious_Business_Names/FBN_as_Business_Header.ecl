import business_headerV2,Business_Header, FBN_new;

EXPORT FBN_as_Business_Header := fFBN_as_Business_Header(FBN_new.File_FBN_update)
 : PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Fictitious_Business_Names::FBN_as_Business_Header');
