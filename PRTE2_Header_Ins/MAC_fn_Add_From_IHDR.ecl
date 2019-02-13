/* ********************************************************************************************
PRTE2_Header_Ins.MAC_fn_Add_From_IHDR

Transform records coming in from IHDR into valid BHDR records
Probably could have been just a function ... but works so no big deal
******************************************************************************************** */
EXPORT MAC_fn_Add_From_IHDR(IHDRDS) := FUNCTIONMACRO

	IMPORT Address, PRTE2_Common, doxie, NID;

	#uniquename(BHDRLayout)
	%BHDRLayout% := PRTE2_Header_Ins.Layouts.Base_Layout;
	#uniquename(lookups)
	%lookups% := doxie.lookup_setter(2,			'SEX') |
							 doxie.lookup_setter(3, 		'CRIM') |
							 doxie.lookup_setter(4, 		'CCW') |
							 doxie.lookup_setter(3, 		'VEH') |
							 doxie.lookup_setter(4, 		'DL') |
							 doxie.lookup_setter(3, 		'REL') |
							 doxie.lookup_setter(3, 		'FIRE') |
							 doxie.lookup_setter(3, 		'FAA') |
							 doxie.lookup_setter(3, 		'VESS') |
							 doxie.lookup_setter(3, 		'PROF') |
							 doxie.lookup_setter(3, 		'BUS') | 
							 doxie.lookup_setter(3, 		'PROP') | 
							 doxie.lookup_setter(3, 		'BK') |
							 doxie.lookup_setter(3, 		'PAW') | 
							 doxie.lookup_setter(3, 		'BC') | 
							 doxie.lookup_setter(3, 		'PROP_ASSES') | 
							 doxie.lookup_setter(3, 		'PROP_DEEDS') | 
							 doxie.lookup_setter(3, 		'PROV') | 
							 doxie.lookup_setter(3, 		'SANC') | ut.bit_set(0,0);
			
	#uniquename(trxFer)
	%BHDRLayout% %trxFer%(IHDRDS L, INTEGER cnt) := TRANSFORM
		addr1 := Address.Addr1FromComponents(L.fb_house_num,'',L.fb_street,L.fb_stsfx,'',L.fb_unit_name,L.fb_unit_no);
		clean_address	:= PRTE2_Common.Clean_Address.FromLine(addr1, l.fb_city,l.fb_state,l.fb_zip,'');
		boolean noError := clean_address.err_stat[1]<>'E';
		SELF.s_did := L.id;				
		SELF.did := L.id;			
		SELF.rid := L.id;
		SELF.pflag1 := '';
		SELF.pflag2 := '';
		SELF.pflag3 := '';
		SELF.src := 'EQ';
		SELF.dt_first_seen := (UNSIGNED3) L.fb_first_dt[1..6];
		SELF.dt_last_seen := 	(UNSIGNED3) L.fb_last_dt[1..6];
		SELF.dt_vendor_last_reported := 0;
		SELF.dt_vendor_first_reported := 0;
		SELF.dt_nonglb_last_seen := 0;
		SELF.rec_type := clean_address.rec_type;
		SELF.vendor_id := '';
		SELF.phone := '';
		SELF.ssn := l.fb_ssn;
		SELF.dob := (INTEGER4) L.fb_dob;
		SELF.title := '';
		SELF.fname := L.fb_first_name;
		SELF.mname := L.fb_mid_name;
		SELF.lname := L.fb_last_name;
		SELF.name_suffix := 	L.fb_sfx_name;
		SELF.prim_range := IF(noError,clean_address.prim_range,L.fb_house_num);
		SELF.predir := IF(noError,clean_address.predir,'');
		SELF.prim_name := IF(noError,clean_address.prim_name,L.fb_street);
		SELF.suffix := IF(noError,clean_address.addr_suffix,L.fb_stsfx);
		SELF.postdir := IF(noError,clean_address.postdir,'');
		SELF.unit_desig := IF(noError,clean_address.unit_desig,L.fb_unit_name);
		SELF.sec_range := IF(noError,clean_address.sec_range,L.fb_unit_no);
		SELF.city_name := IF(noError,clean_address.p_city_name,L.fb_city);
		SELF.st := IF(noError,clean_address.st,L.fb_state);
		SELF.zip := IF(noError,clean_address.zip,L.fb_zip);
		SELF.zip4 := IF(noError,clean_address.zip4,L.fb_zip4);
		SELF.county := clean_address.fips_county;
		SELF.geo_blk := clean_address.geo_blk;
		SELF.cbsa := '';
		SELF.tnt := '';
		SELF.valid_ssn := '';
		SELF.jflag1 := '';
		SELF.jflag2 := '';
		SELF.jflag3 := '';
		SELF.rawaid := 0;
		SELF.valid_dob := '';
		SELF.hhid := L.id;		// Unless we start having multiple records for one person??? several points have addr_ind=1 to only create one per person.
		SELF.county_name := '';
		SELF.listed_name := '';
		SELF.listed_phone := '';
		SELF.dod := 0;
		SELF.death_code := '';
		SELF.lookup_did := %lookups%;
		SELF.addr_suffix := IF(noError,clean_address.addr_suffix,L.fb_stsfx);
		SELF.p_city_name := IF(noError,clean_address.p_city_name,L.fb_city);
		SELF.v_city_name := IF(noError,clean_address.v_city_name,L.fb_city);
		SELF.cart := clean_address.cart;
		SELF.cr_sort_sz := clean_address.cr_sort_sz;
		SELF.lot := clean_address.lot;
		SELF.lot_order := clean_address.lot_order;
		SELF.dbpc := clean_address.dbpc;
		SELF.chk_digit := clean_address.chk_digit;
		SELF.geo_lat := clean_address.geo_lat;
		SELF.geo_long := clean_address.geo_long;
		SELF.msa := clean_address.msa;
		SELF.geo_match := clean_address.geo_match;
		SELF.err_stat := clean_address.err_stat;
		SELF.uid := L.id;			// Unless we start having multiple records for one person??? several points have addr_ind=1 to only create one per person.
		SELF.dph_lname := metaphonelib.DMetaPhone1(l.fb_last_name);
		SELF.l4 := l.fb_last_name[1..4];
		SELF.f3 := l.fb_last_name[1..3];
		SELF.s1 := ((string)l.fb_ssn)[1..1];
		SELF.s2 := ((string)l.fb_ssn)[2..2];
		SELF.s3 := ((string)l.fb_ssn)[3..3];
		SELF.s4 := ((string)l.fb_ssn)[4..4];
		SELF.s5 := ((string)l.fb_ssn)[5..5];
		SELF.s6 := ((string)l.fb_ssn)[6..6];
		SELF.s7 := ((string)l.fb_ssn)[7..7];
		SELF.s8 := ((string)l.fb_ssn)[8..8];
		SELF.s9 := ((string)l.fb_ssn)[9..9];
		SELF.ssn4 := ((string)l.fb_ssn)[6..9];
		SELF.ssn5 := ((string)l.fb_ssn)[1..5];
		SELF.city_code := doxie.Make_CityCode(l.fb_city);
		SELF.pfname := NID.PreferredFirstVersionedStr(l.fb_first_name,2);
		SELF.minit := l.fb_mid_name[1];
		SELF.yob := (integer)l.fb_dob[1..4];
		SELF.states := 0;
		SELF.lname1 := 0;
		SELF.lname2 := 0;
		SELF.lname3 := 0;
		SELF.city1 := 0;
		SELF.city2 := 0;
		SELF.city3 := 0;
		SELF.rel_fname1 := 0;
		SELF.rel_fname2 := 0;
		SELF.rel_fname3 := 0;
		SELF.fname_count := 0;
		SELF.p7 := '';
		SELF.p3 := '';
		SELF.person1 := 0;
		SELF.same_lname := true;
		SELF.number_cohabits := 0;
		SELF.recent_cohabit := 198001;
		SELF.person2 := 0;
		SELF.zero := 0;
		SELF.lookups := %lookups%;
		SELF.addr_dt_last_seen := (UNSIGNED3)l.fb_last_dt[1..6];
		SELF.prpty_deed_id := '';
		SELF.vehicle_vehnum := '';
		SELF.bkrupt_crtcode_caseno := '';
		SELF.main_count := 0;
		SELF.search_count := 0;
		SELF.dl_number := L.fb_dln;
		SELF.bdid := '';
		SELF.run_date := 0;
		SELF.total_records := 0;
		SELF.addr_dt_first_seen := (UNSIGNED3)l.fb_first_dt[1..6];
		SELF.adl_ind := '';
		SELF.s_ssn := l.fb_ssn;
		SELF.cnt := 2;
		SELF.cellphone := FALSE;
		SELF.persistent_record_ID := 0;
		SELF.rtitle := 0;
		SELF := L;		// populate the IHDR_Sub_FB side.
		SELF := [];
	END;

	#uniquename(merge2add)
	%merge2add%	:= PROJECT( IHDRDS, %trxFer%(LEFT,COUNTER) );					// addr_ind=1 to only create one per person.  We may have to copy secondary at some point?
	RETURN SORT(%merge2add%,did);

ENDMACRO;
