import BIPV2_Entity, BIPV2, ut;

export Key_BH_Relationship := module

	export Key := BIPV2_Entity.Key_Relationship; // Should be used for debugging only
	
	export l_kFetch_in := {BIPV2.IDlayouts.l_xlink_ids.ProxID};
	
	export kFetch(dataset(l_kFetch_in) inputs) := function
		fetched := join(
			dedup(sort(inputs,proxid),proxid), Key,
			keyed(left.ProxID = right.ProxID1),
			transform(right),
			limit(ut.limits.DEFAULT, skip)
		);
		return BIPV2.IDmacros.mac_AppendHierarchyIDs(fetched,ProxID2);
	end;

end;