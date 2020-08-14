IMPORT BatchServices, Business_Header, ut, address, doxie;

EXPORT SicCode_BatchService_Records(
	DATASET(BatchServices.SicCode_BatchService_Layouts.Input) in_data,
    Doxie.IDataAccess mod_access,
	UNSIGNED1 max_results_per_acct) := FUNCTION
	
	Zip_Rec := RECORD
		UNSIGNED3 search_zip;
	END;
	
	Sequenced_Rec := RECORD
		UNSIGNED2 __seq;
		STRING3 error_code;
		BatchServices.SicCode_BatchService_Layouts.Input;
		REAL zip_lat;
		REAL zip_long;
		DATASET(Zip_Rec) zip_codes {MAXCOUNT(BatchServices.SicCode_BatchService_Constants.MAX_ZIPS_PER_ACCT)};
	END;
	
	// First, sequence the input records and get the set of ZIP codes
	Sequenced := PROJECT(in_data,TRANSFORM(Sequenced_Rec,
		SELF.__seq := COUNTER,
		temp_any_error := LEFT.zip5 = '' OR LEFT.sic_code = '';
		temp_addrclean := address.Zip9ToGeo34(LEFT.zip5 + IF(LEFT.zip4 != '',LEFT.zip4,'0000'));
		SELF.zip_lat := IF(temp_any_error,0.0,(REAL)temp_addrclean[1..10]),
		SELF.zip_long := IF(temp_any_error,0.0,(REAL)temp_addrclean[11..21]),
		temp_zip_codes := DATASET(ziplib.ZipsWithinRadius(LEFT.zip5,(REAL)LEFT.zipradius),Zip_Rec);
		temp_zip_error := COUNT(temp_zip_codes) > BatchServices.SicCode_BatchService_Constants.MAX_ZIPS_PER_ACCT;
		SELF.zip_codes := IF(NOT temp_any_error AND NOT temp_zip_error,
			temp_zip_codes),
		SELF.error_code := MAP(
			LEFT.zip5 = '' AND LEFT.sic_code = '' => BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ZIP_CODE_OR_SIC_CODE,
			LEFT.zip5 = ''                        => BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ZIP_CODE,
			LEFT.sic_code = ''                    => BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_SIC_CODE,
			temp_zip_error                        => BatchServices.SicCode_BatchService_Constants.ErrorCodes.RADIUS_PRODUCES_TOO_MANY_ZIPS,
			/* DEFAULT */                            BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ERRORS),
		SELF := LEFT));
		
	// Only run with records that have no errors.
	Okay := Sequenced(error_code = BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ERRORS);
	Not_Okay := Sequenced(error_code != BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ERRORS);
	
	Normalized_Rec := RECORD
		Sequenced_Rec - [zip_codes];
		Zip_Rec;
	END;
	
	// Now, normalize the search zips
	Normalized := NORMALIZE(Okay,COUNT(LEFT.Zip_Codes),TRANSFORM(Normalized_Rec,
		SELF.Search_Zip := LEFT.Zip_Codes[COUNTER].Search_Zip,
		SELF := LEFT));
	
	Joined_Rec := RECORD
		Normalized_Rec;
		UNSIGNED6 bdid;
		REAL est_dist;
	END;
	
	// Join to the SIC CODE key to get BDIDs
	JoinedDs := JOIN(Normalized,Business_Header.key_commercial_SIC_Zip,
		KEYED(TRIM(LEFT.sic_code) = RIGHT.sic_code[1..LENGTH(TRIM(LEFT.sic_code))]) AND
		KEYED((UNSIGNED)LEFT.search_zip = RIGHT.zip),
		TRANSFORM(Joined_Rec,
			SELF.bdid := RIGHT.bdid,
			temp_addrclean := address.Zip9ToGeo34(INTFORMAT(RIGHT.zip,5,1) + INTFORMAT(RIGHT.zip4,4,1));
			SELF.est_dist := ut.LL_Dist(LEFT.zip_lat,LEFT.zip_long,(REAL)temp_addrclean[1..10],(REAL)temp_addrclean[11..21]),
			SELF := LEFT),
		KEEP(10000));
	
	// Dedup on BDID by closest distance and then sort by distance
	SortedByDistance := DEDUP(SORT(DEDUP(SORT(JoinedDs,__seq,bdid,est_dist),__seq,bdid),__seq,est_dist,bdid),__seq,keep max_results_per_acct);
	
	BestData_Rec := RECORD
		Joined_Rec.__seq;
		Joined_Rec.acctno;
		Joined_Rec.est_dist;
		Business_Header.Layout_BH_Best;
	END;
	
	WithBestData := JOIN(SortedByDistance,Business_Header.Key_BH_Best,
		KEYED(LEFT.BDID = RIGHT.BDID) AND
        doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
		TRANSFORM(BestData_Rec,
			SELF := RIGHT,
			SELF := LEFT),
		KEEP(1), LIMIT (0));
	
	Seed_Rec := RECORD
		BestData_Rec.__seq;
		BatchServices.SicCode_BatchService_Layouts.Final;
	END;
	
	// Now, seed for the final denormalize.
	DS_Seed := DEDUP(SORT(PROJECT(WithBestData,TRANSFORM(Seed_Rec,
		SELF.__seq := LEFT.__seq,
		SELF.acctno := LEFT.acctno,
		SELF := [])),__seq,acctno),__seq,acctno);
		
	// Now, denormalize the data.
	DS_Denormalized := DENORMALIZE(DS_Seed,WithBestData,
		LEFT.__seq  = RIGHT.__seq,
		TRANSFORM(Seed_Rec,
			SELF.__seq := LEFT.__seq,
			SELF.acctno := LEFT.acctno,
			SELF.error_code := BatchServices.SicCode_BatchService_Constants.ErrorCodes.NO_ERRORS,
			SELF.distance_1     := IF(COUNTER = 1,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_1    ),
			SELF.bdid_1         := IF(COUNTER = 1,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_1        ),
			SELF.company_name_1 := IF(COUNTER = 1,RIGHT.company_name,LEFT.company_name_1),
			SELF.prim_range_1   := IF(COUNTER = 1,RIGHT.prim_range  ,LEFT.prim_range_1  ),
			SELF.predir_1       := IF(COUNTER = 1,RIGHT.predir      ,LEFT.predir_1      ),
			SELF.prim_name_1    := IF(COUNTER = 1,RIGHT.prim_name   ,LEFT.prim_name_1   ),
			SELF.addr_suffix_1  := IF(COUNTER = 1,RIGHT.addr_suffix ,LEFT.addr_suffix_1 ),
			SELF.postdir_1      := IF(COUNTER = 1,RIGHT.postdir     ,LEFT.postdir_1     ),
			SELF.unit_desig_1   := IF(COUNTER = 1,RIGHT.unit_desig  ,LEFT.unit_desig_1  ),
			SELF.sec_range_1    := IF(COUNTER = 1,RIGHT.sec_range   ,LEFT.sec_range_1   ),
			SELF.city_1         := IF(COUNTER = 1,RIGHT.city        ,LEFT.city_1        ),
			SELF.state_1        := IF(COUNTER = 1,RIGHT.state       ,LEFT.state_1       ),
			SELF.zip5_1         := IF(COUNTER = 1,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_1        ),
			SELF.zip4_1         := IF(COUNTER = 1,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_1        ),
			SELF.phone_1        := IF(COUNTER = 1,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_1       ),
			SELF.fein_1         := IF(COUNTER = 1,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_1        ),   
			SELF.distance_2     := IF(COUNTER = 2,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_2    ), 
			SELF.bdid_2         := IF(COUNTER = 2,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_2        ),
			SELF.company_name_2 := IF(COUNTER = 2,RIGHT.company_name,LEFT.company_name_2),
			SELF.prim_range_2   := IF(COUNTER = 2,RIGHT.prim_range  ,LEFT.prim_range_2  ),
			SELF.predir_2       := IF(COUNTER = 2,RIGHT.predir      ,LEFT.predir_2      ),
			SELF.prim_name_2    := IF(COUNTER = 2,RIGHT.prim_name   ,LEFT.prim_name_2   ),
			SELF.addr_suffix_2  := IF(COUNTER = 2,RIGHT.addr_suffix ,LEFT.addr_suffix_2 ),
			SELF.postdir_2      := IF(COUNTER = 2,RIGHT.postdir     ,LEFT.postdir_2     ),
			SELF.unit_desig_2   := IF(COUNTER = 2,RIGHT.unit_desig  ,LEFT.unit_desig_2  ),
			SELF.sec_range_2    := IF(COUNTER = 2,RIGHT.sec_range   ,LEFT.sec_range_2   ),
			SELF.city_2         := IF(COUNTER = 2,RIGHT.city        ,LEFT.city_2        ),
			SELF.state_2        := IF(COUNTER = 2,RIGHT.state       ,LEFT.state_2       ),
			SELF.zip5_2         := IF(COUNTER = 2,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_2        ),
			SELF.zip4_2         := IF(COUNTER = 2,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_2        ),
			SELF.phone_2        := IF(COUNTER = 2,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_2       ),
			SELF.fein_2         := IF(COUNTER = 2,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_2        ),   
			SELF.distance_3     := IF(COUNTER = 3,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_3    ),  
			SELF.bdid_3         := IF(COUNTER = 3,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_3        ),
			SELF.company_name_3 := IF(COUNTER = 3,RIGHT.company_name,LEFT.company_name_3),
			SELF.prim_range_3   := IF(COUNTER = 3,RIGHT.prim_range  ,LEFT.prim_range_3  ),
			SELF.predir_3       := IF(COUNTER = 3,RIGHT.predir      ,LEFT.predir_3      ),
			SELF.prim_name_3    := IF(COUNTER = 3,RIGHT.prim_name   ,LEFT.prim_name_3   ),
			SELF.addr_suffix_3  := IF(COUNTER = 3,RIGHT.addr_suffix ,LEFT.addr_suffix_3 ),
			SELF.postdir_3      := IF(COUNTER = 3,RIGHT.postdir     ,LEFT.postdir_3     ),
			SELF.unit_desig_3   := IF(COUNTER = 3,RIGHT.unit_desig  ,LEFT.unit_desig_3  ),
			SELF.sec_range_3    := IF(COUNTER = 3,RIGHT.sec_range   ,LEFT.sec_range_3   ),
			SELF.city_3         := IF(COUNTER = 3,RIGHT.city        ,LEFT.city_3        ),
			SELF.state_3        := IF(COUNTER = 3,RIGHT.state       ,LEFT.state_3       ),
			SELF.zip5_3         := IF(COUNTER = 3,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_3        ),
			SELF.zip4_3         := IF(COUNTER = 3,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_3        ),
			SELF.phone_3        := IF(COUNTER = 3,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_3       ),
			SELF.fein_3         := IF(COUNTER = 3,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_3        ),   
			SELF.distance_4     := IF(COUNTER = 4,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_4    ), 
			SELF.bdid_4         := IF(COUNTER = 4,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_4        ),
			SELF.company_name_4 := IF(COUNTER = 4,RIGHT.company_name,LEFT.company_name_4),
			SELF.prim_range_4   := IF(COUNTER = 4,RIGHT.prim_range  ,LEFT.prim_range_4  ),
			SELF.predir_4       := IF(COUNTER = 4,RIGHT.predir      ,LEFT.predir_4      ),
			SELF.prim_name_4    := IF(COUNTER = 4,RIGHT.prim_name   ,LEFT.prim_name_4   ),
			SELF.addr_suffix_4  := IF(COUNTER = 4,RIGHT.addr_suffix ,LEFT.addr_suffix_4 ),
			SELF.postdir_4      := IF(COUNTER = 4,RIGHT.postdir     ,LEFT.postdir_4     ),
			SELF.unit_desig_4   := IF(COUNTER = 4,RIGHT.unit_desig  ,LEFT.unit_desig_4  ),
			SELF.sec_range_4    := IF(COUNTER = 4,RIGHT.sec_range   ,LEFT.sec_range_4   ),
			SELF.city_4         := IF(COUNTER = 4,RIGHT.city        ,LEFT.city_4        ),
			SELF.state_4        := IF(COUNTER = 4,RIGHT.state       ,LEFT.state_4       ),
			SELF.zip5_4         := IF(COUNTER = 4,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_4        ),
			SELF.zip4_4         := IF(COUNTER = 4,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_4        ),
			SELF.phone_4        := IF(COUNTER = 4,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_4       ),
			SELF.fein_4         := IF(COUNTER = 4,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_4        ),   
			SELF.distance_5     := IF(COUNTER = 5,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_5    ), 
			SELF.bdid_5         := IF(COUNTER = 5,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_5        ),
			SELF.company_name_5 := IF(COUNTER = 5,RIGHT.company_name,LEFT.company_name_5),
			SELF.prim_range_5   := IF(COUNTER = 5,RIGHT.prim_range  ,LEFT.prim_range_5  ),
			SELF.predir_5       := IF(COUNTER = 5,RIGHT.predir      ,LEFT.predir_5      ),
			SELF.prim_name_5    := IF(COUNTER = 5,RIGHT.prim_name   ,LEFT.prim_name_5   ),
			SELF.addr_suffix_5  := IF(COUNTER = 5,RIGHT.addr_suffix ,LEFT.addr_suffix_5 ),
			SELF.postdir_5      := IF(COUNTER = 5,RIGHT.postdir     ,LEFT.postdir_5     ),
			SELF.unit_desig_5   := IF(COUNTER = 5,RIGHT.unit_desig  ,LEFT.unit_desig_5  ),
			SELF.sec_range_5    := IF(COUNTER = 5,RIGHT.sec_range   ,LEFT.sec_range_5   ),
			SELF.city_5         := IF(COUNTER = 5,RIGHT.city        ,LEFT.city_5        ),
			SELF.state_5        := IF(COUNTER = 5,RIGHT.state       ,LEFT.state_5       ),
			SELF.zip5_5         := IF(COUNTER = 5,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_5        ),
			SELF.zip4_5         := IF(COUNTER = 5,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_5        ),
			SELF.phone_5        := IF(COUNTER = 5,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_5       ),
			SELF.fein_5         := IF(COUNTER = 5,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_5        ),   
			SELF.distance_6     := IF(COUNTER = 6,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_6    ), 
			SELF.bdid_6         := IF(COUNTER = 6,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_6        ),
			SELF.company_name_6 := IF(COUNTER = 6,RIGHT.company_name,LEFT.company_name_6),
			SELF.prim_range_6   := IF(COUNTER = 6,RIGHT.prim_range  ,LEFT.prim_range_6  ),
			SELF.predir_6       := IF(COUNTER = 6,RIGHT.predir      ,LEFT.predir_6      ),
			SELF.prim_name_6    := IF(COUNTER = 6,RIGHT.prim_name   ,LEFT.prim_name_6   ),
			SELF.addr_suffix_6  := IF(COUNTER = 6,RIGHT.addr_suffix ,LEFT.addr_suffix_6 ),
			SELF.postdir_6      := IF(COUNTER = 6,RIGHT.postdir     ,LEFT.postdir_6     ),
			SELF.unit_desig_6   := IF(COUNTER = 6,RIGHT.unit_desig  ,LEFT.unit_desig_6  ),
			SELF.sec_range_6    := IF(COUNTER = 6,RIGHT.sec_range   ,LEFT.sec_range_6   ),
			SELF.city_6         := IF(COUNTER = 6,RIGHT.city        ,LEFT.city_6        ),
			SELF.state_6        := IF(COUNTER = 6,RIGHT.state       ,LEFT.state_6       ),
			SELF.zip5_6         := IF(COUNTER = 6,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_6        ),
			SELF.zip4_6         := IF(COUNTER = 6,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_6        ),
			SELF.phone_6        := IF(COUNTER = 6,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_6       ),
			SELF.fein_6         := IF(COUNTER = 6,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_6        ),   
			SELF.distance_7     := IF(COUNTER = 7,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_7    ), 
			SELF.bdid_7         := IF(COUNTER = 7,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_7        ),
			SELF.company_name_7 := IF(COUNTER = 7,RIGHT.company_name,LEFT.company_name_7),
			SELF.prim_range_7   := IF(COUNTER = 7,RIGHT.prim_range  ,LEFT.prim_range_7  ),
			SELF.predir_7       := IF(COUNTER = 7,RIGHT.predir      ,LEFT.predir_7      ),
			SELF.prim_name_7    := IF(COUNTER = 7,RIGHT.prim_name   ,LEFT.prim_name_7   ),
			SELF.addr_suffix_7  := IF(COUNTER = 7,RIGHT.addr_suffix ,LEFT.addr_suffix_7 ),
			SELF.postdir_7      := IF(COUNTER = 7,RIGHT.postdir     ,LEFT.postdir_7     ),
			SELF.unit_desig_7   := IF(COUNTER = 7,RIGHT.unit_desig  ,LEFT.unit_desig_7  ),
			SELF.sec_range_7    := IF(COUNTER = 7,RIGHT.sec_range   ,LEFT.sec_range_7   ),
			SELF.city_7         := IF(COUNTER = 7,RIGHT.city        ,LEFT.city_7        ),
			SELF.state_7        := IF(COUNTER = 7,RIGHT.state       ,LEFT.state_7       ),
			SELF.zip5_7         := IF(COUNTER = 7,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_7        ),
			SELF.zip4_7         := IF(COUNTER = 7,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_7        ),
			SELF.phone_7        := IF(COUNTER = 7,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_7       ),
			SELF.fein_7         := IF(COUNTER = 7,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_7        ),   
			SELF.distance_8     := IF(COUNTER = 8,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_8    ), 
			SELF.bdid_8         := IF(COUNTER = 8,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_8        ),
			SELF.company_name_8 := IF(COUNTER = 8,RIGHT.company_name,LEFT.company_name_8),
			SELF.prim_range_8   := IF(COUNTER = 8,RIGHT.prim_range  ,LEFT.prim_range_8  ),
			SELF.predir_8       := IF(COUNTER = 8,RIGHT.predir      ,LEFT.predir_8      ),
			SELF.prim_name_8    := IF(COUNTER = 8,RIGHT.prim_name   ,LEFT.prim_name_8   ),
			SELF.addr_suffix_8  := IF(COUNTER = 8,RIGHT.addr_suffix ,LEFT.addr_suffix_8 ),
			SELF.postdir_8      := IF(COUNTER = 8,RIGHT.postdir     ,LEFT.postdir_8     ),
			SELF.unit_desig_8   := IF(COUNTER = 8,RIGHT.unit_desig  ,LEFT.unit_desig_8  ),
			SELF.sec_range_8    := IF(COUNTER = 8,RIGHT.sec_range   ,LEFT.sec_range_8   ),
			SELF.city_8         := IF(COUNTER = 8,RIGHT.city        ,LEFT.city_8        ),
			SELF.state_8        := IF(COUNTER = 8,RIGHT.state       ,LEFT.state_8       ),
			SELF.zip5_8         := IF(COUNTER = 8,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_8        ),
			SELF.zip4_8         := IF(COUNTER = 8,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_8        ),
			SELF.phone_8        := IF(COUNTER = 8,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_8       ),
			SELF.fein_8         := IF(COUNTER = 8,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_8        ),   
			SELF.distance_9     := IF(COUNTER = 9,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_9    ), 
			SELF.bdid_9         := IF(COUNTER = 9,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_9        ),
			SELF.company_name_9 := IF(COUNTER = 9,RIGHT.company_name,LEFT.company_name_9),
			SELF.prim_range_9   := IF(COUNTER = 9,RIGHT.prim_range  ,LEFT.prim_range_9  ),
			SELF.predir_9       := IF(COUNTER = 9,RIGHT.predir      ,LEFT.predir_9      ),
			SELF.prim_name_9    := IF(COUNTER = 9,RIGHT.prim_name   ,LEFT.prim_name_9   ),
			SELF.addr_suffix_9  := IF(COUNTER = 9,RIGHT.addr_suffix ,LEFT.addr_suffix_9 ),
			SELF.postdir_9      := IF(COUNTER = 9,RIGHT.postdir     ,LEFT.postdir_9     ),
			SELF.unit_desig_9   := IF(COUNTER = 9,RIGHT.unit_desig  ,LEFT.unit_desig_9  ),
			SELF.sec_range_9    := IF(COUNTER = 9,RIGHT.sec_range   ,LEFT.sec_range_9   ),
			SELF.city_9         := IF(COUNTER = 9,RIGHT.city        ,LEFT.city_9        ),
			SELF.state_9        := IF(COUNTER = 9,RIGHT.state       ,LEFT.state_9       ),
			SELF.zip5_9         := IF(COUNTER = 9,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_9        ),
			SELF.zip4_9         := IF(COUNTER = 9,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_9        ),
			SELF.phone_9        := IF(COUNTER = 9,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_9       ),
			SELF.fein_9         := IF(COUNTER = 9,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_9        ),   
			SELF.distance_10     := IF(COUNTER = 10,INTFORMAT((UNSIGNED)RIGHT.est_dist,3,1),LEFT.distance_10    ), 
			SELF.bdid_10         := IF(COUNTER = 10,INTFORMAT(RIGHT.bdid,12,1),LEFT.bdid_10        ),
			SELF.company_name_10 := IF(COUNTER = 10,RIGHT.company_name,LEFT.company_name_10),
			SELF.prim_range_10   := IF(COUNTER = 10,RIGHT.prim_range  ,LEFT.prim_range_10  ),
			SELF.predir_10       := IF(COUNTER = 10,RIGHT.predir      ,LEFT.predir_10      ),
			SELF.prim_name_10    := IF(COUNTER = 10,RIGHT.prim_name   ,LEFT.prim_name_10   ),
			SELF.addr_suffix_10  := IF(COUNTER = 10,RIGHT.addr_suffix ,LEFT.addr_suffix_10 ),
			SELF.postdir_10      := IF(COUNTER = 10,RIGHT.postdir     ,LEFT.postdir_10     ),
			SELF.unit_desig_10   := IF(COUNTER = 10,RIGHT.unit_desig  ,LEFT.unit_desig_10  ),
			SELF.sec_range_10    := IF(COUNTER = 10,RIGHT.sec_range   ,LEFT.sec_range_10   ),
			SELF.city_10         := IF(COUNTER = 10,RIGHT.city        ,LEFT.city_10        ),
			SELF.state_10        := IF(COUNTER = 10,RIGHT.state       ,LEFT.state_10       ),
			SELF.zip5_10         := IF(COUNTER = 10,IF(RIGHT.zip != 0,INTFORMAT(RIGHT.zip,5,1),''),LEFT.zip5_10        ),
			SELF.zip4_10         := IF(COUNTER = 10,IF(RIGHT.zip4 != 0,INTFORMAT(RIGHT.zip4,4,1),''),LEFT.zip4_10        ),
			SELF.phone_10        := IF(COUNTER = 10,IF(RIGHT.phone != 0,INTFORMAT(RIGHT.phone,10,1),''),LEFT.phone_10       ),
			SELF.fein_10         := IF(COUNTER = 10,IF(RIGHT.fein != 0,INTFORMAT(RIGHT.fein,9,1),''),LEFT.fein_10        )));
	
	Not_Okay_Ready := PROJECT(Not_Okay,TRANSFORM(Seed_Rec,
		SELF.__seq := LEFT.__seq,
		SELF.acctno := LEFT.acctno,
		SELF.error_code := LEFT.error_code,
		SELF := []));
	
	RETURN PROJECT(SORT(DS_Denormalized + Not_Okay_Ready,__seq),BatchServices.SicCode_BatchService_Layouts.Final);

END;
