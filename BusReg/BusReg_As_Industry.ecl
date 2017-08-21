
IMPORT TopBusiness_BIPV2, MDR;

ds_in				:= BusReg.Files().Base.AID.Built(rawfields.sic<>'' or rawfields.naics<>'' or rawfields.descript<>'');

ds_in_w_source := project(ds_in,
													transform({BusReg.layouts.Base.AID, string2 source := ''},
																		self.source	:= MDR.sourceTools.src_Business_Registration,
																		self 				:= left)
												 );

TopBusiness_BIPV2.Mac_transform_industry(ds_in_w_source		// Input File
						,ds_out
					  ,source
						,true
					  ,rawfields.sic
						,true
					  ,rawfields.naics
						,true
					  ,rawfields.descript
						,false
					  ,rawfields.descript
					  ,source_rec_id
					  ,source_rec_id
					  );
						
EXPORT BusReg_As_Industry := ds_out;