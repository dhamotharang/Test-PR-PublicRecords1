import address,did_add,didville,entiera,header_slimsort,ut;

dEntiera		:=	entiera.File_Entiera_Base(orig_email != '');
dConsumerIn	:=	dataset	(	ut.foreign_prod+'~thor_data400::in::fds_test::20091130::assets::search',
													fds_test.Layout_Consumer.Input.rConsumerIn_layout,
													CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']))
												);

rConsumerClean_layout	:=
record
	dConsumerIn;
	address.Layout_Clean182_fips;
	address.Layout_Clean_Name;
	unsigned6	did				:=	0;
	unsigned2	did_score	:=	0;
end;

rConsumerClean_layout	tConsumerCleanNameAddr(dConsumerIn pInput)	:=
transform
	clean_address			:=	address.CleanAddressParsed(	trim(pInput.address,left,right)						+
																											' '																				+
																											trim(pInput.secondary_address,left,right)	,
																											trim(pInput.city,left,right) 							+
																											' '																				+
																											trim(pInput.state,left,right)							+
																											' '																				+
																											trim(pInput.zip_code,left,right)
																									);

	clean_name				:=	address.CleanPersonFML73_fields(trim(pInput.Name,left,right));
	
	self.prim_range		:=  clean_address.prim_range;
	self.predir				:= 	clean_address.predir;
	self.prim_name		:= 	clean_address.prim_name;
	self.addr_suffix	:=  clean_address.addr_suffix;
	self.postdir			:= 	clean_address.postdir;
	self.unit_desig		:= 	clean_address.unit_desig;
	self.sec_range		:= 	clean_address.sec_range;
	self.p_city_name	:= 	clean_address.p_city_name;
	self.v_city_name	:=  clean_address.v_city_name;
	self.st						:= 	clean_address.st;
	self.zip					:= 	clean_address.zip;
	self.zip4					:= 	clean_address.zip4;
	self.cart					:= 	clean_address.cart;
	self.cr_sort_sz		:= 	clean_address.cr_sort_sz;
	self.lot					:= 	clean_address.lot;
	self.lot_order		:= 	clean_address.lot_order;
	self.dbpc					:= 	clean_address.dbpc;
	self.chk_digit		:= 	clean_address.chk_digit;
	self.rec_type			:= 	clean_address.rec_type;
	self.fips_state		:= 	clean_address.fips_state;
	self.fips_county	:= 	clean_address.fips_county;
	self.geo_lat			:= 	clean_address.geo_lat;
	self.geo_long			:= 	clean_address.geo_long;
	self.msa					:= 	clean_address.msa;
	self.geo_blk			:= 	clean_address.geo_blk;
	self.geo_match		:= 	clean_address.geo_match;
	self.err_stat			:=	clean_address.err_stat;
	
	self.title				:=	clean_name.title;
	self.fname				:=	clean_name.fname;
	self.mname				:=	clean_name.mname;
	self.lname				:=	clean_name.lname;
	self.name_suffix	:=	clean_name.name_suffix;
	self.name_score		:=	clean_name.name_score;
	
	self							:=	pInput;
end;

dConsumerCleanNameAddr	:=	project(dConsumerIn,tConsumerCleanNameAddr(left));

boolean	pSSNSearch						:=			regexfind('^[0-9]{9}$',dConsumerCleanNameAddr.SSN)
																	and	dConsumerCleanNameAddr.SSN																not in	['111111111','999999999'];

boolean	pNamePartialSSNSearch	:=			dConsumerCleanNameAddr.SSN 																!=	''
																	and	length(regexfind('[0-9]+',dConsumerCleanNameAddr.SSN,0))	!=	9
																	and	dConsumerCleanNameAddr.Name																!=	'';

boolean	pNameAddrSearch				:=			dConsumerCleanNameAddr.Name																!=	''
																	and	dConsumerCleanNameAddr.Address														!=	'';


boolean	pAddrSearch						:=			dConsumerCleanNameAddr.Address														!=	''
																	and	dConsumerCleanNameAddr.Name																=		''
																	and	dConsumerCleanNameAddr.Business_Name											=		'';

boolean	pNameStSearch					:=			dConsumerCleanNameAddr.Name																!=	''
																	and	dConsumerCleanNameAddr.State															!=	''
																	and	dConsumerCleanNameAddr.Address														=		'';

