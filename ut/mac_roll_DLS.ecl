export mac_roll_DLS(dls_name) := macro
	self.dls_name := if(l.dls_name > r.dls_name, l.dls_name, r.dls_name);
endmacro;