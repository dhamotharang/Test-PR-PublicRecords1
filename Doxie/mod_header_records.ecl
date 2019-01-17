import doxie, autokey, ut, header, Doxie_Raw, gong_Services, header_quick, AutoStandardI, infutor, Std;

Did_Type_Mask_value:= AutoStandardI.InterfaceTranslator.Did_Type_mask_val.val(project(AutoStandardI.GlobalModule(),
																												AutoStandardI.InterfaceTranslator.Did_Type_mask_val.params));
did_bitmask := DidType.GetBitType (Did_Type_Mask_value); // bit-wise integer representation

export mod_header_records(
	boolean DoSearch,													//this controls whether gong, util, and quick header do their own searches
																						// or just use the input DIDs
	boolean include_dailies = false, 					//these two parms from doxie.header_records
	boolean allow_wildcard = false,
	boolean include_gong = true,
	boolean suppress_gong_noncurrent = false,
	set of STRING1 daily_autokey_skipset=[],
	boolean AllowGongFallBack = true,
	boolean ApplyBpsFilter = false,
	boolean GongByDidOnly = false,             // this serves as an override to gong searching, needed separate control for M2R
  doxie.IDataAccess modAccess = MODULE (doxie.IDataAccess) END
) := MODULE

// have to declare these for now, since they are used in a macro below
shared string5 industry_class_value := modAccess.industry_class;
shared unsigned1 dppa_purpose := modAccess.dppa;
shared unsigned1 glb_purpose := modAccess.glb;
shared boolean probation_override_value := modAccess.probation_override;
shared boolean no_scrub := modAccess.no_scrub;

shared dppa_ok := modAccess.isValidDPPA ();
shared glb_ok := modAccess.isValidGLB ();
shared boolean is_knowx := modAccess.isConsumer ();

//***** GET THE DAILIES EITHER BY SEARCH OR FETCH
export mod_Daily(dataset(Doxie.layout_references_hh) d):=
MODULE

	shared DailyGong := 
		IF(include_dailies AND ~is_knowx,
			 gong_services.Fetch_Gong_History(d(~includedByHHID),true,true,,/*did_onlyL:=*/ not DoSearch or GongByDidOnly,suppress_gong_noncurrent, 
																				AllowLeadingLnameMatch := AutoKey.skipSetTools(daily_autokey_skipset).AddZipL, 
																				AllowFallBack := AllowGongFallBack, AllowLooseSuffixMatch:=false));
	shared DailyUtil := 
		IF(include_dailies AND modAccess.industry_class<>'UTILI' and ~is_knowx and glb_ok /* glb_ok is redundant here, because the underlying attributes apply glb. But it should perform better, since we avoid an additional call. */,
			 IF(DoSearch, 
					doxie.Fetch_Utility_Daily(d,dppa_purpose,glb_purpose,industry_class_value,allow_wildcard,daily_autokey_skipset,ApplyBpsFilter),
					Doxie_Raw.Util_Daily_Raw(d,0,dppa_purpose,glb_purpose,industry_class_value)));
	shared DailyQuick := 
		IF(include_dailies AND ~is_knowx, 
			 IF(DoSearch, 
					header_quick.fetch_records(d, include_dailies, allow_wildcard,daily_autokey_skipset,ApplyBpsFilter),
doxie_Raw.QuickHeader_raw(d,modAccess.date_threshold,dppa_purpose,glb_purpose,,modAccess.ln_branded,probation_override_value, maskSSN:=false)));

	//***** FOR THOSE SEARCHING, EXPORT THE DIDS WE FOUND

	export AddDIDs := DEDUP(
		PROJECT(DailyGong(did<>0),layout_references_hh)+
		PROJECT(DailyUtil((unsigned6)did<>0),TRANSFORM(layout_references_hh, SELF.did := (unsigned6)LEFT.did;SELF := LEFT;))+
		PROJECT(DailyQuick(did<>0),layout_references_hh)+
		d,all);
				

	//***** FORMAT AND CHECK PERMISSIONS FOR AND EXPORT THE DAILIES
		
	doxie.layout_header_records gong2Pretty(DailyGong le, INTEGER i) :=
	TRANSFORM
		isCur := le.current_record_flag='Y';
		SELF.did := le.did;
		SELF.rid := autokey.did_adder('GONG')+i;
		SELF.src := 'PH';
		SELF.fname := le.name_first;
		SELF.mname := le.name_middle;
		SELF.lname := le.name_last;
		SELF.name_suffix := le.name_suffix;
		SELF.city_name := le.p_city_name;
		SELF.zip := le.z5;
		SELF.zip4 := le.z4;
		SELF.phone := le.phone10;
		SELF.listed_phone := IF(isCur,le.phone10,'');
		SELF.listed_name := IF(isCur,le.listed_name,'');
		SELF.listing_type_bus := le.listing_type_bus;
		SELF.listing_type_gov := le.listing_type_gov;
		SELF.caption_text := le.caption_text;
		SELF.bdid := le.bdid;
		SELF.dt_first_seen := (unsigned4)(le.dt_first_seen[1..6]);
		SELF.dt_last_seen := IF((unsigned4)(le.dt_last_seen[1..6])=0,SELF.dt_first_seen,
																																 (unsigned4)(le.dt_last_seen[1..6]));
		SELF.dt_nonglb_last_seen  := SELF.dt_last_seen;
		SELF.TNT := IF(isCur,'V','H');
		SELF.county := le.county_code[3..5];
		SELF.listed_name_prefix := IF(isCur,le.name_prefix,'');
		SELF.listed_name_first := IF(isCur,le.name_first,'');
		SELF.listed_name_middle := IF(isCur,le.name_middle,'');
		SELF.listed_name_last := IF(isCur,le.name_last,'');
		SELF.listed_name_suffix := IF(isCur,le.name_suffix,'');
		SELF := le;
		SELF := [];
	END;

	doxie.layout_header_records util2Pretty(DailyUtil le) :=
	TRANSFORM
		SELF.did := (unsigned6)le.did;
		SELF.rid := le.fdid;
		// bug 61233 this is where we need to add source code for type=z "non-utility" data.
		SELF.src := IF (trim(le.util_type) ='Z','ZU','DU');
		self.suffix := le.addr_suffix;
		self.city_name := le.v_city_name;
		self.dt_first_seen :=  ut.Min2((integer)((string)Std.Date.Today())[1..6],(integer)le.date_first_seen div 100);
		self.dt_last_seen := self.dt_first_seen;
		self.dt_vendor_first_reported := self.dt_first_seen;
		self.dt_nonglb_last_seen := self.dt_first_seen;
		self.county := le.county[3..5];
		self.tnt := 'H';
		self.dob := (unsigned)le.dob;
		SELF := le;
		SELF := [];
	END;

	doxie.layout_header_records quick2Pretty(DailyQuick ri) :=
	TRANSFORM
		self := ri;
		self := [];
	END;

	gongPretty := PROJECT(DailyGong,gong2Pretty(LEFT,COUNTER));
	utilPretty := PROJECT(DailyUtil,util2Pretty(LEFT));
	quickPretty := project(DailyQuick,quick2Pretty(LEFT));
	dailies_uncleaned0 := gongPretty+utilPretty+quickPretty;

	// instead of checking DIDType for dailies, just only allow the dailies if allowing all DIDTypes
	shared dailies_uncleaned := IF (did_bitmask = doxie.DidType.ALL_TYPES, dailies_uncleaned0);

	header.MAC_GlbClean_Header(dailies_uncleaned,dailies_pre, , ,modAccess);

	// need to populate valid_ssn values for any daily records that have an SSN (since they are not populated
	// in the QuickHeader or Util builds)
	//
	// need to match these records against the header and pick up the corresponding valid_ssn value (or 'U' if no match)
	dailies_pre getValidSSN(dailies_pre le, doxie.Key_Header ri) := transform
		self.valid_ssn := if(ri.did = 0, 'U', ri.valid_ssn);
		self := le;
	end;
	
	dailies_w_validssn := join(dailies_pre(ssn <> ''), doxie.Key_Header, 
														 keyed(left.did = right.s_did) and 
																	 left.ssn = right.ssn and 
																	 right.valid_ssn <> 'M', 
														 getValidSSN(left, right), left outer, keep(1), limit (0));
	
	dailies := dailies_pre(ssn = '') + dailies_w_validssn;

	// output(industry_class);
	// output(include_dailies);
	// output(dosearch);
  // output(DailyUtil);
  //output(dailies_uncleaned);
  //output(dailies);
	
	export Records := dailies;
