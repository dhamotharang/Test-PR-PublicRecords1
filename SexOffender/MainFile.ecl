/*2009-12-01T16:53:41Z (Judy Tao)

*/
import doxie_build, codes, didville, did_add, header_slimsort, watchdog, ut, _control, header;

// 'local'
// 'hash'
// 'remote'
did_how := 'local';

//#stored('did_add_force','roxi'); // remove or set to 'thor' to put recs through thor
#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor

df_orig := sexoffender.allpeople;
Layout_seq := record
	unsigned seq;
	df_orig;
end;
ut.MAC_Sequence_Records_NewRec(df_orig, Layout_seq, seq, df)

didville.Layout_Did_InBatch prep_for_did(df l) := transform
  self.phone10 := '';
	self.suffix := l.name_suffix;
	self.z5 := l.zip5;
	self := l;
end;
to_did := project(df, prep_for_did(LEFT));

didoutrec := record
	to_did;
	unsigned6	did;
	unsigned1 score;
	string9	ssn_added;
end;

#if(did_how = 'remote')
DID_Add.Mac_Match_Fast_Roxie(to_did, remote_out,'','BEST_SSN','ALL',true,true)

didoutrec did_ssn_remote(remote_out l) := transform
	self.ssn_added := l.best_ssn;
	self := l;	
end;

did_ssn_added := project(remote_out,did_ssn_remote(LEFT));
#end

#if(did_how = 'local')
#uniquename(matchset)
matchset := ['A', 'D', 'S', '4', 'G', 'Z'];
DID_Add.MAC_Match_Fast(to_did,matchset,local_out,false,true)

didoutrec did_ssn_local(local_out l) := transform
	self.ssn_added := l.best_ssn;
	self.score := l.did_score;
	self := l;
end;

did_ssn_added := project(local_out,did_ssn_local(LEFT));
#end

#if(did_how = 'hash')
did_add.mac_match_hash_roxie(to_did, hash_out)

didoutrec did_ssn_hash(hash_out l) := transform
	self.ssn_added := '';
	self.score := 0;
	self := l;
end;

did_ssn_added := project(hash_out,did_ssn_hash(left));
#end

typeof(df_orig) appendDID_SSN(did_ssn_added l, df r) := transform
	#if(did_how = 'remote')
		self.did          := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,12,1), intformat(l.did,12,1));
		self.score        := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,3,1), intformat(l.score,3,1));
		self.ssn_appended := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8),'',l.ssn_added);
	#end
	#if(did_how = 'local')
		self.did          := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,12,1), intformat(l.did,12,1));
		self.score        := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8), intformat(0,3,1), intformat(l.score,3,1));
		self.ssn_appended := if(l.score < 75 or (l.score=75 and length(trim(l.dob))<8),'',l.ssn_added);
	#end
	#if(did_how = 'hash')
		self.did := intformat(l.did,12,1);
		self.score := intformat(l.score,3,1);
	#end
	
	self := r;
end;

full_df := JOIN(did_ssn_added, df, LEFT.seq = RIGHT.seq, appendDID_SSN(LEFT, RIGHT), right outer);

full_df joinds(full_df l, full_df r) := transform
  self := r; 
end;

string os(string i) := if (i = '','',trim(i) + ' ');

sexoffender.Layout_Out_Main produce_main(full_df L) := transform
  self.orig_state := L.orig_state;
  self.vendor_code := L.vendor_code;
  self.source_file := L.source_file;
  self.name_type := L.name_type;
  self.dt_last_reported := L.dt_last_reported;
  self.dt_first_reported := L.dt_first_reported;
  self.seisint_primary_key := if(l.orig_state in ['VA', 'CO', 'IN'], 
								trim(L.vendor_code) + l.orig_state + trim(l.sor_number,left,right),
								trim(L.vendor_code) + trim(l.sor_number,left,right));
  self.registration_address_1 := os(L.prim_range) + os(L.predir) + os(L.prim_name) + os(L.addr_suffix) + L.postdir;
  self.registration_address_2 := os(L.unit_desig) + L.sec_range;
  self.registration_address_3 := trim(L.V_CITY_NAME) + ' ' + trim(L.ST) + ' ' + L.ZIP5;
  self.registration_address_4 := '';
  self.registration_address_5 := '';
  self.name_orig := (trim(L.FNAME) + ' ' + trim(L.MNAME) + ' ' + trim(L.LNAME) + ' ' + L.NAME_SUFFIX)[1..50];
  self.dob := L.dob;
  self.lname := L.LNAME;
  self.fname := L.FNAME;
  self.mname := L.MNAME;
  self.name_suffix := L.NAME_SUFFIX;
  self.reg_date_1 := L.DATE_ADDRESS_ADDED;
  self.registration_type := L.RESIDENT_or_TEMP;
  self.reg_date_1_type := 'Date Added';
  self.race := L.race;
  self.sex := L.SEX;
  self.eye_color := L.EYE_COLOR;
  self.weight := L.WEIGHT;
  self.height := L.height;
  self.hair_color := L.HAIR_COLOR;
  self.offender_status := L.STATUS;
  self.registration_county := L.COUNTY;
  self.did := (INTEGER)L.did;
  self.score := (INTEGER)L.score;
  self.ssn_appended := L.ssn_appended;
  self.addr_dt_last_seen := '';
  self := L;
