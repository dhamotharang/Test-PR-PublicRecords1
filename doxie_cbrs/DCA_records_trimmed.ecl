
doxie_cbrs.mac_Selection_Declare()

EXPORT DCA_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

  dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,FALSE,1)(Include_ParentCompany_val AND Include_DCA_val);

  ultimate_parent := CHOOSEN(SORT(dca_recs,level,sub),1);

  dcar_slim := doxie_cbrs.layouts.dca_slim_record;

  dcar_slim dca_slimmed(dca_recs L) := TRANSFORM
    SELF.prim_name := IF(L.prim_range = '' AND L.predir = '' AND
      L.prim_name = '' AND L.addr_suffix = '' AND
      L.postdir = '' AND L.sec_range = '' AND L.unit_desig = '',
      L.street, L.prim_name);
    SELF := L;
  END;

  SHARED dca_slim := PROJECT(ultimate_parent,dca_slimmed(LEFT));
  EXPORT records := CHOOSEN(dca_slim, Max_DCA_val);
  EXPORT records_count := COUNT(dca_slim);

END;
