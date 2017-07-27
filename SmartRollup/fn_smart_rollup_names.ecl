import iesp,smartRollup;
export fn_smart_rollup_names(dataset(iesp.bps_share.t_BpsReportIdentity) names2dedup) := function
 SmartRollup.MAC_suppress_name_dups(names2dedup, outrecs, name.last, name.first, name.middle);
 return choosen(outrecs,iesp.Constants.SMART.MAXAKA);
end;