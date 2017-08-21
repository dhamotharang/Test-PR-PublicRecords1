import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151005::event_la',Corp2_Mapping.LayoutsCommon.events,thor);
export In_LA := distribute(ds);
//Corp2_Mapping.LayoutsCommon.Events