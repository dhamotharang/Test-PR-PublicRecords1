import Address,AID,LN_Mortgage,LN_Property,ut,LN_PropertyV2, LN_PropertyV2_Fast,nid,Data_Services;

// Jira DF-11862 - added isfast parameter to name persist file accordingly in order to run continuous delta
export Propagate_Property_Address_Assessment(	dataset(recordof(LN_PropertyV2.layout_property_common_model_base))		Asses_in0,
																						  dataset(recordof(LN_PropertyV2.Layout_DID_Out))	search_in0,
																							boolean isFast
																						)	:=
MODULE

// POPULATE APN FOR DAYTON DATA 
LN_PropertyV2.layout_property_common_model_base	getasses(Asses_in0	L)	:=
transform
	self.fares_unformatted_apn	:=	if(	L.ln_fares_id[1]!='R',
																			LN_PropertyV2.fn_strip_pnum(L.apna_or_pin_number),
																			LN_PropertyV2.fn_strip_pnum(L.fares_unformatted_apn)
																		);
	self												:=	L;
end;

Assess	:=	project(Asses_in0,getasses(left));

// PICK COUNTY NAMES, STATE FROM LOOKUP FOR ONLY FARES DATA
fips_rec := record
 string2  state_alpha;
 string2  state_code;
 string3  county_code;
 string40 county_alpha;
 string2  class;
 string1  crlf;
end;

fips_data_county_name	:=	dataset(Data_Services.foreign_prod+ 'thor_data400::in::fips_code_lookup',fips_rec,flat);

LN_PropertyV2.layout_property_common_model_base	reformat(Assess	l,fips_data_county_name	r)	:=
transform
	self.county_name	:=	if(l.vendor_source_flag	in	['F','S'],StringLib.StringToUpperCase(r.county_alpha),StringLib.StringToUpperCase(l.county_name)); 
	self.state_code		:=	if(l.vendor_source_flag	in	['F','S'],StringLib.StringToUpperCase(r.state_alpha),StringLib.StringToUpperCase(l.state_code)); 
	self							:=	l; 
end; 

Assess_county := join(Assess ,fips_data_county_name,  
                      left.fips_code[1..2] = right.state_code
											and left.fips_code[3..5] = right.county_code,
											reformat(left,right) ,left outer,lookup);


//PULL CLEAN ADDRESS FROM SEARCH FILE 
dist_Assess  := distribute(Assess_county,hash(ln_fares_id)); 

search_in := distribute(search_in0(source_code[2]='P' /*and err_stat[1] ='S'*/),hash(ln_fares_id)); ;

temp_rec	:=
record
	LN_PropertyV2.layout_property_common_model_base; 
	search_in.Append_PrepAddr1;
	search_in.Append_PrepAddr2;
	search_in.Append_RawAID;
  search_in.prim_range;
  search_in.predir;
  search_in.prim_name;
  search_in.suffix;
  search_in.err_stat;
end; 

temp_rec	get_add(dist_Assess	l,search_in	r )	:=
transform
  self	:=	l ;
  self	:=	r ;  
end;

join_address	:=	join(	dist_Assess,
												search_in,
												left.ln_fares_id	=	right.ln_fares_id,
												get_add(left,right),
												keep(1),
												local
											); // JOIN SKEWD SO DISTRIBUTED    

Assess_address_dist	:=	distribute(join_address(((integer)fares_unformatted_apn)<>0 ),hash(fares_unformatted_apn));// :persist('joinaddress');

// ROLLUP TO FIND OUT UNIQUE PROPERTY ADDRESS PER APN,STATE,COUNTY
newrec	:=
record
	Assess_address_dist.property_full_street_address; 
	Assess_address_dist.property_city_state_zip;
	Assess_address_dist.state_code; 
	Assess_address_dist.county_name; 
	Assess_address_dist.fares_unformatted_apn;
	Assess_address_dist.Append_PrepAddr1;
	Assess_address_dist.Append_PrepAddr2;
	Assess_address_dist.Append_RawAID;
	Assess_address_dist.prim_range;
	Assess_address_dist.predir;
	Assess_address_dist.prim_name;
	Assess_address_dist.suffix;
	Assess_address_dist.err_stat;

	boolean	dummy_flag	:=	TRUE;
	string1	source			:=	if(Assess_address_dist.ln_fares_id[1]	!=	'R','D','F');
end;

Assess_slim	:=	table(Assess_address_dist,newrec);

