IMPORT Business_Header,doxie,doxie_cbrs,ut;

EXPORT fn_best_records(
  DATASET(doxie_cbrs.layout_supergroup) thegroupids,
  BOOLEAN in_use_supergroup
) :=
FUNCTION
  doxie.mac_header_field_Declare()
  
  precs := IF(in_use_supergroup,doxie_cbrs.fn_getSupergroup(thegroupids, business_header.stored_use_Levels_val),thegroupids);
  
  kg := business_header.Key_BH_SuperGroup_BDID;
  
  RECORDOF(precs) addgroupid(precs l, kg r) := TRANSFORM
    SELF.group_id := r.group_id;
    SELF := l;
  END;
  
  precs0 := JOIN(precs,kg,
                 KEYED (LEFT.bdid = RIGHT.bdid),
                 addgroupid(LEFT,RIGHT),
                 LEFT OUTER,
                 KEEP (1), LIMIT (0));
  
  outrec := RECORD
    UNSIGNED1 level;
    UNSIGNED6 group_id;
    doxie_cbrs.Layout_BH_Best_String;
  END;
  
  doxie_cbrs.mac_best_records(precs0, bh_best, outrec)
  doxie_cbrs.mac_knowx_best_records(precs0, knowx_best, outrec)
  best_info:= IF(ut.IndustryClass.is_knowx,knowx_best,bh_best);
  
  RETURN best_info;
END;
