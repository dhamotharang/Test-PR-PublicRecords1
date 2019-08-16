/*
Indicator ID	Risk Alert
0	No identity
1	Phone is not active with this person
2	First Seen Date is within “Input A” and “Input B” days (1st date range)
3	Last Seen Date is within last “Input B” days
4								Unused
5	Primary Phone is listed as a Business
6	Phone # has been ported within the past “Input B” days
7	Phone # has been ported more than “Input B” times with this person.
8	Phone # was the origination phone used to spoof another phone # within the past “Input B” days.
9	Phone # has been spoofed within the past “Input B” days
10	 	 	 	 	 	 	Unused
11	 	 	 	 	 	 	Unused
12	 	 	 	 	 	 	Unused
13	 	 	 	 	 	 	Unused
14	 	 	 	 	 	 	Unused
15	Phone # has received “Input A” OTP requests within the past “Input B” days.
16	Phone # is a Prepaid Phone
17	Phone # is associated with a No Contract Carrier
18	Phone Service Type is Landline
19	Phone Service Type is Wireless
20	Phone Service Type is VOIP
21							Unused
22	First Seen Date is within “Input A” and “Input B” days (2nd date range)
23	First Seen Date is within “Input A” and “Input B” days (3rd date range)
24	Primary address is zoned as Commercial
25	Primary address is not the “Current" address for the Primary Subject
26	Phone # was the destination phone used in a spoofing activity with the past “Input B” days.
27	Phone # was the spoofed phone used in a spoofing activity within the past “Input B” days.
28	Primary Subject associated to the phone is deceased
29	Primary Phone Area Code is not in same state as Primary Address.
30	Phone # has had “Input A” search requests within the past “Input B” days
31  Phone # is currently being Forwarded
32  No First Seen Date associated to Phone#
33  No Last Seen Date associated to Phone #
34  No First Seen and Last Seen Date associated to Phone #
35  SIM Card Information has changed in the last “Input B” days.
36  Device Information has changed in the last “Input B” days.
37  Phone in Rejected Transaction.
38  Phone on Global Blacklist.
39  Phone Number Associated with Fraud.
40  Digital ID Bad Reputation.
41  Phone Number First Seen Recently in Digital Identity Network.
42  High Count of Devices Associated to Phone Number in Past Month.
43  High Count of Email Addresses Associated to Phone Number in Past Month.
44  Phone Seen in High Number of Countries in Past Month.
45  Phone Number is Associated to more than [Threshold] Identities
46  Surname of Phone's Listing Name Does Not Match Identity Found
47  Phone returned more than X times in past Y days.
*/

IMPORT $, iesp, STD, ut;

EXPORT CalculatePRIs( DATASET($.Layouts.PhoneFinder.Final) dIn,
                      $.iParam.SearchParams                inMod) :=
