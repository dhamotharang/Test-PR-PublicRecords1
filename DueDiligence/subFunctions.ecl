IMPORT Address, BIPV2, Business_Header, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD, ut;

EXPORT subFunctions := MODULE


  EXPORT ProcessOffenses(DATASET(DueDiligence.LayoutsInternal.RelatedParty) allParties, DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) OffenseDataRolled) := FUNCTION
  
    calcTotals := PROJECT(OffenseDataRolled, TRANSFORM({UNSIGNED4 seq, UNSIGNED6 did, UNSIGNED4 HistoryDate, UNSIGNED4 DateToUse, UNSIGNED2 TotalEverIncarcerations, 
                                                                       UNSIGNED2 TotalCurrentIncarcerations, UNSIGNED2 TotalCurrentParoles, UNSIGNED2 TotalConvictedFelonies4F_OVERNYR, 
                                                                       UNSIGNED2 TotalConvictedFelonies4F_NY, UNSIGNED2 TotalConvictedFelonies4F_EVER, 
                                                                       UNSIGNED2 TotalConvictedUnknowns4U_OVERNYR, UNSIGNED2 TotalConvictedUnknowns4U_NY, 
                                                                       UNSIGNED2 TotalConvictedFelonies4U_EVER, UNSIGNED2 TotalConvictedMisdemeanor4M_OVERNYR, 
                                                                       UNSIGNED2 TotalConvictedMisdemeanor4M_NY, UNSIGNED2 TotalConvictedMisdemeanor4M_EVER, 
                                                                       UNSIGNED2 TotalNonConvictedFelonies3F_OVERNYR, UNSIGNED2 TotalNonConvictedFelonies3F_NY, 
                                                                       UNSIGNED2 TotalNonConvictedFelonies3F_EVER, UNSIGNED2 TotalNonConvictedUnknowns3U_OVERNYR, 
                                                                       UNSIGNED2 TotalNonConvictedUnknowns3U_NY, UNSIGNED2 TotalNonConvictedUnknowns3U_EVER, 
                                                                       UNSIGNED2 TotalNonConvictedMisdemeanor3M_OVERNYR, UNSIGNED2 TotalNonConvictedMisdemeanor3M_NY, 
                                                                       UNSIGNED2 TotalNonConvictedMisdemeanor3M_EVER, UNSIGNED2 TotalConvictedTraffic2T_OVERNYR, 
                                                                       UNSIGNED2 TotalConvictedTraffic2T_NY, UNSIGNED2 TotalConvictedTraffic2T_EVER, 
                                                                       UNSIGNED2 TotalConvictedInfractions2I_OVERNYR, UNSIGNED2 TotalConvictedInfractions2I_NY, 
                                                                       UNSIGNED2 TotalConvictedInfractions2I_EVER, UNSIGNED2 TotalOffensesThisDID, 
                                                                       UNSIGNED2 TotalHitsStateCrim, UNSIGNED2 TotalHitsTrafficInfraction},
                                                                      
                                                      SELF.TotalEverIncarcerations := (INTEGER)(LEFT.Ever_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                                LEFT.Ever_incarc_offenders = DueDiligence.Constants.YES OR
                                                                                                LEFT.Ever_incarc_Punishments = DueDiligence.Constants.YES); 
                                                                                                
                                                      SELF.TotalCurrentIncarcerations := (INTEGER)(LEFT.Curr_incarc_offenses  = DueDiligence.Constants.YES OR
                                                                                                   LEFT.Curr_incarc_offenders  = DueDiligence.Constants.YES OR
                                                                                                   LEFT.Curr_incarc_Punishments = DueDiligence.Constants.YES);
                                                                                                   
                                                      SELF.TotalCurrentParoles := (INTEGER)(LEFT.curr_parole_flag = DueDiligence.Constants.YES OR
                                                                                            LEFT.Curr_parole_Punishments = DueDiligence.Constants.YES);
                                                      
                                                      SELF.TotalConvictedFelonies4F_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, '>');
                                                      SELF.TotalConvictedFelonies4F_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, '<=');                                               
                                                      SELF.TotalConvictedFelonies4F_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.FELONY, DueDiligence.Constants.EMPTY);
                                                                                                      
                                                      SELF.TotalConvictedUnknowns4U_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '>');
                                                      SELF.TotalConvictedUnknowns4U_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '<=');
                                                      SELF.TotalConvictedFelonies4U_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, DueDiligence.Constants.EMPTY);
                                                                                                      
                                                      SELF.TotalConvictedMisdemeanor4M_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '>');
                                                      SELF.TotalConvictedMisdemeanor4M_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '<=');
                                                      SELF.TotalConvictedMisdemeanor4M_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_CONVICTED, DueDiligence.Constants.MISDEMEANOR, DueDiligence.Constants.EMPTY);
                                                                                                       
                                                      SELF.TotalNonConvictedFelonies3F_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, '>');
                                                      SELF.TotalNonConvictedFelonies3F_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, '<=');
                                                      SELF.TotalNonConvictedFelonies3F_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.FELONY, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalNonConvictedUnknowns3U_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '>');
                                                      SELF.TotalNonConvictedUnknowns3U_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, '<=');
                                                      SELF.TotalNonConvictedUnknowns3U_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.UNKNOWN_OFFENSES, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalNonConvictedMisdemeanor3M_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '>');
                                                      SELF.TotalNonConvictedMisdemeanor3M_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, '<=');
                                                      SELF.TotalNonConvictedMisdemeanor3M_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.NONTRAFFIC_NOT_CONVICTED, DueDiligence.Constants.MISDEMEANOR, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalConvictedTraffic2T_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, '>');
                                                      SELF.TotalConvictedTraffic2T_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, '<=');
                                                      SELF.TotalConvictedTraffic2T_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.TRAFFIC, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalConvictedInfractions2I_OVERNYR := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, '>');
                                                      SELF.TotalConvictedInfractions2I_NY := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, '<=');
                                                      SELF.TotalConvictedInfractions2I_EVER := DueDiligence.CommonIndividual.calcCrimData(LEFT, DueDiligence.Constants.TRAFFIC_CONVICTED, DueDiligence.Constants.INFRACTION, DueDiligence.Constants.EMPTY);
                                                      
                                                      SELF.TotalOffensesThisDID := 1;
                                                      SELF.TotalHitsStateCrim := (INTEGER)(SELF.TotalCurrentIncarcerations > 0 OR SELF.TotalCurrentParoles > 0 OR 
                                                                                           SELF.TotalConvictedFelonies4F_NY > 0 OR
                                                                                           SELF.TotalConvictedFelonies4F_OVERNYR > 0 OR
                                                                                           SELF.TotalEverIncarcerations > 0 OR
                                                                                           SELF.TotalConvictedUnknowns4U_NY >  0 OR
                                                                                           SELF.TotalConvictedMisdemeanor4M_NY > 0 OR
                                                                                           SELF.TotalConvictedUnknowns4U_OVERNYR > 0 OR
                                                                                           SELF.TotalConvictedMisdemeanor4M_OVERNYR > 0);
                                                                                  
                                                      SELF.TotalHitsTrafficInfraction := (INTEGER)(SELF.TotalConvictedTraffic2T_NY > 0 OR
                                                                                                   SELF.TotalConvictedInfractions2I_NY > 0 OR
                                                                                                   SELF.TotalConvictedTraffic2T_OVERNYR > 0 OR
                                                                                                   SELF.TotalConvictedInfractions2I_OVERNYR > 0);                           
                                                      
                                                      SELF := LEFT;
                                                      SELF := [];));
  
    sortCalcdTotals := SORT(calcTotals, seq, did);      
   
    rollTotals := ROLLUP(sortCalcdTotals,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                      
                                     SELF.TotalEverIncarcerations := LEFT.TotalEverIncarcerations + RIGHT.TotalEverIncarcerations;
                                     SELF.TotalCurrentIncarcerations := LEFT.TotalCurrentIncarcerations + RIGHT.TotalCurrentIncarcerations;
                                     SELF.TotalCurrentParoles := LEFT.TotalCurrentParoles + RIGHT.TotalCurrentParoles;
                                     
                                     SELF.TotalConvictedFelonies4F_OVERNYR := LEFT.TotalConvictedFelonies4F_OVERNYR + RIGHT.TotalConvictedFelonies4F_OVERNYR;
                                     SELF.TotalConvictedFelonies4F_NY := LEFT.TotalConvictedFelonies4F_NY + RIGHT.TotalConvictedFelonies4F_NY;                                               
                                     SELF.TotalConvictedFelonies4F_EVER := LEFT.TotalConvictedFelonies4F_EVER + RIGHT.TotalConvictedFelonies4F_EVER;
                                                                                     
                                     SELF.TotalConvictedUnknowns4U_OVERNYR := LEFT.TotalConvictedUnknowns4U_OVERNYR + RIGHT.TotalConvictedUnknowns4U_OVERNYR;
                                     SELF.TotalConvictedUnknowns4U_NY := LEFT.TotalConvictedUnknowns4U_NY + RIGHT.TotalConvictedUnknowns4U_NY;
                                     SELF.TotalConvictedFelonies4U_EVER := LEFT.TotalConvictedFelonies4U_EVER + RIGHT.TotalConvictedFelonies4U_EVER;
                                                                                     
                                     SELF.TotalConvictedMisdemeanor4M_OVERNYR := LEFT.TotalConvictedMisdemeanor4M_OVERNYR + RIGHT.TotalConvictedMisdemeanor4M_OVERNYR;
                                     SELF.TotalConvictedMisdemeanor4M_NY := LEFT.TotalConvictedMisdemeanor4M_NY + RIGHT.TotalConvictedMisdemeanor4M_NY;
                                     SELF.TotalConvictedMisdemeanor4M_EVER := LEFT.TotalConvictedMisdemeanor4M_EVER + RIGHT.TotalConvictedMisdemeanor4M_EVER;
                                                                                      
                                     SELF.TotalNonConvictedFelonies3F_OVERNYR := LEFT.TotalNonConvictedFelonies3F_OVERNYR + RIGHT.TotalNonConvictedFelonies3F_OVERNYR;
                                     SELF.TotalNonConvictedFelonies3F_NY := LEFT.TotalNonConvictedFelonies3F_NY + RIGHT.TotalNonConvictedFelonies3F_NY;
                                     SELF.TotalNonConvictedFelonies3F_EVER := LEFT.TotalNonConvictedFelonies3F_EVER + RIGHT.TotalNonConvictedFelonies3F_EVER;
                                     
                                     SELF.TotalNonConvictedUnknowns3U_OVERNYR := LEFT.TotalNonConvictedUnknowns3U_OVERNYR + RIGHT.TotalNonConvictedUnknowns3U_OVERNYR;
                                     SELF.TotalNonConvictedUnknowns3U_NY := LEFT.TotalNonConvictedUnknowns3U_NY + RIGHT.TotalNonConvictedUnknowns3U_NY;
                                     SELF.TotalNonConvictedUnknowns3U_EVER := LEFT.TotalNonConvictedUnknowns3U_EVER + RIGHT.TotalNonConvictedUnknowns3U_EVER;
                                     
                                     SELF.TotalNonConvictedMisdemeanor3M_OVERNYR := LEFT.TotalNonConvictedMisdemeanor3M_OVERNYR + RIGHT.TotalNonConvictedMisdemeanor3M_OVERNYR;
                                     SELF.TotalNonConvictedMisdemeanor3M_NY := LEFT.TotalNonConvictedMisdemeanor3M_NY + RIGHT.TotalNonConvictedMisdemeanor3M_NY;
                                     SELF.TotalNonConvictedMisdemeanor3M_EVER := LEFT.TotalNonConvictedMisdemeanor3M_EVER + RIGHT.TotalNonConvictedMisdemeanor3M_EVER;
                                     
                                     SELF.TotalConvictedTraffic2T_OVERNYR := LEFT.TotalConvictedTraffic2T_OVERNYR + RIGHT.TotalConvictedTraffic2T_OVERNYR;
                                     SELF.TotalConvictedTraffic2T_NY := LEFT.TotalConvictedTraffic2T_NY + RIGHT.TotalConvictedTraffic2T_NY;
                                     SELF.TotalConvictedTraffic2T_EVER := LEFT.TotalConvictedTraffic2T_EVER + RIGHT.TotalConvictedTraffic2T_EVER;
                                     
                                     SELF.TotalConvictedInfractions2I_OVERNYR := LEFT.TotalConvictedInfractions2I_OVERNYR + RIGHT.TotalConvictedInfractions2I_OVERNYR;
                                     SELF.TotalConvictedInfractions2I_NY := LEFT.TotalConvictedInfractions2I_NY + RIGHT.TotalConvictedInfractions2I_NY;
                                     SELF.TotalConvictedInfractions2I_EVER := LEFT.TotalConvictedInfractions2I_EVER + RIGHT.TotalConvictedInfractions2I_EVER;
                                     
                                     SELF.TotalOffensesThisDID := LEFT.TotalOffensesThisDID + RIGHT.TotalOffensesThisDID;
                                     SELF.TotalHitsStateCrim := LEFT.TotalHitsStateCrim + RIGHT.TotalHitsStateCrim;
                                     SELF.TotalHitsTrafficInfraction := LEFT.TotalHitsTrafficInfraction + RIGHT.TotalHitsTrafficInfraction;
                                     
                                     SELF := LEFT;));
                                     
    addAllParties := JOIN(allParties, rollTotals,
                          LEFT.seq = RIGHT.seq AND
                          LEFT.party.did = RIGHT.did,
                          TRANSFORM(RECORDOF(RIGHT),
                                    SELF.seq := LEFT.seq;
                                    SELF.did := LEFT.party.did;
                                    SELF := RIGHT;
                                    // SELF := LEFT.party;
                                    SELF := [];),
                          LEFT OUTER);
     
     
    RETURN addAllParties;
	END;

END;