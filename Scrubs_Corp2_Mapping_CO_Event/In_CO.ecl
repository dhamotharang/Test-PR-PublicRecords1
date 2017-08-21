import Corp2_Mapping, ut;

ds_CO := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150813::event_co',Corp2_Mapping.LayoutsCommon.events,thor);
export In_CO := distribute(ds_CO);
//Corp2_Mapping.LayoutsCommon.Events