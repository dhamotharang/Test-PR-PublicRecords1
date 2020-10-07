import progressive_phone,iesp,MDR,Royalty;
export transform_progressive_phones(dataset(progressive_phone.layout_progressive_online_out) ppi,
 BOOLEAN ShowPhoneScore = FALSE, STRING scoreModel='', BOOLEAN UsePremiumSource_A=false) := function

//get the running version of waterfall phones / Contact plus
version := progressive_phone.HelperFunctions.FN_GetVersion(scoreModel, UsePremiumSource_A);
versionName := progressive_phone.HelperFunctions.FN_GetVersionName(version);
PPC := progressive_phone.Constants;

iesp.ContactPlus.t_ContactPlusProgPhoneRecord outrec(progressive_phone.layout_progressive_online_out L) := transform
      self.PhoneType := L.subj_phone_type;
      self.UniqueId := intformat(L.did,12,1);
      self.Name := row(L,transform(iesp.share.t_name,self.full := '',
                            self.First := left.subj_first,
                            self.Middle := left.subj_middle,
                            self.Last := left.subj_last,
                            self.suffix := left.subj_suffix,
                            self.prefix := ''));

      self.ListedName := L.subj_name_dual;
      self.Phone10 := L.subj_phone10;
      self.TimeZone := L.timeZone;
      self.CarrierName := L.Meta_Carrier_Name;
      self.CarrierCity := L.Meta_Carrier_City;
      self.CarrierState := L.Meta_Carrier_State;
      self.SubjPhonePossibleRelationship := L.subj_phone_relationship;
      self.SubjPhonePossibleTimezone := L.subj_phone_possible_timezone;
      self.SubjPhoneAddressZipcodeTimezone := L.subj_phone_address_zipcode_timezone;
      self.SubjTimezoneMatchFlag := L.subj_timezone_match_flag;
      self.SubjPhonePortedDate := L.subj_phone_ported_date;
      self.SubjPhoneSeenFreq := L.subj_phone_seen_freq;
      self.SubjPhoneAge := L.subj_phone_age;
      self.SubjPhoneTransientFlag := L.subj_phone_transient_flag;
      self.NewType:= if(L.subj_phone_type_new IN PPC.Premium_Source_Set,PPC.premium,L.subj_phone_type_new);
      self.DateFirstSeen := iesp.ECL2ESP.toDateYM((unsigned3)L.subj_date_first);
      self.DateLastSeen := iesp.ECL2ESP.toDateYM((unsigned3)L.subj_date_last);
      self.PhoneFeedback := row(L.feedback[1],transform(iesp.phonesfeedback.t_PhonesFeedback,
                              self.FeedbackCount := left.feedback_count,
                              self.LastFeedbackResult := left.Last_Feedback_Result,
                              self.LastFeedbackResultProvided := (string8)left.Last_Feedback_Result_Provided));
      self.Address.StreetNumber := L.prim_range;
      self.Address.StreetPreDirection	:= L.predir;
      self.Address.StreetName	:= L.prim_name;
      self.Address.StreetSuffix := L.addr_suffix;
      self.Address.StreetPostDirection := L.postdir;
      self.Address.UnitDesignation := L.unit_desig;
      self.Address.UnitNumber	:= L.sec_range;
      self.Address.City := L.p_city_name;
      self.Address.State := L.st;
      self.Address.Zip5 := L.zip5;
      self.NewPhoneType := L.Meta_ServLine_Type;

      self.Source := map(L.subj_phone_type_new IN PPC.Premium_Source_Set      => L.subj_phone_type_new,
                         L.vendor in Royalty.Constants.LastResortRoyalty      => MDR.sourceTools.src_wired_Assets_Royalty,
                         '');  //for internal purposes

      self.ServiceVersion := versionName; //for internal purposes

      self.PhoneScore := IF(ShowPhoneScore, L.phone_score, '');

      self := [];
end;
rslt := project(ppi,outrec(left));
return rslt;
end;
