EXPORT Mac_Append_Feedback (
  pInputfile // Input File
  ,pDIDField
  ,pPhoneField
  ,pOutputFile // OUTPUT file with feedback DATASET
  ,mod_access
  ,dFeedback='Feedback' // Feedback DATASET name
  ) := MACRO
  //import cannot be inside macro when the macro is being called from within a transform
   
  // sequence input: designates [phone, DID] combination as unique
  #uniquename(input_layout_seq)
  #uniquename(pInputfile_seq)
  %input_layout_seq%:=RECORD
    RECORDOF(pInputfile);
    UNSIGNED seq_tmp;
  END;
  ut.MAC_Sequence_Records_NewRec(pInputfile,%input_layout_seq%,seq_tmp,%pInputfile_seq%);
    
  #uniquename(skip_set)
  %skip_set%:=['7','8'];

  // first, read feedbacks into the flat layout for the further rollup.
  #uniquename(base_feedback_rec)
  %base_feedback_rec% := PhonesFeedback_Services.Layouts.Layout_PhonesFeedback_base;

  #uniquename(feedback_flat)
  #uniquename(feedback_rec_flat)
  %feedback_rec_flat%:=RECORD
    %input_layout_seq%;
    %base_feedback_rec% %feedback_flat%; // using NAMED subrecord to avoid name collisions
    UNSIGNED4 global_sid;
    UNSIGNED8 record_sid;
  END;
    
  #uniquename(join_data);
  %feedback_rec_flat% %join_data% (%pInputfile_seq% l, PhonesFeedback.Key_PhonesFeedback_phone r):=TRANSFORM
    SELF:=l;
    SELF.%feedback_flat% := r;
    SELF.global_sid := r.global_sid;
    SELF.record_sid := r.record_sid;
  END;

  #uniquename(joinup_pre);
  %joinup_pre% := 
    JOIN(%pInputfile_seq%, PhonesFeedback.Key_PhonesFeedback_phone,
      (LEFT.pPhoneField <> '') AND
      KEYED (LEFT.pPhoneField = RIGHT.Phone_number) AND
      (UNSIGNED) LEFT.pDIDField= (UNSIGNED) RIGHT.did AND
      RIGHT.phone_contact_type NOT IN %skip_set%,
      %join_data%(LEFT,RIGHT),
    LEFT OUTER, LIMIT(0), KEEP(1000));

  #uniquename(joinup_flagged)
  %joinup_flagged% := Suppress.MAC_FlagSuppressedSource(%joinup_pre%, mod_access, pDIDField);

  #uniquename(joinup);
  %joinup% := PROJECT(%joinup_flagged%, TRANSFORM(%feedback_rec_flat%,
    SELF.%feedback_flat% := IF(~LEFT.is_suppressed, LEFT.%feedback_flat%);
    SELF := LEFT));

  // group and rollup to create a child feedback data
  #uniquename(feedback_data)
  #uniquename(tmp_rec_layout)
  %tmp_rec_layout%:=RECORD
    %input_layout_seq%;
    DATASET(%base_feedback_rec%) %feedback_data% := DATASET([],%base_feedback_rec%);
  END;

  #uniquename(grouped_recs);
  %grouped_recs% := GROUP(SORT(%joinup%, seq_tmp), seq_tmp);

  #uniquename(rolled_recs);
  #uniquename(SetFeedbackChild);
  %tmp_rec_layout% %SetFeedbackChild% (%feedback_rec_flat% L, DATASET (%feedback_rec_flat%) R) := TRANSFORM
    SELF.%feedback_data% := PROJECT (r (%feedback_flat%.phone_number != ''), TRANSFORM (%base_feedback_rec%, SELF := LEFT.%feedback_flat%));
    SELF := L;
  END;
  %rolled_recs% := ROLLUP (%grouped_recs%, GROUP, %SetFeedbackChild% (LEFT, ROWS (LEFT)));

  // call main function for each child datast; it must return a single feedback
  #uniquename(AppendFeedback)
  RECORDOF(pInputfile) %AppendFeedback%(%rolled_recs% l) := TRANSFORM
    SELF.dFeedback := PhonesFeedback_Services.Functions.GetReport(l.%feedback_data%);
    SELF := l;
  END;
    
  pOutputFile := PROJECT(%rolled_recs%,%AppendFeedback%(LEFT));
ENDMACRO;
