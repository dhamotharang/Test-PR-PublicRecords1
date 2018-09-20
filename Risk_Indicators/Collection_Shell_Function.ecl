import addrbest, doxie, mdr, RiskWise, Progressive_Phone, Paw, ut;

export Collection_Shell_Function( dataset(risk_indicators.Layout_Input) progressive_prep, Risk_Indicators.Scoring_Parameters parameters) := FUNCTION

mod_access := MODULE (doxie.functions.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule ()))
  EXPORT unsigned1 glb := parameters.glb;
  EXPORT unsigned1 dppa := parameters.dppa;	
  EXPORT string DataPermissionMask := parameters.datapermission;
  EXPORT string DataRestrictionMask := parameters.datarestriction;
  EXPORT boolean ln_branded := parameters.ln_branded;
  EXPORT boolean probation_override := FALSE; // was set up as a constant below
  EXPORT unsigned3 date_threshold := 0;              // was set up as a constant below
END;

// get the DID for the input applicant, setting bsversion_temp := 2 so we don't ask for multiple DIDs
bsversion_temp := 2;
applicant_input_with_did := ungroup(risk_indicators.iid_getDID_prepOutput(progressive_prep, parameters.DPPA, parameters.GLB, parameters.isFCRA, bsversion_temp, parameters.DataRestriction,
																																					parameters.appendBest, parameters.gateways));
// output(applicant_input_with_did, named('applicant_input_with_did'));

f_in_raw := project(applicant_input_with_did, 
						transform(progressive_phone.layout_progressive_batch_in, 
								self.acctno := (string)left.seq;
								self.did := left.did;
								self.name_first := left.fname;
								self.name_middle := left.mname;
								self.name_last := left.lname;
								self.name_suffix := left.suffix;
								self.phoneno := left.phone10;
								self.suffix := left.addr_suffix;
								self.z4 := left.zip4;
								self.phoneno_1 := '';
								self.phoneno_2 := '';
								self.phoneno_3 := '';
								self.phoneno_4 := '';
								self.phoneno_5 := '';
								self.phoneno_6 := '';
								self.phoneno_7 := '';
								self.phoneno_8 := '';
								self.phoneno_9 := '';
								self.phoneno_10 := '';
								self := left));
// output(f_in_raw, named('f_in_raw'));

// call waterfall phones with the static configuration the modelers requested
tmpMod :=
MODULE(progressive_phone.waterfall_phones_options)
	EXPORT BOOLEAN SkipPhoneScoring  := TRUE; // Disable the new scoring model -- this ensures the product remains as it is today
	EXPORT BOOLEAN DedupOutputPhones := IF(~SkipPhoneScoring,FALSE,NOT KeepAllPhones); // We need to keep all phones from all WF levels in order to run the model
	EXPORT INTEGER CountES           := 1;
	EXPORT INTEGER CountSE           := 4;
	EXPORT INTEGER CountAP           := 3;
	EXPORT INTEGER CountSP           := 1;
	EXPORT INTEGER CountMD           := 2;
	EXPORT INTEGER CountCL           := 3;
	EXPORT INTEGER CountCR           := 1;
	EXPORT INTEGER CountSX           := 2;
	EXPORT INTEGER CountPP           := 3;
	EXPORT INTEGER CountNE           := 3;
	EXPORT INTEGER CountWK           := 1;
END;
				
f_out := addrbest.Progressive_phone_common(f_in_raw,tmpMod,,,,FALSE);

temp_rec := record
	unsigned seq;
	f_out;
	string2 nxx_type;
	string1 dial_ind;
	string1 point_id;
	string1 active_phone;  // 2=active, 1=disconnected, blank=unknown
	string1 listing_type; 
end;

w_telcordia := join(f_out, risk_indicators.Key_Telcordia_tpm_slim, 
						(integer)LEFT.subj_phone10!=0 AND
						keyed(LEFT.subj_phone10[1..3]=(RIGHT.npa)) and 
						keyed(left.subj_phone10[4..6]=RIGHT.nxx) and
						KEYED(RIGHT.tb IN [LEFT.subj_phone10[7]]),
					transform(temp_rec, 
									self.nxx_type := right.nxx_type;
									self.dial_ind := right.dial_ind;
									self.point_id := right.point_id;
									self.listing_type := left.phpl_phones_plus_type;
									self.active_phone := '';
									self.p_did := left.p_did;
									self.seq := 0;
									self := left;
									),
				  left outer, atmost(riskwise.max_atmost), keep(1));
// output(w_telcordia, named('w_telcordia'));

w_seq := iterate(group(sort(w_telcordia, acctno), acctno), transform(temp_rec, self.seq := counter, self := right));
// output(w_seq, named('w_seq'));


w_phone_disconnects := join(w_seq, risk_indicators.key_phone_table_v2,
							(integer)left.subj_phone10 != 0 and
					keyed(left.subj_phone10=right.phone10), // AND RIGHT.dt_first_seen < history_date,
				transform(temp_rec, self.active_phone := map(	right.iscurrent=> '2',
																											right.potdisconnect => '1',
																											'' );
														self := left),																											
					left outer, atmost(riskwise.max_atmost), keep(100));
w_phone_disconnect_flag := dedup(sort(w_phone_disconnects, acctno, seq, -active_phone), seq);
// output(w_phone_disconnect_flag, named('w_phone_disconnect_flag'));		

// put all the DIDs from the results into 1 bucket to be used for searching header and address history
dids := ungroup(project(f_out, transform(Doxie.layout_references, self.did := left.did)) + project(applicant_input_with_did, transform(Doxie.layout_references, self.did := left.did)));
// output(dids, named('dids'));

deduped_dids := dedup(dids);
// output(deduped_dids, named('deduped_dids'));

csa := doxie.Comp_Subject_Addresses(deduped_dids, parameters.includegong,,,mod_access);																						
doxie.MAC_Address_Rollup(csa.addresses, Risk_Indicators.collection_shell_mod.max_addresses, address_history)
// output(address_history, named('address_history'));


