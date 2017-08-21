IMPORT BAIR, STD, VersionControl, ut;

EXPORT raidsReport := MODULE 

EXPORT raidsReport_Email () := FUNCTION

raidsStatsBuiltSF := '~thor_data400::in::prepped::statsreport::built';
raidsStatsSentSF  := '~thor_data400::in::prepped::statsreport::sent';

today := ut.getDate : INDEPENDENT; 

raidsByDayDate 		:= ut.date_math(today,-1);
raidsByWeekDate 	:= ut.date_math(today,-7);
raidsByMonthDate 	:= ut.date_math(today,-30);

sendEmailNoReportAddress := Bair.Email_Notification_Lists.BuildFailure_Raidsreport;
bairTeamEmail := Bair.Email_Notification_Lists.BuildSuccess_Raidsreport;

raidsStatsBuilt := DATASET(raidsStatsBuiltSF, Bair.raidsReport_Layout.raidsReportRec, THOR);

rAgenciesRAIDSReportSchedule := RECORD
  UNSIGNED4 providerID := raidsStatsBuilt.providerID;
  STRING periodicity := 'file received';
	STRING emailAddress := bairTeamEmail;
END;

dAgenciesRAIDSReportScheduleTB := TABLE(raidsStatsBuilt,rAgenciesRAIDSReportSchedule);
rAgenciesRAIDSReportSchedule tBuilds(dAgenciesRAIDSReportScheduleTB L, dAgenciesRAIDSReportScheduleTB R) := TRANSFORM
		SELF                        := L;
		SELF                        := R;
END;

dAgenciesRAIDSReportSchedule := ROLLUP(SORT(dAgenciesRAIDSReportScheduleTB,providerID),LEFT.providerID = RIGHT.providerID, tBuilds(LEFT,RIGHT)):INDEPENDENT;


raidsStatsSent := DATASET(raidsStatsSentSF, Bair.raidsReport_Layout.rFilesSent, THOR);
Bair.raidsReport_Layout.raidsReportRec JoinThemLeftOnly(Bair.raidsReport_Layout.raidsReportRec L, Bair.raidsReport_Layout.rFilesSent R) := TRANSFORM
	SELF := L;
END;
raidsStatsNOTSent := JOIN(raidsStatsBuilt,raidsStatsSent,
	 				              LEFT.filename = RIGHT.filename,
												JoinThemLeftOnly(LEFT,RIGHT),
					              LEFT ONLY);

sCandidates := RECORD
  UNSIGNED4 providerID;
  STRING periodicity;
	STRING emailAddress;
  DATASET(Bair.raidsReport_Layout.raidsReportRec) raidsStatsRec;
 	STRING filesIncluded := '';
	STRING data_provider_name:='';
END;

sCandidates JoinThem(rAgenciesRAIDSReportSchedule L, Bair.raidsReport_Layout.raidsReportRec R) := TRANSFORM
	SELF := L;
	SELF.raidsStatsRec := R;
	SELF.filesIncluded := R.filename;
	SELF.data_provider_name := R.data_provider_name;
END;
InnerJoinedRecs := JOIN(dAgenciesRAIDSReportSchedule,raidsStatsNotSent,
					              LEFT.providerid = RIGHT.providerid,
												JoinThem(LEFT,RIGHT));

raidsByFile  := InnerJoinedRecs(periodicity='file received');
raidsByDay   := InnerJoinedRecs(periodicity='daily', EXISTS(raidsstatsrec(dtimport=raidsByDayDate))); 
raidsByWeek  := InnerJoinedRecs(periodicity='weekly', EXISTS(raidsstatsrec(dtimport>=raidsByWeekDate))); 
raidsByMonth := InnerJoinedRecs(periodicity='monthly', EXISTS(raidsstatsrec(dtimport>=raidsByMonthDate))); 

raidsEmail := raidsByFile + raidsByDay + raidsByWeek + raidsByMonth; 

reprocessNote := if (STD.STR.Find(raidsEmail.filesIncluded,'.xml-')>0,' - REPROCESSED',' ');

sentEmail  := SEQUENTIAL(APPLY(raidsEmail,
						        STD.System.Email.SendEmailAttachText
										(raidsEmail.emailAddress 
										,'Data Import Report - ' + raidsEmail.data_provider_name
										,'Files included on this report:\n\n' + raidsEmail.filesIncluded
										, Bair.raidsReport_FormatHTML.fn_msg(raidsEmail.raidsStatsRec)
										,'text/plain; charset=ISO-8859-3'
										,'raidsReport.html'
										,,,'LNACA_Service@lexisnexis.com')));

sendEmailNoReport := STD.System.Email.SendEmail(sendEmailNoReportAddress,'Accurint Crime Analysis and/or Community Crime Map Import Report','No new Accurint Crime Analysis and/or Community Crime Map stats data available');
STRING fVersion := ut.getDate + '_' + ut.getTime(): INDEPENDENT	;

rJustSentEmail := RECORD
  UNSIGNED4 providerID := raidsEmail.providerID;
  STRING filename := raidsEmail.raidsStatsRec[1].fileName;
	STRING emailAddress := raidsEmail.emailAddress;
  STRING periodicity := raidsEmail.periodicity;
	STRING data_provider_name:= raidsEmail.data_provider_name;
	STRING sent_date_time := fVersion;
END;
raidsJustSentEmail := TABLE(raidsEmail, rJustSentEmail);

newRaidsStatsSent := raidsStatsSent + raidsJustSentEmail;

ut.MAC_SF_BuildProcess(newRaidsStatsSent,raidsStatsSentSF, saveEmailSent ,2,,true,pVersion:=fversion);

rReturn := if (COUNT(raidsEmail) > 0,
               SEQUENTIAL(sentEmail, saveEmailSent),
							 sendEmailNoReport); 			 

return rReturn;

END;

END;
