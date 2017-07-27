import doxie_cbrs, business_header;

export fn_getSupergroup(dataset(doxie_cbrs.layout_supergroup) thegroupids, boolean use_Levels_val = false) := 
FUNCTION

unsigned4 max_Supergroup_val := 300 : stored('MaxSupergroup');

//****** GET ALL THE GROUP IDS
kb := JOIN (thegroupids, Business_Header.Key_BH_SuperGroup_BDID,
            KEYED (LEFT.bdid = RIGHT.bdid),
            TRANSFORM (RIGHT),
            KEEP (1), LIMIT (0));

//****** GET ALL THE BDIDS FOR THOSE GROUPS
kg := Business_Header.Key_BH_SuperGroup_GroupID;

outrec := doxie_cbrs.layout_supergroup;

outrec FetchBDIDGroup(kg r) := transform
self := r;
end;

bh_group := limit(kg(keyed(group_id in set(kb, group_id))), 30000, skip);
bh_group_count := count(bh_group);
bh_group_fetched := project(bh_group, FetchBDIDGroup(left));
	
//***** THIS WALKS THRU THE RELATIVE KEYS TO FIND LEVEL OF RELATION	
ssg := doxie_cbrs.fn_getSmallerSupergroup( thegroupids, max_supergroup_val);				

//***** ADD LEVEL INFO TO FETCHED GROUP
outrec addlevels(bh_group_fetched l, ssg r) := transform
	self.level := if(r.bdid > 0, r.level, 10);
	self := l;
end;

wlevels := join(bh_group_fetched, ssg, left.bdid = right.bdid, addlevels(left, right), left outer);

bh_group_out := 
	if((max_supergroup_val = 0 or max_Supergroup_val > bh_group_count) and bh_group_count > 0,
		 if(use_Levels_val, wlevels ,bh_group_fetched),
		 ssg);
						 
return bh_group_out;

END;