// all they want in the address history sections of the shell are the dates, addr_type and distance moved
// addr_common is set up outside the addr_details section to be re-used in the final layout
addr_common := record
	unsigned3 dt_first_seen;
	unsigned3 dt_last_seen;
	string1 addr_type;
	string4 distance_moved;
end;

addr_details := record
	string65 street_addr := '';
	STRING10 prim_range;
	STRING2  predir;
	STRING28 prim_name;
	STRING4  addr_suffix;
	STRING2  postdir;
	STRING10 unit_desig;
	STRING8  sec_range;
	STRING25 p_city_name;
	STRING2  st;
	STRING5  z5;
	STRING4  zip4;
	STRING10 lat;
	STRING11 long;
	string3 county;
	string7 geo_blk;
	STRING4  addr_status;
end;

addr_rec := record
	addr_common;
	addr_details;
end;

applicant_history := record
	unsigned did;
	addr_rec				addr1;
	addr_rec				addr2;
	addr_rec				addr3;
	addr_rec				addr4;
	addr_rec				addr5;
	addr_rec				addr6;
end;

applicant_history parse_address_history(applicant_input_with_did le, address_history rt) := transform
	self.did := le.did;
	self.addr1.dt_first_seen := rt.dt_first_seen;
	self.addr1.dt_last_seen := rt.dt_last_seen;
	street_address := Risk_Indicators.MOD_AddressClean.street_address('',rt.prim_range,
										rt.predir,rt.prim_name,rt.suffix,rt.postdir,rt.unit_desig,rt.sec_range);
	cleaned_addr := risk_indicators.MOD_AddressClean.clean_addr( street_address, rt.city_name, rt.st, rt.zip+if(rt.zip4<>'', rt.zip4, '') ) ;	
	self.addr1.street_addr := street_address;
	self.addr1.prim_range := cleaned_addr[1..10];
	self.addr1.predir := cleaned_addr[11..12];
	self.addr1.prim_name := cleaned_addr[13..40];
	self.addr1.addr_suffix := cleaned_addr[41..44];
	self.addr1.postdir := cleaned_addr[45..46];
	self.addr1.unit_desig := cleaned_addr[47..56];
	self.addr1.sec_range := cleaned_addr[57..64];
	self.addr1.p_city_name := cleaned_addr[90..114];
	self.addr1.st := cleaned_addr[115..116];
	self.addr1.z5 := cleaned_addr[117..121];
	self.addr1.zip4 := cleaned_addr[122..125];
	self.addr1.lat := cleaned_addr[146..155];
	self.addr1.long := cleaned_addr[156..166];
	self.addr1.addr_type := cleaned_addr[139];
	self.addr1.addr_status := cleaned_addr[179..182];
	self.addr1.county := cleaned_addr[143..145];
	self.addr1.geo_blk := cleaned_addr[171..177];
	self := [];
end;

applicant_addr_history := join(applicant_input_with_did, address_history, left.did<>0 and left.did=right.did,
																	parse_address_history(left, right));															
// output(applicant_addr_history, named('applicant_address_history'));

addr_share_rec := record
	unsigned did1;
	addr_rec did1_addr;
	unsigned did2;
	unsigned3 dt_first_seen_did2;
	unsigned3 dt_last_seen_did2;
	string4 TimeSinceSharedAddress;
	string4 LengthSharedAddress;
end;

system_yearmonth := (integer)(ut.GetDate[1..6]);
		
// identify all shared addresses so we can calcuate months since shared address variable
shared_addresses := join(applicant_addr_history, address_history, 
													left.addr1.prim_range=right.prim_range and
													left.addr1.prim_name=right.prim_name and 
													left.addr1.z5=right.zip and
													left.addr1.sec_range=right.sec_range and
													left.did<>right.did,
													transform(addr_share_rec,
																		self.did1 := left.did;
																		self.did1_addr := left.addr1;
																		self.did2 := right.did;
																		self.dt_first_seen_did2 := right.dt_first_seen;
																		self.dt_last_seen_did2 := right.dt_last_seen;
																		
																		max_common_first_seen := MAX(left.addr1.dt_first_seen, right.dt_first_seen);
																		min_common_last_seen := MIN(left.addr1.dt_last_seen, right.dt_last_seen);
																		shared_address := (left.addr1.dt_first_seen between right.dt_first_seen and right.dt_last_seen) or 
																									(left.addr1.dt_last_seen between right.dt_first_seen and right.dt_last_seen) or
																									(right.dt_first_seen between left.addr1.dt_first_seen and left.addr1.dt_last_seen) or 
																									(right.dt_last_seen between left.addr1.dt_first_seen and left.addr1.dt_last_seen);
																		// only calculate the months if dates overlap and the overlapping first seen dates aren't 0, otherwise skip							
																		self.TimeSinceSharedAddress := if(shared_address and max_common_first_seen<>0, (string)MIN( Risk_Indicators.collection_shell_mod.months_apart(system_yearmonth, min_common_last_seen), Risk_Indicators.collection_shell_mod.cap4byte), skip);
																		self.LengthSharedAddress := if(shared_address, (string)MIN( Risk_Indicators.collection_shell_mod.months_apart(min_common_last_seen, max_common_first_seen), Risk_Indicators.collection_shell_mod.cap4byte), '');
																		),keep(10));  // may have more than 1 co-resident per address, but i'll start with 10 here as a guess
// output(shared_addresses, named('shared_addresses'));

unique_address_sharing := dedup(group(sort(shared_addresses, did1, did2, TimeSinceSharedAddress, -LengthSharedAddress)), did1, did2);
// output(unique_address_sharing, named('unique_address_sharing'));
					
													
applicant_history add_history(applicant_history le, applicant_history rt, integer c) := transform
	self.addr1 := if(c=1, rt.addr1, le.addr1);
	self.addr2 := if(c=2, rt.addr1, le.addr2);
	self.addr3 := if(c=3, rt.addr1, le.addr3);
	self.addr4 := if(c=4, rt.addr1, le.addr4);
	self.addr5 := if(c=5, rt.addr1, le.addr5);
	self.addr6 := if(c=6, rt.addr1, le.addr6);
	self := le;
end;

