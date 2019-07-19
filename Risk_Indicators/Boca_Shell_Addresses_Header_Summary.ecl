import risk_indicators;

EXPORT Boca_Shell_Addresses_Header_Summary( grouped dataset(risk_indicators.iid_constants.layout_outx) all_header, grouped dataset(risk_indicators.Layout_Output) rolled_header ) := function

// get stats for each address like record count per source, dates first seen at source			
address_source_stats := table(all_header, 
											{seq, 
											_z5 := h.zip, 
											_prim_name := h.prim_name, 
											_prim_range := h.prim_range, 
											_src := src,
											records_per_source := count(group),
											first_seen_at_source := min(group, if(hdr_dt_first_seen=0, 999999, hdr_dt_first_seen)),
											max_first_seen_at_source := max(group, hdr_dt_first_seen),
											last_seen_at_source := max(group, hdr_dt_last_seen),					
											}, seq, h.zip, h.prim_name, h.prim_range, src);

temp_rec := record
	UNSIGNED4 seq;
	STRING5  z5;
	STRING10 prim_range;
	STRING28 prim_name;
	string100 addr_sources := '';
	string200 addr_sources_first_seen_date := '';
	string200 addr_sources_max_first_seen_date := '';
	string200 addr_sources_last_seen_date := '';
	string100 addr_sources_recordcount := '';
end;

tf_source_stats := project(address_source_stats,
						transform(temp_rec,
							vblank := (left._z5='' or left._prim_name='');
							self.addr_sources := if(vblank,'',left._src + ',');
							self.addr_sources_first_seen_date := if(vblank,'',if(left.first_seen_at_source=999999, '0', (string)left.first_seen_at_source) + ',');
							self.addr_sources_max_first_seen_date := if(vblank,'',(string)left.max_first_seen_at_source + ',');
							self.addr_sources_last_seen_date := if(vblank,'',(string)left.last_seen_at_source + ',');
							self.addr_sources_recordcount := if(vblank,'',(string)left.records_per_source + ',');	
							self.z5 := left._z5;
							self.prim_range := left._prim_range;
							self.prim_name := left._prim_name;
							self := left));
							
grp_source_stats := group(sort(tf_source_stats, seq, z5, prim_name, prim_range, addr_sources, -addr_sources_first_seen_date), seq, z5, prim_name, prim_range);		
							
temp_rec roll_addr_source_stats(temp_rec le, temp_rec rt) := transform
	self.addr_sources := trim(le.addr_sources) + rt.addr_sources +',';
	self.addr_sources_max_first_seen_date := trim(le.addr_sources_max_first_seen_date) + rt.addr_sources_max_first_seen_date + ',';
	self.addr_sources_first_seen_date := trim(le.addr_sources_first_seen_date) + rt.addr_sources_first_seen_date + ',';
	self.addr_sources_last_seen_date := trim(le.addr_sources_last_seen_date) + rt.addr_sources_last_seen_date + ',';
	self.addr_sources_recordcount := trim(le.addr_sources_recordcount) + rt.addr_sources_recordcount + ',';
	self := rt;
end;
					
rolled_addr_source_stats := rollup(grp_source_stats, 
	left.seq=right.seq and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range, 
	roll_addr_source_stats(left,right));

with_input_addr := join(rolled_header, rolled_addr_source_stats,
	left.seq=right.seq and left.z5=right.z5 and left.prim_name=right.prim_name and left.prim_range=right.prim_range,
		transform(risk_indicators.Layout_Output,
			self.address_sources_summary.input_addr_sources := right.addr_sources;
			self.address_sources_summary.input_addr_sources_first_seen_date := right.addr_sources_first_seen_date;
			self.address_sources_summary.input_addr_sources_recordcount := right.addr_sources_recordcount;
			self := left), left outer, keep(1));

with_current_addr := join(with_input_addr, rolled_addr_source_stats,
	left.seq=right.seq and left.chronozip=right.z5 and left.chronoprim_name=right.prim_name and left.chronoprim_range=right.prim_range,
		transform(risk_indicators.Layout_Output,	
			self.address_sources_summary.current_addr_sources := right.addr_sources;
			self.address_sources_summary.current_addr_sources_first_seen_date := right.addr_sources_first_seen_date;
			self.address_sources_summary.current_addr_sources_recordcount := right.addr_sources_recordcount;
			self := left), left outer, keep(1));

with_address_source_stats_rolled := join(with_current_addr, rolled_addr_source_stats,	
	left.seq=right.seq and left.chronozip2=right.z5 and left.chronoprim_name2=right.prim_name and left.chronoprim_range2=right.prim_range,
		transform(risk_indicators.Layout_Output,
			self.address_sources_summary.previous_addr_sources := right.addr_sources;
			self.address_sources_summary.previous_addr_sources_first_seen_date := right.addr_sources_first_seen_date;
			self.address_sources_summary.previous_addr_sources_recordcount := right.addr_sources_recordcount;
			self := left), left outer, keep(1));

// output(address_source_stats, named('address_source_stats'));
// output(tf_source_stats, named('tf_source_stats'));	
// output(rolled_addr_source_stats, named('rolled_addr_source_stats'));
// output(with_input_addr, named('with_input_addr'));
// output(with_current_addr, named('with_current_addr'));
// output(with_address_source_stats_rolled, named('with_address_source_stats_rolled'));


return group(with_address_source_stats_rolled, seq, did);

end;