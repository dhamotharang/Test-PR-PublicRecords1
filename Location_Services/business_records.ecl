import doxie, doxie_raw, ut, Business_Header;

export business_records(dataset(Doxie_Raw.Layout_address_input) addrs, doxie.IDataAccess mod_access) := FUNCTION

doxie.layout_addressSearch trafam(Doxie_Raw.Layout_address_input l) := transform
	SELF.seq := 0;
	SELF.prim_name := ut.StripOrdinal(L.prim_name);
	SELF.state := l.st;
	SELF := l;
end;

fam := project(addrs, trafam(left));
by_addr := Doxie.bdid_from_address(fam, true, true);

bhkb := Business_Header.Key_BH_Best;

layout_result := record
	unsigned6 group_id;
	Business_Header.Layout_BH_Best;
end;

layout_result AddBest(by_addr l,  bhkb r) := transform
	self.bdid := l.bdid;
	self.group_id := 0;
	self := r;
end;

best_j := join(by_addr(bdid != 0), bhkb,
				keyed(left.bdid = right.bdid) AND 
				doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
				AddBest(left, right),
				left outer,
        keep(1), limit(0));

layout_result AddGroup(best_j l, Business_Header.Key_BH_SuperGroup_BDID r) := transform
	self.group_id := r.group_id;
	self := l;
end;

best_group := join(best_j, Business_Header.Key_BH_SuperGroup_BDID,
				keyed (left.bdid = right.bdid),
				AddGroup(left,right),
				keep(1), limit(0));
				
RETURN best_group;
END;
