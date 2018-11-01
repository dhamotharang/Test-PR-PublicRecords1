import std;

office := Ares.file_office_flat(tfpuid != '');

//join office to city on office.city.fid = locations.location.address.city.fid
location_layout := Record
	string tfpuid;
	string institution_id;
	string office_type_code;
	dataset(Ares.layouts.address) addresses;
End;

location_layout loc_xform(recordof(office) l, RecordOf(office.locations) r) := Transform
		self.tfpuid := l.tfpuid;
		self.institution_id := l.institution_id;
		self.office_type_code := l.summary.types[1].type;
		self.addresses := r.address;
End;
//We have to get all the locations for each office.  We're keeping tfpuid to be the primary key. Each office can 
//have multiple locations and each location can have multiple addresses.
locations := normalize(office, Left.locations, loc_xform(LEFT,RIGHT));

address_layout := Record
	string tfpuid;
	string institution_id;
	string office_type_code;
	Ares.layouts.address address;
End;

address_layout adr_xform(recordof(locations) l, Ares.layouts.address r) := Transform
	self.tfpuid := l.tfpuid;
	self.institution_id := l.institution_id;
	self.office_type_code := l.office_type_code;
	self.address := r;
End;

//Each location can have multiple addresses so we have to get them all.
addresses := normalize(locations, Left.addresses, adr_xform(LEFT,RIGHT));


city_layout_slim := Record
	addresses.tfpuid;
	addresses.institution_id;
	addresses.office_type_code;
	string cityid;
End;

//Slime layout to only required fields.
office_city_slim := project(addresses, transform( city_layout_slim, 
															self.cityid := if(left.address.city.link.href != '', std.str.splitwords(left.address.city.link.href,'/')[3], '');
															self := left));
	
//Join to city dataset.
office_city_join := join(office_city_slim, Ares.Files.ds_city, left.cityid = right.id);

layout_city_slim := record
    string id;
		string fid;
    string tfpid;
		string tfpuid;
		string office_type_code;
		string institution_id;
		string country_id;
end;



layout_country_slim := record
	string country_id;
End;

layout_place := record
	string link_href;
  string link_rel;
end;

layout_country_slim country_id_xform(recordof(office_city_join.within.place) l) := Transform
	self.country_id := if(l.link_href != '', std.str.splitwords(l.link_href,'/')[3], '');
End;

layout_city_slim city_xform(office_city_join l) := Transform
	places := l.within.place;
	country_ids := project(places(regexfind( '/country/id', link_href)), country_id_xform(left));
	self.country_id := if(count(country_ids) > 0, country_ids[1].country_id,'');
	self := l;
End;


city_with_country_id := project(office_city_join, city_xform(left));

city_with_country_layout := record(recordof(city_with_country_id))
	string iso2;
End;

city_with_country_layout cc_xform(city_with_country_id l, Ares.Files.ds_country r) := transform
	self.iso2 := r.summary.iso2;
	self := l;
End;

with_iso := join(city_with_country_id, Ares.Files.ds_country, left.country_id = right.id, cc_xform(left, right));

expanded_legal_layout := recordof(Ares.Files.ds_legal_entity) or {string c_type_source, string c_type_value};

expanded_legal_layout expand_legal_xform(Ares.Files.ds_legal_entity l) := Transform
	self.c_type_value := l.summary.types(type_source = 'TFP')[1].type_value;
	self.c_type_source := if (self.c_type_value != '', 'TFP', '');
	self := l;
End;

expanded_legal := project(Ares.Files.ds_legal_entity, expand_legal_xform(left));



// count(expanded_legal(c_type_value != ''));
// count(expanded_legal(c_type_value = ''));
layout_w_institution_type := record(recordof(with_iso))
	string institution_type;
	expanded_legal.summary.names;
	string abbrev_name := '';
end;

layout_w_institution_type instit_xform(with_iso l, expanded_legal r) := Transform
	inst_type := trim(r.c_type_value, left,right);
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
																self := l;
																self := r.summary;
	end;


with_inst_type := join(with_iso, expanded_legal, left.institution_id = right.id , instit_xform(left, right));
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

layout_gploc final_xform(w_office_type l) := Transform
	self.Update_Flag := 'A';
	self.ISO_Country_Code := l.iso2;
	self.Primary_Key_Accuity_Location_ID := l.tfpuid;
	self.Institution_Type := l.institution_type;
	self.Office_Type := l.office_type;
	
End;
	final := Project(w_office_type, final_xform(left));
EXPORT file_gploc := final;