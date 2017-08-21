import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151014::main_mi',Corp2_Mapping.LayoutsCommon.main,thor);
ds_filt := ds(recordorigin = 'C');
//ds_filt := ds;

export In_MI := distribute(ds_filt,hash32(corp_key));
//Corp2_Mapping.LayoutsCommon.Main