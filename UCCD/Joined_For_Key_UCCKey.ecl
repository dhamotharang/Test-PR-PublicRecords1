withsummary := uccd.joined_for_key(ucc_key <> '');

wsum_sort := sort(dedup(sort(withsummary(ucc_key not in uccd.bogus_keys),
					ucc_key, event_document_num, collateral_child, debtor_name, debtor_prim_range, secured_name, secured_prim_name, local),
				ucc_key, event_document_num, collateral_child, debtor_name, debtor_prim_range, secured_name, secured_prim_name, local),
			ucc_key,event_document_num, debtor_name, debtor_prim_range, secured_name, secured_prim_name, local);

uccd.Layout_Doxie_Records into_outformat(wsum_sort L) := transform
	self.collateral_children := row({L.collateral_child},uccd.Layout_Collateral_ChildDS);
	self := l;
end;

wsum := project(wsum_sort, into_outformat(LEFT));

uccd.Layout_Doxie_Records rollem(wsum l, wsum r) := transform
	self.collateral_children := if(count(r.collateral_children) > 0, l.collateral_children + r.collateral_children, l.collateral_children);
	self := l;
end;
			
fetched := rollup(wsum,	
					left.ucc_key = right.ucc_key and 
					left.event_document_num = right.event_document_num and
					left.debtor_name = right.debtor_name and 
					left.debtor_prim_range = right.debtor_prim_range and
					left.secured_name = right.secured_name and
					left.secured_prim_name = right.secured_prim_name,
					rollem(left, right), local);

export Joined_For_Key_UCCKey := fetched;