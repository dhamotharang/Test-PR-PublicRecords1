#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header, ut,Business_HeaderV2;

export AMIDIR_As_Business_Contact
	:= fAMIDIR_As_Business_Contact(Business_HeaderV2.Source_Files.amidir.BusinessHeader)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::AMIDIR::AMIDIR_As_Business_Contact')
	;
