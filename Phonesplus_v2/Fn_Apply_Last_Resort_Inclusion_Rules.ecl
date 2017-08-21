//*************Function to apply last resort rule for records where phone has not been assigned to anyone else and: 
//   				the source is cellphones or utility               
//					the phone type is Cell
//                  the phone is non-pub Targus WP
//                  the phone is Cell and has no even even if alredy assigned to someone else
//**********************************************************************************
export Fn_Apply_Last_Resort_Inclusion_Rules (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

already_classified := Fn_Phone_Already_Classified(phplus_in);

phone_type_rules(string append_phone_type, boolean append_best_addr_match_flag, append_nonpublished_match, boolean append_latest_phone_owner_flag) := function
//------------Define rules--------------------------------
		//---------Cell phone type match best address
		cell_best_rule := append_phone_type[..4] = 'CELL' and
						  append_best_addr_match_flag ;
		//---------Cellphone phone type							  
		last_resort_cell_rule :=  append_phone_type = 'CELL';							  
									  

		//---------Targus Non-pub
		non_pub_targ_rule := append_nonpublished_match > 1000b and  
							 append_phone_type[..4] = 'POTS' and
							 append_latest_phone_owner_flag;

		rule_check := cell_best_rule or last_resort_cell_rule or non_pub_targ_rule;
return rule_check;
end;

//------------Define caption for each rulerules--------------
phone_type_caption(string append_phone_type, boolean append_best_addr_match_flag, append_nonpublished_match, boolean append_latest_phone_owner_flag)  := function 							  

		cell_best_caption:= if(append_phone_type[..4] = 'CELL' and
							   append_best_addr_match_flag, 
							   Translation_Codes.rules_bitmap_code('Cellphone-Best-Match'), 0b);		


		last_resort_cell_caption:= if(append_phone_type = 'CELL', 
									   Translation_Codes.rules_bitmap_code('Last-Resort-Cell'), 0b );								
										


		non_pub_targ_caption:= if( append_nonpublished_match > 1000b and  
								   append_phone_type[..4] = 'POTS' and
									 append_latest_phone_owner_flag, 
								   Translation_Codes.rules_bitmap_code('Targ-Non-pub'), 0b);
								
								
		caption := cell_best_caption | last_resort_cell_caption | non_pub_targ_caption;

return caption;
end;

recordof(phplus_in) t_apply_last_resort(phplus_in le, already_classified ri) := transform
										
//------------Apply rules--------------------------------			

	self.in_flag 	    := if ((le.in_flag or ri.npa = '') and 
							   ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) and
								 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Deceased')) and
								 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) and
								 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect')) and
							   phone_type_rules(le.append_phone_type, le.append_best_addr_match_flag, le.append_nonpublished_match, le.append_latest_phone_owner_flag), 
							   true, 
							   le.in_flag); 
	self.rules  		:=  if ((le.in_flag or ri.npa = '') and
	                           ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Deceased')) and
														 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) and
							   						 ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect')) and
								 phone_type_rules(le.append_phone_type, le.append_best_addr_match_flag, le.append_nonpublished_match, le.append_latest_phone_owner_flag),
							   le.rules |
							   phone_type_caption(le.append_phone_type, le.append_best_addr_match_flag,le.append_nonpublished_match, le.append_latest_phone_owner_flag) ,
							   le.rules);
	self := le;

end;

last_resort := join(distribute(phplus_in, hash(npa+phone7)),
						   distribute(already_classified, hash(npa+phone7)),
						   left.npa+left.phone7 = right.npa+right.phone7,
						   t_apply_last_resort(left, right),
						   left only,
						   local);

//------------Include only the records with the latest date last seen that meet the rules
latest_include_flagged := dedup(sort(distribute(last_resort(in_flag and cur_orig_conf_score <> 4), hash(npa+phone7)), npa+phone7,-append_latest_phone_owner_flag, -DateLastSeen, local), npa+phone7, local);

//-----------Include records without dates even if the phone has already been assigned to someone else
recordof(phplus_in) t_include_cellphones_no_dates(phplus_in le) := transform
	self.in_flag := true;
	self.rules  := le.rules | Translation_Codes.rules_bitmap_code('Last-Resort-Cell');
	self 		 := le;
end;

cellphones_no_dates := project(phplus_in(append_phone_type = 'CELL' and DateLastSeen = 0 and ~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) and ~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Deceased')) and ~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) and ~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect'))),
                               t_include_cellphones_no_dates(left));


latest_include_flagged_all := latest_include_flagged + cellphones_no_dates;

recordof(phplus_in) t_prop_last_resort_include_rules(phplus_in le, latest_include_flagged_all ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b, ri.in_flag, le.in_flag) ;
	self.rules 	     := if(ri.rules <> 0b, ri.rules, le.rules);
	self.src_rule    := if(ri.rules <> 0b, le.src_all | ri.src_all | le.src_rule | ri.src_rule, le.src_all |le.src_rule);
	self := le;
end;

prop_include_rules:= join(distribute(phplus_in, hash(phone7_did_key)),
				    distribute(latest_include_flagged_all, hash(phone7_did_key)),
					left.phone7_did_key = right.phone7_did_key,
					t_prop_last_resort_include_rules(left, right),
					left outer,
					local);
					
					
//------------For records alredy included verify if the last resort rule is also met
basic_last_resort_include := project(prop_include_rules,
	                                 transform(recordof(phplus_in),
									           self.rules := if(left.in_flag and
											                     ~Translation_Codes.fFlagIsOn(left.rules, Translation_Codes.rules_bitmap_code('Cellphone-Best-Match')) and
																 ~Translation_Codes.fFlagIsOn(left.rules, Translation_Codes.rules_bitmap_code('Last-Resort-Cell')) and
																 ~Translation_Codes.fFlagIsOn(left.rules, Translation_Codes.rules_bitmap_code('Targ-Non-pub')) and
																  phone_type_rules(left.append_phone_type, left.append_best_addr_match_flag,left.append_nonpublished_match, left.append_latest_phone_owner_flag), 
																  left.rules | 
																  phone_type_caption(left.append_phone_type, left.append_best_addr_match_flag,left.append_nonpublished_match, left.append_latest_phone_owner_flag),
							                                      left.rules),
																  
											   self := left));
									

										
return basic_last_resort_include;

end;