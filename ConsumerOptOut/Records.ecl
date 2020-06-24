IMPORT Doxie, iesp, Suppress;

EXPORT Records(iesp.consumeroptout.t_ConsumerOptoutReportRequest rec_in,
  Doxie.IDataAccess mod_access) := FUNCTION

  optout_key := Suppress.Key_OptOutSrc();

  iesp.consumeroptout.t_ConsumerOptoutReportResult applyOptOut(
    iesp.consumeroptout.t_ConsumerOptoutReportRequest L, optout_key R) := TRANSFORM

    is_match := R.lexid <> 0;

    // check exemptions
    glb_exempt := (R.exemptions & Suppress.optout_exemption.bit_glb(mod_access.glb)) <> 0;
    dppa_exempt := (R.exemptions & Suppress.optout_exemption.bit_dppa(mod_access.dppa)) <> 0;
    is_exempt := glb_exempt OR dppa_exempt;

    // input echo
    self.inputecho := L.ReportBy;

    // opt out data
    self.lexid := L.ReportBy.LexId;
    self.exemptions := (string)R.exemptions;
    self.ActID := R.act_id;
    self.DateAdded := iesp.ECL2ESP.toDatestring8(R.date_added);

    // Determine which global_sids are in both the input and the key.
    input_gsids := L.ReportBy.GlobalSIDs;
    key_gsids := DATASET(R.global_sids, {unsigned4 value});
    output_gsids := JOIN(input_gsids, key_gsids,
      (unsigned4)LEFT.value = RIGHT.value, TRANSFORM(LEFT));

    self.GlobalSids := output_gsids;

    // opt out flag
    self.OptOutFlag := is_match AND ~is_exempt AND
      (NOT EXISTS(input_gsids) OR EXISTS(output_gsids));

  END;

  key_rec := optout_key(KEYED(lexid = (unsigned6)rec_in.ReportBy.LexId))[1];
  rec_out := ROW(applyOptOut(rec_in, key_rec));

  RETURN rec_out;

END;
