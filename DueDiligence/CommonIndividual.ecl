IMPORT DueDiligence, iesp, Risk_Indicators, STD, ut;

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
  END;
  
  EXPORT GetIIDSSNFlags(DATASET(DueDiligence.Layouts.Indv_Internal) inData, STRING dataRestrictionMask,
                        UNSIGNED1 dppa, UNSIGNED1 glba, INTEGER bsVersion, UNSIGNED8 bsOptions) := FUNCTION
      
      
      exactMatchLevel := risk_indicators.iid_constants.default_ExactMatchLevel;
      
      ssnFlagsPrepSeq := PROJECT(inData, TRANSFORM(Risk_Indicators.Layout_output,
                                                    stringDate := (STRING)LEFT.historyDate;
                                                    SELF.seq := COUNTER;
                                                    SELF.account := (STRING)LEFT.seq;
                                                    SELF.historyDate := (UNSIGNED)stringDate[1..6];
                                                    SELF.did := LEFT.individual.did;
                                                    SELF.fname := LEFT.individual.firstName;
                                                    SELF.mname := LEFT.individual.middleName;
                                                    SELF.lname := LEFT.individual.lastName;
                                                    SELF.suffix := LEFT.individual.suffix;
                                                    SELF.dob := (STRING)LEFT.individual.dob;
                                                    SELF.phone10 := LEFT.individual.phone;
                                                    SELF.p_city_name := LEFT.individual.city;
                                                    SELF.st := LEFT.individual.state;
                                                    SELF.z5 := LEFT.individual.zip5;
                                                    SELF.lat := LEFT.individual.geo_lat;
                                                    SELF.long := LEFT.individual.geo_long;
                                                    SELF.addr_type := LEFT.individual.rec_type;
                                                    SELF.addr_status := LEFT.individual.err_stat;
                                                    SELF := LEFT.individual;
                                                    SELF := [];));	

      withSSNFlags := risk_indicators.iid_getSSNFlags(GROUP(ssnFlagsPrepseq, seq), dppa, glba, FALSE, TRUE, exactMatchLevel, dataRestrictionMask, bsVersion, bsOptions);	
		
      RETURN withSSNFlags;
  END;

END;  //END OF MODULE