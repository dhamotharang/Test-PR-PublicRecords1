import business_headerV2, Business_Header;

EXPORT Gong_As_Business_Header := fGong_As_Business_Header(Business_HeaderV2.Source_Files.gong_history.BusinessHeader)
         : PERSIST(business_header._dataset().thor_cluster_Persists + 'persist::Gong::Gong_As_Business_Header');