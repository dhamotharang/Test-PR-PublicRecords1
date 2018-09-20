export mac_get_type_t(f_t_did, f_t_acctno, f_t_out, modAccess) := macro
		
/*
 *  TRYHARDER TH search level
 *    Uses the same logic as Phones Plus (mac_get_type_g), except on "below the line" phones only.
 */
import phonesplus, doxie, ut, progressive_phone, Phonesplus_v2, Phones;

#uniquename(incoming_rows_t)
%incoming_rows_t% := count(f_t_did);  // relative phones... there could be several people that we are looking for phones
	
#uniquename(ppl_did_key_t)	
#uniquename(LR_index_did_t)	
%ppl_did_key_t% := phonesplus_v2.key_phonesplus_did;
%LR_index_did_t% := Phonesplus_v2.Key_Royalty_Did;

#uniquename(layout_with_c_score_t)
%layout_with_c_score_t% := record
	progressive_phone.layout_progressive_batch_out_with_did;
	unsigned2	ConfidenceScore;
	// string2 vendor;
	string1 ActiveFlag;
end;

#uniquename(layout_with_c_score_t_src)
%layout_with_c_score_t_src% := record
	%layout_with_c_score_t%;
	string2	src;
end;

//fetch phonesplus records
#uniquename(by_phonesplus_did_t)
%layout_with_c_score_t_src% %by_phonesplus_did_t%(f_t_did l, 
																										 %ppl_did_key_t% r) := transform
	// Unlike the Phones Plus level, TRYHARDER is only concerned with phones that are "below the line" (mac_get_type_g)
	// So skip the records that are "above the line" - confidencescore >= 11
	boolean isCell := phonesplus_v2.IsCell(r.append_phone_type);
	self.acctno := if(r.cellphone='' or r.confidencescore>=11 or (exclude_non_cell_pp and (~isCell)), 
	                  skip, (string20)l.seq);
	self.subj_first := r.fname;
  self.subj_middle := r.mname;
  self.subj_last := r.lname;
	self.subj_suffix := if(r.name_suffix[1..2]='UN','',r.name_suffix);
	self.subj_phone10 := r.CellPhone;
  self.subj_name_dual := if(r.origname='', r.company, r.origname);
	// Need to make sure that this is set to 11, Phones Plus above the line is set to a '6'.
  self.subj_phone_type := '11';
  self.subj_date_first := (string6)r.DateFirstSeen;
  self.subj_date_last := (string6)r.DateLastSeen;
	self.subj_phone_date_last := (string6)r.DateLastSeen;
  self.phpl_phones_plus_type := if(isCell,'C','');
	self.did := l.did;
	self.st := r.state;
	self.p_did := r.did;
  self.p_name_last := r.lname;
	self.p_name_first := r.fname;
	self.sub_rule_number := 111;
  self.sort_order_internal := case(r.append_phone_type, 'CELL' => 1,
																											'LNDLN PRTD TO CELL'=> 2,
																											'POTS'=> 3,
																											'VOIP'=> 4,
																											'Puerto Rico/US Virgin Isl'=> 5,
																											'PAGE'=> 6,
																											'FREE'=> 7,
																											8);
	self := r;
  self := [];
end;

#uniquename(f_t_out_raw)
%f_t_out_raw% := join(f_t_did(did<>0), %ppl_did_key_t%,
                      left.did = right.l_did and
											~Phones.Functions.IsPhoneRestricted(right.origstate, 
																													modAccess.glb,
																													modAccess.dppa,
																													modAccess.industry_class,
																													, //checkRNA
																													right.datefirstseen,
																													right.dt_nonglb_last_seen,
																													right.rules,
																													right.src_all,
																													modAccess.DataRestrictionMask
																												 ),
 	                 %by_phonesplus_did_t%(left, right),
			       limit(ut.limits.PHONE_PER_PERSON * %incoming_rows_t%, skip));

