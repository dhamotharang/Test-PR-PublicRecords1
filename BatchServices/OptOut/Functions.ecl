IMPORT $, AutoKeyI, BatchServices, didville;

EXPORT Functions := MODULE

  SHARED GetDids(DATASET(BatchServices.OptOut.Layouts.Input_Processed) recs_in, 
                BatchServices.OptOut.IParams.BatchParams params) := FUNCTION

    $.Layouts.batch_in_didvile_rec to_didville(BatchServices.OptOut.Layouts.Input_Processed l) := TRANSFORM
      self.did := 0;
      self.seq := (unsigned)l.acctno;
      self.phone10 := l.phone;
      self.p_city_name := l.city_name;
      self.z5 := l.zip;
      self := l;
      self := [];
    END;

    drecs := project(recs_in, to_didville(left));
    DidVille.MAC_DidAppend(drecs, recs_append, true, ''); 

    recs_out := join(recs_in, recs_append, 
      left.acctno = (string)right.seq AND
      right.score >= params.Score_Threshold, 
      TRANSFORM(BatchServices.OptOut.Layouts.Input_Ex, 
        self.srch_did := right.did, 
        self.error_code := if(right.did <> 0, left.error_code, AutoKeyI.errorcodes._codes.INSUFFICIENT_INPUT), 
        self := left), 
      LEFT OUTER, 
      KEEP(1), LIMIT(0));

    RETURN recs_out;

  END;

  EXPORT CheckInputRecs(DATASET(BatchServices.OptOut.Layouts.Input_Processed) recs_in, 
                BatchServices.OptOut.IParams.BatchParams params) := FUNCTION

    // if an input did/lexid is provided, it will be used and pii will be ignored
    passthru_recs := recs_in(did <> 0);
    pii_recs := recs_in(did = 0);

    // otherwise use pii to determine the lexid for the recs that don't specify one
    append_recs := GetDids(pii_recs, params);

    passthru_out := PROJECT(passthru_recs, 
                      TRANSFORM(BatchServices.OptOut.Layouts.Input_Ex, 
                        self.srch_did := left.did, 
                        self := left));

    RETURN passthru_out + append_recs;

  END;

END;