IMPORT $, doxie_raw, Header, ut, Relationship;

EXPORT Get_DID_Associations(DATASET($.Layouts.RelDetailsIn) dSubjDIDs,
                            $.iParam.RelDetails             inMod,
                            BOOLEAN                         calculateDIDAssociations = FALSE,
                            DATASET($.Layouts.RelDetailsIn) dDIDsOfInterest          = DATASET([],$.Layouts.RelDetailsIn)) :=
FUNCTION
  // Relatives layout
  relativeLayout := Relationship.layout_GetRelationship.interfaceOutputNeutral;

  // Common transforms
  // First degree relatives and associates
  $.Layouts.RelDetailsTemp tRelsAssocFirstDeg($.Layouts.RelDetailsIn le,relativeLayout ri,INTEGER depth) :=
  TRANSFORM
    SELF.seq             := le.seq;
    SELF.src_did         := le.did;
    SELF.depth           := depth;
    SELF.person1         := ri.did1;
    SELF.person2         := ri.did2;
    SELF.recent_cohabit  := ri.rel_dt_last_seen;
    SELF.number_cohabits := ri.total_score;
    SELF.prim_range      := ri.source_type;
    SELF                 := ri;
  END;

  // Second and third degree relatives
  $.Layouts.RelDetailsTemp tRels($.Layouts.RelDetailsTemp le,relativeLayout ri,INTEGER depth) :=
  TRANSFORM
    SELF.depth           := depth;
    SELF.title           := Doxie_Raw.Constants.GetSecondDegRelation(le.title,ri.title);
    SELF.person1         := ri.did1;
    SELF.person2         := ri.did2;
    SELF.recent_cohabit  := ri.rel_dt_last_seen / 100;
    SELF.number_cohabits := MAX(ri.total_score / 5, 6);  // Calculate num cohabits based on new rule from relative fab team
    SELF.prim_range      := ri.source_type;
    SELF                 := ri;
    SELF                 := le;
  END;

  // Rollup siblings from second and third degree relatives
  $.Layouts.RelDetailsTemp tRollupSiblings($.Layouts.RelDetailsTemp le,$.Layouts.RelDetailsTemp ri) :=
  TRANSFORM
    SELF.title := IF(le.title NOT IN [Header.relative_titles.num_Relative,Header.relative_titles.num_Associate],le.title,ri.title);
    SELF       := le;
  END;

  dSubjDIDsFilter := dSubjDIDs(did > 0);

  // Create a dataset which contains the subject and person of interest in the same record
  $.Layouts.DIDsOfIntWSubj tDIDsOfIntWSubj($.Layouts.RelDetailsIn le,$.Layouts.RelDetailsIn ri) :=
  TRANSFORM
    SELF.seq     := le.seq;
    SELF.src_did := le.did;
    SELF.did     := ri.did;
  END;

  dDIDsOfIntWSubj := JOIN(dSubjDIDsFilter,dDIDsOfInterest,
                          LEFT.seq = RIGHT.seq,
                          tDIDsOfIntWSubj(LEFT,RIGHT),
                          LEFT OUTER,
                          ATMOST(1000));

  // First degree relatives
  fdeg_dids := PROJECT(dSubjDIDsFilter,TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := []));

  fdeg_recs := Relationship.proc_GetRelationshipNeutral(fdeg_dids,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result;
  dRelsFirstDeg := JOIN(dSubjDIDsFilter,fdeg_recs,
                        LEFT.did = RIGHT.did1 and RIGHT.isRelative,
                        tRelsAssocFirstDeg(LEFT,RIGHT,1));

  // Flag records where we found a match in dids_of_interest
  $.Layouts.RelDetailsTemp tDIDsOfIntFirstDeg($.Layouts.DIDsOfIntWSubj le,$.Layouts.RelDetailsTemp ri) :=
  TRANSFORM
    SELF.seq                   := le.seq;
    SELF.src_did               := le.src_did;
    SELF.did_of_interest       := le.did;
    SELF.found_did_of_interest := (le.did = ri.person2);
    SELF                       := ri;
  END;

  dDIDsOfIntFirstDeg := JOIN(dDIDsOfIntWSubj,dRelsFirstDeg,
                              LEFT.seq = RIGHT.seq and
                              LEFT.did = RIGHT.person2,
                              tDIDsOfIntFirstDeg(LEFT,RIGHT),
                              LEFT OUTER,
                              LIMIT(0),KEEP(1));

  // Sort and assign a sequence in order of best first degree relatives
  dRelsFirstDegOfInterst := IF(calculateDIDAssociations,dDIDsOfIntFirstDeg(found_did_of_interest),dRelsFirstDeg);

  dRelsFirstDegGrp  := GROUP(SORT(dRelsFirstDegOfInterst,seq,-number_cohabits,-recent_cohabit,-isRelative,person1),seq);
  dRelsFirstDegSort := PROJECT(dRelsFirstDegGrp,
                                TRANSFORM($.Layouts.RelDetailsTemp,SELF.p2_sort := COUNTER,SELF := LEFT));

  // Search for more relatives since we didn't find the relationship for all the associated DIDs
  // and eliminate groups where we found all the persons of interest
  dDIDsOfIntLookForMore_1 := JOIN(dDIDsOfIntFirstDeg(~found_did_of_interest),
                                  dRelsFirstDeg,
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM(RIGHT));

  // Find more relatives since we didn't reach the max limit specified for relatives
  dRelsFirstDegLookForMore := IF(calculateDIDAssociations,
                                  dDIDsOfIntLookForMore_1,
                                  UNGROUP(HAVING(dRelsFirstDegSort,COUNT(ROWS(LEFT)) < inMod.MaxRelatives)));

  // Second degree relatives
  sdeg_dids := PROJECT(dRelsFirstDegLookForMore,TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := []));

  sdeg_recs := Relationship.proc_GetRelationshipNeutral(sdeg_dids,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result;
  dRelsSecondDeg := JOIN(dRelsFirstDegLookForMore,sdeg_recs,
                        LEFT.person2 = RIGHT.did1 and RIGHT.isRelative,
                        tRels(LEFT,RIGHT,2));

  // Rollup - to remove the same person related with multiple second degree siblings and keep the closest specific relationship
  dRelsSecondDegDedup := ROLLUP(SORT(dRelsSecondDeg,seq,person2,-number_cohabits,-recent_cohabit,-isRelative,person1),
                                LEFT.seq     = RIGHT.seq and
                                LEFT.person2 = RIGHT.person2,
                                tRollupSiblings(LEFT,RIGHT));

  // Remove subject and first degree relatives
  dRelsSecondDegRemoveSubj := JOIN(dRelsSecondDegDedup,
                                    dRelsFirstDeg,
                                    LEFT.person2 = RIGHT.person1,
                                    LEFT ONLY);

  dRelsSecondDegOnly := JOIN(dRelsSecondDegRemoveSubj,
                              dRelsFirstDeg,
                              LEFT.person2 = RIGHT.person2,
                              LEFT ONLY);

  // Flag records where we found a match in dids_of_interest
  $.Layouts.RelDetailsTemp tDIDsOfIntSecondDeg($.Layouts.RelDetailsTemp le,$.Layouts.RelDetailsTemp ri) :=
  TRANSFORM
    SELF.seq                   := le.seq;
    SELF.src_did               := le.src_did;
    SELF.did_of_interest       := le.did_of_interest;
    SELF.found_did_of_interest := (le.did_of_interest = ri.person2);
    SELF                       := ri;
  END;

  dDIDsOfIntSecondDeg := JOIN(dDIDsOfIntFirstDeg(~found_did_of_interest),dRelsSecondDegOnly,
                              LEFT.seq = RIGHT.seq and
                              LEFT.did_of_interest = RIGHT.person2,
                              tDIDsOfIntSecondDeg(LEFT,RIGHT),
                              LEFT OUTER,
                              LIMIT(0),KEEP(1));

  // Sort and assign a sequence in order of best second degree relatives
  dRelsSecondDegOfInterst := IF(calculateDIDAssociations,dDIDsOfIntSecondDeg(found_did_of_interest),dRelsSecondDegOnly);

  dRelsSecondDegGrp  := GROUP(SORT(dRelsSecondDegOfInterst,seq,-number_cohabits,-recent_cohabit,-isRelative,person1),seq);
  dRelsSecondDegSort := PROJECT(dRelsSecondDegGrp,
                                TRANSFORM($.Layouts.RelDetailsTemp,SELF.p3_sort := COUNTER,SELF := LEFT));

  // Search for more relatives since we didn't find the relationship for all the associated DIDs
  dDIDsOfIntLookForMore_2 := JOIN(dDIDsOfIntSecondDeg(~found_did_of_interest),
                                  dRelsSecondDegOnly,
                                  LEFT.seq = RIGHT.seq,
                                  TRANSFORM(RIGHT));

  // Find more relatives since we didn't reach the max limit specified for relatives
  dRelsSecondDegLookForMore := IF(calculateDIDAssociations,
                                  dDIDsOfIntLookForMore_2,
                                  UNGROUP(HAVING(dRelsSecondDegGrp,COUNT(ROWS(LEFT)) < inMod.MaxRelatives)));

  // Third degree relatives
  tdeg_dids := PROJECT(dRelsSecondDegLookForMore,TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout,SELF:=LEFT,SELF := []));
  // Proc params set to only return relatives and not associates.
  tdeg_recs := Relationship.proc_GetRelationshipNeutral(tdeg_dids,TRUE,TRUE,FALSE,FALSE,ut.limits.RELATIVES_PER_PERSON,,TRUE).result;
  dRelsThirdDeg := JOIN(dRelsSecondDegLookForMore,tdeg_recs,
                        LEFT.person2 = RIGHT.did1 and RIGHT.isRelative,
                        tRels(LEFT,RIGHT,3));

  // Rollup - to remove the same person related with multiple third degree siblings
  dRelsThirdDegDedup := ROLLUP(SORT(dRelsThirdDeg,seq,person2,-number_cohabits,-recent_cohabit,-isRelative,person1),
                                LEFT.seq     = RIGHT.seq and
                                LEFT.person2 = RIGHT.person2,
                                tRollupSiblings(LEFT,RIGHT));

  // Remove subject, first and second degree relatives
  dRelsThirdDegRemoveSubj := JOIN(dRelsThirdDegDedup,
                                  dRelsFirstDeg,
                                  LEFT.person2 = RIGHT.person1,
                                  LEFT ONLY);

  dRelsThirdDegRemoveFirstDeg := JOIN(dRelsThirdDegRemoveSubj,
                                      dRelsFirstDeg,
                                      LEFT.person2 = RIGHT.person2,
                                      LEFT ONLY);

  dRelsThirdDegOnly := JOIN(dRelsThirdDegRemoveFirstDeg,
                            dRelsSecondDegOnly,
                            LEFT.person2 = RIGHT.person2,
                            LEFT ONLY);

  // Flag records where we found a match in dids_of_interest
  $.Layouts.RelDetailsTemp tDIDsOfIntThirdDeg($.Layouts.RelDetailsTemp le,$.Layouts.RelDetailsTemp ri) :=
  TRANSFORM
    SELF.seq                   := le.seq;
    SELF.src_did               := le.src_did;
    SELF.did_of_interest       := le.did_of_interest;
    SELF.found_did_of_interest := (le.did_of_interest = ri.person2);
    SELF                       := ri;
  END;

  dDIDsOfIntThirdDeg := JOIN(dDIDsOfIntSecondDeg(~found_did_of_interest),dRelsThirdDegOnly,
                              LEFT.seq = RIGHT.seq and
                              LEFT.did_of_interest = RIGHT.person2,
                              tDIDsOfIntThirdDeg(LEFT,RIGHT),
                              LEFT OUTER,
                              LIMIT(0),KEEP(1));

  // Sort and assign a sequence in order of best third degree relatives
  dRelsThirdDegOfInterst := IF(calculateDIDAssociations,dDIDsOfIntThirdDeg(found_did_of_interest),dRelsThirdDegOnly);

  dRelsThirdDegGrp  := GROUP(SORT(dRelsThirdDegOfInterst,seq,-number_cohabits,-recent_cohabit,-isRelative,person1),seq);
  dRelsThirdDegSort := PROJECT(dRelsThirdDegGrp,
                                TRANSFORM($.Layouts.RelDetailsTemp,SELF.p4_sort := COUNTER,SELF := LEFT));

  // Associates - we need only for first degree
  dAssocs := JOIN(dSubjDIDsFilter,fdeg_recs,
                        LEFT.did = RIGHT.did1 and NOT RIGHT.isRelative,
                        tRelsAssocFirstDeg(LEFT,RIGHT,1));

  // Search for associates since we didn't find the relationship for all the persons of interest
  $.Layouts.RelDetailsTemp tDIDsOfIntAssocs($.Layouts.RelDetailsTemp le,$.Layouts.RelDetailsTemp ri) :=
  TRANSFORM
    SELF.seq                   := le.seq;
    SELF.src_did               := le.src_did;
    SELF.did_of_interest       := le.did_of_interest;
    SELF.found_did_of_interest := (le.did_of_interest = ri.person2);
    SELF                       := ri;
  END;

  dDIDsOfIntAsocs := JOIN(dDIDsOfIntThirdDeg(~found_did_of_interest),dAssocs,
                          LEFT.seq = RIGHT.seq and
                          LEFT.did_of_interest = RIGHT.person2,
                          tDIDsOfIntAssocs(LEFT,RIGHT),
                          LEFT OUTER,
                          LIMIT(0),KEEP(1));

  // Sort and assign a sequence in order of best first degree associates
  dAssocsOfInterst := IF(calculateDIDAssociations,dDIDsOfIntAsocs(found_did_of_interest),dAssocs);

  dAssocsGrp  := GROUP(SORT(dAssocsOfInterst,seq,-number_cohabits,-recent_cohabit,-isRelative,person1),seq);
  dAssocsSort := PROJECT(dAssocsGrp,
                          TRANSFORM($.Layouts.RelDetailsTemp,SELF.p2_sort := COUNTER,SELF := LEFT));

  // Combine all relatives
  dRelDetails := dRelsFirstDegSort + IF(inMod.RelativeDepth > 1,dRelsSecondDegSort) + IF(inMod.RelativeDepth > 2,dRelsThirdDegSort);

  // Relatives + Associates
  dRelAssocs := IF(inMod.IncludeRelatives,dRelDetails) + IF(inMod.IncludeAssociates,dAssocsSort);

  // Input records where we didn't find any relatives
  dSubjDIDsNoRels := JOIN(dDIDsOfIntWSubj,dRelAssocs,
                          LEFT.seq = RIGHT.seq,
                          TRANSFORM($.Layouts.RelDetailsOut,SELF.person2 := LEFT.did,SELF := LEFT,SELF := []),
                          LEFT ONLY);

  dDIDsOfIntNoRels := JOIN(dDIDsOfIntWSubj,dRelAssocs,
                            LEFT.seq = RIGHT.seq and
                            LEFT.did = RIGHT.person2,
                            TRANSFORM($.Layouts.RelDetailsOut,SELF.person2 := LEFT.did,SELF := LEFT,SELF := []),
                            LEFT ONLY);

  // Output all the records irrespective whether we found relatives or not
  dAllRelAssocs := IF(calculateDIDAssociations,dDIDsOfIntNoRels,dSubjDIDsNoRels) +
                    PROJECT(dRelAssocs,
                            TRANSFORM($.Layouts.RelDetailsOut,
                                      SELF.title := Header.relative_titles.fn_get_str_title(LEFT.title),
                                      SELF       := LEFT));

  dAllRelAssocsDedup := DEDUP(SORT(dAllRelAssocs(title != ''),seq,person2,isRelative,depth,p2_sort,p3_sort,p4_sort),seq,person2);

  dOut := SORT(dAllRelAssocsDedup,seq,isRelative,depth,p2_sort,p3_sort,p4_sort);

  #IF(Doxie_Raw.Constants.Debug)
    OUTPUT(dDIDsOfIntWSubj,NAMED('dDIDsOfIntWSubj'));
    OUTPUT(dRelsFirstDeg,NAMED('dRelsFirstDeg'));
    OUTPUT(dDIDsOfIntFirstDeg,NAMED('dDIDsOfIntFirstDeg'));
    OUTPUT(dRelsFirstDegSort,NAMED('dRelsFirstDegSort'));
    OUTPUT(dDIDsOfIntLookForMore_1,NAMED('dDIDsOfIntLookForMore_1'));
    OUTPUT(dRelsFirstDegLookForMore,NAMED('dRelsFirstDegLookForMore'));
    OUTPUT(dRelsSecondDeg,NAMED('dRelsSecondDeg'));
    OUTPUT(dRelsSecondDegDedup,NAMED('dRelsSecondDegDedup'));
    OUTPUT(dRelsSecondDegRemoveSubj,NAMED('dRelsSecondDegRemoveSubj'));
    OUTPUT(dRelsSecondDegOnly,NAMED('dRelsSecondDegOnly'));
    OUTPUT(dDIDsOfIntSecondDeg,NAMED('dDIDsOfIntSecondDeg'));
    OUTPUT(dDIDsOfIntLookForMore_2,NAMED('dDIDsOfIntLookForMore_2'));
    OUTPUT(dRelsSecondDegLookForMore,NAMED('dRelsSecondDegLookForMore'));
    OUTPUT(dRelsSecondDegSort,NAMED('dRelsSecondDegSort'));
    OUTPUT(dRelsThirdDeg,NAMED('dRelsThirdDeg'));
    OUTPUT(dRelsThirdDegDedup,NAMED('dRelsThirdDegDedup'));
    OUTPUT(dRelsThirdDegRemoveSubj,NAMED('dRelsThirdDegRemoveSubj'));
    OUTPUT(dRelsThirdDegRemoveFirstDeg,NAMED('dRelsThirdDegRemoveFirstDeg'));
    OUTPUT(dRelsThirdDegOnly,NAMED('dRelsThirdDegOnly'));
    OUTPUT(dDIDsOfIntThirdDeg,NAMED('dDIDsOfIntThirdDeg'));
    OUTPUT(dRelsThirdDegSort,NAMED('dRelsThirdDegSort'));
    OUTPUT(dAssocs,NAMED('dAssocs'));
    OUTPUT(dDIDsOfIntAsocs,NAMED('dDIDsOfIntAsocs'));
    OUTPUT(dAssocsSort,NAMED('dAssocsSort'));
    OUTPUT(dRelDetails,NAMED('dRelDetails'));
    OUTPUT(dRelAssocs,NAMED('dRelAssocs'));
    OUTPUT(dSubjDIDsNoRels,NAMED('dSubjDIDsNoRels'));
    OUTPUT(dAllRelAssocs,NAMED('dAllRelAssocs'));
    OUTPUT(dAllRelAssocsDedup,NAMED('dAllRelAssocsDedup'));
    OUTPUT(dOut,NAMED('dOut'));
  #END

  RETURN dOut;
END;
