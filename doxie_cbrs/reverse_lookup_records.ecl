
doxie_cbrs.mac_Selection_Declare()

export reverse_lookup_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

phones := dedup(doxie_cbrs.best_records_bdids(bdids)(Include_ReversePhone_val and (integer)phone <> 0), phone, all);
k := doxie_cbrs.key_phone_gong;

{unsigned1 level, k} keepk(unsigned1 l, k r) := transform
	self.level := l;
	self := r;
end;

jnd := join(phones, k, left.phone = right.phone10, keepk(left.level, right), KEEP(10), LIMIT(100,SKIP));


return jnd(z5 <> '' and (prim_range <> '' or prim_name <> ''));
END;
	