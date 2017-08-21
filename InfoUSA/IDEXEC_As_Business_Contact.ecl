#OPTION('multiplePersistInstances',FALSE);
import business_header, infousa, ut, address,Business_HeaderV2;

export IDEXEC_as_Business_Contact 
	:= fIDEXEC_as_Business_Contact(Business_HeaderV2.Source_Files.infousa_idexec.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::IDEXEC_As_Business_Contact')
	;
