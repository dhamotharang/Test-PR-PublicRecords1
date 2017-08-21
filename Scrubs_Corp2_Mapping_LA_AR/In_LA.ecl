import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151007::ar_la',Corp2_Mapping.LayoutsCommon.AR,thor);

export In_LA := distribute(ds);
//Corp2_Mapping.LayoutsCommon.AR