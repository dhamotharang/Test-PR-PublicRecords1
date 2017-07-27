withsummary := distribute(uccd.joined_for_key(bdid != 0), hash(bdid));

wsum_sort := sort(dedup(sort(withsummary(ucc_key not in uccd.bogus_keys),
					bdid, ucc_key, event_document_num, collateral_child, -secured_prim_name, local),
				bdid, ucc_key, event_document_num, collateral_child, local),
			bdid,ucc_key,event_document_num,-secured_prim_name, local);

uccd.Layout_Doxie_Records into_outformat(wsum_sort L) := transform
	self.collateral_children := row({L.collateral_child},uccd.Layout_Collateral_ChildDS);
	self := l;
end;

wsum := project(wsum_sort, into_outformat(LEFT));

uccd.Layout_Doxie_Records rollem(wsum l, wsum r) := transform
	self.collateral_children := if(count(r.collateral_children) > 0, l.collateral_children + r.collateral_children, l.collateral_children);
	self := l;
end;
			
fetched := rollup(wsum,	right.bdid = left.bdid and
					left.ucc_key = right.ucc_key and 
					left.event_document_num = right.event_document_num, 
					rollem(left, right), local);

export Joined_For_Key_BDID := fetched;