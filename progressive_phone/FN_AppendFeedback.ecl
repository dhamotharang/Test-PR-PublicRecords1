IMPORT AutoStandardI, doxie, PhonesFeedback, suppress, STD, ut;

EXPORT FN_AppendFeedback(DATASET(Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec) wf_recs_in) := FUNCTION
mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
  fbk := PhonesFeedback.Key_PhonesFeedback_phone;
rec_with_seq:=record
unsigned seq:=0;
Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec;
end;
wf_recs_tmp:=project(wf_recs_in,rec_with_seq);
ut.MAC_Sequence_Records(wf_recs_tmp, seq, wf_recs);
  TmpRec := RECORD(Progressive_Phone.Layout_Progressive_phones.common_with_meta_rec)
    unsigned seq;
    UNSIGNED1	phone_contact_type;
    UNSIGNED4	date_added;
    STRING20	fname;
    STRING20	mname;
    STRING20	lname;
    UNSIGNED4	last_connected_date;
    UNSIGNED1	method;
    unsigned4 global_sid;
    unsigned8 record_sid;
  END;

  BOOLEAN cmpName(STRING lf, STRING lm, STRING ll, STRING rf, STRING rm, STRING rl) := FUNCTION
    STRING lf_t := TRIM(lf);
    STRING lm_t := TRIM(lm);
    STRING ll_t := TRIM(ll);
    STRING rf_t := TRIM(rf);
    STRING rm_t := TRIM(rm);
    STRING rl_t := TRIM(rl);
    BOOLEAN skipM := LENGTH(lm_t) = 0;
    BOOLEAN fl_match := ll_t = rl_t AND lf_t = rf_t;

    RETURN IF(skipM, fl_match, fl_match AND lm_t = rm_t);
  END;

  TmpRec toTmpRec(wf_recs l, fbk r) := TRANSFORM
    UNSIGNED1 method := MAP(l.did = r.did => 1,
                            cmpName(l.subj_first, l.subj_middle, l.subj_last, r.fname, r.mname, r.lname) => 2,
                            0);
    UNSIGNED1 phone_contact_type := (UNSIGNED1) TRIM(r.phone_contact_type);
    UNSIGNED timeStamp := STD.Date.FromStringToDate(r.date_time_added , '%b %d %Y');

    SELF.phone_contact_type := IF(phone_contact_type BETWEEN 1 AND 4, phone_contact_type, 99);
    SELF.date_added := timeStamp;
    SELF.fname := r.fname;
    SELF.mname := r.mname;
    SELF.lname := r.lname;
    SELF.last_connected_date := IF(phone_contact_type = 1, timeStamp, 0);
    SELF.method := method;
    SELF := l;
    SELF := [];
  END;

  TmpRec updtRPC(TmpRec l, TmpRec r) := TRANSFORM
    SELF.last_connected_date := IF(r.phone_contact_type = 1, r.date_added, l.last_connected_date);
    SELF := r;
  END;

  dateToStr(UNSIGNED4 date) := IF(date <> 0, INTFORMAT(date, 8, 0), '');

  progressive_phone.layout_progressive_batch_out_with_fb toOutWithFB(TmpRec input) := TRANSFORM
    SELF.phone_feedback_date_1 := dateToStr(input.date_added);
    SELF.phone_feedback_result_1 := input.phone_contact_type ;
    SELF.phone_feedback_first_1 := input.fname;
    SELF.phone_feedback_middle_1 := input.mname;
    SELF.phone_feedback_last_1 := input.lname;
    SELF.phone_feedback_last_rpc_date_1 := dateToStr(input.last_connected_date);
    SELF := input;
  END;


  matches := JOIN(wf_recs, fbk,
                  KEYED(RIGHT.phone_number = LEFT.subj_phone10) AND
                  (LEFT.DID = RIGHT.DID OR
                   cmpName(LEFT.subj_first, LEFT.subj_middle, LEFT.subj_last, RIGHT.fname, RIGHT.mname, RIGHT.lname)),
                  toTmpRec(LEFT, RIGHT),
                  LEFT OUTER, LIMIT(10000, SKIP));
  matches_flagged := suppress.MAC_FlagSuppressedSource(matches,mod_access);
  matches_suppressed := project(matches_flagged,transform(recordof(matches_flagged),
                                  SELF.phone_contact_type := IF(~left.is_suppressed,left.phone_contact_type,0),
                                  SELF.date_added :=  IF(~left.is_suppressed,left.date_added,0),
                                  SELF.fname := IF(~left.is_suppressed,left.fname,''),
                                  SELF.mname :=  IF(~left.is_suppressed,left.mname,''),
                                  SELF.lname :=  IF(~left.is_suppressed,left.lname,''),
                                  SELF.last_connected_date := IF(~left.is_suppressed, left.last_connected_date, 0),
                                  SELF.method := IF(~left.is_suppressed,left.method,0),
                                  SELF := left));
  matches_sorted := SORT(project(matches_suppressed,tmprec), acctno, subj_phone10, date_added, method);
  m := ROLLUP(matches_sorted, updtRPC(LEFT, RIGHT), acctno, subj_phone10);
  o := PROJECT(sort(m,seq), toOutWithFB(LEFT));
  RETURN o;
END;
