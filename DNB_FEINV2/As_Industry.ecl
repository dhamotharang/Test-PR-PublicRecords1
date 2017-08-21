
IMPORT TopBusiness_BIPV2, MDR;

ds_in 				:= DNB_FEINV2.File_DNB_Fein_base_main_new(sic_code<>'');

ds_in_w_source := project(ds_in,
													transform({DNB_FEINv2.layout_DNB_fein_base_main_new, string2 source := ''},
																		self.source	:= MDR.sourceTools.src_Dunn_Bradstreet_Fein,
																		self 				:= left)
												 );

TopBusiness_BIPV2.Mac_transform_industry(ds_in_w_source		// Input File
						,ds_out
					  ,source
						,true
					  ,sic_code
						,false
					  ,sic_code
						,false
					  ,sic_code
						,false
					  ,sic_code
					  ,tmsid
					  ,source_rec_id
					  ,date_first_seen
						,date_last_seen
					  ,date_vendor_first_reported
						,date_vendor_last_reported
						,false
						,sic_code
						,false
						,sic_code);	


EXPORT As_Industry := ds_out;