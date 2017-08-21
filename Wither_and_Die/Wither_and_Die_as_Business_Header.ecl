#OPTION('multiplePersistInstances',FALSE);
import Business_Header, ut;

export wither_and_die_As_Business_Header
	:= fwither_and_die_As_Business_Header(wither_and_die.File_Wither_and_Die_In)
	: persist(business_header._dataset().thor_cluster_Persists + 'persist::Wither_and_Die::Wither_and_Die_as_Business_Header')
	;
