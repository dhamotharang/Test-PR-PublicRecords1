import Corp2_Mapping, ut;

ds_NV := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20160328::event_nv',Corp2_Mapping.LayoutsCommon.events,thor);
export In_NV := distribute(ds_NV);
//Corp2_Mapping.LayoutsCommon.Events