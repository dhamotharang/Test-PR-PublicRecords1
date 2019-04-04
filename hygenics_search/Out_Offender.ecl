	/*2013-06-17T15:49:44Z (vchikte)
C:\Documents and Settings\ChikteVP\Application Data\HPCC Systems\eclide\vchikte\Dataland_EOSS_Proxy\hygenics_search\Out_Offender\2013-06-17T15_49_44Z.ecl
*/
import PromoteSupers, Lib_Date, hygenics_crim, CrimSrch, Crim_Common, Corrections, Life_EIR, doxie_build;

fcra_v1 			:= Offender_Joined;


///////////////////////////////////////////////////////////////
//Add 180 Day Rule Filter /////////////////////////////////////
///////////////////////////////////////////////////////////////

file_date_filter	:= StringLib.StringFilter(hygenics_search.Version.development, '0123456789');

fcra_filtered			:= fcra_v1(vendor in hygenics_search.sCourt_Vendors_To_Omit);

fcra_all					:= fcra_v1(vendor not in hygenics_search.sCourt_Vendors_To_Omit
												
                             ); 											

/////////////////////////////////////////////////////////////
//Remove FCRA related information from non-updating sources//
/////////////////////////////////////////////////////////////
	
	fcra_filtered removeInfo(fcra_filtered l):= transform
		self.fcra_conviction_flag						:= '';
		self.fcra_traffic_flag							:= '';
		self.fcra_date											:= '';
		self.fcra_date_type									:= '';
		self.conviction_override_date				:= '';
		self.conviction_override_date_type	:= '';
		self.offense_score									:= '';
		self 																:= l;
	end;
	
ds_fcra_filtered 	:= project(fcra_filtered, removeInfo(left));
ds_fcra_all			 	:= fcra_all;

////////////////////////////////////
//Add Offender_persistent_id Field//
////////////////////////////////////

