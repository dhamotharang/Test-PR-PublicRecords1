IMPORT $, CriminalRecords_BatchService, Autokey_batch, Doxie, FFD, FCRA, iesp;

EXPORT PossibleIncarcerationReport_Records($.IParam.incarceration_report in_params, BOOLEAN isFCRA = FALSE) := FUNCTION

  ds_did_in := DATASET([{in_params.did}], doxie.layout_references);
  ds_in := PROJECT(ds_did_in, TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster, SELF.acctno := '1', SELF.did := LEFT.did, SELF := []));

  config_data := MODULE(PROJECT(in_params, CriminalRecords_BatchService.IParam.batch_params, OPT))
    EXPORT ReturnDocName := in_params.ReturnDocName;
    EXPORT ReturnSSN := in_params.ReturnSSN;
  END;

  // FCRA FFD
  dids := PROJECT(ds_in(did <> 0), FFD.Layouts.DidBatch);
  data_groups := FFD.Constants.DataGroupSet.Criminal_Incarceration;
  pc_recs := IF(isFCRA, FFD.FetchPersonContext(dids, in_params.gateways, data_groups, in_params.FFDOptionsMask));
  slim_pc_recs := FFD.SlimPersonContext(pc_recs);
  alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];

  // FCRA Overrides
  ds_best  := PROJECT(ds_in(did <> 0), TRANSFORM(doxie.layout_best, SELF.did := LEFT.did, SELF:=[]));
  ds_flags := IF(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));

  records_incr := CriminalRecords_BatchService.get_incarceration_records(ds_in, config_data, ds_flags, slim_pc_recs, isFCRA);

  show_consumer_stmts := isFCRA AND FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
  has_alert_suppression := isFCRA AND alert_flags.suppress_records;
  has_consumer_data := ~has_alert_suppression AND EXISTS(records_incr);

  layout_incr := CriminalRecords_BatchService.Layouts.batch_pii_out_pre;
  layout_iesp_record := iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationRecord;
  
  layout_iesp_record incr_xform(layout_incr l) := TRANSFORM
    espDate(string8 dt) := iesp.ECL2ESP.toDatestring8(dt);
    inmate_name := iesp.ECL2ESP.SetName(l.incr_fname, '', l.incr_lname, '', '');
    inmate_ssn := l.incr_ssn;
    SELF.IncarcerationFlag := l.incarceration_flag;
    SELF.IncrStateOrigin := l.incr_state_origin;
    SELF.IncrDOCNumber := l.incr_doc_num;
    SELF.InmateDOB := espDate(l.incr_dob);
    SELF.EventDate := espDate(l.event_dt);
    SELF.PunishmentType := l.punishment_type;
    SELF.SentenceLength := l.sent_length;
    SELF.SentenceLengthDesc := l.sent_length_desc;
    SELF.InmateCurrentStatus := l.cur_stat_inm;
    SELF.InmateCurrentStatusDesc := l.cur_stat_inm_desc;
    SELF.InmateLocation := l.cur_loc_inm;
    SELF.CurrentSecurityClassDate := espDate(l.cur_sec_class_dt);
    SELF.CurrentSecurityClass := l.cur_loc_sec;
    SELF.GainTimeAmount := l.gain_time;
    SELF.GainTimeEffectiveDate := espDate(l.gain_time_eff_dt);
    SELF.LatestAdmitDate := espDate(l.latest_adm_dt);
    SELF.ScheduledReleaseDate := espDate(l.sch_rel_dt);
    SELF.ActualReleaseDate := espDate(l.act_rel_dt);
    SELF.ControlReleaseDate := espDate(l.ctl_rel_dt);
    SELF.PresumptiveParoleReleaseDate := espDate(l.presump_par_rel_dt);
    SELF.InmateSSNs := ROW({inmate_ssn}, iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationInmateSSN);
    SELF.InmateNames := ROW(inmate_name, iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationInmateName);
    SELF.LexId := (UNSIGNED) l.incr_did;
    SELF.isDisputed := l.isDisputed;
    SELF.OffenderKey := l.offender_key;
    SELF.StatementIds := l.StatementIds;
    SELF := [];
  END;

  records_temp := SORT(PROJECT(records_incr, incr_xform(LEFT)), OffenderKey, -LatestAdmitDate, -EventDate);

  layout_iesp_record rollup_incr_xform(layout_iesp_record l, layout_iesp_record r) := TRANSFORM
    inmate_ssns := l.InmateSSNs + r.InmateSSNs;
    SELF.InmateNames := l.InmateNames + r.InmateNames;
    SELF.InmateSSNs := DEDUP(SORT(inmate_ssns, RECORD), RECORD);
    SELF := l;
  END;

  records := ROLLUP(records_temp, LEFT.OffenderKey = RIGHT.OffenderKey, rollup_incr_xform(LEFT, RIGHT));
  consumer_stmts_all := FFD.prepareConsumerStatements(pc_recs);
  consumer_stmts := consumer_stmts_all(has_consumer_data OR StatementType IN FFD.Constants.RecordType.StatementConsumerLevel);
  consumer_alerts := FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_flags, in_params.FFDOptionsMask);
  input_consumer := FFD.MAC.PrepareConsumerRecord(in_params.did, TRUE);

  iesp.criminal_possibleincarceration_fcra.t_FcraPossibleIncarcerationReportResponse iesp_xform() := TRANSFORM
    SELF._Header            := iesp.ECL2ESP.GetHeaderRow();
    SELF.Records            := IF(~has_alert_suppression, records, $.Constants.BlankIncarcerationRecord);
    SELF.ConsumerStatements := IF(show_consumer_stmts, consumer_stmts, FFD.Constants.BlankConsumerStatements);
    SELF.ConsumerAlerts     := IF(isFCRA, consumer_alerts, FFD.Constants.BlankConsumerAlerts);
    SELF.Consumer           := input_consumer;
  END;

  results := DATASET([iesp_xform()]);

  RETURN results;

END;
