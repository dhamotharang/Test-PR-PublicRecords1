export Mac_History_Daily_Did(infile, mod_access, did_field, outfile) := macro

  import gong, Suppress;

  #uniquename(did_history_key)
  %did_history_key% := gong.key_history_did;

  #uniquename(gong_did_history)
  %gong_did_history% := join(infile, %did_history_key%, keyed(left.did_field = right.l_did),
    TRANSFORM(right), LIMIT(ut.limits.GONG_HISTORY_MAX, SKIP));

  outfile := Suppress.MAC_SuppressSource(%gong_did_history%, mod_access, did_field);

endmacro;