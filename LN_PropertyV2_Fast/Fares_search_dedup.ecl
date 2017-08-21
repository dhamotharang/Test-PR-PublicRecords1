import ut,LN_PropertyV2,property,LN_PropertyV2_Fast;

export Fares_search_dedup(dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod))  in_search,
                          dataset(recordof(LN_PropertyV2_Fast.Layout_Fares_Deeds))   deeds_dedup,
						  dataset(recordof(ln_propertyV2_Fast.layout_fares_assessor)) assesor_dedup) :=
function

fares_rec := record
 string12 fares_id;
end;

fares_rec deedSlim(recordof(deeds_dedup) L) := transform
 self := l;
end;

fares_rec assesSlim(recordof(assesor_dedup) L) := transform
 self := l;
end;

search_file := distribute(in_search,hash(ln_fares_id));

deeds_file := project(deeds_dedup,deedslim(left));
asses_file := project(assesor_dedup,assesSlim(left));

join_file := distribute(deeds_file+asses_file,hash(fares_id));

recordof(in_search) loseAsses(search_file L, fares_rec R) := transform
 self := l;
end;

search_dup := join(search_file,join_file,left.ln_fares_id=right.fares_id,loseAsses(left,right),local);

return search_dup;

end;

