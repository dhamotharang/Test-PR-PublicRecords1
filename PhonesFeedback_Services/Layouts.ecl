IMPORT PhonesFeedback;

EXPORT Layouts := MODULE

  EXPORT Layout_PhonesFeedback_base := PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base;
  EXPORT feedback_report :=RECORD //same as iesp/phonesfeedback/t_PhonesFeedback
    INTEGER feedback_count;
    STRING Last_Feedback_Result;
    INTEGER Last_Feedback_Result_Provided;
  END;
  EXPORT rec_in_request:=RECORD
    STRING Phone_Number;
    STRING in_DID;
  END;
  EXPORT rec_fmt_layout:=RECORD
    Layout_PhonesFeedback_base;
    INTEGER fmt_date;
  END;
  
END;
