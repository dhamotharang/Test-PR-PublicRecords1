
import header, ut;
EXPORT Proc_build_UCTUE_hist(string filedate) := function


uctue_raw := UtilFile.file_utility_nctue_in ;

base_in_house := utilfile.file_util.full_base;


r1 := record

 utilfile.layout_utility_nctue_in;
 string73       full_name;
 string183      full_S_address;
 string183      full_B_address;

end;

r2 := record

base_in_house;
 string73       full_name;
 string183      full_address;

end;
//mapping UCTUE
r1 x1(uctue_raw le) := transform
 
 self.full_name := trim(le.fname, left, right) + trim(le.mname, left, right) + trim(le.lname, left, right)
                  + trim(le.name_suffix, left, right); 
 self.full_s_address := trim(le.Svc_addr_street, left, right) + trim(le.Svc_addr_street_name, left, right) + trim(le.Svc_addr_street_Type, left, right) 
                   + trim(le.Svc_addr_street_direction, left, right) + trim(le.Svc_addr_apartment, left, right) + trim(le.Svc_addr_city, left, right) 
									 + trim(le.Svc_addr_state, left, right) + trim(le.Svc_addr_zip, left, right); 
 self.full_B_address := trim(le.BUS_addr_street, left, right) + trim(le.BUS_addr_street_name, left, right) + trim(le.BUS_addr_street_Type, left, right) 
                   + trim(le.BUS_addr_street_direction, left, right) + trim(le.BUS_addr_apartment, left, right) + trim(le.BUS_addr_city, left, right) 
									 + trim(le.Bus_addr_state, left, right) + trim(le.BUS_addr_zip, left, right); 

 self     := le;
end;

p1      := project(uctue_raw, x1(left));
p1_dist := distribute(p1,hash(exchange_reference_number,full_name));

r2  x2(base_in_house le) := transform
 
 self.full_name := trim(le.orig_fname, left, right) + trim(le.orig_mname, left, right) + trim(le.orig_lname, left, right)
                  + trim(le.orig_name_suffix, left, right); 
 self.full_address := trim(le.address_street, left, right) + trim(le.address_street_name, left, right) + trim(le.address_street_type, left, right) 
                   + trim(le.address_street_direction, left, right) + trim(le.address_apartment, left, right) + trim(le.address_city, left, right) 
									 + trim(le.address_state, left, right) + trim(le.address_zip, left, right); 
 
 self                   := le;
end;

p2      := project(base_in_house, x2(left));
p2_dist := distribute(p2,hash(exchange_serial_number,full_name));


utilfile.layout_utility_nctue_in x3(p1 le, p2 ri) := transform
 
 self                   := le;
end;


rollup_all1 := join(p1_dist(full_s_address = full_b_address),p2_dist,left.full_name =right.full_name and left.full_s_address = right.full_address 

and left.full_b_address = right.full_address and
 
left.exchange_reference_number = right.exchange_serial_number and
left.most_recent_update_date = right.date_added_to_exchange and left.last_update_date = right.connect_date and
left.addr_type = right.util_type and left.ssn = right.ssn and 
left.wrk_phone = right.work_phone and left.svc_phone = right.phone and left.drivers_license_state_code = right.drivers_license_state_code
and left.drivers_license = right.drivers_license
// and left.csa_uca_indicator = right.csa_indicator
 ,x3(left,right), left only, local);//:persist('~thor_data400::persist::uctue_util_hist_rollup');

same_rec1 := dedup(rollup_all1, all);

utilfile.layout_utility_nctue_in x4(p1 le, p2 ri) := transform
 
 self                   := le;
end;


rollup_all2 := join(p1_dist(full_s_address <> full_b_address),p2_dist,left.full_name =right.full_name and (left.full_s_address = right.full_address 

or left.full_b_address = right.full_address) and
 
left.exchange_reference_number = right.exchange_serial_number and
left.most_recent_update_date = right.date_added_to_exchange and left.last_update_date = right.connect_date and
left.addr_type = right.util_type and left.ssn = right.ssn and 
left.wrk_phone = right.work_phone and left.svc_phone = right.phone and left.drivers_license_state_code = right.drivers_license_state_code
and left.drivers_license = right.drivers_license
// and left.csa_uca_indicator = right.csa_indicator
 ,x4(left,right), left only, local);//:persist('~thor_data400::persist::uctue_util_hist_rollup');

same_rec2 := dedup(rollup_all2, all);

same_rec := same_rec1 + same_rec2;

NCTUE_clean := UtilFile.map_util_nctue_hist(same_rec).util_nctue_clean;
	header.MAC_555_phones(NCTUE_clean, work_phone, nctue_utils_clean_workphone);
	header.MAC_555_phones(nctue_utils_clean_workphone, phone, nctue_utils_clean_phone0);
    ut.mac_flipnames(nctue_utils_clean_phone0,fname,mname,lname,nctue_utils_clean_phone);
	clean_phone := output(nctue_utils_clean_phone,,'~thor_data400::in::nctue_utils_hist_cleanphone_'+filedate,__compressed__,overwrite);
    nctue_canadian := UtilFile.map_util_nctue_hist(same_rec).util_nctue_canadian;
	daily_canadian_clean := output(nctue_canadian,,'~thor_data400::in::nctue_utils_hist_canadian_'+filedate,__compressed__,overwrite);
	//full util
  util_nctue_full := 	dataset('~thor_data400::in::nctue_utils_hist_cleanphone_'+filedate,utilfile.Layout_Util.base, flat);
	did_nctue := output(UtilFile.did_nctue_hist(util_nctue_full),,'~thor_data400::in::utility::'+filedate+'::nctue_hist_did',__compressed__,overwrite);
	
	add_nctue_base := FileServices.AddSuperFile('~thor_data400::base::utility_file', '~thor_data400::in::nctue_utils_hist_cleanphone_'+filedate); 

	add_nctue_did := fileservices.addsuperfile('~thor_data400::base::utility_DID','~thor_data400::in::utility::'+filedate+'::nctue_hist_did');

build_util_nctue := sequential(clean_phone,daily_canadian_clean,did_nctue,add_nctue_base,add_nctue_did);

return build_util_nctue;

end;
