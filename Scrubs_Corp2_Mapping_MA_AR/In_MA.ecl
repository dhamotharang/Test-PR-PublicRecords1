import Corp2_Mapping, ut;

ds_MA := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150812::ar_ma',Corp2_Mapping.LayoutsCommon.AR,thor);

export In_ma := distribute(ds_MA);
//Corp2_Mapping.LayoutsCommon.AR