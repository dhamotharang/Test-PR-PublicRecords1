//**********Funtion to apply basic exclusion rule for low vendor confidence score = 5 (disconnected) or 7 (area code changed)
import ut;
export Fn_Apply_Basic_Exclusion_Rules (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

recordof(phplus_in) t_apply_basic_erules(phplus_in le) := transform

//------------Define rules--------------------------------
	
   //-----Vendor Low Confidence rule
	low_vendor_conf_rule:= if(le.cur_orig_conf_score in [5,7],
							   true, false);
		
	low_vendor_conf_caption:= if(low_vendor_conf_rule,
								 Translation_Codes.rules_bitmap_code('Low-Vendor-Conf'), 0b );
								 
	//Deceased rule
	deceased_rule := if(le.did_type = 'DEAD' and ~le.append_latest_phone_owner_flag,	
											true, false);
	
	
	deceased_caption:= if(deceased_rule,
								 Translation_Codes.rules_bitmap_code('Deceased'), 0b );
								 
	//Gong History with subsequent disconnect
	gongh_discon_rule := if(Translation_Codes.fFlagIsOn(le.src_all,Translation_Codes.source_bitmap_code('GO')) and
													le.append_phone_type not in ['CELL' , 'LNDLN PRTD TO CELL'] and
													((unsigned)le.eda_did_dt[..6] > le.datelastseen or 
													(unsigned)le.eda_hist_did_dt[..6] > le.datelastseen or 
													le.eda_did_dt >  le.eda_hist_did_dt or
													(le.datelastseen = (unsigned)le.eda_hist_did_dt[..6] and le.eda_hist_did_dt [..6 ] = le.eda_hist_phone_dt [..6 ] and le.eda_hist_did_dt > le.eda_hist_phone_dt ) or
													(le.datelastseen = (unsigned)le.eda_did_dt[..6] and le.eda_did_dt [..6 ] = le.eda_phone_dt [..6 ] and le.eda_did_dt > le.eda_phone_dt ))
											,true,false);

gongh_discon_caption:= if(gongh_discon_rule,
								 Translation_Codes.rules_bitmap_code('Gongh-Disconnect'), 0b );

//consortium discon
consortium_discon_rule := le.append_feedback_phone = '4' and ut.DaysApart(ut.GetDate,(string)le.append_feedback_phone_dt)  <= 365	;							 

consortium_discon_caption:= if(consortium_discon_rule,
								 Translation_Codes.rules_bitmap_code('Consortium-Disconnect'), 0b );								 
								 
//------------Apply rules--------------------------------
	
	self.in_flag 	    := if (low_vendor_conf_rule or deceased_rule or gongh_discon_rule or consortium_discon_rule,
							    false, 
							    le.in_flag); 
	self.rules  		:= if (low_vendor_conf_rule or deceased_rule or  gongh_discon_rule or consortium_discon_rule,
							    le.rules | low_vendor_conf_caption | deceased_caption | gongh_discon_caption | consortium_discon_caption, 
							    le.rules); 
	self := le;
end;

apply_basic_erules := project(phplus_in, t_apply_basic_erules(left));

//------------Propagate Exclusion rules all records for individuals flagged

exclude_flagged := apply_basic_erules(Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) or
													            Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Gongh-Disconnect')) or
																			Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Consortium-Disconnect')));

recordof(phplus_in) t_prop_exclude_rules(phplus_in le, exclude_flagged ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b,ri.in_flag, le.in_flag) ;
	self.rules 	   	 := if(ri.rules <> 0b, ri.rules, le.rules);
	self.src_rule    := if(ri.rules <> 0b, le.src_all | ri.src_all | le.src_rule | ri.src_rule, le.src_all |le.src_rule);
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
