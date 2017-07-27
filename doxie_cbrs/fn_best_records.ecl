import Business_Header,doxie,doxie_cbrs,ut;

export fn_best_records(
  dataset(doxie_cbrs.layout_supergroup) thegroupids,
	boolean in_use_supergroup
) :=
function
	doxie.mac_header_field_Declare()
	
	precs := if(in_use_supergroup,doxie_cbrs.fn_getSupergroup(thegroupids, business_header.stored_use_Levels_val),thegroupids);
	
	kg := business_header.Key_BH_SuperGroup_BDID;
	
	recordof(precs) addgroupid(precs l, kg r) := transform
	  self.group_id := r.group_id;
		self := l;
	end;
	
	precs0 := join(precs,kg,
                 keyed (left.bdid = right.bdid),
                 addgroupid(left,right),
                 left outer,
                 keep (1), limit (0));
	
	outrec := record
		unsigned1 level;
		unsigned6 group_id;
		doxie_cbrs.Layout_BH_Best_String;
	end;
	
	doxie_cbrs.mac_best_records(precs0, bh_best, outrec)
	doxie_cbrs.mac_knowx_best_records(precs0, knowx_best, outrec)
	best_info:= IF(ut.IndustryClass.is_knowx,knowx_best,bh_best);
	
	return best_info;
end;