// put the applicant DID into the layout of applicant_history to serve as the parent record in the denormalize
parent_record := project(applicant_input_with_did, transform(applicant_history, self.did:=left.did, self := []));	

// flatten the address history
applicant_address_history_denormed := denormalize(parent_record, 
																									applicant_addr_history, 
																									left.did=right.did, 
																									add_history(left, right, counter));		
																									
// output(parent_record, named('parent_record'));
// output(applicant_addr_history, named('applicant_addr_history'));																									
// output(applicant_address_history_denormed, named('applicant_address_history_denormed'));

best_data := Risk_Indicators.collection_shell_mod.getBestCleaned(project(deduped_dids, doxie.layout_references), parameters.DataRestriction, parameters.GLB);
// output(best_data, named('best_data'));

applicant_with_best := record
	risk_indicators.collection_shell_mod.best_rec best_info;
	applicant_input_with_did;
end;

// identify which of those DIDs was the applicant
applicant_best := join(applicant_input_with_did, best_data, left.did=right.did,
								transform(applicant_with_best, 
													self.best_info.seq := left.seq, 
													self.best_info := right, 
													self := left), 
								left outer, lookup);
// output(applicant_best, named('applicant_best'));
			

progressive_with_best := record
	Risk_Indicators.collection_shell_mod.best_rec best_info;
	w_phone_disconnect_flag;
end;
			
progressive_best := join(w_phone_disconnect_flag, best_data, left.did=right.did,
								transform(progressive_with_best, self.best_info := right, self := left), left outer, lookup);
// output(progressive_best, named('progressive_best'));

progressive_with_applicant_best := record
	boolean isApplicant;
	string6 distance_to_applicant := '';
	Risk_Indicators.collection_shell_mod.best_rec best_info;
	w_phone_disconnect_flag;
	Risk_Indicators.collection_shell_mod.best_rec applicant_best;
end;



// append the distance from the applicant to each relative/associate/neighbor/etc DID
with_distance := join(applicant_best, progressive_best, left.seq=(unsigned)right.acctno,
								transform(progressive_with_applicant_best, 
											self.isApplicant := left.did=right.did;
											self.distance_to_applicant := Risk_Indicators.Collection_Shell_MOD.calculate_distance(left.best_info.lat, left.best_info.long,
																																			 right.best_info.lat, right.best_info.long);	
											self.applicant_best := left.best_info;
											self := right), left outer);
// output(with_distance, named('with_distance_to_applicant'));
		
		
// send the DIDs off to search header to get dates first and last seen, and some source counts
d := record
	unsigned6 did := 0;
end;
ln_branded := false;
hdr := riskwise.getHeaderByDid(project(deduped_dids, d), parameters.dppa, parameters.glb, parameters.ln_branded, parameters.datarestriction);
// output(choosen(hdr, 50), named('hdr')); 

// need first seen dates, last seen dates and counts
adl_table := table(hdr, {
							did,
							hdr_dt_first_seen := MIN(GROUP,IF(dt_first_seen=0,999999,dt_first_seen)),
							hdr_dt_last_seen := MAX(GROUP,dt_last_seen),
							property_sourced := count(group, src in mdr.sourceTools.set_LnPropertyV2),
							bankruptcy_sourced := count(group, src=mdr.sourceTools.src_Bankruptcy),	
							}, did, few);
// output(adl_table, named('adl_table'));

fout_slim := record
	string20 acctno;
	unsigned1 seq;
	string8  matchcodes;
	integer error_code;
	string20 subj_first;
	string20 subj_middle;
	string20 subj_last;
	string5 subj_suffix; 
	string10 subj_phone10;
	string120 subj_name_dual;
	string2 subj_phone_type;
	string6 subj_date_first;
	string6 subj_date_last;
	string3 phpl_phones_plus_type;
	string30 phpl_phone_carrier;
	string25 phpl_carrier_city;
	string2 phpl_carrier_state; 
	string2 subj_phone_type_new := '';
	unsigned6		p_did:=0;
	string25	p_name_last:='';
	string25	p_name_first:='';
	UNSIGNED6	did;
	string10 phone10;				// phone number from the EDA search, renamed from subj_phone10 above
	string2 nxx_type;
	string1 dial_ind;
	string1 point_id;
	string1 active_phone;  // 2=active, 1=disconnected, blank=unknown
	string1 listing_type;
end;

temp_storage := record
	fout_slim;
	string1 name_match_flag := '';
	boolean isApplicant;  // flag indicating a match between the record in waterfall phones result and the DID append on the applicant
	string6 distance_to_applicant := '';  // phsyical distance in miles between the applicant's best address and the subject in waterfall phones
	string1 incarceration_flag := '';
	string6 phone_first_seen := '';
	string6 phone_last_seen := '';
	unsigned3 hdr_dt_first_seen ;
	unsigned3 hdr_dt_last_seen;
	string1 property_sourced;
	string1 bankruptcy_sourced;
	string1 criminal_sourced;
	Risk_Indicators.collection_shell_mod.best_rec best_info;  // best PII info on the subject returned from waterfall phones
	Risk_Indicators.collection_shell_mod.best_rec applicant_best;  // best PII on the DID returned from the DID append
end;

incarceration := Risk_Indicators.collection_shell_mod.getIncarceration(project(deduped_dids, transform(doxie.layout_references, self.did := left.did)));
// output(incarceration, named('incarceration'));

// done searching for the data for all of the DIDs, now put it into the horizontal layout
with_incarceration := join(with_distance, incarceration, left.did=right.did,
							transform(temp_storage, self.incarceration_flag := right.incarceration_flag,
												self := left, self := []), left outer, keep(1));
// output(with_incarceration, named('with_incarceration'));

