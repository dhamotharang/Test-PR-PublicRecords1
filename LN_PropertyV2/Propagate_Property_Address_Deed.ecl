import Address,AID,LN_Mortgage,LN_Property,ut,LN_Propertyv2 ;

export Propagate_Property_Address_Deed(	dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base))	deed_in0,
																				dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search_mod))	search_in0
																			)
	:=	MODULE

shared	fDropZip4(string	pLineLast)	:=	regexreplace('(^| )([0-9]{5})[-]?[0-9]{4}($| .*)',pLineLast,'\\1\\2\\3');

// POPULATE APN FOR DAYTON DATA 
LN_PropertyV2.layout_deed_mortgage_common_model_base	getdeeds(deed_in0 L)	:=
transform
	self.fares_unformatted_apn	:=	if(	L.ln_fares_id[1]	!=	'R',
																			fn_strip_pnum(L.apnt_or_pin_number),
																			fn_strip_pnum(L.fares_unformatted_apn)
																		);
	self												:=	L;
end;

deeds	:=	project(deed_in0,getDeeds(left));

// PICK COUNTY NAMES, STATE FROM LOOKUP FOR ONLY FARES DATA
fips_rec := record
 string2  state_alpha;
 string2  state_code;
 string3  county_code;
 string40 county_alpha;
 string2  class;
 string1  crlf;
end;

fips_data_county_name	:=	dataset(ut.foreign_prod+'~thor_data400::in::fips_code_lookup',fips_rec,flat);

LN_PropertyV2.layout_deed_mortgage_common_model_base	reformat(deeds	l,fips_data_county_name	r)	:=
transform
	self.county_name	:=	if(	l.vendor_source_flag in ['F','S'],
														StringLib.StringToUpperCase(r.county_alpha),
														StringLib.StringToUpperCase(l.county_name)
													);
	self.state				:=	if(	l.vendor_source_flag in ['F','S'],
														StringLib.StringToUpperCase(r.state_alpha),
														StringLib.StringToUpperCase(l.state)
													);
	self							:=	l; 
end ; 

deeds_county	:=	join(	deeds,
												fips_data_county_name,
												left.fips_code[1..2]	=	right.state_code	and
												left.fips_code[3..5]	=	right.county_code,
												reformat(left,right),
												left outer,
												lookup
											);

//PULL CLEAN ADDRESS FROM SEARCH FILE 
dist_deeds	:=	distribute(deeds_county,hash(ln_fares_id)); 

search_in	:=	distribute(search_in0(source_code[2]='P' /*and err_stat[1] ='S'*/),hash(ln_fares_id));

temp_rec	:=
record
	LN_PropertyV2.layout_deed_mortgage_common_model_base;
	search_in.Append_PrepAddr1;
	search_in.Append_PrepAddr2;
	search_in.Append_RawAID;
  search_in.prim_range;
  search_in.predir;
  search_in.prim_name;
  search_in.suffix;
  search_in.err_stat;
end; 

temp_rec	get_add(dist_deeds	l,search_in	r)	:=
transform 
	self	:=	l;
  self	:=	r;  
end;

join_address	:=	join(	dist_deeds,
												search_in,
												left.ln_fares_id	=	right.ln_fares_id,
												get_add(left,right),
												keep(1),
												local
											); // JOIN SKEWD SO DISTRIBUTED    

deeds_address_dist	:=	distribute(join_address(((integer)fares_unformatted_apn)<>0),hash(fares_unformatted_apn));// :persist('joinaddress');

// ROLLUP TO FIND OUT UNIQUE PROPERTY ADDRESS PER APN,STATE,COUNTY
newrec	:=
record
	deeds_address_dist.property_full_street_address;
	deeds_address_dist.property_address_citystatezip;
	deeds_address_dist.state;
	deeds_address_dist.county_name;
	deeds_address_dist.fares_unformatted_apn;
	deeds_address_dist.Append_PrepAddr1;
	deeds_address_dist.Append_PrepAddr2;
	deeds_address_dist.Append_RawAID;
	deeds_address_dist.prim_range;
	deeds_address_dist.predir;
	deeds_address_dist.prim_name;
	deeds_address_dist.suffix;
	deeds_address_dist.err_stat;
	boolean	dummy_flag	:=	TRUE;
	string1	source			:=	if(deeds_address_dist.ln_fares_id[1]	!=	'R','D','F');
end;

deeds_slim	:=	table(deeds_address_dist,newrec);

deeds_property	:=	dedup(	sort(	deeds_slim(property_full_street_address <> '' and property_address_citystatezip <> ''),
																	fares_unformatted_apn,state,county_name,source,
																	prim_range,predir,prim_name,suffix,err_stat
																	,local
																),
														fares_unformatted_apn,state,county_name,source,
														prim_range,predir,prim_name,suffix,
														local
													);

newrec	trans(newrec	l,newrec	r)	:=
transform
	self.fares_unformatted_apn	:=	l.fares_unformatted_apn;
	self.dummy_flag							:=	if(	(	(	trim(l.prim_range,left,right)	+
																					trim(l.predir,left,right)			+
																					trim(l.prim_name,left,right)	+
																					trim(l.suffix,left,right)
																				)
																				<> 
																				(	trim(r.prim_range,left,right)	+
																					trim(r.predir,left,right)			+
																					trim(r.prim_name,left,right)	+
																					trim(r.suffix,left,right)
																				)
																			)
																			or
																			l.dummy_flag	=	FALSE,
																			FALSE,
																			TRUE
																		); 
	self												:=	l;
