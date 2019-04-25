import ADVFiles, FraudDefenseNetwork;

export FDN_fake_data := module

		shared ds_base := dataset('~nkoubsky::in::fake_basefile_20150910', FraudDefenseNetwork.Layouts.base.main, csv(heading(0)));
		
		export true_basefile := ADVFiles.FDNDS;
		
		export fake_basefile := ds_base(record_id <> 0);
		
		export appended_basefile := ds_base + ADVFiles.FDNDS;

		export fake_MbsGcIdExclusion := project(ds_base, transform(FraudDefenseNetwork.Layouts_Key.MbsGcIdExclusion, 
																																											self.fdn_file_gc_exclusion_id := 90899 + counter;
																																											self := left.classification_permissible_use_access; 
																																											self := []
																																											));

		export fake_MbsIndTypeExclusion := project(ds_base, transform(FraudDefenseNetwork.Layouts_Key.MbsIndTypeExclusion, 
																																											self.fdn_file_Ind_type_exclusion_id := 90899 + counter;
																																											self := left.classification_permissible_use_access; 
																																											self := []
																																											));

		export fake_MbsProductInclude := project(ds_base, transform(FraudDefenseNetwork.Layouts_Key.MbsProductInclude, 
																																											self.fdn_file_product_include_id := 90899 + counter;
																																											self.product_id := 123456;
																																											self := left.classification_permissible_use_access; 
																																											self := []
																																											));


end;