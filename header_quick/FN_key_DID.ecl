import _Control,dx_header,header;

export FN_key_DID(dataset(dx_header.Layout_Header) head_in, string logicalname) := FUNCTION

//map date_first_seen when date_last_seen is 0

head := project(head_in, transform(dx_header.Layout_Header, 
self.dt_last_seen  := if(left.dt_last_seen = 0, left.dt_first_seen, left.dt_last_seen), self := left));

head_ccpa_compliant:=header.fn_suppress_ccpa(head,true);

idx := index(head_ccpa_compliant(did > 0), {did}, {head_ccpa_compliant} - layout_header_exclusions, logicalname);
return idx;

END;