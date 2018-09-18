//export mac_get_type_f(f_f_did, f_f_acctno, f_f_out, data_restriction_mask='', sx_match_restriction_limit) := macro
export mac_get_type_f(f_f_did, f_f_acctno, f_f_out, sx_match_restriction_limit, modAccess) := macro

import gong, progressive_phone, NID, ut, STD, watchdog;

#uniquename(f_f_did_set)
%f_f_did_set% := SET(f_f_did, did);

#uniquename(gong_address_key)
%gong_address_key% := gong.Key_history_Address;

#uniquename(gong_history_name_key)
%gong_history_name_key% := gong.Key_History_Name;

#uniquename(gong_history_city_st_key)
%gong_history_city_st_key% := gong.key_history_city_st_name;

#uniquename(best_city_st_name_key)
%best_city_st_name_key%	:=	watchdog.Key_Best_Name_City_State;

#uniquename(blue_recs)
progressive_phone.mac_get_blue(f_f_did, %blue_recs%, false, false, false, modAccess)

#uniquename(f_six_months)
%f_six_months% := %blue_recs%(src<>'' and ut.DaysApart(StringLib.GetDateYYYYMMDD(),(string6)dt_last_seen + '15')<=180
                              or ut.DaysApart(StringLib.GetDateYYYYMMDD(),(string6)dt_vendor_last_reported + '15')<=180); 

#uniquename(f_input)			   
%f_input% := project(f_f_did, transform(progressive_phone.layout_header_seq, 
		                                 self.dob := (integer4)left.dob,
		                                 self.phone := left.phone10, 
								   self.name_suffix := left.suffix,
								   self.suffix := left.addr_suffix,
								   self.city_name := left.p_city_name,
								   self.zip := left.z5, self := left, self := []));
		
#uniquename(b_out_plus)
%b_out_plus% :=
RECORD
	progressive_phone.layout_progressive_batch_out_with_did;
END;

