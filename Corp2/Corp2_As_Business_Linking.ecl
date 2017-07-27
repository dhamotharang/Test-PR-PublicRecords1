#OPTION('multiplePersistInstances',FALSE);
export Corp2_As_Business_Linking := Corp2.fCorp2_As_Business_Linking(corp2.files().AID.corp.prod,corp2.files().AID.cont.prod,corp2.files().base.events.prod)
															  : PERSIST(Corp2.Cluster.Cluster_out + 'persist::' + Corp2.DatasetName + '::as_Business_Linking');							 