with_adl_info := join(with_incarceration, adl_table, left.did=right.did,
												transform(temp_storage, 
														fnamematch := risk_indicators.iid_constants.g(risk_indicators.FnameScore(left.subj_first, left.p_name_first));
														lnamematch := risk_indicators.iid_constants.g(risk_indicators.lnameScore(left.subj_last, left.p_name_last));
														self.name_match_flag := map(fnamematch and lnamematch => '1',
																												lnamematch => '2',
																												fnamematch => '3',
																												left.subj_first=left.p_name_last => '4',
																												left.subj_last[1]=left.p_name_first[1] => '5',
																												stringlib.stringfind(left.subj_name_dual,left.p_name_last, 1)>0 => '6',
																												'');
														self.active_phone := map(left.active_phone='2' => '1',
																										 left.active_phone='1' => '0',
																										 '');
														self.phone10 := left.subj_phone10;
														self.phone_first_seen := if((integer)left.subj_date_first=0, '', left.subj_date_first);
														self.phone_last_seen := if((integer)left.subj_date_last=0, '', left.subj_date_last);
														self.hdr_dt_first_seen := right.hdr_dt_first_seen;
														self.hdr_dt_last_seen := right.hdr_dt_last_seen;
														self.property_sourced := if(right.property_sourced>0, '1', '0');
														self.bankruptcy_sourced := if(right.bankruptcy_sourced>0, '1', '0');
														// because it doesn't appear that criminal records are always on the header
														// based upon comparing the incarceration flag results to the header sourced
														// use the incarceration flag to determine if person has any criminal records associated with the DID
														self.criminal_sourced := if(left.incarceration_flag='', '0', '1');
														self := left), left outer);													
// output(sort(with_adl_info, acctno, seq));
		

applicant_rec := record
	unsigned6    did := 0;
	qstring5     title := '';
	qstring20    fname := '';
	qstring20    mname := '';
	qstring20    lname := '';
	qstring5     name_suffix := '';
	qstring9     ssn := '';
	integer4     dob := 0;
	qstring10    phone := '';
	string65 		 street_addr := '';
	string25 in_city;
	string2 in_state;
	string5 in_zipcode;
	qstring10    prim_range := '';
	string2      predir := '';
	qstring28    prim_name := '';
	qstring4     suffix := '';
	string2      postdir := '';
	qstring10    unit_desig := '';
	qstring8     sec_range := '';
	qstring25    city_name := '';
	string2      st := '';
	qstring5     zip := '';
	qstring4     zip4 := '';
	STRING10 lat := '';
	STRING11 long := '';
	STRING1  addr_type := '';
	STRING4  addr_status := '';
	string3 county := '';
	string7 geo_blk := '';
	string1 incarceration_flag := '';
end;

phones_common := record
		unsigned seq;
		boolean isApplicant;
		unsigned6 did;
		unsigned3 hdr_dt_first_seen;
		unsigned3 hdr_dt_last_seen;
		string1 bankruptcy_sourced;
		string1 property_sourced;
		string1 criminal_sourced;
		string1 possible_incarceration;
		string4 distance_to_applicant;
		string10 phone10;				// phone number from the EDA search
		string2 nxx_type;       // telcordia phone type
		string1 active_phone;  // Y=active, N=disconnected, blank=unknown
		string6 phone_first_seen;
		string6 phone_last_seen := '';
		string1 listing_type;
		unsigned6 p_did; 
		string20 subj_first;
		string20 subj_middle;
		string20 subj_last;
end;

p := PAW.key_contactID;
paw_slim := record
	p.contact_id;
	p.did;
	p.bdid;
	p.dt_first_seen;
	p.dt_last_seen;
	p.phone;
	p.active_phone_flag;
	p.source;
	p.company_name;
	p.company_title;
	p.company_status;
end;

es_se_layout := record
	phones_common;
	string1 name_match_flag;  // 1-6 based on first/last match level to phone listed name
end;

cr_sp_md_layout := record
	phones_common;
	string4 TimeSinceSharedAddress;
	string4 LengthSharedAddress;
end;
		
input_flag_rec := record
	// original input fields	
	string1 input_fnamepop;
	string1 input_lnamepop;
	string1 input_addrpop;
	string1 input_ssnlength;
	string1 input_dobpop;
	string1 input_hphnpop;
	// pop flags about the ADL input sent to the boca_shell
	string1 adl_addr;
	string1 wf_hphn;
	string1 adl_ssn;
	string1 adl_dob;
end;

// for the people at work result, they also want to know the source and the company status
paw_rec := record
	phones_common;
	p.contact_id;
	p.source;
	p.company_status;
end;

internal_working_layout := record
	string20 acctno;
	risk_indicators.layout_input original_input;
	input_flag_rec input_flags;
	applicant_rec 						applicant;  // remove this section from the layout sent to modelers
	
	// 1 EDA search result
	es_se_layout					ES;
	
	// up to 4 skip-trace results
	es_se_layout					SE1;
	es_se_layout					SE2;
	es_se_layout					SE3;
	es_se_layout					SE4;
	
	// up to 3 Progressive Address Search
	phones_common					AP1;
	phones_common					AP2;
	phones_common					AP3;
	
	// 2 expanded skip-trace result
	phones_common					SX1;
	phones_common					SX2;
	
	// 1 possible spouse
	cr_sp_md_layout				SP;
	
	// up to 2 possible parents
	cr_sp_md_layout				MD1;
	cr_sp_md_layout				MD2;
	
	// up to 3 closest relatives
	cr_sp_md_layout				CL1;
	cr_sp_md_layout				CL2;
	cr_sp_md_layout				CL3;
	
	cr_sp_md_layout				CR;
	// up to 3 phones plus results
	phones_common					PP1;
	phones_common					PP2;
	phones_common					PP3;
	
	// up to 3 closest neighbors
	phones_common					NE1;
	phones_common					NE2;
	phones_common					NE3;
	
	// up to 1 record from People at Work
	paw_rec					WK;

	addr_rec						addr1;
	addr_rec						addr2;
	addr_rec						addr3;
	addr_rec						addr4;
	addr_rec						addr5;
	addr_rec						addr6;
end;



