import std, Ares;

	ssi := Ares.file_ssi_flat(id != '');
	
	expanded_ssi_layout := recordof(ssi);
	
	output(	sort(ssi, id), named('ssi_extended_ds'));
	output(	count(ssi), named('ssi_extended_ds_count'));
	
	// ssi to  currency join
	ssi_currency_ds := join(ssi, Ares.Files.ds_currency, left.currency_id = right.id, 
																																	 transform(expanded_ssi_layout, self.currency_iso_code := right.isoCode; self := left;), left outer);
	//output(	sort(ssi_currency_ds, id), named('ssi_currency_ds'));
	//output(	count(ssi_currency_ds), named('ssi_currency_dss_count'));	
	
	
	office_ds_dist := DISTRIBUTE(Ares.Files.ds_office, HASH(id));
	// ssi to clearer office id join
	ssi_clearer_office_ds_dist := DISTRIBUTE(ssi_currency_ds, HASH(clearer_office_id));	
	ssi_clearer_office_ds := join(ssi_clearer_office_ds_dist, office_ds_dist, left.clearer_office_id = right.id, 
																				transform(expanded_ssi_layout, self.clearer_tfpuid := right.tfpuid; self := left;), local, left outer);

	//output(	sort(ssi_clearer_office_ds, id), named('ssi_clearer_office_ds'));
	//output(	count(ssi_clearer_office_ds), named('ssi_clearer_office_ds_count'));  
	
	// ssi to intermediate office id join
	ssi_intermediary_office_ds_dist := DISTRIBUTE(ssi_clearer_office_ds, HASH(intermediary_office_id));
	ssi_intermediary_office_ds := join(ssi_intermediary_office_ds_dist, office_ds_dist, left.intermediary_office_id = right.id, 
																				transform(expanded_ssi_layout, self.holder_tfpuid := right.tfpuid; self := left;), local, left outer);

	//output(	sort(ssi_intermediary_office_ds, id), named('ssi_intermediary_office_ds'));
	//output(	count(ssi_intermediary_office_ds), named('ssi_intermediary_office_ds_count'));

	// ssi to beneficiary office id join
	ssi_beneficiary_office_ds_dist := DISTRIBUTE(ssi_intermediary_office_ds, HASH(beneficiary_office_id));	
	ssi_beneficiary_office_ds := join(ssi_beneficiary_office_ds_dist, office_ds_dist, left.beneficiary_office_id = right.id, 
																				transform(expanded_ssi_layout, self.owner_tfpuid := right.tfpuid; self := left;), local, left outer);
	//output(	sort(ssi_beneficiary_office_ds, id), named('ssi_beneficiary_office_ds'));
	//output(	count(ssi_beneficiary_office_ds), named('ssi_beneficiary_office_ds_count'));

	// ssi to further office id join
	ssi_further_office_ds_dist := DISTRIBUTE(ssi_beneficiary_office_ds, HASH(further_office_id));
	ssi_further_office_ds := join(ssi_further_office_ds_dist, office_ds_dist, left.further_office_id = right.id, 
																				transform(expanded_ssi_layout, self.further_tfpuid := right.tfpuid; self := left;), local, left outer);
	//output(	sort(ssi_further_office_ds, id), named('ssi_further_office_ds'));
	//output(	count(ssi_further_office_ds), named('ssi_further_office_ds_count'));
	
	// ssi to further2 office id join
	ssi_further2_office_ds_dist := DISTRIBUTE(ssi_further_office_ds, HASH(further2_office_id));
	ssi_further2_office_ds := join(ssi_further2_office_ds_dist, office_ds_dist, left.further2_office_id = right.id, 
																				transform(expanded_ssi_layout, self.further2_tfpuid := right.tfpuid; self := left;), local, left outer);	
	//output(	sort(ssi_further2_office_ds, id), named('ssi_further2_office_ds'));
	//output(	count(ssi_further2_office_ds), named('ssi_further2_office_ds_count'));	
	
	
	// routing codes layout_RoutingCode
	routing_codes_dist := DISTRIBUTE(Ares.Files.ds_routingcode(codeType='SWIFT BIC'), HASH(id));
	// ssi to clearer routing code id join
	ssi_clear_routing_dist :=  DISTRIBUTE(ssi_further2_office_ds, HASH(clearer_routing_code_id));
	ssi_clear_route_dist_ds := join(ssi_clear_routing_dist, routing_codes_dist, left.clearer_routing_code_id = right.id, 
																				transform(expanded_ssi_layout, self.clearer_bic_code := right.codeValue; self := left;), local, left outer);
	
	output(	sort(ssi_clear_route_dist_ds, id), named('ssi_clear_route_dist_ds'));
	output(	count(ssi_clear_route_dist_ds), named('ssi_clear_route_dist_ds_count'));	
	
	// ssi to intermediary routing code id join
	ssi_intermediary_routing_dist :=  DISTRIBUTE(ssi_clear_route_dist_ds, HASH(intermediary_routing_code_id));
	ssi_intermediary_route_dist_ds := join(ssi_intermediary_routing_dist, routing_codes_dist, left.intermediary_routing_code_id = right.id, 
																				transform(expanded_ssi_layout, self.holder_bic_code := right.codeValue; self := left;), local, left outer);
	
	output(	sort(ssi_intermediary_route_dist_ds, id), named('ssi_intermediary_route_dist_ds'));
	output(	count(ssi_intermediary_route_dist_ds), named('ssi_intermediary_route_dist_ds_count'));	
	
	// ssi to beneficiary routing code id join
	ssi_beneficiary_routing_dist :=  DISTRIBUTE(ssi_intermediary_route_dist_ds, HASH(beneficiary_routing_code_id));
	ssi_beneficiary_route_dist_ds := join(ssi_beneficiary_routing_dist, routing_codes_dist, left.beneficiary_routing_code_id = right.id, 
																				transform(expanded_ssi_layout, self.owner_bic_code := right.codeValue; self := left;), local, left outer);
	
	//output(	sort(ssi_beneficiary_route_dist_ds, id), named('ssi_beneficiary_route_dist_ds'));
	//output(	count(ssi_beneficiary_route_dist_ds), named('ssi_beneficiary_route_dist_ds_ds_count'));	
	
	// ssi to further routing code id join
	ssi_further_routing_dist :=  DISTRIBUTE(ssi_beneficiary_route_dist_ds, HASH(further_routing_code_id));
	ssi_further_route_dist_ds := join(ssi_further_routing_dist, routing_codes_dist, left.further_routing_code_id = right.id, 
																				transform(expanded_ssi_layout, self.further_bic_code := right.codeValue; self := left;), local, left outer);
	
		// ssi to further2 routing code id join
	ssi_further2_routing_dist :=  DISTRIBUTE(ssi_further_route_dist_ds, HASH(further2_routing_code_id));
	ssi_further2_route_dist_ds := join(ssi_further2_routing_dist, routing_codes_dist, left.further2_routing_code_id = right.id, 
																				transform(expanded_ssi_layout, self.further2_bic_code := right.codeValue; self := left;), local, left outer);
	
	// ssi to ssiSet id join 
	ssi_full_ds := join(ssi_beneficiary_route_dist_ds, Ares.Files.ds_ssiset, left.ssi_set_id = right.id, left outer);

	
	layout_gpssi final_xform(ssi_full_ds l) := Transform
		self.Update_Flag 					:= 'A';
		//self.Primary_Key					:= Ares.str_functions.pad(seq_cnt,'>','0',8); 
		self.Primary_Key							:= l.primary_key; 
		self.Accuity_Location_ID			:= l.owner_tfpuid;
		self.Correspondent_Type				:= l.correspondentType;
		self.ISO_Currency_Code				:= l.currency_iso_code;
		self.Owner_BIC											 := if (l.owner_bic_code != '' and length(l.owner_bic_code) < 11, Ares.str_functions.pad(l.owner_bic_code, '>', 'X', 11), l.owner_bic_code);
		self.Owner_BIC_Without_Padding			 := l.owner_bic_code;
		self.Owner_BIC_SSI_Account_Number    := l.clearer_account_number;
		self.Clearer_Location_ID             := l.clearer_tfpuid;
		self.Clearer_BIC                     := if (l.clearer_bic_code != '' and length(l.clearer_bic_code) < 11, Ares.str_functions.pad(l.clearer_bic_code, '>', 'X', 11), l.clearer_bic_code);
		self.Clearer_BIC_Without_Padding     := l.clearer_bic_code;
		self.Holder_Location_ID              :=  l.holder_tfpuid;
		self.Holder_BIC                      := if (l.holder_bic_code != '' and length(l.holder_bic_code) < 11, Ares.str_functions.pad(l.holder_bic_code, '>', 'X', 11), l.holder_bic_code);
		self.Holder_BIC_Without_Padding      := l.holder_bic_code;
		self.Holder_BIC_SSI_Account_Number   := l.holder_account_number;
		self.Preferred_SSI_Indicator         := l.preferred;
		self.Further_Location_ID             := l.further_tfpuid;
		self.Further_BIC                     := if (l.further_bic_code != '' and length(l.further_bic_code) < 11, Ares.str_functions.pad(l.further_bic_code, '>', 'X', 11), l.further_bic_code);
		self.Further_BIC_Without_Padding     := l.further_bic_code;
		self.Further_2_Location_ID           := l.further2_tfpuid;
		self.Further_2_BIC                   := if (l.further2_bic_code != '' and length(l.further2_bic_code) < 11, Ares.str_functions.pad(l.further2_bic_code, '>', 'X', 11), l.further2_bic_code);
		self.Further_2_BIC_Without_Padding   := l.further2_bic_code;
		self.Correspondent_Effective_Date    := l.created_on_date;
		self.Correspondent_Deactivation_Date := l.deleted_on_date;
		self.Correspondent_Update_Date       := l.validationDate;
		self.SSI_Notes                       := l.additional_info;
	End;

	final := Project(ssi_full_ds, final_xform(left));

EXPORT file_gpssi := final;