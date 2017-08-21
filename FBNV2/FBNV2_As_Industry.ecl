
IMPORT TopBusiness_BIPV2, MDR;

ds_in					 :=	FBNV2.File_FBN_Business_Base_AID(sic_code != '' or bus_type_desc !='');

ds_in_w_source := project(ds_in,
													transform({FBNV2.Layout_Common.Business_AID, string2 source := ''},
																		 self.source	:= MDR.sourceTools.fFBNV2(left.tmsid),
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
						,true
					  ,bus_type_desc
					  ,tmsid
					  ,source_rec_id
						,dt_first_seen
						,dt_last_seen
					  ,dt_vendor_first_reported
						,dt_vendor_last_reported
						,false
						,sic_code
						,false
						,sic_code);

EXPORT FBNV2_As_Industry := ds_out;