boolean	pNameZipSearch				:=			dConsumerCleanNameAddr.Name																!=	''
																	and	dConsumerCleanNameAddr.Zip_code														!=	''
																	and	dConsumerCleanNameAddr.Address														=		'';

// Get all the records where the search conditions are not met
dConsumerNoSearch	:=	dConsumerCleanNameAddr(	~(			pSSNSearch
																									or	pNamePartialSSNSearch
																									or	pNameAddrSearch
																									or	pAddrSearch
																									or	pNameStSearch
																									or	pNameZipSearch
																								)
																				);

// Common layout for search outputs
rConsumerMatch_layout	:=
record
	recordof(dConsumerCleanNameAddr)	ConsumerSearch;
	recordof(dEntiera)								EmailSearchResults;
	string1														MatchIndicator	:=	'';
end;

// Common transform being used for all the searches
rConsumerMatch_layout	tGetMatches(dEntiera le, dConsumerCleanNameAddr ri)	:=
transform
	self.EmailSearchResults	:=	le;
	self.ConsumerSearch			:=	ri;
end;

rConsumerMatch_layout	fnDedup(dataset(rConsumerMatch_layout)	pConsumerMatches)	:=
function
	dConsumerMatches_Dist		:=	distribute(pConsumerMatches,hash(ConsumerSearch.record_id));
	dConsumerMatches_Sort		:=	sort(dConsumerMatches_Dist,ConsumerSearch.record_id,EmailSearchResults.orig_email,local);
	dConsumerMatches_Dedup	:=	dedup(dConsumerMatches_Sort,ConsumerSearch.record_id,EmailSearchResults.orig_email,local);
	
	return	dConsumerMatches_Dedup;
end;

// Search 1 - SSN
// Append DID by SSN
SSN_Matchset	:=	['S'];
did_add.MAC_Match_Flex(	dConsumerCleanNameAddr(pSSNSearch),
												SSN_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rConsumerClean_layout, 
												false,
												did_score,
												75,
												dConsumer_DIDBySSN,
												false
											);

dSSNDIDMatch		:=	join(	dEntiera(did	!=	0),
													dConsumer_DIDBySSN,
													left.did	=	right.did,
													tGetMatches(left,right),
													lookup
												);

dSSNDIDNoMatch	:=	join(	dEntiera(did	!=	0),
													dConsumer_DIDBySSN,
													left.did	=	right.did,
													tGetMatches(left,right),
													right only
												);

dSSNDirectMatch			:=	join(	dEntiera(best_ssn	!=	''),
															dSSNDIDNoMatch,
															left.best_ssn	=	right.ConsumerSearch.ssn,
															transform(	rConsumerMatch_layout,
																					self.ConsumerSearch			:=	right.ConsumerSearch;
																					self.EmailSearchResults	:=	left;
																				),
															lookup
														);

dSSNDirectNoMatch		:=	join(	dEntiera(best_ssn	!=	''),
															dSSNDIDNoMatch,
															left.best_ssn	=	right.ConsumerSearch.ssn,
															transform(	rConsumerMatch_layout,
																					self.ConsumerSearch			:=	right.ConsumerSearch;
																					self.EmailSearchResults	:=	left;
																				),
															right only
														);

dSSNMatch		:=	dSSNDIDMatch	+	dSSNDirectMatch;
dSSNNoMatch	:=	dSSNDirectNoMatch;

output(dSSNMatch,named('SSN_Match'));
output(dSSNNoMatch,named('SSN_NoMatch'));

// Search2 - Name and Partial SSN Search
dNamePartialSSNMatch		:=	join(	dEntiera(best_ssn	!=	''),
																	dConsumerCleanNameAddr(pNamePartialSSNSearch),
																	left.clean_name.fname	=	right.fname	and
																	left.clean_name.mname	=	right.mname	and
																	left.clean_name.lname	=	right.lname	and
																	left.best_ssn[6..9]		=	right.ssn,
																	tGetMatches(left,right),
																	lookup
																);

dNamePartialSSNNoMatch	:=	join(	dEntiera(best_ssn	!=	''),
																	dConsumerCleanNameAddr(pNamePartialSSNSearch),
																	left.clean_name.fname	=	right.fname	and
																	left.clean_name.mname	=	right.mname	and
																	left.clean_name.lname	=	right.lname	and
																	left.best_ssn[6..9]		=	right.ssn,
																	tGetMatches(left,right),
																	right only
																);

