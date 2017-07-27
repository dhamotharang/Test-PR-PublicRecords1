f := dataset('TEMP::BH_Super_Group', Business_Header.Layout_BH_Super_Group, flat);

// Choose BDID for Group
fbdid := f(bdid = 44530114);  //Lexis-Nexis
//fbdid := f(bdid = 105640874);  //Seven-Resorts
//fbdid := f(bdid = 18039411);  //Seisint


Business_Header.Layout_BH_Super_Group GetGroup(f l, Business_Header.Layout_BH_Super_Group r) := transform
self := l;
end;

fgroup := join(f, fbdid, left.group_id = right.group_id, GetGroup(left, right), lookup);

output(fgroup, all);

// output best records for group
Business_Header.Layout_BH_Best GetGroupBest(Business_Header.Layout_BH_Best l, Business_Header.Layout_BH_Super_Group r) := transform
self := l;
end;

fbest := join(Business_Header.File_Business_Header_Best, fgroup, left.bdid = right.bdid, GetGroupBest(left,right), lookup);

output(fbest,all);



