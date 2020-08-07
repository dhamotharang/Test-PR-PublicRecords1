IMPORT ut, doxie_cbrs, business_header;

EXPORT fn_DCA_records_dayton(
  DATASET(doxie_cbrs.layout_references) thegroupids,
  BOOLEAN in_use_supergroup,
  UNSIGNED1 in_direction = 0
) := FUNCTION
  bdid_dataset :=
    table(
      doxie_cbrs.fn_getSupergroup(
        PROJECT(
          thegroupids,
          TRANSFORM(
            doxie_cbrs.layout_supergroup,
            SELF.group_id := 0,
            SELF.level := 0,
            SELF := LEFT)),
        business_header.stored_use_Levels_val),
      {bdid});
  ut.MAC_Slim_Back(bdid_dataset, doxie_cbrs.layout_references, bdids_use)
  
  tempdca := doxie_cbrs.get_DCA_records(IF(in_use_supergroup,bdids_use,thegroupids),IF(in_use_supergroup,1,in_direction));
  temprec := RECORD
    tempdca;
    UNSIGNED6 group_id;
  END;
  kb := Business_Header.Key_BH_SuperGroup_BDID;
  temprec attachgroupid(tempdca l, kb r) := TRANSFORM
    SELF.group_id := r.group_id;
    SELF := l;
  END;
  res := JOIN (tempdca, kb,
               KEYED (LEFT.bdid=RIGHT.bdid),
               attachgroupid(LEFT,RIGHT),
               LEFT OUTER,
               KEEP (1), LIMIT (0));
  RETURN res (group_id <> 0);
END;
