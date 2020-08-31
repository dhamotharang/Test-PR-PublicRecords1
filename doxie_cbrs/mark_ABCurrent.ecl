IMPORT did_add,doxie,doxie_cbrs,ut;
doxie_cbrs.mac_Selection_Declare()
EXPORT mark_ABCurrent(DATASET(doxie_cbrs.layout_best_records_prs) inf,
                      DATASET(doxie_cbrs.layout_references) bdids,
                      doxie.IDataAccess mod_access) :=
FUNCTION

rlr := table(doxie_cbrs.reverse_lookup_records(bdids,mod_access,Include_ReversePhone_val), {phone10, listed_name});


inf tra(inf le, rlr ri) := TRANSFORM
  SELF.isCurrent := (INTEGER)ri.phone10 > 0;
  SELF := le;
END;

wcur := JOIN(inf, rlr,
  (INTEGER)LEFT.phone > 0 AND
  (INTEGER)LEFT.phone = (INTEGER)RIGHT.phone10 AND
  ut.CompanySimilar100(datalib.companyclean(LEFT.company_name),datalib.companyclean(RIGHT.listed_name)) < 40/* AND
  DID_Add.Address_Match_Score
    (LEFT.prim_range, LEFT.prim_name, LEFT.sec_range, (STRING)LEFT.zip,
      RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range, (STRING)RIGHT.z5) < 255*/,
  tra(LEFT, RIGHT), LEFT OUTER, KEEP(1));

RETURN wcur;

END;
