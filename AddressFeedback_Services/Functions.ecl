import AddressFeedback, iesp;

EXPORT Functions := module
  
  export string40 getFeedbackTypeDescription(unsigned1 pTypeCode) := map(
    pTypeCode = Constants.FEEDBACK_TYPE.RIGHT_PARTY_CONTACT => 'Correct Address',
    pTypeCode = Constants.FEEDBACK_TYPE.RELATIVE_ASSOCIATE_CONTACT => 'Relative Or Associate Contact',
    pTypeCode = Constants.FEEDBACK_TYPE.WRONG_PARTY_CLAIM => 'Wrong Address Claim',
    pTypeCode = Constants.FEEDBACK_TYPE.NO_CONTACT => 'No Contact Or Knowledge of Debtor',
    pTypeCode = Constants.FEEDBACK_TYPE.OTHER_INFO_ENTERED => 'Other info entered',
    '');

  // Takes the latest of all feedbacks and calculates when it was last confirmed.
  // "confirmed" means either 'Right Party Contact' or 'Relative Or Associate Contact'
  shared getLastFeedback (dataset(Layouts.feedback_common) pRecs) := function
  
    dRecsSorted := choosen(sort(pRecs,-date_time_added), 1); // the latest feedback
    sConfirmed := [Constants.FEEDBACK_TYPE.RIGHT_PARTY_CONTACT, Constants.FEEDBACK_TYPE.RELATIVE_ASSOCIATE_CONTACT];
    
    iesp.addressfeedback.t_LastAddressFeedback tLastXForm (Layouts.feedback_common l):=transform
      self.ResultProvided := iesp.ECL2ESP.toDate (l.date_time_added);
      self.Result := getFeedbackTypeDescription(l.address_contact_type);
      // latest date when this address was confirmed
      self.ConfirmedContact := iesp.ECL2ESP.toDate (max(pRecs(address_contact_type in sConfirmed), date_time_added));
    end;
    
    return project (dRecsSorted(date_time_added > 0), tLastXForm(LEFT));
    
  end;

  shared getOtherInfo (dataset(Layouts.feedback_common) pRecs) := function
  
    dRecsInfo := dedup(sort(pRecs(address_contact_type=Constants.FEEDBACK_TYPE.OTHER_INFO_ENTERED),
                          -date_time_added,-other_info), other_info);
    dOtherInfo := project(dRecsInfo(other_info<>''), transform(iesp.share.t_StringArrayItem, self.Value := left.other_info));
    return dOtherInfo;
    
  end;

  shared getSummary (dataset(Layouts.feedback_common) pRecs) := function
    
    dFeedbackTmp := table( dedup(sort(pRecs,loginid,-date_time_added),loginid), {address_contact_type,FeedbackCount:=COUNT(GROUP)}, address_contact_type);

    iesp.addressfeedback.t_AddrFeedbackReport xform(dFeedbackTmp l):=transform
      self.Description := getFeedbackTypeDescription(l.address_contact_type);
      self.FeedbackCount := l.FeedbackCount;
    end;

    dFeedbackSummary := project(dFeedbackTmp, xform(left));
    return dFeedbackSummary;
    
  end;
  
  export formatReport(dataset(Layouts.feedback_common) pRecs) := function

    dLastFeedback := getLastFeedback(pRecs);
    dOtherInfo := getOtherInfo(pRecs);
    dSummary := getSummary(pRecs);

    iesp.addressfeedback.t_AddressFeedbackReportResponse xform (Layouts.feedback_common l):=transform
      self._Header:=iesp.ECL2ESP.GetHeaderRow();
      self.LastFeedback := dLastFeedback[1];
      self.OtherInfo := choosen(project(dOtherInfo,iesp.share.t_StringArrayItem), iesp.Constants.ADDRFEEDBACK.MaxOtherInfo);
      self.FeedbackReports := choosen(dSummary, iesp.Constants.ADDRFEEDBACK.MaxFeedbacks);
    end;
    
    dRecsOut := dedup(sort(project(pRecs, xform(left)), record), record);
    return dRecsOut;
    
  end;
  
end;
