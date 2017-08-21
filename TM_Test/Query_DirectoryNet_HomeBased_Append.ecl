import gong, YellowPages, ut;

// Append phone numbers from Gong for residential (home-based) businesses based on match to contact
dn_init := TM_Test.directorynet_group_phone_best(bus_best_phone = '' and lname <> '' and zip <> '' and prim_name <> '');
dn_init_other := TM_Test.directorynet_group_phone_best(not(bus_best_phone = ''and lname <> ''and zip <> '' and prim_name <> ''));

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
				   
output(enth(dn_addr_append(bus_best_phone <> ''),300),all);
