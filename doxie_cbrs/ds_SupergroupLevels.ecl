IMPORT business_header;

EXPORT ds_SupergroupLevels(DATASET(doxie_cbrs.layout_references) bdids = DATASET([], doxie_cbrs.layout_references)) :=
  IF(EXISTS(bdids),PROJECT(bdids,TRANSFORM(doxie_cbrs.layout_supergroup,SELF:=LEFT,SELF:=[])),
  business_header.getSupergroup
  (business_header.stored_bdid_value, business_header.stored_use_Levels_val));
