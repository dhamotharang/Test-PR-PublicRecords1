import ut;

//  Rollup Relative Group

export BH_Relative_Group_Rollup(

	 DATASET(Layout_Relative_Match	) pBH_Relative_Group_Combined	= BH_Relative_Group_Combined()
	,string														pPersistname								= persistnames().BHRelativeGroupRollup													
	,boolean													pShouldRecalculatePersist		= true													

) := FUNCTION

Layout_Relative_Group_Temp := record
unsigned6 group_id := 0;
Layout_Relative_Match;
end;


Relative_Group_Append := pBH_Relative_Group_Combined;

Layout_Relative_Group_Temp InitRelativeGroup(Layout_Relative_Match l) := transform
self := l;
self.group_id := l.bdid1;
end;

Relative_Group_Init := project(Relative_Group_Append, InitRelativeGroup(left));

Relative_Group_Dist := distribute(Relative_Group_Init, hash(group_id, match_type));
Relative_Group_Sort := sort(Relative_Group_Dist, group_id, match_type, bdid2, local);
Relative_Group_Grp := group(Relative_Group_Sort, group_id, match_type, local);

Layout_Relative_Group_Temp AssignGroupID(Layout_Relative_Group_Temp l, Layout_Relative_Group_Temp r) := transform
self.group_id := if(l.group_id = 0, r.group_id, l.group_id);
self := r;
end;

Relative_Group_Iter := group(iterate(Relative_Group_Grp, AssignGroupID(left,right)));

Layout_Business_Relative_Group FormatRelativeGroup(Layout_Relative_Group_Temp l) := transform
self.group_id := l.group_id;
self.group_type := l.match_type;
self.bdid := L.bdid2;
end;

Relative_Group_Out := project(Relative_Group_Iter, FormatRelativeGroup(left));
Relative_Group_Out_Sort := sort(Relative_Group_Out, group_id);

BH_Relative_Group_Rollup_persisted := Relative_Group_Out_Sort 
	: persist(pPersistname);

returndataset := if(pShouldRecalculatePersist = true, BH_Relative_Group_Rollup_persisted
																										, persists().BHRelativeGroupRollup
									);
return returndataset;

end;