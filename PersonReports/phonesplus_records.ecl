IMPORT $, iesp, doxie, moxie_phonesplus_server;

out_rec    := iesp.dirassistwireless.t_PhonesPlusRecord;
out_rec_v2 := iesp.bpsreport.t_BpsReportPhonesPlusRecord; // same as above + PhonesFeedback

EXPORT phonesplus_records (
  dataset (doxie.layout_references) dids,
  $.IParam.phonesplus in_params = module ($.IParam.phonesplus) end,
  boolean IsFCRA = false
) := MODULE

  phpl := moxie_phonesplus_server.phonesplus_did_records (
            dids,
            iesp.Constants.BR.MaxPhonesPlus, //this is ignored, actually...
            in_params.score_threshold,
            in_params.glb,
            in_params.dppa,, TRUE).w_timezone; //IsRoxie

  rec_in := Moxie_phonesplus_Server.Layout_batch_did.w_timezone;

  out_rec_v2 FormatReport (rec_in L) := TRANSFORM
    self.ListedName := L.listed_name;
    self.Name := iesp.ECL2ESP.SetName (L.name_first, L.name_middle, L.name_last, L.name_suffix, '');
    self.Address := iesp.ECL2ESP.SetAddress (
      L.prim_name, L.prim_range, L.predir, L.postdir, L.suffix, L.unit_desig, L.sec_range, 
      L.city, L.st, L.z5, L.z4, '');
    self.PhoneNumber := L.phoneno;
    self.TimeZone := L.timezone;
    self.PhoneType := L.PhoneType;
    self.CarrierName   := L.carrier;
    self.CarrierCity   := L.carrier_city;
    self.CarrierState  := L.carrier_state;
    self.ListingTypes := dataset ([{L.listing_type_bus}, {L.listing_type_res}, {L.listing_type_cell}],
                                  iesp.share.t_StringArrayItem);
    LF := choosen (L.Feedback, 1) [1];
    f_row := row ({LF.feedback_count, LF.Last_Feedback_Result, LF.Last_Feedback_Result_Provided},
                                iesp.phonesfeedback.t_PhonesFeedback);
    Self.PhoneFeedback := if (in_params.include_phonesfeedback, f_row);
  END;
  
  EXPORT phonesplus_v2 := if (~IsFCRA, PROJECT (phpl, FormatReport (Left)));

  // slice feedback off
  EXPORT phonesplus := if (~IsFCRA, PROJECT (phonesplus_v2, out_rec));

END;
