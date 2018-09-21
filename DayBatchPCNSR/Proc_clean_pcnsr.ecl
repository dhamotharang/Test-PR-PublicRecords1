import InfoUSA,address,did_add,didville,ut,header_slimsort,standard, header, idl_header;

ebc_p_cnsr_in := InfoUSA.File_PCNSR_In;

Layout_p_cnsr_for_clean := RECORD
	DayBatchPCNSR.Layout_PCNSR;
	STRING38 	name_for_clean1;
	STRING38 	name_for_clean2;
	STRING 		addr1_for_clean;
	STRING30 	addr2_for_clean;
END;

doSkip(ebc_p_cnsr_in l, INTEGER c) := FUNCTION
		skipIt := (c = 2 AND TRIM(l.adult_2_surname) = '') OR
							(c = 3 AND TRIM(l.adult3_surname) = '') OR
							(c = 4 AND TRIM(l.adult4_surname) = '');
		RETURN skipIt;
END;

getFullName(STRING given_name,STRING middle_initial, 
						STRING surname, STRING surname_suffix) := FUNCTION
		STRING fullName := 	(string)given_name + ' ' +
												(string)middle_initial + ' ' +
												(string)surname + ' ' +
												(string)surname_suffix;
		RETURN fullName;
END;

//Normalize PCNSR Data
Layout_p_cnsr_for_clean normPCNSR(ebc_p_cnsr_in l,INTEGER c) := 	TRANSFORM,SKIP(doSkip(l,c))

			SELF.name_for_clean1 := CHOOSE(c,
																		getFullName(l.given_name,l.middle_initial,l.surname,l.surname_suffix),
																		getFullName(l.adult_2_given_name,l.adult_2_middle_initial,
																								l.adult_2_surname,l.adult_2_surname_suffix),
																		getFullName(l.adult_3_given_name,l.adult_3_middle_initial,
																								l.adult3_surname,l.adult_3_surname_suffix),
																		getFullName(l.adult_4_given_name,l.adult_4_middle_initial,
																								l.adult4_surname,l.adult_4_surname_suffix)
															);
											
			SELF.name_for_clean2 := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
																			=> getFullName(	l.adult_2_given_name,l.adult_2_middle_initial,
																											l.adult_2_surname,l.adult_2_surname_suffix),
																	c = 1  AND l.adult_3_spouse_indicator = 'Y'
																			=> getFullName(	l.adult_3_given_name,l.adult_3_middle_initial,
																											l.adult3_surname,l.adult_3_surname_suffix),
																	c = 1  AND l.adult_4_spouse_indicator = 'Y'
																			=> getFullName(	l.adult_4_given_name,l.adult_4_middle_initial,
																											l.adult4_surname,l.adult_4_surname_suffix),																																								
																	(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
																	(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
																	(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
																			=> getFullName(	l.given_name,l.middle_initial,
																											l.surname,l.surname_suffix),
																	''
																	);
SELF.fname_orig := CHOOSE(c,
													(STRING)l.given_name,
													(STRING)l.adult_2_given_name,
													(STRING)l.adult_3_given_name,
													(STRING)l.adult_4_given_name
													);
SELF.mname_orig := CHOOSE(c,
													(STRING)l.middle_initial,
													(STRING)l.adult_2_middle_initial,
													(STRING)l.adult_3_middle_initial,
													(STRING)l.adult_4_middle_initial
													);
SELF.lname_orig := CHOOSE(c,
													(STRING)l.surname,
													(STRING)l.adult_2_surname,
													(STRING)l.adult3_surname,
													(STRING)l.adult4_surname
													);
SELF.name_suffix_orig := CHOOSE(c,
													(STRING)l.surname_suffix,
													(STRING)l.adult_2_surname_suffix,
													(STRING)l.adult_3_surname_suffix,
													(STRING)l.adult_4_surname_suffix
													);
SELF.title_orig := CHOOSE(c,
													(STRING)l.title_code,
													(STRING)l.adult_2_title_code,
													(STRING)l.adult_3_title_code,
													(STRING)l.adult_4_title_code
													);
SELF.spouse_fname_orig := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
															=> (STRING)l.adult_2_given_name,
													c = 1  AND l.adult_3_spouse_indicator = 'Y'
															=> (STRING)l.adult_3_given_name,
													c = 1  AND l.adult_4_spouse_indicator = 'Y'
															=> (STRING)l.adult_4_given_name,																																								
													(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
													(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
													(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
															=> (STRING)l.given_name,
													''
													);
SELF.spouse_mname_orig := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
															=> (STRING)l.adult_2_middle_initial,
													c = 1  AND l.adult_3_spouse_indicator = 'Y'
															=> (STRING)l.adult_3_middle_initial,
													c = 1  AND l.adult_4_spouse_indicator = 'Y'
															=> (STRING)l.adult_4_middle_initial,																																								
													(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
													(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
													(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
															=> (STRING)l.middle_initial,
													''
													);
SELF.spouse_lname_orig := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
															=> (STRING)l.adult_2_surname,
													c = 1  AND l.adult_3_spouse_indicator = 'Y'
															=> (STRING)l.adult3_surname,
													c = 1  AND l.adult_4_spouse_indicator = 'Y'
															=> (STRING)l.adult4_surname,																																								
													(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
													(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
													(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
															=> (STRING)l.surname,
													''
													);
SELF.spouse_name_suffix_orig := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
															=> (STRING)l.adult_2_surname_suffix,
													c = 1  AND l.adult_3_spouse_indicator = 'Y'
															=> (STRING)l.adult_3_surname_suffix,
													c = 1  AND l.adult_4_spouse_indicator = 'Y'
															=> (STRING)l.adult_4_surname_suffix,																																								
													(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
													(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
													(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
															=> (STRING)l.surname_suffix,
													''
													);
SELF.spouse_title_orig := MAP(c = 1  AND l.adult_2_spouse_indicator = 'Y'
															=> (STRING)l.adult_2_title_code,
													c = 1  AND l.adult_3_spouse_indicator = 'Y'
															=> (STRING)l.adult_3_title_code,
													c = 1  AND l.adult_4_spouse_indicator = 'Y'
															=> (STRING)l.adult_4_title_code,																																								
													(c = 2 AND l.adult_2_spouse_indicator = 'Y') OR
													(c = 3 AND l.adult_3_spouse_indicator = 'Y') OR
													(c = 4 AND l.adult_4_spouse_indicator = 'Y') 																
															=> (STRING)l.title_code,
													''
													);
													
		SELF.phone_forDID := MAP(	l.area_code <> '' AND l.phone_number <> '' AND	l.telephone_number_type = 'V' 
																	=> l.area_code + l.phone_number,
															l.phone2_number <> '' AND l.telephone2_number_type = 'V'
																	=> l.phone2_number,
															'');
															
		SELF.addr1_for_clean := address.Addr1FromComponents(TRIM(l.house_number, left, right),TRIM(l.street_prefix_direction, left, right),
																												TRIM(l.street_name, left, right),TRIM(l.street_suffix,left, right),'',
																												TRIM(l.unit_type, left, right),TRIM(l.unit_number, left, right));
		SELF.addr2_for_clean := address.Addr2FromComponents(TRIM(l.city_name, left, right),TRIM(l.state_abbreviation),l.zip_code);
																												
		SELF.spouse_indicator := IF(SELF.name_for_clean2 = '','N','Y');
		
		SELF.gender := CHOOSE(c,l.gender,
													l.adult_2_gender,
													l.adult_3_gender,
													l.adult_4_gender);
		
		SELF.date_of_birth := CHOOSE(c,l.date_of_birth,
																 l.adult_2_date_of_birth,
																 l.adult_3_date_of_birth,
																 l.adult_4_date_of_birth);

		SELF.refresh_date := CHOOSE(c,l.refresh_date,
																l.refresh_date_2,
																l.refresh_date_3,
																l.refresh_date_4);
		
		SELF.name_address_verification_source := CHOOSE(c,l.name_address_verification_source,
																										l.name_address_verification_source_2,
																										l.name_address_verification_source_3,
																										l.name_address_verification_source_4);

		SELF.drop_indicator := CHOOSE(c,l.drop_indicator,
																	l.drop_indicator_2,
																	l.drop_indicator_3,
																	l.drop_indicator_4);

		SELF.do_not_mail_flag := CHOOSE(c,l.do_not_mail_flag,
																		l.do_not_mail_flag_2,
																		l.do_not_mail_flag_3,
																		l.do_not_mail_flag_4);

		SELF.do_not_call_flag := CHOOSE(c,l.do_not_call_flag,
																		l.do_not_call_flag_2,
																		l.do_not_call_flag_3,
																		l.do_not_call_flag_4);
		
		SELF.business_file_hit_flag := CHOOSE(c,l.business_file_hit_flag,
																					l.business_file_hit_flag_2,
																					l.business_file_hit_flag_3,
																					l.business_file_hit_flag_4);
		
		
		SELF.did := 0;
		SELF.did_score := 0;
		SELF := l;
		SELF := [];
END;

normalizedPCNSR := NORMALIZE(ebc_p_cnsr_in,4,normPCNSR(LEFT,COUNTER));
//END: Normalize PCNSR Data

//Clean Names
Layout_names := RECORD
	STRING38 name_for_clean;
	STRING73 clean_name;
	standard.name;
END;

Layout_names getNames(normalizedPCNSR np) := TRANSFORM,SKIP(TRIM(np.name_for_clean1) = '')
	SELF.name_for_clean := np.name_for_clean1;
	SELF := [];
END;

namesList := PROJECT(normalizedPCNSR,getNames(LEFT));

//Distribute then local sort and dedup
dedupedNames := DEDUP(SORT(distribute(namesList,hash(name_for_clean)),name_for_clean,local),name_for_clean,local);

Layout_names cleanNames(dedupedNames l) := TRANSFORM
		SELF.clean_name := address.CleanPersonFML73(l.name_for_clean);

		SELF.title := SELF.clean_name[1..5];
		SELF.fname := SELF.clean_name[6..25];
		SELF.mname := SELF.clean_name[26..45];
		SELF.lname := SELF.clean_name[46..65];
		SELF.name_suffix := SELF.clean_name[66..70];
		SELF.name_score := SELF.clean_name[71..73];
		SELF := l;
END;

cleanedNames := PROJECT(dedupedNames,cleanNames(LEFT));

dPCNSR1 := DISTRIBUTE(normalizedPCNSR,HASH(normalizedPCNSR.name_for_clean1));

Layout_p_cnsr_for_clean addCleanName1(dPCNSR1 l,cleanedNames r):= TRANSFORM
     self.title := r.title;
	self.fname := r.fname;
	self.mname := r.mname;
	self.lname := r.lname;
	self.name_suffix := r.name_suffix;
	self.name_score := r.name_score;
	SELF := l;
END;

pcnsrCleanNames1 := JOIN(dPCNSR1,cleanedNames,LEFT.name_for_clean1 = RIGHT.name_for_clean,
													addCleanName1(LEFT,RIGHT),LOCAL);

//split up records with name2 and records without
dPCNSR2_no_name := pcnsrCleanNames1(name_for_clean2='');
dPCNSR2 := DISTRIBUTE(pcnsrCleanNames1(name_for_clean2!=''),HASH(name_for_clean2));

								
Layout_p_cnsr_for_clean addCleanName2(dPCNSR2 l,cleanedNames r):= TRANSFORM
	SELF.spouse_title := r.title;
	SELF.spouse_fname := r.fname;
	SELF.spouse_mname := r.mname;
	SELF.spouse_lname := r.lname;
	SELF.spouse_name_suffix := r.name_suffix;
	SELF := l;
END;

//only join dataset with name2
pcnsrCleanNames_ := JOIN(dPCNSR2, cleanedNames,
										LEFT.name_for_clean2 = RIGHT.name_for_clean,
										addCleanName2(LEFT,RIGHT),LOCAL);

//concate datasets for address cleaning
pcnsrCleanNames := pcnsrCleanNames_ + dPCNSR2_no_name : persist('persist::daybatchPcnsr::proc_clean_names');
//END: Clean Names

//Clean Addresses

address.MAC_Address_Clean(pcnsrCleanNames,addr1_for_clean,addr2_for_clean,true,clean182)

Layout_p_cnsr_for_clean getClean(clean182 l) := TRANSFORM
	SELF.prim_range := l.clean[1..10];
	SELF.predir := l.clean[11..12];
	SELF.prim_name := l.clean[13..40];
	SELF.addr_suffix := l.clean[41..44];
	SELF.postdir := l.clean[45..46];
	SELF.unit_desig := l.clean[47..56];
	SELF.sec_range := l.clean[57..64];
	SELF.p_city_name := l.clean[65..89];
	SELF.v_city_name := l.clean[90..114];
	SELF.st := if(l.clean[115..116]='',
					ziplib.ZipToState2(l.clean[117..121]),
					l.clean[115..116]);
	SELF.zip := l.clean[117..121];
	SELF.zip4 := l.clean[122..125];
	SELF.cart := l.clean[126..129];
	SELF.cr_sort_sz := l.clean[130];
	SELF.lot := l.clean[131..134];
	SELF.lot_order := l.clean[135];
	SELF.dbpc := l.clean[136..137];
	SELF.chk_digit := l.clean[138];
	SELF.rec_type := l.clean[139..140];
	SELF.county := l.clean[141..145];
	SELF.geo_lat := l.clean[146..155];
	SELF.geo_long := l.clean[156..166];
	SELF.msa := l.clean[167..170];
	SELF.geo_blk := l.clean[171..177];
	SELF.geo_match := l.clean[178];
	SELF.err_stat := l.clean[179..182];
	SELF := l;
end;

all_cleaned := PROJECT(clean182,getClean(LEFT)) : persist('persist::daybatchPcnsr::proc_clean_addr');
//END: Clean Addresses

//------------Apply Name Flipping Macro--------------------
ut.mac_flipnames(all_cleaned,fname,mname,lname,names_flipped);
//---------------------------------------------------------

//build consumer hhid

didville.MAC_HHID_Append_By_Address(
	names_flipped, pcnsr_hhid_out, hhid, lname,
	prim_range, prim_name, sec_range, st, zip)

//Append DIDs
matchset := ['A','D','P','Z'];

did_add.MAC_Match_Flex(pcnsr_hhid_out,matchset,foo,date_of_birth,
			fname,mname,lname,name_suffix,prim_range,prim_name,sec_range,
			zip,st,phone_forDID,did,DayBatchPCNSR.Layout_PCNSR,true,did_score,75,outf)
//END: Append DIDs

//improve HHID
out_with_hhid := outf(hhid<>0); 

out_no_hhid := outf(hhid=0);

//get_hhid_by_did 

DayBatchPCNSR.Layout_PCNSR get_hhid_by_did(out_no_hhid l, header.File_HHID_Current r) := transform
self.hhid := r.hhid;
self := l;
end;

f_out := join(out_no_hhid(did<>0), header.File_HHID_Current(ver=1),
                    left.did = right.did, get_hhid_by_did(left,right),
left outer, hash) + out_no_hhid (did=0) + out_with_hhid; 

ut.MAC_SF_BuildProcess(f_out,'~thor_data400::base::daybatch_pcnsr',out_file,3,,true)

export Proc_clean_pcnsr := out_file;