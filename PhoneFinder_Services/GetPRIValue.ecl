IMPORT iesp, PhoneFinder_Services,std,ut;

EXPORT GetPRIValue(PhoneFinder_Services.Layouts.PhoneFinder.Final SubjectPhone,
										PhoneFinder_Services.iParam.ReportParams inMod):= FUNCTION
Constants := PhoneFinder_Services.Constants;

	//**********************************************************************************************************************************************
	// inMod.TransactionType=PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT using only Phone Activity rules and ALL rules are High alerts
	//**********************************************************************************************************************************************
PRIRules := IF(inMod.TransactionType=PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,	
										PROJECT(inMod.RiskIndicators(Category=PhoneFinder_Services.Constants.enumCategory[2] AND OTP),
																			TRANSFORM(iesp.phonefinder.t_PhoneFinderRiskIndicator, SELF.Level:='H', SELF.LevelCount:=1, SELF:=LEFT, SELF:=[])),
										inMod.RiskIndicators);
currentDate := (STRING)STD.Date.Today();										
	alertRec:= RECORD
		STRING flag;
		STRING message;
	END;	
	RulesRec := RECORD
		iesp.phonefinder.t_PhoneFinderRiskIndicator;
		UNSIGNED1 indicator;
		BOOLEAN OTPRIFailed;
		DATASET(alertRec) Alerts;
	END;
	
	RulesRec evaluateRules(iesp.phonefinder.t_PhoneFinderRiskIndicator l) := TRANSFORM
		hasFailed := CASE(l.RiskId, 
		// Risk Rules - See comprehensive descriptions of each option at the end of the attribute
		// -----------------------------------------------------------------------
										0  => SubjectPhone.fname='' AND SubjectPhone.lname='' AND SubjectPhone.listed_name='' AND SubjectPhone.prim_name='' AND SubjectPhone.batch_in.homephone<>'', // no identity
										// Eventually we will obtain PortingStatus from the LIBD file, however for now we continue to use TU as authoritative
										// 1  => SubjectPhone.PortingStatus='Inactive',
									 -1 => SubjectPhone.phone = '',
										1  => PhoneFinder_Services.Functions.PhoneStatusDesc((INTEGER)SubjectPhone.realtimephone_ext.statuscode)='INACTIVE',
										2  => (UNSIGNED)SubjectPhone.dt_first_seen>(UNSIGNED)ut.date_math(currentDate,-l.Threshold ) AND 
																		(UNSIGNED)SubjectPhone.dt_first_seen <= (UNSIGNED)ut.date_math(currentDate, -l.ThresholdA),
										3  => SubjectPhone.dt_last_seen<>'' AND ut.DaysApart(SubjectPhone.dt_last_seen,currentDate)>l.Threshold,
										5  => SubjectPhone.listing_type_bus<>'',
										6  => ut.DaysApart((STRING)SubjectPhone.LastPortedDate,currentDate)<=l.Threshold,
										7  => SubjectPhone.PortingCount > 0 AND SubjectPhone.PortingCount > l.Threshold,
										8  => EXISTS(SubjectPhone.SpoofingHistory(phoneOrigin=Constants.SpoofPhoneOrigin.SOURCE AND 
																															(UNSIGNED)EventDate > (UNSIGNED)ut.date_math(currentDate, -l.Threshold))),
										9  => SubjectPhone.LastEventSpoofedDate<>0 AND ut.DaysApart((STRING)SubjectPhone.LastEventSpoofedDate,currentDate)<=l.Threshold,
										15 => COUNT(SubjectPhone.OTPHistory((UNSIGNED)EventDate > (UNSIGNED)ut.date_math(currentDate, -l.Threshold))) 
																																>= IF(l.ThresholdA > 0,l.ThresholdA,Constants.OTPRiskLimit),										
										16 => SubjectPhone.Prepaid,
										17 => SubjectPhone.NoContractCarrier,
										// Might be needed later - TU conflicts with PortMetadata - changes will come in Release 4
										// Using PortMetadata as authoritative when available. See similar inactive rule above
										// 18 => SubjectPhone.serviceType = PhoneFinder_Services.Constants.serviceType.LANDLINE,
										// 19 => SubjectPhone.serviceType = PhoneFinder_Services.Constants.serviceType.WIRELESS,
										// 20 => SubjectPhone.serviceType = PhoneFinder_Services.Constants.serviceType.VOIP,
										18 => SubjectPhone.coc_description = PhoneFinder_Services.Constants.PhoneType.LANDLINE,
										19 => SubjectPhone.coc_description = PhoneFinder_Services.Constants.PhoneType.WIRELESS,
										20 => SubjectPhone.coc_description = PhoneFinder_Services.Constants.PhoneType.VOIP,
										22 => (UNSIGNED)SubjectPhone.dt_first_seen>(UNSIGNED)ut.date_math(currentDate, -l.Threshold) AND 
																		(UNSIGNED)SubjectPhone.dt_first_seen <= (UNSIGNED)ut.date_math(currentDate, -l.ThresholdA),
										23 => (UNSIGNED)SubjectPhone.dt_first_seen>(UNSIGNED)ut.date_math(currentDate, -l.Threshold) AND 
																		(UNSIGNED)SubjectPhone.dt_first_seen <= (UNSIGNED)ut.date_math(currentDate,-l.ThresholdA ),
										24 => SubjectPhone.primary_address_type = 'Business',
										25 => SubjectPhone.tnt = 'H' AND SubjectPhone.prim_name<>'',
										26 => EXISTS(SubjectPhone.SpoofingHistory(phoneOrigin=Constants.SpoofPhoneOrigin.DESTINATION AND 
																															(UNSIGNED)EventDate > (UNSIGNED)ut.date_math(currentDate, -l.Threshold))),
										27 => EXISTS(SubjectPhone.SpoofingHistory(phoneOrigin=Constants.SpoofPhoneOrigin.SPOOFED AND 
																															(UNSIGNED)EventDate > (UNSIGNED)ut.date_math(currentDate, -l.Threshold))),		
										28 => SubjectPhone.deceased = 'Y',																					
										29 => SubjectPhone.st<> '' AND SubjectPhone.PhoneState <> SubjectPhone.st, //check for best.st <> st
										//30 => COUNT(SubjectPhone.InquiryDates((UNSIGNED4)inquiryDate>=(UNSIGNED)ut.date_math(currentDate, -l.Threshold))) >= MAX(l.ThresholdA,Constants.InquiryDayLimit),
										30 => COUNT(SubjectPhone.InquiryDates((UNSIGNED4)inquiryDate>=(UNSIGNED)ut.date_math(currentDate, -l.Threshold))) + SubjectPhone.RecordsReturned
										                                                            >= MAX(l.ThresholdA,Constants.InquiryDayLimit),
                    31=> 	SubjectPhone.CallForwardingIndicator   =	PhoneFinder_Services.Functions.CallForwardingDesc(1),							
										32 => (UNSIGNED)SubjectPhone.dt_first_seen = 0,
										33 => (UNSIGNED)SubjectPhone.dt_last_seen = 0,
										34 => (UNSIGNED)SubjectPhone.dt_first_seen = 0 AND (UNSIGNED)SubjectPhone.dt_last_seen = 0,
										FALSE);				
		//Keep violating rules and risk indicator	based on individual rule.
		SELF.Alerts 	 := IF(hasFailed, PROJECT(l, TRANSFORM(alertRec, SELF.flag := LEFT.Category,SELF.message := LEFT.RiskDescription)));
		SELF.OTPRIFailed:= hasFailed and l.OTP;
		SELF.indicator := MAP(hasFailed AND l.LevelCount = 1 => Constants.RiskLevel.FAILED,
													hasFailed AND l.LevelCount > 1 => Constants.RiskLevel.WARN,
													Constants.RiskLevel.PASS);
		SELF:=l;
	END;
	dsRules := PROJECT(PRIRules(Active), evaluateRules(LEFT)); 

	levelSort := SORT(dsRules(indicator > Constants.RiskLevel.PASS),Level);
	
	//Distinguish between warning and failure
	RulesRec computeAlert(RulesRec l, RulesRec r) := TRANSFORM
		totalAlerts 		:= COUNT(l.Alerts + r.Alerts);
		SELF.Alerts 		:= l.Alerts + r.Alerts;
		SELF.OTPRIFailed:= l.OTPRIFailed OR r.OTPRIFailed; 
		SELF.indicator 	:= MAP(totalAlerts >= MIN(l.LevelCount,r.levelCount) => Constants.RiskLevel.FAILED,
													totalAlerts > 0 															 => Constants.RiskLevel.WARN,
																																						Constants.RiskLevel.PASS);
		SELF.LevelCount	:=	MIN(l.LevelCount,r.levelCount); 
		SELF := [];
	END;
	dsAlert := ROLLUP(levelSort,
												LEFT.Level=RIGHT.Level,
												computeAlert(LEFT,RIGHT));
																					
	//Rollup alerts by categories req2.12										
	PhoneFinder_Services.Layouts.PhoneFinder.alert rollCategory(alertRec l, DATASET(alertRec) allRows) :=TRANSFORM
		SELF.flag := l.flag;
		SELF.messages := PROJECT(allRows,TRANSFORM(iesp.share.t_StringArrayItem, SELF.value := LEFT.message));
	END;
	alertResults := ROLLUP(GROUP(SORT(dsAlert.Alerts,flag),flag), GROUP, rollCategory(LEFT,ROWS(LEFT)));

	//Identify resulting risk and whether any OTP Rule failed
	risk:= TABLE(dsAlert,{UNSIGNED indicator := MAX(MAX(GROUP, dsAlert.indicator),Constants.RiskLevel.PASS),
												BOOLEAN OTPRIFailed:= MAX(GROUP, dsAlert.OTPRIFailed)})[1];

	//Add risk results and alerts to Primary phone.
	PrimaryPhoneUpd := PROJECT(SubjectPhone,TRANSFORM(PhoneFinder_Services.Layouts.PhoneFinder.Final,
																										SELF.Alerts 					 := alertResults,
																										SELF.PhoneRiskIndicator:=Constants.RiskIndicator[risk.indicator],
																										SELF.OTPRIFailed			 :=risk.OTPRIFailed,
																										SELF:=LEFT));
	// OUTPUT(dsRules);																									
	// OUTPUT(levelSort);
	// OUTPUT(dsAlert.alerts);
	// OUTPUT(alertResults);																										
	// OUTPUT(risk);																																																	
	// OUTPUT(PrimaryPhoneUpd);
	RETURN PrimaryPhoneUpd;
END;

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
*/	
