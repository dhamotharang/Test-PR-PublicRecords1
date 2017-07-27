EXPORT MAC_MiniDriversBuild
(
	DriversFileIn, 
	DriversFileOut,
	didPersons = 'false',
	did_how = '\'remote\''
) := MACRO

// Sequence incoming file
#uniquename(layout_seq)
%layout_seq% := RECORD
	UNSIGNED4 seq_no := 0;
	DriversFileIn;
END;

#uniquename(add_seq)
%layout_seq% %add_seq%(%layout_seq% l, %layout_seq% r) := TRANSFORM
	SELF.seq_no := IF(l.seq_no = 0, thorlib.node() + 1, l.seq_no + thorlib.nodes());
	SELF := r;
END;

#uniquename(sequenced)
%sequenced% := ITERATE(
		TABLE(DriversFileIn, %layout_seq%), 
		%add_seq%(LEFT, RIGHT), LOCAL);

// Slim down for processing
#uniquename(layout_slim)
%layout_slim% := RECORD
	%sequenced%.seq_no;
	UNSIGNED4 newest_seq_no := %sequenced%.seq_no;
	%sequenced%.orig_state;
	%sequenced%.dl_number;
	%sequenced%.dt_first_seen;
	%sequenced%.dt_last_seen;
	%sequenced%.dt_vendor_first_reported;
	%sequenced%.dt_vendor_last_reported;
	%sequenced%.orig_expiration_date;
	%sequenced%.history;
	DATA16 record_hash := HASHMD5(
		%sequenced%.orig_state,
		%sequenced%.dl_number,
		%sequenced%.name,
		%sequenced%.addr1,
		%sequenced%.city,
		%sequenced%.state,
		%sequenced%.zip,
		%sequenced%.dob,
		%sequenced%.race,
		%sequenced%.sex_flag,
		%sequenced%.license_type,
		%sequenced%.attention_flag,
		%sequenced%.dod,
		%sequenced%.restrictions,
		%sequenced%.orig_expiration_date,
		%sequenced%.orig_issue_date,
		%sequenced%.lic_issue_date,
		%sequenced%.expiration_date,
		%sequenced%.active_date,
		%sequenced%.inactive_date,
		%sequenced%.lic_endorsement,
		%sequenced%.motorcycle_code,
		%sequenced%.ssn,
		%sequenced%.age,
		%sequenced%.privacy_flag,
		%sequenced%.driver_edu_code,
		%sequenced%.dup_lic_count,
		%sequenced%.rcd_stat_flag,
		%sequenced%.height,
		%sequenced%.hair_color,
		%sequenced%.eye_color,
		%sequenced%.weight,
		%sequenced%.oos_previous_dl_number,
		%sequenced%.oos_previous_st,
		%sequenced%.status,
		%sequenced%.issuance,
		%sequenced%.address_change,
		%sequenced%.name_change,
		%sequenced%.dob_change,
		%sequenced%.sex_change,
		%sequenced%.old_dl_number,
		%sequenced%.dl_key_number);
END;

#uniquename(drivers_slim)
%drivers_slim% := TABLE(%sequenced%, %layout_slim%);

//****** Check each rec to make sure it did not expire b4 that states initial load
//		 If it did, then zero out its dates

#uniquename(drivers_exp)
drivers.MAC_Check_Expire(%drivers_slim%, orig_expiration_date, %drivers_exp%)

//****** Get rid of recs that are just a state dumping the same thing again
#uniquename(drivers_sort)
%drivers_sort% := SORT(
					DISTRIBUTE(%drivers_exp%, HASH(dl_number, orig_state)),
					dl_number, orig_state, record_hash, dt_first_seen, LOCAL);
		
// Keep the oldest record, but remember the newest sequence number
// so that we can take the cleaned fields from that one at the end.
#uniquename(roll_seq)
%layout_slim% %roll_seq%(%drivers_sort% l, %drivers_sort% r) := TRANSFORM
	SELF.newest_seq_no := r.seq_no;
	SELF := l;
END;

