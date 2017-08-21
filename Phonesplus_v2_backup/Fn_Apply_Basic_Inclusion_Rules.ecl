/*2009-12-18T21:35:49Z (aherzberg_prod)
c:\SuperComputer\Production\QueryBuilder\workspace\aherzberg_prod\prod\Phonesplus_v2\Fn_Apply_Basic_Inclusion_Rules\2009-12-18T21_35_49Z.ecl
*/
/* *****Function to apply basic inclusion rules
                  Gong non-pub landlines
				  ported neustar
				  seen once (household is the only one assigned to the phone and the household does not have othe phone)and
				  latest cell matching to address best
				  high vendor confidence score 
				  utility and cell phone souces
*************************************************************/
import ut;
export Fn_Apply_Basic_Inclusion_Rules (dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

phplus_in_lastest_owner_reflag :=Fn_ReFlag_Phone_Latest_Owner(phplus_in);

recordof(phplus_in) t_apply_basic_rules(phplus_in_lastest_owner_reflag le) := transform
	

//------------Define rules--------------------------------
	//----Non-pub rule
	
	non_pub_rule 	   := if (le.append_nonpublished_match > 1b and  
							  le.append_nonpublished_match <= 1000b and
							  (le.append_phone_type[..4] = 'POTS') and
							  le.append_latest_phone_owner_flag, 
							  true, false);
							  
	non_pub_caption		:= if(non_pub_rule, 
							  Translation_Codes.rules_bitmap_code('Non-pub'), 0b );
	
	//----Ported Neustar rule
	ported_neustar_rule :=   if(Translation_Codes.fFlagIsOn(le.append_ported_match, 1b) and
							    le.append_latest_phone_owner_flag, 
							    true, false);
	
	ported_neustar_caption:= if(ported_neustar_rule, 
							    Translation_Codes.rules_bitmap_code('Ported-Neustar'), 0b );
								
								
   //----Seen Once rule
   	seen_once_rule 	    := if (le.append_seen_once_ind and
							   le.append_latest_phone_owner_flag,
							   true, false);
    seen_one_caption	:= if(seen_once_rule,
							  Translation_Codes.rules_bitmap_code('Seen-Once'), 0b );

   //-----Vendor High Confidence rule
	high_vendor_conf_rule:= if(le.cur_orig_conf_score = 2 or
							   (le.cur_orig_conf_score = 3 and
							   le.append_latest_phone_owner_flag),
							   true, false);
		
	high_vendor_conf_caption:= if(high_vendor_conf_rule,
								 Translation_Codes.rules_bitmap_code('High-Vendor-Conf'), 0b );
								  
  //------Cellphone match best address
  
	cell_best_latest_rule  := if(le.append_phone_type[..4] = 'CELL' and
								  le.append_latest_phone_owner_flag and 
								  le.append_best_addr_match_flag,
							      true, false);
								  
    cell_best_latest_caption   := if(cell_best_latest_rule,
									 Translation_Codes.rules_bitmap_code('Cellphone-Latest'), 0b );
									 
									 
//---------Cellphone or utility source or cellphone sources where individual is the latest owner
source_latest_rule :=        (Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('UW')) or
					         Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('UT')) or
									 Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('ZT')) or
									 Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('ZK')) or
					          Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('01')) or
							 Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('02')) or
							 Translation_Codes.fFlagIsOn(le.src,Translation_Codes.source_bitmap_code('05'))) and 
							 le.append_latest_phone_owner_flag;

source_latest_caption:= if(source_latest_rule, 
						        Translation_Codes.rules_bitmap_code('Source-Latest'), 0b);
								
								
//---------Ported rule: no active phone for individual, address matches best and phone is in eda history
ported_best_no_active_rule := le.append_portability_indicator = '1' and 
							  le.append_indiv_has_active_eda_phone_flag = false and 
							  le.append_latest_phone_owner_flag and 
							  le.append_best_addr_match_flag and 
							  (((string)le.dt_last_seen [..4] >= '2001' and
							  ut.DaysApart((string)le.dt_last_seen, ut.GetDate) >= 90) or
							  le.dt_last_seen = 0) and
							  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'));

ported_best_no_active_caption:= if(ported_best_no_active_rule, 
								Translation_Codes.rules_bitmap_code('Ported-Best-No-Active'), 0b);

//---------Ported rule: phone is in gong history and type is a cell


ported_cell_rule 		 := le.append_portability_indicator = '1' and 
							le.append_phone_type[..4] = 'CELL' and
							le.append_latest_phone_owner_flag and
						    (((string)le.dt_last_seen [..4] >= '2001' and
							ut.DaysApart((string)le.dt_last_seen, ut.GetDate) >= 90) or
							le.dt_last_seen = 0) and
							Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'));

ported_cell_caption 	 := if(ported_cell_rule, 
							   Translation_Codes.rules_bitmap_code('Ported-Cell-Type'), 0b);
								

//------------Apply rules--------------------------------
	
	self.in_flag 	    := if ((le.rules = 0b  or 
								~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')))and 
							    (non_pub_rule or
								 ported_neustar_rule or
								 seen_once_rule or
							     high_vendor_conf_rule or
							     cell_best_latest_rule or
								 source_latest_rule or
								 ported_best_no_active_rule or 
								 ported_cell_rule), 
							     true, 
							     le.in_flag); 
	self.rules  		:= if((le.rules = 0b  or 
								~Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')))and 
							    (non_pub_rule or
								 ported_neustar_rule or
								 seen_once_rule or
							     high_vendor_conf_rule or
							     cell_best_latest_rule or
								 source_latest_rule or
								 ported_best_no_active_rule or 
								 ported_cell_rule), 
								 le.rules |
							     non_pub_caption | 
							     ported_neustar_caption |
							     seen_one_caption |
							     high_vendor_conf_caption |
							     cell_best_latest_caption |
								 source_latest_caption |
								 ported_best_no_active_caption |
								 ported_cell_caption,
							     le.rules);							   
	self := le;
end;

apply_basic_rules := project(phplus_in_lastest_owner_reflag, t_apply_basic_rules(left));

//------------Propagate Inclusion rules all records for individuals flagged
include_flagged := dedup(sort(distribute(apply_basic_rules(in_flag), hash(phone7_did_key)), phone7_did_key,-append_latest_phone_owner_flag, local), phone7_did_key, local);

recordof(phplus_in) t_prop_include_rules(phplus_in_lastest_owner_reflag le, include_flagged ri) := transform
	self.in_flag 	   := if(ri.rules <> 0b, ri.in_flag, le.in_flag) ;
	self.rules 	     := if(ri.rules <> 0b, ri.rules, le.rules);
	self.src_rule    := if(ri.rules <> 0b, le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
	self := le;
end;

prop_include_rules:= join(distribute(phplus_in_lastest_owner_reflag, hash(phone7_did_key)),
				    include_flagged,
					left.phone7_did_key = right.phone7_did_key,
					t_prop_include_rules(left, right),
					left outer,
					local);
					
return prop_include_rules;
end;