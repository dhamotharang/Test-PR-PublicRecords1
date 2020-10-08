IMPORT business_header;
EXPORT layout_supergroup := RECORD
  business_header.Layout_BH_Super_Group.group_id;
  business_header.Layout_BH_Super_Group.bdid;
  UNSIGNED1 level := 0;
END;
