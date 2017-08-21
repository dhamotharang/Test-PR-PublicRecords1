#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header;

EXPORT Wither_and_Die_As_Business_Contact
	:= fwither_and_Die_As_Business_Contact(wither_and_die.File_Wither_and_Die_In) 
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Wither_and_Die::Wither_and_Die_As_Business_Contact')
	;
