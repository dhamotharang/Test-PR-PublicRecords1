
IMPORT PhonesFeedback_Services, iesp, PhonesFeedback, STD;

EXPORT Functions := MODULE
  SHARED STRING35 contact_type_description(STRING type_code) := MAP(
    type_code = '1'=>'Right Party Contact',
    type_code = '2'=>'Relative Or Associate Contact',
    type_code = '3'=>'Wrong Party Claim',
    type_code = '4'=>'Phone Disconnected',
    type_code = '5'=>'No Contact Or Knowledge of Debtor',
    type_code = '7'=>'Alternate Phone entered',
    type_code = '8'=>'Other info entered',
    '');
  
   EXPORT STRING30 feedback_src_description(STRING feedback_src_code) := MAP(
    feedback_src_code = '1'=>'Person Search',
    feedback_src_code = '2'=>'Advanced Person/Deep Skip Search',
    feedback_src_code = '3'=>'Phones Plus',
    feedback_src_code = '4'=>'Phones Basic Lookup',
    feedback_src_code = '5'=>'Phones Reverse Lookup',
    '');
    
  SHARED valid_date(STRING DatetoCheck):= 
    IF(LENGTH(DatetoCheck)=8 AND
    ((INTEGER)(DatetoCheck[1..4]) >= 1900) AND
    ((INTEGER)(DatetoCheck[5..6]) BETWEEN 1 AND 12) AND
    ((INTEGER)(DatetoCheck[7..8]) BETWEEN 1 AND 31),DatetoCheck,'');
    
  // the only purpose is to get a date as YYYYMMDD (this actually better to be be done at a build time)
  SHARED PhonesFeedback_Services.Layouts.rec_fmt_layout add_std_date (PhonesFeedback_Services.Layouts.Layout_PhonesFeedback_base l):=TRANSFORM
      // sort of a hack: evaluate only yyyymmdd, ignoring everything else
      c2:=STD.STR.Find (l.date_time_added,':',1);
      s1:=TRIM (l.date_time_added[1..(c2-3)]);
      s2:=PhonesFeedback_Services.CleanDate(s1);

      SELF.fmt_date:=(INTEGER) valid_date(s2);
      SELF:=l;
  END;

  EXPORT fnSearchVal(DATASET(Layouts.Layout_PhonesFeedback_base) phone_recs_tmp) := FUNCTION

    phone_recs := PROJECT (phone_recs_tmp, add_std_date (LEFT));

    // takes the latest of all feedbacks, calculates when its phone number was confirmed the last time
    // "confirmed" means either 'Right Party Contact' or 'Relative Or Associate Contact'
    feedback_Report (DATASET(PhonesFeedback_Services.Layouts.rec_fmt_layout) phone_recs):=FUNCTION
      phone_recs_srt:= CHOOSEN (SORT (phone_recs, -fmt_date), 1); // the latest feedback

      iesp.phonesfeedback.t_LastFeedback final_xform (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=TRANSFORM
        SELF.ResultProvided := iesp.ECL2ESP.toDate (l.fmt_date);
        SELF.Result := contact_type_description (l.phone_contact_type);
        // latest date when this phone was confirmed:
        cdate := MAX (phone_recs ((phone_contact_type='1') OR (phone_contact_type='2')), fmt_date);
        SELF.ConfirmedContact := iesp.ECL2ESP.toDate (cdate);
      END;

      RETURN PROJECT (phone_recs_srt(fmt_date > 0), final_xform(LEFT));
    END;

    addl_Phone (DATASET(PhonesFeedback_Services.Layouts.rec_fmt_layout) phone_recs):=FUNCTION
      phone_recs_addl_ph:=DEDUP(SORT(phone_recs(phone_contact_type='7'),-fmt_date,-alt_phone),alt_phone);
      phone_recs_addl_info:=DEDUP(SORT(phone_recs(phone_contact_type='8'),-fmt_date,-other_info),other_info);
      PhonesFeedback.Mac_Parse_Phone(phone_recs_addl_info,other_info,did,phone_recs_addl_ph_2);
      phone_recs_addl_ph_1:=table(phone_recs_addl_ph(alt_phone<>''),{PhoneNumber:=alt_phone});
      addl_ph_tmp:=DEDUP(SORT(phone_recs_addl_ph_1+phone_recs_addl_ph_2,PhoneNumber),PhoneNumber);
      
      iesp.share.t_StringArrayItem xform(addl_ph_tmp le):=TRANSFORM
        SELF.value:=le.PhoneNumber;
      END;
      addl_ph:=PROJECT(addl_ph_tmp,xform(LEFT));
      
      RETURN addl_ph;
    END;
    
    addl_info (DATASET(PhonesFeedback_Services.Layouts.rec_fmt_layout) phone_recs):=FUNCTION
      phone_recs_addl_info:=DEDUP(SORT(phone_recs(phone_contact_type='8'),-fmt_date,-other_info),other_info);
      addl_info:= table(phone_recs_addl_info(other_info<>''),{other_info});
      
      iesp.share.t_StringArrayItem xform(addl_info le):=TRANSFORM
        SELF.Value:=le.other_info;
      END;
      other_info:=PROJECT(addl_info,xform(LEFT));
      RETURN other_info;
    END;

    feedback_summary (DATASET(PhonesFeedback_Services.Layouts.rec_fmt_layout) phone_recs):=FUNCTION
      ds_tmp:=DEDUP(SORT(phone_recs,loginid,-fmt_date),loginid);
      feedback_tmp:=table(ds_tmp,{phone_contact_type,FeedbackCount:=COUNT(GROUP)},phone_contact_type);
      iesp.phonesfeedback.t_FeedbackReport xform(feedback_tmp le):=TRANSFORM
        SELF.description:=contact_type_description(le.phone_contact_type);
        SELF.FeedbackCount:=le.FeedbackCount;
      END;
      feedback_summary:=PROJECT(feedback_tmp,xform(LEFT));
      RETURN feedback_summary;
    END;

    iesp.phonesfeedback.t_PhonesFeedbackReportResponse xform (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=TRANSFORM
      SELF.LastFeedback:= feedback_Report(phone_recs)[1];
      SELF.AdditionalPhones:=CHOOSEN(PROJECT(addl_Phone(phone_recs),iesp.share.t_StringArrayItem), iesp.Constants.PHFEEDBACK.MaxAdditionalPhones);
      SELF.OtherInfo:=CHOOSEN(PROJECT(addl_info(phone_recs),iesp.share.t_StringArrayItem), iesp.Constants.PHFEEDBACK.MaxOtherInfo);
      SELF.FeedbackReports:=CHOOSEN(feedback_summary(phone_recs), iesp.Constants.PHFEEDBACK.MaxFeedbacks);
      SELF._Header:=iesp.ECL2ESP.GetHeaderRow();
    END;
    
    final_Rpt:=PROJECT(phone_recs,xform(LEFT));
    RETURN final_Rpt;
  END;



  // to be used for embedded PhonesFeedback section (person search, reports, etc.)
  // returns no more than one record (per phone+DID)
  EXPORT GetReport (DATASET(Layouts.Layout_PhonesFeedback_base) phone_recs_tmp):= FUNCTION

    phone_recs := PROJECT (phone_recs_tmp, add_std_date (LEFT));

    // keep only latest feedbacks from each user (customerid + loginid)
    // TODO: time may be important: two feedbacks with different contact_type at the same date
    phone_dedup:=DEDUP(SORT(phone_recs, did, phone_number, customerid, loginid, -fmt_date, phone_contact_type),
                            did, phone_number, customerid, loginid);

    // take the latest of all (per phone+DID)
    phone_unique := DEDUP (SORT (phone_dedup, did, phone_number, -fmt_date), did, phone_number);
    
    // per spec: take latest feedback and count how many "same" feedbacks among latest per user
    PhonesFeedback_Services.Layouts.feedback_report x_rpt1 (PhonesFeedback_Services.Layouts.rec_fmt_layout l):=TRANSFORM
      SELF.Last_Feedback_Result_Provided:=l.fmt_date;
      SELF.Last_Feedback_Result:=contact_type_description(l.phone_contact_type);
      SELF.feedback_count := COUNT (phone_dedup (did = l.did, phone_number = l.phone_number,
                                    phone_contact_type = l.phone_contact_type));
    END;

    result := PROJECT (phone_unique, x_rpt1 (LEFT));
    RETURN result;
  END;
END;
