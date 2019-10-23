import codes;

in_file := TXBUS.Cleaned_Txbus_Addr;

Layout_Out := Txbus.Layouts_Txbus.Layout_AID_Common;

Dist_Cleaned_Txbus := distribute(in_file, hash64(Taxpayer_Number, Outlet_Number));

//Added Taxpayer_Org_Type_desc to the rollup process to make sure the rollup is done correctly.  Other wise there will
//be duplicates.  
Srt_Dist_Cleaned_Txbus := sort(Dist_Cleaned_Txbus, record, 
                               EXCEPT Process_date, dt_first_seen, dt_last_seen, Taxpayer_cart, Taxpayer_Org_Type_desc,
															 Taxpayer_cr_sort_sz, Taxpayer_lot, Taxpayer_lot_order, Taxpayer_geo_lat, Taxpayer_geo_long,
															 Taxpayer_geo_blk, Taxpayer_geo_match, outlet_cr_sort_sz, Outlet_lot, Outlet_lot_order, 
															 Outlet_geo_lat, outlet_geo_long, outlet_geo_blk, outlet_geo_match, outlet_cart,
															 Taxpayer_name_score, Taxpayer_err_stat, outlet_err_stat, local);

Layout_Out  rollupXform(Layout_Out l, Layout_Out r) := transform
	self.Process_Date   := if(l.Process_Date  > r.Process_Date, l.Process_Date, r.Process_Date);
	self.dt_first_seen  := if(l.dt_first_seen > r.dt_first_seen, r.dt_first_seen, l.dt_first_seen);
	self.dt_last_seen   := if(l.dt_last_seen  < r.dt_last_seen,  r.dt_last_seen,  l.dt_last_seen);
	self                := l;
end;

rolledup_file := rollup(Srt_Dist_Cleaned_Txbus, rollupXform(LEFT,RIGHT), RECORD,
						            EXCEPT Process_date, dt_first_seen, dt_last_seen, Taxpayer_cart, Taxpayer_Org_Type_desc,
															 Taxpayer_cr_sort_sz, Taxpayer_lot, Taxpayer_lot_order, Taxpayer_geo_lat, Taxpayer_geo_long,
															 Taxpayer_geo_blk, Taxpayer_geo_match, outlet_cr_sort_sz, Outlet_lot, Outlet_lot_order, 
															 Outlet_geo_lat, outlet_geo_long, outlet_geo_blk, outlet_geo_match, outlet_cart,
															 Taxpayer_name_score, Taxpayer_err_stat, outlet_err_stat, local);

//*** Code to explode the description values for Taxpayer_Org_type 
Layout_Out  getOrgType(rolledup_file l, codes.File_Codes_V3_In r) := transform
	self.Taxpayer_org_type_desc := If(trim(r.long_desc, left, right) != '', stringlib.StringToUpperCase(trim(r.long_desc,left, right)), '');
	self                        := l;
end;

Tans_file := join(rolledup_file,
		          codes.File_Codes_V3_In(trim(file_name, left, right) = 'TXBUS',trim(field_name, left, right) = 'TAXPAYER_ORG_TYPE'),
		          trim(left.Taxpayer_Org_type, left, right) = trim(right.code, left, right),
		          getOrgType(LEFT,RIGHT),left outer, lookup);
							
export Update_Txbus := Tans_file : persist(Txbus.Constants.Cluster + 'persist::txbus::Updated_Txbus');