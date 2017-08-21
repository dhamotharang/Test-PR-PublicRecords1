import	ut;

export	Proc_Build_GWL_Base_V2(string	pFileDate)	:=
function
	dEntityRecordID	:=	GlobalWatchLists.Generate_RecordID;

	// Convert to GWL Entity V2 layout
	GlobalWatchLists.Layouts.Base.rEntity_Layout	tReformatEntity(dEntityRecordID	pInput)	:=
	transform
		self.EntityID				:=	pInput.recordid;
		self.EntityType			:=	map(	UnicodeLib.UnicodeToUpperCase(pInput.nametype)	=	u'BUSINESS'		=>	'B',
																	UnicodeLib.UnicodeToUpperCase(pInput.nametype)	=	u'INDIVIDUAL'	=>	'I',
																	UnicodeLib.UnicodeToUpperCase(pInput.nametype)	=	u'VESSEL'			=>	'V',
																	'U'	//UNKNOWN
																);
		self.WatchListName	:=	(string)pInput.WatchListName;
		self.WatchListDate	:=	(string)pInput.WatchListDate;
		self.DateListed			:=	(string)pInput.DateListed;
		
		self.NameCount			:=	count(pInput.AkaList);
		self.AddressCount		:=	count(pInput.AddressList);
		self.IDCount				:=	count(pInput.IdentificationList);
		self.PhoneCount			:=	count(pInput.PhoneNumberList);
		self.InfoCount			:=	count(pInput.AdditionalInfoList);
		
		self.AkaNames				:=	project(	pInput.AkaList,
																			transform(	GlobalWatchLists.Layouts.Base.rAkaName_Layout,
																									self.RecordID	:=	counter;
																									self.Comments	:=	left.AkaComments;
																									self					:=	left;
																								)
																		);
		self.Addresses			:=	project(	pInput.AddressList,
																			transform(	GlobalWatchLists.Layouts.Base.rAddress_Layout,
																									self.RecordID				:=	counter;
																									self.AddressType		:=	(string)left.AddressType;
																									self.StreetAddress1	:=	left.StreetAddr1;
																									self.StreetAddress2	:=	left.StreetAddr2;
																									self.Comments				:=	left.AddrComments;
																									self								:=	left;
																								)
																		);
		self.Phones					:=	project(	pInput.PhoneNumberList,
																			transform(	GlobalWatchLists.Layouts.Base.rPhone_Layout,
																									self.RecordID	:=	counter;
																									self					:=	left;
																								)
																		);
		self.IDs						:=	project(	pInput.IdentificationList,
																			transform(	GlobalWatchLists.Layouts.Base.rID_Layout,
																									self.RecordID			:=	counter;
																									self.DateIssued		:=	(string)left.DateIssued;
																									self.DateExpires	:=	(string)left.DateExpires;
																									self.IDType				:=	GlobalWatchLists.constants.GetIDTypeCode((string)left.IdentificationType);
																									self.Comments			:=	left.IdentificationComments;
																									self							:=	left;
																								)
																		);
		self.AddlInfo				:=	project(	pInput.AdditionalInfoList,
																			transform(	GlobalWatchLists.Layouts.Base.rAddlInfo_Layout,
																									self.RecordID	:=	counter;
																									self.Comments	:=	left.AddlInfoComments;
																									self					:=	left;
																								)
																		);
		
		self								:=	pInput;
	end;

	dEntity	:=	project(dEntityRecordID,tReformatEntity(left));

	ut.MAC_SF_BuildProcess(dEntity,'~thor_200::base::globalwatchlistsV2::entity',buildEntityBase,,,true,pFileDate);

	// Convert to GWL V2 Country layout
	dCountryRecordID	:=	GlobalWatchLists.Generate_RecordID_Country;

	GlobalWatchLists.Layouts.Base.rCountry_Layout	tReformatCountry(dCountryRecordID	pInput)	:=
	transform
		dLocations	:=	project(	pInput.LocationList,
															transform(	GlobalWatchLists.Layouts.Base.rCountryName_Layout,
																					self.RecordID	:=	0;
																					self.NameInd	:=	'LOCATION';
																					self.NameType	:=	left.LocationType,
																					self.Name			:=	left.LocationName;
																				)
														);
		dCountry		:=	project(	pInput.CountryAkaList,
															transform(	GlobalWatchLists.Layouts.Base.rCountryName_Layout,
																					self.RecordID	:=	0;
																					self.NameInd	:=	'COUNTRY';
																					self.NameType	:=	left.CountryAKAType;
																					self.Name			:=	left.CountryAKAName;
																				)
														);
		self.CountryID			:=	pInput.recordid;
		self.WatchListName	:=	(string)pInput.WatchListName;
		self.WatchListDate	:=	(string)pInput.WatchListDate;
		self.DateListed			:=	(string)pInput.DateListed;
		self.CountryType		:=	(string)pInput.NameType;
		self.NameCount			:=	count(dLocations	+	dCountry);
		self.CountryNames		:=	project(	dLocations	+	dCountry,
																			transform(	GlobalWatchLists.Layouts.Base.rCountryName_Layout,
																									self.RecordID	:=	counter;
																									self					:=	left;
																								)
																		);
		self								:=	pInput;
	end;

	dCountry	:=	project(dCountryRecordID,tReformatCountry(left));

	ut.MAC_SF_BuildProcess(dCountry,'~thor_200::base::globalwatchlistsV2::country',buildCountryBase,,,true,pFileDate);
	
	// Build V2 base files
	bldV2BaseFiles	:=	parallel(buildEntityBase,buildCountryBase);
	
	// Build token files
	bldTokenFiles	:=	parallel(	GlobalWatchLists.Build_TokenFile_Address_V4(pFileDate),
															GlobalWatchLists.Build_TokenFile_Country_V4(pFileDate),
															GlobalWatchLists.Build_TokenFile_Name_V4(pFileDate)
														);
	
	return	sequential(bldV2BaseFiles,bldTokenFiles);
end;