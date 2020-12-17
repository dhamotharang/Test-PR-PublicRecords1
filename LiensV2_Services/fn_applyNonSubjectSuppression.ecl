IMPORT FCRA, Suppress;

// Handle non_subject suppression
EXPORT fn_applyNonSubjectSuppression(DATASET(liensv2_services.layout_lien_rollup) raw_rec,
                                     DATASET(LiensV2_Services.layout_ids) rec_in,
                                     INTEGER1 non_subject_suppression) := FUNCTION
  
  liensv2_services.layout_lien_party xformParty(liensv2_services.layout_lien_party L,
                                                UNSIGNED6 subject_did) := TRANSFORM,
    SKIP(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank
          AND NOT EXISTS(L.parsed_parties((UNSIGNED6)did = subject_did OR (bdid <> '' OR cname <> ''))))
    //blanking orig_name if return subject only
    SELF.orig_name := MAP(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.doNothing => L.orig_name,
                               non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => L.orig_name,
                                '');
    //suppressing debtors that are not the subject searched on and are not a company
    party_supp := PROJECT(L.parsed_parties((UNSIGNED6)did = subject_did OR (bdid <> '' OR cname <> '')), liensv2_services.layout_lien_party_parsed);
    //adding FCRA restriction tag to non-subject parties
    
    nonSubjects := L.parsed_parties(~((UNSIGNED6)did = subject_did OR (bdid <> '' OR cname <> '')));
    
    fcra_restricted := PROJECT(nonSubjects,
                               TRANSFORM(liensv2_services.layout_lien_party_parsed,
                                         SELF.lname := FCRA.Constants.FCRA_Restricted,
                                         SELF := []));
    // Insider Threat RR-15409, return name only
    fcra_returnNameOnly := PROJECT(nonSubjects,
      TRANSFORM(liensv2_services.layout_lien_party_parsed,
                SELF.fname := LEFT.fname,
                SELF.mname := LEFT.mname,
                SELF.lname := LEFT.lname,
                SELF.name_suffix := LEFT.name_suffix,
                SELF := []));
    
    SELF.parsed_parties := MAP(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => party_supp + fcra_restricted,
                               non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnNameOnly => party_supp + fcra_returnNameOnly,
                               non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => party_supp,
                               L.parsed_parties); //default: non_subject_suppresson = Suppress.Constants.NonSubjectSuppression.doNothing
    SELF.addresses := MAP(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.doNothing => L.addresses,
                          EXISTS(fcra_restricted) OR EXISTS(fcra_returnNameOnly) => DATASET([], liensv2_services.layout_lien_party_address),
                          L.addresses);
    SELF.persistent_record_id := L.persistent_record_id;
  END;
  
  liensv2_services.layout_lien_rollup xformNonSubject(liensv2_services.layout_lien_rollup L,
                                                      LiensV2_Services.layout_ids R) := TRANSFORM
    SELF.acctno := R.acctno;
    SELF.debtors := PROJECT(L.debtors, xformParty(LEFT, R.did));
    SELF.creditors := PROJECT(L.creditors, xformParty(LEFT, R.did));
    SELF.attorneys := PROJECT(L.attorneys, xformParty(LEFT, R.did));
    SELF.thds := PROJECT(L.thds, xformParty(LEFT, R.did));
    SELF := L;
  END;
  
  out_rec := JOIN(raw_rec, rec_in,
    LEFT.tmsid = RIGHT.tmsid
    AND (LEFT.acctno = '' OR LEFT.acctno = RIGHT.acctno),
    xformNonSubject(LEFT, RIGHT));
  RETURN out_rec;
END;
