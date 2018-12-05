export mac_get_type_c(f_c_did, f_c_acctno, f_c_out, is_glb_ok=true, use_landlord=false, use_input_only=false, modAccess) := macro
  import progressive_phone, header, ut, gong, risk_indicators, NID, Std;
	
#uniquename(gong_addr_key)
%gong_addr_key% := gong.Key_History_Address;

#uniquename(apt_building_key)
%apt_building_key% := header.Key_AptBuildings;

#uniquename(a2s_key)
%a2s_key% := risk_indicators.Key_HRI_Address_To_Sic;

//all addresses with a date last seen newer than six months

#uniquename(blue_recs)
progressive_phone.mac_get_blue(f_c_did, %blue_recs%, true, true, false, modAccess)

#uniquename(todays_date)
%todays_date% := (string8) Std.Date.Today();

#uniquename(f_six_months)
%f_six_months% := %blue_recs%(ut.DaysApart(%todays_date%,(string6)dt_last_seen + '15')<=180,
                              src<>'' or ut.DaysApart(%todays_date%,(string6)dt_vendor_last_reported + '15')<=180);

//all addresses from the input	
#uniquename(get_c_in)
progressive_phone.layout_header_seq %get_c_in%(f_c_acctno l) := transform
	SELF.did := 0;
     SELF.dt_first_seen := 0;
	SELF.dt_last_seen := 0;
	SELF.phone := l.phone10;
	SELF.dob := (integer4)l.dob;
	SELF.name_suffix := l.suffix;
     SELF.suffix := l.addr_suffix;
     SELF.city_name := l.p_city_name;
	SELF.st := l.st;
	SELF.zip := l.z5;
	SELF := l;
     SELF := [];
end;

#uniquename(f_c_in)
%f_c_in% := project(f_c_acctno, %get_c_in%(left))(prim_name[1..6]<>'PO BOX', prim_name[1..3]<>'DOD'); 

//dedup the input & six months' addresses
#uniquename(f_c_to_match)
%f_c_to_match% := dedup(sort(%f_six_months%, seq, prim_name, zip, prim_range, fname, lname, -sec_range, -dt_last_seen),
                        seq, prim_name, zip, prim_range, fname, lname);

#uniquename(batch_out_ext_rec)
%batch_out_ext_rec% := record
	progressive_phone.layout_progressive_batch_out_with_did;
	string5  z5;
	string1  listing_type_bus;
     string1  listing_type_res;
     string1  listing_type_gov;
	unsigned1 business_addr_priority;
	string5  business_addr_type;  
end;

#uniquename(get_type_c_raw)
%batch_out_ext_rec% %get_type_c_raw%(%f_c_to_match% l, 
                                     %gong_addr_key% r) := transform
	self.acctno := if(r.phone10='', skip, (string20)l.seq);
     self.subj_first := l.fname;
     self.subj_middle := l.mname;
     self.subj_last := l.lname;
     self.subj_suffix := l.name_suffix; 
	self.subj_phone10 := r.phone10;
     self.subj_name_dual := r.listed_name;
     self.subj_phone_type := '3';
     self.subj_date_first := if(l.dt_first_seen=0 and l.dt_last_seen=0, r.dt_first_seen[1..6], (string8)l.dt_first_seen);
     self.subj_date_last := if(l.dt_first_seen=0 and l.dt_last_seen=0, %todays_date%[1..6], (string8)l.dt_last_seen);
		 self.subj_phone_date_last := %todays_date%[1..6];
     self.phpl_phones_plus_type := map(r.listing_type_res<>''=>r.listing_type_res,
	                         r.listing_type_bus<>''=>r.listing_type_bus,
						r.listing_type_gov);
	self.prim_range := r.prim_range;
	self.prim_name := r.prim_name;
	self.sec_range := r.sec_range;
	self.z5 := r.z5;
	self.listing_type_bus := r.listing_type_bus;
     self.listing_type_res := r.listing_type_res;
     self.listing_type_gov := r.listing_type_gov;
	self.business_addr_priority := 99;
	SELF.did := l.did;
	self.addr_suffix := r.suffix;
	self.zip5 := r.z5;
	self.p_did := r.did;
  self.p_name_last := r.name_last;
	 self.p_name_first := r.name_first;
	 self.sub_rule_number := 31;
	self := r;
	self := [];											   
end;
		
#uniquename(f_c_out_found_precheck)		
%f_c_out_found_precheck% := join(%f_c_to_match%, %gong_addr_key%,
		              keyed(left.prim_name = right.prim_name) and
		              keyed(left.zip = right.z5) and
		              keyed(left.prim_range = right.prim_range) and
									keyed(left.st = right.st) and right.current_flag = true and
		              (left.sec_range = '' or left.sec_range = right.sec_range or
		   	          NID.mod_PFirstTools.PFLeqPFR(left.fname, right.name_first) and
			            STD.Str.EditDistance(left.lname, right.name_last)<2 or
				          right.listing_type_bus<>'' and right.listed_name<>'' and right.name_last='' and right.name_first=''),
		              %get_type_c_raw%(left, right), limit(ut.limits.PHONE_PER_ADDRESS, skip));

