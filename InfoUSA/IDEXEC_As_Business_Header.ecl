#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut,address,Business_HeaderV2;

EXPORT IDEXEC_as_Business_Header
	:= fIDEXEC_as_Business_Header(Business_HeaderV2.Source_Files.infousa_idexec.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::InfoUSA::IDEXEC_As_Business_Header')
	;