export fn_invalid_dates_base_correction(string filedate) := function

full_did := utilfile.file_util.full_did((unsigned)did > 0);
full_no_did := utilfile.file_util.full_did((unsigned)did = 0);

temp_rec := record

UtilFile.Layout_DID_Out;
string8   old_connect_date := '';
string8   old_date_first_seen := '';
string1		csa_indicator := '';

end;

pre_csa := project(full_did, temp_rec);
p2_dist  := distribute(pre_csa((addr_type = 'S' or (addr_type = 'B' and addr_dual = 'N')) and date_first_seen <> ''),hash(did));
p2_sort  := sort      (p2_dist,did,prim_range,prim_name,zip,date_first_seen,connect_date,local);
p2_group := group(p2_sort, did,prim_range,prim_name,zip, local);

min_dates(string l, string r) := if(l<>'' and r<>'', min(l, r), if(l<>'', l, r));

p2_sort trollup(p2_sort le, p2_sort ri) := transform
 self.date_first_seen := min_dates(le.date_first_seen,ri.date_first_seen);
 self.connect_date   := min_dates(le.connect_date,ri.connect_date);
 self := le;
end;

p2_rollup := group(rollup(p2_group,true,trollup(left,right)));

pre_csa tjoin(pre_csa le, p2_rollup ri) := transform
self.date_first_seen := if(le.addr_type = 'B' and le.addr_dual = 'Y' and le.date_first_seen <> '' and le.date_first_seen < ri.date_first_seen, ri.date_first_seen, le.date_first_seen);
self.connect_date := if(le.addr_type = 'B' and le.addr_dual = 'Y' and le.connect_date <> '' and le.connect_date < ri.connect_date, ri.connect_date, le.connect_date);
self.csa_indicator   := if(le.addr_type = 'B' and le.addr_dual = 'Y' and le.date_first_seen <> '' and le.date_first_seen < ri.date_first_seen, 'Y',
if(le.addr_type = 'B' and le.addr_dual = 'Y' and le.date_first_seen <> '' and le.date_first_seen >= ri.date_first_seen and ri.date_first_seen <> '', 'N', le.csa_indicator));
self.old_connect_date := le.connect_date;
self.old_date_first_seen := le.date_first_seen;
self := le;

end;

csa_out := join(distribute(pre_csa,hash(did)), p2_rollup, left.did = right.did 
and left.prim_name = right.prim_name 
and left.prim_range = right.prim_range
and left.zip=right.zip, tjoin(left,right), left outer,local);

output_did := output(csa_out + project(full_no_did, temp_rec),,'~thor_data400::base::utility_DID_'+ filedate + '_invalid_dates_correction', overwrite, __compressed__);

util_base := utilfile.file_util.full_base;

//appending csa indicator and correction dates from DID file

util_base_dist := distribute(util_base, hash(id));

util_base_dist tjoin_did(util_base_dist le, csa_out ri) := transform

self.csa_indicator := if(le.csa_indicator='U' or ri.csa_indicator = '', le.csa_indicator, ri.csa_indicator);
self.date_first_seen := ri.date_first_seen;
self.connect_date := ri.connect_date;
self.did := ri.did;
self := le;

end;

util_base_csa := join(util_base_dist, distribute(csa_out,hash(id)),
left.id = right.id and
left.exchange_serial_number = right.exchange_serial_number and 
left.date_added_to_exchange = right.date_added_to_exchange and
left.addr_type = right.addr_type and 
left.address_street = right.address_street and
left.address_street_name = right.address_street_name and
left.address_zip = right.address_zip and 
left.fname = right.fname and
left.mname = right.mname and
left.lname = right.lname and 
left.name_suffix = right.name_suffix and
left.prim_name = right.prim_name and
left.p_city_name = right.p_city_name and 
left.cart = right.cart and 
left.cr_sort_sz = right.cr_sort_sz and 
left.lot = right.lot and 
left.lot_order = right.lot_order and 
left.dbpc = right.dbpc and 
left.chk_digit = right.chk_digit and 
left.rec_type = right.rec_type and 
left.county = right.county and 
left.geo_lat = right.geo_lat and 
left.geo_long = right.geo_long and 
left.msa = right.msa and 
left.geo_blk = right.geo_blk and 
left.geo_match = right.geo_match and
left.err_stat = right.err_stat, tjoin_did(left,right),left outer, local);

output_base := output(util_base_csa,,'~thor_data400::base::utility_' + filedate + '_invalid_dates_correction', overwrite, __compressed__);

return sequential(output_did, output_base);

end;