#uniquename(drivers_deduped)
%drivers_deduped% := ROLLUP(%drivers_sort%,
	LEFT.dl_number = RIGHT.dl_number AND
	LEFT.orig_state = RIGHT.orig_state AND
	LEFT.record_hash = RIGHT.record_hash,
	%roll_seq%(LEFT, RIGHT), LOCAL);


//****** Set the history flag update the dt_last_seen where there is a newer rec for that person

#uniquename(drivers_grp)
%drivers_grp% := GROUP(
		SORT(%drivers_deduped%(history != 'E'),
			dl_number, orig_State, -dt_last_seen, -dt_first_seen, -orig_expiration_Date, LOCAL),
			dl_number, orig_State, LOCAL);

#uniquename(make_hist)
TYPEOF(%drivers_grp%) %make_hist%(%drivers_grp% l, %drivers_grp% r) := TRANSFORM
  SELF.history := MAP(r.orig_expiration_Date > 0 AND r.orig_expiration_Date < (UNSIGNED4) ut.GetDate => 'E',
					  l.orig_state = '' => r.history,
					  'H');
  SELF.dt_last_seen := IF(r.dt_last_seen > 0 AND l.dt_first_seen > r.dt_last_seen,
						  l.dt_first_seen, r.dt_last_seen);
  SELF := r;
END;

#uniquename(drivers_hist)
%drivers_hist% := GROUP(ITERATE(%drivers_grp%, %make_hist%(LEFT, RIGHT)))
		+ %drivers_deduped%(history = 'E');

#uniquename(process_restrictions)
STRING %process_restrictions%(STRING rest) :=
							  rest[1] + 
									if(rest[2]<>' ',','+rest[2],'') +
									if(rest[3]<>' ',','+rest[3],'') + 
									if(rest[4]<>' ',','+rest[4],'') +
									if(rest[5]<>' ',','+rest[5],'') +
									if(rest[6]<>' ',','+rest[6],'') + 
									if(rest[7]<>' ',','+rest[7],'') + 
									if(rest[8]<>' ',','+rest[8],'') + 
									if(rest[9]<>' ',','+rest[9],'') +
									if(rest[10]<>' ',','+rest[10],'');
		
// Join the original fields
#uniquename(layout_original)
%layout_original% := RECORD
	%layout_seq%;
	UNSIGNED4 newest_seq_no;
END;

#uniquename(take_original)
%layout_original% %take_original%(%drivers_hist% l, %sequenced% r) := TRANSFORM
	SELF.newest_seq_no := l.newest_seq_no;
	SELF.history := l.history;
	SELF.dt_last_seen := l.dt_last_seen;
	SELF.dt_first_seen := l.dt_first_seen;
	SELF.dt_vendor_first_reported := l.dt_vendor_first_reported;
	SELF.dt_vendor_last_reported := l.dt_vendor_last_reported;
	SELF.restrictions_delimited := if(r.restrictions_delimited <> '', r.restrictions_delimited, 
												 %process_restrictions%(r.restrictions));
	SELF.ssn_safe := r.ssn;
	SELF := r;
END;

#uniquename(get_node)
%get_node%(UNSIGNED4 num) :=  (num - 1) % thorlib.nodes();

#uniquename(j_orig)
%j_orig% := JOIN(
	SORT(
		DISTRIBUTE(%drivers_hist%, %get_node%(seq_no)),
		seq_no, LOCAL),
	%sequenced%,
	LEFT.seq_no = RIGHT.seq_no, 
	%take_original%(LEFT, RIGHT), NOSORT, LOCAL);

