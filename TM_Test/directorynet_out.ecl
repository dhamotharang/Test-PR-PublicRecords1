import gong, YellowPages, ut;

// Append phone numbers from Gong for residential (home-based) businesses based on match to contact
dn_init := directorynet_group_phone_best(bus_best_phone = '' and lname <> '' and zip <> '' and prim_name <> '');
dn_init_other := directorynet_group_phone_best(not(bus_best_phone = ''and lname <> ''and zip <> '' and prim_name <> ''));

gf := Gong.File_Gong_History_Full(phone10 <> '');
gf_res := gf(current_record_flag = 'Y', listing_type_res <> '', name_last <> '', z5 <> '', prim_name <> '');
gf_res_dedup := dedup(gf_res, name_last, z5, prim_name, prim_range, all);

dn_addr_append := join(dn_init,
                       gf_res_dedup,
				   left.zip = right.z5 and
				     left.prim_name = right.prim_name and
					left.prim_range = right. prim_range and
					left.lname = right.name_last and
					ut.NNEQ(left.sec_range, right.sec_range),
				   transform(TM_Test.Layout_DirectoryNet_Base, self.bus_best_phone := right.phone10, self := left),
				   left outer,
				   hash);
				   
dn_init_all := dn_addr_append + dn_init_other;
				   
dn_out_init := project(dn_init_all,
                       transform(Layout_DirectoryNet_Out,
				             self.business_phone := left.bus_best_phone,
						   self := left));

// Append an active flag for the phone if phone is known to be active
// in either Gong or Yellow Pages

layout_input_phone_active := record
string10 phone10 := dn_out_init.business_phone;
string1 input_phone_active := '';
end;

dn_phone_active_init := table(dn_out_init(business_phone <> ''), layout_input_phone_active);
dn_phone_active_init_dist := distribute(dedup(dn_phone_active_init, all), hash(phone10));


layout_phone_info := record
gf.phone10;
gf.current_record_flag;  
end;

gf_phone_info := table(gf, layout_phone_info);

yp := DATASET('~thor_data400::base::yellowpages', YellowPages.Layout_YellowPages_Base,THOR);

yp_phone_info := project(yp(source = 'Y', phone10 <> ''),
                         transform(layout_phone_info, self.current_record_flag := 'Y', self := left));

gyp_phone_info_dist := distribute(gf_phone_info + yp_phone_info, hash(phone10));
gyp_phone_info_sort := sort(gyp_phone_info_dist, phone10, if(current_record_flag = 'Y', 0, 1), local);
gyp_phone_info_dedup := dedup(gyp_phone_info_sort, phone10, local);

dn_phone_active_append := join(gyp_phone_info_dedup,
                                          dn_phone_active_init_dist,
								  left.phone10 = right.phone10,
								  transform(layout_input_phone_active, self.input_phone_active := if(left.phone10 <> '', if(left.current_record_flag = 'Y', 'Y', 'N'), ''),
								                                       self := right),
								  right outer,
								  local);
								  
// Append active phone flag
dn_phone_active := join(distribute(dn_out_init(business_phone <> ''), hash(business_phone)),
                                   dn_phone_active_append,
						     left.business_phone = right.phone10,
						     transform(Layout_DirectoryNet_Out,
							           self.business_phone_active := right.input_phone_active,
									 self := left),
						     left outer,
						     local);

dn_phone_active_all := dn_phone_active + dn_out_init(business_phone = '');


export directorynet_out := dn_phone_active_all : persist('TMTEST::directorynet_out_mktapp_extended');
//export directorynet_out := dn_phone_active_all : persist('TMTEST::directorynet_out');