import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151014::event_mi',Corp2_Mapping.LayoutsCommon.events,thor);
export In_MI := distribute(ds);
//Corp2_Mapping.LayoutsCommon.events