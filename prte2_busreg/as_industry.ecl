IMPORT TopBusiness_BIPV2, MDR, prte2_busreg,busreg;

ds_in_w_source := project(prte2_busreg.files.DS_busreg_linkid(rawfields.sic<>'' or rawfields.naics<>'' or rawfields.descript<>''),
													transform({BusReg.layouts.Base.AID, string2 source := ''},
																		self.source	:= MDR.sourceTools.src_Business_Registration,
																		self 				:= left;
																		self        :=[];)
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
						
EXPORT as_Industry := ds_out;