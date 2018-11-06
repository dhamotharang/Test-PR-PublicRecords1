import std;

	ssi := files.ds_ssi;
	
	layout_ssi_extended := record(layout_ssi)
			string currency_id;
			string clearer_office_id;
			string intermediary_office_id;
			string beneficiary_office_id;
			string clearer_routing_code_id;
			string intermediary_routing_code_id;
			string beneficiary_routing_code_id;
			string further_office_id;
			string further2_office_id;
			string further_routing_code_id;
			string further2_routing_code_id;
			string ssi_set_id;
			string currency_iso_code; // ssi/currency→/currency/isoCode
			string owner_tfpuid; // ssi/route/beneficiary/presence→/office/@tfpuid
			string owner_bic_code; // ssi/route/beneficiary/routingCodes/routingCode→ /routingCode[codeType="SWIFT BIC"]/codeValue
			string clearer_account_number;	
			string clearer_tfpuid; // ssi/route/clearer/presence→/office/@tfpuid
			string clearer_bic_code; // ssi/route/clearer/routingCodes/routingCode→ /routingCode[codeType="SWIFT BIC"]/codeValue
			string holder_tfpuid; // ssi/route/intermediary[1]/presence→/office/tfpuid
			string holder_bic_code; // ssi/route/intermediary[1]/routingCodes/routingCode→/routingCode[codeType='SWIFT BIC']/codeValue
			string holder_account_number; // ssi/route/intermediary[1]/accountNumbers/accountNumber
			string further_tfpuid;
			string further_bic_code;
			string further2_tfpuid;
			string further2_bic_code;
	end;

	
	ssi_extended_ds := project(ssi, transform( layout_ssi_extended, 
															self.currency_id := if(left.currency_link_href != '', std.str.splitwords(left.currency_link_href,'/')[3], '');
															self.clearer_office_id := if(count(left.route.clearer) > 0, std.str.splitwords(left.route.clearer[1].presence_link_href,'/')[3], '');
															self.intermediary_office_id := if(count(left.route.intermediary) > 0, std.str.splitwords(left.route.intermediary[1].presence_link_href,'/')[3], '');
															self.beneficiary_office_id := if(count(left.route.beneficiary) > 0, std.str.splitwords(left.route.beneficiary[1].presence_link_href,'/')[3], '');
															self.clearer_routing_code_id := if(count(left.route.clearer.routingCodes) > 0, if(left.route.clearer[1].routingCodes[1].link_href != '', std.str.splitwords(left.route.clearer[1].routingCodes[1].link_href,'/')[3], ''), '');
															self.intermediary_routing_code_id := if(count(left.route.intermediary.routingCodes) > 0, if(left.route.intermediary[1].routingCodes[1].link_href != '', std.str.splitwords(left.route.intermediary[1].routingCodes[1].link_href,'/')[3], ''), '');
															self.beneficiary_routing_code_id := if(count(left.route.beneficiary.routingCodes) > 0, if(left.route.beneficiary[1].routingCodes[1].link_href != '', std.str.splitwords(left.route.beneficiary[1].routingCodes[1].link_href,'/')[3], ''), '');											
															self.further_office_id	:= if(count(left.route.intermediary) > 0, std.str.splitwords(left.route.intermediary[2].presence_link_href,'/')[3], '');;
															self.further2_office_id := if(count(left.route.intermediary) > 0, std.str.splitwords(left.route.intermediary[3].presence_link_href,'/')[3], '');
															self.further_routing_code_id := if(count(left.route.intermediary.routingCodes) > 0, if(left.route.intermediary[1].routingCodes[2].link_href != '', std.str.splitwords(left.route.intermediary[2].routingCodes[1].link_href,'/')[3], ''), '');
															self.further2_routing_code_id := if(count(left.route.intermediary.routingCodes) > 0, if(left.route.intermediary[1].routingCodes[3].link_href != '', std.str.splitwords(left.route.intermediary[3].routingCodes[1].link_href,'/')[3], ''), '');
															self.ssi_set_id := if(left.set_link_href != '', std.str.splitwords(left.set_link_href,'/')[3], '');
															self.owner_tfpuid			:= '';
															self.owner_bic_code			:= '';
															self.clearer_account_number	:= if(count(left.route.clearer.accountNumber) > 0, left.route.clearer[1].accountNumber[1].value, '');
															self.clearer_tfpuid			:= '';
															self.clearer_bic_code		:= '';
															self.holder_tfpuid			:= '';
															self.holder_bic_code		:= '';
															self.holder_account_number	:= if(count(left.route.intermediary[1].accountNumber) > 0, left.route.intermediary[1].accountNumber[1].value, '');
															self.further_tfpuid			:= '';
															self.further_bic_code		:= '';
															self.further2_tfpuid		:= '';
															self.further2_bic_code		:= '';	
															self.currency_iso_code := '';
															self := left));
	
	output(	sort(ssi_extended_ds, id), named('ssi_extended_ds'));
	output(	count(ssi_extended_ds), named('ssi_extended_ds_count'));
	
	// ssi to  currency join
	ssi_currency_ds := join(ssi_extended_ds, Ares.Files.ds_currency, left.currency_id = right.id, 
																																	 transform(layout_ssi_extended, self.currency_iso_code := right.isoCode; self := left;), left outer);
	//output(	sort(ssi_currency_ds, id), named('ssi_currency_ds'));
	//output(	count(ssi_currency_ds), named('ssi_currency_dss_count'));	
	
	
	office_ds_dist := DISTRIBUTE(Ares.Files.ds_office, HASH(id));
	// ssi to clearer office id join
	ssi_clearer_office_ds_dist := DISTRIBUTE(ssi_currency_ds, HASH(clearer_office_id));	
	ssi_clearer_office_ds := join(ssi_clearer_office_ds_dist, office_ds_dist, left.clearer_office_id = right.id, 
																				transform(layout_ssi_extended, self.clearer_tfpuid := right.tfpuid; self := left;), local, left outer);

	//output(	sort(ssi_clearer_office_ds, id), named('ssi_clearer_office_ds'));
	//output(	count(ssi_clearer_office_ds), named('ssi_clearer_office_ds_count'));  
	
	// ssi to intermediate office id join
	ssi_intermediary_office_ds_dist := DISTRIBUTE(ssi_clearer_office_ds, HASH(intermediary_office_id));
	ssi_intermediary_office_ds := join(ssi_intermediary_office_ds_dist, office_ds_dist, left.intermediary_office_id = right.id, 
																				transform(layout_ssi_extended, self.holder_tfpuid := right.tfpuid; self := left;), local, left outer);

	//output(	sort(ssi_intermediary_office_ds, id), named('ssi_intermediary_office_ds'));
	//output(	count(ssi_intermediary_office_ds), named('ssi_intermediary_office_ds_count'));

	// ssi to beneficiary office id join
	ssi_beneficiary_office_ds_dist := DISTRIBUTE(ssi_intermediary_office_ds, HASH(beneficiary_office_id));	
	ssi_beneficiary_office_ds := join(ssi_beneficiary_office_ds_dist, office_ds_dist, left.beneficiary_office_id = right.id, 
																				transform(layout_ssi_extended, self.owner_tfpuid := right.tfpuid; self := left;), local, left outer);
	//output(	sort(ssi_beneficiary_office_ds, id), named('ssi_beneficiary_office_ds'));
	//output(	count(ssi_beneficiary_office_ds), named('ssi_beneficiary_office_ds_count'));

	// ssi to further office id join
	ssi_further_office_ds_dist := DISTRIBUTE(ssi_beneficiary_office_ds, HASH(further_office_id));
	ssi_further_office_ds := join(ssi_further_office_ds_dist, office_ds_dist, left.further_office_id = right.id, 
																				transform(layout_ssi_extended, self.further_tfpuid := right.tfpuid; self := left;), local, left outer);
	//output(	sort(ssi_further_office_ds, id), named('ssi_further_office_ds'));
	//output(	count(ssi_further_office_ds), named('ssi_further_office_ds_count'));
	
	// ssi to further2 office id join
	ssi_further2_office_ds_dist := DISTRIBUTE(ssi_further_office_ds, HASH(further2_office_id));
	ssi_further2_office_ds := join(ssi_further2_office_ds_dist, office_ds_dist, left.further2_office_id = right.id, 
																				transform(layout_ssi_extended, self.further2_tfpuid := right.tfpuid; self := left;), local, left outer);	
	//output(	sort(ssi_further2_office_ds, id), named('ssi_further2_office_ds'));
	//output(	count(ssi_further2_office_ds), named('ssi_further2_office_ds_count'));	
	
	
	// routing codes layout_RoutingCode
	routing_codes_dist := DISTRIBUTE(Ares.Files.ds_routingcode(codeType='SWIFT BIC'), HASH(id));
	// ssi to clearer routing code id join
	ssi_clear_routing_dist :=  DISTRIBUTE(ssi_further2_office_ds, HASH(clearer_routing_code_id));
	ssi_clear_route_dist_ds := join(ssi_clear_routing_dist, routing_codes_dist, left.clearer_routing_code_id = right.id, 
																				transform(layout_ssi_extended, self.clearer_bic_code := right.codeValue; self := left;), local, left outer);
	
	output(	sort(ssi_clear_route_dist_ds, id), named('ssi_clear_route_dist_ds'));
	output(	count(ssi_clear_route_dist_ds), named('ssi_clear_route_dist_ds_count'));	
	
	// ssi to intermediary routing code id join
	ssi_intermediary_routing_dist :=  DISTRIBUTE(ssi_clear_route_dist_ds, HASH(intermediary_routing_code_id));
	ssi_intermediary_route_dist_ds := join(ssi_intermediary_routing_dist, routing_codes_dist, left.intermediary_routing_code_id = right.id, 
																				transform(layout_ssi_extended, self.holder_bic_code := right.codeValue; self := left;), local, left outer);
	
	output(	sort(ssi_intermediary_route_dist_ds, id), named('ssi_intermediary_route_dist_ds'));
	output(	count(ssi_intermediary_route_dist_ds), named('ssi_intermediary_route_dist_ds_count'));	
	
	// ssi to beneficiary routing code id join
	ssi_beneficiary_routing_dist :=  DISTRIBUTE(ssi_intermediary_route_dist_ds, HASH(beneficiary_routing_code_id));
	ssi_beneficiary_route_dist_ds := join(ssi_beneficiary_routing_dist, routing_codes_dist, left.beneficiary_routing_code_id = right.id, 
																				transform(layout_ssi_extended, self.owner_bic_code := right.codeValue; self := left;), local, left outer);
	
	//output(	sort(ssi_beneficiary_route_dist_ds, id), named('ssi_beneficiary_route_dist_ds'));
	//output(	count(ssi_beneficiary_route_dist_ds), named('ssi_beneficiary_route_dist_ds_ds_count'));	
	
	// ssi to further routing code id join
	ssi_further_routing_dist :=  DISTRIBUTE(ssi_beneficiary_route_dist_ds, HASH(further_routing_code_id));
	ssi_further_route_dist_ds := join(ssi_further_routing_dist, routing_codes_dist, left.further_routing_code_id = right.id, 
																				transform(layout_ssi_extended, self.further_bic_code := right.codeValue; self := left;), local, left outer);
	
		// ssi to further2 routing code id join
	ssi_further2_routing_dist :=  DISTRIBUTE(ssi_further_route_dist_ds, HASH(further2_routing_code_id));
	ssi_further2_route_dist_ds := join(ssi_further2_routing_dist, routing_codes_dist, left.further2_routing_code_id = right.id, 
																				transform(layout_ssi_extended, self.further2_bic_code := right.codeValue; self := left;), local, left outer);
	
	// ssi to ssiSet id join 
	ssi_full_ds := join(ssi_beneficiary_route_dist_ds, Ares.Files.ds_ssiset, left.ssi_set_id = right.id, left outer);
	
	
	paddedBicCode(STRING code) := FUNCTION
		xstring := 'XXXXXXXXXXX';
		x := 11 - length(code);
		padded_str := xstring[1..x] + code;
		RETURN padded_str;
	END;
	
	
	layout_gpssi final_xform(ssi_full_ds l) := Transform
		self.Update_Flag 					:= 'A';
		self.Primary_Key					:= ''; //TODO
		self.Accuity_Location_ID			:= l.owner_tfpuid;
		self.Correspondent_Type				:= l.correspondentType;
		self.ISO_Currency_Code				:= l.currency_iso_code;
		self.Owner_BIC											 := if (l.owner_bic_code != '' and length(l.owner_bic_code) < 11, paddedBicCode(l.owner_bic_code), l.owner_bic_code);
		self.Owner_BIC_Without_Padding			 := l.owner_bic_code;
		self.Owner_BIC_SSI_Account_Number    := l.clearer_account_number;
		self.Clearer_Location_ID             := l.clearer_tfpuid;
		self.Clearer_BIC                     := if (l.clearer_bic_code != '' and length(l.clearer_bic_code) < 11, paddedBicCode(l.clearer_bic_code), l.clearer_bic_code);
		self.Clearer_BIC_Without_Padding     := l.clearer_bic_code;
		self.Holder_Location_ID              :=  l.holder_tfpuid;
		self.Holder_BIC                      := if (l.holder_bic_code != '' and length(l.holder_bic_code) < 11, paddedBicCode(l.holder_bic_code), l.holder_bic_code);
		self.Holder_BIC_Without_Padding      := l.holder_bic_code;
		self.Holder_BIC_SSI_Account_Number   := l.holder_account_number;
		self.Preferred_SSI_Indicator         := l.preferred;
		self.Further_Location_ID             := l.further_tfpuid;
		self.Further_BIC                     := if (l.further_bic_code != '' and length(l.further_bic_code) < 11, paddedBicCode(l.further_bic_code), l.further_bic_code);
		self.Further_BIC_Without_Padding     := l.further_bic_code;
		self.Further_2_Location_ID           := l.further2_tfpuid;
		self.Further_2_BIC                   := if (l.further2_bic_code != '' and length(l.further2_bic_code) < 11, paddedBicCode(l.further2_bic_code), l.further2_bic_code);
		self.Further_2_BIC_Without_Padding   := l.further2_bic_code;
		self.Correspondent_Effective_Date    := l.created_on_date;
		self.Correspondent_Deactivation_Date := '';
		self.Correspondent_Update_Date       := l.validationDate;
		self.SSI_Notes                       := '';
	End;

	final := Project(ssi_full_ds, final_xform(left));

output(sort(final, -Accuity_Location_ID), named('final_output'));
//EXPORT file_gpssi := final;