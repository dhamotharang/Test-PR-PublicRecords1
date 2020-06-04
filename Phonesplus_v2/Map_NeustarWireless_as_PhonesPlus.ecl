/*
	Maps NeustarWireless to a common layout 
	Jira: DF-24336
*/

//Jira DF-24903 - added mapping of geo_ fields and err_stat

import NeustarWireless, ut, _validate;

phone_f := NeustarWireless.Files.Base.Main(current_rec=true);

//map to a common layout
	PhonesPlus_V2.Layout_In_Phonesplus.Layout_In_Common t_map_common_layout(phone_f input) := Transform
	self.npa := input.phone [1..3];
	self.phone7 := input.phone [4..10];
	self.cellphone := input.phone;
	self.cellphoneidkey := hashmd5(input.phone[4..10] 
																+ input.clean_address.prim_range 
																+ input.clean_address.predir 
																+ input.clean_address.prim_name 
																+ input.clean_address.addr_suffix 
																+ input.clean_address.postdir 
																+ input.clean_address.unit_desig 
																+ input.clean_address.sec_range 
																+ input.clean_address.zip 
																+ input.cln_lname 
																+ input.cln_fname);

	self.phone7_did_key := hashmd5(input.phone[4..10] + input.did);
	self.pdid := 0;
	self.did := input.did;
	self.did_score := (string3) input.did_score;
	self.datefirstseen := 0;
	self.datelastseen := 0; 
	self.datevendorlastreported := (unsigned3) _validate.date.fCorrectedDateString((string) input.date_vendor_last_reported )[1..6]; 
	self.datevendorfirstreported := (unsigned3) _validate.date.fCorrectedDateString((string) input.date_vendor_first_reported )[1..6]; 
	self.dt_nonglb_last_seen := 0;
	self.glb_dppa_flag := '';
	self.glb_dppa_all := '';
	self.vendor := input.source; //"N2"
	self.source := input.source; //DF-25784
	self.src_all := PhonesPlus_V2.translation_codes.source_bitmap_code(input.source);
	self.append_avg_source_conf := 0;
	self.append_max_source_conf := 0;
	self.append_min_source_conf := 0;
	self.append_total_source_conf := 0;
	self.orig_dt_last_seen := 0;
	self.origname := ut.CleanSpacesAndUpper(input.fname + ' ' + input.mname + ' ' + input.suffix + ' ' + input.lname);
	self.address1 := input.append_prep_address_1;
	self.address2 := '';
	self.address3 := '';
	self.origcity := input.city;
	self.origstate := input.state;
	self.origzip := input.zip;
	self.orig_phone := input.phone;
	self.dob := input.cln_dob;
	self.agegroup := '';
	self.gender := input.gender;
	self.orig_listing_type := '';
	self.listingtype := '';
	self.orig_publish_code := '';
	self.orig_phone_type := '';
	self.orig_phone_usage := '';
	self.company := if (input.nametype = 'B', ut.CleanSpacesAndUpper(input.fname + ' ' + input.mname + ' ' + input.suffix + ' ' + input.lname), '');
	self.orig_phone_reg_dt := 0;
	self.orig_carrier_code := '';
	self.orig_carrier_name := '';
	self.orig_conf_score := '';
	self.orig_rec_type := 0;
	self.clean_company := if(input.nametype = 'B', input.cln_fullname, '');
	self.prim_range := input.clean_address.prim_range;
	self.predir := input.clean_address.predir;
	self.prim_name := input.clean_address.prim_name;
	self.addr_suffix := input.clean_address.addr_suffix;
	self.postdir := input.clean_address.postdir;
	self.unit_desig := input.clean_address.unit_desig;
	self.sec_range := input.clean_address.sec_range;
	self.p_city_name := input.clean_address.p_city_name;
	self.v_city_name := input.clean_address.v_city_name;
	self.state := input.clean_address.st;
	self.zip5 := input.clean_address.zip;
	self.zip4 := input.clean_address.zip4;
	self.cart := input.clean_address.cart;
	self.cr_sort_sz := input.clean_address.cr_sort_sz;
	self.lot := input.clean_address.lot;
	self.lot_order := input.clean_address.lot_order;
	self.dpbc := input.clean_address.dbpc;
	self.chk_digit := input.clean_address.chk_digit;
	self.geo_lat := input.clean_address.geo_lat;
	self.geo_long := input.clean_address.geo_long;
	self.geo_blk := input.clean_address.geo_blk;
	self.geo_match := input.clean_address.geo_match;
	self.err_stat := input.clean_address.err_stat;
	self.rec_type := input.clean_address.rec_type;
	self.ace_fips_st := input.clean_address.county[1..2]; 
	self.ace_fips_county := input.clean_address.county[3..5]; 
	self.title := input.cln_title;
	self.fname := input.cln_fname;
	self.mname := input.cln_mname;
	self.lname := input.cln_lname;
	self.name_suffix := input.cln_suffix;
	self.name_score := '';
	self.bdid := 0;
	self.bdid_score := 0;
	self.agreg_listing_type := ''; 
	self.max_orig_conf_score := 0;
	self.min_orig_conf_score := 0;
	self.cur_orig_conf_score := 0;
	self.activeflag := '';
	self.rawaid := input.rawaid;
	self.cleanaid := input.aceaid;
	//nuestar only rules
	self.activity_status := input.activity_status; 	//DF-25784
	self.prepaid := input.prepaid; 									//DF-25784
	self.verified := input.verified; 								//DF-25784
	self.cord_cutter:= input.cord_cutter; 					//DF-25784
	activity_status_rule := MAP
													(	input.activity_status= 'A1' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A1'),
														input.activity_status= 'A2' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A2'),
														input.activity_status= 'A3' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A3'),
														input.activity_status= 'A4' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A4'),
														input.activity_status= 'A5' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A5'),
														input.activity_status= 'A6' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A6'),
														input.activity_status= 'A7' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-A7'),
														input.activity_status= 'I1' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I1'),
														input.activity_status= 'I2' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I2'),
														input.activity_status= 'I3' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I3'),
														input.activity_status= 'I4' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I4'),
														input.activity_status= 'I5' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I5'),
														input.activity_status= 'I6' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I6'),
														input.activity_status= 'I7' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-I7'),
														input.activity_status= 'U'  => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Activity-Status-U'),
														0b);

	prepaid_rule := MAP 
									( input.prepaid= 'Y' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-Y'),
										input.prepaid= 'N' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Prepaid-N'),
										0b);

	verified_rule	:= MAP
									( input.verified = 'A' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-A'),
										input.verified = 'B' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-B'),
										input.verified = 'C' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-C'),
										input.verified = 'D' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-D'),
										input.verified = 'E' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Verified-E'),
										0b);

	cord_cutter_rule := MAP									
											( input.cord_cutter= 'Y' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-Y'),
												input.cord_cutter= 'N' => PhonesPlus_V2.Translation_Codes.rules_bitmap_code('NeustarWireless-Cord-Cutter-N'),
												0b);	
	
	self.rules := activity_status_rule | prepaid_rule | verified_rule | cord_cutter_rule;
	
	self := input;
end;

EXPORT Map_NeustarWireless_as_PhonesPlus := project(phone_f,t_map_common_layout(left)) 
									  :persist('~thor_data400::persist::Phonesplus::Map_NeustarWireless_as_PhonesPlus');			  

