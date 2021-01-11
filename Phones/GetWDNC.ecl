IMPORT Doxie, dx_Phone_TCPA, Phones;

EXPORT GetWDNC(
  DATASET(Phones.Layouts.PhoneAttributes.BatchIn) dBatchPhonesIn,
  Phones.IParam.BatchParams in_mod)
  := FUNCTION
phoneInfo := DEDUP(SORT(PROJECT(dBatchPhonesIn, TRANSFORM(Phones.Layouts.rec_phoneLayout, SELF.phone := LEFT.phoneno)), phone), phone);

dWDNC_history := IF(doxie.compliance.use_WDNC(in_mod.DataPermissionMask) AND in_mod.Allow_TCPA_Port, dx_Phone_TCPA.RAW.GetWDNC_history(phoneInfo));

dWDNC_historyrecords := PROJECT(dWDNC_history, TRANSFORM(Phones.Layouts.PhoneAttributes.Raw,
                                               SELF.phone := LEFT.phone,
                                               SELF.acctno := '',
					                           SELF.source := Phones.Constants.Sources.PHONES_WDNC,
                                               SELF.phone_line_type := LEFT.phone_type,
					                           SELF.phone_serv_type := LEFT.phone_type,
                                               SELF.line_type_last_seen := LEFT.dt_last_seen,
			                                   SELF.event_date := LEFT.dt_first_seen,
				                               SELF.event_type := Phones.Constants.PhoneAttributes.PORTED_LINE,
                                               SELF.line := LEFT.phone_type,
					                           SELF.is_current := LEFT.is_current,
                                               SELF := []));

dWDNCPhones := JOIN(dBatchPhonesIn, dWDNC_historyrecords,
	               LEFT.phoneno = RIGHT.phone,
							   TRANSFORM(Phones.Layouts.PhoneAttributes.Raw, 
							   SELF.acctno := LEFT.acctno, 
							   SELF.phoneno := LEFT.phoneno,
							   SELF := RIGHT),
							   LIMIT(0), KEEP(Phones.Constants.PhoneAttributes.MaxRecsPerPhone));
RETURN dWDNCPhones;
END;