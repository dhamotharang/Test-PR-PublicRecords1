IMPORT ut,watchdog;
doxie_cbrs.mac_Selection_Declare()

EXPORT Associated_Business_byContact_records(DATASET(doxie_cbrs.layout_references) bdids) := FUNCTION

abc := doxie_cbrs.best_rest(bdids)(isByC, prim_range <> '' OR prim_name <> '');

outrec := RECORD
  abc;
  watchdog.Layout_best.fname;
  watchdog.Layout_best.mname;
  watchdog.Layout_best.lname;
  UNSIGNED2 seq := 0;
  BOOLEAN hasBBB := FALSE;
  BOOLEAN hasBBB_NM := FALSE;
END;

doxie.mac_best_records(abc,
                       did,
                       outfile,
                       dppa_ok,
                       glb_ok,
                       ,
                       doxie.DataRestriction.fixed_DRM);

//add name by key
outrec addname(abc l, outfile r) := TRANSFORM
  SELF.fname := r.fname;
  SELF.mname := r.mname;
  SELF.lname := r.lname;
  SELF := l;
END;

abcfat_bykey_j := JOIN(abc, outfile,
  LEFT.did = RIGHT.did,
  addName(LEFT, RIGHT), LEFT OUTER);

abcfat_bykey := SORT(abcfat_bykey_j, lname, fname, mname, company_name, bdid, did);

//add name by contacts (to limit to those shown)
con := doxie_cbrs.contact_records_prs_max(bdids);
outrec addname2(abc l, con r) := TRANSFORM
  SELF.fname := r.fname;
  SELF.mname := r.mname;
  SELF.lname := r.lname;
  SELF.seq := r.seq;
  SELF := l;
END;

abcfat_bycon_j := JOIN(abc, con, LEFT.did = RIGHT.did, addname2(LEFT,RIGHT), KEEP(1));
abcfat_bycon := SORT(abcfat_bycon_j, seq, did, bdid);

//only use contact route if showing them
abcfat := IF(Include_AssociatedPeople_val,abcfat_bycon,abcfat_bykey);

doxie_cbrs.mac_hasBBB(abcfat, wb, bdids)

RETURN wb;
END;
