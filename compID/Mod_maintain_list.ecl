export Mod_maintain_list(
						dataset(Layout_compID_list)	pList
						,dataset(Layout_compID_out)	pCompID
						)	:= module

	shared list:=distribute(pList,hash(did));
	shared compID_tx:=distribute(pCompID(original_cid_adl<>''),hash((unsigned6)original_cid_adl));

	cid:=project(compID_tx,transform({Layout_compID_list},self.did:=(unsigned6)left.original_cid_adl,self:=left));
	export add:=dedup(sort(distribute(list+cid,hash(did)),did,local),did,local);

	export add_n_del:=join(add,compID_tx(adl_stability_flag in ['S','C'])
									,left.did=(unsigned6)right.original_cid_adl
									,left only
									,local);

end;