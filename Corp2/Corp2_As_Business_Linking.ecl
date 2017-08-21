#OPTION('multiplePersistInstances',FALSE); 
import mdr;

ds_recorp  := Corp2.fCorp2_As_Business_Linking    (corp2.files().AID.corp.prod,corp2.files().AID.cont.prod,corp2.files().base.events.prod);

export Corp2_As_Business_Linking := ds_recorp 
	: PERSIST(Corp2.Cluster.Cluster_out + 'persist::' + Corp2.DatasetName + '::as_Business_Linking');							 