//fetch royalty records
#uniquename(by_royalty_did_t)
%layout_with_c_score_t_src% %by_royalty_did_t%(f_t_did l, 
																									%LR_index_did_t% r) := transform
	boolean isCell := phonesplus_v2.IsCell(r.append_phone_type);
	self.acctno := if(r.cellphone='' or r.confidencescore>=11 or (exclude_non_cell_pp and (~isCell)),
	                 skip, (string20)l.seq);
	self.subj_first := r.fname;
  self.subj_middle := r.mname;
  self.subj_last := r.lname;
	self.subj_suffix := if(r.name_suffix[1..2]='UN','',r.name_suffix);
	self.subj_phone10 := r.CellPhone;
  self.subj_name_dual := if(r.origname='', r.company, r.origname);
  self.subj_phone_type := '11';
  self.subj_date_first := (string6)r.DateFirstSeen;
  self.subj_date_last := (string6)r.DateLastSeen;
	self.subj_phone_date_last := (string6)r.DateLastSeen;
  self.phpl_phones_plus_type := if(isCell,'C','');
	self.did := l.did;
	self.st := r.state;
	self.p_did := r.did;
  self.p_name_last := r.lname;
	self.p_name_first := r.fname;
	self.sub_rule_number := 112;
  self.sort_order_internal := case(r.append_phone_type, 'CELL' => 1,
																											'LNDLN PRTD TO CELL'=> 2,
																											'POTS'=> 3,
																											'VOIP'=> 4,
																											'Puerto Rico/US Virgin Isl'=> 5,
																											'PAGE'=> 6,
																											'FREE'=> 7,
																											8);

	self := r;
  self := [];
end;
		
#uniquename(LR_raw_t)
%LR_raw_t%	:= join(f_t_did(did<>0), %LR_index_did_t%,
                     Keyed(left.did = right.l_did) and use_LR and 
										 ~Phones.Functions.IsPhoneRestricted(right.origstate, 
																												 modAccess.glb,
																												 modAccess.dppa,
																												 modAccess.industry_class,
																												 , //checkRNA
																												 right.datefirstseen,
																												 right.dt_nonglb_last_seen,
																												 right.rules,
																												 right.src_all,
																												 modAccess.DataRestrictionMask
																												),
										 %by_royalty_did_t%(left, right),
									 limit(ut.limits.PHONE_PER_PERSON * %incoming_rows_t%, skip));
			 
#uniquename(f_t_out_raw_post_filter)	
Header.MAC_Filter_Sources(%f_t_out_raw%,%f_t_out_raw_post_filter%,src,modAccess.DataRestrictionMask);									

#uniquename(f_t_out_ready)				
%f_t_out_ready% := project(%f_t_out_raw_post_filter%,%layout_with_c_score_t_src%); 

#uniquename(royalty_only_t)
%royalty_only_t% := join(%f_t_out_ready%, %LR_raw_t%, left.acctno = right.acctno
													and left.did = right.did
											,transform(%layout_with_c_score_t_src%,self:=right),right only);

#uniquename(f_t_comb_ready)
%f_t_comb_ready% := %f_t_out_ready% + %royalty_only_t%;

#uniquename(f_t_out_dep)
%f_t_out_dep% := group(dedup(sort(%f_t_comb_ready%, acctno, subj_phone10, -subj_date_last, -ConfidenceScore, 
				         if(ActiveFlag='', 1, 2), -subj_date_first), acctno, subj_phone10), acctno);

#uniquename(f_t_out_final)
%f_t_out_final% := project(topN(%f_t_out_dep%,3 * %incoming_rows_t%,
						  acctno, -subj_date_last, -ConfidenceScore, if(ActiveFlag='', 1, 2), -subj_date_first, subj_phone10), 
				       progressive_phone.layout_progressive_batch_out_with_did);					
	
//get back acctno	
progressive_phone.mac_get_back_acctno(%f_t_out_final%, f_t_acctno, f_t_out);		

endmacro;