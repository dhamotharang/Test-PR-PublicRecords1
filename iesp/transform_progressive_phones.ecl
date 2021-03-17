IMPORT progressive_phone, iesp, MDR, Royalty;
EXPORT transform_progressive_phones(DATASET(progressive_phone.layout_progressive_online_out) ppi,
         BOOLEAN ShowPhoneScore = FALSE, STRING scoreModel = '', BOOLEAN UsePremiumSource_A = FALSE) := FUNCTION

  // get the running version of waterfall phones / Contact plus
  // scoreModel COMMON_SCORE (or deprecated PHONESCORE_V2 or COLLECTIONSCORE_V3) will trigger call to Phone_Shell
  version := progressive_phone.HelperFunctions.FN_GetVersion(scoreModel, UsePremiumSource_A);
  versionName := progressive_phone.HelperFunctions.FN_GetVersionName(version);

  iesp.ContactPlus.t_ContactPlusProgPhoneRecord outrec(progressive_phone.layout_progressive_online_out L) := TRANSFORM
    SELF.PhoneType := L.subj_phone_type;
    SELF.UniqueId := INTFORMAT(L.did,12,1);
    SELF.Name := ROW(L, TRANSFORM(iesp.share.t_name, 
                            SELF.Full   := '',
                            SELF.First  := LEFT.subj_first,
                            SELF.Middle := LEFT.subj_middle,
                            SELF.Last   := LEFT.subj_last,
                            SELF.suffix := LEFT.subj_suffix,
                            SELF.prefix := ''));

    SELF.ListedName := L.subj_name_dual;
    SELF.Phone10  := L.subj_phone10;
    SELF.TimeZone := L.timeZone;
    SELF.CarrierName  := L.Meta_Carrier_Name;
    SELF.CarrierCity  := L.Meta_Carrier_City;
    SELF.CarrierState := L.Meta_Carrier_State;
    SELF.SubjPhonePossibleRelationship   := L.subj_phone_relationship;
    SELF.SubjPhonePossibleTimezone       := L.subj_phone_possible_timezone;
    SELF.SubjPhoneAddressZipcodeTimezone := L.subj_phone_address_zipcode_timezone;
    SELF.SubjTimezoneMatchFlag := L.subj_timezone_match_flag;
    SELF.SubjPhonePortedDate   := L.subj_phone_ported_date;
    SELF.SubjPhoneSeenFreq     := L.subj_phone_seen_freq;
    SELF.SubjPhoneAge := L.subj_phone_age;
    SELF.SubjPhoneTransientFlag := L.subj_phone_transient_flag;
    SELF.NewType:= IF(L.subj_phone_type_new IN progressive_phone.Constants.Premium_Source_Set, progressive_phone.Constants.premium, L.subj_phone_type_new);
    SELF.DateFirstSeen := iesp.ECL2ESP.toDateYM((UNSIGNED3)L.subj_date_first);
    SELF.DateLastSeen  := iesp.ECL2ESP.toDateYM((UNSIGNED3)L.subj_date_last);
    SELF.PhoneFeedback := ROW(L.feedback[1], TRANSFORM(iesp.phonesfeedback.t_PhonesFeedback,
                                               SELF.FeedbackCount := LEFT.feedback_count,
                                               SELF.LastFeedbackResult := LEFT.Last_Feedback_Result,
                                               SELF.LastFeedbackResultProvided := (STRING8)LEFT.Last_Feedback_Result_Provided));
    SELF.Address.StreetNumber        := L.prim_range;
    SELF.Address.StreetPreDirection	 := L.predir;
    SELF.Address.StreetName	         := L.prim_name;
    SELF.Address.StreetSuffix        := L.addr_suffix;
    SELF.Address.StreetPostDirection := L.postdir;
    SELF.Address.UnitDesignation     := L.unit_desig;
    SELF.Address.UnitNumber	         := L.sec_range;
    SELF.Address.City  := L.p_city_name;
    SELF.Address.State := L.st;
    SELF.Address.Zip5  := L.zip5;
    SELF.NewPhoneType  := L.Meta_ServLine_Type;

    SELF.Source := MAP(L.subj_phone_type_new IN progressive_phone.Constants.Premium_Source_Set => L.subj_phone_type_new,
                       L.vendor IN Royalty.Constants.LastResortRoyalty => MDR.sourceTools.src_wired_Assets_Royalty,
                                                                          '');  //for internal purposes

    SELF.ServiceVersion := versionName; //for internal purposes

    SELF.PhoneScore := IF(ShowPhoneScore, L.phone_score, '');
    SELF.PhoneStarRating := L.Phone_StarRating;

    SELF := [];
  END;
  rslt := PROJECT(ppi, outrec(LEFT));
  RETURN rslt;
END;