end;

main1 := project(full_df,produce_main(LEFT));

//get addr_dt_last_seen from header and SO main
hdr := header.File_Headers;

hdr_slim_rec := record
	hdr.did;
	hdr.dt_last_seen;
	hdr.prim_range;
	hdr.prim_name;
	hdr.sec_range;
	hdr.zip;
end; 

hdr_slim_tbl := table(hdr, hdr_slim_rec)(prim_name<>'');
hdr_slim_tbl_dst := distribute(hdr_slim_tbl, hash(did));
hdr_slim_tbl_srt := sort(hdr_slim_tbl_dst, did, prim_range, prim_name, sec_range, zip, -dt_last_seen,local);
hdr_slim_tbl_dep := dedup(hdr_slim_tbl_srt, did, prim_range, prim_name, sec_range, zip, local);

main_dst := distribute(main1, hash(did));

sexoffender.Layout_Out_Main get_addr_dt(main_dst l, hdr_slim_tbl_dep r) := transform
     self.addr_dt_last_seen := map(l.prim_name = '' => '',
	                              r.dt_last_seen > (unsigned3)(l.reg_date_1[1..6]) => (string6)r.dt_last_seen, 
							l.reg_date_1[1..6]);
	self := l;
end;

main2 := join(main_dst, hdr_slim_tbl_dep,
              left.did = right.did and 
		    left.prim_range = right.prim_range and 
		    left.prim_name = right.prim_name and 
		    left.sec_range = right.sec_range and 
		    left.zip5 = right.zip, 
		    get_addr_dt(left, right),
		    left outer, local);

sexoffender.Layout_Out_Main getDecode(sexoffender.Layout_Out_Main L) := transform
    self.orig_state_code := L.orig_state;
	self.orig_state := codes.GENERAL.STATE_LONG(L.orig_state);
	self := L;
end;

main3 := project(main2, getDecode(LEFT));

// Bring in original, unmodified primary records
input_uncleaned := sexoffender.File_Accurint_In;

// Provide mapping for all blank columns
sexoffender.layout_out_main jAddMissingData(main3 L, input_uncleaned R) := transform
	self.addl_comments_1            := R.addl_comments_1;
	self.addl_comments_2            := R.addl_comments_2;
	self.corrective_lense_flag      := R.corrective_lense_flag;
	self.dob_aka                    := R.dob_aka;
	self.employer_address_1         := R.employer_address_1;
	self.employer_address_2         := R.employer_address_2;
	self.employer_address_3         := R.employer_address_3;
	self.employer_address_4         := R.employer_address_4;
	self.employer_address_5         := R.employer_address_5;
	self.employer_county            := R.employer_county;
	self.name_orig                  := R.name_orig;
	self.offender_status            := R.offender_status;
	self.orig_dl_number             := R.orig_dl_number;
	self.orig_dl_state              := R.orig_dl_state;
	self.orig_veh_color_1           := R.orig_veh_color_1;
	self.orig_veh_color_2           := R.orig_veh_color_2;
	self.orig_veh_make_model_1      := R.orig_veh_make_model_1;
	self.orig_veh_make_model_2      := R.orig_veh_make_model_2;
	self.orig_veh_plate_1           := R.orig_veh_plate_1;
	self.orig_veh_plate_2           := R.orig_veh_plate_2;
	self.orig_veh_state_1           := R.orig_veh_state_1;
	self.orig_veh_state_2           := R.orig_veh_state_2;
	self.orig_veh_year_1            := R.orig_veh_year_1;
	self.orig_veh_year_2            := R.orig_veh_year_2;
	self.police_agency              := R.police_agency;
	self.police_agency_address_1    := R.police_agency_address_1;
	self.police_agency_address_2    := R.police_agency_address_2;
	self.police_agency_contact_name := R.police_agency_contact_name;
	self.police_agency_phone        := R.police_agency_phone;
	self.reg_date_1                 := R.reg_date_1;
	self.reg_date_1_type            := R.reg_date_1_type;
	self.reg_date_2                 := R.reg_date_2;
	self.reg_date_2_type            := R.reg_date_2_type;
	self.reg_date_3                 := R.reg_date_3;
	self.reg_date_3_type            := R.reg_date_3_type;
	self.registration_address_1     := R.registration_address_1;
	self.registration_address_2     := R.registration_address_2;
	self.registration_address_3     := R.registration_address_3;
	self.registration_address_4     := R.registration_address_4;
	self.registration_address_5     := R.registration_address_5;
	self.registration_county        := R.registration_county;
	self.registration_type          := R.registration_type;
	self.school                     := R.school;
	self.school_address_1           := R.school_address_1;
	self.school_address_2           := R.school_address_2;
	self.school_address_3           := R.school_address_3;
	self.school_address_4           := R.school_address_4;
	self.school_address_5           := R.school_address_5;
	self.school_county              := R.school_county;
	self.shoe_size                  := R.shoe_size;
    self                            := L;