all_f				 			:= ds_fcra_filtered + ds_fcra_all;

	all_f addOPID(all_f l):= transform
	
		filterField(String s) := FUNCTION
			return StringLib.StringFilter(StringLib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		END;

    Vid_num 						:= filterField(l.id_num);		
		Vpty_nm 						:= filterField(l.pty_nm);
		Vorig_lname					:= filterField(l.orig_lname);
		Vorig_fname					:= filterField(l.orig_fname);
		Vpty_typ						:= filterField(l.pty_typ);
		Vcase_num 					:= filterField(l.case_num);
		Vcase_court 				:= filterField(l.case_court);
		Vcase_date 					:= filterField(l.case_date);
		Vcase_type 					:= filterField(l.case_type);
		Vcase_type_desc 		:= filterField(l.case_type_desc);
		//Vcounty_of_origin 	:= filterField(l.county_of_origin);
		Vdle_num 						:= filterField(l.dle_num);
		Vfbi_num 						:= filterField(l.fbi_num);
		Vdoc_num 						:= filterField(l.doc_num);
		Vins_num 						:= filterField(l.ins_num);
		Vdl_num 						:= filterField(l.dl_num);
		Vdl_state 					:= filterField(l.dl_state);
		Vdob 								:= filterField(l.dob);
			
		// Vstreet_address			:= trim(trim(trim(trim(trim(trim(trim(trim(trim(trim(l.prim_range, left, right) + trim(l.predir, left, right), left, right) + trim(l.prim_name, left, right), left, right) + trim(l.addr_suffix, left, right), left, right) + trim(l.postdir, left, right), left, right) + trim(l.unit_desig, left, right), left, right) + trim(l.sec_range, left, right), left, right) + trim(l.p_city_name, left, right), left, right) + trim(l.st, left, right), left, right) + trim(l.zip5, left, right), left, right);

		Vstreet_address_12 	:= l.street_address_1+l.street_address_2;

		Vstreet_address_3 	:= filterField(l.street_address_3);
		Vstreet_address_4 	:= filterField(l.street_address_4);
		Vstreet_address_5 	:= filterField(l.street_address_5);
		Vrace 							:= filterField(l.race);
		Vrace_desc 					:= filterField(l.race_desc);
		Vheight							:= filterField(l.height);
		Vsex 								:= filterField(l.sex);
		Vskin_color					:= filterField(l.skin_color);	
		Vskin_color_desc		:= filterField(l.skin_color_desc);
		
		Vweight							:= filterField(l.weight);
		Veye_color					:= filterField(l.eye_color);	
		Veye_color_desc		  := filterField(l.eye_color_desc);
		Vhair_color					:= filterField(l.hair_color);	
		Vhair_color_desc		:= filterField(l.hair_color_desc);	
		VParty_status_desc	:= filterField(l.Party_status_desc);
		Vorig_mname					:= filterField(l.orig_mname);
		Vorig_name_suffix		:= filterField(l.orig_name_suffix);
		Vlname          		:= filterField(l.lname);
		Vfname          		:= filterField(l.fname);
		Vmname          		:= filterField(l.mname);
		Vname_suffix		    := filterField(l.name_suffix);
		
		self.offender_persistent_id 	:= hash64(l.offender_key + 
		                                        Vid_num + 
																						trim(l.pty_nm, left, right) + 
																						Vorig_lname + 'X' +
																						Vorig_fname + 'X' +
																						Vorig_mname + 'X' +
																						Vorig_name_suffix + 
																						Vpty_typ + 
																						// Vlname + 'X' + 
																						// Vfname + 'X' +
																						// Vmname + 'X' +
																						// Vname_suffix + 
																						trim(l.case_num, left, right) + 
																						Vcase_court + 
																						Vcase_date + 
																						Vcase_type + 
																						Vcase_type_desc /*+ Vcounty_of_origin +*/+ 
																						Vdle_num + 
																						Vfbi_num + 
																						Vdoc_num + 
																						Vins_num + 
																						Vdl_num + 
																						Vdl_state +
																						Vdob + 
																					  Vstreet_address_12 + 
																						Vstreet_address_3 + 
																						Vstreet_address_4 + 
																						Vstreet_address_5 + 
																					  //Vstreet_address + 
																					  Vrace + 
																						Vrace_desc + 
																						Vheight + 
																						Vsex + 
																						Vskin_color + 
																						Vskin_color_desc + 
																						Veye_color	+ 
																						Veye_color_desc +				
																						Vhair_color +	
																						Vhair_color_desc + 
																						VParty_status_desc + 
																						Vweight);  
		self := l;
	end;

all_files := project(all_f, addOPID(left)):persist('~thor_400::persist::Crim_records_before_DID_filter');
							
corrections.layout_offender trecs(fcra_v1 L) := transform
	  self.did	:= if(trim(l.did_to_keep, left, right)='000000000000', '', l.did_to_keep);	
		self 			:= L;
	end;

NonFCRA_records 	  :=  project(all_files, trecs(left));
sortedOffender      :=  sort(distribute(NonFCRA_records,HASH(offender_key,vendor,source_file)),
                        offender_key,vendor,source_file,record_type,orig_state,id_num,
                        StringLib.StringFilter(StringLib.StringToUpperCase(pty_nm),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//pty_nm_fmt,
												StringLib.StringFilter(StringLib.StringToUpperCase(orig_lname+orig_fname+orig_mname+orig_name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//lname,fname,mname,name_suffix,pty_typ,//nid,
												StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												// ntype,nindicator,nitro_flag,
												ssn,case_num,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												case_date,case_type,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_type_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												county_of_origin,
												StringLib.StringFilter(StringLib.StringToUpperCase(dle_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												fbi_num,doc_num,ins_num,dl_num,dl_state,dob,dob_alias,county_of_birth,place_of_birth,
												StringLib.StringFilter(StringLib.StringToUpperCase(street_address_1+street_address_2+street_address_3+street_address_4+street_address_5),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												current_residence_county,legal_residence_county,
												StringLib.StringFilter(StringLib.StringToUpperCase(race),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(race_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												sex,
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                        height,weight,												
												_3g_offender,violent_offender,sex_offender,vop_offender,data_type,record_setup_date,
                        datasource,
												StringLib.StringFilter(StringLib.StringToUpperCase(p_city_name),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												st,zip5,
                        // cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,
                        county_name,did,ssn_appended,curr_incar_flag,curr_parole_flag,curr_probation_flag,
                        image_link,fcra_conviction_flag, fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,
												offender_persistent_id,-ace_fips_st,-src_upload_date,-age,-zip4,-citizenship,local);
NonFCRA_records_dedup:= dedup(sortedOffender,
                        offender_key,vendor,source_file,record_type,orig_state,id_num,
                        StringLib.StringFilter(StringLib.StringToUpperCase(pty_nm),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//pty_nm_fmt,
												StringLib.StringFilter(StringLib.StringToUpperCase(orig_lname+orig_fname+orig_mname+orig_name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												// ntype,nindicator,nitro_flag,
												ssn,case_num,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												case_date,case_type,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_type_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												county_of_origin,
												StringLib.StringFilter(StringLib.StringToUpperCase(dle_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												fbi_num,doc_num,ins_num,dl_num,dl_state,dob,dob_alias,county_of_birth,place_of_birth,
												StringLib.StringFilter(StringLib.StringToUpperCase(street_address_1+street_address_2+street_address_3+street_address_4+street_address_5),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												current_residence_county,legal_residence_county,
												StringLib.StringFilter(StringLib.StringToUpperCase(race),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(race_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												sex,
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                        height,weight,											
												_3g_offender,violent_offender,sex_offender,vop_offender,data_type,record_setup_date,
                        datasource,
												StringLib.StringFilter(StringLib.StringToUpperCase(p_city_name),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												st,zip5,
                        /* cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,*/
                        county_name,did,ssn_appended,curr_incar_flag,curr_parole_flag,curr_probation_flag,
                        image_link,fcra_conviction_flag, fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,
												offender_persistent_id,local);

////////////////////////////////////////////////////////////////////////////////////
//Fix to accommodate current FCRA Offender file/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	
	dslayout2 := record
		all_files; 
		string1 off_name_type;
	end;
	
	dslayout2 addONT(all_files l):= transform
		self.off_name_type := l.pty_typ;
		did      := MAP( trim(l.did_to_keep, left, right)<>'000000000000' and l.did = l.did_to_keep => l.did,'');
		//Added this filter as per Linking team. Added as part proj Juli
		self.did := MAP(~((unsigned)l.did>0 and l.xadl2_weight >=35 and (l.xadl2_distance>=9 or l.xadl2_distance=0))=>'',
		                did);
		self     := l;
	end;
	
add_ONT := project(all_files, addONT(left));
	
dCrimOffender2FixedDist 			:= distribute(add_ONT,hash(Offender_Key));
// Sort gives us filled DIDs first, and if no DIDs filled, name type "0" first
// by default.  Keep in mind that "2" record types would not have DID'd anyway.

dCrimOffender2FixedSorted			:= sort(dCrimOffender2FixedDist,Offender_Key,-DID,Off_Name_Type,local);
dCrimOffender2FixedGrouped		:= group(dCrimOffender2FixedSorted,Offender_Key);

	dslayout2 tFixNameType(dslayout2 pLeft, dslayout2 pRight):= transform
		self.Off_Name_Type	:= if(pLeft.Offender_Key='','0','2');
		self								:= pRight;
	end;

dCrimOffender2FixedTypeSet		:= iterate(dCrimOffender2FixedGrouped,tFixNameType(left,right));
dCrimOffender2FixedReady			:= ungroup(dCrimOffender2FixedTypeSet);
//dCrimOffender2FixedReadywithDIDFilter := dCrimOffender2FixedReady();
corrections.layout_offender RemF(dCrimOffender2FixedReady l):= transform
		self.did 						:= if(l.off_name_type= '2',
														'',
														l.did);	
		self.ssn						:= if(l.off_name_type= '2',
														  '',
														  l.ssn);
		self.ssn_appended		:= if(l.off_name_type= '2',
														  '',
														  l.ssn_appended);

		self := l;
	end;

  FCRA_records:= project(dCrimOffender2FixedReady, RemF(left));
	FsortedOffender :=  sort(distribute(FCRA_records,HASH(offender_key,vendor,source_file)),
                        offender_key,vendor,source_file,record_type,orig_state,id_num,
                        StringLib.StringFilter(StringLib.StringToUpperCase(pty_nm),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//pty_nm_fmt,
												StringLib.StringFilter(StringLib.StringToUpperCase(orig_lname+orig_fname+orig_mname+orig_name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//lname,fname,mname,name_suffix,pty_typ,//nid,
												StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												// ntype,nindicator,nitro_flag,
												ssn,case_num,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												case_date,case_type,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_type_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												county_of_origin,
												StringLib.StringFilter(StringLib.StringToUpperCase(dle_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												fbi_num,doc_num,ins_num,dl_num,dl_state,dob,dob_alias,county_of_birth,place_of_birth,
												StringLib.StringFilter(StringLib.StringToUpperCase(street_address_1+street_address_2+street_address_3+street_address_4+street_address_5),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												current_residence_county,legal_residence_county,
												StringLib.StringFilter(StringLib.StringToUpperCase(race),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(race_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												sex,
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                        height,weight,												
												_3g_offender,violent_offender,sex_offender,vop_offender,data_type,record_setup_date,
                        datasource,
												StringLib.StringFilter(StringLib.StringToUpperCase(p_city_name),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												st,zip5,
                        // cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,
                        county_name,did,ssn_appended,curr_incar_flag,curr_parole_flag,curr_probation_flag,
                        image_link,fcra_conviction_flag, fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,
												offender_persistent_id,-ace_fips_st,-src_upload_date,-age,-zip4,-citizenship,-prim_range,-predir,-prim_name,-addr_suffix,-postdir,-unit_desig,-sec_range,local);
FCRA_records_dedup :=   dedup(sortedOffender,
                        offender_key,vendor,source_file,record_type,orig_state,id_num,
                        StringLib.StringFilter(StringLib.StringToUpperCase(pty_nm),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												//pty_nm_fmt,
												StringLib.StringFilter(StringLib.StringToUpperCase(orig_lname+orig_fname+orig_mname+orig_name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(lname+fname+mname+name_suffix),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												// ntype,nindicator,nitro_flag,
												ssn,case_num,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_court),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												case_date,case_type,
												StringLib.StringFilter(StringLib.StringToUpperCase(case_type_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												county_of_origin,
												StringLib.StringFilter(StringLib.StringToUpperCase(dle_num),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												fbi_num,doc_num,ins_num,dl_num,dl_state,dob,dob_alias,county_of_birth,place_of_birth,
												StringLib.StringFilter(StringLib.StringToUpperCase(street_address_1+street_address_2+street_address_3+street_address_4+street_address_5),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												current_residence_county,legal_residence_county,
												StringLib.StringFilter(StringLib.StringToUpperCase(race),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(race_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												sex,
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(hair_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(eye_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(skin_color_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												StringLib.StringFilter(StringLib.StringToUpperCase(party_status_desc),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
                        height,weight,											
												_3g_offender,violent_offender,sex_offender,vop_offender,data_type,record_setup_date,
                        datasource,
												StringLib.StringFilter(StringLib.StringToUpperCase(p_city_name),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
												st,zip5,
                        /* cart,cr_sort_sz,lot,lot_order,dpbc,chk_digit,rec_type,ace_fips_county,geo_lat,geo_long,msa,geo_blk,geo_match,*/
                        county_name,did,ssn_appended,curr_incar_flag,curr_parole_flag,curr_probation_flag,
                        image_link,fcra_conviction_flag, fcra_traffic_flag,fcra_date,fcra_date_type,conviction_override_date,conviction_override_date_type,offense_score,
												offender_persistent_id,local);

////////////////////////////////////////////////////////////////////////////////////

  PromoteSupers.MAC_SF_BuildProcess(NonFCRA_records_dedup,'~thor_Data400::base::corrections_offenders_' + doxie_build.buildstate, outOffnd, 2,,TRUE);
	PromoteSupers.MAC_SF_BuildProcess(FCRA_records_dedup,'~thor_data400::base::fcra_corrections_offenders_' + doxie_build.buildstate, outOffnd2, 2,,TRUE);			 
	PromoteSupers.MAC_SF_BuildProcess(hygenics_crim.File_AddressCacheInput,'~thor_data400::base::crim::address_cache_' + doxie_build.buildstate, outOffnd3, 2,,TRUE);
							 
export Out_Offender := sequential(
												outOffnd,
												//output(all_files,,'~thor_data400::base::fcra::life_eir::criminal_offenders_20130410'/* + Version.Development*/, overwrite, __compressed__),
												outOffnd2,
												outOffnd3);		 