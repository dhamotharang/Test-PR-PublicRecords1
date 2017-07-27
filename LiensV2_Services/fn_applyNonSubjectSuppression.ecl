import FCRA, Suppress;

// Handle non_subject suppression
EXPORT fn_applyNonSubjectSuppression(dataset(liensv2_services.layout_lien_rollup) raw_rec,
																		 dataset(LiensV2_Services.layout_ids) rec_in,
																		 integer1 non_subject_suppression) := FUNCTION	
	
	liensv2_services.layout_lien_party xformParty(liensv2_services.layout_lien_party L,
																								unsigned6 subject_did) := transform, 
																																					skip(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank 
																																							 and not exists(L.parsed_parties((unsigned6)did = subject_did or (bdid <> '' or cname <> ''))))
		//blanking orig_name if return subject only
		self.orig_name 			:= if(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.doNothing, L.orig_name, '');
		//suppressing debtors that are not the subject searched on and are not a company
		party_supp := project(L.parsed_parties((unsigned6)did = subject_did or (bdid <> '' or cname <> '')), liensv2_services.layout_lien_party_parsed);
		//adding FCRA restriction tag to non-subject parties
		fcra_restricted := project(L.parsed_parties(~((unsigned6)did = subject_did or (bdid <> '' or cname <> ''))),
															 transform(liensv2_services.layout_lien_party_parsed,
																				 self.lname := FCRA.Constants.FCRA_Restricted, 
																				 self := []));
		party_restricted := party_supp + fcra_restricted;
		self.parsed_parties := map(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnRestrictedDescription => party_restricted, 
															 non_subject_suppression = Suppress.Constants.NonSubjectSuppression.returnBlank => party_supp,
															 L.parsed_parties); //default: non_subject_suppresson = Suppress.Constants.NonSubjectSuppression.doNothing
		self.addresses := map(non_subject_suppression = Suppress.Constants.NonSubjectSuppression.doNothing => L.addresses, 
													exists(fcra_restricted) => dataset([], liensv2_services.layout_lien_party_address),
													L.addresses);
		self.persistent_record_id := L.persistent_record_id;
	end;
	
	liensv2_services.layout_lien_rollup xformNonSubject(liensv2_services.layout_lien_rollup L,
																											LiensV2_Services.layout_ids R) := transform
		self.acctno := R.acctno;
		self.debtors := project(L.debtors, xformParty(left, R.did));
		self.creditors := project(L.creditors, xformParty(left, R.did));
		self.attorneys := project(L.attorneys, xformParty(left, R.did));
		self.thds := project(L.thds, xformParty(left, R.did));
		self := L;
	end;
	
	out_rec := join(raw_rec, rec_in,
									left.tmsid = right.tmsid
									and (left.acctno = '' or left.acctno = right.acctno),
									xformNonSubject(left, right));
	RETURN out_rec;
END;