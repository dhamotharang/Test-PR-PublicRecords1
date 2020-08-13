IMPORT doxie_cbrs, business_header;

EXPORT fn_getSupergroup(DATASET(doxie_cbrs.layout_supergroup) thegroupids, BOOLEAN use_Levels_val = FALSE) :=
FUNCTION

UNSIGNED4 max_Supergroup_val := 300 : STORED('MaxSupergroup');

//****** GET ALL THE GROUP IDS
kb := JOIN (thegroupids, Business_Header.Key_BH_SuperGroup_BDID,
            KEYED (LEFT.bdid = RIGHT.bdid),
            TRANSFORM (RIGHT),
            KEEP (1), LIMIT (0));

//****** GET ALL THE BDIDS FOR THOSE GROUPS
kg := Business_Header.Key_BH_SuperGroup_GroupID;

outrec := doxie_cbrs.layout_supergroup;

outrec FetchBDIDGroup(kg r) := TRANSFORM
SELF := r;
END;

bh_group := LIMIT(kg(KEYED(group_id IN SET(kb, group_id))), 30000, SKIP);
bh_group_count := COUNT(bh_group);
bh_group_fetched := PROJECT(bh_group, FetchBDIDGroup(LEFT));
  
//***** THIS WALKS THRU THE RELATIVE KEYS TO FIND LEVEL OF RELATION
ssg := doxie_cbrs.fn_getSmallerSupergroup( thegroupids, max_supergroup_val);

//***** ADD LEVEL INFO TO FETCHED GROUP
outrec addlevels(bh_group_fetched l, ssg r) := TRANSFORM
  SELF.level := IF(r.bdid > 0, r.level, 10);
  SELF := l;
END;

wlevels := JOIN(bh_group_fetched, ssg, LEFT.bdid = RIGHT.bdid, addlevels(LEFT, RIGHT), LEFT OUTER);

bh_group_out :=
  IF((max_supergroup_val = 0 OR max_Supergroup_val > bh_group_count) AND bh_group_count > 0,
     IF(use_Levels_val, wlevels ,bh_group_fetched),
     ssg);
             
RETURN bh_group_out;

END;