output(dNamePartialSSNMatch,named('NamePartialSSN_Match'));
output(dNamePartialSSNNoMatch,named('NamePartialSSN_NoMatch'));

// Search3 - Name and Address Search
// Append DID by Name, Address
NameAddr_Matchset	:=	['A'];

did_add.MAC_Match_Flex(	dConsumerCleanNameAddr(pNameAddrSearch),
												NameAddr_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rConsumerClean_layout, 
												false,
												did_score,
												75,
												dConsumer_DIDByNameAddr,
												false
											);

dNameAddrDIDMatch		:=	join(	dEntiera(did	!=	0),
															dConsumer_DIDByNameAddr,
															left.did	=	right.did,
															tGetMatches(left,right),
															lookup
														);

dNameAddrDIDNoMatch	:=	join(	dEntiera(did	!=	0),
															dConsumer_DIDByNameAddr,
															left.did	=	right.did,
															tGetMatches(left,right),
															right only
														);

dEntieraNameAddr	:=	dEntiera(			clean_name.lname					!=	''
																and	clean_address.prim_range	!=	''
																and	clean_address.prim_name		!=	''
																and	clean_address.zip					!=	''
															);

dNameAddrDirectMatch			:=	join(	dEntieraNameAddr,
																		dNameAddrDIDNoMatch,
																		left.clean_name.fname						=	right.ConsumerSearch.fname				and
																		// left.clean_name.mname						=	right.ConsumerSearch.mname				and
																		left.clean_name.lname						=	right.ConsumerSearch.lname				and
																		left.clean_address.prim_range		=	right.ConsumerSearch.prim_range		and
																		left.clean_address.prim_name		=	right.ConsumerSearch.prim_name		and
																		left.clean_address.predir				=	right.ConsumerSearch.predir				and
																		left.clean_address.postdir			=	right.ConsumerSearch.postdir			and
																		left.clean_address.sec_range		=	right.ConsumerSearch.sec_range		and
																		left.clean_address.v_city_name	=	right.ConsumerSearch.v_city_name	and
																		left.clean_address.st						=	right.ConsumerSearch.st						and
																		left.clean_address.zip					=	right.ConsumerSearch.zip_code,
																		transform(	rConsumerMatch_layout,
																								self.ConsumerSearch			:=	right.ConsumerSearch;
																								self.EmailSearchResults	:=	left;
																							),
																		lookup
																	);

dNameAddrDirectNoMatch		:=	join(	dEntieraNameAddr,
																		dNameAddrDIDNoMatch,
																		left.clean_name.fname						=	right.ConsumerSearch.fname				and
																		left.clean_name.mname						=	right.ConsumerSearch.mname				and
																		left.clean_name.lname						=	right.ConsumerSearch.lname				and
																		left.clean_address.prim_range		=	right.ConsumerSearch.prim_range		and
																		left.clean_address.prim_name		=	right.ConsumerSearch.prim_name		and
																		left.clean_address.predir				=	right.ConsumerSearch.predir				and
																		left.clean_address.postdir			=	right.ConsumerSearch.postdir			and
																		left.clean_address.sec_range		=	right.ConsumerSearch.sec_range		and
																		left.clean_address.v_city_name	=	right.ConsumerSearch.v_city_name	and
																		left.clean_address.st						=	right.ConsumerSearch.st						and
																		left.clean_address.zip					=	right.ConsumerSearch.zip_code,
																		transform(	rConsumerMatch_layout,
																								self.ConsumerSearch			:=	right.ConsumerSearch;
																								self.EmailSearchResults	:=	left;
																							),
																		right only
																	);

dNameAddrMatch		:=	dNameAddrDIDMatch	+	dNameAddrDirectMatch;
dNameAddrNoMatch	:=	dNameAddrDirectNoMatch;

output(dNameAddrMatch,named('NameAddr_Match'));
output(dNameAddrNoMatch,named('NameAddr_NoMatch'));

// Search4 - Address Search
dEntieraAddr	:=	dEntiera(			clean_address.prim_range	!=	''
														and	clean_address.prim_name		!=	''
														and	clean_address.zip					!=	''
													);

