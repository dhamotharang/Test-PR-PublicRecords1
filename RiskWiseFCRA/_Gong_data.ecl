import doxie, dx_gong, FCRA, data_services;

MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;

export _Gong_data (dataset (doxie.layout_references) dids,
                   dataset (fcra.Layout_override_flag) ds_flagfile) := function

  Layout_Gong := dx_Gong.layouts.i_history_did;

  gong_ffids := SET(ds_flagfile(file_id = FCRA.FILE_ID.GONG), flag_file_id );
  gong_keys  := SET(ds_flagfile(file_id = FCRA.FILE_ID.GONG), trim(record_id) );
  gong_corr  := CHOOSEN(FCRA.key_override_gong_ffid( keyed( flag_file_id in gong_ffids ) ), MAX_OVERRIDE_LIMIT );

  gong_main := join (dids, dx_gong.key_history_did(data_services.data_env.iFCRA),
                     keyed(left.did=right.l_did) and trim((string12)right.did+(string10)right.phone10+(string8)right.dt_first_seen) not in gong_keys // old way - prior to 11/13/2012
										 and trim((string)right.persistent_record_id) not in gong_keys, // new way - using persistent_record_id
                     transform( layout_gong, self := right),
                     KEEP(100), LIMIT(1000));
  gong_deduped := dedup(sort(gong_main,record),all);

  res := gong_deduped + PROJECT( gong_corr, transform (Layout_Gong,
                                                       self.l_did := left.did,
                                                       self := LEFT,
                                                       SELF :=[]));

  return res;
end;