// doesn't matter what the waterfall phones returns, the applicant info is on all records, so choose the first one
app := join(progressive_prep, with_adl_info, left.seq=right.applicant_best.seq,
				transform(internal_working_layout, 
									self.acctno := (string)left.seq;
									self.original_input := left;
									self.input_flags.input_fnamepop := if(trim(left.fname)<>'', '1', '0');
									self.input_flags.input_lnamepop := if(trim(left.lname)<>'', '1', '0');
									self.input_flags.input_addrpop := if(trim(left.in_streetaddress)<>'', '1', '0');
									self.input_flags.input_ssnlength := (string1)length(trim(left.ssn));
									self.input_flags.input_dobpop := if(trim(left.dob)<>'', '1', '0');
									self.input_flags.input_hphnpop := if(trim(left.phone10)<>'', '1', '0');
									self.input_flags.adl_addr := map(trim(right.applicant_best.street_addr)='' => '0', // best addr not found
																									 trim(left.in_streetaddress)='' and trim(right.applicant_best.street_addr)<>'' => '1',  // replaced blank with best
																									 left.prim_name=right.applicant_best.prim_name and left.prim_range=right.applicant_best.prim_range => '2', // best was the same as input
																									 '3');  // replaced with best, didn't match original input
									
									self.input_flags.adl_ssn := map(trim(right.applicant_best.ssn)='' => '0', // best ssn not found
																									 trim(left.ssn)='' and trim(right.applicant_best.ssn)<>'' => '1',  // replaced blank with best
																									 left.ssn=right.applicant_best.ssn=> '2', // best was the same as input
																									 '3');  // replaced with best, didn't match original input
									
									self.input_flags.adl_dob := map((unsigned)right.applicant_best.dob=0 => '0', // best dob not found
																									 (unsigned)left.dob=0 and (unsigned)right.applicant_best.dob<>0 => '1',  // replaced blank with best
																									 (unsigned)left.dob=right.applicant_best.dob=> '2', // best was the same as input
																									 '3');  // replaced with best, didn't match original input
									self.input_flags := [];
									
									// based upon a change in requirements, they don't want just a simple append from the best file
									// they want each field to be checked on the best, if best file doesn't have that element, keep the original input
									best_name_found := right.applicant_best.fname<>'' and right.applicant_best.lname<>'';										
									self.applicant.title := if(best_name_found, right.applicant_best.title , left.title );
									self.applicant.fname := if(best_name_found, right.applicant_best.fname , left.fname );
									self.applicant.mname := if(best_name_found, right.applicant_best.mname , left.mname );
									self.applicant.lname := if(best_name_found, right.applicant_best.lname , left.lname );
									self.applicant.name_suffix := if(best_name_found, right.applicant_best.name_suffix , left.suffix );
									self.applicant.ssn := if(right.applicant_best.ssn<>'', right.applicant_best.ssn, left.ssn);
									self.applicant.dob := if(right.applicant_best.dob<>0, right.applicant_best.dob, (integer)left.dob);
									best_addr_found := right.applicant_best.street_addr<>'' and right.applicant_best.zip<>'';
									self.applicant.street_addr := if(best_addr_found, right.applicant_best.street_addr , left.in_streetaddress );
									self.applicant.in_city := if(best_addr_found, right.applicant_best.city_name, left.in_city);
									self.applicant.in_state := if(best_addr_found, right.applicant_best.st, left.in_state);
									self.applicant.in_zipcode := if(best_addr_found, right.applicant_best.zip, left.in_zipcode);
									self.applicant.prim_range := if(best_addr_found, right.applicant_best.prim_range , left.prim_range );
									self.applicant.predir := if(best_addr_found, right.applicant_best.predir , left.predir );
									self.applicant.prim_name := if(best_addr_found, right.applicant_best.prim_name , left.prim_name );
									self.applicant.suffix := if(best_addr_found, right.applicant_best.suffix , left.addr_suffix );
									self.applicant.postdir := if(best_addr_found, right.applicant_best.postdir , left.postdir );
									self.applicant.unit_desig := if(best_addr_found, right.applicant_best.unit_desig , left.unit_desig );
									self.applicant.sec_range := if(best_addr_found, right.applicant_best.sec_range , left.sec_range );
									self.applicant.city_name := if(best_addr_found, right.applicant_best.city_name , left.p_city_name );
									self.applicant.st := if(best_addr_found, right.applicant_best.st , left.st );
									self.applicant.zip := if(best_addr_found, right.applicant_best.zip , left.z5 );
									self.applicant.zip4 := if(best_addr_found, right.applicant_best.zip4 , left.zip4 );
									self.applicant.lat := if(best_addr_found, right.applicant_best.lat , left.lat );
									self.applicant.long := if(best_addr_found, right.applicant_best.long , left.long );
									self.applicant.addr_type := if(best_addr_found, right.applicant_best.addr_type , left.addr_type );
									self.applicant.addr_status := if(best_addr_found, right.applicant_best.addr_status , left.addr_status );
									self.applicant.county := if(best_addr_found, right.applicant_best.county, left.county );
									self.applicant.geo_blk := if(best_addr_found, right.applicant_best.geo_blk , left.geo_blk );
									
									self.applicant.phone := '';  // this will be set later
									self.applicant.incarceration_flag := ''; // this will be set later
									self.applicant.did := right.applicant_best.did ;
									
									self := []), left outer, keep(1));
									
// output(progressive_prep, named('progressive_prep'));




