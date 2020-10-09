import ut, header_slimsort, did_add, didville, header,address;

export proc_clean_and_did(dataset(marriage_divorce_v2.layout_mar_div_intermediate) in0) :=
module

// The default for _Flag.Reclean is FALSE.  This is so recleaning of certain fields in the previous base 
// will be skipped with each build.  
PrevBase := project(marriage_divorce_v2.file_mar_div_intermediate
										,transform(marriage_divorce_v2.layout_mar_div_intermediate
										,self.touched := if(_Flag.Reclean, '', left.touched);
										,self := left));

// New Input Data + the previous Intermediate Base file
in1 := in0 + PrevBase;

append_puid      	 := marriage_divorce_v2.fn_append_puid(in1);
cleaned_dates      := marriage_divorce_v2.fn_fix_dates(append_puid);
patch_vendor       := marriage_divorce_v2.fn_patch_vendor(cleaned_dates);
fix_xml_data       := marriage_divorce_v2.fn_ln_xml_address_patch(patch_vendor);
fix_filing_numbers := marriage_divorce_v2.fn_patch_filing_number(fix_xml_data);
roll_prep          := marriage_divorce_v2.fn_rollup_prep(fix_filing_numbers);
city_vs_citystate  := marriage_divorce_v2.fn_city_vs_citystate(roll_prep);
rolled_up          := marriage_divorce_v2.fn_rollup(city_vs_citystate);

header.MAC_Bad_Seen_and_Vendor_Dates(rolled_up,fixed_seen_and_vendor_dates);

//Suppress Marriage records bug#77778

marriage_divorce_v2.Mac_Suppress(fixed_seen_and_vendor_dates,out_suppress);

marriage_divorce_v2.layout_mar_div_intermediate t_clean(marriage_divorce_v2.layout_mar_div_intermediate le) := transform
 
 boolean previously_cleaned := if(le.touched='Y' and le.vendor <> 'CIV18',true,false);
 boolean is_xml_rec         := stringlib.stringfind(le.source_file,'XML',1)!=0;
 
 string140 v_pname_conj := if(previously_cleaned=false and le.conjunctive_party<>'',
                            if(le.conjunctive_name_format='L',address.CleanDualNameLFM140(le.conjunctive_party),							
							if(le.conjunctive_name_format='F',address.CleanDualName140(le.conjunctive_party),
						   '')),'');

 string73 v_pname_party1 := if(previously_cleaned=false and le.party1_name<>'',
                             if(le.party1_name_format='L',address.CleanPersonLFM73(le.party1_name),							
							 if(le.party1_name_format='F',address.CleanPersonFML73(le.party1_name),
						    '')),'');

 string73 v_pname_party2 := if(previously_cleaned=false and le.party2_name<>'',
                             if(le.party2_name_format='L',address.CleanPersonLFM73(le.party2_name),							
							 if(le.party2_name_format='F',address.CleanPersonFML73(le.party2_name),
						    '')),'');

 string73 v_pname_alias1 := if(previously_cleaned=false and le.party1_alias<>'',
                             if(le.party1_name_format='L',address.CleanPersonLFM73(le.party1_alias),							
							 if(le.party1_name_format='F',address.CleanPersonFML73(le.party1_alias),
						    '')),'');

 string73 v_pname_alias2 := if(previously_cleaned=false and le.party2_alias<>'',
                             if(le.party2_name_format='L',address.CleanPersonLFM73(le.party2_alias),							
							 if(le.party2_name_format='F',address.CleanPersonFML73(le.party2_alias),
						    '')),'');
							
 string182 v_ca_party1 := address.cleanaddress182(le.party1_addr1,le.party1_csz);
 string182 v_ca_party2 := address.cleanaddress182(le.party2_addr1,le.party2_csz);

 string70 v_pname_conj_name1 := v_pname_conj[1..70];
 string70 v_pname_conj_name2 := v_pname_conj[71..140];

 string1 v_gender1_derived := datalib.gender(v_pname_conj_name1[6..25]);
 string1 v_gender2_derived := datalib.gender(v_pname_conj_name2[6..25]);
 
 //Attempt to derive _type information when the incoming name is conjunctive
 self.party1_type := if(previously_cleaned=false,
                      if(trim(le.party1_type)='' and v_pname_conj<>'',
                       if(v_gender1_derived='M','H',
					   if(v_gender1_derived='F','S',
					 '')),le.party1_type),le.party1_type);

 self.party2_type := if(previously_cleaned=false,
                      if(trim(le.party2_type)='' and v_pname_conj<>'',
                       if(v_gender2_derived='M','H',
					   if(v_gender2_derived='F','S',
					 '')),le.party2_type),le.party2_type);
					 
 self.pname_party1 := if(previously_cleaned=false,
                       if(v_pname_party1<>'',v_pname_party1,
                       if(v_pname_conj_name1<>'',v_pname_conj_name1,
					  '')),le.pname_party1);

 //refer to OH Divorce mapping for unique condition for this data
 self.pname_party2 := if(trim(le.source_file)='OH DEPARTMENT OF HEALTH' and le.filing_type='7',
                       le.pname_party2,
					  if(previously_cleaned=false,
                       if(v_pname_party2<>'',v_pname_party2,
                       if(v_pname_conj_name2<>'',v_pname_conj_name2,
					  '')),le.pname_party2));

 self.pname_party1_alias := if(previously_cleaned=false,
                             if(v_pname_alias1<>'',v_pname_alias1,
					        ''),le.pname_party1_alias);

 self.pname_party2_alias := if(previously_cleaned=false,
                             if(v_pname_alias2<>'',v_pname_alias2,
					        ''),le.pname_party2_alias);
					  
 self.ca_party1    := if(previously_cleaned=false or is_xml_rec=true,v_ca_party1,le.ca_party1);
 self.ca_party2    := if(previously_cleaned=false or is_xml_rec=true,v_ca_party2,le.ca_party2);

 //Touched is set to 'Y' here since at this point the new input records will have been cleaned
 //in this transform (and previous base records were already cleaned in a prior build).  If there 
 //is a need to reclean the previous base file records, then set _Flag.Reclean to TRUE.
 self.touched      := 'Y';
  
 self := le;

