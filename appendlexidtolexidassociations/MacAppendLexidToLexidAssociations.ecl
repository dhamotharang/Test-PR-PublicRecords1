EXPORT MacAppendLexidToLexidAssociations(indata, Lexid1, Lexid2='', Prefix='Association', DegreeThreshold=2, IndexThreshold=20000000) := FUNCTIONMACRO
  IMPORT Relationship;
	IMPORT Relavator;
  IMPORT Header;
  LOCAL DistinctLexids := TABLE(PROJECT(indata((INTEGER)Lexid1 > 0 
  #IF(#TEXT(Lexid2)<>'')														
    AND (INTEGER)Lexid2 > 0
  #END),                
    TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, self.did := (INTEGER)LEFT.Lexid1)),
    {DID}, 
    DID, MERGE);

  LOCAL DistinctInputLexidAssociations := PROJECT(indata(
    (INTEGER)Lexid1 > 0 
    #IF(#TEXT(Lexid2)<>'')														
      AND (INTEGER)Lexid2 > 0
    #END), 
    TRANSFORM(Relationship.Layout_GetRelationship.DIDS_Pairs_layout, 
      self.did  := (INTEGER)LEFT.Lexid1,
      self.did2 := 
      #IF(#TEXT(Lexid2)<>'')														
        (INTEGER)LEFT.Lexid2
      #ELSE 
        0
      #END));
  
  // All Lexid Associations
  LOCAL MatchingLexidAssociationsFull := DISTRIBUTE(Relationship.proc_GetRelationship(DistinctLexids, 
    TRUE,   //RelativeFlag
    TRUE,   //AssociateFlag
    FALSE,  //AllFlag
    FALSE,  //TransactionalOnlyFlag
    500,    //MaxCount
    500,    //TopNCount
    TRUE,   //doSkip
    FALSE,  //doFail
    FALSE,  //doAtmost
    FALSE,  //sameLname
    0,      //minScore
    0,      //recentRelative
    ,       //person2
    FALSE,  //excludeTransClosure2
    FALSE,  //excludeInactives
    COUNT(DistinctLexids)>IndexThreshold //doThor
    ).result, HASH32(did1, did2));
  
  // Exact Lexid to Lexid Association Matches.
  LOCAL MatchingLexidAssociations:= DISTRIBUTE(Relationship.proc_GetRelationshipPairs(DistinctInputLexidAssociations,
    TRUE,   //RelativeFlag
    TRUE,   //AssociateFlag
    FALSE,  //AllFlag
    FALSE,  //TransactionalOnlyFlag
    500,    //MaxCount
    500,    //TopNCount
    TRUE,   //doSkip
    FALSE,  //doFail
    FALSE,  //doAtmost
    FALSE,  //sameLname
    0,      //minScore
    0,      //recentRelative
    FALSE,  //excludeTransClosure2
    FALSE,  //excludeInactives
    COUNT(DistinctInputLexidAssociations)>IndexThreshold //doThor
    ).result, HASH32(did1, did2));
	
  // First Degree Detail with the Degree column added.
  LOCAL FirstDegreeAssociations := SORT(DISTRIBUTE(PROJECT(
  #IF(#TEXT(Lexid2)<>'')			
	   MatchingLexidAssociations
  #ELSE
	   MatchingLexidAssociationsFull
	#END
      ,TRANSFORM({RECORDOF(LEFT), REAL Degree := 1}, SELF := LEFT)), HASH32(did1, did2)), did1, did2, degree, LOCAL);	

  // Second Degree Detail.  
	LOCAL InputwithoutMatchedFirstDegrees_SM := JOIN(DistinctInputLexidAssociations, FirstDegreeAssociations, LEFT.did=RIGHT.did1 AND LEFT.did2=RIGHT.did2, LEFT ONLY, LOOKUP, HASH);

	LOCAL InputwithoutMatchedFirstDegrees_LG := JOIN(DistinctInputLexidAssociations, FirstDegreeAssociations, LEFT.did=RIGHT.did1 AND LEFT.did2=RIGHT.did2, LEFT ONLY, HASH);
 	                 
  // Only combinations that haven't matched at the first degree.                   
  LOCAL InputwithoutMatchedFirstDegrees := IF(COUNT(FirstDegreeAssociations)<2000000,InputwithoutMatchedFirstDegrees_SM,InputwithoutMatchedFirstDegrees_LG);
  
  LOCAL PersonClusterSM := JOIN(
  
    #IF(#TEXT(Lexid2)<>'')														
  InputwithoutMatchedFirstDegrees
    #ELSE
  PROJECT(DistinctInputLexidAssociations, TRANSFORM(RECORDOF(InputwithoutMatchedFirstDegrees), SELF.did1 := LEFT.did, SELF := []))
    #END, 
    
  Relavator.Key_Person_Cluster_Degree, 
                          LEFT.did1=RIGHT.cluster_id 
  #IF(#TEXT(Lexid2)<>'')													
                          AND LEFT.did2=RIGHT.associated_did
  #END													
			  AND RIGHT.Degree_Key/100 <= DegreeThreshold,
                             TRANSFORM({RECORDOF(FirstDegreeAssociations)}, 
                               SELF.did1 := RIGHT.cluster_id,
                               SELF.did2 := RIGHT.associated_did,
                               SELF.Degree := RIGHT.Degree,
                               SELF := []), LIMIT(1000,SKIP));

  LOCAL PersonClusterLG := JOIN(
    #IF(#TEXT(Lexid2)<>'')														
  InputwithoutMatchedFirstDegrees
    #ELSE
  PROJECT(DistinctInputLexidAssociations, TRANSFORM(RECORDOF(InputwithoutMatchedFirstDegrees), SELF.did1 := LEFT.did, SELF := []))
    #END, 
  
  
  PULL(Relavator.Key_Person_Cluster_Degree(Degree_Key/100 <= DegreeThreshold)), 
                          LEFT.did1=RIGHT.cluster_id 
  #IF(#TEXT(Lexid2)<>'')													
                          AND LEFT.did2=RIGHT.associated_did
  #END													
                          ,
                             TRANSFORM({RECORDOF(FirstDegreeAssociations)},     
                               SELF.did1 := RIGHT.cluster_id,
                               SELF.did2 := RIGHT.associated_did,
                               SELF.Degree := RIGHT.Degree,
                               SELF := []), HASH, LIMIT(1000,SKIP)); // was smart but was croaking the platform.
  
  
  LOCAL SecondDegreeAssociations := SORT(DISTRIBUTE(MAP(COUNT(InputwithoutMatchedFirstDegrees)>IndexThreshold => PersonClusterLG, PersonClusterSM), HASH32(did1, did2)), did1, did2, degree, LOCAL);

  // Merged associations, deduping out   
//  FinalAssociations := MERGE([ FirstDegreeAssociations, SecondDegreeAssociations], SORTED(did1, did2),DEDUP, LOCAL);

  FinalAssociations := DEDUP(SORT(FirstDegreeAssociations + SecondDegreeAssociations, did1, did2, degree, LOCAL), did1, did2, LOCAL);
   
  // Join this back to the input.

  LOCAL RelativesRec := RECORD // Todo Switch this and the transform to use #EXPAND and implement the prefix.
	  RECORDOF(indata);
    #EXPAND('unsigned4 ' +  Prefix + 'AssociatedLexid');
    #EXPAND('string15 ' +  Prefix + 'Type');
    #EXPAND('string10 ' +  Prefix + 'confidence');
    #EXPAND('integer2 ' +  Prefix + 'CohabitScore');
    #EXPAND('integer2 ' +  Prefix + 'CohabitCount');
    #EXPAND('integer2 ' +  Prefix + 'CoApartmentScore');
    #EXPAND('integer2 ' +  Prefix + 'CoApartmentCount');
    #EXPAND('integer2 ' +  Prefix + 'CoPoBoxScore');
    #EXPAND('integer2 ' +  Prefix + 'CoPoBoxCount');
    #EXPAND('integer2 ' +  Prefix + 'CoSsnScore');
    #EXPAND('integer2 ' +  Prefix + 'CoSsnCount');
    #EXPAND('unsigned2 ' +  Prefix + 'TotalCount');
    #EXPAND('integer2 ' +  Prefix + 'TotalScore');
    #EXPAND('string10 ' +  Prefix + 'Cluster');
    #EXPAND('string2 ' +  Prefix + 'Generation');
    #EXPAND('unsigned4 ' +  Prefix + 'RelationshipDateFirstSeen');
    #EXPAND('unsigned4 ' +  Prefix + 'RelationshipDateLastSeen');
    #EXPAND('unsigned2 ' +  Prefix + 'OverlapMonths');
    #EXPAND('unsigned4 ' +  Prefix + 'DateFirstSeen');
    #EXPAND('unsigned4 ' +  Prefix + 'DateLastSeen');
    #EXPAND('unsigned2 ' +  Prefix + 'AgeFirstSeen');
    #EXPAND('boolean ' +  Prefix + 'Personal');
    #EXPAND('boolean ' +  Prefix + 'Business');
    #EXPAND('boolean ' +  Prefix + 'Other');
    #EXPAND('boolean ' +  Prefix + 'IsRelative');
    #EXPAND('boolean ' +  Prefix + 'IsAssociate');
    #EXPAND('boolean ' +  Prefix + 'IsBusiness');
    #EXPAND('REAL ' +  Prefix + 'Degree');
    #EXPAND('INTEGER1 ' +  Prefix + 'Hit');
    #EXPAND('INTEGER1 ' +  Prefix + 'RelationshipCode');
    #EXPAND('STRING ' +  Prefix + 'Relationship');
 END;

  LOCAL RelativesRec tRelatives(indata L, FinalAssociations R) := TRANSFORM 
    #EXPAND('SELF.' +  Prefix + 'AssociatedLexid := R.did2');
    #EXPAND('SELF.' +  Prefix + 'Type := R.type');
    #EXPAND('SELF.' +  Prefix + 'confidence := R.Confidence');
    #EXPAND('SELF.' +  Prefix + 'CohabitScore := R.cohabit_score');
    #EXPAND('SELF.' +  Prefix + 'CohabitCount := R.cohabit_cnt');
    #EXPAND('SELF.' +  Prefix + 'CoApartmentScore := R.coapt_score');
    #EXPAND('SELF.' +  Prefix + 'CoApartmentCount := R.coapt_cnt');
    #EXPAND('SELF.' +  Prefix + 'CoPoBoxScore := R.copobox_score');
    #EXPAND('SELF.' +  Prefix + 'CoPoBoxCount := R.copobox_cnt');
    #EXPAND('SELF.' +  Prefix + 'CoSsnScore := R.cossn_score');
    #EXPAND('SELF.' +  Prefix + 'CoSsnCount := R.cossn_cnt');
    #EXPAND('SELF.' +  Prefix + 'TotalCount := R.total_cnt');
    #EXPAND('SELF.' +  Prefix + 'TotalScore := R.total_score');
    #EXPAND('SELF.' +  Prefix + 'Cluster := R.cluster');
    #EXPAND('SELF.' +  Prefix + 'Generation := R.generation');
    #EXPAND('SELF.' +  Prefix + 'RelationshipDateFirstSeen := R.rel_dt_first_seen');
    #EXPAND('SELF.' +  Prefix + 'RelationshipDateLastSeen := R.rel_dt_last_seen');
    #EXPAND('SELF.' +  Prefix + 'OverlapMonths := R.overlap_months');
    #EXPAND('SELF.' +  Prefix + 'DateFirstSeen := R.hdr_dt_first_seen');
    #EXPAND('SELF.' +  Prefix + 'DateLastSeen := R.hdr_dt_last_seen');
    #EXPAND('SELF.' +  Prefix + 'AgeFirstSeen := R.age_first_seen');
    #EXPAND('SELF.' +  Prefix + 'Personal := R.personal');
    #EXPAND('SELF.' +  Prefix + 'Business := R.business');
    #EXPAND('SELF.' +  Prefix + 'Other := R.other');
    #EXPAND('SELF.' +  Prefix + 'IsRelative :=R.isrelative');
    #EXPAND('SELF.' +  Prefix + 'IsAssociate := R.isassociate');
    #EXPAND('SELF.' +  Prefix + 'IsBusiness := R.isbusiness');
    #EXPAND('SELF.' +  Prefix + 'Degree := R.Degree');
    #EXPAND('SELF.' +  Prefix + 'Hit := (INTEGER1)(R.did2 > 0)');
    #EXPAND('SELF.' +  Prefix + 'RelationshipCode := R.title');
    #EXPAND('SELF.' +  Prefix + 'Relationship := Header.relative_titles.fn_get_str_title(R.title)');
    SELF := L;
  END;

  // Append Prefixed Relationship columns back to input.
  LOCAL FinalOutput := JOIN(indata, FinalAssociations, (INTEGER)LEFT.LexId1=right.did1 
  #IF(#TEXT(Lexid2)<>'')														
	                                AND (INTEGER)LEFT.Lexid2=RIGHT.did2
  #END																	
																	,
                       tRelatives(LEFT,RIGHT), LEFT OUTER, 
                       SMART);

  RETURN FinalOutput;
ENDMACRO;