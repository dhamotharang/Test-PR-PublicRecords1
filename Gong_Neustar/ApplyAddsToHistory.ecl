import gong, gong_v2, ut,header,header_quick,Header_Services,watchdog;


	Layout_History xNewHistory(Layout_gongMaster mstr) := TRANSFORM
		self.bell_id := 'NEU';
		self.current_record_flag := 'Y';
		self.deletion_date := '';		// all new records
		self.dt_first_seen := mstr.add_date;
		self.dt_last_seen := mstr.dt_last_seen;
		
		self.phone10 := mstr.phone10;
		self.listed_name := mstr.company_name;
		self.sequence_number := (string)mstr.sequence_number;
		self.persistent_record_id := 0;
		// names are cleaned
		//self.nid := mstr.nid;
		//self.nametype := mstr.nametype;
		//self.name_ind := mstr.name_ind;
		self.pclean := mstr.record_id;		// we don't need pclean, but we do need the record id
		
		/* fields are no longer populated in new records and need to be populated for history */
		self.v_predir := mstr.predir ;
		self.v_prim_name := mstr.prim_name ;
		self.v_suffix := mstr.suffix ;
		self.v_postdir := mstr.postdir ;	
		self := mstr;
		self := [];
	END;

/*
GetNewRecords(dataset(layout_gongMaster) adds, dataset(layout_history) h) := 

 JOIN(adds, h, 
					LEFT.record_id=RIGHT.pclean AND
					LEFT.publish_code = RIGHT.publish_code AND
				LEFT.listing_type_bus = RIGHT.listing_type_bus AND LEFT.listing_type_res = RIGHT.listing_type_res AND LEFT.listing_type_gov = RIGHT.listing_type_gov AND
				LEFT.  phone10 = RIGHT.phone10 AND
				LEFT.company_name = RIGHT.listed_name AND
				LEFT.caption_text = RIGHT.caption_text AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				LEFT.prim_name = RIGHT.v_prim_name AND
				LEFT.predir = RIGHT.v_predir AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				LEFT.suffix = RIGHT.v_suffix AND
				LEFT.postdir = RIGHT.v_postdi) AND
				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						xNewHistory(LEFT)
						),
				LEFT ONLY, LOCAL);
/*
GetUnchangedRecords(dataset(layout_gongMaster) adds, dataset(Layout_History) h) := 

 JOIN(h, adds, 
					LEFT.record_id=RIGHT.pclean AND
					LEFT.publish_code = RIGHT.publish_code AND
				LEFT.listing_type_bus = RIGHT.listing_type_bus AND LEFT.listing_type_res = RIGHT.listing_type_res AND LEFT.listing_type_gov = RIGHT.listing_type_gov AND
				LEFT.  phone10 = RIGHT.phone10 AND
				LEFT.listed_name = RIGHT.company_name AND
				UC(LEFT.		BUSINESS_CAPTIONS) = UC(RIGHT.BUSINESS_CAPTIONS) AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT_code = RIGHT.INDENT_code AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.		PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.		POST_DIR) = UC(RIGHT.POST_DIR) AND
				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(Layout_History,
									self.dt_first_seen := min(LEFT.dt_first_seen,RIGHT.dt_first_seen);
									self := LEFT;
						),
				LEFT ONLY, LOCAL);

GetUpdates(dataset(layout_gongMaster) adds, dataset(Layout_History) h) := 

 JOIN(h, adds, 
					LEFT.pclean=RIGHT.record_id AND
					LEFT.publish_code = RIGHT.publish_code AND
				LEFT.listing_type_bus = RIGHT.listing_type_bus AND LEFT.listing_type_res = RIGHT.listing_type_res AND LEFT.listing_type_gov = RIGHT.listing_type_gov AND
				LEFT.  phone10 = RIGHT.phone10 AND
				LEFT.listed_name = RIGHT.company_name AND
				UC(LEFT.		BUSINESS_CAPTIONS) = UC(RIGHT.BUSINESS_CAPTIONS) AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.		PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.		POST_DIR) = UC(RIGHT.POST_DIR) AND
				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(Layout_History,
									self.dt_first_seen := min(LEFT.dt_first_seen,RIGHT.dt_first_seen);
									self := LEFT;
						),
				INNER, LOCAL);



	
AddRecords(dataset(layout_gongMaster) adds, dataset(layout_history) history_base) := FUNCTION
		return GetNewRecords(adds, history_base);
END;
*/
/*
EXPORT ApplyAddsToHistory(dataset(layout_gongMaster) adds, dataset(layout_history) history_base, string update_date = ut.Now()) := FUNCTION

	new_history := PROJECT(adds, xNewHistory(LEFT));
	history_did_hhid := Gong_Neustar.fn_did_bdid_hhid(new_history);

	gong.mac_add_disc_cnt(history_did_hhid,update_date,history_with_count);
//*** 55136 Add gong lift (cjs) history 
	gong_v2.Macro_GongLift(history_with_count, history_with_lift);
	history_with_pdid := gong.fnPropagateADLs(history_with_lift).history;
//*** end gong lift

	history_new := history_base & history_with_pdid;
	history_with_pid := Gong_Neustar.Mac_Assign_UniqueId(history_new, persistent_record_id);
	
	history_with_pidd := DISTRIBUTE(history_with_pid,hash(phone10,prim_range,prim_name,z5,listed_name));	
	gong_neustar.Mac_Apply_Legal(history_with_pidd, hist_d_out);

	return hist_d_out;

END;
*/
EXPORT ApplyAddsToHistory(dataset(layout_gongMaster) adds, dataset(layout_history) history_base, string update_date = ut.Now()) := FUNCTION
//*** 55136 Add gong lift (cjs) history 
	//gong_v2.Macro_GongLift(history_with_count, history_with_lift);
	//history_with_pdid := gong.fnPropagateADLs(history_with_lift).history;
//*** end gong lift
	new_history := PROJECT(adds, xNewHistory(LEFT));
	//history_did_hhid := Gong_Neustar.fn_did_bdid_hhid(new_history);

	history_new := history_base & new_history;
	history_with_pid := Gong_Neustar.Mac_Assign_UniqueId(history_new, persistent_record_id);
	
	history_with_pidd := DISTRIBUTE(history_with_pid,hash(phone10,prim_range,prim_name,z5,listed_name));	
	//gong_neustar.Mac_Apply_Legal(history_with_pidd, hist_d_out);

	return history_with_pidd;

END;