import Corp2_Mapping, ut;

ds_MA := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150812::event_MA',Corp2_Mapping.LayoutsCommon.events,thor);
export In_MA := distribute(ds_MA);
//Corp2_Mapping.LayoutsCommon.Events