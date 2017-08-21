import Corp2_Mapping, ut;

ds := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20151005::main_la',Corp2_Mapping.LayoutsCommon.Main,thor);
ds_filt := ds;
//ds_filt := ds(ut.fntrim2upper(recordorigin) = 'C');

export In_LA := distribute(ds_filt);
//Corp2_Mapping.LayoutsCommon.Main