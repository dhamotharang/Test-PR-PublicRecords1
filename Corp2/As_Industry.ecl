
IMPORT TopBusiness_BIPV2, MDR;

ds_in				:= corp2.Files().AID.Corp.Built(trim(corp_sic_code) != '' or trim(corp_naic_code) != '');

ds_in_w_source := project(ds_in,
													transform({Corp2.Layout_Corporate_Direct_Corp_AID, string2 source := ''},
																		self.source	:= MDr.sourceTools.fCorpV2(left.corp_key, left.corp_state_origin),
																		self 				:= left)
												 );

TopBusiness_BIPV2.Mac_transform_industry(ds_in_w_source		// Input File
						,ds_out
					  ,source
						,true
					  ,corp_sic_code
						,true
					  ,corp_naic_code
						,false
					  ,corp_key
						,false
					  ,corp_orig_bus_type_desc
					  ,corp_key
					  ,source_rec_id
						,dt_first_seen
						,dt_last_seen
					  ,dt_vendor_first_reported
						,dt_vendor_last_reported
						,true
						,record_type
						,false
						,corp_key);

EXPORT As_Industry := ds_out;

