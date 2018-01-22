IMPORT Address, BIPV2, Business_Header, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD, ut;

EXPORT subFunctions := MODULE


EXPORT ProcessOffenses(DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) OffenseDataRolled) := FUNCTION
 
 
  	
		// ------                                                             ------
	  // ------  Summarize the Data up to the DID/Individual                ------
		// ------                                                             ------
		// ------  criminalOffenderLevel indicates convicted or non-convicted ------
		// ------   (4 and 2 are convicted, while 3 is non-convicted          ------
		// ------  and used in conjunction with offenseScore to indicate      ------
		// ------   the type of offenses                                      ------
		// ------   (F = FELONY, M = MISDEMEANOR, T = TRAFFIC, I = INFRACTIONS -----
		// ------                                                             ------
		SummaryOffensesFelony := table(OffenseDataRolled,
	                               /* columns in the table */  
	                              {seq, 
																 did, 
																 HistoryDate,
																 DateToUse,
                                   																 
																 TotalEverIncarcerations                                      := SUM(GROUP, (integer)(Ever_incarc_offenses  = DueDiligence.Constants.YES
																                                                                 OR Ever_incarc_offenders = DueDiligence.Constants.YES
																																																                                 OR Ever_incarc_Punishments = DueDiligence.Constants.YES)),																														 
                 TotalCurrentIncarcerations                                   := SUM(GROUP, (integer)(Curr_incarc_offenses  = DueDiligence.Constants.YES
																                                                                 OR Curr_incarc_offenders  = DueDiligence.Constants.YES
																																																                                 OR Curr_incarc_Punishments = DueDiligence.Constants.YES)),																																																 
																 TotalCurrentParoles                                          := SUM(GROUP, (integer)(curr_parole_flag = DueDiligence.Constants.YES
																                                                                 OR Curr_parole_Punishments = DueDiligence.Constants.YES)), 																																			
                                   																 
																 TotalConvictedFelonies4F_OVERNYR    /*4F Over n years */     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
		                                                                               AND  offenseScore = DueDiligence.Constants.FELONY  
																																		                                               AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																									 
																 TotalConvictedFelonies4F_NY    /*4F in last N# of years*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY  
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																 TotalConvictedFelonies4F_EVER    /*4F EVER*/                 := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED  
		                                                                               AND  offenseScore = DueDiligence.Constants.FELONY)),  																													
																																		 
																 TotalConvictedUnknowns4U_OVERNYR  /*4U Over N years */       := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedUnknowns4U_NY    /*4U in last N# of years*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedFelonies4U_EVER  /*4U EVER*/   								        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES)),  			 
																																										 
																 TotalConvictedMisdemeanor4M_OVERNYR /*4M*/                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedMisdemeanor4M_NY /*4M*/                        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																 TotalConvictedMisdemeanor4M_EVER  /*4M EVER*/   						        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR)), 
																																																
																TotalNonConvictedFelonies3F_OVERNYR /*3F  */                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY
                                                                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedFelonies3F_NY /*3F in last N# of years*/     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedFelonies3F_EVER /*3F EVER*/                  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.FELONY)), 
																																																  																																					
																TotalNonConvictedUnknowns3U_OVERNYR /*3U  */                  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																TotalNonConvictedUnknowns3U_NY /*3U in last N# of years*/     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedUnknowns3U_EVER/*3U EVER*/                   := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore IN DueDiligence.Constants.UNKNOWN_OFFENSES)), 
	 
																TotalNonConvictedMisdemeanor3M_OVERNYR /*3M in last year*/    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
																TotalNonConvictedMisdemeanor3M_NY /*3M in last N# of years*/  := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																 
															  TotalNonConvictedMisdemeanor3M_EVER /*3M EVER*/               := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.MISDEMEANOR)),
																																																 
																TotalConvictedTraffic2T_OVERNYR     /*2T*/                     := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																
																TotalConvictedTraffic2T_NY     /*2T*/                         := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC
																																															 	                                AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																
																TotalConvictedTraffic2T_EVER     /*2T*/                       := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.TRAFFIC)),
																																															 	                                
																																																																															
																TotalConvictedInfractions2I_OVERNYR /*2I*/                    := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION
																																																                                 AND  NumOfDaysAgo > ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																
																TotalConvictedInfractions2I_NY  /*2I*/                        := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION
																																																                                 AND  NumOfDaysAgo <= ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK))),
																																																																 
																TotalConvictedInfractions2I_EVER  /*2I*/                      := SUM(GROUP, (integer)(criminalOffenderLevel = DueDiligence.Constants.TRAFFIC_CONVICTED
																                                                                 AND  offenseScore = DueDiligence.Constants.INFRACTION)),
																																																                                 
																																																
															  /*  Calculate the TOTAL of all OFFENSES for this DID  */   
																TotalOffensesThisDID                                          := COUNT(GROUP) 
				
															  /*end of columns in the table */ },
																/* Grouped by */  
																seq, did);
		
		
		 																																													 
			  																																														 
		// OUTPUT(SummaryOffensesFelony,        NAMED('SummaryOffensesFelony'));

  RETURN SummaryOffensesFelony;
	END;





END;