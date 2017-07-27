export mac_roll_DLS_tdate(dls_name) := macro 
  l_dls_int := iesp.ECL2ESP.DateToInteger(l.dls_name);
  r_dls_int := iesp.ECL2ESP.DateToInteger(r.dls_name);
	self.dls_name := if(l_dls_int > r_dls_int, l.dls_name, r.dls_name);
endmacro;