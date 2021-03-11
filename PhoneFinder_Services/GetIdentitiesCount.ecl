IMPORT $, Phones;

EXPORT GetIdentitiesCount(DATASET($.Layouts.PhoneFinder.Final) dIn) :=
FUNCTION

  dIn_filter := dIn(did != 0 OR lname != '' OR listed_name != '' OR typeflag != Phones.Constants.TypeFlag.DataSource_PV);
  dInDedup_did := DEDUP(SORT(dIn_filter(did != 0), acctno, phone, did), 
                        acctno, phone, did );

  dInDedup_nodid := DEDUP(SORT(dIn_filter((did = 0)), acctno, phone, fname, lname, listed_name, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range, city_name, st, zip), 
                        acctno, phone, fname, lname, listed_name, prim_range, prim_name, predir, suffix, postdir, unit_desig, sec_range,city_name, st, zip);                      
  
  dInDedup := SORT(dInDedup_did & dInDedup_nodid, acctno, phone);
  rCntIdentity_Layout :=
  RECORD
    dInDedup.acctno;
    dInDedup.phone;
    UNSIGNED2 cnt_identities := COUNT(GROUP);
  END;

  // Rollup on phone, to get count the identities for each phone
  dCntIdentities := TABLE(dInDedup, rCntIdentity_Layout, acctno, phone, FEW);

  // Append the count flag to the input dataset
  dAppendCntIds := JOIN(dIn, dCntIdentities,
                        LEFT.acctno = RIGHT.acctno AND
                        LEFT.phone  = RIGHT.phone,
                        TRANSFORM($.Layouts.PhoneFinder.Final, SELF.identity_count := RIGHT.cnt_identities, SELF := LEFT),
                        LEFT OUTER,
                        LIMIT(0), KEEP(1));

  #IF($.Constants.Debug.Intermediate)
    OUTPUT(dInDedup, NAMED('dInDedup'));
    OUTPUT(dCntIdentities, NAMED('dCntIdentities'));
    OUTPUT(dAppendCntIds, NAMED('dAppendCntIds'));

  #END
  RETURN dAppendCntIds;
END;