end;

// Join the data modified up until this point with the original input primary records
ds_fixed_data := join(distribute(main3          ,hash32(trim(seisint_primary_key[1..16],left,right)))
                     ,distribute(input_uncleaned,hash32(trim(seisint_primary_key[1..16],left,right)))
                     ,trim(LEFT.seisint_primary_key[1..16],left,right) = trim(RIGHT.seisint_primary_key[1..16],left,right)
					 ,jAddMissingData(left,right)
					 ,local);

//Fix: Orig DID <> AKA DID ///////////////////////////////////////////////////////////////////

//Orig Name Has DID
orig_did := ds_fixed_data(name_type='0' and did<>0);

//Orig Name Has No DID
orig_no_did := ds_fixed_data(name_type='0' and did=0);

aka_name := ds_fixed_data(name_type<>'0');

ds1_filter := ds_fixed_data(seisint_primary_key <> '' and name_type = '0');

ds1_filter joinds2(ds1_filter l, ds1_filter r) := transform
  self.did := l.did;
  self.score := l.score;
  self.ssn_appended := l.ssn_appended;
  self := r; 
end;

//Orig Name Has DID - Populate Orig DID to the AKAs
join_ds2 := join(ds1_filter, ds_fixed_data(seisint_primary_key <> '' and name_type <> '0'),      
			           trim(left.seisint_primary_key) = trim(right.seisint_primary_key),
			           joinds2(left,right));


fix_file := orig_did + orig_no_did + join_ds2 ;

//fix_file := orig_did + orig_no_did + join_ds2 : persist('~thor_data400::Persist::Sex_Offender_before_incarceration_flags');    
//fix_file := dataset('~thor_data400::Persist::Sex_Offender_With_did_ssn_flagged', sexoffender.layout_out_main, flat);

sexoffender.layout_out_main tr_set_flags(fix_file L) := TRANSFORM 

	registration_address_search_string 	:= 'INCARCERATED';
	offender_status_search_string 		:= ['CONFINED','CONFINEMENT','CURRENTLY INCARCERATED','IN CUSTODY',
											'IN CUSTODY ;COMPLIANT','INCARCERATED','JAIL','INCARCERATED REGISTERED']; 
	set_curr_incar_flag 				:= if(L.registration_address_1 = registration_address_search_string 
											or L.offender_status in offender_status_search_string,'Y','');

		SELF.curr_incar_flag := set_curr_incar_flag;
		SELF.curr_parole_flag := '';
		SELF.curr_probation_flag := '';
		SELF := L;
	END;    

ds_fixed_data_flagged := PROJECT(fix_file,tr_set_flags(LEFT));

/////////////////////////////////////////////////////////////////////////////////////////////

//export BWR_Produce_MainFile := output(ds_fixed_data,,'out::sex_offender_main'+ doxie_build.buildstate + sexOffender.version,overwrite) : persist('~thor_data400::Persist::Sex_Offender_With_did_ssn','thor_dell400_2');
export MainFile := ds_fixed_data_flagged : persist('~thor_data400::Persist::Sex_Offender_With_did_ssn','thor400_92');