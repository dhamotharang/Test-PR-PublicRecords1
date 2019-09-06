IMPORT $, BatchServices, Suppress;

EXPORT Records(DATASET(BatchServices.OptOut.Layouts.Input_Ex) recs_in, 
              BatchServices.OptOut.IParams.BatchParams params) := FUNCTION

  optout_key := Suppress.Key_OptOutSrc();
  
  BatchServices.OptOut.Layouts.Output_Layout applyOptOut(
                                  BatchServices.OptOut.Layouts.Input_Ex r_in, 
                                  optout_key r_opt) := TRANSFORM

    is_match := r_opt.lexid <> 0;
    is_test := Suppress.optout_exemption.is_test(r_opt.exemptions);
    glb_exempt := (r_opt.exemptions & Suppress.optout_exemption.bit_glb(params.glb)) <> 0;
    dppa_exempt := (r_opt.exemptions & Suppress.optout_exemption.bit_dppa(params.dppa)) <> 0;
    is_exempt := glb_exempt OR dppa_exempt;

    // input data passthrough
    self.acctno := r_in.orig_acctno;
    self.lexid := r_in.srch_did;
    self.input_echo := r_in;

    // opt out data
    self.global_sids := r_opt.global_sids;
    self.exemptions := r_opt.exemptions;
    self.act_id := r_opt.act_id;
    self.date_added := r_opt.date_added;

    // opt out flags
    self.optout_flag := IF(is_match, ~is_exempt, FALSE);
    self.test_flag := IF(is_match, is_test, FALSE);

    // echo any batch errors
    self.err_addr := r_in.err_addr;
    self.err_search := r_in.err_search;
    self.error_code := r_in.error_code;
  END;

  recs_out := JOIN(recs_in, optout_key, 
    left.srch_did = right.lexid AND 
    (params.AllowTestSuppression OR ~(Suppress.optout_exemption.is_test(right.exemptions))), 
    applyOptOut(left, right), 
    LEFT OUTER, 
    KEEP(1), LIMIT(0));

  //output(optout_key, named('optout_key'));

  RETURN recs_out;

END;