end;

p_clean := project(out_suppress,t_clean(left)); 


//Re-sequence records irregardless of whether it's already been cleaned
ut.MAC_Sequence_Records(p_clean,record_id,p_clean_seq) 

export base_file_intermediate := p_clean_seq : persist('~thor_data400::persist::mar_div_sequenced_new');

did_prep_rec := record
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_vendor_last_reported;
 string5   vendor;
 unsigned6 record_id;
 string8   process_date;
 string2   state_origin;
 string1   party_type;
 string3   which_party;
 string70  pname;
 string1   name_sequence;
 string100 nameasis;
 string1   nameasis_name_format;
 string182 ca;
 string9   ssn;
 string8   dob;
 string3   age;
 string8   dob_or_age:='';
 string2   orig_residence_st;
 string2   birth_state;
 string30  race;
 string50  party_csz;
 string35  party_county;
 string20  previous_marital_status;
 string20  how_marriage_ended;
 string2   times_married;
 string8   last_marriage_end_dt;

 //raw address fields
 string50  party_addr;
 // string50  party_csz;
end;

did_prep_rec t_did_prep_rec(marriage_divorce_v2.layout_mar_div_intermediate le, integer c) := transform
 
 self.party_type  := choose(c,le.party1_type,le.party2_type,le.party1_type,le.party2_type);
 self.which_party := choose(c,'P1','P2','P1A','P2A');
 self.pname       := choose(c,le.pname_party1,le.pname_party2,le.pname_party1_alias,le.pname_party2_alias);
 self.name_sequence := choose(c,if(le.conjunctive_party<>'','1','1'),
                                if(le.conjunctive_party<>'','2','1'),
						        '1',
						        '1'
						     );
 self.nameasis := choose(c,if(le.conjunctive_party<>'',le.conjunctive_party,le.party1_name),
                           if(le.conjunctive_party<>'',le.conjunctive_party,le.party2_name),
						   le.party1_alias,
						   le.party2_alias
						);
 self.nameasis_name_format := choose(c,if(le.conjunctive_party<>'',le.conjunctive_name_format,le.party1_name_format),
                                       if(le.conjunctive_party<>'',le.conjunctive_name_format,le.party2_name_format),
						               le.party1_name_format,
						               le.party2_name_format
						            );
 self.ca       := choose(c,le.ca_party1 ,le.ca_party2 ,le.ca_party1 ,le.ca_party2);
 self.ssn      := choose(c,le.party1_ssn,le.party2_ssn,le.party1_ssn,le.party2_ssn);
 /*
 self.dob_or_age := choose(c,if(le.party1_dob<>'',le.party1_dob,le.party1_age),
                             if(le.party2_dob<>'',le.party2_dob,le.party2_age),
							 if(le.party1_dob<>'',le.party1_dob,le.party1_age),
							 if(le.party2_dob<>'',le.party2_dob,le.party2_age)
						  );
 */						  
 self.dob      := choose(c,le.party1_dob,  le.party2_dob,  le.party1_dob,        le.party2_dob);
 self.age      := choose(c,le.party1_age,  le.party2_age,  le.party1_age,        le.party2_age);
 
 self.orig_residence_st := choose(c,if(length(trim(le.party1_csz))=2,le.party1_csz,''),
                                    if(length(trim(le.party1_csz))=2,le.party2_csz,''),
                                    if(length(trim(le.party2_csz))=2,le.party1_csz,''),
									if(length(trim(le.party2_csz))=2,le.party2_csz,'')
							     );
 
 self.birth_state		:= choose(c,le.party1_birth_state, 	le.party2_birth_state,	le.party1_birth_state,	le.party2_birth_state);
 self.race					:= choose(c,le.party1_race, 				le.party2_race,					le.party1_race,					le.party2_race);
 self.party_county	:= choose(c,le.party1_county, 			le.party2_county,				le.party1_county,				le.party2_county);
 self.previous_marital_status	:= choose(c,le.party1_previous_marital_status, 		le.party2_previous_marital_status,	le.party1_previous_marital_status,	le.party2_previous_marital_status);
 self.how_marriage_ended			:= choose(c,le.party1_how_marriage_ended, 				le.party2_how_marriage_ended,				le.party1_how_marriage_ended,				le.party2_how_marriage_ended);
 self.times_married						:= choose(c,le.party1_times_married, 							le.party2_times_married,						le.party1_times_married,						le.party2_times_married);
 self.last_marriage_end_dt		:= choose(c,le.party1_last_marriage_end_dt, 			le.party2_last_marriage_end_dt,			le.party1_last_marriage_end_dt,			le.party2_last_marriage_end_dt);
 self.party_addr	:= choose(c,le.party1_addr1,le.party2_addr1,le.party1_addr1,le.party2_addr1);
 self.party_csz		:= choose(c,le.party1_csz,le.party2_csz,le.party1_csz,le.party2_csz);
 self          := le;