Assess_property	:=	dedup(	sort(	Assess_slim(property_full_street_address	<>	''	and	property_city_state_zip	<>	''),
																	fares_unformatted_apn,state_code,county_name,source,
																	prim_range,predir,prim_name,suffix,err_stat,
																	local
																),
														fares_unformatted_apn,state_code,county_name,source,
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

Assess_property_flag	:=	rollup(	Assess_property,
																	trans(left,right),
																	fares_unformatted_apn,state_code,county_name,source,
																	local
																);

dist_Assess_apn_filled	:=	distribute(dist_Assess(fares_unformatted_apn<>''),hash(fares_unformatted_apn));
dist_Assess_apn_empty		:=	dist_Assess(fares_unformatted_apn='');

// Propagate within source D => Dayton F=> Fares 
rec_temp	:=
record
	LN_PropertyV2.layout_property_common_model_base;
	string100	Append_PrepAddr1		:=	'';
	string50	Append_PrepAddr2		:=	'';
	AID.Common.xAID	Append_RawAID	:=	0;
	string1	src										:=	'';
end; 

rec_temp	treformat(LN_PropertyV2.layout_property_common_model_base	l)	:=
transform 
	self.src	:=	if(l.ln_fares_id[1]	!=	'R','D','F');
	self			:=	l;
end; 

dist_Assess_apn_filled_src	:=	project(dist_Assess_apn_filled,treformat(left));
	 
// DO LEFT OUTER TO KEEP ALL RECORDS(PROPAGATED RECORDS ALONG WITH OTHER RECORDS).P for Propgataion
shared	propagate_address	:=	join(	dist_Assess_apn_filled_src,
																		Assess_property_flag(dummy_flag	=	TRUE	and	err_stat[1]	=	'S'),
																		left.fares_unformatted_apn=right.fares_unformatted_apn	and	left.state_code=right.state_code	and	left.county_name=right.county_name	and	left.src=right.source,
																		transform(	rec_temp,
																								self.property_full_street_address	:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'',right.property_full_street_address,left.property_full_street_address),
																								self.property_city_state_zip			:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'',right.property_city_state_zip,left.property_city_state_zip),// this will overwrite zip if its populated 
																								self.prop_addr_propagated_ind			:=	if(left.property_full_street_address	=	''	and	right.property_full_street_address	!=	'','P','');
																								self.Append_PrepAddr1							:=	if(left.property_full_street_address	=	''	and	right.Append_PrepAddr1	!=	'',right.Append_PrepAddr1,left.Append_PrepAddr1);
																								self.Append_PrepAddr2							:=	if(left.property_full_street_address	=	''	and	right.Append_PrepAddr2	!=	'',right.Append_PrepAddr2,left.Append_PrepAddr2);
																								self.Append_RawAID								:=	if(left.property_full_street_address	=	''	and	right.Append_RawAID			!=	0,right.Append_RawAID,left.Append_RawAID);
																								self															:=	left
																							),
																		left outer,
																		local
																	)	+	project(dist_Assess_apn_empty,rec_temp)	:	independent;

export	Assess_result	:=	project(propagate_address,LN_PropertyV2.layout_property_common_model_base);

Assess_wpatch    := LN_PropertyV2.fn_patch_tax(Assess_result);

// call current flag function/macro 
export Assess_resultWflag := LN_PropertyV2_Fast.Mac_LN_latest_Recflag(search_in0).current_assessor(Assess_wpatch); 

	new_search_candidates	:=	propagate_address(prop_addr_propagated_ind	=	'P');

// Bug 31994 - Remove records which don't have the address populated and are being propagated

recordof(search_in0)	t_norm(new_search_candidates	le, integer	c)	:=
transform
	self.nameasis									:=	choose(c,le.assessee_name,le.second_assessee_name);
	self.name_type								:=	choose(c,LN_PropertyV2.Prep_Name.fnLNNameOrder(le.assessee_name_type_code),LN_PropertyV2.Prep_Name.fnLNNameOrder(le.second_assessee_name_type_code));
	self.source_code							:=	choose(c,'OP','OP');
	self.which_orig								:=	choose(c,'1','2');
	self.phone_number							:=	choose(c,le.assessee_phone_number,'');  //check this
	self.dt_first_seen						:=	(integer)(le.tax_year + '00');
	self.dt_last_seen							:=	(integer)(le.tax_year + '00');
	self.dt_vendor_first_reported	:=	(integer)(le.tax_year + '00');
	self.dt_vendor_last_reported	:=	(integer)le.process_date[1..6];
	self.conjunctive_name_seq			:=	'1';
	self.prop_addr_propagated_ind	:=	'P';
	self													:=	le;
	self													:=	[];
end;

p_norm	:=	normalize(new_search_candidates,2,t_norm(left,counter))(trim(nameasis)<>'');

LN_PropertyV2.Mac_Clean_Name(p_norm,dCleanName,new_search_candidates);

// clean address using AID macro
ln_propertyv2.Append_AID(dCleanName,dCleanAddress,true);

preFix := IF(isFast,'property_fast','ln_propertyv2');
export new_search_records	:= dCleanAddress	:	persist('~thor_data400::persist::'+preFix+'::asses_address_propagated_fp'+if(isFast,'_d','f'));
	     //dataset('~thor_data400::persist::ln_propertyv2::asses_address_propagated_fp',recordof(dCleanAddress),thor);

end;