IMPORT doxie, ut;

EXPORT GetFlagFile (DATASET (doxie.layout_best) ds_best) := FUNCTION

  // result will contain flag records for "this" person only
  READ_LIMIT := ut.limits.FLAG_RECORDS_PER_PERSON;

  flag_rec := RECORD
    DATASET (fcra.Layout_override_flag) flags {MAXCOUNT(READ_LIMIT)};
  END;

  // fetch flag records for this person
  flag_rec GetFlagRecords (doxie.layout_best L) := TRANSFORM
    ssn_flags := CHOOSEN (fcra.key_override_flag_ssn (keyed (l_ssn = L.ssn), datalib.NameMatch (L.fname, L.mname, L.lname, fname, mname, lname)<3),
                          READ_LIMIT);
    did_flags := CHOOSEN (fcra.key_override_flag_did (keyed (l_did = (string)L.did)),
                          READ_LIMIT);

    flags_all := PROJECT (did_flags, fcra.Layout_override_flag) +
                 PROJECT (ssn_flags, fcra.Layout_override_flag);

    SELF.flags := CHOOSEN (dedup (flags_all, ALL), READ_LIMIT);
  END;

  ds_pro := PROJECT (ds_best, GetFlagRecords (Left));
  ds_flags := NORMALIZE (ds_pro, Left.flags, TRANSFORM (fcra.Layout_override_flag, SELF := Right));

  RETURN ds_flags;
END;
