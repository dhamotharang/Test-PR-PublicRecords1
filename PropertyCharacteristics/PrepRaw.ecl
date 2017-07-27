import	_control,Codes;

export PrepRaw(string	pFileDate,string	pProcessDate)	:=
module

	// Drop zip4 before passing to the AID macro so as to not introduce any new addresses to the cache due to zip4
	shared	fDropZip4	(string pLineLast) :=	regexreplace('(^| )([0-9]{5})[-]?[0-9]{4}($| .*)',pLineLast,'\\1\\2');
	
	// Generate prepped logical file name depending on source
	shared	fnPreppedLogicalFileName(string	pSource)	:=	'~thor_data400::in::propertybluebook::'	+	pSource	+	'::'	+	pFileDate;
	
	shared	unsigned	maxMLS1PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.MLS1,(unsigned)BBPropertyID[5..])				:	global;
	shared	unsigned	maxMLS2PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.MLS2,(unsigned)BBPropertyID[5..])				:	global;
	shared	unsigned	maxMLS3PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.MLS3,(unsigned)BBPropertyID[5..])				:	global;
	shared	unsigned	maxMLS4PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.MLS4,(unsigned)BBPropertyID[5..])				:	global;
	shared	unsigned	maxIns1PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.Insurance1,(unsigned)BBPropertyID[5..])	:	global;
	// shared	unsigned	maxIns2PropertyID	:=	max(PropertyCharacteristics.Files.Prepped.Insurance2,(unsigned)BBPropertyID[5..])	:	global;
	shared	unsigned	maxApprPropertyID	:=	max(PropertyCharacteristics.Files.Prepped.Appraiser,(unsigned)BBPropertyID[5..])	:	global;
	
	// Prep function for MLS1
	PropertyCharacteristics.Layout_In.MLS1_Prepped	tMLS1Prepped(PropertyCharacteristics.Layout_In.MLS1	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID				:=	'1MLS'	+	intformat(maxMLS1PropertyID+cnt,10,1);
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'MLS1';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('mls1');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.Address	+	' '	+	pInput.Address2));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(if(		pInput.City	!=	'',trim(pInput.City,left,right)	+	', ','')	
																																																					+	pInput.State
																																																					+	' '
																																																					+	fDropZip4(pInput.ZipCode)
																																																				),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self										:=	pInput;
	end;

	dMLS1Prepped	:=	project(PropertyCharacteristics.Files.Raw.MLS1,tMLS1Prepped(left,counter));

	// Slim the file to contain only the address info
	dMLS1PreppedSlim	:=	project(dMLS1Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dMLS1PreppedSlim,dMLS1PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.MLS1_Prepped	tMLS1ToPrepped(dMLS1Prepped	le,dMLS1PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dMLS1RawAID	:=	join(	dMLS1Prepped,
												dMLS1PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tMLS1ToPrepped(left,right),
												hash
											);
	
	outMLS1Prepped		:=	output(dMLS1RawAID,,'~thor_data400::in::propertybluebook::mls1::'	+	pFileDate,csv(separator('\t'),terminator('\n'),quote('')),__compressed__,overwrite);
	
	superMLS1Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls1::raw_delete','~thor_data400::in::propertybluebook::mls1::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls1::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls1','~thor_data400::in::propertybluebook::mls1::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls1::raw_delete',true)
																	);
	
	export	MLS1_Prepped	:=	sequential(outMLS1Prepped,superMLS1Prepped);
	
	// Prep function for MLS2
	PropertyCharacteristics.Layout_In.MLS2_Prepped	tMLS2Prepped(PropertyCharacteristics.Layout_In.MLS2	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID				:=	'2MLS'	+	intformat(maxMLS2PropertyID+cnt,10,1);
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'MLS2';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('mls2');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.Address	+	' '	+	pInput.Address2));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	pInput.City	!=	'',trim(pInput.City,left,right)	+	', ','')	
																																																				+	pInput.State
																																																				+	' '
																																																				+	fDropZip4(pInput.ZipCode)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self										:=	pInput;
	end;

	dMLS2Prepped	:=	project(PropertyCharacteristics.Files.Raw.MLS2,tMLS2Prepped(left,counter));
	
	// Slim the file to contain only the address info
	dMLS2PreppedSlim	:=	project(dMLS2Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dMLS2PreppedSlim,dMLS2PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.MLS2_Prepped	tMLS2ToPrepped(dMLS2Prepped	le,dMLS2PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dMLS2RawAID	:=	join(	dMLS2Prepped,
												dMLS2PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tMLS2ToPrepped(left,right),
												hash
											);

	outMLS2Prepped	:=	output(dMLS2RawAID,,'~thor_data400::in::propertybluebook::mls2::'	+	pFileDate,csv(separator('\t'),terminator('\n'),quote('')),__compressed__,overwrite);

	superMLS2Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls2::raw_delete','~thor_data400::in::propertybluebook::mls2::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls2::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls2','~thor_data400::in::propertybluebook::mls2::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls2::raw_delete',true)
																	);
	
	export	MLS2_Prepped	:=	sequential(outMLS2Prepped,superMLS2Prepped);

	// Prep function for MLS3
	PropertyCharacteristics.Layout_In.MLS3_Prepped	tMLS3Prepped(PropertyCharacteristics.Layout_In.MLS3	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID				:=	'3MLS'	+	intformat(maxMLS3PropertyID+cnt,10,1);
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'MLS3';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('mls3');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.StreetNumber	+	' '	+	pInput.StreetName));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	pInput.City	!=	'',trim(pInput.City,left,right)	+	', ','')	
																																																				+	pInput.State
																																																				+	' '
																																																				+	fDropZip4(pInput.Zip)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self										:=	pInput;
	end;
	
	dMLS3Prepped	:=	project(PropertyCharacteristics.Files.Raw.MLS3,tMLS3Prepped(left,counter));

	// Slim the file to contain only the address info
	dMLS3PreppedSlim	:=	project(dMLS3Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dMLS3PreppedSlim,dMLS3PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.MLS3_Prepped	tMLS3ToPrepped(dMLS3Prepped	le,dMLS3PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dMLS3RawAID	:=	join(	dMLS3Prepped,
												dMLS3PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tMLS3ToPrepped(left,right),
												hash
											);
	
	outMLS3Prepped	:=	output(dMLS3RawAID,,'~thor_data400::in::propertybluebook::mls3::'	+	pFileDate,csv(separator('\t'),terminator('\n'),quote('')),__compressed__,overwrite);
	
	superMLS3Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls3::raw_delete','~thor_data400::in::propertybluebook::mls3::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls3::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls3','~thor_data400::in::propertybluebook::mls3::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls3::raw_delete',true)
																	);
	
	export	MLS3_Prepped	:=	sequential(outMLS3Prepped,superMLS3Prepped);

	// Prep function for MLS4
	PropertyCharacteristics.Layout_In.MLS4_Prepped	tMLS4Prepped(PropertyCharacteristics.Layout_In.MLS4	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID				:=	'4MLS'	+	intformat(maxMLS4PropertyID+cnt,10,1);
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'MLS4';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('mls4');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pInput.Address	+	' '	+	pInput.Address2));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	pInput.City	!=	'',trim(pInput.City,left,right)	+	', ','')	
																																																				+	pInput.State
																																																				+	' '
																																																				+	fDropZip4(pInput.ZipCode)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self										:=	pInput;
	end;

	dMLS4Prepped	:=	project(PropertyCharacteristics.Files.Raw.MLS4,tMLS4Prepped(left,counter));

	// Slim the file to contain only the address info
	dMLS4PreppedSlim	:=	project(dMLS4Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dMLS4PreppedSlim,dMLS4PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.MLS4_Prepped	tMLS4ToPrepped(dMLS4Prepped	le,dMLS4PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dMLS4RawAID	:=	join(	dMLS4Prepped,
												dMLS4PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tMLS4ToPrepped(left,right),
												hash
											);

	outMLS4Prepped	:=	output(dMLS4RawAID,,'~thor_data400::in::propertybluebook::mls4::'	+	pFileDate,csv(separator('\t'),terminator('\n'),quote('')),__compressed__,overwrite);
	
	superMLS4Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls4::raw_delete','~thor_data400::in::propertybluebook::mls4::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls4::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::mls4','~thor_data400::in::propertybluebook::mls4::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::mls4::raw_delete',true)
																	);
	
	export	MLS4_Prepped	:=	sequential(outMLS4Prepped,superMLS4Prepped);

	// Prep function for INS1
	// Dedup the dataset by PolicyID
	dIns1RawDist	:=	distribute(PropertyCharacteristics.Files.Raw.Insurance1,(unsigned)PolicyID);
	dIns1RawDedup	:=	dedup(dIns1RawDist,PolicyID,all,local);
	
	// Reformat to prepped layout
	dIns1Format2Prepped	:=	project(	dIns1RawDedup,
																		transform(	PropertyCharacteristics.Layout_In.BlueBook_Prepped,
																								self.PolicyID	:=	(unsigned)left.PolicyID;
																								self					:=	left;
																								self					:=	[];
																							)
																	);
	
	// Denormalize property attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns1AttrDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped	le,
																																				PropertyCharacteristics.Layout_In.BB_Extract				ri
																																			)	:=
	transform
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'INS1';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('ins1');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(le.StreetName));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	le.City	!=	'',
																																																							trim(le.City,left,right)	+	', ',
																																																							''
																																																						)	
																																																				+	le.State
																																																				+	' '
																																																				+	fDropZip4(le.PostalCode)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self.ResidenceType			:=	if(ri.AttrSubtradeID	=	'1',ri.Value,le.ResidenceType);
		self.Stories						:=	if(ri.AttrSubtradeID	=	'2',ri.Value,le.Stories);
		self.LivingArea					:=	if(ri.AttrSubtradeID	=	'3',ri.Value,le.LivingArea);
		self.Bedrooms						:=	if(ri.AttrSubtradeID	=	'4',ri.Value,le.Bedrooms);
		self.TotalRooms					:=	if(ri.AttrSubtradeID	=	'5',ri.Value,le.TotalRooms);
		self.Baths							:=	if(ri.AttrSubtradeID	=	'6',ri.Value,le.Baths);
		self.Fireplaces					:=	if(ri.AttrSubtradeID	=	'7',ri.Value,le.Fireplaces);
		self.Pool								:=	if(	ri.AttrSubtradeID	=	'8',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.Pool
																	);
		self.AC									:=	if(	ri.AttrSubtradeID	=	'9',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.AC
																	);
		self.YearBuilt					:=	if(ri.AttrSubtradeID	=	'10',ri.Value,le.YearBuilt);
		self.Condition					:=	if(ri.AttrSubtradeID	=	'11',ri.Value,le.Condition);
		self.LotArea						:=	if(ri.AttrSubtradeID	=	'13',ri.Value,le.LotArea);
		self										:=	le;
		self										:=	[];
	end;

	dIns1AttrDenorm	:=	denormalize(	dIns1Format2Prepped,
																		dIns1RawDist((integer)TradeID	=	0),
																		left.PolicyID	=	(unsigned)right.PolicyID,
																		tIns1AttrDenorm(left,right),
																		local
																	);
	
	// Slim the dataset to contain only the structure attributes
	PropertyCharacteristics.Layout_In.StructureDetail	tStructureDetail(	PropertyCharacteristics.Layout_In.BB_Extract	pInput)	:=
	transform
		self.PolicyID	:=	(unsigned)pInput.PolicyID;
		self.Category	:=	PropertyCharacteristics.CodeTranslations.Trade2Category(pInput.TradeID);
		self.Material	:=	PropertyCharacteristics.CodeTranslations.IBDesc2Code(pInput.TradeID,pInput.Description)[1..3];
		self.Value		:=	(real)pInput.Value;
		self					:=	pInput;
		self					:=	[];
	end;
	
	dIns1StructureDetail	:=	project(dIns1RawDist((integer)TradeID	!=	0),tStructureDetail(left));
	
	// Structure details contains a lot of duplicates and hence, need to dedup
	dIns1StructureDetailDist	:=	distribute(dIns1StructureDetail,PolicyID);
	dIns1StructureDetailDedup	:=	dedup(dIns1StructureDetailDist,record,all,local);
	
	// Create a child dataset for the structure attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tStructureDetailDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped					le,
																																							dataset(PropertyCharacteristics.Layout_In.StructureDetail)	ri
																																						)	:=
	transform
		self.IBCodes	:=	ri;
		self					:=	le;
	end;
	
	dIns1StructureDetailDenorm	:=	denormalize(	dIns1AttrDenorm,
																								dIns1StructureDetailDedup,
																								left.PolicyID	=	(integer)right.PolicyID,
																								group,
																								tStructureDetailDenorm(left,rows(right)),
																								local
																							);
	
	// Append sequence number
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns1PropID(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID	:=	'1INS'	+	intformat(maxIns1PropertyID+cnt,10,1);
		self							:=	pInput;
	end;
	
	dIns1Prepped	:=	project(dIns1StructureDetailDenorm,tIns1PropID(left,counter));
	
	// Slim the file to contain only the address info
	dIns1PreppedSlim	:=	project(dIns1Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dIns1PreppedSlim,dIns1PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns1ToPrepped(dIns1Prepped	le,dIns1PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dIns1RawAID	:=	join(	dIns1Prepped,
												dIns1PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tIns1ToPrepped(left,right),
												hash
											);
	
	outIns1Prepped	:=	output(dIns1RawAID,,'~thor_data400::in::propertybluebook::ins1::'	+	pFileDate,/*csv(separator('\t'),terminator('\n'),quote('')),*/__compressed__,overwrite);
	
	superIns1Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::ins1::raw_delete','~thor_data400::in::propertybluebook::ins1::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::ins1::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::ins1','~thor_data400::in::propertybluebook::ins1::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::ins1::raw_delete',true)
																	);
	
	export	Ins1_Prepped	:=	sequential(outIns1Prepped,superIns1Prepped);

	/*
	// Prep function for INS2
	// Dedup the dataset by PolicyID
	dIns2RawDist	:=	distribute(PropertyCharacteristics.Files.Raw.Insurance2,(unsigned)PolicyID);
	dIns2RawDedup	:=	dedup(dIns2RawDist,PolicyID,all,local);
	
	// Reformat to prepped layout
	dIns2Format2Prepped	:=	project(	dIns2RawDedup,
																		transform(	PropertyCharacteristics.Layout_In.BlueBook_Prepped,
																								self.PolicyID	:=	(unsigned)left.PolicyID;
																								self					:=	left;
																								self					:=	[];
																							)
																	);
	
	// Denormalize property attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns2AttrDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped	le,
																																				PropertyCharacteristics.Layout_In.BB_Extract				ri
																																			)	:=
	transform
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'INS2';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('Ins2');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(le.StreetName));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	le.City	!=	'',
																																																							trim(le.City,left,right)	+	', ',
																																																							''
																																																						)	
																																																				+	le.State
																																																				+	' '
																																																				+	fDropZip4(le.PostalCode)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self.ResidenceType			:=	if(ri.AttrSubtradeID	=	'1',ri.Value,le.ResidenceType);
		self.Stories						:=	if(ri.AttrSubtradeID	=	'2',ri.Value,le.Stories);
		self.LivingArea					:=	if(ri.AttrSubtradeID	=	'3',ri.Value,le.LivingArea);
		self.Bedrooms						:=	if(ri.AttrSubtradeID	=	'4',ri.Value,le.Bedrooms);
		self.TotalRooms					:=	if(ri.AttrSubtradeID	=	'5',ri.Value,le.TotalRooms);
		self.Baths							:=	if(ri.AttrSubtradeID	=	'6',ri.Value,le.Baths);
		self.Fireplaces					:=	if(ri.AttrSubtradeID	=	'7',ri.Value,le.Fireplaces);
		self.Pool								:=	if(	ri.AttrSubtradeID	=	'8',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.Pool
																	);
		self.AC									:=	if(	ri.AttrSubtradeID	=	'9',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.AC
																	);
		self.YearBuilt					:=	if(ri.AttrSubtradeID	=	'10',ri.Value,le.YearBuilt);
		self.Condition					:=	if(ri.AttrSubtradeID	=	'11',ri.Value,le.Condition);
		self.LotArea						:=	if(ri.AttrSubtradeID	=	'13',ri.Value,le.LotArea);
		self										:=	le;
		self										:=	[];
	end;

	dIns2AttrDenorm	:=	denormalize(	dIns2Format2Prepped,
																		dIns2RawDist((integer)TradeID	=	0),
																		left.PolicyID	=	(unsigned)right.PolicyID,
																		tIns2AttrDenorm(left,right),
																		local
																	);
	
	// Slim the dataset to contain only the structure attributes
	PropertyCharacteristics.Layout_In.StructureDetail	tStructureDetail(	PropertyCharacteristics.Layout_In.BB_Extract	pInput)	:=
	transform
		self.PolicyID	:=	(unsigned)pInput.PolicyID;
		self.Category	:=	PropertyCharacteristics.CodeTranslations.Trade2Category(pInput.TradeID);
		self.Material	:=	PropertyCharacteristics.CodeTranslations.IBDesc2Code(pInput.TradeID,pInput.Description)[1..3];
		self.Value		:=	(real)pInput.Value;
		self					:=	pInput;
		self					:=	[];
	end;
	
	dIns2StructureDetail	:=	project(dIns2RawDist((integer)TradeID	!=	0),tStructureDetail(left));
		
	// Structure details contains a lot of duplicates and hence, need to dedup
	dIns2StructureDetailDist	:=	distribute(dIns2StructureDetail,PolicyID);
	dIns2StructureDetailDedup	:=	dedup(dIns2StructureDetailDist,record,all,local);
	
	// Create a child dataset for the structure attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tStructureDetailDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped					le,
																																							dataset(PropertyCharacteristics.Layout_In.StructureDetail)	ri
																																						)	:=
	transform
		self.IBCodes	:=	ri;
		self					:=	le;
	end;
	
	dIns2StructureDetailDenorm	:=	denormalize(	dIns2AttrDenorm,
																								dIns2StructureDetailDedup,
																								left.PolicyID	=	(integer)right.PolicyID,
																								group,
																								tStructureDetailDenorm(left,rows(right)),
																								local
																							);
	
	// Append sequence number
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns2PropID(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID	:=	'1INS'	+	intformat(maxIns2PropertyID+cnt,10,1);
		self							:=	pInput;
	end;
	
	dIns2Prepped	:=	project(dIns2StructureDetailDenorm,tIns2PropID(left,counter));
	
	// Slim the file to contain only the address info
	dIns2PreppedSlim	:=	project(dIns2Prepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dIns2PreppedSlim,dIns2PreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tIns2ToPrepped(dIns2Prepped	le,dIns2PreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dIns2RawAID	:=	join(	dIns2Prepped,
												dIns2PreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tIns2ToPrepped(left,right),
												hash
											);
	
	outIns2Prepped	:=	output(dIns2RawAID,,'~thor_data400::in::propertybluebook::Ins2::'	+	pFileDate,__compressed__,overwrite);
	
	superIns2Prepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::Ins2::raw_delete','~thor_data400::in::propertybluebook::Ins2::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::Ins2::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::Ins2','~thor_data400::in::propertybluebook::Ins2::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::Ins2::raw_delete',true)
																	);
	
	export	Ins2_Prepped	:=	sequential(outIns2Prepped,superIns2Prepped);
	*/
	
	// Prep function for APPRAISER
	// Dedup the dataset by PolicyID
	dApprRawDist	:=	distribute(PropertyCharacteristics.Files.Raw.Appraiser,(unsigned)PolicyID);
	dApprRawDedup	:=	dedup(dApprRawDist,PolicyID,all,local);
	
	// Reformat to prepped layout
	dApprFormat2Prepped	:=	project(	dApprRawDedup,
																		transform(	PropertyCharacteristics.Layout_In.BlueBook_Prepped,
																								self.PolicyID	:=	(unsigned)left.PolicyID;
																								self					:=	left;
																								self					:=	[];
																							)
																	);
	
	// Denormalize property attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tApprAttrDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped	le,
																																				PropertyCharacteristics.Layout_In.BB_Extract				ri
																																			)	:=
	transform
		self.ProcessDate				:=	pProcessDate;
		self.VendorSource				:=	'Appr';
		self.PreppedLogicalName	:=	fnPreppedLogicalFileName('Appr');
		self.Append_PrepAddr1		:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(le.StreetName));
		self.Append_PrepAddr2		:=	stringlib.stringtouppercase(regexreplace(	'[,]$',
																																					stringlib.stringcleanspaces(		if(	le.City	!=	'',
																																																							trim(le.City,left,right)	+	', ',
																																																							''
																																																						)	
																																																				+	le.State
																																																				+	' '
																																																				+	fDropZip4(le.PostalCode)
																																																			),
																																					''
																																				)
																														);
		self.Append_RawAID			:=	0;
		self.ResidenceType			:=	if(ri.AttrSubtradeID	=	'1',ri.Value,le.ResidenceType);
		self.Stories						:=	if(ri.AttrSubtradeID	=	'2',ri.Value,le.Stories);
		self.LivingArea					:=	if(ri.AttrSubtradeID	=	'3',ri.Value,le.LivingArea);
		self.Bedrooms						:=	if(ri.AttrSubtradeID	=	'4',ri.Value,le.Bedrooms);
		self.TotalRooms					:=	if(ri.AttrSubtradeID	=	'5',ri.Value,le.TotalRooms);
		self.Baths							:=	if(ri.AttrSubtradeID	=	'6',ri.Value,le.Baths);
		self.Fireplaces					:=	if(ri.AttrSubtradeID	=	'7',ri.Value,le.Fireplaces);
		self.Pool								:=	if(	ri.AttrSubtradeID	=	'8',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.Pool
																	);
		self.AC									:=	if(	ri.AttrSubtradeID	=	'9',
																		if((integer)ri.Value	=	0,'N','Y'),
																		le.AC
																	);
		self.YearBuilt					:=	if(ri.AttrSubtradeID	=	'10',ri.Value,le.YearBuilt);
		self.Condition					:=	if(ri.AttrSubtradeID	=	'11',ri.Value,le.Condition);
		self.LotArea						:=	if(ri.AttrSubtradeID	=	'13',ri.Value,le.LotArea);
		self										:=	le;
		self										:=	[];
	end;

	dApprAttrDenorm	:=	denormalize(	dApprFormat2Prepped,
																		dApprRawDist((integer)TradeID	=	0),
																		left.PolicyID	=	(unsigned)right.PolicyID,
																		tApprAttrDenorm(left,right),
																		local
																	);
	
	// Slim the dataset to contain only the structure attributes
	PropertyCharacteristics.Layout_In.StructureDetail	tStructureDetail(	PropertyCharacteristics.Layout_In.BB_Extract	pInput)	:=
	transform
		self.PolicyID	:=	(unsigned)pInput.PolicyID;
		self.Category	:=	PropertyCharacteristics.CodeTranslations.Trade2Category(pInput.TradeID);
		self.Material	:=	PropertyCharacteristics.CodeTranslations.IBDesc2Code(pInput.TradeID,pInput.Description)[1..3];
		self.Value		:=	(real)pInput.Value;
		self					:=	pInput;
		self					:=	[];
	end;
	
	dApprStructureDetail	:=	project(dApprRawDist((integer)TradeID	!=	0),tStructureDetail(left));
		
	// Structure details contains a lot of duplicates and hence, need to dedup
	dApprStructureDetailDist	:=	distribute(dApprStructureDetail,PolicyID);
	dApprStructureDetailDedup	:=	dedup(dApprStructureDetailDist,record,all,local);
	
	// Create a child dataset for the structure attributes
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tStructureDetailDenorm(	PropertyCharacteristics.Layout_In.BlueBook_Prepped					le,
																																							dataset(PropertyCharacteristics.Layout_In.StructureDetail)	ri
																																						)	:=
	transform
		self.IBCodes	:=	ri;
		self					:=	le;
	end;
	
	dApprStructureDetailDenorm	:=	denormalize(	dApprAttrDenorm,
																								dApprStructureDetailDedup,
																								left.PolicyID	=	(integer)right.PolicyID,
																								group,
																								tStructureDetailDenorm(left,rows(right)),
																								local
																							);
	
	// Append sequence number
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tApprPropID(PropertyCharacteristics.Layout_In.BlueBook_Prepped	pInput,integer	cnt)	:=
	transform
		self.BBPropertyID	:=	'1INS'	+	intformat(maxApprPropertyID+cnt,10,1);
		self							:=	pInput;
	end;
	
	dApprPrepped	:=	project(dApprStructureDetailDenorm,tApprPropID(left,counter));
	
	// Slim the file to contain only the address info
	dApprPreppedSlim	:=	project(dApprPrepped,PropertyCharacteristics.Layout_In.BB_RawAddress_Slim);
	
	// Pass to the AID macro and get the Raw AID
	PropertyCharacteristics.Mac_Append_RawAID(dApprPreppedSlim,dApprPreppedAID);
	
	// Join back to the orig file
	PropertyCharacteristics.Layout_In.BlueBook_Prepped	tApprToPrepped(dApprPrepped	le,dApprPreppedAID	ri)	:=
	transform
		self.Append_RawAID	:=	ri.Append_RawAID;
		self								:=	le;
	end;
	
	dApprRawAID	:=	join(	dApprPrepped,
												dApprPreppedAID,
												left.BBPropertyID	=	right.BBPropertyID,
												tApprToPrepped(left,right),
												hash
											);
	
	outApprPrepped	:=	output(dApprRawAID,,'~thor_data400::in::propertybluebook::Appr::'	+	pFileDate,/*csv(separator('\t'),terminator('\n'),quote('')),*/__compressed__,overwrite);
	
	superApprPrepped	:=	sequential(	fileservices.startsuperfiletransaction(),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::Appr::raw_delete','~thor_data400::in::propertybluebook::Appr::raw',,true),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::Appr::raw'),
																		fileservices.addsuperfile('~thor_data400::in::propertybluebook::Appr','~thor_data400::in::propertybluebook::Appr::'	+	pFileDate),
																		fileservices.finishsuperfiletransaction(),
																		fileservices.clearsuperfile('~thor_data400::in::propertybluebook::Appr::raw_delete',true)
																	);
	
	export	Appr_Prepped	:=	sequential(outApprPrepped,superApprPrepped);

end;