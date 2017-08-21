#OPTION('multiplePersistInstances',FALSE);
import Business_Header, ut, Address,business_headerv2;

export Vickers_As_Business_Contact
 := fVickers_As_Business_Contact(
		 Business_HeaderV2.Source_Files.vickers_13d13g.BusinessHeader
		,Business_HeaderV2.Source_Files.vickers_insider_filing.BusinessHeader
		,Business_HeaderV2.Source_Files.vickers_insider_security_in.BusinessHeader

	) : persist(business_header._dataset().thor_cluster_Persists + 'persist::Vickers::Vickers_As_Business_Contact')
 ;