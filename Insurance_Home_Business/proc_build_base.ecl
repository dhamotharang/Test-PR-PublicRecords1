import _control, address, address_file, ut;

foreclosure_monitoring_in := foreclosure_monitoring.file_foreclosure_monitoring_in;

// Clean address

layout_foreclosure_monitoring.l_foreclosure_monitoring_temp t_clean_addr(layout_foreclosure_monitoring.l_foreclosure_monitoring_in l) := transform
	string182 clean_address	:= AddrCleanLib.CleanAddress182(trim(l.address_street), trim(l.city) + ' ' + l.state + ' ' + l.zip + '-' + l.zip4);
	
	self.clean_addr.prim_range	:= clean_address[1..10];
	self.clean_addr.predir			:= clean_address[11..12];
	self.clean_addr.prim_name		:= clean_address[13..40];
	self.clean_addr.addr_suffix	:= clean_address[41..44];
	self.clean_addr.postdir			:= clean_address[45..46];
	self.clean_addr.unit_desig	:= clean_address[47..56];
	self.clean_addr.sec_range		:= clean_address[57..64];
	self.clean_addr.p_city_name	:= clean_address[65..89];
	self.clean_addr.v_city_name	:= clean_address[90..114];
	self.clean_addr.st					:= clean_address[115..116];
	self.clean_addr.zip					:= clean_address[117..121];
	self.clean_addr.zip4				:= clean_address[122..125];
	self.clean_addr.cart				:= clean_address[126..129];
	self.clean_addr.cr_sort_sz	:= clean_address[130];
	self.clean_addr.lot					:= clean_address[131..134];
	self.clean_addr.lot_order		:= clean_address[135];
	self.clean_addr.dbpc				:= clean_address[136..137];
	self.clean_addr.chk_digit		:= clean_address[138];
	self.clean_addr.rec_type		:= clean_address[139..140];
	self.clean_addr.fips_state	:= clean_address[141..142];
	self.clean_addr.fips_county	:= clean_address[143..145];
	self.clean_addr.geo_lat		 	:= clean_address[146..155];
	self.clean_addr.geo_long	 	:= clean_address[156..166];
	self.clean_addr.msa				 	:= clean_address[167..170];
	self.clean_addr.geo_blk		 	:= clean_address[171..177];
	self.clean_addr.geo_match	 	:= clean_address[178];
	self.clean_addr.err_stat	 	:= clean_address[179..182];

	self := l;
end;

p_foreclosure_clean_addr := project(foreclosure_monitoring_in, t_clean_addr(left)) : persist('foreclosure_clean_address');

foreclosure_addr_dist := distribute(p_foreclosure_clean_addr, hash(clean_addr.prim_range, clean_addr.prim_name, clean_addr.zip));
home_bus_address_file	:= sort(distribute(address_file.File_AddressID, hash(prim_range, prim_name, zip)), prim_range, prim_name, zip, local);

// Populate the home busness flag indicator

typeof(foreclosure_addr_dist) t_home_bus_ind(recordof(foreclosure_addr_dist) l, recordof(home_bus_address_file) r) := transform
	self.home_bus_ind	:= if(r.resident_flag = 'Y' and r.business_flag = 'Y', 'Y', '');
	self							:= l;
end;

jn_populate_homebusind_with_secrange := join(foreclosure_addr_dist, //(clean_addr.sec_range <> ''),
																						home_bus_address_file,
																						left.clean_addr.prim_range	= right.prim_range and
																						left.clean_addr.prim_name		= right.prim_name and
																						left.clean_addr.sec_range		= right.sec_range and
																						left.clean_addr.zip					= right.zip,
																						t_home_bus_ind(left, right),
																						left outer,
																						local
																						);
/*																						
output(count(jn_populate_homebusind_with_secrange(home_bus_ind = 'Y')), named('Good_HomeBusInd'));

// Rollup records with same prim name, prim range and zip

typeof(home_bus_address_file) t_rollup(home_bus_address_file l, home_bus_address_file r) := transform
	self.src_header			:= if(l.src_header <> '', l.src_header, r.src_header);
	self.src_bus_header	:= if(l.src_bus_header <> '', l.src_bus_header, r.src_bus_header);
	self.src_pcnsr			:= if(l.src_pcnsr <> '', l.src_pcnsr, r.src_pcnsr);
	self.src_gong				:= if(l.src_gong <> '', l.src_gong, r.src_gong);
	self.src_property		:= if(l.src_property <> '', l.src_property, r.src_property);
	self.src_so					:= if(l.src_so <> '', l.src_so, r.src_so);
	self.resident_flag	:= if(l.resident_flag <> '', l.resident_flag, r.resident_flag);
	self.business_flag	:= if(l.business_flag <> '', l.business_flag, r.business_flag);
	self.govt_flag			:= if(l.govt_flag <> '', l.govt_flag, r.govt_flag);
	
	self								:= l;
end;

rlp_home_bus_addr_file	:= rollup(home_bus_address_file,
																left.prim_range = right.prim_range and
																left.prim_name	= right.prim_name and
																left.zip				= right.zip,
																t_rollup(left,right),
																local
																);

jn_populate_homebusind_no_secrange := join(foreclosure_addr_dist(clean_addr.sec_range = ''),
																					rlp_home_bus_addr_file,
																					left.clean_addr.prim_range	= right.prim_range and
																					left.clean_addr.prim_name		= right.prim_name and
																					left.clean_addr.sec_range		= right.sec_range and
																					left.clean_addr.zip					= right.zip,
																					t_home_bus_ind(left, right),
																					left outer,
																					local
																					);

output(count(jn_populate_homebusind_no_secrange(home_bus_ind = 'Y')), named('Doubtful_HomeBusInd'));

output(jn_populate_homebusind_no_secrange,,'~thor_data400::temp::home_bus_ind',__compressed__,overwrite);
*/

// Transform the file to the orig vendor layout

jn_populate_home_bus_ind 				:= jn_populate_homebusind_with_secrange; //jn_populate_homebusind_with_secrange + jn_populate_homebusind_no_secrange;
jn_populate_home_bus_ind_dist		:= distribute(jn_populate_home_bus_ind, hash(experian_bus_id));
foreclosure_monitoring_in_dist	:= distribute(foreclosure_monitoring_in, hash(experian_bus_id));

foreclosure_home_bus := join(foreclosure_monitoring_in_dist,
															jn_populate_home_bus_ind_dist,
															left.experian_bus_id = right.experian_bus_id,
															transform(recordof(layout_foreclosure_monitoring.l_foreclosure_monitoring_out),
																				self.home_bus_ind := right.home_bus_ind; self := left),
															local
														);

ut.MAC_SF_BuildProcess(foreclosure_home_bus, '~thor_data400::base::foreclosure_monitoring::home_bus', build_base);

despray_remote_file := '/hds_1/home_business_ind/out/home_bus_ind_' + ut.GetDate;
despray_file := fileservices.despray('~thor_data400::base::foreclosure_monitoring::home_bus', _control.IPAddress.edata12, despray_remote_file);

export proc_build_base := sequential(build_base, despray_file);