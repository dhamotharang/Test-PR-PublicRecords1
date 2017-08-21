import Corp2_Mapping, ut;

ds_MN := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160420::event_mn',Corp2_Mapping.LayoutsCommon.events,thor);
export In_MN := distribute(ds_MN);
//Corp2_Mapping.LayoutsCommon.Events