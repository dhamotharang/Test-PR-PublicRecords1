import address_attributes, doxie, ut, data_services;

ds_in := distribute(Address_Attributes.file_business_risk(geolink <> ''), hash64(geolink));

rCountHRB := RECORD
	ds_in.geolink;
	cnt_shell 						:= COUNT(GROUP,ds_in.potential_shell_address = TRUE);
	cnt_shelf 						:= COUNT(GROUP,ds_in.potential_shelf_address = TRUE);
	cnt_businesses 				:= COUNT(GROUP,ds_in.business_count > 0);
	cnt_legal_srv_cnt 		:= COUNT(GROUP,ds_in.legal_srv_cnt > 0);
	cnt_hr_biz_cnt 				:= COUNT(GROUP,ds_in.hr_biz_cnt > 0);
	cnt_incorp_srv 				:= COUNT(GROUP,ds_in.incorp_srv = TRUE);
	cnt_credit_rpr_srv 		:= COUNT(GROUP,ds_in.credit_rpr_srv = TRUE);
	cnt_residential_addrs := COUNT(GROUP,ds_in.address_type in ['1','2']);
	cnt_business_addrs 		:= COUNT(GROUP,ds_in.address_type in ['0','']);
END;
ds := TABLE(ds_in,rCountHRB,geolink,few,local);

export key_business_risk_geolink:=INDEX(ds, 																												       										//dataset
																		{geolink},  											 																												//key fields
																		{ds},  																												   			 										//layout
																		data_services.data_location.prefix() + 'thor_data400::key::business_header::'+doxie.Version_SuperKey+'::business_risk_geolink');//file