end;

deeds_property_flag	:=	rollup(	deeds_property,
																trans(left,right),
																fares_unformatted_apn,state,county_name,source,
																local
															);

dist_deeds_apn_filled	:=	distribute(dist_deeds(fares_unformatted_apn<>''),hash(fares_unformatted_apn));
dist_deeds_apn_empty	:=	dist_deeds(fares_unformatted_apn='');

// Propagate within source D => Dayton F=> Fares 
rec_temp	:=
record 
	LN_PropertyV2.layout_deed_mortgage_common_model_base;
	string100	Append_PrepAddr1		:=	'';
	string50	Append_PrepAddr2		:=	'';
	AID.Common.xAID	Append_RawAID	:=	0;
	string1	src										:=	''; 
end;

rec_temp	treformat(LN_PropertyV2.layout_deed_mortgage_common_model_base	l)	:=
transform
	self.src	:=	if(l.ln_fares_id[1]	!=	'R','D','F') ;
	self			:=	l;
end; 

dist_deeds_apn_filled_src	:=	project(dist_deeds_apn_filled,treformat(left));

// DO LEFT OUTER TO KEEP ALL RECORDS(PROPAGATED RECORDS ALONG WITH OTHER RECORDS).P for Propgataion  
shared	propagate_address	:=	join(	dist_deeds_apn_filled_src,
																		deeds_property_flag(dummy_flag = TRUE and err_stat[1] = 'S'),
																		left.fares_unformatted_apn=right.fares_unformatted_apn	and	left.state=right.state	and	left.county_name=right.county_name	and	left.src=right.source,
																		transform(	rec_temp,
																								self.property_full_street_address		:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'',right.property_full_street_address,left.property_full_street_address),
																								self.property_address_citystatezip	:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'',right.property_address_citystatezip,left.property_address_citystatezip), // this will overwrite zip if its populated 
																								self.prop_addr_propagated_ind				:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'','P','');
																								self.Append_PrepAddr1								:=	if(left.property_full_street_address	=	''	and	right.Append_PrepAddr1	!=	'',right.Append_PrepAddr1,left.Append_PrepAddr1);
																								self.Append_PrepAddr2								:=	if(left.property_full_street_address	=	''	and	right.Append_PrepAddr2	!=	'',right.Append_PrepAddr2,left.Append_PrepAddr2);
																								self.Append_RawAID									:=	if(left.property_full_street_address	=	''	and	right.Append_RawAID			!=	0,right.Append_RawAID,left.Append_RawAID);
																								self																:=	left
																							),
																		left outer,
																		local
																	)	+	project(dist_deeds_apn_empty,rec_temp)	:	independent;

// Bring back to the orig deed layout
export	deed_result	:=	project(propagate_address,LN_PropertyV2.layout_deed_mortgage_common_model_base);

// call current flag function/macro and merge LN,Fares 
Deeds_Wflag	:=	LN_PropertyV2.Mac_LN_latest_Recflag.current_deeds(deed_result);

// bug 25396 - nameasis in search would begin w/ a leading ", "
export Deeds_resultWflag	:=	LN_PropertyV2.fn_patch_deed(Deeds_Wflag,ln_propertyv2.File_addl_fares_deed); 

new_search_candidates	:=	propagate_address(prop_addr_propagated_ind	=	'P');

r_norm	:=
record
	string12	ln_fares_id;
	string5		vendor_source_flag;
	string8		process_date;
	string80	name;
	string1		name_type;
	string1		which_orig;
	string70	property_full_street_address;
	string6		property_address_unit_number;
	string51	property_address_citystatezip;
	string100	Append_PrepAddr1;
	string50	Append_PrepAddr2;
	AID.Common.xAID	Append_RawAID;
	string10 	phone_number;
	unsigned3	dt_first_seen; 
	unsigned3	dt_last_seen; 
	unsigned3	dt_vendor_first_reported; 
	unsigned3	dt_vendor_last_reported;
	string1		conjunctive_name_seq;
	string1		prop_addr_propagated_ind;
end;

LN_PropertyV2.layout_deed_mortgage_property_search_mod	t_norm(new_search_candidates	le,integer	c)	:=
transform
	self.nameasis									:=	choose(c,le.name1,le.name2,le.seller1,le.seller2);
	self.source_code							:=	choose(c,le.buyer_or_borrower_ind+'P',le.buyer_or_borrower_ind+'P','SP','SP');
	self.which_orig								:=	choose(c,'1','2','1','2');
	self.phone_number							:=	choose(c,le.phone_number,le.phone_number,'','');
	self.dt_first_seen						:=	(integer)le.recording_date[1..6];
	self.dt_last_seen							:=	(integer)le.recording_date[1..6];
	self.dt_vendor_first_reported	:=	(integer)le.recording_date[1..6];
	self.dt_vendor_last_reported	:=	(integer)le.process_date[1..6];
	self.conjunctive_name_seq			:=	'1';
	self.prop_addr_propagated_ind	:=	'P';
	self													:=	le;
	self													:=	[];	
end;

p_norm	:=	normalize(new_search_candidates,4,t_norm(left,counter))(trim(nameasis)<>'');

LN_Propertyv2.Mac_Clean_Name(p_norm,dCleanName);

// pass to aid macro
ln_propertyv2.Append_AID(dCleanName,dCleanAddress,true);

export new_search_records	:=	dCleanAddress	:	persist('~thor_data400::persist::ln_propertyv2::deeds_address_propagated');

end;