IMPORT ut;

EXPORT Rollup_Base(DATASET(DataBridge.Layouts.Base) pDataset) := FUNCTION

	pDataset_Dist := DISTRIBUTE(pDataset, HASH(name+company));
	pDataset_sort := SORT( pDataset_Dist 
	                      ,-process_date
												,name                ,company                ,address             ,address2
												,city                ,state                  ,scf                 ,zip_code5              
												,zip_code4           ,mail_score             ,area_code           ,telephone_number
												,name_prefix         ,name_first             ,name_middle_initial ,name_last
												,suffix              ,title_code_1           ,title_code_2 			  ,title_code_3 
												,title_code_4        ,web_address            ,sic8_1							,sic8_2
												,sic8_3              ,sic8_4                 ,sic6_1							,sic6_2   
												,sic6_3              ,sic6_4                 ,sic6_5							,email 
												,email_present_flag  ,site_source1           ,site_source2				,site_source3
												,site_source4        ,site_source5           ,site_source6				,site_source7 
												,site_source8        ,site_source9           ,site_source10			  ,individual_source1 
												,individual_source2  ,individual_source3     ,individual_source4  ,individual_source5 
												,individual_source6  ,individual_source7     ,individual_source8  ,individual_source9 
												,individual_source10 ,email_status
												,LOCAL );
	
	DataBridge.Layouts.Base RollupUpdate(DataBridge.Layouts.Base L, DataBridge.Layouts.Base R) := TRANSFORM
		
		Earliest_Date                 := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
		
		SELF.dt_first_seen 						:= ut.EarliestDate(ut.EarliestDate(L.dt_first_seen, R.dt_first_seen)
																						        ,ut.EarliestDate(L.dt_last_seen,  R.dt_last_seen));
		SELF.dt_last_seen 						:= max(L.dt_last_seen, R.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= max(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := Earliest_Date;
		SELF.record_type							:= IF(L.record_type = 'C' OR R.record_type = 'C', 'C', 'H');
		SELF.record_sid						    := IF(Earliest_Date = L.dt_vendor_first_reported, L.record_sid, R.record_sid);  //Use the earliest record_sid
		SELF                          := L;
	END;

	pDataset_rollup := ROLLUP(pDataset_sort
														,RollupUpdate(LEFT, RIGHT)
														,name                ,company                ,address             ,address2
														,city                ,state                  ,scf                 ,zip_code5              
														,zip_code4           ,mail_score             ,area_code           ,telephone_number
														,name_prefix         ,name_first             ,name_middle_initial ,name_last  
														,suffix              ,title_code_1           ,title_code_2				,title_code_3 
														,title_code_4        ,web_address            ,sic8_1							,sic8_2      
														,sic8_3              ,sic8_4                 ,sic6_1							,sic6_2      
														,sic6_3              ,sic6_4                 ,sic6_5							,email  
														,email_present_flag  ,site_source1           ,site_source2 			  ,site_source3 
														,site_source4        ,site_source5           ,site_source6				,site_source7 
														,site_source8        ,site_source9           ,site_source10  		  ,individual_source1 
														,individual_source2  ,individual_source3     ,individual_source4  ,individual_source5 
														,individual_source6  ,individual_source7     ,individual_source8	,individual_source9 
														,individual_source10 ,email_status
														,LOCAL );

	RETURN pDataset_rollup;

END;