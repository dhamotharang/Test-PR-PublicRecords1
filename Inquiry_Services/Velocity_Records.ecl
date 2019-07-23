import	Address, AutoHeaderI, AutoStandardI, iesp, doxie, inquiry_acclogs, ut, Suppress, Gateway;

export	Velocity_Records(	iesp.searchalert.t_SearchAlertSearchBy			pReqSearchBy,
													iesp.searchalert.t_SearchAlertOptions				pOptions,
													DATASET(Gateway.Layouts.Config) dGateways
												)	:=
function
	string14	vDID				:=	pReqSearchBy.uniqueid	:	stored('UniqueID');

	// Customer sent DID takes preference over the header library searched DID
	unsigned6	vCleanDID		:=	if(	stringlib.stringfilterout(vDID,'0123456789')	=	''	and	(unsigned)vDID	!=	0,
																(unsigned6)vDID,
																0
															);

	// Get search parameters from global #stored variables
  gm := AutoStandardI.GlobalModule();
  mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(gm);
	searchMod	:=	module(project(gm, AutoHeaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
	end;

	// Search DIDs from standard header library
	dSearchDIDs	:=	AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(searchMod);

	// Temporary module with fields needed to search
	string ret_date:= iesp.ECL2ESP.t_DateToString8(pReqSearchBy.RetroDate)	:	stored('RetroDate');
  tmpMod	:=
  module(project(searchMod,Inquiry_Services.Velocity_IParam.SearchRecords,opt))
		export	UniqueID					:=	if(	vCleanDID	!=	0,
																			vCleanDID,
																			dSearchDIDs[1].did
																		);
		export	Industry					:=	ut.fnTrim2Upper(pReqSearchBy.Industry)								:	stored('Industry');
		export	Product						:=	ut.fnTrim2Upper(pReqSearchBy.Product)									:	stored('Product');
		export	RetroDate					:=	ret_date;
    export	DateRange					:=	pReqSearchBy.daterange																:	stored('DateRange');
    export	IndustryKBA				:=	pOptions.industrykba																	:	stored('IndustryKBA');
		export	EDataVelocity			:=	pOptions.Velocity																			:	stored('Velocity');
		// export	GatewayURL				:=	if(	~pOptions.Velocity,
																			// dGateways(ut.fnTrim2Upper(servicename)='SP_SEARCHALERTID')[1].URL,
																			// dGateways(ut.fnTrim2Upper(servicename)='SP_SEARCHIDENTITYVELOCITYID')[1].URL
																		// );
		export	DATASET (Gateway.Layouts.Config) Gateway_cfg				:=	dGateways;
  end;

	// Name, street address and city state zip calculated from the components
	string	vUnparsedFullName	:=	if(	pReqSearchBy.Name.Full	=	'',
																		Address.NameFromComponents(	pReqSearchBy.Name.First,
																																pReqSearchBy.Name.Middle,
																																pReqSearchBy.Name.Last,
																																pReqSearchBy.Name.Suffix
																															),
																		pReqSearchBy.Name.Full
																	);

	string	vStateCityZip			:=	if(	pReqSearchBy.Address.StateCityZip	=	'',
																		Address.Addr2FromComponents(pReqSearchBy.Address.City,pReqSearchBy.Address.State,pReqSearchBy.Address.Zip5),
																		pReqSearchBy.Address.StateCityZip
																	);

	string	vAddr							:=	if(	pReqSearchBy.Address.StreetAddress1	=	'',
																		Address.Addr1FromComponents(	pReqSearchBy.Address.StreetNumber,pReqSearchBy.Address.StreetPreDirection,
																																	pReqSearchBy.Address.StreetName,pReqSearchBy.Address.StreetSuffix,
																																	pReqSearchBy.Address.StreetPostDirection,
																																	pReqSearchBy.Address.UnitDesignation,pReqSearchBy.Address.UnitNumber
																																),
																		stringlib.stringcleanspaces(pReqSearchBy.Address.StreetAddress1	+	pReqSearchBy.Address.StreetAddress2)
																	);

	// Boolean values to check whether name, address, ssn, did are populated
	boolean	isNamePopulated	:=	vUnparsedFullName	!=	'';
	boolean	isAddrPopulated	:=	vAddr	!=	''	and	vStateCityZip		!=	'';
	boolean	isSSNPopulated	:=	(unsigned)pReqSearchBy.SSN	!=	0;
	boolean	isDIDPopulated	:=	tmpMod.UniqueID	!=	0;

	boolean isInsufficientInput	:=	~isDIDPopulated	and	~isSSNPopulated	and	~(isNamePopulated	and	isAddrPopulated);
	boolean	isIdentityNotFound	:=	~isDIDPopulated;

	// Dummy transform to create dataset for sybase gateway call
	inquiry_services.velocity_layouts.r_uniqueid x0() := transform
		self.uniqueid := tmpMod.uniqueid;
	end;

	sybase_input:= dataset([x0()]);

	// Hit gateway if retro date isn't supplied or less than 72 hours
	blnHitGateway	:=	map(	tmpMod.uniqueid	=	0																													=>	false,
													tmpMod.RetroDate	=	''	or	ut.DaysApart(ut.GetDate,tmpMod.RetroDate)	<=	3	=>	true,
													false
												);

	// Gateway - Sybase records
	dInquirySybaseRecs	:=	if(	blnHitGateway,
															choosen(	sort(	inquiry_services.velocity_soapcall(sybase_input,tmpMod),
																							-search_date
																						),
																				inquiry_services.velocity_constants.did_record_limit
																			),
															dataset([],Inquiry_Services.Velocity_Layouts.Gateway.Out)
														);

	// Apply the rec_use filter - use only blank values
	sybase_recs_raw	:=	if(	~tmpMod.EDataVelocity,
													dInquirySybaseRecs,
													dInquirySybaseRecs(rec_use	=	'')
												);

	// Inquiry account logs info from THOR
	dInquiryDailyRecs		:=	if(	tmpMod.uniqueid	in	Inquiry_Services.Velocity_Constants.FAKE_DIDS,
															choosen(sort(	Inquiry_AccLogs.Key_Inquiry_DID_Update(keyed(s_did	=	tmpMod.uniqueid)),-search_info.datetime),inquiry_services.velocity_constants.did_record_limit),
															sort(Inquiry_AccLogs.Key_Inquiry_DID_Update(keyed(s_did	=	tmpMod.uniqueid)),-search_info.datetime)
														);

	dInquiryWeeklyRecs	:=	if(	tmpMod.uniqueid	in	Inquiry_Services.Velocity_Constants.FAKE_DIDS,
															choosen(sort(Inquiry_AccLogs.Key_Inquiry_DID(keyed(s_did	=	tmpMod.uniqueid)),-search_info.datetime),inquiry_services.velocity_constants.did_record_limit),
															sort(Inquiry_AccLogs.Key_Inquiry_DID(keyed(s_did	=	tmpMod.uniqueid)),-search_info.datetime)
														);

	// Combine the daily and weekly inquiry data and dedup duplicate information
	dInquiryRecsCombined			:=	dInquiryDailyRecs & dInquiryWeeklyRecs;
	dInquiryRecsCombinedDedup	:=	dedup(	dInquiryRecsCombined,
																				search_info.transaction_id,
																				search_info.sequence_number,
																				search_info.datetime,
																				search_info.sequence_number,
																				search_info.transaction_type,
																				search_info.function_description,
																				all
																			);

	thor_recs_raw	:=	if(	~tmpMod.EDataVelocity,
												dInquiryRecsCombinedDedup,
												dInquiryRecsCombinedDedup(bus_intel.use	=	'')
											);

	// Combine both the thor and gateway records
	inquiry_recs	:=	Inquiry_Services.Velocity_Functions(tmpMod).fnCombineRecords(thor_recs_raw,sybase_recs_raw);
  inquiry_recs_suppressed := Suppress.MAC_SuppressSource(inquiry_recs, mod_access, s_did, ccpa.global_sid);
	// Calculate funtion/industry counts and search date counts
	recs_rold	:=	if(	~tmpMod.EDataVelocity,
										choosen(Inquiry_Services.Velocity_Functions(tmpMod).fnFunctionNameCounts(inquiry_recs_suppressed),iesp.constants.VC.MAX_SEARCH_ALERT_RECS),
										Inquiry_Services.Velocity_Functions(tmpMod).fnIndustryCounts(inquiry_recs_suppressed)
									);

	// Populate header and counts section and bring to iesp out layout
	iesp.searchalert.t_SearchAlertResponse	marshall()	:=
	transform
		self._Header			:=	iesp.ECL2ESP.GetHeaderRow();
		self.InputEcho		:=	pReqSearchBy;
		self.RecordCount	:=	count(recs_rold);
		self.Records			:=	recs_rold;
		self							:=	[];
	end;

	// Set error messages in the header section
	iesp.searchalert.t_SearchAlertResponse	tErrors()	:=
	transform
		string	vQueryID	:=	''	:	stored('_QueryId');
		string	vTransID	:=	''	:	stored('_TransactionId');
		integer	vStatus		:=	map(	isInsufficientInput	=>	301,
																isIdentityNotFound	=>	9,
																0
															);
		string	vMessage	:=	map(	isInsufficientInput	=>	stringlib.stringtouppercase(Doxie.ErrorCodes(301)),
																isIdentityNotFound	=>	'NO IDENTITIES FOUND',
																''
															);

		GetHeaderRow()		:=	row({vStatus,vMessage,vQueryID,vTransID,[]},iesp.share.t_ResponseHeader);

		self._Header			:=	GetHeaderRow();
		self.InputEcho		:=	pReqSearchBy;
		self							:=	[];
	end;

/*
	// output statements for debugging
	output(tmpMod);
	output(thor_recs_raw,named('thor_recs_raw'));
	output(sybase_recs_raw,named('sybase_recs_raw'));
	output(inquiry_recs,named('inquiry_recs'));
	output(inquiry_recs_suppressed,named('inquiry_recs_suppressed'));
	output(recs_rold,named('recs_rold'));
*/

  return	if(	tmpMod.EDataVelocity	and	(isInsufficientInput	or	isIdentityNotFound),
							dataset([tErrors()]),
							dataset([marshall()])
						);
end;