// applicant joined to EDA search results (phone_type_new='ES')
with_ES := join(app, with_adl_info(subj_phone_type_new='ES'),
						left.acctno=right.acctno,
						transform(internal_working_layout,
											// always return the match flag on ES results, but only return the rest of the fields if the match flag is 1-4
											self.ES.name_match_flag := right.name_match_flag;
											good_eda := right.name_match_flag in ['1','2','3','4'];
											self.ES.did := if(good_eda, right.did , left.ES.did );
											self.ES.phone10 := if(good_eda, right.phone10 , left.ES.phone10 );
											self.ES.nxx_type := if(good_eda, right.nxx_type , left.ES.nxx_type );
											self.ES.phone_first_seen := if(good_eda, right.phone_first_seen , left.ES.phone_first_seen );
											self.ES.phone_last_seen := if(good_eda, right.phone_last_seen , left.ES.phone_last_seen );
											self.ES.p_did := if(good_eda, right.p_did , left.ES.p_did );	
											
											// isapplicant is used later, map that here, and as long as I'm at it...
											// map the other fields that were dropped on the cutting floor by the modelers just in case they ever decide to use any of them in the final layout
											self.ES.isapplicant := if(good_eda, right.isapplicant, left.ES.isapplicant);
											self.ES.hdr_dt_first_seen := if(good_eda, right.hdr_dt_first_seen, left.ES.hdr_dt_first_seen);
											self.ES.hdr_dt_last_seen := if(good_eda, right.hdr_dt_last_seen, left.ES.hdr_dt_last_seen);
											self.ES.bankruptcy_sourced := if(good_eda, right.bankruptcy_sourced, left.ES.bankruptcy_sourced);
											self.ES.property_sourced := if(good_eda, right.property_sourced, left.ES.property_sourced);
											self.ES.criminal_sourced := if(good_eda, right.criminal_sourced, left.ES.criminal_sourced);
											self.ES.possible_incarceration := if(good_eda, right.incarceration_flag, left.ES.possible_incarceration);
											self.ES.distance_to_applicant := if(good_eda, right.distance_to_applicant, left.ES.distance_to_applicant);
											self.ES.active_phone := if(good_eda, right.active_phone, left.ES.active_phone);  // Y=active, N=disconnected, blank=unknown								
											self.ES.listing_type := if(good_eda, right.listing_type, left.ES.listing_type);
											self.ES.subj_first := if(good_eda, right.subj_first, left.ES.subj_first);
											self.ES.subj_middle := if(good_eda, right.subj_middle, left.ES.subj_middle);
											self.ES.subj_last := if(good_eda, right.subj_last, left.ES.subj_last);
											
											self := left;),  left outer, keep(1));
// output(with_ES, named('with_ES'));

// add up to 4 skip trace results
skip_trace_results := dedup(sort(with_adl_info(subj_phone_type_new='SE'), acctno, seq), acctno, keep(4));
with_SEs := join(with_ES, skip_trace_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.SE1 := right;
												self := left), left outer);
internal_working_layout roll_SEs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.SE1 := le.SE1;
	self.SE2 := if(le.SE2.seq=0, rt.SE1, le.SE2);
	self.SE3 := if(le.SE2.seq<>0 and le.SE3.seq=0, rt.SE1, le.SE3); // only populate 3 with SE1 if 2 was already populated
	self.SE4 := if(le.SE3.seq<>0 and le.SE4.seq=0, rt.SE1, le.SE4); // only populate 4 with SE1 if 3 was already populated
	self := le;
end;
rolled_SEs := rollup(with_SEs, left.acctno=right.acctno, roll_SEs(left, right));
// output(rolled_SEs, named('rolled_SEs'));



// add up to 2 skip-trace results
expanded_skip_trace_results := dedup(sort(with_adl_info(subj_phone_type_new='SX'), acctno, seq), acctno, keep(2));
with_SXs := join(rolled_SEs, expanded_skip_trace_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.SX1 := right;
												self := left), left outer);
internal_working_layout roll_SXs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.SX1 := le.SX1;
	self.SX2 := if(le.SX2.seq=0, rt.SX1, le.SX2);
	self := le;
end;
rolled_SXs := rollup(with_SXs, left.acctno=right.acctno, roll_SXs(left, right));
// output(rolled_SXs, named('rolled_SXs'));


// add up to 3 results from progressive address search
progressive_address_results := dedup(sort(with_adl_info(subj_phone_type_new='AP'), acctno, seq), acctno, keep(3));
with_APs := join(rolled_SXs, progressive_address_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.AP1 := right;
												self := left), left outer);
internal_working_layout roll_APs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.AP1 := le.AP1;
	self.AP2 := if(le.AP2.seq=0, rt.AP1, le.AP2);
	self.AP3 := if(le.AP2.seq<>0 and le.AP3.seq=0, rt.AP1, le.AP3); // only populate 3 with AP1 if 2 was already populated
	self := le;
end;

rolled_APs := rollup(with_APs, left.acctno=right.acctno, roll_APs(left, right));
// output(rolled_APs, named('rolled_APs'));


// joined to possible spouse search results (phone_type_new='SP')
with_sp := join(rolled_APs, with_adl_info(subj_phone_type_new='SP'),
						left.acctno=right.acctno,
						transform(internal_working_layout,
											self.SP := right;
											self := left), left outer, keep(1));
// output(with_sp, named('with_sp'));


// add results from up to 2 parents
parent_results := dedup(sort(with_adl_info(subj_phone_type_new='MD'), acctno, seq), acctno, keep(2));
with_MDs := join(with_sp, parent_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.MD1 := right;
												self := left), left outer);
internal_working_layout roll_MDs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.MD1 := le.MD1;
	self.MD2 := if(le.MD2.seq=0, rt.MD1, le.MD2);
	self := le;
end;
rolled_MDs := rollup(with_MDs, left.acctno=right.acctno, roll_MDs(left, right));
// output(rolled_MDs, named('rolled_MDs'));


// add results from up to 3 closest relatives
close_relative_results := dedup(sort(with_adl_info(subj_phone_type_new='CL'), acctno, seq), acctno, keep(3));
with_CLs := join(rolled_MDs, close_relative_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.CL1 := right;
												self := left), left outer);
internal_working_layout roll_CLs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.CL1 := le.CL1;
	self.CL2 := if(le.CL2.seq=0, rt.CL1, le.CL2);
	self.CL3 := if(le.CL2.seq<>0 and le.CL3.seq=0, rt.CL1, le.CL3); // only populate 3 with CL1 if 2 was already populated
	self := le;
end;
rolled_CLs := rollup(with_CLs, left.acctno=right.acctno, roll_CLs(left, right));
// output(rolled_CLs, named('rolled_CLs'));

// joined to co-resident search results (phone_type_new='CR')
with_CR := join(rolled_CLs, with_adl_info(subj_phone_type_new='CR'),
						left.acctno=right.acctno,
						transform(internal_working_layout,
											self.CR := right;
											self := left), left outer, keep(1));
// output(with_CR, named('with_CR'));