#uniquename(take_latest)
%layout_seq% %take_latest%(%j_orig% l, %sequenced% r) := TRANSFORM
	SELF.title := r.title;
	SELF.fname := r.fname;
	SELF.mname := r.mname;
	SELF.lname := r.lname;
	SELF.name_suffix := r.name_suffix;
	SELF.cleaning_score := r.cleaning_score;
	SELF.addr_fix_flag := r.addr_fix_flag;
	SELF.prim_range := r.prim_range;
	SELF.predir := r.predir;
	SELF.prim_name := r.prim_name;
	SELF.suffix := r.suffix;
	SELF.postdir := r.postdir;
	SELF.unit_desig := r.unit_desig;
	SELF.sec_range := r.sec_range;
	SELF.p_city_name := r.p_city_name;
	SELF.v_city_name := r.v_city_name;
	SELF.st := r.st;
	SELF.zip5 := r.zip5;
	SELF.zip4 := r.zip4;
	SELF.cart := r.cart;
	SELF.cr_sort_sz := r.cr_sort_sz;
	SELF.lot := r.lot;
	SELF.lot_order := r.lot_order;
	SELF.dpbc := r.dpbc;
	SELF.chk_digit := r.chk_digit;
	SELF.rec_type := r.rec_type;
	SELF.ace_fips_st := r.ace_fips_st;
	SELF.county := r.county;
	SELF.geo_lat := r.geo_lat;
	SELF.geo_long := r.geo_long;
	SELF.msa := r.msa;
	SELF.geo_blk := r.geo_blk;
	SELF.geo_match := r.geo_match;
	SELF.err_stat := r.err_stat;
	SELF.seq_no := r.seq_no;
	SELF := l;
END;

#uniquename(j_latest)
%j_latest% := JOIN(
	SORT(
		DISTRIBUTE(%j_orig%(seq_no != newest_seq_no), %get_node%(newest_seq_no)),
		newest_seq_no, LOCAL),
	%sequenced%,
	LEFT.newest_seq_no = RIGHT.seq_no,
	%take_latest%(LEFT, RIGHT), NOSORT, LOCAL);

#uniquename(strip_seq)
%layout_seq% %strip_seq%(%j_orig% l) := TRANSFORM
	SELF := l;
END;

#uniquename(j_all)
%j_all% := PROJECT(%j_orig%(seq_no = newest_seq_no), %strip_seq%(LEFT))
			+ %j_latest%;
			
// Slim down again for did
#uniquename(prep_for_roxie)
didville.Layout_Did_InBatch %prep_for_roxie%(%j_all% l) :=
TRANSFORM
	SELF.seq := l.seq_no;
	SELF.suffix := l.name_suffix;
	SELF.addr_suffix := l.suffix;
	SELF.z5 := l.zip5;
	SELF.phone10 := '';
	SELF.DOB := IF(L.dob = 0, '', INTFORMAT(l.dob, 8, 1));
	SELF := l;
END;

#uniquename(to_did)
%to_did% := PROJECT(%j_all%, %prep_for_roxie%(LEFT));

#uniquename(did_added)
#uniquename(thor_added)
#if(did_how = 'remote')
// pass to roxie
DID_Add.Mac_Match_Fast_Roxie(%to_did%, %did_added%)
#end

#if(did_how = 'local')
#uniquename(matchset)
%matchset% := ['A', 'D', 'S', 'P', '4', 'G', 'Z'];
DID_Add.MAC_Match_Fast(%to_did%, %matchset%, %thor_added%, false, true)
%did_added% := DISTRIBUTE(%thor_added%, %get_node%(seq));
#end

#if(did_how = 'hash')
did_add.mac_match_hash_roxie(%to_did%, %thor_added%)
%did_added% := DISTRIBUTE(%thor_added%, %get_node%(seq));
#end


// Join back to the wide file.
#uniquename(add_did)
typeof(DriversFileIn) %add_did%(%did_added% l, %j_all% r) := TRANSFORM
	SELF.did := l.did;
#if(did_how != 'hash')
	SELF.ssn := IF((UNSIGNED) r.ssn = 0, l.best_ssn, r.ssn);
#end
	SELF := r;
END;

#uniquename(j_did)
%j_did% := JOIN(
	SORT(%did_added%, seq, LOCAL),
	SORT(%j_all%, seq_no, LOCAL),
	LEFT.seq = RIGHT.seq_no,
	%add_did%(LEFT, RIGHT), NOSORT, LOCAL);

#if(didPersons)
DriversFileOut := %j_did%;
#else
DriversFileOut := %j_all%;
#end

ENDMACRO;