end;

p_did_prep_rec := normalize(base_file_intermediate,4,t_did_prep_rec(left,counter))(pname<>''); 


did_prep_id_rec := record
did_prep_rec;
unsigned8 persistent_record_id := 0;

end;

did_prep_id_rec t_add_persistent(p_did_prep_rec le) := transform
self.persistent_record_id	:= HASH64(le.record_id +','
																		+ ut.CleanSpacesAndUpper(le.vendor) +','
																		+	ut.CleanSpacesAndUpper(le.party_type) +','
																		+	ut.CleanSpacesAndUpper(le.which_party) +','
																		+	ut.CleanSpacesAndUpper(le.nameasis) +','
																		+	ut.CleanSpacesAndUpper(le.nameasis_name_format) +','
																		+ ut.CleanSpacesAndUpper(le.party_addr) +','
																		+ ut.CleanSpacesAndUpper(le.party_csz) +','
																		+ ut.CleanSpacesAndUpper(le.ssn) + ','
																		+ ut.CleanSpacesAndUpper(le.dob) +','
																		+ ut.CleanSpacesAndUpper(le.age) +','
																		+ ut.CleanSpacesAndUpper(le.birth_state) +','
																		+ ut.CleanSpacesAndUpper(le.race) +','
																		+ ut.CleanSpacesAndUpper(le.party_county) +','
																		+ ut.CleanSpacesAndUpper(le.previous_marital_status) +','
																		+ ut.CleanSpacesAndUpper(le.how_marriage_ended) +','
																		+ ut.CleanSpacesAndUpper(le.times_married) +','
																		+ ut.CleanSpacesAndUpper(le.last_marriage_end_dt)
																			);
	
 self := le;
