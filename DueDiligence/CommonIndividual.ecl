IMPORT DueDiligence, iesp, STD, ut;

EXPORT CommonIndividual := MODULE

	
	EXPORT getRelationship(inquiredInd, dsNameFromInquiredInd, relationToInquired) := FUNCTIONMACRO
  
    relationship := NORMALIZE(inquiredInd, LEFT.dsNameFromInquiredInd, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                                                            SELF.seq := LEFT.seq;
                                                                            SELF.inquiredDID := LEFT.individual.did;
                                                                            SELF.historyDate := LEFT.historyDate;
                                                                            SELF.historyDateRaw := LEFT.historyDateRaw;
                                                                            SELF.individual := RIGHT;
                                                                            SELF.indvType := relationToInquired;
                                                                            SELF := [];));
		
		RETURN relationship;
	ENDMACRO;
    
  
  EXPORT calcCrimData(dataRow, offenderLevelIn, offenseScoreIn, daysLookupSymbol) := FUNCTIONMACRO
  
    dataType := STD.Str.ToUpperCase(#GETDATATYPE(offenseScoreIn));
    offenseOperator := IF(STD.Str.StartsWith(dataType, 'STRING'), '=', ' IN ');
        
    #if(daysLookupSymbol = DueDiligence.Constants.EMPTY)
       val := (INTEGER)(dataRow.criminalOffenderLevel = offenderLevelIn AND
                           dataRow.offenseScore #EXPAND(offenseOperator) offenseScoreIn);
    #else
       val := (INTEGER)(dataRow.criminalOffenderLevel = offenderLevelIn AND
                        dataRow.offenseScore #EXPAND(offenseOperator) offenseScoreIn AND
                       (dataRow.NumOfDaysAgo #EXPAND(daysLookupSymbol) ut.DaysInNYears(DueDiligence.Constants.YEARS_TO_LOOK_BACK)));
    #end
         
         
    RETURN val;
  ENDMACRO;

  EXPORT CreateRelatedPartyDataset(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
  //Need to convert the inquuired individual into a dataset in order to re-use modules created for indivuals and Business executives
    indivRelatedParty := PROJECT(inData, TRANSFORM({DATASET(DueDiligence.LayoutsInternal.RelatedParty) inquiredDS},
                                                    SELF.inquiredDS := PROJECT(LEFT, TRANSFORM(DueDiligence.LayoutsInternal.RelatedParty, 
                                                                                             SELF.seq := LEFT.seq;
                                                                                             SELF.did := LEFT.inquiredDID;
                                                                                             SELF.party := LEFT.individual;
                                                                                             SELF := LEFT;
                                                                                             SELF := [];));
                                                    SELF := [];));

  RETURN indivRelatedParty.inquiredDS;

  END;  //END OF FUNCTION

END;  //END OF MODULE