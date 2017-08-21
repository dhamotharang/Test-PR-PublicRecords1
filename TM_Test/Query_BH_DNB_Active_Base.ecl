// Calculate active businesses and groups
// A business is assumed to be active if an update from any source has been received
// in the last year.  Business must have a non-blank address
// Future: include only trusted source types (TBD)

bh := Business_Header.File_Business_Header_Base;

earliest_date := 20050701;

layout_bdid_date := record
bh.bdid;
unsigned6 group_id := 0;
bh.source;
bh.dt_last_seen;
bh.state;
string1 phone_active := 'N';
string1 active_dnb := 'N';
end;

bh_dates := table(bh(dt_last_seen >= earliest_date, zip <> 0, prim_name <> '', state <> '',
                     not (source = 'D' and fein <> 0),  ut.st2FipsCode(state) <> ''/* ,
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC '] */), layout_bdid_date);

// Append group ids
bhg := Business_Header.File_Super_Group;

bh_dates_gid := join(bh_dates,
                     bhg,
				 left.bdid = right.bdid,
				 transform(layout_bdid_date, self.group_id := right.group_id, self := left),
				 hash);

bh_dates_dist := distribute(bh_dates_gid, hash(bdid));
bh_dates_sort := sort(bh_dates_dist, bdid, -dt_last_seen, local);
bh_dates_dedup := dedup(bh_dates_sort, bdid, local);

output(count(bh_dates_dedup), named('Active_Businesses_By_Date'));

bh_dates_gid_dedup := dedup(bh_dates_dedup, group_id, all);

output(count(bh_dates_gid_dedup), named('Active_Groups_By_Date'));

// Determine how many have an active phone number

layout_bdid_phone := record
unsigned6 bdid;
unsigned6 group_id;
string10 phone10;
string1 phone_active := 'N';
end;

bh_phones := join(bh(phone <> 0, phone >= 10000000, phone < 10000000000),
                  bh_dates_dedup,
			   left.bdid = right.bdid,
			   transform(layout_bdid_phone,
			             self.phone10 := intformat(left.phone, 10, 1),
					   self := right),
			   hash);
			   
bh_phones_dedup := dedup(bh_phones, all);

// Append an active flag for the phone if phone is known to be active
// in either Gong or Yellow Pages

layout_input_phone_active := record
bh_phones_dedup.phone10;
bh_phones_dedup.phone_active;
end;

bh_phone_active_init := table(bh_phones_dedup, layout_input_phone_active);
bh_phone_active_init_dist := distribute(dedup(bh_phone_active_init, all), hash(phone10));

gf := Gong.File_Gong_History_Full(phone10 <> '');

layout_phone_info := record
gf.phone10;
gf.current_record_flag;  
end;

gf_phone_info := table(gf(current_record_flag = 'Y'), layout_phone_info);
gf_phone_info_dedup := dedup(gf_phone_info, all);

yp := YellowPages.Files.Base.QA(source='Y');

yp_phone_info := project(yp(source = 'Y', phone10 <> ''),
                         transform(layout_phone_info, self.current_record_flag := 'Y', self := left));
					
yp_phone_info_dedup := dedup(yp_phone_info, all);

gyp_phone_info_dedup := dedup(gf_phone_info_dedup + yp_phone_info_dedup, all);
gyp_phone_info_dedup_dist := distribute(gyp_phone_info_dedup, hash(phone10));

bh_phone_active_append := join(gyp_phone_info_dedup_dist,
                                          bh_phone_active_init_dist,
								  left.phone10 = right.phone10,
								  transform(layout_input_phone_active, self.phone_active := if(left.current_record_flag = 'Y', 'Y', 'N'),
								                                       self := right),
								  right outer,
								  local);
								  
// Append active phone flag
bh_phone_active := join(distribute(bh_phones_dedup, hash(phone10)),
                                   bh_phone_active_append,
						     left.phone10 = right.phone10,
						     transform(layout_bdid_phone,
							           self.phone_active := right.phone_active,
									 self := left),
						     left outer,
						     local);
							
bh_phone_active_dist := distribute(bh_phone_active, hash(bdid));
bh_phone_active_sort := sort(bh_phone_active_dist, bdid, if(phone_active = 'Y', 0, 1), local);
bh_phone_active_dedup := dedup(bh_phone_active_sort, bdid, local);


output(count(bh_phone_active_dedup(phone_active = 'Y')), named('Active_Businesses_with_Active_Phone'));

// Determine groups with at least one active phone
bh_phones_active_group_dist := distribute(bh_phone_active_dedup, hash(group_id));
bh_phones_active_group_sort := sort(bh_phones_active_group_dist, group_id, if(phone_active = 'Y', 0, 1), local);
bh_phones_active_group_dedup := dedup(bh_phones_active_group_sort, group_id, local);

output(count(bh_phones_active_group_dedup(phone_active = 'Y')), named('Active_Groups_with_Active_Phone'));

// Append phone active flag to base data
bh_active_base := join(bh_dates_gid,
                       bh_phone_active_dedup(phone_active = 'Y'),
				   left.bdid = right.bdid,
				   transform(layout_bdid_date,
				             self.phone_active := if(right.bdid <> 0, 'Y', left.phone_active),
						   self := left),
				   left outer,
				   hash);

// Append an active flag for D&B companies
dnb_companies := DNB.File_DNB_Base;

layout_dnb_companies_slim := record
dnb_companies.bdid;
dnb_companies.duns_number;
dnb_companies.active_duns_number;
dnb_companies.record_type;
end;

dnb_companies_slim := table(dnb_companies, layout_dnb_companies_slim);

dnb_active_current := dnb_companies_slim(active_duns_number = 'Y', record_type = 'C');
dnb_active_current_dedup := dedup(dnb_active_current, bdid, all);

bh_active_base_dnb := join(bh_active_base,
                           dnb_active_current_dedup,
				       left.bdid = right.bdid,
				       transform(layout_bdid_date,
				                 self.active_dnb := if(right.bdid <> 0, 'Y', left.active_dnb),
						       self := left),
				       left outer,
				       hash) : persist('TMTEST::bh_active_base_dnb');
					  
output(count(bh_active_base_dnb), named('Total_Active_Base'));
output(bh_active_base_dnb);
output(bh_active_base_dnb(phone_active='Y'));
output(bh_active_base_dnb(active_dnb='Y'));
