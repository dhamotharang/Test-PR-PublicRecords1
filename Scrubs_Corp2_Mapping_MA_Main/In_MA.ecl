import Corp2_Mapping, ut;

ds_MA := dataset(Corp2_Mapping._Dataset().thor_cluster_Files + 'in::corp2::20150812::main_ma',Corp2_Mapping.LayoutsCommon.Main,thor);
ds_filt := ds_MA(ut.fntrim2upper(recordorigin) = 'T');
export In_MA := distribute(ds_filt);
//Corp2_Mapping.LayoutsCommon.Main