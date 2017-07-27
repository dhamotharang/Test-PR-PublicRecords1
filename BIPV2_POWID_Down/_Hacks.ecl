No hacks needed right now.  The hack below was needed when my orgid specificity declaration was messed up, but not anymore.

---------------

BIPV2_POWID_Down.match_candidates:

// j8 := JOIN(h1,PULL(Specificities(ih).orgid_values_persisted),LEFT.orgid=RIGHT.orgid,add_orgid(LEFT,RIGHT,TRUE),LOOKUP,LEFT OUTER);
j8 := JOIN(h1,Specificities(ih).orgid_values_persisted,keyed(LEFT.orgid=RIGHT.orgid),add_orgid(LEFT,RIGHT,TRUE),LEFT OUTER);
