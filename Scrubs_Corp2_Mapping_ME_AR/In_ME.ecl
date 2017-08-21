import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160429::ar_me',Corp2_Mapping.LayoutsCommon.AR,thor);
export In_MI := distribute(ds);
//Corp2_Mapping.LayoutsCommon.AR