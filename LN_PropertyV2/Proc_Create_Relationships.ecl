import	lib_fileservices,dops;

export	Proc_Create_Relationships(string	pVersionDate)	:=
function

	LNPropertyV2Cluster	:=	'~thor_data400::key::ln_propertyv2::';
	
	// Get list of all logical keys for NonFCRA and FCRA property keys
	dNonFCRAKeys	:=	dops.GetRoxieKeys('LNPropertyV2Keys','B','N','N');
	dFCRAKeys			:=	dops.GetRoxieKeys('FCRA_LNPropertyV2Keys','B','F','N');
	
	rLogicalName_layout	:=
	record
		lib_fileservices.FsLogicalFileNameRecord;
	end;
	
	// Combine the FCRA and Non FCRA key list datasts
	dAllKeys	:=	dNonFCRAKeys	+	dFCRAKeys;
	
	// Get only the logical key names
	dLogicalKeys	:=	project(	dAllKeys,
															transform(	rLogicalName_layout,
																					self.name	:=	'~'	+	regexreplace('(LNPropertyV2Keys_DATE|FCRA_LNPropertyV2Keys_DATE)',stringlib.stringcleanspaces(left.logicalkey),pVersionDate)
																				)
														);
	
	// Create column mapping for dph_lname
	colMapAutokeyName	:=	FileServices.setcolumnmapping(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::name',
																												'dph_lname{set(metaphonelib.DMetaPhone1),displayname(dph_lname)}'
																											);
	
	// Create relationships for autokeys
	AddrB2_2_Payload				:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::addressb2',
																																'fakeid','bdid','link','1:M',true
																															);

	Addr_2_Payload					:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::address',
																																'fakeid','did','link','1:M',true
																															);

	CityStNameB2_2_Payload	:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::citystnameb2',
																																'fakeid','bdid','link','1:M',true
																															);

	CityStName_2_Payload		:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::citystname',
																																'fakeid','did','link','1:M',true
																															);

	Fein2_2_Payload					:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::fein2',
																																'fakeid','bdid','link','1:M',true
																															);

	NameB2_2_Payload				:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::nameb2',
																																'fakeid','bdid','link','1:M',true
																															);

	NameWords2_2_Payload		:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::namewords2',
																																'fakeid','bdid','link','1:M',true
																															);

	Name_2_Payload					:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::name',
																																'fakeid','did','link','1:M',true
																															);

	Phone2_2_Payload				:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::phone2',
																																'fakeid','did','link','1:M',true
																															);

	PhoneB2_2_Payload				:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::phoneb2',
																																'fakeid','bdid','link','1:M',true
																															);

	SSN2_2_Payload					:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::ssn2',
																																'fakeid','did','link','1:M',true
																															);

	StNameB2_2_Payload			:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::stnameb2',
																																'fakeid','bdid','link','1:M',true
																															);

	StName_2_Payload				:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::stname',
																																'fakeid','did','link','1:M',true
																															);

	ZipB2_2_Payload					:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::zipb2',
																																'fakeid','bdid','link','1:M',true
																															);

	Zip_2_Payload						:= FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::payload',
																																LNPropertyV2Cluster	+	pVersionDate	+	'::autokey::zip',
																																'fakeid','did','link','1:M',true
																															);

	AutoKeyRelationships	:=	sequential(	colMapAutokeyName,
																				parallel(	AddrB2_2_Payload,Addr_2_Payload,CityStNameB2_2_Payload,CityStName_2_Payload,
																									Fein2_2_Payload,NameB2_2_Payload,NameWords2_2_Payload,Name_2_Payload,
																									Phone2_2_Payload,PhoneB2_2_Payload,SSN2_2_Payload,StNameB2_2_Payload,
																									StName_2_Payload,ZipB2_2_Payload,Zip_2_Payload
																								)
																			);

	// Create relationships for Non-FCRA keys
	AddlDeedFID_2_DeedPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addlfaresdeed.fid',
																																				'ln_fares_id','ln_fares_id','link','1:1',true
																																			);

	AddlTaxFID_2_TaxPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addlfarestax.fid',
																																				'ln_fares_id','ln_fares_id','link','1:1',true
																																			);

	AddlLegalFID_2_DeedPayload			:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addllegal.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AddlLegalFID_2_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addllegal.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AddlNamesFID_2_DeedPayload			:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addlnames.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);
																																			
	AddlNamesFID_2_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addlnames.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AddrSearchFID_SearchPayload			:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addr_search.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AddrSearchFID_DeedPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addr_search.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AddrSearchFID_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::addr_search.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	AssessorAPN_2_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.parcelnum',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	DeedAPN_2_DeedPayload						:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::deed.parcelnum',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	DeedZipLoanAmt_2_DeedPayload		:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::deed.zip_loanamt',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchBDID_2_DeedPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.bdid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchBDID_2_TaxPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.bdid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchDID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.did',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchDID_2_TaxPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.did',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchDID_2_SearchPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.did',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchFID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchFID_2_TaxPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchFIDCounty_2_DeedPayload		:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::deed.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid_county',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchFIDCounty_2_TaxPayload		:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::assessor.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid_county',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	SearchFIDCounty_2_SearchPayload	:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid',
																																				LNPropertyV2Cluster	+	pVersionDate	+	'::search.fid_county',
																																				'ln_fares_id','ln_fares_id','link','1:M',true
																																			);

	nonFCRARelationships	:=	parallel(	AddlDeedFID_2_DeedPayload,AddlTaxFID_2_TaxPayload,AddlLegalFID_2_DeedPayload,
																			AddlLegalFID_2_TaxPayload,AddlNamesFID_2_DeedPayload,AddlNamesFID_2_TaxPayload,
																			AddrSearchFID_SearchPayload,AddrSearchFID_DeedPayload,AddrSearchFID_TaxPayload,
																			AssessorAPN_2_TaxPayload,DeedAPN_2_DeedPayload,DeedZipLoanAmt_2_DeedPayload,
																			SearchBDID_2_DeedPayload,SearchBDID_2_TaxPayload,SearchDID_2_DeedPayload,
																			SearchDID_2_TaxPayload,SearchDID_2_SearchPayload,SearchFID_2_DeedPayload,
																			SearchFID_2_TaxPayload,SearchFIDCounty_2_DeedPayload,SearchFIDCounty_2_TaxPayload,
																			SearchFIDCounty_2_SearchPayload
																		);
	
	// Create relationships for FCRA keys
	FCRA_AddlNamesFID_2_DeedPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::addlnames.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_AddlNamesFID_2_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::addlnames.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_AddrSearchFID_2_DeedPayload			:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::addr_search.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_AddrSearchFID_2_TaxPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::addr_search.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_AddrSearchFID_2_SearchPayload		:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::addr_search.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchBDID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::bdid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchBDID_2_TaxPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::bdid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_DeedV2FID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deedv2.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchFID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchFID_2_TaxPayload						:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchFIDCounty_2_DeedPayload		:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid_county',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchFIDCounty_2_TaxPayload			:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid_county',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchFIDCounty_2_SearchPayload	:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid_county',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchDID_2_DeedPayload					:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::deed.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.did',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchDID_2_TaxPayload						:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::assessor.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.did',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRA_SearchDID_2_SearchPayload				:=	FileServices.AddFileRelationship(	LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.fid',
																																							LNPropertyV2Cluster	+	'fcra::'	+	pVersionDate	+	'::search.did',
																																							'ln_fares_id','ln_fares_id','link','1:M',true
																																						);

	FCRARelationships	:=	parallel(	FCRA_AddlNamesFID_2_DeedPayload,FCRA_AddlNamesFID_2_TaxPayload,FCRA_AddrSearchFID_2_DeedPayload,
																	FCRA_AddrSearchFID_2_TaxPayload,FCRA_AddrSearchFID_2_SearchPayload,/*FCRA_SearchBDID_2_DeedPayload,
																	FCRA_SearchBDID_2_TaxPayload,FCRA_DeedV2FID_2_DeedPayload,*/FCRA_SearchFID_2_DeedPayload,
																	FCRA_SearchFID_2_TaxPayload,FCRA_SearchFIDCounty_2_DeedPayload,FCRA_SearchFIDCounty_2_TaxPayload,
																	FCRA_SearchFIDCounty_2_SearchPayload,FCRA_SearchDID_2_DeedPayload,FCRA_SearchDID_2_TaxPayload,
																	FCRA_SearchDID_2_SearchPayload
																);
	
	outMissingKeys	:=	output(FileExists.MissingKeyList(dLogicalKeys),named('MissingKeys'));
	
	return	if(	FileExists.CheckFileExists(dLogicalKeys),
							parallel(AutoKeyRelationships,nonFCRARelationships,FCRARelationships,outMissingKeys),
							FileServices.SendEmail(	'kgummadi@seisint.com',
																			'LNProperty Add Key Relationship Failed: '	+	pVersionDate,
																			'The missing indexes are listed in the workunit: ' + thorlib.wuid()
																		)
						);
end;