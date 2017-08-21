export proc_build_roxie_keys(string rundate) := function

 build_gong_roxie_keys := sequential(
  gong_v2.proc_build_keys_current_jtrost(rundate)
 //,gong_v2.proc_build_keys_history_jtrost(rundate)
 );
 
 return build_gong_roxie_keys;

end;