end;

p_did_id_prep_rec := project(p_did_prep_rec,t_add_persistent(left));

redefine_rec := record
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_vendor_last_reported;
 string5   vendor;
 unsigned6 record_id;
 string8   process_date;
 string2   state_origin;
 string1   party_type;
 string3   which_party;

 //string70  pname;
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 
 string1   name_sequence;
 string100 nameasis;
 string1   nameasis_name_format;
 
 //string182 ca;
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  p_city_name;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string4   cart;
 string1   cr_sort_sz;
 string4   lot;
 string1   lot_order;
 string2   dbpc;
 string1   chk_digit;
 string2   rec_type;
 string5   county;
 string10  geo_lat;
 string11  geo_long;
 string4   msa;
 string7   geo_blk;
 string1   geo_match;
 string4   err_stat; 
 
 string9   ssn;
 string8   dob;
 string3   age;
 string8   dob_or_age;
 string2   orig_residence_st;
 
 string2   birth_state;
 string30  race;
 string35  party_county;
 string20  previous_marital_status;
 string20  how_marriage_ended;
 string2   times_married;
 string8   last_marriage_end_dt;
 unsigned8 persistent_record_id ;
 
 unsigned6 did :=0;
end;

redefine_rec t_redefine(did_prep_id_rec le) := transform
 
 self.title       := le.pname[ 1.. 5];
 self.fname       := le.pname[ 6..25];
 self.mname       := le.pname[26..45];
 self.lname       := le.pname[46..65];
 self.name_suffix := le.pname[66..70];

 self.prim_range  := le.ca[ 1..  10];
 self.predir      := le.ca[ 11.. 12];
 self.prim_name   := le.ca[ 13.. 40];
 self.suffix      := le.ca[ 41.. 44];
 self.postdir     := le.ca[ 45.. 46];
 self.unit_desig  := le.ca[ 47.. 56];
 self.sec_range   := le.ca[ 57.. 64];
 self.p_city_name := le.ca[ 65.. 89];
 self.v_city_name := le.ca[ 90..114];
 self.st          := if(le.ca[115..116]<>'',le.ca[115..116],if(le.orig_residence_st<>'',le.orig_residence_st,le.state_origin));
 self.zip         := le.ca[117..121];
 self.zip4        := le.ca[122..125];
 self.cart        := le.ca[126..129];
 self.cr_sort_sz  := le.ca[130..130];
 self.lot         := le.ca[131..134];
 self.lot_order   := le.ca[135..135];
 self.dbpc        := le.ca[136..137];
 self.chk_digit   := le.ca[138..138];
 self.rec_type    := le.ca[139..140];
 self.county      := le.ca[141..145];
 self.geo_lat     := le.ca[146..155];
 self.geo_long    := le.ca[156..166];
 self.msa         := le.ca[167..170];
 self.geo_blk     := le.ca[171..177];
 self.geo_match   := le.ca[178..178];
 self.err_stat    := le.ca[179..182]; 
 
 
 self.dob         := if(length(trim(le.dob))=8,le.dob,
                     if(length(trim(le.dob))=6,le.dob+'00',
					 if(length(trim(le.dob))=4,le.dob+'0000',
					 '')));
 					 
 self             := le;

end;

p_redefine := project(p_did_id_prep_rec,t_redefine(left));

redefine_rec t_dob_or_age(redefine_rec le) := transform
 self.dob_or_age := if(le.dob<>'',le.dob,le.age);
 self            := le;
end;

p_redefine2 := project(p_redefine,t_dob_or_age(left)); 

