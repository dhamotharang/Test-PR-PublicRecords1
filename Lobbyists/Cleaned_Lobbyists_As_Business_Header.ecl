import Business_Header,Business_HeaderV2;

export Cleaned_Lobbyists_As_Business_Header
	:= fCleaned_Lobbyists_As_Business_Header(dataset('~thor_data400::base::lobbyists::qa',Lobbyists.Layout_Lobbyists_Common,thor))
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Lobbyists::Cleaned_Lobbyists_As_Business_Header');