dAddrMatch			:=	join(	dEntieraAddr,
													dConsumerCleanNameAddr(pAddrSearch),
													left.clean_address.prim_range		=	right.prim_range	and
													left.clean_address.prim_name		=	right.prim_name		and
													left.clean_address.predir				=	right.predir			and
													left.clean_address.postdir			=	right.postdir			and
													left.clean_address.sec_range		=	right.sec_range		and
													left.clean_address.v_city_name	=	right.v_city_name	and
													left.clean_address.st						=	right.st					and
													left.clean_address.zip					=	right.zip_code,
													tGetMatches(left,right),
													lookup
												);

dAddrNoMatch		:=	join(	dEntieraAddr,
													dConsumerCleanNameAddr(pAddrSearch),
													left.clean_address.prim_range		=	right.prim_range	and
													left.clean_address.prim_name		=	right.prim_name		and
													left.clean_address.predir				=	right.predir			and
													left.clean_address.postdir			=	right.postdir			and
													left.clean_address.sec_range		=	right.sec_range		and
													left.clean_address.v_city_name	=	right.v_city_name	and
													left.clean_address.st						=	right.st					and
													left.clean_address.zip					=	right.zip_code,
													tGetMatches(left,right),
													right only
												);

output(dAddrMatch,named('Address_Match'));
output(dAddrNoMatch,named('Address_NoMatch'));

// Search5 - Name and State Search
dEntieraNameSt	:=	dEntiera(clean_name.lname 	!=	''	and	clean_address.st	!=	'');

dNameStMatch		:=	join(	dEntieraNameSt,
													dConsumerCleanNameAddr(pNameStSearch),
													left.clean_name.lname	=	right.lname	and
													left.clean_name.fname	=	right.fname	and
													left.clean_name.mname	=	right.mname	and
													left.clean_address.st	=	right.st,
													tGetMatches(left,right),
													lookup
												);

dNameStNoMatch	:=	join(	dEntieraNameSt,
													dConsumerCleanNameAddr(pNameStSearch),
													left.clean_name.lname	=	right.lname	and
													left.clean_name.fname	=	right.fname	and
													left.clean_name.mname	=	right.mname	and
													left.clean_address.st	=	right.st,
													tGetMatches(left,right),
													right only
												);

output(dNameStMatch,named('NameState_Match'));
output(dNameStNoMatch,named('NameState_NoMatch'));

// Search6 - Name and Zip search
dEntieraNameZip	:=	dEntiera(clean_name.lname 	!=	''	and	clean_address.zip	!=	'');

dNameZipMatch		:=	join(	dEntieraNameZip,
													dConsumerCleanNameAddr(pNameZipSearch),
													left.clean_name.lname		=	right.lname			and
													left.clean_name.fname		=	right.fname			and
													left.clean_name.mname		=	right.mname			and
													left.clean_address.zip	=	right.zip_code,
													tGetMatches(left,right),
													lookup
												);

dNameZipNoMatch	:=	join(	dEntieraNameZip,
													dConsumerCleanNameAddr(pNameZipSearch),
													left.clean_name.lname		=	right.lname			and
													left.clean_name.fname		=	right.fname			and
													left.clean_name.mname		=	right.mname			and
													left.clean_address.zip	=	right.zip_code,
													tGetMatches(left,right),
													right only
												);

output(dNameZipMatch,named('NameZip_Match'));
output(dNameZipNoMatch,named('NameZip_NoMatch'));

// Per Jill - Run counts for the records instead of sending FDS the records
dAll	:=	dSSNMatch							+
					dNamePartialSSNMatch	+
					dNameAddrMatch				+
					dAddrMatch						+
					dNameStMatch					+
					dNameZipMatch;

rEmailAppend_layout	:=
record
	dConsumerIn.record_id;
	dEntiera;
end;

dEmailAppend		:=	join(	dConsumerIn,
													dAll,
													left.record_id	=	right.ConsumerSearch.record_id,
													transform(	rEmailAppend_layout,
																			self.record_id	:=	left.record_id;
																			self						:=	right.EmailSearchResults;
																		),
													left outer
												);

dEmailAppend_dedup	:=	dedup(	dEmailAppend,
																Record_ID,
																orig_email,
																all
															);

dFDSEmailAppend	:=	sort(dEmailAppend_dedup,(integer)record_id);

outEmailAppend	:=	output(	dFDSEmailAppend,,
														'~thor_data400::out::fds_test::consumer::email_append_test',
														overwrite,
														__compressed__
													);

