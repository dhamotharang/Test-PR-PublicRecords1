//*************Function to apply last resort rule for records where phone has not been assigned to anyone else and: 
//                  unclassified phones with vendor confidence score > 0 and <> 5 
//**********************************************************************************
export Fn_Apply_Vendor_Conf_Last_Resort_Rule (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

already_classified := Fn_Phone_Already_Classified(phplus_in);

//-----------Find Unclassified
unclassified := join(distribute(phplus_in, hash(npa+phone7)),
						   distribute(already_classified, hash(npa+phone7)),
						   left.npa+left.phone7 = right.npa+right.phone7,
						   transform(recordof(phplus_in), self := left),
						   left only,
						   local);

//-----Classify as include records where phone has vendor confidence score > 0 and <> 5
last_resort_med_vendor_conf := unclassified(cur_orig_conf_score > 0 and
							cur_orig_conf_score <> 5 and 
							~Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('High-Vendor-Conf')));

last_resort_vendor_conf_ded := dedup(sort(distribute(last_resort_med_vendor_conf, hash(npa+phone7)), npa+phone7,local), npa+phone7, local);

recordof(phplus_in) t_apply_last_resort_vendor_conf(phplus_in le, last_resort_vendor_conf_ded ri) := transform
	med_vendor_conf_cell_caption:= if(ri.npa <> '', 
									  Translation_Codes.rules_bitmap_code('Med-Vendor-Conf-Cell'), 0b);
	
	self.in_flag 	    := if ((le.in_flag or ri.npa <> '') and 
							   ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')),
							   true, 
							   le.in_flag); 
	self.rules  		:=  if ((le.in_flag or ri.npa <> '') and
	                           ~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')),
							   le.rules | 
							   med_vendor_conf_cell_caption,
							   le.rules);
	self := le;

end;

last_resort_vendor_conf := join(distribute(phplus_in, hash(npa+phone7)),
						   distribute(last_resort_vendor_conf_ded, hash(npa+phone7)),
						   left.npa+left.phone7 = right.npa+right.phone7,
						    t_apply_last_resort_vendor_conf(left, right),
						   local);

//------------Include only the records with the latest date last seen that meet the rules
latest_include_flagged := dedup(sort(distribute(last_resort_vendor_conf(in_flag), hash(npa+phone7)), npa+phone7,-append_latest_phone_owner_flag, -dt_last_seen, local), npa+phone7, local);



recordof(phplus_in) t_prop_last_resort_include_rules(phplus_in le, latest_include_flagged ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b, ri.in_flag, le.in_flag) ;
	self.rules 	     := if(ri.rules <> 0b, ri.rules, le.rules);
	self.src_rule    := if(ri.rules <> 0b, le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
	self := le;
end;

prop_include_rules:= join(distribute(phplus_in, hash(phone7_did_key)),
				    distribute(latest_include_flagged, hash(phone7_did_key)),
					left.phone7_did_key = right.phone7_did_key,
					t_prop_last_resort_include_rules(left, right),
					left outer,
					local);
					
return prop_include_rules;
end;

