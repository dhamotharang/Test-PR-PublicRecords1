




import crim_common;
import crim_cp_ln;
import hygenics_eval;

offender_aoc :=  JOIN(File_offender(data_type = '2' 
																                 and pty_nm + 
																								 orig_lname +  
																								 orig_fname + 
																								 orig_mname + 
																								 orig_name_suffix <> ''
																									),File_LN_Cross_Extract_Driver,LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);		
																				
sort_offender_aoc := sort(distribute(offender_aoc,hash(offender_key)),
                                                     offender_key,
																										 vendor,
																										 state_origin,
																										 data_type,
																										 source_file,
																										 case_number,
																										 case_court,
																										 case_name,
																										 case_type,
																										 case_type_desc,
																										 case_filing_dt,
																										 pty_nm,
																										 pty_nm_fmt,
																										 orig_lname,
																										 orig_fname,
																										 orig_mname,
																										 orig_name_suffix,
																										 pty_typ,
																										 nitro_flag,
																										 orig_ssn,
																										 dle_num,
																										 fbi_num,
																										 doc_num,
																										 ins_num,
																										 id_num,
																										 dl_num,
																										 dl_state,
																										 citizenship,
																										 dob,
																										 dob_alias,
																										 place_of_birth,
																										 street_address_1,
																										 street_address_2,
																										 street_address_3,
																										 street_address_4,
																										 street_address_5,
																										 race,
																										 race_desc,
																										 sex,
																										 hair_color,
																										 hair_color_desc,
																										 eye_color,
																										 eye_color_desc,
																										 skin_color,
																										 skin_color_desc,
																										 height,
																										 weight,
																										 party_status,
																										 party_status_desc,
																										 prim_range,
																											predir,
																											prim_name,
																											addr_suffix,
																											postdir,
																											unit_desig,
																											sec_range,
																											p_city_name,
																											v_city_name,
																											state,
																											zip5,
																											zip4,
																											cart,
																											cr_sort_sz,
																											lot,
																											lot_order,
																											dpbc,
																											chk_digit,
																											rec_type,
																											ace_fips_st,
																											ace_fips_county,
																											geo_lat,
																											geo_long,
																											msa,
																											geo_blk,
																											geo_match,
																											err_stat,
																											title,
																											fname,
																											mname,
																											lname,
																											name_suffix,
																											cleaning_score,	
																											ssn,
																											did,
																											pgid, src_upload_date,
																											process_date,local);		

dedup_offender_aoc := DEDUP(sort_offender_aoc, RECORD, EXCEPT Process_date, KEEP 1,RIGHT,LOCAL);

offense_aoc := JOIN(File_Court_Offenses,File_LN_Cross_Extract_Driver,LEFT.Source_file = RIGHT.Source_file and RIGHT.ln_cross_extract_flag = 'Y',lookup);
	  
dedup_dist_offense_aoc := dedup(distribute(offense_aoc,hash(offender_key)),offender_key,ALL,local);	

	

layout_aoc_offenders := RECORD
hygenics_eval.Layout_Common_Crim_Offender;
Layout_LN_Cross_Extract_Driver.old_record_supplier_cd;
Layout_LN_Cross_Extract_Driver.record_supplier_cd;
Layout_LN_Cross_Extract_Driver.court_id;
Crim_Common.Layout_Moxie_Court_Offenses.court_cd;
Crim_Common.Layout_Moxie_Court_Offenses.court_desc;																									 
END;

layout_aoc_offenders  tr_get_court_cd_and_cd_descr(dedup_offender_aoc L, dedup_dist_offense_aoc R) := TRANSFORM
SELF := L;
SELF := R;
END;

ds_aoc_offenders_court_codes_and_desc := JOIN(dedup_offender_aoc,dedup_dist_offense_aoc,
																			     left.offender_key = right.offender_key,
																			       tr_get_court_cd_and_cd_descr(LEFT,RIGHT),local);																				 
																			 
export File_AOC_Offenders := ds_aoc_offenders_court_codes_and_desc;		