rNameAddrCounts_layout	:=
record
	dFDSEmailAppend.record_id;
	Count_Results	:=	sum(group, if(dFDSEmailAppend.orig_email != '', 1, 0));
end;

dEmailSearchCounts	:=	table	(	dFDSEmailAppend,
																rNameAddrCounts_layout,
																dFDSEmailAppend.record_id,
																few
															);

outEmailSearchCounts_Fixed	:=	output(	sort(dEmailSearchCounts,(integer)record_id),,
																				'~thor_data400::out::fds_test::consumer::email_append_fixed',
																				overwrite,
																				__compressed__
																			);

outEmailSearchCounts				:=	output(	sort(dEmailSearchCounts,(integer)record_id),,
																				'~thor_data400::out::fds_test::consumer::email_results',
																				CSV(HEADING(single),SEPARATOR(['|']), TERMINATOR(['\n'])),
																				overwrite,
																				__compressed__
																			);

cntTotalSSN								:=	count(dConsumerCleanNameAddr(pSSNSearch));
cntTotalNamePartialSSN		:=	count(dConsumerCleanNameAddr(pNamePartialSSNSearch));
cntTotalNameAddr					:=	count(dConsumerCleanNameAddr(pNameAddrSearch));
cntTotalAddr							:=	count(dConsumerCleanNameAddr(pAddrSearch));
cntTotalNameSt						:=	count(dConsumerCleanNameAddr(pNameStSearch));
cntTotalNameZip						:=	count(dConsumerCleanNameAddr(pNameZipSearch));

cntTotalSearch						:=		cntTotalSSN
															+	cntTotalNamePartialSSN
															+	cntTotalNameAddr
															+	cntTotalAddr
															+	cntTotalNameSt
															+	cntTotalNameZip;

cntSSNNoMatch							:=	count(dSSNNoMatch);
cntNamePartialSSNNoMatch	:=	count(dNamePartialSSNNoMatch);
cntNameAddrNoMatch				:=	count(dNameAddrNoMatch);
cntAddrNoMatch						:=	count(dAddrNoMatch);
cntNameStNoMatch					:=	count(dNameStNoMatch);
cntNameZipNoMatch					:=	count(dNameZipNoMatch);

cntTotalNoMatch						:=		cntSSNNoMatch
															+	cntNamePartialSSNNoMatch
															+	cntNameAddrNoMatch
															+	cntAddrNoMatch
															+	cntNameStNoMatch
															+	cntNameZipNoMatch;

real4	Total_MatchRate						:=	((real4)(cntTotalSearch - cntTotalNoMatch)/cntTotalSearch)	*	100;
real4	SSN_MatchRate							:=	((real4)(cntTotalSSN - cntSSNNoMatch)/cntTotalSSN)	*	100;
real4	NamePartialSSN_MatchRate	:=	((real4)(cntTotalNamePartialSSN - cntNamePartialSSNNoMatch)/cntTotalNamePartialSSN)	*	100;
real4	NameAddr_MatchRate				:=	((real4)(cntTotalNameAddr - cntNameAddrNoMatch)/cntTotalNameAddr)	*	100;
real4	Address_MatchRate					:=	((real4)(cntTotalAddr - cntAddrNoMatch)/cntTotalAddr)	*	100;
real4	NameState_MatchRate				:=	((real4)(cntTotalNameSt - cntNameStNoMatch)/cntTotalNameSt)	*	100;
real4	NameZip_MatchRate					:=	((real4)(cntTotalNameZip - cntNameZipNoMatch)/cntTotalNameZip)	*	100;

export EmailAppend := sequential(	outEmailAppend,
																	outEmailSearchCounts_Fixed,
																	outEmailSearchCounts,
																	output(Total_MatchRate					,named('Total_MatchRate')),
																	output(SSN_MatchRate						,named('SSN_MatchRate')),
																	output(NamePartialSSN_MatchRate	,named('NamePartialSSN_MatchRate')),
																	output(NameAddr_MatchRate				,named('NameAddress_MatchRate')),
																	output(Address_MatchRate				,named('Address_MatchRate')),
																	output(NameState_MatchRate			,named('NameState_MatchRate')),
																	output(NameZip_MatchRate				,named('NameZip_MatchRate'))
																);