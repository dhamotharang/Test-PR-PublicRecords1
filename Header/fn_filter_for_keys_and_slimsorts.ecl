import mdr;

export fn_filter_for_keys_and_slimsorts(dataset(recordof(header.layout_header)) in_hdr, boolean also_remove_probation=false) := function

 //allowing C's in -> DID's in Property only, more than 1 record, and wasn't previously ambiguous
 keep_these0 := in_hdr(jflag2 not in ['A','B','D','E']);
 
 keep_these := if(also_remove_probation=true,keep_these0(mdr.sourceTools.SourceIsOnProbation(src)=false),keep_these0);
 
 return keep_these;

end;