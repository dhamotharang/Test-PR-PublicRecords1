IMPORT $;

EXPORT GetIdentitiesCount(DATASET($.Layouts.PhoneFinder.Final) dIn) :=
FUNCTION
  dInDedup := DEDUP(SORT(dIn, acctno, phone, did, fname, lname), acctno, phone, IF(did != 0, (STRING)did, TRIM(fname) + ' ' + TRIM(lname)));

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