#uniquename(f_c_out_found)		
%f_c_out_found% := IF(strict_apsx,
					JOIN(%f_c_out_found_precheck%, gong.Key_History_phone,
						keyed(LEFT.subj_phone10[4..10]=RIGHT.p7) AND
						keyed(LEFT.subj_phone10[1..3]=RIGHT.p3) AND
						RIGHT.current_flag AND (LEFT.did=RIGHT.did OR RIGHT.did=0), 
						TRANSFORM(%batch_out_ext_rec%, SELF := LEFT),
						KEEP(1), ATMOST(100)), %f_c_out_found_precheck%);

#uniquename(f_c_out_input)
%f_c_out_input% := join(%f_c_in%, %gong_addr_key%,
		              keyed(left.prim_name = right.prim_name) and
		              keyed(left.zip = right.z5) and
		              keyed(left.prim_range = right.prim_range) and
									keyed(left.st = right.st) and right.current_flag = true and
		              (left.sec_range = '' or left.sec_range = right.sec_range or
		   	          NID.mod_PFirstTools.PFLeqPFR(left.fname,right.name_first) and
			            STD.Str.EditDistance(left.lname, right.name_last)<2 or
				          right.listing_type_bus<>'' and right.listed_name<>'' and right.name_last='' and right.name_first=''),
		              %get_type_c_raw%(left, right), limit(ut.limits.PHONE_PER_ADDRESS, skip));

#uniquename(get_out_input_only)
%f_c_out_input% %get_out_input_only%(%f_c_out_input% l) := transform
	self := l;
end;

#uniquename(f_c_out_raw)
%f_c_out_raw% := if(use_input_only, %f_c_out_input%,
                    join(%f_c_out_input%, %f_c_out_found%,
                        left.acctno = right.acctno,
				                %get_out_input_only%(left), left only) + %f_c_out_found%);

#uniquename(get_apt_priority)
%batch_out_ext_rec% %get_apt_priority%(%f_c_out_raw% l, %apt_building_key% r) := transform
	self.business_addr_priority := if(r.prim_name<>'', 1, l.business_addr_priority);
	self.business_addr_type := if(r.prim_name<>'', 'APRT', l.business_addr_type);  
	self := l;
end; 

#uniquename(f_c_out_priority_apt)
%f_c_out_priority_apt% := join(%f_c_out_raw%, %apt_building_key%,
                               keyed(left.prim_range = right.prim_range) and
                               keyed(left.prim_name = right.prim_name) and
                               keyed(left.z5 = right.zip) and 
                               right.apt_cnt>1 and left.listing_type_bus<>'', 
                               %get_apt_priority%(left, right), left outer,
                               keep(1), limit (0)); // actual stat on the keyed fields above: ~60


#uniquename(get_sic_priority)
%batch_out_ext_rec% %get_sic_priority%(%f_c_out_priority_apt% l, %a2s_key% r) := transform
	self.business_addr_priority := map(r.sic_code='2210' => 2,
	                                   r.sic_code='2215' => 3,
								                     r.sic_code='2250' => 4,
								                     l.business_addr_priority);
	self.business_addr_type := map(r.sic_code='2210' => 'HOTL',
	                               r.sic_code='2215' => 'CAMP',
																 r.sic_code='2230' => 'ROOM',
 																 r.sic_code='2250' => 'NURS',
																 r.sic_code='2380' => 'REST',
																 r.sic_code='2381' => 'NURS',
							                   l.business_addr_type); 
	self := l;
end; 

#uniquename(f_c_out_priority_sic)
%f_c_out_priority_sic% := join(%f_c_out_priority_apt%, %a2s_key%,
                               keyed(left.z5=right.z5) and
                               keyed(left.prim_name=right.prim_name) and
                               left.prim_range=right.prim_range and
                               ut.nneq(left.sec_range,right.sec_range) and
                               left.listing_type_bus<>'',
                               %get_sic_priority%(left, right), left outer,
                               keep(1), limit (0)); // actual count: keyed ~560, all ~30

#uniquename(f_c_out_appended)
%f_c_out_appended% := if(use_landlord, 
                         %f_c_out_priority_sic%, 
                         %f_c_out_priority_sic%(business_addr_type='' or business_addr_type='APRT'));

#uniquename(f_c_out_dep)		
%f_c_out_dep% := GROUP(SORT(group(dedup(sort(%f_c_out_appended%(listing_type_bus<>''), acctno,  
                                  business_addr_priority, subj_phone10, -subj_date_last, -subj_date_first),
				              acctno) +
				   dedup(sort(%f_c_out_appended%(listing_type_bus=''), acctno, 
				              subj_phone10, -subj_date_last, -subj_date_first),
				              acctno, subj_phone10)),  
				acctno), acctno);
					 


					
#uniquename(f_c_out_final)
%f_c_out_final% := GROUP(project(TopN(%f_c_out_dep%,4,
                                acctno, if(listing_type_bus<>'', 1, 2), business_addr_priority, 
					  	  -subj_date_last, -subj_date_first), 
                           progressive_phone.layout_progressive_batch_out_with_did));			
		
progressive_phone.mac_get_back_acctno(%f_c_out_final%, f_c_acctno, f_c_out_raw)

f_c_out := if(use_input_only, %f_c_out_final%, f_c_out_raw);

endmacro;