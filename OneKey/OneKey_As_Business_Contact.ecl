﻿#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header;

EXPORT OneKey_As_Business_Contact := fOneKey_As_Business_Contact(OneKey.Files().Base.BusinessHeader) 
	: persist(Business_Header._Dataset().thor_cluster_Persists +  'persist::OneKey::OneKey_As_Business_Contact');