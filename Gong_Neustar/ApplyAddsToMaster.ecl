import STD, ut;

GetNewRecords(dataset(layout_gongMaster) adds, dataset(layout_gongMaster) mstr) := 

 JOIN(adds, mstr, 
					LEFT.record_id=RIGHT.record_id AND
					LEFT.filedate=RIGHT.filedate AND
//					LEFT.add_date=RIGHT.add_date AND
					LEFT.listing_type = RIGHT.listing_type AND
				LEFT. 	RECORD_TYPE = RIGHT.RECORD_TYPE AND
				LEFT.  TELEPHONE = RIGHT.telephone AND
				UC(LEFT.BUSINESS_NAME) = UC(RIGHT.BUSINESS_NAME) AND
				UC(LEFT.		BUSINESS_CAPTIONS) = UC(RIGHT.BUSINESS_CAPTIONS) AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				//UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				ut.NNEQ(UC(LEFT.MIDDLE_NAME), UC(RIGHT.MIDDLE_NAME)) AND
				UC(LEFT.  	PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.		PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.		POST_DIR) = UC(RIGHT.POST_DIR) AND
//				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
//				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.dt_last_seen := LEFT.filedate[1..8];
									self.persistent_record_id := 0;
									self := LEFT;
						),
				LEFT ONLY, LOCAL);

GetUnchangedRecords(dataset(layout_gongMaster) adds, dataset(layout_gongMaster) mstr, string8 file_date) := 

 JOIN(mstr, adds, 
					LEFT.record_id=RIGHT.record_id AND
					LEFT.filedate=RIGHT.filedate AND
//					LEFT.add_date=RIGHT.add_date AND
					LEFT.listing_type = RIGHT.listing_type AND
				LEFT. 	RECORD_TYPE = RIGHT.RECORD_TYPE AND
				LEFT.  TELEPHONE = RIGHT.telephone AND
				UC(LEFT.BUSINESS_NAME) = UC(RIGHT.BUSINESS_NAME) AND
				UC(LEFT.		BUSINESS_CAPTIONS) = UC(RIGHT.BUSINESS_CAPTIONS) AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				//UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				ut.NNEQ(UC(LEFT.MIDDLE_NAME), UC(RIGHT.MIDDLE_NAME)) AND
				UC(LEFT.  	PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.		PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.		POST_DIR) = UC(RIGHT.POST_DIR) AND
//				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
//				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.dt_last_seen := IF(LEFT.Current_Record_Flag='Y', file_date, LEFT.dt_last_seen);
									self.deletion_date := IF(LEFT.Current_Record_Flag='Y', '', LEFT.deletion_date);
									self.persistent_record_id := left.persistent_record_id;
									self := LEFT;
						),
				LEFT ONLY, LOCAL);


GetUpdates(dataset(layout_gongMaster) adds, dataset(layout_gongMaster) mstr) := 

 JOIN(adds, mstr,  
					LEFT.record_id=RIGHT.record_id AND
					LEFT.filedate=RIGHT.filedate AND
//					LEFT.add_date=RIGHT.add_date AND
					LEFT.listing_type = RIGHT.listing_type AND
				LEFT. 	RECORD_TYPE = RIGHT.RECORD_TYPE AND
				LEFT.  TELEPHONE = RIGHT.telephone AND
				UC(LEFT.BUSINESS_NAME) = UC(RIGHT.BUSINESS_NAME) AND
				UC(LEFT.		BUSINESS_CAPTIONS) = UC(RIGHT.BUSINESS_CAPTIONS) AND
				UC(LEFT.  	CATEGORY) = UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				UC(LEFT.LAST_NAME) = UC(RIGHT.LAST_NAME) AND
				UC(LEFT.SUFFIX_NAME) = UC(RIGHT.SUFFIX_NAME) AND
				UC(LEFT.FIRST_NAME) = UC(RIGHT.FIRST_NAME) AND
				//UC(LEFT.MIDDLE_NAME) = UC(RIGHT.MIDDLE_NAME) AND
				ut.NNEQ(UC(LEFT.MIDDLE_NAME), UC(RIGHT.MIDDLE_NAME)) AND
				UC(LEFT.  	PRIMARY_STREET_NUMBER) = UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				UC(LEFT.		PRE_DIR) = UC(RIGHT.PRE_DIR) AND
				UC(LEFT.  	PRIMARY_STREET_NAME) = UC(RIGHT.PRIMARY_STREET_NAME) AND
				UC(LEFT.  	PRIMARY_STREET_SUFFIX) = UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				UC(LEFT.		POST_DIR) = UC(RIGHT.POST_DIR) AND
//				UC(LEFT.		SECONDARY_ADDRESS_TYPE) = UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				UC(LEFT.		SECONDARY_RANGE) = UC(RIGHT.SECONDARY_RANGE) AND
				UC(LEFT.  	CITY) = UC(RIGHT.CITY) AND
				UC(LEFT.  	STATE) = UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
//				LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(layout_gongMaster,
									self.current_record_flag := 'Y';
									self.deletion_date := '';
									self.dt_first_seen := earlier(LEFT.dt_first_seen,RIGHT.dt_first_seen);
									self.dt_last_seen := LEFT.filedate[1..8];
									self.persistent_record_id := right.persistent_record_id;
									self.group_id := right.group_id;	// df-18363 keep group_id persistent
									self := LEFT;
						),
				INNER, KEEP(1), LOCAL);


EXPORT ApplyAddsToMaster(dataset(layout_gongMaster) adds, dataset(layout_gongMaster) mstr) := FUNCTION

		file_date := adds[1].filedate[1..8];

		updates := GetUpdates(adds, mstr);
		newadds := GetNewRecords(adds, mstr);
		unchanged := GetUnchangedRecords(adds, mstr, file_date);

		//return unchanged & updates & newadds;
		master6 := unchanged & updates & newadds;
		master7 := Mac_Assign_UniqueId(master6, persistent_record_id);
		
		// rollup duplicate records
		master8 := gong_neustar.fn_rollup(master7);
		
	return master8;
END;
