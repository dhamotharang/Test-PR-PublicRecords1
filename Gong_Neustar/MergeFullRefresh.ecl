import STD, ut;

GetReplacedRecords(dataset(Gong_Neustar.layout_gongMaster) adds, dataset(Gong_Neustar.layout_gongMaster) mstr, string8 filedate) := 

 JOIN(mstr, adds, 
				//	LEFT.record_id=RIGHT.record_id AND
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
				//LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				//	LEFT.DATA_SOURCE = RIGHT.DATA_SOURCE AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS,
						TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.current_record_flag := '';
									//self.dt_last_seen := IF(LEFT.Current_Record_Flag='Y', filedate, LEFT.dt_last_seen);
									self.deletion_date := '';	//IF(LEFT.Current_Record_Flag='Y', filedate, left.deletion_date);
									self := LEFT;
						),
				 LEFT ONLY);


GetUpdates(dataset(Gong_Neustar.layout_gongMaster) adds, dataset(Gong_Neustar.layout_gongMaster) mstr) := 

 JOIN(adds, mstr,  
					//LEFT.record_id=RIGHT.record_id AND
					//LEFT.add_date=RIGHT.add_date AND
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
				//LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				//	LEFT.DATA_SOURCE = RIGHT.DATA_SOURCE AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS, 
						TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.filedate := LEFT.filedate;
									self.add_date := Gong_Neustar.earlier(LEFT.add_date,RIGHT.add_date,LEFT.filedate[1..8]);
									self.dt_first_seen := Gong_Neustar.earlier(LEFT.add_date,RIGHT.add_date,LEFT.filedate[1..8]);
									self.current_record_flag := 'Y';
									self.deletion_date := '';
									self.dt_last_seen := LEFT.filedate[1..8];
									self.persistent_record_id := IF(RIGHT.persistent_record_id=0,LEFT.persistent_record_id,RIGHT.persistent_record_id);
									self.group_id := IF(right.group_id='', left.group_id,right.group_id);	// df-18363 keep group_id persistent
									self := LEFT;
						),
				LEFT OUTER, KEEP(1)); 
				
// DF-28737: Assign persistent_record_id to replaced dataset if the record already exists in master file
PopulatePersistentRecordId(dataset(Gong_Neustar.layout_gongMaster) replaced, dataset(Gong_Neustar.layout_gongMaster) mstr) := 

 JOIN(replaced, mstr,  
					//LEFT.record_id=RIGHT.record_id AND
					//LEFT.add_date=RIGHT.add_date AND
					LEFT.listing_type = RIGHT.listing_type AND
				LEFT. 	RECORD_TYPE = RIGHT.RECORD_TYPE AND
				LEFT.  TELEPHONE = RIGHT.telephone AND
				Gong_Neustar.UC(LEFT.BUSINESS_NAME) = Gong_Neustar.UC(RIGHT.BUSINESS_NAME) AND
				Gong_Neustar.UC(LEFT.		BUSINESS_CAPTIONS) = Gong_Neustar.UC(RIGHT.BUSINESS_CAPTIONS) AND
				Gong_Neustar.UC(LEFT.  	CATEGORY) = Gong_Neustar.UC(RIGHT.CATEGORY) AND
				LEFT.	INDENT = RIGHT.INDENT AND
				Gong_Neustar.UC(LEFT.LAST_NAME) = Gong_Neustar.UC(RIGHT.LAST_NAME) AND
				Gong_Neustar.UC(LEFT.SUFFIX_NAME) = Gong_Neustar.UC(RIGHT.SUFFIX_NAME) AND
				Gong_Neustar.UC(LEFT.FIRST_NAME) = Gong_Neustar.UC(RIGHT.FIRST_NAME) AND
				ut.NNEQ(Gong_Neustar.UC(LEFT.MIDDLE_NAME), Gong_Neustar.UC(RIGHT.MIDDLE_NAME)) AND
				Gong_Neustar.UC(LEFT.  	PRIMARY_STREET_NUMBER) = Gong_Neustar.UC(RIGHT.PRIMARY_STREET_NUMBER) AND
				Gong_Neustar.UC(LEFT.		PRE_DIR) = Gong_Neustar.UC(RIGHT.PRE_DIR) AND
				Gong_Neustar.UC(LEFT.  	PRIMARY_STREET_NAME) = Gong_Neustar.UC(RIGHT.PRIMARY_STREET_NAME) AND
				Gong_Neustar.UC(LEFT.  	PRIMARY_STREET_SUFFIX) = Gong_Neustar.UC(RIGHT.PRIMARY_STREET_SUFFIX) AND
				Gong_Neustar.UC(LEFT.		POST_DIR) = Gong_Neustar.UC(RIGHT.POST_DIR) AND
//				Gong_Neustar.UC(LEFT.		SECONDARY_ADDRESS_TYPE) = Gong_Neustar.UC(RIGHT.SECONDARY_ADDRESS_TYPE) AND
				Gong_Neustar.UC(LEFT.		SECONDARY_RANGE) = Gong_Neustar.UC(RIGHT.SECONDARY_RANGE) AND
				Gong_Neustar.UC(LEFT.  	CITY) = Gong_Neustar.UC(RIGHT.CITY) AND
				Gong_Neustar.UC(LEFT.  	STATE) = Gong_Neustar.UC(RIGHT.STATE) AND
				LEFT.  	ZIP_CODE = RIGHT.ZIP_CODE AND
				//LEFT.	  ZIP_PLUS4 = RIGHT.ZIP_PLUS4 AND
				//	LEFT.DATA_SOURCE = RIGHT.DATA_SOURCE AND
				LEFT.OMIT_ADDRESS = RIGHT.OMIT_ADDRESS, 
						TRANSFORM(Gong_Neustar.layout_gongMaster,
									self.persistent_record_id := IF(RIGHT.persistent_record_id=0,LEFT.persistent_record_id,RIGHT.persistent_record_id);
									self := LEFT;
						),
				INNER, KEEP(1)); 
EXPORT MergeFullRefresh(dataset(layout_gongMaster) refresh, dataset(layout_gongMaster) mstr) := FUNCTION

  string8 filedate := refresh[1].filedate[1..8];
	curr := mstr(current_record_flag='Y');
	notcurr := mstr(current_record_flag<>'Y');

	updates := GetUpdates(refresh, curr);
	replaced := GetReplacedRecords(refresh, curr, filedate);
	replaced_pid := PopulatePersistentRecordId(replaced, curr);		//DF-28737 assign existing persistent_record_id to records in replaced

	master7 := updates & replaced_pid & notcurr;	// DF-28737
	master7_pid := Gong_Neustar.Mac_Assign_UniqueId(master7, persistent_record_id);

	// rollup duplicate records
	master8 := gong_neustar.fn_rollup(master7_pid);
	
	return master8;

END;