//rule1 - if the input last name in key listed_name or input first name matches the listing's last name
#uniquename(by_rule_1)
%b_out_plus% %by_rule_1%(%f_six_months% l, %gong_address_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
     self.subj_first := r.name_first;
     self.subj_middle := r.name_middle;
     self.subj_last := r.name_last;
     self.subj_suffix := r.name_suffix; 
	self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '5';
     self.subj_date_first := r.dt_first_seen[1..6];
     self.subj_date_last := ((string) Std.Date.Today())[1..6];
		 self.subj_phone_date_last := ((string) Std.Date.Today())[1..6];
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	 SELF.did := l.did;
	 self.p_did := r.did;
	 self.addr_suffix := r.suffix;
	 self.zip5 := r.z5;
	 self.p_name_last := r.name_last;
	 self.p_name_first := r.name_first;
	 self.sub_rule_number := 51;
	 self := r;
   self := [];
end;

#uniquename(f_f_1_raw)
%f_f_1_raw% := join(%f_six_months%, %gong_address_key%, 
                keyed(left.prim_name = right.prim_name) and
		      keyed(left.zip = right.z5) and
		      keyed(left.prim_range = right.prim_range) and
			 keyed(left.sec_range = right.sec_range) and
				keyed(left.st = right.st) and right.current_flag = true and
			 ((length(trim(left.lname))>1 and STD.Str.Find(trim(right.listed_name), trim(left.lname), 1)>0) or
			 (length(trim(left.fname))>1 and trim(left.fname)=trim(right.name_last))),
			 %by_rule_1%(left, right), limit(ut.limits.PHONE_PER_PERSON, skip));

// Need to add one more sort criteria to make these sort/dedup's deterministic.  Choose to keep the record with a p_did matching one of the input dids.
#uniquename(f_f_1)
%f_f_1% := dedup(sort(%f_f_1_raw%, 
                      acctno, subj_phone10, -subj_date_last, -subj_date_first, -(p_did IN %f_f_did_set%)), 
								 acctno, subj_phone10);
			 
//rule2 - if first name, last name, city and state match

#uniquename(by_rule_2)
%b_out_plus% %by_rule_2%(%f_six_months% l, %gong_history_city_st_key% r) := transform
	self.acctno := if(r.phone10='' or r.current_record_flag<>'Y', skip, (string20)l.seq);
     self.subj_first := r.name_first;
     self.subj_middle := r.name_middle;
     self.subj_last := r.name_last;
     self.subj_suffix := r.name_suffix; 
	self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '5';
     self.subj_date_first := r.dt_first_seen[1..6];
     self.subj_date_last := r.dt_last_seen[1..6];
		 self.subj_phone_date_last := r.dt_last_seen[1..6];
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	SELF.did := l.did;
  self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.p_did := r.did;
	self.p_name_last := r.name_last;
	self.p_name_first := r.name_first;
	self.sub_rule_number := 52;
	self := r;
	self := [];
end;

// Bug 111486 - Loose matching on common names for SX logic
// Name/City/State is returning the same phone number primarily where input name is a common name
#uniquename(f_best_city_st_raw_input)
%f_best_city_st_raw_input%	:=	join(	%f_input%,
																			%best_city_st_name_key%,
																					keyed(left.st	=	right.st)
																			and	keyed(left.city_name	=	right.city_name)
																			and	keyed(left.lname	=	right.lname)
																			and	keyed(	(NID.mod_PFirstTools.PF(left.fname)[1]	=	right.preferred_fname)
																									or
																									(NID.mod_PFirstTools.PF(left.fname)[2]	!=	''	and	NID.mod_PFirstTools.PF(left.fname)[2] = right.preferred_fname)
																								)
																			and	right.did_cnt_with_pref_nm	>	sx_match_restriction_limit,
																			transform(recordof(%f_input%),self	:=	left),
																			left only
																		);

#uniquename(f_best_city_st_raw)
%f_best_city_st_raw%	:=	join(	%f_six_months%,
																%best_city_st_name_key%,
																		keyed(left.st	=	right.st)
																and	keyed(left.city_name	=	right.city_name)
																and	keyed(left.lname	=	right.lname)
																and	keyed(	(NID.mod_PFirstTools.PF(left.fname)[1]	=	right.preferred_fname)
																						or
																						(NID.mod_PFirstTools.PF(left.fname)[2]	!=	''	and	NID.mod_PFirstTools.PF(left.fname)[2] = right.preferred_fname)
																					)
																and	right.did_cnt_with_pref_nm	>	sx_match_restriction_limit,
																transform(recordof(%f_six_months%),self	:=	left),
																left only
															);

#uniquename(f_f_2_raw_input)
%f_f_2_raw_input% := join(if(sx_match_restriction_limit	=	0,%f_input%,%f_best_city_st_raw_input%),
													%gong_history_city_st_key%, 
												  keyed(right.city_code in doxie.Make_CityCodes(left.city_name).rox) and             
													keyed(left.st = right.st) and       
                          keyed(metaphonelib.DMetaPhone1(left.lname)[1..6] = right.dph_name_last) and
			                    keyed(left.lname<>'' and left.lname = right.name_last) and
			                    keyed(NID.mod_PFirstTools.PF(left.fname)[1] = right.p_name_first  or 
							                  NID.mod_PFirstTools.PF(left.fname)[2] <>'' and 
							                  NID.mod_PFirstTools.PF(left.fname)[2] = right.p_name_first) and 
													(left.did=right.did or left.did=0 or right.did=0), 
			                    %by_rule_2%(left, right), limit(5 * ut.limits.PHONE_PER_PERSON, skip));

#uniquename(f_f_2_raw)
%f_f_2_raw% := join(if(sx_match_restriction_limit	=	0,%f_six_months%,%f_best_city_st_raw%),
										%gong_history_city_st_key%, 
										keyed(right.city_code in doxie.Make_CityCodes(left.city_name).rox) and            
										keyed(left.st = right.st) and       
										keyed(metaphonelib.DMetaPhone1(left.lname)[1..6] = right.dph_name_last) and
										keyed(left.lname<>'' and left.lname = right.name_last) and
										keyed(length(trim(left.fname)) > 1 and 
												 (NID.mod_PFirstTools.PF(left.fname)[1] = right.p_name_first  or 
													NID.mod_PFirstTools.PF(left.fname)[2] <>'' and 
													NID.mod_PFirstTools.PF(left.fname)[2] = right.p_name_first)) and 
										(left.did=right.did or left.did=0 or right.did=0), 
										%by_rule_2%(left, right), limit(5 * ut.limits.PHONE_PER_PERSON, skip));
			 
#uniquename(f_f_2)	
%f_f_2% := dedup(sort(if(exists(%f_f_2_raw_input%),%f_f_2_raw_input%,%f_f_2_raw%), 
                      acctno, subj_phone10, -subj_date_last, -subj_date_first, -(p_did IN %f_f_did_set%)), 
								 acctno, subj_phone10);

//rule3 - if first name initial, last name, city and state match, and the listing has no street address 
#uniquename(by_rule_3)
%b_out_plus% %by_rule_3%(%f_six_months% l, %gong_history_city_st_key% r) := transform
	   self.acctno := if(r.phone10='' or r.current_record_flag<>'Y', skip, (string20)l.seq);
     self.subj_first := r.name_first;
     self.subj_middle := r.name_middle;
     self.subj_last := r.name_last;
     self.subj_suffix := r.name_suffix; 
	   self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '5';
     self.subj_date_first := r.dt_first_seen[1..6];
     self.subj_date_last := r.dt_last_seen[1..6];
		 self.subj_phone_date_last := r.dt_last_seen[1..6];
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                                  r.listing_type_bus<>''=>r.listing_type_bus,
						         r.listing_type_gov);
	   SELF.did := l.did;
		 self.p_did := r.did;
  	 self.p_name_last := r.name_last;
	   self.p_name_first := r.name_first;
		 self.sub_rule_number := 53;
     self := [];
