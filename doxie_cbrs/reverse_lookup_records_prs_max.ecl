doxie_cbrs.mac_Selection_Declare()
export reverse_lookup_records_prs_max(dataset(doxie_cbrs.layout_references) bdids) := function
r := doxie_cbrs.reverse_lookup_records_prs(bdids)(Return_ReversePhone_val and not past_max);

//gonna lop it off for exactly max
r lop(r l) := transform
	overshot := l.cumulative_count - max_reverselookup_val;
	self.listed_name_children := 
		if(overshot < 0, 
			 l.listed_name_children,
			 choosen(l.listed_name_children, count(l.listed_name_children) - overshot));
	self := l;
end;

return project(r, lop(left));
end;