// add up to 3 results from phones plus
phones_plus_results := dedup(sort(with_adl_info(subj_phone_type_new='PP'), acctno, seq), acctno, keep(3));
with_PPs := join(with_CR, phones_plus_results, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.PP1 := right;
												self := left), left outer);
internal_working_layout roll_PPs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.PP1 := le.PP1;
	self.PP2 := if(le.PP2.seq=0, rt.PP1, le.PP2);
	self.PP3 := if(le.PP2.seq<>0 and le.PP3.seq=0, rt.PP1, le.PP3); // only populate 3 with PP1 if 2 was already populated
	self := le;
end;

rolled_PPs := rollup(with_PPs, left.acctno=right.acctno, roll_PPs(left, right));
// output(rolled_PPs, named('rolled_PPs'));


// add up to 3 closest neighbors
Neighbors := dedup(sort(with_adl_info(subj_phone_type_new='NE'), acctno, seq), acctno, keep(3));
with_NEs := join(rolled_PPs, Neighbors, 
							left.acctno=right.acctno,
							transform(internal_working_layout,
												self.NE1 := right;
												self := left), left outer);
internal_working_layout roll_NEs(internal_working_layout le, internal_working_layout rt) := transform						 
	self.NE1 := le.NE1;
	self.NE2 := if(le.NE2.seq=0, rt.NE1, le.NE2);
	self.NE3 := if(le.NE2.seq<>0 and le.NE3.seq=0, rt.NE1, le.NE3); // only populate 3 with NE1 if 2 was already populated
	self := le;
end;
rolled_NEs := rollup(with_NEs, left.acctno=right.acctno, roll_NEs(left, right));
// output(rolled_NEs, named('rolled_NEs'));


// add up to 1 record from People at work
with_WK := join(rolled_NEs, with_adl_info(subj_phone_type_new='WK'),
						left.acctno=right.acctno,
						transform(internal_working_layout,
											self.WK := right;
											self := left;),  left outer, keep(1));
											


with_addr_history := join(with_WK, applicant_address_history_denormed, left.applicant.did=right.did,
													transform(internal_working_layout,
																		// calculate the distance from most recent address to the prior address
																		self.addr1.distance_moved := risk_indicators.Collection_Shell_MOD.calculate_distance(right.addr1.lat, right.addr1.long, right.addr2.lat, right.addr2.long);
																		self.addr2.distance_moved := risk_indicators.Collection_Shell_MOD.calculate_distance(right.addr2.lat, right.addr2.long, right.addr3.lat, right.addr3.long);
																		self.addr3.distance_moved := risk_indicators.Collection_Shell_MOD.calculate_distance(right.addr3.lat, right.addr3.long, right.addr4.lat, right.addr4.long);
																		self.addr4.distance_moved := risk_indicators.Collection_Shell_MOD.calculate_distance(right.addr4.lat, right.addr4.long, right.addr5.lat, right.addr5.long);
																		self.addr5.distance_moved := risk_indicators.Collection_Shell_MOD.calculate_distance(right.addr5.lat, right.addr5.long, right.addr6.lat, right.addr6.long);
																		self.addr1 := right.addr1;
																		self.addr2 := right.addr2;
																		self.addr3 := right.addr3;
																		self.addr4 := right.addr4;
																		self.addr5 := right.addr5;
																		self.addr6 := right.addr6;
																		self := left));


with_shared_address_info := denormalize(with_addr_history, unique_address_sharing, left.applicant.did=right.did1,
												transform(internal_working_layout, 
																	self.CR.TimeSinceSharedAddress := if(left.cr.did=right.did2, right.TimeSinceSharedAddress, left.CR.TimeSinceSharedAddress);
																	self.CR.LengthSharedAddress := if(left.cr.did=right.did2, right.LengthSharedAddress, left.CR.LengthSharedAddress);
																	
																	self.CL1.TimeSinceSharedAddress := if(left.CL1.did=right.did2, right.TimeSinceSharedAddress, left.CL1.TimeSinceSharedAddress);
																	self.CL1.LengthSharedAddress := if(left.CL1.did=right.did2, right.LengthSharedAddress, left.CL1.LengthSharedAddress);
																	
																	self.CL2.TimeSinceSharedAddress := if(left.CL2.did=right.did2, right.TimeSinceSharedAddress, left.CL2.TimeSinceSharedAddress);
																	self.CL2.LengthSharedAddress := if(left.CL2.did=right.did2, right.LengthSharedAddress, left.CL2.LengthSharedAddress);
																	
																	self.CL3.TimeSinceSharedAddress := if(left.CL3.did=right.did2, right.TimeSinceSharedAddress, left.CL3.TimeSinceSharedAddress);
																	self.CL3.LengthSharedAddress := if(left.CL3.did=right.did2, right.LengthSharedAddress, left.CL3.LengthSharedAddress);
																	
																	self.SP.TimeSinceSharedAddress := if(left.SP.did=right.did2, right.TimeSinceSharedAddress, left.SP.TimeSinceSharedAddress);
																	self.SP.LengthSharedAddress := if(left.SP.did=right.did2, right.LengthSharedAddress, left.SP.LengthSharedAddress);
																	
																	self.MD1.TimeSinceSharedAddress := if(left.MD1.did=right.did2, right.TimeSinceSharedAddress, left.MD1.TimeSinceSharedAddress);
																	self.MD1.LengthSharedAddress := if(left.MD1.did=right.did2, right.LengthSharedAddress, left.MD1.LengthSharedAddress);
																	
																	self.MD2.TimeSinceSharedAddress := if(left.MD2.did=right.did2, right.TimeSinceSharedAddress, left.MD2.TimeSinceSharedAddress);
																	self.MD2.LengthSharedAddress := if(left.MD2.did=right.did2, right.LengthSharedAddress, left.MD2.LengthSharedAddress);
																	
																	self := left), left outer);	
