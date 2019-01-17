IMPORT EmailService, Header, Relationship, doxie, Doxie_Raw, AutoHeaderI, AutoHeaderV2, AutoStandardI;

EXPORT Functions := MODULE


  SHARED GetRelationDescription (STRING _type, UNSIGNED _title, 
                          DATASET(Relationship.layout_output.relTypeRec) rel_sources,
                          UNSIGNED other_lexid = 0,
                          UNSIGNED subj_lexid = 0) := FUNCTION 

    fltrd_sources := rel_sources(~EmailService.Constants.isRestrictedRelationSource(rel_type));

    _source := SORT(fltrd_sources, -score, -cnt, rel_type)[1].rel_type;

    rel_desc := MAP( _title > 0 AND _title <= Header.relative_titles.num_relative  // all relatives
                    OR _title = Header.relative_titles.num_Neighbor
                            => EmailService.Constants.RelationshipPrefix +
                                    Header.relative_titles.fn_get_str_title(_title), 
                    _type <> '' AND  _source<>'' // for relations other than relatives   
                            => Relationship.Constants.getRelationSourceDescription(_source),
                    subj_lexid>0 AND other_lexid = subj_lexid 
                            => EmailService.Constants.PossibleSubject,
                    '');
    RETURN rel_desc;
  END;

  EXPORT GetRelationshipBySubjectLexId(DATASET(EmailService.Assorted_Layouts.layout_relationship) in_relat_pairs,
                                BOOLEAN include_2ndDegree_relatives = FALSE
                                ) := FUNCTION 
  
    // we are only interested to find subject relationships to identities with resolved Lexids other than subject
    posbl_subject_rels := DEDUP(PROJECT(in_relat_pairs(identity_lexID>0, subject_LexId>0, subject_LexId<>identity_lexID),
                          TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout,
                                    SELF.DID := LEFT.subject_LexId)),
                          ALL);
                           
                           
    has_possible_rels := EXISTS(posbl_subject_rels);
    subject_relat_pairs := IF(has_possible_rels, 
             Relationship.proc_GetRelationshipNeutral(posbl_subject_rels, 
                                           AllFlag := TRUE, 
                                           TopNCount := 0, 
                                           doAtmost := TRUE,
                                           HighConfidenceRelatives := TRUE,
                                           HighConfidenceAssociates := TRUE).result,
             DATASET([], Relationship.Layout_GetRelationship.interfaceOutputNeutral));


    // 2nd degree relatives
    relatives_dids := 	DEDUP(PROJECT(subject_relat_pairs(type = Relationship.Constants.PERSONAL AND 
                                             confidence = EmailService.Constants.HIGH AND 
                                             title <= Header.relative_titles.num_relative), 	// not considering associates for 2nd degree relatives
                          TRANSFORM(Relationship.layout_GetRelationship.DIDs_Layout,
                                    SELF.DID := LEFT.DID2;
                                    )), 
                        ALL);
                            
    second_degree_relatives :=  IF(include_2ndDegree_relatives AND EXISTS(relatives_dids), 
            Relationship.proc_GetRelationshipNeutral(relatives_dids, 
                                              RelativeFlag := TRUE,  // we only look for high confidence relatives here
                                              doAtmost := TRUE,
                                              HighConfidenceRelatives := TRUE).result,
            DATASET([], Relationship.Layout_GetRelationship.interfaceOutputNeutral));

    fltrd_2nd_rels := second_degree_relatives(type = Relationship.Constants.PERSONAL AND 
                                             confidence = EmailService.Constants.HIGH);
                                             
    second_degree_relatives_with_title := JOIN(subject_relat_pairs, fltrd_2nd_rels, 
	                      LEFT.did2 = RIGHT.did1,											
												TRANSFORM(Relationship.Layout_GetRelationship.interfaceOutputNeutral,
														SELF.did2 := RIGHT.did2,
														SELF.did1 := LEFT.did1,
														SELF.title := Doxie_Raw.Constants.GetSecondDegRelation(LEFT.title,RIGHT.title),
														SELF.TYPE := RIGHT.TYPE,
                            SELF := RIGHT)														
                        );
    // the above result might contain multiple records for same identity, we only need one                   
    secondDegree_relatives_dedup := DEDUP(SORT(second_degree_relatives_with_title, did1, did2, title, -total_score), did1, did2); 
    
    combined_subject_rels := subject_relat_pairs + IF(include_2ndDegree_relatives,secondDegree_relatives_dedup);

    email_recs_with_rel := JOIN(in_relat_pairs, combined_subject_rels, 
                                LEFT.identity_lexid = RIGHT.did2
                                AND LEFT.subject_lexId = RIGHT.did1,
                                TRANSFORM(EmailService.Assorted_Layouts.layout_relationship,
                                found_relationship := GetRelationDescription(RIGHT.type,RIGHT.title,RIGHT.rels, LEFT.identity_lexid,LEFT.subject_lexId);
                                SELF.relationship := IF(found_relationship <>'',found_relationship,LEFT.relationship);
                                SELF := LEFT
                                ),
                                LEFT OUTER, KEEP(1), LIMIT(0));
 
    res := IF(has_possible_rels, email_recs_with_rel, in_relat_pairs);

    //output(in_relat_pairs, named('in_relat_pairs'));
    //output(subject_relat_pairs, named('subject_relat_pairs'));
    //output(secondDegree_relatives, named('secondDegree_relatives'));
    //output(secondDegree_relatives_with_title, named('secondDegree_relatives_with_title'));
    //output(email_recs_with_rel, named('email_recs_with_rel'));

    RETURN res;
  END;

  EXPORT GetRelationshipInReverse(DATASET(EmailService.Assorted_Layouts.layout_relationship) in_rel_pairs
                                 ) := FUNCTION 
                                
    // attempt for not found relationship - using email identity Lexids to hit the relationship index instead of subject lexid
    unknown_rels := DEDUP(PROJECT(in_rel_pairs(relationship = '' OR relationship = EmailService.Constants.NoRelationship),
                                TRANSFORM(Relationship.Layout_GetRelationship.DIDs_pairs_layout, 
                                SELF.DID := IF(LEFT.identity_lexid>0 AND LEFT.identity_lexid<>LEFT.subject_LexId, LEFT.identity_lexid, SKIP),
                                SELF.DID2 := LEFT.subject_LexId)
                                ), ALL);
                                
    reverse_rels := Relationship.functions_getRelationship.convertFlatToNeutral(
                    PROJECT(Relationship.proc_GetRelationshipPairs(unknown_rels, 
                                    TopNCount := 0,
                                    AllFlag := TRUE,  doAtmost := TRUE,
                                    HighConfidenceRelatives := TRUE,
                                    HighConfidenceAssociates := TRUE).result, 
                           TRANSFORM(Relationship.layout_GetRelationship.InterfaceOutput_new, SELF:=LEFT, SELF:=[])));

    // since we look for relations in reverse we drop relatives as title would give reverse assocoation like parent instead of child
    fltrd_tx_rels := reverse_rels(title>=Header.relative_titles.num_relative);
    email_recs_with_rel2 := JOIN(in_rel_pairs, fltrd_tx_rels, 
                                 LEFT.identity_lexid = RIGHT.did1
                                 AND LEFT.subject_lexId = RIGHT.did2,
                                 TRANSFORM(EmailService.Assorted_Layouts.layout_relationship,
                                  found_relationship := GetRelationDescription(RIGHT.type,RIGHT.title,RIGHT.rels, LEFT.identity_lexid,LEFT.subject_lexId);
                                  SELF.relationship := IF(found_relationship <>'',found_relationship,LEFT.relationship);
                                  SELF := LEFT
                                 ),
                                 LEFT OUTER, KEEP(1), LIMIT(0));

    //output(reverse_rels, named('reverse_rels'));

    RETURN email_recs_with_rel2;
  END;
    
  EXPORT AddEmailRelationshipInfo (DATASET(EmailService.Assorted_Layouts.layout_search_out) email_recs, 
                                STRING in_email, 
                                UNSIGNED subject_LexId) := FUNCTION 
  
    // we keep only  email records matching input email
    inrecs_fltr := PROJECT(email_recs, TRANSFORM(EmailService.Assorted_Layouts.layout_search_out, 
                            ds_emails := LEFT.emails(clean_email = in_email);
                            SELF.emails := ds_emails,
                            SELF.relationship := IF(EXISTS(ds_emails), 
                                                   IF(LEFT.did = subject_LexId and subject_LexId>0,
                                                   EmailService.Constants.PossibleSubject,
                                                   EmailService.Constants.NoRelationship),  // default is No relationship or Association found
                                                   SKIP);  
                            SELF.subject_LexId := subject_LexId;
                            SELF := LEFT));


    // To establisg relationship using Lexid we are only interested in identities with resolved Lexid other than input subject 
    inrecs_for_rels := inrecs_fltr(DID>0 AND DID<>subject_LexId);
    possible_rel_pairs := PROJECT(inrecs_for_rels, 
                                  TRANSFORM(EmailService.Assorted_Layouts.layout_relationship,
                                            SELF.identity_lexID := LEFT.DID, 
                                            SELF.subject_lexId := subject_LexId,
                                            SELF.relationship := LEFT.relationship));


    rels_by_subject_lexid := GetRelationshipBySubjectLexId(possible_rel_pairs, include_2ndDegree_relatives:=TRUE);
    
    rels_by_lexid := IF(EXISTS(rels_by_subject_lexid(relationship = EmailService.Constants.NoRelationship, subject_lexId>0, identity_lexid>0)),
              GetRelationshipInReverse(rels_by_subject_lexid), // we attempt to hit relationship index using Lexids in reverse - in some cases relationship is available in 1 direction only in index
              rels_by_subject_lexid);
    
    email_recs_with_rels := JOIN(inrecs_fltr, rels_by_lexid, 
                                 LEFT.did = RIGHT.identity_LexID,
                                TRANSFORM(EmailService.Assorted_Layouts.layout_search_out,
                                  SELF.relationship := IF(RIGHT.relationship<>'', RIGHT.relationship, LEFT.relationship),
                                  SELF := LEFT
                                 ),
                                 LEFT OUTER, KEEP(1), LIMIT(0));
    
    all_enail_rels := IF(subject_LexId>0 AND EXISTS(possible_rel_pairs), email_recs_with_rels, inrecs_fltr);

    RETURN all_enail_rels;
  END;

  EXPORT  Get_Dids() := FUNCTION

    BOOLEAN forceLocal := TRUE;

    g_mod := AutoStandardI.GlobalModule();

    tempmod := MODULE(PROJECT(g_mod,AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt)) 
      EXPORT BOOLEAN useonlybestdid := TRUE;       
    END;

    // copy from global module to "extended" search interface; minimum translations are done here	
    ds_search := AutoHeaderV2.LIBCALL_conversions.GetPreprocessedInputDataset (tempmod);

    // library wrapper call
    search_code := AutoHeaderV2.Constants.SearchCode.NOFAIL;
	  dids := AutoHeaderV2.get_dids (ds_search, search_code, forceLocal);

    RETURN PROJECT (dids, doxie.layout_references);

  END;
END;