IMPORT PhonesFeedback_Services, PhonesFeedback, STD;

EXPORT ReportFunctions (DATASET(PhonesFeedback_Services.Layouts.Layout_PhonesFeedback_base) phone_recs_tmp) := FUNCTION
    
  EXPORT STRING30 contact_type_description(STRING type_code) := MAP(
    type_code = '1'=>'Right Party Contact',
    type_code = '2'=>'Relative Or Associate Contact',
    type_code = '3'=>'Wrong Party Claim',
    type_code = '4'=>'Phone Disconnected',
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
        
  EXPORT valid_date(STRING DatetoCheck):= 
    IF(LENGTH(DatetoCheck)>8 AND
    ((INTEGER)(DatetoCheck[1..4]) >= 1900) AND
    ((INTEGER)(DatetoCheck[5..6]) BETWEEN 1 AND 12) AND
    ((INTEGER)(DatetoCheck[7..8]) BETWEEN 1 AND 31),DatetoCheck,'');
    
  r1 := RECORD
    RECORDOF (phone_recs_tmp);
    INTEGER fmt_date;
  END;

  r1 xform_dt(phone_recs_tmp le):=TRANSFORM
    SELF.fmt_date:=(UNSIGNED) PhonesFeedback_Services.CleanDate(le.date_time_added);
    SELF:=le;
  END;
  phone_recs_dt:=PROJECT(phone_recs_tmp,xform_dt(LEFT));
    
  PhonesFeedback_Services.Layouts.rec_fmt_layout add_std_date(phone_recs_tmp l):=TRANSFORM
    tmp:=l.date_time_added;
    c2:=STD.STR.Find(tmp,':',1);
    s1:=tmp[1..(c2-3)];
    htmp:=INTFORMAT((INTEGER) tmp[(c2-2)..(c2-1)],2,1);
    mtmp:=INTFORMAT((INTEGER) tmp[(c2+1)..(c2+2)],2,1);
    amtmTmp:=tmp[(LENGTH(tmp)-1)..LENGTH(tmp)];
    htmp24:=INTFORMAT(IF(amtmTmp='AM',(INTEGER) htmp,((INTEGER) htmp)+12),2,1);
    s2:=PhonesFeedback_Services.CleanDate(s1);

    SELF.fmt_date:=(INTEGER) valid_date((s2+(STRING) htmp24+(STRING) mtmp));
    SELF:=l;
  END;
  
  phone_recs := PROJECT(phone_recs_tmp, add_std_date(LEFT));
  
  phone_recs_dedup:=DEDUP(SORT(phone_recs,-fmt_date,customerid,loginid,did,phone_contact_type),customerid,loginid,did,phone_contact_type);
  rpt_layout:=RECORD
    PhonesFeedback_Services.Layouts.feedback_report;
    STRING loginid;
  END;

  phone_recs_srt := SORT(phone_recs, -fmt_date);

  rpt_layout x_rpt1 (phone_recs l):=TRANSFORM
    SELF.Last_Feedback_Result_Provided:=l.fmt_date;
    SELF.Last_Feedback_Result:=contact_type_description(l.phone_contact_type);
    SELF.loginid:=l.loginid;
    SELF:=[];
  END;
  results_all := DEDUP(SORT(PROJECT(phone_recs_srt, x_rpt1(LEFT)),
      -Last_Feedback_Result_Provided,Last_Feedback_Result,loginid),
    Last_Feedback_Result,Last_Feedback_Result,loginid);

  results_with_feedback := results_all(Last_Feedback_Result<>'');
  results_table := TABLE(results_with_feedback, {Last_Feedback_Result, fbcnt:=COUNT(GROUP)}, Last_Feedback_Result);
                
  PhonesFeedback_Services.Layouts.feedback_report xform(results_with_feedback l, results_table r) :=TRANSFORM
    SELF.Last_Feedback_Result_Provided := (UNSIGNED) l.Last_Feedback_Result_Provided[1..8];
    SELF.feedback_count := r.fbcnt;
    SELF.Last_Feedback_Result := l.Last_Feedback_Result;
  END;
  result_rpt_all:=JOIN(results_with_feedback, results_table,
    LEFT.Last_Feedback_Result = RIGHT.Last_Feedback_Result,
    xform(LEFT,RIGHT));
  
  RETURN result_rpt_all;
    
END;