with_applicant_incarceration := join(with_shared_address_info, incarceration, left.applicant.did=right.did,
							transform(internal_working_layout, 
												self.applicant.incarceration_flag := right.incarceration_flag;
											
											// all of the waterfall phones have been mapped, now set the wf_hphn flag
											priority_phone := map(left.ES.isApplicant and left.ES.phone10<>'' => left.ES.phone10,
																						left.SE1.isApplicant and left.SE1.phone10<>'' => left.SE1.phone10,
																						left.SE2.isApplicant and left.SE2.phone10<>'' => left.SE2.phone10,
																						left.SE3.isApplicant and left.SE3.phone10<>'' => left.SE3.phone10,
																						left.SE4.isApplicant and left.SE4.phone10<>'' => left.SE4.phone10,
																						left.AP1.isApplicant and left.AP1.phone10<>'' => left.AP1.phone10,
																						left.AP2.isApplicant and left.AP2.phone10<>'' => left.AP2.phone10,
																						left.AP3.isApplicant and left.AP3.phone10<>'' => left.AP3.phone10,
																						left.SP.isApplicant and left.SP.phone10<>'' => left.SP.phone10,
																						left.SX1.isApplicant and left.SX1.phone10<>'' => left.SX1.phone10,
																						left.PP1.isApplicant and left.PP1.phone10<>'' => left.PP1.phone10,
																						left.PP2.isApplicant and left.PP2.phone10<>'' => left.PP2.phone10,
																						left.PP3.isApplicant and left.PP3.phone10<>'' => left.PP3.phone10,																						
																						'');
											self.applicant.phone := if(priority_phone='', left.original_input.phone10, priority_phone);
											self.input_flags.wf_hphn := map(priority_phone='' => '0', // waterfall phones didn't find a phone
																									 trim(left.original_input.phone10)='' and trim(priority_phone)<>'' => '1',  // replaced blank with best
																									 left.original_input.phone10=priority_phone=> '2', // waterfall phones result was the same as input
																									 '3');  // replaced with waterfall phones result, didn't match original input
																									 
												self := left, self := []), left outer, keep(1));		
												
												
//append people at work data source code and company status for the WK.DID
w_contact_ids := join(with_applicant_incarceration, paw.Key_Did,
											left.wk.did<>0 and
											keyed(left.wk.did=right.did),
											transform(internal_working_layout, 
											self.wk.contact_id := right.contact_id;
											self.wk := left.wk;
											self := left), 
											left outer, 
											atmost(riskwise.max_atmost), keep(1000));
paw_All := join(w_contact_ids, p, 
								left.wk.contact_id <> 0 and 
								keyed(left.wk.contact_id=right.contact_id) and
								left.wk.phone10=right.company_phone, 
								transform(internal_working_layout, 
													self.wk.source := right.source;
													self.wk.company_status := right.company_status;
													self.wk := left.wk;
													self := left),
													left outer,
													atmost(100), keep(1));
with_paw := dedup(sort(paw_All, acctno, -wk.source), acctno);																		

// gateways := dataset([],risk_indicators.Layout_Gateways_In);  // no gateways, don't want to incur transactional cost to targus on collection products

// isUtility := false;
// suppressNearDups := true;
// require2ele := false;
// from_biid := false;
// from_IT1O := false;
// // turn watchlist searching off
	// ofac_only := false;
	// excludeWatchlists := true;
	// ofac_version := 1;
	// include_ofac := false;
	// include_additional_watchlists := false;
	// watchlist_threshold := 0.84;
	// dob_radius := -1;
// includeRelativeInfo := true;
// includeDLInfo := true;
// includeVehInfo := true;
// includeDerogInfo :=true;
// nugen := true;

iid_prep := PROJECT(with_paw,
							transform(risk_indicators.Layout_Input, 
												self.seq := left.original_input.seq;
												self.suffix := left.applicant.name_suffix;
												self.in_streetaddress := left.applicant.street_addr;
												self.addr_suffix := left.applicant.suffix;
												self.p_city_name := left.applicant.city_name;
												self.z5 := left.applicant.zip;
												self.phone10 := left.applicant.phone;
												self.dob := if(left.applicant.dob=0, '', (string8)left.applicant.dob);												
												self.age := if (left.applicant.dob = 0, '', (STRING3)ut.GetAgeI_asOf(left.applicant.dob, (unsigned)risk_indicators.iid_constants.myGetDate(left.original_input.historydate)) );	
	
												self := left.applicant, 
												self.historydate := left.original_input.historydate;
												self := []));


iid_results := risk_indicators.InstantID_Function(iid_prep, 
	parameters.gateways, 
	parameters.dppa, 
	parameters.glb, 
	parameters.isUtility, 
	parameters.ln_branded, 
	parameters.ofac_only,
	parameters.suppressNearDups,
	parameters.require2ele,
	parameters.isFCRA,
	parameters.from_biid,
	parameters.ExcludeWatchLists,
	parameters.from_IT1O,
	parameters.ofac_version,
	parameters.include_ofac,
	parameters.include_additional_watchlists,
	parameters.global_watchlist_threshold,
	parameters.dob_radius,
	parameters.bsversion,
	in_dataRestriction:=parameters.DataRestriction,
	in_append_best:=parameters.AppendBest,
	in_dataPermission:=parameters.DataPermission);
											
clam := risk_indicators.Boca_Shell_Function(iid_results, parameters.gateways, parameters.dppa, parameters.glb, parameters.isUtility, parameters.ln_branded, parameters.includeRelativeInfo, parameters.includeDLInfo, parameters.includeVehInfo, parameters.includeDerogInfo, parameters.bsversion, parameters.doScore, 
										nugen := parameters.nugenreasons, filter_out_fares := parameters.RemoveFares, DataRestriction:=parameters.DataRestriction, DataPermission:=parameters.DataPermission);
										
final := join(with_paw, clam, (unsigned)left.acctno=right.seq,
						transform(Risk_Indicators.collection_shell_mod.collection_shell_layout_full, 
											self.cs.incarceration_flag := left.applicant.incarceration_flag;
											self.cs := left;
											self := right));

// output(choosen(with_adl_info, 1), named('with_adl_info'));									
// output(app, named('app'));
// output(with_paw, named('with_paw'));
// output(iid_prep, named('iid_prep'));
// output(iid_results, named('iid_results'));
// output(clam, named('clam'));

return final;


END;