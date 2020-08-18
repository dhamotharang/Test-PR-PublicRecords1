EXPORT DCA_records_trimmed(DATASET(doxie_cbrs.layout_references) bdids) :=
MODULE

doxie_cbrs.mac_Selection_Declare()

// ut.mac_slim_back(bdid_dataset,doxie_cbrs.layout_references,wla);

dca_recs := doxie_cbrs.fn_DCA_records_dayton(bdids,FALSE,1)(Include_ParentCompany_val AND Include_DCA_val);

ultimate_parent := CHOOSEN(SORT(dca_recs,level,sub),1);

dcar_slim := RECORD
  dca_recs.level;
  dca_recs.name;
  dca_recs.prim_range;
  dca_recs.predir;
  dca_recs.prim_name;
  dca_recs.addr_suffix;
  dca_recs.postdir;
  dca_recs.sec_range;
  dca_recs.unit_desig;
  STRING25 city;
  STRING2 state;
  STRING5 zip;
  dca_recs.zip4;
  dca_recs.Province;
  dca_recs.Country;
  dca_recs.Phone;
  dca_recs.bus_desc;
END;

dcar_slim dca_slimmed(dca_recs L) := TRANSFORM
  SELF.prim_name := IF(L.prim_range = '' AND L.predir = '' AND
             L.prim_name = '' AND L.addr_suffix = '' AND
             L.postdir = '' AND L.sec_range = '' AND L.unit_desig = '',
             L.street, L.prim_name);
  SELF := L;
END;

SHARED dca_slim := PROJECT(ultimate_parent,dca_slimmed(LEFT));

doxie_cbrs.mac_Selection_Declare()

EXPORT records := CHOOSEN(dca_slim,Max_DCA_val);
EXPORT records_count := COUNT(dca_slim);

END;
