import std;

office := Ares.file_office_flat(tfpuid != '');

// office_w_country_iso_layout := record(recordof(office))
	// string iso2;
// End;

// office_w_country_iso_layout cc_xform(office l, Ares.Files.ds_country r) := transform
	// self.iso2 := r.summary.iso2;
	// self := l;
// End;
// with_iso := join(city_with_country_id, Ares.Files.ds_country, left.country_id = right.id, cc_xform(left, right));
// with_iso := join(office, Ares.Files.ds_country, left.primary_city_country_id = right.id, cc_xform(left, right));
expanded_legal_layout := recordof(Ares.Files.ds_legal_entity) or {string c_type_source, string c_type_value, string headoffice_id};

expanded_legal_layout expand_legal_xform(Ares.Files.ds_legal_entity l) := Transform
	self.c_type_value := l.summary.types(type_source = 'TFP')[1].type_value;
	self.c_type_source := if (self.c_type_value != '', 'TFP', '');
	self.headoffice_id := std.str.splitwords(l.locations.headOffice.link_href,'/')[3];
	self := l;
End;

expanded_legal := project(Ares.Files.ds_legal_entity, expand_legal_xform(left));



// count(expanded_legal(c_type_value != ''));
// count(expanded_legal(c_type_value = ''));
layout_w_institution_type := record(recordof(office))
	string institution_type;
	string legal_entity_id;
	expanded_legal.summary.names;
	expanded_legal.headoffice_id;
	string abbrev_name := '';
end;

layout_w_institution_type instit_xform(office l, expanded_legal r) := Transform
	inst_type := trim(r.c_type_value, left,right);
	self.legal_entity_id := r.id;
	self.institution_type := Map(	inst_type ='Depository Financial Institution'=>'00',
																inst_type ='Commercial Bank'=>'01',
																inst_type ='Savings Bank'=>'02',
																inst_type ='Savings & Loan Association'=>'03',
																inst_type ='Credit Union'=>'04',
																inst_type ='Industrial Bank'=>'05',
																inst_type ='Edge Act Corporations'=>'06',
																inst_type ='Private Bank'=>'07',
																inst_type ='Article 12'=>'08',
																inst_type ='Consumer Credit Act Bank'=>'09',
																inst_type ='FCDA (Financial Center Development Act) Bank'=>'10',
																inst_type ='Government Bank'=>'11',
																inst_type ='Trust Company'=>'12',
																inst_type ='Thrift & Loan'=>'13',
																inst_type ='Financial Services Company'=>'14',
																inst_type ='Holding Company'=>'15',
																inst_type ='Attorney'=>'16',
																inst_type ='Cooperative Bank'=>'17',
																inst_type ='Cooperative'=>'17',
																inst_type ='Credit Card Bank'=>'20',
																inst_type ='Savings Holding Company'=>'21',
																inst_type ='Limited Purpose Bank'=>'23',
																inst_type ='Mortgage Bank'=>'25',
																inst_type ='Investment Bank'=>'26',
																inst_type ='Development Bank'=>'27',
																inst_type ='Universal Bank'=>'28',
																inst_type ='Agricultural Bank'=>'29',
																inst_type ='Non-Bank'=>'30',
																inst_type ='Deposit Taking Institution'=>'31',
																inst_type ='Merchant Bank'=>'32',
																inst_type ='Central Bank'=>'33',
																inst_type ='Credit Bank'=>'34',
																inst_type ='Off-Shore Bank'=>'35',
																inst_type ='Retail Bank'=>'36',
																inst_type ='Foreign Exchange Company'=>'37',
																inst_type ='Trade Finance Company'=>'38',
																inst_type ='Wholesale Bank'=>'39',
																inst_type ='Solicitor'=>'50',
																inst_type ='Auditor'=>'51',
																inst_type ='Building Society'=>'52',
																inst_type ='Authorized Institution'=>'53',
																inst_type ='Holding Company'=>'55',
																inst_type ='Association'=>'90',
																inst_type ='Unknown Type'=>'99', '99');
	abbrev_names := r.Summary.Names.Names(Type = 'Abbreviated Name');
	legal_names := r.Summary.Names.Names(Type = 'Legal Title');
	abbrev_name := MAP (count(abbrev_names) > 0 => abbrev_names[1].Value, count(legal_names) >0 => legal_names[1].Value,'' );
	self.abbrev_name := abbrev_name;
	self.headoffice_id := r.headoffice_id;
	self := l;
	self := r.summary;
end;


with_inst_type := join(office, expanded_legal, left.institution_id = right.id , instit_xform(left, right));
abbreviated_short := with_inst_type(length(abbrev_name)<=35);
abbreviated_long  := with_inst_type(length(abbrev_name)>35); 

