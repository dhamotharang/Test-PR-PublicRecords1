//****************Function to exclud records that match Active EDA***************
export Fn_Exclude_EDA(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function



//------------Score EDA phones as low confidence because they already exist in Gong
recordof(phplus_in) t_eda_score(phplus_in le) := transform
	self.in_flag 	    := if (le.eda_active_flag or
							   Translation_Codes.fFlagIsOn(le.eda_match, 1b),
							   false,
							   le.in_flag);
							   
	self.rules  		:= if (le.eda_active_flag,
							   Translation_Codes.rules_bitmap_code('Active-EDA-Record'),
							   if (Translation_Codes.fFlagIsOn(le.eda_match, 1b), 
							   Translation_Codes.rules_bitmap_code('Active-EDA-Phone'),
							   le.rules));
	self := le;
end;


eda_score := project(phplus_in, t_eda_score(left));

//------------Propagate EDA score to all records with the same phone for individual

eda_score_flagged := eda_score(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Phone')) or
							   Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Record')));

recordof(phplus_in) t_prop_eda(eda_score le,eda_score_flagged  ri) := transform
	self.in_flag	 	   := if(ri.rules <> 0b, ri.in_flag, le.in_flag);
	self.rules 		       := if(ri.rules <> 0b, ri.rules, le.rules);
	self := le;
end;

prop_eda    := join(distribute(eda_score, hash(phone7_did_key)),
					dedup(sort(distribute(eda_score_flagged, hash(phone7_did_key)), phone7_did_key, local), phone7_did_key, local),
					left.phone7_did_key = right.phone7_did_key,
					t_prop_eda(left, right),
					local,
					left outer);

excluded_eda := prop_eda(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Phone')) = false and
				 Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Record')) = false);

flagged_eda := prop_eda(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Phone')) or
					    Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Active-EDA-Record')))
						:persist('~thor_data400::persist::Phonesplus::flagged_eda');

return excluded_eda;

end;