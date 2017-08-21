import doxie;

//update the base file child dids set with the newest found
export func_update_base(dataset(layout_customer_base_seq) f_base,
                        dataset(layout_customer_base_seq) f_triple,
                        dataset(layout_acctno_did) f_dids_update) := function
	
//initialize all records should update dids	
f_in_triple_slim := table(f_triple, {f_triple.seq});	
f_in_triple_seq := dedup(sort(f_in_triple_slim, seq), seq);
	
layout_customer_base_seq init_dids(f_base l, f_in_triple_seq r) := transform
	self.dids := if(r.seq=0,l.dids, dataset([],{doxie.layout_references}));
	self := l;
end;	
	
f_base_init := join(f_base, f_in_triple_seq,
                    left.seq = right.seq,
                    init_dids(left, right), left outer);

//update with dids				   				   
layout_customer_base_seq get_dids_update(f_base_init l, f_dids_update r, unsigned cnt) := transform
    self.dids := l.dids + if(cnt>50,
                             dataset([],doxie.layout_references),
                             dataset([{r.did}], {doxie.layout_references}));
    self := l;	
end;
	
f_base_updated := denormalize(f_base_init, f_dids_update,
                              left.seq = (unsigned)right.acctno,
                              get_dids_update(left, right, counter));

return f_base_updated;						 
	
end;