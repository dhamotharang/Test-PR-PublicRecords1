//****************Function to propagate include/exclude flag to records with the same HHID********************

export Fn_Propagate_Household(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//Propagate exclusion flag to records that have the same hhid
phplus_exclude_household := dedup(sort(distribute(phplus_in(~in_flag and 
												   (Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Low-Vendor-Conf')) or
												    Translation_Codes.fFlagIsOn(rules, Translation_Codes.rules_bitmap_code('Non-pub-for-someone-else'))) and
													hhid > 0), 
							           hash(npa+phone7)), 
						          npa+phone7, hhid, rules, local),
				            npa+phone7, hhid, local) ;
							
recordof(phplus_in) t_propagate_household_false (phplus_in le, phplus_exclude_household  ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b and 
					     (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b and 
					     (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))),
						  ri.rules | Translation_Codes.rules_bitmap_code('Household'), 
						  le.rules );
	
	self.src_rule := if(ri.rules <> 0b and 
					     (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))),
						  le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
    self := le;
end;


propagate_household_false := join(distribute(phplus_in, hash(npa+phone7)), 
							 phplus_exclude_household,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.hhid = right.hhid,
							 t_propagate_household_false(left, right), 
							 left outer,
							 local);

//---------Propagate inclusion flag and rules to records that have the same hhid

phplus_include_household := dedup(sort(distribute(propagate_household_false(in_flag and rules <> 0b), hash(npa+phone7)), npa+phone7, hhid, rules, local),npa+phone7,hhid, local) ;

recordof(phplus_in) t_propagate_household_true (propagate_household_false le, phplus_include_household ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b  and 
						  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.rules  | Translation_Codes.rules_bitmap_code('Household'), 
						  le.rules );
	
	self.src_rule := if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule );
							
    self := le;
end;


propagate_household_true := join(distribute(propagate_household_false, hash(npa+phone7)), 
							 phplus_include_household,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.hhid = right.hhid,
							 t_propagate_household_true(left, right), 
							  left outer,
							 local);	
							 
//-----------Propagate inclusion flag and rules to records that have the same last name and address

phplus_include_same_nm_addr := dedup(sort(distribute(propagate_household_true(in_flag and rules <> 0b), hash(npa+phone7)), npa+phone7, lname, prim_range, prim_name, sec_range, zip5, rules, local),npa+phone7,lname, prim_range, prim_name, sec_range, zip5, local) ;

recordof(phplus_in) t_propagate_same_nm_addr_true (propagate_household_true le, phplus_include_same_nm_addr ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b  and 
						  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.rules  | Translation_Codes.rules_bitmap_code('Household'), 
						  le.rules );
							
	 self.src_rule := if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
							
    self := le;
end;


propagate_same_nm_addr_true := join(distribute(propagate_household_true, hash(npa+phone7)), 
							 phplus_include_same_nm_addr,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.lname = right.lname and
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.sec_range = right.sec_range and
							 left.zip5 = right.zip5,
							 t_propagate_same_nm_addr_true(left, right), 
							  left outer,
							 local);	


//-----------Propagate include rules for same phone same last name for recs with did =0 or there is no address

phplus_include_household_ph_lnm := dedup(sort(distribute(propagate_same_nm_addr_true(in_flag and rules <> 0b and (pdid > 0 or prim_name = '')), hash(npa+phone7)), npa+phone7, lname, rules, local),npa+phone7,lname, local) ;

recordof(phplus_in) t_propagate_household_true_ph_lnm (propagate_same_nm_addr_true le, phplus_include_household_ph_lnm  ri) := transform 
	self.in_flag 	:= if(ri.rules <> 0b  and 
						  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.in_flag, 
						  le.in_flag);
	self.rules 	:= if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  ri.rules  | Translation_Codes.rules_bitmap_code('Household'), 
						  le.rules );
	
	self.src_rule := if(ri.rules <> 0b  and 
		                  (le.rules = 0b or 
						  Translation_Codes.fFlagIsOn(le.rules, Translation_Codes.rules_bitmap_code('Disconnected-EDA'))), 
						  le.src | ri.src | le.src_rule | ri.src_rule, le.src |le.src_rule);
							
    self := le;
end;


propagate_household_true_ph_lnm := join(distribute(propagate_same_nm_addr_true, hash(npa+phone7)), 
							 phplus_include_household_ph_lnm ,
							 left.npa+left.phone7 = right.npa+right.phone7 and
							 left.lname = right.lname,
							 t_propagate_household_true_ph_lnm(left, right), 
							  left outer,
							 local);

return propagate_household_true_ph_lnm;

end;