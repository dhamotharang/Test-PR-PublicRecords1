//**********Funtion to apply basic exclusion rule for low vendor confidence score = 5 (disconnected) or 7 (area code changed)

export Fn_Apply_Basic_Exclusion_Rules (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

recordof(phplus_in) t_apply_basic_erules(phplus_in le) := transform

//------------Define rules--------------------------------
	
   //-----Vendor Low Confidence rule
	low_vendor_conf_rule:= if(le.cur_orig_conf_score in [5,7],
							   true, false);
		
	low_vendor_conf_caption:= if(low_vendor_conf_rule,
								 Translation_Codes.rules_bitmap_code('Low-Vendor-Conf'), 0b );

//------------Apply rules--------------------------------
	
	self.in_flag 	    := if (low_vendor_conf_rule,
							    false, 
							    le.in_flag); 
	self.rules  		:= if (low_vendor_conf_rule,
							    le.rules | low_vendor_conf_caption, 
							    le.rules); 
	self := le;
end;

apply_basic_erules := project(phplus_in, t_apply_basic_erules(left));

//------------Propagate Exclusion rules all records for individuals flagged

exclude_flagged := apply_basic_erules(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')));

recordof(phplus_in) t_prop_exclude_rules(phplus_in le, exclude_flagged ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b,ri.in_flag, le.in_flag) ;
	self.rules 	   	 := if(ri.rules <> 0b, ri.rules, le.rules);
	self.src_rule    := if(ri.rules <> 0b, le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
	self := le;
end;

prop_exclude_rules:= join(distribute(phplus_in, hash(phone7_did_key)),
				    dedup(sort(distribute(exclude_flagged, hash(phone7_did_key)), phone7_did_key, local), phone7_did_key, local),
					left.phone7_did_key = right.phone7_did_key,
					t_prop_exclude_rules(left, right),
					left outer,
					local);

return prop_exclude_rules;

end;
