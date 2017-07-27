Import advo,ut,iesp,AutoHeaderI;
export Zipcode_records (Lookup_Services.Zipcode_IParam.searchParams inrec) := FUNCTION


	//Validate input prior to running search
	hasZip := inrec.Zip <> '';
	hasState := inrec.State <> '';
	hasCity :=  inrec.City <> '';
	hasStreet :=  inrec.StreetName <> '';
	hasCheckedOption := inrec.isZip5 or inrec.isZip4ByZip5 or inrec.isCityListByZip5;
	isOptionMissing := hasZip and not hasCheckedOption;
	isZip4MissingZip:= not hasZip and inrec.isZip4ByZip5;
	isCityListMissingZip:= not hasZip and inrec.isCityListByZip5;
	isMissingState:=not hasState and (inrec.isAddresses or inrec.isZip5);
	isMissingCity:=not hasCity and (inrec.isAddresses or inrec.isZip5);
	isMissingSearchType:=not inrec.isAddresses and not inrec.isZip5 and not inrec.isZip4ByZip5 and not inrec.isCityListByZip5;

	Validation := Map(isOptionMissing=true => 'Zip is only used in conjunction with SearchType Zip4s and Cities.',
										isZip4MissingZip=true => 'You must specify a Zip when using SearchType Zip4s.',
										isCityListMissingZip=true => 'You must specify a Zip when using SearchType Cities.',
										isMissingState=true => 'You must specify a State.',
										isMissingCity=true => 'You must specify a City.',
										isMissingSearchType=true => 'You must specify a SearchType. Valid values are Zip, Zip4s, Cities.',
										'');
	if(length(trim(Validation))>0,fail(301,Validation));
	isNumericStreet := ut.isNumeric(inrec.streetName);
	cleanStreetName := if(isNumericStreet,AutoHeaderI.Functions.addOrdinal(inrec.streetName),inrec.streetName); 
	getAdvoStreetListingsData:=Advo.Key_Addr2(keyed(ST=inrec.state) and keyed(v_city_name=inrec.City) and prim_name=cleanStreetName and (prim_range = inrec.StreetNumber or inrec.StreetNumber = ''));
	getAdvoStreetListingsDataFinal:=project(getAdvoStreetListingsData, Lookup_Services.Zipcode_layouts.Zipcode_Zip4Listing);
	//New rules, if house number return zip and zip 4.  if only street return zip
  Lookup_Services.Zipcode_layouts.Zipcode_slim slimRules(Lookup_Services.Zipcode_layouts.Zipcode_Zip4Listing inGeoData) := transform
		self.ZIP_5 := inGeoData.zip_5;
		self.ZIP_4 := if(inrec.StreetNumber <> '',inGeoData.zip_4,'');
		self := [];
	end;
	getAdvoStreetListingsData_Rules := project(getAdvoStreetListingsDataFinal,slimRules(left));
	getAdvoStreetListingsData_Final := dedup(sort(getAdvoStreetListingsData_Rules,zip_5,zip_4),zip_5,zip_4);
	
	getCityListbyZipcode:=project(ut.ZipToCities(inrec.Zip).records,transform(Lookup_Services.Zipcode_layouts.Zipcode_slim,self.city_name:=left.city,self:=[]));

	getZipcodeforCity:=project(dataset(ut.ZipsWithinCity(inrec.state,inrec.city),{Integer4 ZIP_5}),transform(Lookup_Services.Zipcode_layouts.Zipcode_slim,self.ZIP_5:=(string)left.ZIP_5,self:=[]));

	getZip4forZipcodeData:=project(Advo.Key_Addr1(keyed(zip=inrec.Zip)),Lookup_Services.Zipcode_layouts.Zipcode_Zip4Listing);
	getZip4_dedup:=dedup(sort(getZip4forZipcodeData,ZIP_5,ZIP_4),ZIP_5,ZIP_4);
	getZip4forZipcode:=project(getZip4_dedup,transform(Lookup_Services.Zipcode_layouts.Zipcode_slim,self:=left,self:=[]));

	//Get Data based on input combination
	getGeoData:=map(inrec.Zip <> '' and inrec.isCityListByZip5 => getCityListbyZipcode,
									inrec.Zip <> '' and inrec.isZip4ByZip5 => getZip4forZipcode,
							    inrec.StreetName <> '' and inrec.City <> '' and inrec.State <> '' and inrec.isAddresses => getAdvoStreetListingsData_Final,
							    inrec.City <> '' and inrec.State <> '' and inrec.isZip5 => getZipcodeforCity,
							    dataset([],Lookup_Services.Zipcode_layouts.Zipcode_slim));

	getResults:=dedup(sort(getGeoData,STREET_NUM,STREET_NAME,STREET_PRE_DIRectional,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,County_Name,City_Name,State_Code,ZIP_5,ZIP_4),STREET_NUM,STREET_NAME,STREET_PRE_DIRectional,STREET_POST_DIRectional,STREET_SUFFIX,Secondary_Unit_Designator,Secondary_Unit_Number,County_Name,City_Name,State_Code,ZIP_5,ZIP_4);

	iesp.zipcode.t_ZipCodeSearchRecord xfmOutput(Lookup_Services.Zipcode_layouts.Zipcode_slim l) := transform
		self.Address.StreetNumber:=l.STREET_NUM;
		self.Address.StreetPreDirection:=l.STREET_PRE_DIRectional;
		self.Address.StreetName:=l.STREET_NAME;
		self.Address.StreetSuffix:=l.STREET_SUFFIX;
		self.Address.StreetPostDirection:=l.STREET_POST_DIRectional;
		self.Address.UnitDesignation:=l.Secondary_Unit_Designator;
		self.Address.UnitNumber:=l.Secondary_Unit_Number;
		self.Address.StreetAddress1:='';
		self.Address.StreetAddress2:='';
		self.Address.City:=l.City_Name;
		self.Address.State:=if(inrec.isCityListByZip5,ziplib.ZipToState2(inrec.Zip),l.State_Code);
		self.Address.Zip5:=l.ZIP_5;
		self.Address.Zip4:=l.ZIP_4;
		self.Address.County:=l.County_Name;
		self.Address.PostalCode:='';
		self.Address.StateCityZip:='';
	end;
	
	return Project(getResults,xfmOutput(left));
End;

