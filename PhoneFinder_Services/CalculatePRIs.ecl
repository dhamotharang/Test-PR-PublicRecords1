IMPORT $, iesp, STD, ut;

EXPORT CalculatePRIs( DATASET($.Layouts.PhoneFinder.Final) dIn,
                      $.iParam.ReportParams                inMod) :=
FUNCTION
  currentDate := (STRING)STD.Date.Today();

  // If PHONERISKASSESSMENT, ONLY check OTP RI
  dRIs := IF(inMod.TransactionType = $.Constants.TransType.PHONERISKASSESSMENT,	
              PROJECT(inMod.RiskIndicators(Category = $.Constants.enumCategory[2] AND OTP),
                      TRANSFORM(iesp.phonefinder.t_PhoneFinderRiskIndicator, SELF.Level := 'H', SELF.LevelCount := 1, SELF := LEFT)),
              inMod.RiskIndicators);

  rRiskInd_Layout :=
  RECORD(iesp.phonefinder.t_PhoneFinderRiskIndicator)
    BOOLEAN OTPRIFailed;
  END;

  $.Layouts.PhoneFinder.Final tRiskInd(dIn pInput) :=
  TRANSFORM
    rRiskInd_Layout tCheckRIs(iesp.phonefinder.t_PhoneFinderRiskIndicator le) :=
    TRANSFORM
      sim_change_date := IF(pInput.imsi_ChangeDate <> '', pInput.imsi_ChangeDate, pInput.imsi_ActivationDate);
      BOOLEAN isPRIFail := CASE(le.RiskId,
                                -1 => pInput.phone = '',
                                0  => pInput.fname = '' AND pInput.lname = '' AND pInput.listed_name = '' AND pInput.prim_name = '' AND pInput.batch_in.homephone <> '',
                                1  => pInput.PhoneStatus = $.Constants.PhoneStatus.Inactive,
                                2  => ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN le.ThresholdA AND le.Threshold,
                                3  => pInput.dt_last_seen <> '' AND ut.DaysApart(currentDate, pInput.dt_last_seen) > le.Threshold,
                                5  => pInput.listing_type_bus <> '',
                                6  => ut.DaysApart(currentDate, (STRING)pInput.LastPortedDate) <= le.Threshold,
                                7  => pInput.PortingCount > 0 AND pInput.PortingCount > le.Threshold,
                                8  => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SOURCE AND ut.DaysApart(currentDate, EventDate) <= le.Threshold)),
                                9  => pInput.LastEventSpoofedDate <> 0 AND ut.DaysApart(currentDate, (STRING)pInput.LastEventSpoofedDate) <= le.Threshold,
                                15 => COUNT(pInput.OTPHistory(ut.DaysApart(currentDate, EventDate) <= le.Threshold)) >= IF(le.ThresholdA > 0, le.ThresholdA, $.Constants.OTPRiskLimit),
                                16 => pInput.Prepaid,
                                17 => pInput.NoContractCarrier,
                                18 => pInput.coc_description = $.Constants.PhoneType.LANDLINE,
                                19 => pInput.coc_description = $.Constants.PhoneType.WIRELESS,
                                20 => pInput.coc_description = $.Constants.PhoneType.VoIP,
                                22 => ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN le.ThresholdA AND le.Threshold,
                                23 => ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN le.ThresholdA AND le.Threshold,
                                24 => STD.Str.ToUpperCase(pInput.primary_address_type) = 'BUSINESS',
                                25 => pInput.tnt = 'H' AND pInput.prim_name <> '',
                                26 => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.DESTINATION AND ut.DaysApart(currentDate, EventDate) <= le.Threshold)),
                                27 => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SPOOFED AND ut.DaysApart(currentDate, EventDate) <= le.Threshold)),
                                28 => pInput.deceased = 'Y',
                                29 => pInput.st<> '' AND pInput.PhoneState <> pInput.st,
                                30 => COUNT(pInput.InquiryDates(ut.DaysApart(currentDate, inquiryDate) <= le.Threshold)) + pInput.RecordsReturned >= MAX(le.ThresholdA, $.Constants.InquiryDayLimit),
                                31 => pInput.CallForwardingIndicator = $.Functions.CallForwardingDesc(1),
                                32 => (UNSIGNED)pInput.dt_first_seen = 0,
                                33 => (UNSIGNED)pInput.dt_last_seen = 0,
                                34 => (UNSIGNED)pInput.dt_first_seen = 0 AND (UNSIGNED)pInput.dt_last_seen = 0,
                                35 => ut.DaysApart(currentDate, sim_change_date) <= le.Threshold OR
                                      (pInput.imsi_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imsi_seensince) <= le.Threshold),
                                36 => ut.DaysApart(currentDate, pInput.imei_ChangeDate) <= le.Threshold OR 
                                      (pInput.loststolen = 1 AND  ut.DaysApart(currentDate, pInput.loststolen_date) <= le.Threshold) OR
                                      (pInput.imsi_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imsi_seensince) <= le.Threshold) OR																																																																								
                                      (pInput.imei_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imei_seensince) <= le.Threshold) OR																																																																								
                                      (pInput.iccid_changedthis_time = 1 AND ut.DaysApart(currentDate, pInput.iccid_seensince) <= le.Threshold),
                                FALSE
                              );

      SELF.RiskId      := IF(isPRIFail, le.RiskId, SKIP);
      SELF.OTPRIFailed := le.OTP AND isPRIFail;
      SELF             := le;
    END;

    dIterateRIs := PROJECT(dRIs, tCheckRIs(LEFT));
    
    // For each Level we would only have ONE LevelCount. The structure of RIs is misleading.
    // For any RI with respective Level, we can look at the LevelCount to get the threshold of PASS/WARN/FAIL
    rLevelCnt_Layout :=
    RECORD
      dIterateRIs.Level;
      dIterateRIs.LevelCount;
      cntLevels := COUNT(GROUP);
    END;

    tblLevelCnt := TABLE(dIterateRIs, rLevelCnt_Layout, Level, LevelCount, FEW);

    SELF.AlertIndicators   := PROJECT(dIterateRIs,
                                      TRANSFORM(iesp.phonefinder.t_PhoneFinderAlertIndicator,
                                                SELF.Flag     := LEFT.Category,
                                                SELF.Messages := LEFT.RiskDescription,
                                                SELF          := LEFT));
    SELF.Alerts             := ROLLUP(GROUP(SORT(dIterateRIs, Category), Category),
                                      GROUP,
                                      TRANSFORM($.Layouts.PhoneFinder.Alert,
                                                SELF.flag     := LEFT.Category,
                                                SELF.Messages := PROJECT(ROWS(LEFT), TRANSFORM(iesp.share.t_StringArrayItem, SELF.value := LEFT.RiskDescription))));
    SELF.PhoneRiskIndicator := MAP( EXISTS(tblLevelCnt(cntLevels > LevelCount)) => $.Constants.RiskIndicator[$.Constants.RiskLevel.FAILED],
                                    EXISTS(dIterateRIs)                         => $.Constants.RiskIndicator[$.Constants.RiskLevel.WARN],
                                    $.Constants.RiskIndicator[$.Constants.RiskLevel.PASS]);
    SELF.OTPRIFailed        := EXISTS(dIterateRIs(OTPRIFailed));
    SELF                    := pInput;
  END;
    /*
    dtFirstSeenDaysApartRI1 := dictRIs[2];
    dtLastSeenDaysOlderRI   := dictRIs[3];
    dtPortedLastSeenDaysRI  := dictRIs[6];
    portingCountRI          := dictRIs[7];
    spoofOriginRI           := dictRIs[8];
    spoofEventRI            := dictRIs[9];
    otpEventRI              := dictRIs[15];
    dtFirstSeenDaysApartRI2 := dictRIs[22];
    dtFirstSeenDaysApartRI3 := dictRIs[23];
    spoofDestRI             := dictRIs[26];
    spoofRI                 := dictRIs[27];
    inquiryRI               := dictRIs[30];
    simRI                   := dictRIs[35];
    deviceRI                := dictRIs[36];

    sim_change_date := IF(pInput.imsi_ChangeDate <> '', pInput.imsi_ChangeDate, pInput.imsi_ActivationDate);

    SELF.Alerts := PROJECT(IF(pInput.phone = '', dictRIs[-1]) +
                    IF(pInput.fname = '' AND pInput.lname = '' AND pInput.listed_name = '' AND pInput.prim_name = '' AND pInput.batch_in.homephone <> '', dictRIs[0]) +
                    IF(pInput.PhoneStatus = $.Constants.PhoneStatus.Inactive, dictRIs[1]) +
                    IF(ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN dtFirstSeenDaysApartRI1.ThresholdA AND dtFirstSeenDaysApartRI1.Threshold, dtFirstSeenDaysApartRI1) +
                    IF(pInput.dt_last_seen <> '' AND ut.DaysApart(currentDate, pInput.dt_last_seen) > dtLastSeenDaysOlderRI.Threshold, dtLastSeenDaysOlderRI) +
                    IF(pInput.listing_type_bus <> '', dictRIs[5]) +
                    IF(ut.DaysApart(currentDate, (STRING)pInput.LastPortedDate) <= dtPortedLastSeenDaysRI.Threshold, dtPortedLastSeenDaysRI) +
                    IF(pInput.PortingCount > 0 AND pInput.PortingCount > portingCountRI.Threshold, portingCountRI) +
                    IF(EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SOURCE AND ut.DaysApart(currentDate, EventDate) <= spoofOriginRI.Threshold)), spoofOriginRI) +
                    IF(pInput.LastEventSpoofedDate <> 0 AND ut.DaysApart(currentDate, (STRING)pInput.LastEventSpoofedDate) <= spoofEventRI.Threshold, spoofEventRI) +
                    IF(COUNT(pInput.OTPHistory(ut.DaysApart(currentDate, EventDate) <= otpEventRI.Threshold)) >= IF(otpEventRI.ThresholdA > 0, otpEventRI.ThresholdA, $.Constants.OTPRiskLimit), otpEventRI) +
                    IF(pInput.Prepaid, dictRIs[16]) +
                    IF(pInput.NoContractCarrier, dictRIs[17]) +
                    IF(pInput.coc_description = $.Constants.PhoneType.LANDLINE, dictRIs[18]) +
                    IF(pInput.coc_description = $.Constants.PhoneType.WIRELESS, dictRIs[19]) +
                    IF(pInput.coc_description = $.Constants.PhoneType.VoIP, dictRIs[20]) +
                    IF(ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN dtFirstSeenDaysApartRI2.ThresholdA AND dtFirstSeenDaysApartRI2.Threshold, dtFirstSeenDaysApartRI2) +
                    IF(ut.DaysApart(currentDate, pInput.dt_first_seen) BETWEEN dtFirstSeenDaysApartRI3.ThresholdA AND dtFirstSeenDaysApartRI3.Threshold, dtFirstSeenDaysApartRI3) +
                    IF(STD.Str.ToUpperCase(pInput.primary_address_type) = 'BUSINESS', dictRIs[24]) +
                    IF(pInput.tnt = 'H' AND pInput.prim_name <> '', dictRIs[25]) +
                    IF(EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.DESTINATION AND ut.DaysApart(currentDate, EventDate) <= spoofDestRI.Threshold)), spoofDestRI) +
                    IF(EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SPOOFED AND ut.DaysApart(currentDate, EventDate) <= spoofRI.Threshold)), spoofRI) +
                    IF(pInput.deceased = 'Y', dictRIs[28]) +
                    IF(pInput.st<> '' AND pInput.PhoneState <> pInput.st, dictRIs[29]) +
                    IF(COUNT(pInput.InquiryDates(ut.DaysApart(currentDate, inquiryDate) <= inquiryRI.Threshold)) + pInput.RecordsReturned >= MAX(inquiryRI.ThresholdA, $.Constants.InquiryDayLimit), inquiryRI) +
                    IF(pInput.CallForwardingIndicator   =	$.Functions.CallForwardingDesc(1), dictRIs[31]) +
                    IF((UNSIGNED)pInput.dt_first_seen = 0, dictRIs[32]) +
                    IF((UNSIGNED)pInput.dt_last_seen = 0, dictRIs[33]) +
                    IF((UNSIGNED)pInput.dt_first_seen = 0 AND (UNSIGNED)pInput.dt_last_seen = 0, dictRIs[34]) +
                    IF(ut.DaysApart(currentDate, sim_change_date) <= simRI.Threshold OR (pInput.imsi_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imsi_seensince) <= simRI.Threshold), simRI) +
                    IF(ut.DaysApart(currentDate, pInput.imei_ChangeDate) <= deviceRI.Threshold OR 
											 (pInput.loststolen = 1 AND  ut.DaysApart(currentDate, pInput.loststolen_date) <= deviceRI.Threshold) OR
											 (pInput.imsi_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imsi_seensince) <= deviceRI.Threshold) OR																																																																								
											 (pInput.imei_changedthis_time = 1  AND ut.DaysApart(currentDate, pInput.imei_seensince) <= deviceRI.Threshold) OR																																																																								
											 (pInput.iccid_changedthis_time = 1 AND ut.DaysApart(currentDate, pInput.iccid_seensince) <= deviceRI.Threshold), deviceRI),
                       TRANSFORM($.Layouts.PhoneFinder.Alert, SELF.flag := LEFT.Category, SELF.messages := LEFT.RiskDescriptionSELF := LEFT));
    SELF        := pInput;
  END;
  */
  dResultsWithRIs := PROJECT(dIn, tRiskInd(LEFT));

  RETURN dResultsWithRIs;
END;