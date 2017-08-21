#OPTION('multiplePersistInstances',FALSE);
import ut, Business_Header,Business_HeaderV2; 

export AMIDIR_As_Business_Header
	:= fAMIDIR_As_Business_Header(Business_HeaderV2.Source_Files.amidir.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::AMIDIR::AMIDIR_As_Business_Header')
	;