END;

//***** FETCH AND CHECK PERMISSIONS FOR AND EXPORT THE HEADER RECORDS
export mod_Header(dataset(Doxie.layout_references_hh) d):=
MODULE
	
	HeaderPretty_MACRO(key_hp,hp_out) := MACRO
	hp_out := join(d, key_hp, KEYED(left.did=right.s_did) and
															doxie.DidType.Test(right.lookup_did, did_bitmask) and
															(not ApplyBpsFilter or 
															doxie.bpssearch_filter.rec_OK(right.ssn, right.lname,right.fname,right.mname,
																														right.prim_range,right.prim_name,right.suffix,
																														right.sec_range,right.city_name,right.zip,
																														right.phone,right.listed_phone,right.dob)
															), 
											 transform(doxie.layout_header_records, 
																 self.includedByHHID := left.includedByHHID,
																 self := right,
																 self.penalt := 0,
																 self.num_compares := 0),
											 LIMIT(ut.limits .DID_PER_PERSON, SKIP));	
	ENDMACRO;
	HeaderPretty_MACRO(Infutor.Key_Header_Infutor_Knowx,infr_out1)
	HeaderPretty_MACRO(doxie.key_header,hdr_out1)
	headerPretty := if(Is_knowx
	               ,infr_out1
								 ,hdr_out1);

  export HeaderRecords_Unclean := headerPretty;

	header.MAC_GlbClean_Header(HeaderRecords_Unclean,headerCleaned, , ,modAccess);
	export Records := project(headerCleaned, doxie.layout_presentation);  //is already in this layout, but compiler doesn't know that
END;

//***** EXPORT COMBO

export Results(dataset(Doxie.layout_references_hh) d) :=
project(
	mod_Daily(d).Records + mod_Header(d).Records, 
	doxie.layout_presentation
);

END;