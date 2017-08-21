import header;

export Header_blocked_data(dataset(recordof(header.layout_header)) in_hdr) := function

did_set := [
33638066154,
14261128832,
33679397195,
25030319,
1235021511, 
501203239,
86342354,
889376,
897549976,
43765524793,
753153811,
5938537,
63224493325,
911692354,
8432912,
43765524793,
911692354,
43819847475,
15853684,
8434112
];

 filter_by_did    := in_hdr(did not in did_set);  
 filter_by_jflag2 := header.fn_filter_for_keys_and_slimsorts(filter_by_did);
 
 return filter_by_jflag2;

end;