// count(abbreviated_long);


recordof(abbreviated_long) xform_trans_abbv(abbreviated_long l) := Transform
	rep_ds  := Ares.Files.ds_lookup(fid ='ABBREVIATION_RULE').lookupBody(RegExFind(completetext, l.abbrev_name, NOCASE));
	
  iterator_layout := recordof(rep_ds) or {string abbv_name};
	
	iterator_ds := project(rep_ds, transform(iterator_layout, self.abbv_name := l.abbrev_name, self := left));

	iterator_layout iter_xform(iterator_ds l, iterator_ds r) := transform
		current_name := if(l.abbv_name = '', r.abbv_name, l.abbv_name);
		self.abbv_name := regexreplace(r.completetext, current_name, r.abbreviatedtext);
		self := R;
	End;
	
	iterated := iterate(iterator_ds, iter_xform(left, right));
	self.abbrev_name := if(count(iterated) > 0, iterated[count(iterated)].abbv_name, l.abbrev_name)[1..35];
	self := l;
End;

trans_abbr := project(abbreviated_long, xform_trans_abbv(left));
// abbreviated_long;
// trans_abbr;

with_office_type_layout := Record(recordof(with_inst_type))
	string office_type;
End;

with_office_type_layout add_ofc_type( with_inst_type l) := Transform
	self.office_type := Map(	RegExFind('Agency', l.office_type_code, NOCASE) => '03',
														RegExFind('Representative Office', l.office_type_code, NOCASE) => '04',
														RegExFind('Head Office', l.office_type_code, NOCASE) => '05',
														RegExFind('Branch', l.office_type_code, NOCASE) => '06','06');
	self := l;
End;

w_office_type := Project(abbreviated_short + trans_abbr , add_ofc_type(left));

w_headoffice_layout := record(recordof(w_office_type))
	string headoffice_tfpuid;
End;

w_headoffice_layout xform_headoffice(w_office_type l, office r) := transform
	self.headoffice_tfpuid := r.tfpuid;
	self := l;
End;

w_headoffice := join(w_office_type, office, left.headoffice_id = right.id, xform_headoffice(left, right));

w_current_assets_layout := record(recordof(w_headoffice))
	string current_assets := '';
end;

//Ares.Files.ds_financialstatement(count(lineItems(fid = 'FDB003F'))>0);
w_current_assets_layout xform_cur_ast(w_headoffice l, file_financialStatement_flat r) := transform
	self.current_assets := r.lineItems(fid = 'FDB003F')[1].value;
	self := l;
end;

w_current_assets := join(w_headoffice, file_financialStatement_flat, left.legal_entity_id = right.owner_id, xform_cur_ast(left,right));


ds_fin := ares.file_financialStatement_flat;
grp_fin_period_end_layout := record
	ds_fin.owner_id;
	last := max(group,ds_fin.periodEnd);
end;

latest_fin_recs := table(ds_fin, grp_fin_period_end_layout, owner_id);

w_fin_dt_layout := record(recordof(w_current_assets))
	string latest_fin_dt := '';
end;

w_fin_dt_layout xform_fin_dt(w_current_assets l, latest_fin_recs r) := Transform
	self.latest_fin_dt := r.last;
	self := l;
end;

w_fin_dt := join(w_current_assets, latest_fin_recs, left.legal_entity_id = right.owner_id, xform_fin_dt(left,right), left outer, keep(1));

layout_gploc final_xform(w_fin_dt l) := Transform
	self.Update_Flag := 'A';
	self.ISO_Country_Code := l.country_iso2;
	self.Primary_Key_Accuity_Location_ID := l.tfpuid;
	self.Institution_Type := l.institution_type;
	self.Office_Type := l.office_type;
	self.Institution_Name_Abbreviated := l.abbrev_name;
	self.Institution_Name_Full  := l.institution_fullname;
	self.Branch_Name := l.branch_name;
	self.Physical_Address_1  := l.physical_address1;
	self.Physical_Address_2  := l.physical_address2;
	self.City_Town := l.city_name;
	self.State_Province_Region_Abbreviated := l.st_prov_rgn_abbv;
	self.State_Province_Region_Full := l.st_prov_rgn;
	self.Postal_Code := l.postal_code;
	self.Country_Name_Full := l.country_name;
	self.employer_tax_id  := l.employer_tax_id;
	self.Head_Office_Accuity_Location_ID := l.headoffice_tfpuid;
	self.Current_Assets := l.current_assets;
	self.Date_of_Financials := l.latest_fin_dt;
	self.Institution_Identifier := std.str.splitwords(l.tfpid, '-')[1];
End;
	final := Project(w_fin_dt, final_xform(left));
EXPORT file_gploc := final;