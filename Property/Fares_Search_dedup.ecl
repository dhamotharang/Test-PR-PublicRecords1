import ut;
fares_rec := record
 string12 fares_id;
end;

fares_rec deedSlim(property.Layout_Fares_Deeds L) := transform
 self := l;
end;

fares_rec assesSlim(property.Layout_Fares_Assessor L) := transform
 self := l;
end;

search_file := distribute(property.File_Fares_Search,hash(fares_id));
deeds_file := project(property.file_fares_deeds,deedslim(left));
asses_file := project(property.File_Fares_Assessor,assesSlim(left));

join_file := distribute(deeds_file+asses_file,hash(fares_id));

property.Layout_Fares_Search loseAsses(search_file L, fares_rec R) := transform
 self := l;
end;

j1 := join(search_file,join_file,left.fares_id=right.fares_id,loseAsses(left,right),local);

ut.MAC_SF_BuildProcess(j1,'~thor_data400::in::fares_search',run_dup,2,,true);
export Fares_search_dedup := run_dup;