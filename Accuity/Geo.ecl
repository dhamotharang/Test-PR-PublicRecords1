import Worldcheck_Bridger;
// handle country and city data
export Geo := MODULE

//geoin := Reformat.Inputs.gwl(type IN ['01', '02']);
countries := Accuity.Files.input.gwl.entity(type = '01');
cities := Accuity.Files.input.gwl.entity(type = '02');
 

rPlaceDenormal :=
	RECORD,maxlength(4096)
		string	id;
		string	full_name;
		string	list_id;
		string	list_code;
		string	source;
		string  Listed_Date;
		dataset(Layouts.Input.crAddresses)	Addresses; 
END;

rPlace :=
	RECORD,maxlength(4096)
		string	id;
		string	full_name;
		string	list_id;
		string	list_code;
		string	source;
		string  Listed_Date;
		Layouts.Input.crAddresses	Address; 
END;

locations1 := Project(cities, rPlaceDenormal);

	tbl := table(locations1, 
						{integer n := count(Addresses), 
						locations1});


	locations2 := normalize(tbl,left.n,transform(rPlace,
										self.id 			:= left.id;
										self.full_name		:= left.full_name;
										self.Address	:= left.Addresses[counter];
										self := left;
									)
							);

extras := locations2(full_name <> Address.City,full_name <> Address.Province);
locations3 := PROJECT(extras, transform(rPlace,
										self.id 			:= left.id;
										self.full_name		:= left.full_name;
										ct := TRIM(left.Address.City);
										pr := TRIM(left.Address.Province);
										self.Address.City := IF(pr='',left.full_name,'');
										self.Address.Province := IF(pr='','',left.full_name);
										self := left;
							));

locations4 := locations2 + locations3;


locations := DEDUP(locations4, record, all);


rLocation := RECORD
    string lid;
	string type;
	string name;
	string country;
	string locsource;
END;

rGeography := RECORD
		string	id;
		string	full_name;
		string	list_id;
		string	list_code;
		string	source;
		string listed_date;
		string reason_listed;
		string comments;
		string countrycode;
		string countryname;
		rLocation;
END;

rGeography xPlace(Layouts.input.rEntity L, rPlace R) := TRANSFORM
	self.type := TRIM(MAP(
		R.Address.City <> '' => 'CITY',
		R.Address.Province <> '' => 'CITY',		//'PROVINCE',
		''));
	self.name := MAP(
		R.Address.City <> '' => R.Address.City,
		R.Address.Province <> '' => R.Address.Province,
		'');
	self.lid := R.id;
	self.country := R.Address.country_name;
	self.locsource := R.source;
	self.comments := L.additional_info[1].sdf_value;
	self.reason_listed := L.programs[1].program_desc;
	self.countrycode := L.addresses[1].country_code;
	self.countryname := L.addresses[1].country_name;
	self := L;
END;

//j := JOIN(countries, locations(Address.City <> '' ),	// exclude provinces
j := JOIN(countries, locations(Address.City <> '' ),
			LEFT.source = RIGHT.source AND LEFT.Addresses[1].Country_code = RIGHT.Address.Country_code,
			xPlace(LEFT, RIGHT), LEFT OUTER);

j2 := SORT(DISTRIBUTE(j(id<>''), hash(id)), id, LOCAL);

Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo xrotm(rGeography src) := TRANSFORM
	self.id := src.id;
	self.Country_Name := src.full_name;
	self.accuitydatasource := src.source+' '+src.list_id;
	self.comments := '';
	self.Entity_Unique_ID		:= 'AC' + src.id;
//	self.Listed_date := src.lastUpdateDate;
//	self.location_list := DATASET([{src.ltype; src.name;}],Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_location);
	self.location_list.location := 	row(src,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_location);
	SELF := src;
	self := [];
END;

alldata := project(j2, xrotm(LEFT));

Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo makeCities(
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo L,
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.rgeo R) := TRANSFORM
	SELF.id := L.id;
	SELF.location_list.location := L.location_list.location + 
					ROW({R.location_list.location[1].lid,
						TRIM(R.location_list.location[1].type),
						R.location_list.location[1].name},
						Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_location);
	self := L;
END;

georecs1 := SORT(DISTRIBUTE(ROLLUP(alldata, id, makeCities(LEFT, RIGHT)),hash(id)),id,LOCAL);

georecs3 := geoAKAs(georecs1);

export georecs := sort(distribute(georecs3,hash(id)),id,LOCAL) :persist('~hthor::persist::accuity::allgeo');

export source_CEL_1082_countries  := georecs(accuityDataSource='CEL 1082'); //CANADIAN ECONOMIC SANCTIONED COUNTRIES LIST
export source_FDJ_1152_countries  := georecs(accuityDataSource='FDJ 1152'); //
export source_OFAC_countries  := georecs(accuityDataSource IN ['RBL 1072','TFP 1072']); //OFAC
END;

