import header,_Control;

export FN_key_DID(dataset(header.Layout_Header) head_in, string logicalname) := FUNCTION

//map date_first_seen when date_last_seen is 0

head := project(head_in, transform(header.Layout_Header, 
self.dt_last_seen  := if(left.dt_last_seen = 0, left.dt_first_seen, left.dt_last_seen), self := left));

idx := index(head(did > 0), {did}, {head} - layout_header_exclusions, logicalname);
return idx;

END;