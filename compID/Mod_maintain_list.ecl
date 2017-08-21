export Mod_maintain_list(
						dataset(Layout_compID_list)	pList
						,dataset(Layout_compID_out)	pCompID
						)	:= module

	cid0:=pCompID(new_cid_adl<>'');
	cid:=project(cid0,transform({Layout_compID_list}
							,self.did:=(unsigned6)left.new_cid_adl));
	export add:=dedup(sort(distribute(pList+cid,hash(did)),did,local),did,local);

	cid0:=pCompID(adl_stability_flag in ['S','C']);
	cid:=distribute(cid0,hash((unsigned6)original_cid_adl));
	export add_n_del:=join(add,cid
								,left.did=(unsigned6)right.original_cid_adl
								,transform(left)
								,left only
								,local);

end;