end;

#uniquename(f_f_3_raw_iput)
%f_f_3_raw_iput% := join(if(sx_match_restriction_limit	=	0,%f_input%,%f_best_city_st_raw_input%),
                         %gong_history_city_st_key%,
												 keyed(right.city_code in doxie.Make_CityCodes(left.city_name).rox) and
												 (left.st = right.st) and
                         (metaphonelib.DMetaPhone1(left.lname)[1..6] = right.dph_name_last) and
		  	                 (left.lname<>'' and left.lname = right.name_last) and
			                   (left.fname[1]=right.name_first or left.fname = right.name_first) and			         
			                   right.prim_name='', %by_rule_3%(left, right), limit(5 * ut.limits.PHONE_PER_PERSON, skip));

#uniquename(f_f_3_raw)
%f_f_3_raw% := join(if(sx_match_restriction_limit	=	0,%f_six_months%,%f_best_city_st_raw%),
										%gong_history_city_st_key%,
										keyed(right.city_code in doxie.Make_CityCodes(left.city_name).rox) and            
										(left.st = right.st) and
										(metaphonelib.DMetaPhone1(left.lname)[1..6] = right.dph_name_last) and
										(left.lname<>'' and left.lname = right.name_last) and
										(left.fname[1]=right.name_first or left.fname = right.name_first) and			         
										right.prim_name='', %by_rule_3%(left, right), limit(5 * ut.limits.PHONE_PER_PERSON, skip));

#uniquename(f_f_3)
%f_f_3% := dedup(sort(if(exists(%f_f_3_raw_iput%), %f_f_3_raw_iput%, %f_f_3_raw%), 
                      acctno, subj_phone10, -subj_date_last, -subj_date_first, -(p_did IN %f_f_did_set%)), 
		       acctno, subj_phone10);

#uniquename(f_f_all_precheck)
%f_f_all_precheck% :=  dedup(sort(%f_f_1% + %f_f_2% + %f_f_3%, acctno, subj_phone10, -subj_date_last, -subj_date_first, -(p_did IN %f_f_did_set%)), 
		       acctno, subj_phone10);

#uniquename(f_f_all)		
%f_f_all% := IF(strict_apsx, JOIN(%f_f_all_precheck%, gong.Key_History_phone,
						keyed(LEFT.subj_phone10[4..10]=RIGHT.p7) AND
						keyed(LEFT.subj_phone10[1..3]=RIGHT.p3) AND
						RIGHT.current_flag AND (LEFT.did=RIGHT.did OR RIGHT.did=0), 
						TRANSFORM(progressive_phone.layout_progressive_batch_out_with_did, SELF := LEFT),
						KEEP(1), ATMOST(100)), 
				PROJECT(%f_f_all_precheck%, progressive_phone.layout_progressive_batch_out_with_did));

progressive_phone.mac_get_back_acctno(%f_f_all%, f_f_acctno, f_f_out, true)

endmacro;