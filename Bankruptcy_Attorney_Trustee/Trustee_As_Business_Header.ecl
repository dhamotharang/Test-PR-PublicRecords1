#OPTION('multiplePersistInstances',FALSE);
import Business_Header,Business_HeaderV2;

export  Trustee_As_Business_Header:= fTrustee_As_Business_Header(Bankruptcy_Attorney_Trustee.Files.Trustees_Base) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::BAT::Trustee_As_Business_Header');
	