FUNCTION
  // If PHONERISKASSESSMENT, ONLY check OTP RI
  dRIs := IF(inMod.TransactionType = $.Constants.TransType.PHONERISKASSESSMENT,	
              IF(inMod.UseThreatMetrixRules, PROJECT(inMod.RiskIndicators(Category = $.Constants.enumCategory[2]), iesp.phonefinder.t_PhoneFinderRiskIndicator),
                                             PROJECT(inMod.RiskIndicators(Category = $.Constants.enumCategory[2] AND OTP),
                                             TRANSFORM(iesp.phonefinder.t_PhoneFinderRiskIndicator, SELF.Level := 'H', SELF.LevelCount := 1, SELF := LEFT))),
              inMod.RiskIndicators);

  rRiskInd_Layout :=
  RECORD(iesp.phonefinder.t_PhoneFinderRiskIndicator)
    BOOLEAN OTPRIFailed;
  END;
  

  $.Layouts.PhoneFinder.Final tRiskInd(dIn pInput) :=
  TRANSFORM
    rRiskInd_Layout tCheckRIs(iesp.phonefinder.t_PhoneFinderRiskIndicator le) :=
    TRANSFORM
      sim_change_date := (UNSIGNED)(MAX(pInput.imsi_ChangeDate, pInput.imsi_ActivationDate));
      device_change_date := (UNSIGNED)(MAX(pInput.imei_ChangeDate, pInput.imei_ActivationDate));
      dt_last_seen    := (UNSIGNED)pInput.dt_last_seen;
      dt_first_seen   := (UNSIGNED)pInput.dt_first_seen;
      currentDate     := STD.Date.Today();
      monthstominutes := (le.Threshold*30*24*60); // Convert Months into Minutes.

      BOOLEAN isPRIFail := CASE(le.RiskId,
                                -1 => pInput.isPrimaryPhone AND pInput.phone = '',
                                0  => pInput.isPrimaryPhone AND (pInput.fname = '' AND pInput.lname = '' AND pInput.listed_name = '' AND pInput.prim_name = '' AND pInput.phone <> ''),
                                1  => pInput.PhoneStatus = $.Constants.PhoneStatus.Inactive,
                                2  => STD.Date.DaysBetween(dt_first_seen, currentDate) BETWEEN le.ThresholdA AND le.Threshold,
                                3  => dt_last_seen <> 0 AND STD.Date.DaysBetween(dt_last_seen, currentDate) > le.Threshold,
                                5  => pInput.listing_type_bus <> '',
                                6  => STD.Date.DaysBetween(pInput.LastPortedDate, currentDate) <= le.Threshold,
                                7  => pInput.PortingCount > 0 AND pInput.PortingCount > le.Threshold,
                                8  => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SOURCE AND STD.Date.DaysBetween((UNSIGNED)EventDate, currentDate) <= le.Threshold)),
                                9  => pInput.LastEventSpoofedDate <> 0 AND STD.Date.DaysBetween(pInput.LastEventSpoofedDate, currentDate) <= le.Threshold,
                                15 => COUNT(pInput.OTPHistory(STD.Date.DaysBetween((UNSIGNED)EventDate, currentDate) <= le.Threshold)) >= IF(le.ThresholdA > 0, le.ThresholdA, $.Constants.OTPRiskLimit),
                                16 => pInput.Prepaid,
                                17 => pInput.NoContractCarrier,
                                18 => pInput.coc_description = $.Constants.PhoneType.LANDLINE,
                                19 => pInput.coc_description = $.Constants.PhoneType.WIRELESS,
                                20 => pInput.coc_description = $.Constants.PhoneType.VoIP,
                                22 => STD.Date.DaysBetween(dt_first_seen, currentDate) BETWEEN le.ThresholdA AND le.Threshold,
                                23 => STD.Date.DaysBetween(dt_first_seen, currentDate) BETWEEN le.ThresholdA AND le.Threshold,
                                24 => STD.Str.ToUpperCase(pInput.primary_address_type) = 'BUSINESS',
                                25 => pInput.tnt = 'H' AND pInput.prim_name <> '',
                                26 => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.DESTINATION AND STD.Date.DaysBetween((UNSIGNED)EventDate, currentDate) <= le.Threshold)),
                                27 => EXISTS(pInput.SpoofingHistory(phoneOrigin = $.Constants.SpoofPhoneOrigin.SPOOFED AND STD.Date.DaysBetween((UNSIGNED)EventDate, currentDate) <= le.Threshold)),
                                28 => pInput.deceased = 'Y',
                                29 => pInput.st <> '' AND pInput.PhoneState <> pInput.st,
                                30 => COUNT(pInput.InquiryDates(STD.Date.DaysBetween((UNSIGNED)inquiryDate, currentDate) <= le.Threshold)) + pInput.RecordsReturned >= MAX(le.ThresholdA, $.Constants.InquiryDayLimit),
                                31 => pInput.CallForwardingIndicator = $.Functions.CallForwardingDesc(1),
                                32 => dt_first_seen = 0,
                                33 => dt_last_seen = 0,
                                34 => dt_first_seen = 0 AND dt_last_seen = 0,
                                35 => (STD.Date.DaysBetween(sim_change_date, currentDate) <= le.Threshold),
                                36 => (STD.Date.DaysBetween(device_change_date, currentDate) <= le.Threshold),
                                37 => MAP(le.ThresholdB = 'Day' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Reject - One Day')),
                                          le.ThresholdB = 'Week' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Reject - One Week')),
                                          le.ThresholdB = 'Month' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Reject - One Month')),
                                           FALSE),
                                38 => EXISTS(pInput.ReasonCodes(value = 'Phone Number in Global Blacklist')), 
                                39 => MAP(le.ThresholdB = 'Week' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Fraud - One Week')),
                                          le.ThresholdB = 'Month' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Fraud - One Month')),
                                          le.ThresholdB = 'Three Months' => EXISTS(pInput.ReasonCodes(value = 'Phone Number Fraud - Three Months')),
                                           FALSE),
                                40 => EXISTS(pInput.ReasonCodes(value = 'AssociatedDigitalID - Trust Score below Zero')),
                                41 => EXISTS((pInput.TmxVariables(Name = 'timesincephonefirstseen' AND (INTEGER)Value <= MonthstoMinutes))),
                                42 => EXISTS((pInput.TmxVariables(Name = 'countdeviceseenwithphone_month' AND (INTEGER)Value >= le.Threshold))),
                                43 => EXISTS((pInput.TmxVariables(Name = 'countemailsseenwithphone_month' AND (INTEGER)Value >= le.Threshold))),
                                44 => EXISTS((pInput.TmxVariables(Name = 'phoneseenmultiplecountry_month' AND (INTEGER)Value >= le.Threshold))),
                                45 => pInput.identity_count > le.Threshold,
                                46 => inMod.isPrimarySearchPII AND ~pInput.isLNameMatch,
                                47 => pInput.phone_inresponse_count > le.ThresholdA,
                                FALSE);

      SELF.RiskId      := IF(isPRIFail, le.RiskId, SKIP);
      SELF.OTPRIFailed := le.OTP AND isPRIFail;
      SELF             := le;
    END;

    dIterateRIs := PROJECT(dRIs(Active AND LevelCount > 0), tCheckRIs(LEFT));
    
    // For each Level we would only have ONE LevelCount. The structure of RIs is misleading.
    // For any RI with respective Level, we can look at the LevelCount to get the threshold of PASS/WARN/FAIL
    rLevelCnt_Layout :=
    RECORD
      dIterateRIs.Level;
      dIterateRIs.LevelCount;
      cntLevels := COUNT(GROUP);
    END;

    tblLevelCnt := TABLE(dIterateRIs, rLevelCnt_Layout, Level, LevelCount, FEW);

    SELF.AlertIndicators   := PROJECT(SORT(dIterateRIs(Category != ''), Category),
                                      TRANSFORM(iesp.phonefinder.t_PhoneFinderAlertIndicator,
                                                SELF.Flag     := LEFT.Category,
                                                SELF.Messages := LEFT.RiskDescription,
                                                SELF          := LEFT));
    SELF.Alerts             := ROLLUP(GROUP(SORT(dIterateRIs(Category != ''), Category), Category),
                                      GROUP,
                                      TRANSFORM($.Layouts.PhoneFinder.Alert,
                                                SELF.flag     := LEFT.Category,
                                                SELF.Messages := PROJECT(ROWS(LEFT), TRANSFORM(iesp.share.t_StringArrayItem, SELF.value := LEFT.RiskDescription))));
    SELF.PhoneRiskIndicator := MAP( EXISTS(tblLevelCnt(cntLevels >= LevelCount)) => $.Constants.RiskIndicator[$.Constants.RiskLevel.FAILED],
                                    EXISTS(dIterateRIs)                          => $.Constants.RiskIndicator[$.Constants.RiskLevel.WARN],
                                    $.Constants.RiskIndicator[$.Constants.RiskLevel.PASS]);
    SELF.OTPRIFailed        := EXISTS(dIterateRIs(OTPRIFailed));
    SELF                    := pInput;
  END;
  
  dResultsWithRIs := PROJECT(dIn, tRiskInd(LEFT));

  RETURN dResultsWithRIs;
END;