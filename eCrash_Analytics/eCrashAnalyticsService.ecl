/*--SOAP--
<message name="eCrashAnalyticsService">
  <part name="AdminAnalyticsReportRequest" type="tns:XmlDataSet" cols="200" rows="20" />
  <part name="AdminAnalyticsReportResponse" type="tns:XmlDataSet" cols="200" rows="20" />
 </message>
*/
/*--INFO-- Ecrash Analytics service -- 
   Input:  iesp.adminanalytics.AdminAnalyticsReportRequest (xml)
   Output: iesp.adminanalytics.AdminAnalyticsReportResponse (xml)
*/

IMPORT _Control, ut, iesp, doxie, eCrash_Analytics;
EXPORT eCrashAnalyticsService() := FUNCTION

  Layout_EASRequest				:= iesp.adminanalytics.t_AdminAnalyticsReportRequest;
	Layout_EASResponse			:= iesp.adminanalytics.t_AdminAnalyticsReportResponse;
	
	EASRequest		:=	DATASET([], Layout_EASRequest) : STORED('AdminAnalyticsReportRequest', FEW);
	EASReq				:=	EASRequest[1]; 
	
	STRING 	InAgencyID 		:= EASReq.ReportBy.Agency;
	STRING1 InAgencyType 	:= EASReq.ReportBy.AgencyType;  //this will store either 1 = Beat level, 2 = Precinct Level, spaces = agency level report.
	STRING8 InBeginDate		:= (STRING4) EASReq.ReportBy.StartDate.Year + (STRING2) INTFORMAT(EASReq.ReportBy.StartDate.Month,2,1) + (STRING2) INTFORMAT(EASReq.ReportBy.StartDate.Day,2,1);
	STRING8 InEndDate			:= (STRING4) EASReq.ReportBy.EndDate.Year + (STRING2) INTFORMAT(EASReq.ReportBy.EndDate.Month,2,1) + (STRING2) INTFORMAT(EASReq.ReportBy.EndDate.Day,2,1);
	STRING2 InRptNbr			:= if(EASReq.Options.ReportNumber<>'',EASReq.Options.ReportNumber,'1');
	STRING  InSortSeq			:= EASReq.Options.SortSequence;
	INTEGER InStartPos		:= IF(EASReq.Options.StartingSequence > 0, EASReq.Options.StartingSequence, 1);
	INTEGER InRetCnt			:= IF(EASReq.Options.ReturnCount > 1 AND
	                            EASReq.Options.ReturnCount < eCrash_Analytics.Constants.MaxLayoutCnt, EASReq.Options.ReturnCount, 200);

	BuildRpt 	:= eCrash_Analytics.BuildReports(InAgencyID, InAgencyType, InBeginDate, InEndDate, InSortSeq);

// those reports commented out below are still under development and will go into as later phases to this project.       
  dsReport := CASE(InRptNbr, 
									'1'  => CASE(InAgencyType,                             //RPT1 = Accidents by Command at Agency Level, Beat Level or Precinct Level
															'1' => BuildRpt.RPT1ACBeatLvl,             //RPT1 = Accidents by Command at Beat Level.
															'2' => BuildRpt.RPT1ACPrecinctLvl, 				 //RPT1 = Accidents by Command at Precinct Level.
															       BuildRpt.RPT1ACAgencyLVL),          //RPT1 = Accidents by Command at Agency Level. 
									'2'  => CASE(InAgencyType,                             //RPT2 = Injuries by Command at Agency Level, Beat Level or Precinct Level.
															'1' => BuildRpt.RPT2ICBeatLvl,             //RPT2 = Injuries by Command at Beat Level.
															'2' => BuildRpt.RPT2ICPrecinctLvl,         //RPT2 = Injuries by Command at Precinct Level.
                                     BuildRpt.RPT2ICAgencyLvl),          //RPT2 = Injuries by Command at Agency Level.
									'3'  => CASE(InAgencyType,														 //RPT3 = Fatalities by Command at Agency Level, Beat Level or Precinct Level.
															'1' => BuildRpt.RPT3FCBeatLvl,             //RPT3 = Fatalities by Command at Beat Level.
															'2' => BuildRpt.RPT3FCPrecinctLvl,         //RPT3 = Fatalities by Command at Precinct Level.
                                    BuildRpt.RPT3FCAgencyLvl),
									'4'  => BuildRpt.RPT4ACDOW,														 //RPT4 = Accidents by Day Of Week.
									'5'  => BuildRpt.RPT5ICDOW,                            //RPT5 = Injuries by Day Of Week.
									'6'  => BuildRpt.RPT6FCDOW,                            //RPT6 = Fatalities by Day Of Week.
									'7'  => BuildRpt.RPT7ACHOD,                            //RPT7 = Accidents by Hour of Day.
									'8'  => BuildRpt.RPT8ICHOD,                            //RPT8 = Injuries by Hour Of Day.
									'9'  => BuildRpt.RPT9FCHOD,                            //RPT9 = Fatalities by Hour of Day.
									'10' => BuildRpt.RPT10ACMOY,                           //RPT10= Accidents by Month of Year.
									'11' => BuildRpt.RPT11ICMOY,                           //RPT11= Injuries by Month of Year.
									'12' => BuildRpt.RPT12FCMOY,                           //RPT12= Fatalities by Month of Year.
									'13' => BuildRpt.RPT13ACCollisionType,                  //RPT13= Accidents by Collision Type.
									'14' => BuildRpt.RPT14ACBySeverityByInter,           //RPT14= Accidents by Severity By Intersection.
									'15' => BuildRpt.RPT15ACByATByInter,                 //RPT15= Accidents by Accident Type By Intersection.
									'16' => BuildRpt.RPT16ACByTourByInter,               //RPT16= Accidents by Tour By Intersection.
									'17' => BuildRpt.RPT17ACByCTByInter,                 //RPT17= Accidents by Collision Type By Intersection
									'18' => BuildRpt.RPT18ACByDOWByInter                 //RPT18= Accidents by DayOfWeek By Intersection.
									);

  // CRU wants me to backfill records for Months, Days and Hours where we don't have any totals. They don't want gaps in the dataset being returned.
	// For example, if we don't have any counts for a "Monday" then I need to create an empty Monday record. This way they always get 8 records back for
	// days of the week plus the unknown record.
  dsBackfilled := eCrash_Analytics.Functions.InsertEmpties(InRptNbr, dsReport);

  // this will sort the file the myriad of ways that are requested by InSortSeq	
	dsSorted		:= eCrash_Analytics.Functions.SortData(dsBackfilled, InSortSeq, InRptNbr);
	
  //now, we add a counter to each of the records after the sort is complete. Don't know if we will ever need the counter but I thought it was a good
	//idea to include it.
	dsSortedWithCounter := eCrash_Analytics.Functions.AddCounter(dsSorted);
	
	TotalResults := COUNT(dsSortedWithCounter);
	
	dsPage := dsSortedWithCounter[InStartPos..InStartPos + (InRetCnt-1)];

  // now we populate the final output layout for the service.
	// OutReport := DATASET([eCrash_Analytics.LoadEspLayout(dsPage,InRptNbr,InAgencyID,TotalResults).LoadFinalLayout]);

// Next 2 lines added by Brad, and prior line removed on 9/8/13
	GrandTotals := eCrash_Analytics.Functions.ComputeGrandTotals(dsSortedWithCounter);
	OutReport := DATASET([eCrash_Analytics.LoadEspLayout(dsPage,InRptNbr,InAgencyID,TotalResults,GrandTotals).LoadFinalLayout]);
 
	RETURN OUTPUT(OutReport, NAMED('Results'));
END;