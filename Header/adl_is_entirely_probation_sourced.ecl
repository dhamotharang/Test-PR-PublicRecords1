import mdr;

hdr := header.file_headers;

r1 := record
 hdr.did;
 boolean source_is_on_prob;
end;

r1 t1(hdr le) := transform
 self.source_is_on_prob := mdr.sourcetools.sourceisonprobation(le.src);
 self                   := le;
end;

p1      := project(hdr,t1(left));
p1_dist := distribute(p1,hash(did));
p1_sort := sort(p1_dist,did,source_is_on_prob,local);
p1_dupd := dedup(p1_sort,did,source_is_on_prob,local);

r1 t2(r1 le, r1 ri) := transform
 self.source_is_on_prob := if(le.source_is_on_prob=false,le.source_is_on_prob,ri.source_is_on_prob);
 self                   := le;
end;

p2 := rollup(p1_dupd,left.did=right.did,t2(left,right),local);

export adl_is_entirely_probation_sourced := p2(source_is_on_prob=true);