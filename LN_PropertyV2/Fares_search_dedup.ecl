import ut,LN_PropertyV2,property;

export Fares_search_dedup(dataset(recordof(LN_PropertyV2.Layout_Fares_Search_in))  in_search,
                          dataset(recordof(property.layout_fares_deeds))   deeds_dedup,
						  dataset(recordof(property.layout_fares_assessor)) assesor_dedup) :=
function

fares_rec := record
 string12 fares_id;
end;

fares_rec deedSlim(property.Layout_Fares_Deeds L) := transform
 self := l;
end;

fares_rec assesSlim(property.Layout_Fares_Assessor L) := transform
 self := l;
end;

search_file := distribute(in_search,hash(fares_id));

deeds_file := project(deeds_dedup,deedslim(left));
asses_file := project(assesor_dedup,assesSlim(left));

join_file := distribute(deeds_file+asses_file,hash(fares_id));

LN_PropertyV2.Layout_Fares_Search_in loseAsses(search_file L, fares_rec R) := transform
 self := l;
end;

search_dup := join(search_file,join_file,left.fares_id=right.fares_id,loseAsses(left,right),local);

return search_dup;

end;

