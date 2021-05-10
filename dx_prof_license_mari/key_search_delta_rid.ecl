IMPORT dx_common, data_services;

rec := dx_common.layout_ridkey;

fname (integer typ) := IF (typ = data_services.data_env.iFCRA,
  $.names().i_fcra_search_delta_rid_super,
  $.names().i_search_delta_rid_super);

EXPORT key_search_delta_rid(integer typ=0) := INDEX ({rec.record_sid}, rec, fname(typ),OPT);