matchset := ['A','Z','D','Q','G','S'];
#stored('is_xADL2',false); 
did_add.MAC_Match_Flex
	(p_redefine2, matchset,					
	 ssn, dob_or_age, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, redefine_rec, false, DID_Score_field,
	 75, d_did)

mar_div_did := d_did : persist('~thor_data400::persist::mar_div_did_new');


// marriage_divorce_v2.layout_mar_div_search t_map_to_search(redefine_rec le) := transform
// self.persistent_record_id	:= HASH64(le.record_id +','
																			// + ut.CleanSpacesAndUpper(le.vendor) +','
																			// +	ut.CleanSpacesAndUpper(le.party_type) +','
																			// +	ut.CleanSpacesAndUpper(le.which_party) +','
																			// + ut.CleanSpacesAndUpper(le.title) +','
																			// + ut.CleanSpacesAndUpper(le.fname) +','
																			// +	ut.CleanSpacesAndUpper(le.mname)	+','
																			// + ut.CleanSpacesAndUpper(le.lname) +','
																			// +	ut.CleanSpacesAndUpper(le.name_suffix) +','
																			// +	ut.CleanSpacesAndUpper(le.nameasis) +','
																			// + ut.CleanSpacesAndUpper(le.prim_range) +','
																			// + ut.CleanSpacesAndUpper(le.predir) +','
																			// + ut.CleanSpacesAndUpper(le.prim_name) +','
																			// +	ut.CleanSpacesAndUpper(le.suffix) +','
																			// + ut.CleanSpacesAndUpper(le.postdir) +','
																			// + ut.CleanSpacesAndUpper(le.unit_desig) +','
																			// + ut.CleanSpacesAndUpper(le.sec_range) +','
																			// +	ut.CleanSpacesAndUpper(le.p_city_name) +','
																			// + ut.CleanSpacesAndUpper(le.v_city_name) +','
																			// + ut.CleanSpacesAndUpper(le.st) +','
																			// + ut.CleanSpacesAndUpper(le.zip) +','
																			// + ut.CleanSpacesAndUpper(le.zip4) +','
																			// +	ut.CleanSpacesAndUpper(le.cart) +','
																			// + ut.CleanSpacesAndUpper(le.cr_sort_sz) +','
																			// + ut.CleanSpacesAndUpper(le.lot) +','
																			// + ut.CleanSpacesAndUpper(le.lot_order) +','
																			// + ut.CleanSpacesAndUpper(le.dbpc) +','
																			// + ut.CleanSpacesAndUpper(le.chk_digit) +','
																			// + ut.CleanSpacesAndUpper(le.rec_type) +','
																			// + ut.CleanSpacesAndUpper(le.county) +','
																			// + ut.CleanSpacesAndUpper(le.geo_lat) +','
																			// + ut.CleanSpacesAndUpper(le.geo_long) +','
																			// + ut.CleanSpacesAndUpper(le.msa) +','
																			// + ut.CleanSpacesAndUpper(le.geo_blk) +','
																			// + ut.CleanSpacesAndUpper(le.geo_match) +','
																			// + ut.CleanSpacesAndUpper(le.err_stat)
																			// + ut.CleanSpacesAndUpper(le.dob) +','
																			// + ut.CleanSpacesAndUpper(le.age) +','
																			// + ut.CleanSpacesAndUpper(le.birth_state) +','
																			// + ut.CleanSpacesAndUpper(le.race) +','
																			// + ut.CleanSpacesAndUpper(le.party_county) +','
																			// + ut.CleanSpacesAndUpper(le.previous_marital_status) +','
																			// + ut.CleanSpacesAndUpper(le.how_marriage_ended) +','
																			// + ut.CleanSpacesAndUpper(le.times_married) +','
																			// + ut.CleanSpacesAndUpper(le.last_marriage_end_dt)
																			// );
	
 // self := le;
// end;

marriage_divorce_v2.layout_mar_div_search t_map_to_search(redefine_rec le) := transform
 self := le;
end;

export search_file := project(mar_div_did(trim(lname)<>'UNKNOWN'),t_map_to_search(left));

end;