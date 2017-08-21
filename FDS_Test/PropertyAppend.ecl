import address,business_header,business_header_ss,did_add,didville,header_slimsort,ln_propertyv2,ut;

// Assets search file from FDS
dAssetsIn	:=	dataset	(	ut.foreign_prod+'~thor_data400::in::fds_test::20091130::assets::search',
												Layout_assets.Input.rAssetsIn_layout,
												CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']))
											);

dSearch		:=	ln_propertyv2.File_Search_DID	(	source_code[1]	!=	'C'	and
																							prim_name				!=	''	and
																							zip							!=	''	and
																							(lname != '' or cname != '')
																						);

// Cleaned name and address for assessment file
dAssesClean				:=	dataset	(	'~thor400_84::persist::property::assess_clean',
																layout_assets.response.rAssesAppendClnNameAddr_layout,
																thor
															);
dAssesClean_dist	:=	distribute(dAssesClean,hash(ln_fares_id));

// Cleaned name and address for deeds file
dDeedsClean				:=	dataset	(	'~thor400_84::persist::property::deeds_clean',
																layout_assets.response.rDeedsAppendClnNameAddr_layout,
																thor
															);
dDeedsClean_dist	:=	distribute(dDeedsClean,hash(ln_fares_id));

// Clean name and address for assets vendor file
rAssetsClean_layout	:=
record
	dAssetsIn;
	address.Layout_Clean182_fips;
	address.Layout_Clean_Name;
	integer8	did					:=	0;
	unsigned3	did_score		:=	0;
	integer8	bdid				:=	0;
	unsigned3	bdid_score	:=	0;
end;

rAssetsClean_layout	tAssetsCleanNameAddr(dAssetsIn pInput)	:=
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

	clean_name				:=	address.CleanPersonLFM73_fields(trim(pInput.Name,left,right));
	
	self.title				:=	clean_name.title;
	self.fname				:=	clean_name.fname;
	self.mname				:=	clean_name.mname;
	self.lname				:=	clean_name.lname;
	self.name_suffix	:=	clean_name.name_suffix;
	self.name_score		:=	clean_name.name_score;
	self							:=	clean_address.addressrecord;
	self							:=	pInput;
end;

dAssetsCleanNameAddr	:=	project(dAssetsIn,tAssetsCleanNameAddr(left));

boolean	pSSNSearch						:=			dAssetsCleanNameAddr.SSN						!=	''
																	and	length(dAssetsCleanNameAddr.SSN)		=		9
																	and	dAssetsCleanNameAddr.SSN						not in ['111111111','999999999'];

boolean	pNamePartialSSNSearch	:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.SSN						!=	''
																	and	length(dAssetsCleanNameAddr.SSN)		!=		9;

boolean	pNameAddrSearch				:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.Address				!=	'';

boolean	pBusNameAddrSearch		:=			dAssetsCleanNameAddr.Business_Name 	!=	''
																	and	dAssetsCleanNameAddr.Address				!=	'';

boolean	pNameStSearch					:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.State					!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						=		''
																	and	dAssetsCleanNameAddr.Zip_code				=		'';

boolean	pAddrSearch						:=			dAssetsCleanNameAddr.Address				!=	''
																	and	dAssetsCleanNameAddr.Name						=		''
																	and	dAssetsCleanNameAddr.Business_Name	=		'';

boolean	pNameZipSearch				:=			dAssetsCleanNameAddr.Name						!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						=		''
																	and	dAssetsCleanNameAddr.State					=		''
																	and	dAssetsCleanNameAddr.Zip_Code				!=	'';

boolean	pBusNameCityStSearch	:=			dAssetsCleanNameAddr.Business_Name	!=	''
																	and	dAssetsCleanNameAddr.Address				=		''
																	and	dAssetsCleanNameAddr.City						!=	''
																	and	dAssetsCleanNameAddr.State					!=	'';

boolean	pPhoneSearch					:=	dAssetsCleanNameAddr.Phone_Number				!=	'';

// Get all the records where the search conditions are not met
dAssetsNoSearch	:=	dAssetsCleanNameAddr(	~(			pSSNSearch
																							or	pNamePartialSSNSearch
																							or	pNameAddrSearch
																							or	pBusNameAddrSearch
																							or	pNameStSearch
																							or	pAddrSearch
																							or	pNameZipSearch
																							or	pBusNameCityStSearch
																							or	pPhoneSearch
																						)
																				);

output(count(dAssetsNoSearch),named('Cnt_Records_not_being_used_in_searches'));
output(dAssetsNoSearch,named('Records_not_being_used_in_searches'));

// Declare all the common layouts and transforms being used for the searches
rAssetsSearchMatch_layout	:=
record
	recordof(dAssetsCleanNameAddr)	assets_search;
	recordof(dSearch)								search_result;
	string2													priorityInd;
end;

rAssetsAssesMatch_layout	:=
record
	recordof(dAssetsCleanNameAddr)	assets_search;
	recordof(dAssesClean)						assess_result;
	string2													priorityInd;
end;

rAssetsDeedsMatch_layout	:=
record
	recordof(dAssetsCleanNameAddr)	assets_search;
	recordof(dDeedsClean)						deeds_result;
	string2													priorityInd;
end;

rAssetsSearchMatch_layout	tMatchOwnerFDS(recordof(dSearch) le, recordof(dAssetsCleanNameAddr) ri)	:=
transform
	self.assets_search	:=	ri;
	self.search_result	:=	le;
	self.priorityInd		:=	if(	le.source_code[1]	in	['O','B'],
															'P',
															''
														);
end;

rAssetsSearchMatch_layout	tMatchPropFDS(recordof(dSearch) le, recordof(dAssetsCleanNameAddr) ri)	:=
transform
	self.assets_search	:=	ri;
	self.search_result	:=	le;
	self.priorityInd		:=	if(	le.source_code[2] = 'P',
															'P',
															''
														);
end;

// Get all the relevant assessment records pertaining to the fares_id
fnGetAllAssesFaresID	(	dataset(rAssetsSearchMatch_layout)															pSearch,
												dataset(layout_assets.response.rAssesAppendClnNameAddr_layout)	pAssesClean	=	dAssesClean_dist
											)	:=
function
	dSearchMatch_dist		:=	distribute(pSearch,hash(search_result.ln_fares_id));
	dSearchMatch_sort		:=	sort(	dSearchMatch_dist,search_result.ln_fares_id,-priorityInd,local);
	dSearchMatch_dedup	:=	dedup(dSearchMatch_sort,search_result.ln_fares_id,local);

	rAssetsAssesMatch_layout tGetAssesInfo(pAssesClean le, pSearch ri)	:=
	transform
		self.assets_search							:=	ri.assets_search;
		self.assess_result							:=	le;
		self.priorityInd								:=	if(	ri.priorityInd	=	'P',
																						'PA',
																						''
																					);
	end;

	dAssesMatchInfo	:=	join(	pAssesClean,
														dSearchMatch_dedup(search_result.ln_fares_id[2]	=	'A'),
														left.ln_fares_id	=	right.search_result.ln_fares_id,
														tGetAssesInfo(left, right),
														lookup,
														local
													);

	return	dAssesMatchInfo;
end;

// Get all the relevant deed records pertaining to the fares_id
fnGetAllDeedsFaresID	(	dataset(rAssetsSearchMatch_layout)															pSearch,
												dataset(layout_assets.response.rDeedsAppendClnNameAddr_layout)	pDeedsClean	=	dDeedsClean_dist
											)	:=
function
	dSearchMatch_dist		:=	distribute(pSearch,hash(search_result.ln_fares_id));
	dSearchMatch_sort		:=	sort(	dSearchMatch_dist,search_result.ln_fares_id,-priorityInd,local);
	dSearchMatch_dedup	:=	dedup(dSearchMatch_sort,search_result.ln_fares_id,local);

	rAssetsDeedsMatch_layout tGetDeedsInfo(pDeedsClean le, pSearch ri)	:=
	transform
		self.assets_search							:=	ri.assets_search;
		
		self.deeds_result								:=	le;
		self.priorityInd								:=	if(	ri.priorityInd	=	'P',
																						'PD',
																						''
																					);
	end;
	
	dDeedsMatchInfo	:=	join(	pDeedsClean,
														dSearchMatch_dedup(search_result.ln_fares_id[2]	in	['D']),
														left.ln_fares_id	=	right.search_result.ln_fares_id,
														tGetDeedsInfo(left, right),
														lookup,
														local
													);

	return	dDeedsMatchInfo;
end;

// Search1 - Match on SSN
// Append DID by SSN
SSN_Matchset	:=	['S'];
DID_Add.MAC_Match_Flex(	dAssetsCleanNameAddr(pSSNSearch),
												SSN_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rAssetsClean_layout, 
												true,
												did_score,
												80,
												dAssets_DIDBySSN,
											);

// output(dAssets_DIDBySSN,named('Assets_DID_by_SSN'));

dAssetsSSNDIDMatch	:=	join(	dSearch(did != 0),
															dAssets_DIDBySSN,
															left.did	=	right.did,
															tMatchOwnerFDS(left,right),
															lookup
														);

// output(dAssetsSSNMatch,named('SSN_Match'));

dAssetsSSNDIDNoMatch	:=	join(	dSearch(did != 0),
																dAssets_DIDBySSN,
																left.did	=	right.did,
																tMatchOwnerFDS(left,right),
																right only,
																hash
															);

// output(dAssetsSSNNoMatch,named('SSN_NoMatch'));

// Match records with no did with direct ssn
dAssetsSSNDirectMatch	:=	join(	dSearch(app_ssn	!=	''),
																dAssetsSSNDIDNoMatch,
																left.app_ssn	=	right.assets_search.ssn,
																transform(rAssetsSearchMatch_layout,
																					self.assets_search	:=	right.assets_search;
																					self.search_result	:=	left;
																					self.priorityInd		:=	if(left.source_code[1]	in	['O','B'],'P','');
																					),
																lookup
															);

// output(dAssetsSSNDirectMatch,named('SSNDirect_Match'));

dAssetsSSNDirectNoMatch	:=	join(	dSearch(app_ssn	!=	''),
																	dAssetsSSNDIDNoMatch,
																	left.app_ssn	=	right.assets_search.ssn,
																	transform(rAssetsSearchMatch_layout,
																						self.assets_search	:=	right.assets_search;
																						self.search_result	:=	left;
																						self.priorityInd		:=	if(left.source_code[1]	in	['O','B'],'P','');
																						),
																	right only,
																	hash
																);

dAssetsSSNNoMatch	:=	dAssetsSSNDirectNoMatch
											 : persist('persist::property::ssn_nomatch');

// Get all the relevant records pertaining to the fares_id
dAssetsSSNAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsSSNDIDMatch+dAssetsSSNDirectMatch)
															:	persist('persist::property::asses::ssn');

// output(dAssetsSSNAssesMatchInfo,named('SSN_search_asses_match'));

dAssetsSSNDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsSSNDIDMatch+dAssetsSSNDirectMatch)
															:	persist('persist::property::deeds::ssn');

// output(dAssetsSSNDeedsMatchInfo,named('SSN_search_deeds_match'));

// Search2 - Name and Partial SSN only
dAssetsNamePartialSSNMatch	:=	join(	dSearch(app_ssn	!=	''),
																			dAssetsCleanNameAddr(pNamePartialSSNSearch),
																			left.fname					=	right.fname	and
																			left.mname					=	right.mname	and
																			left.lname					=	right.lname	and
																			left.app_ssn[6..9]	=	right.ssn,
																			tMatchOwnerFDS(left,right),
																			lookup
																		);

// output(dAssetsNamePartialSSNMatch,named('NamePartialSSN_Match'));

dAssetsNamePartialSSNNoMatch	:=	join(	dSearch(app_ssn	!=	''),
																				dAssetsCleanNameAddr(pNamePartialSSNSearch),
																				left.fname					=	right.fname	and
																				left.mname					=	right.mname	and
																				left.lname					=	right.lname	and
																				left.app_ssn[6..9]	=	right.ssn,
																				tMatchOwnerFDS(left,right),
																				right only,
																				hash
																			) : persist('persist::property::namepartialssn_nomatch');

// output(dAssetsNamePartialSSNNoMatch,named('NamePartialSSN_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsNamePartialSSNAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsNamePartialSSNMatch)
																				:	persist('persist::property::asses::namepartialssn');

// output(dAssetsNamePartialSSNAssesMatchInfo,named('NamePartialSSN_search_asses_match'));

dAssetsNamePartialSSNDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsNamePartialSSNMatch)
																				:	persist('persist::property::deeds::namepartialssn');

// output(dAssetsNamePartialSSNDeedsMatchInfo,named('NamePartialSSN_search_deeds_match'));

// Search3 - Match on Name and Address
// Append DID by address
NameAddress_Matchset	:=	['A'];
DID_Add.MAC_Match_Flex(	dAssetsCleanNameAddr(pNameAddrSearch),
												NameAddress_Matchset,
												SSN,
												'',
												fname,mname,lname,name_suffix, 
												prim_range,prim_name,sec_range,zip,st,
												'',
												did,   			
												rAssetsClean_layout, 
												true,
												did_score,
												80,
												dAssets_DIDByNameAddr,
											);

// output(dAssets_DIDByNameAddr,named('Assets_DID_by_NameAddr'));

dAssetsNameAddrMatch	:=	join(	dSearch(did != 0),
																dAssets_DIDByNameAddr,
																left.did	=	right.did,
																tMatchOwnerFDS(left,right),
																lookup
															);

// output(dAssetsNameAddrMatch,named('NameAddr_Match'));

dAssetsNameAddrNoMatch	:=	join(	dSearch(did != 0),
																	dAssets_DIDByNameAddr,
																	left.did	=	right.did,
																	tMatchOwnerFDS(left,right),
																	right only,
																	hash
																) : persist('persist::property::nameaddr_nomatch');

// output(dAssetsNameAddrNoMatch,named('NameAddr_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsNameAddrAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsNameAddrMatch)
																	:	persist('persist::property::asses::nameaddr');

// output(dAssetsNameAddrAssesMatchInfo,named('NameAddr_search_asses_match'));

dAssetsNameAddrDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsNameAddrMatch)
																	:	persist('persist::property::deeds::nameaddr');

// output(dAssetsNameAddrDeedsMatchInfo,named('NameAddr_search_deeds_match'));

// Search4 - Match on Business Name and Address
// Append BDID by address
BusNameAddress_Matchset	:=	['A'];
preBDID	:=	dAssetsCleanNameAddr(pBusNameAddrSearch);

Business_header_ss.MAC_Match_Flex(	preBDID,
																		BusNameAddress_Matchset,
																		Business_Name,
																		prim_range,prim_name,zip,sec_range,st,
																		Phone_Number,
																		tax_id_number,
																		bdid,   			
																		rAssetsClean_layout, 
																		true,
																		bdid_score,
																		dAssets_BDIDByBusNameAddr
																	);

// output(dAssets_BDIDByBusNameAddr,named('Assets_BDID_by_BusNameAddr'));

dAssetsBusNameAddrMatch	:=	join(	dSearch(bdid != 0),
																	dAssets_BDIDByBusNameAddr,
																	left.bdid	=	right.bdid,
																	tMatchOwnerFDS(left,right),
																	lookup
																);

// output(dAssetsBusNameAddrMatch,named('BusNameAddr_Match'));

dAssetsBusNameAddrNoMatch	:=	join(	dSearch(bdid != 0),
																		dAssets_BDIDByBusNameAddr,
																		left.bdid	=	right.bdid,
																		tMatchOwnerFDS(left,right),
																		right only,
																		hash
																	) : persist('persist::property::busnameaddr_nomatch');

// output(dAssetsBusNameAddrNoMatch,named('BusNameAddr_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsBusNameAddrAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsBusNameAddrMatch)
																			:	persist('persist::property::asses::busnameaddr');

// output(dAssetsBusNameAddrAssesMatchInfo,named('BusNameAddr_search_asses_match'));

dAssetsBusNameAddrDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsBusNameAddrMatch)
																			:	persist('persist::property::deeds::busnameaddr');

// output(dAssetsBusNameAddrDeedsMatchInfo,named('BusNameAddr_search_deeds_match'));

// Search5 - Address only
dAssetsAddrMatch	:=	join(	dSearch(prim_name	!=	''	and	zip	!=	''),
														dAssetsCleanNameAddr(pAddrSearch),
														left.prim_range		=	right.prim_range	and
														left.predir				=	right.predir			and
														left.prim_name		=	right.prim_name		and
														left.sec_range		=	right.sec_range		and
														left.postdir			=	right.postdir			and
														left.p_city_name	=	right.p_city_name	and
														left.st						=	right.st					and
														left.zip					=	right.zip,
														tMatchPropFDS(left,right),
														lookup
													);

// output(dAssetsAddrMatch,named('Addr_Match'));

dAssetsAddrNoMatch	:=	join(	dSearch(prim_name	!=	''	and	zip	!=	''),
															dAssetsCleanNameAddr(pAddrSearch),
															left.prim_range		=	right.prim_range	and
															left.predir				=	right.predir			and
															left.prim_name		=	right.prim_name		and
															left.sec_range		=	right.sec_range		and
															left.postdir			=	right.postdir			and
															left.p_city_name	=	right.p_city_name	and
															left.st						=	right.st					and
															left.zip					=	right.zip,
															tMatchPropFDS(left,right),
															right only,
															hash
														) : persist('persist::property::address_nomatch');

// output(dAssetsAddrNoMatch,named('Addr_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsAddrAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsAddrMatch)
															:	persist('persist::property::asses::address');

// output(dAssetsAddrAssesMatchInfo,named('Addr_search_asses_match'));

dAssetsAddrDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsAddrMatch)
															:	persist('persist::property::deeds::address');

// output(dAssetsAddrDeedsMatchInfo,named('Addr_search_deeds_match'));

// Search6 - Name and State only
dAssetsNameStMatch	:=	join(	dSearch(lname	!=	''	and	st	!=	''),
															dAssetsCleanNameAddr(pNameStSearch),
															left.fname	=	right.fname	and
															left.mname	=	right.mname	and
															left.lname	=	right.lname	and
															left.st			=	right.st,
															tMatchOwnerFDS(left,right),
															lookup
														);

// output(dAssetsNameStMatch,named('NameState_Match'));

dAssetsNameStNoMatch	:=	join(	dSearch(lname	!=	''	and	st	!=	''),
																dAssetsCleanNameAddr(pNameStSearch),
																left.fname	=	right.fname	and
																left.mname	=	right.mname	and
																left.lname	=	right.lname	and
																left.st			=	right.st,
																tMatchOwnerFDS(left,right),
																right only,
																hash
															) : persist('persist::property::namestate_nomatch');

// output(dAssetsNameStNoMatch,named('NameState_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsNameStAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsNameStMatch)
																:	persist('persist::property::asses::namestate');

// output(dAssetsNameStAssesMatchInfo,named('NameState_search_asses_match'));

dAssetsNameStDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsNameStMatch)
																:	persist('persist::property::deeds::namestate');

// output(dAssetsNameStDeedsMatchInfo,named('NameState_search_deeds_match'));

// Search7 - Name and Zip only
dAssetsNameZipMatch	:=	join(	dSearch(lname	!=	''	and	cname	=	''	and	zip	!=	''),
															dAssetsCleanNameAddr(pNameZipSearch),
															left.fname	=	right.fname	and
															left.mname	=	right.mname	and
															left.lname	=	right.lname	and
															left.zip		=	right.zip,
															tMatchOwnerFDS(left,right),
															lookup
														);

// output(dAssetsNameZipMatch,named('NameZip_Match'));

dAssetsNameZipNoMatch	:=	join(	dSearch((lname	!=	''	and	cname	=	''	and	zip	!=	'')),
																dAssetsCleanNameAddr(pNameZipSearch),
																left.fname	=	right.fname	and
																left.mname	=	right.mname	and
																left.lname	=	right.lname	and
																left.zip		=	right.zip,
																tMatchOwnerFDS(left,right),
																right only,
																hash
															) : persist('persist::property::namezip_nomatch');

// output(dAssetsNameZipNoMatch,named('NameZip_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsNameZipAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsNameZipMatch)
																	:	persist('persist::property::asses::namezip');

// output(dAssetsNameZipAssesMatchInfo,named('NameZip_search_asses_match'));

dAssetsNameZipDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsNameZipMatch)
																	:	persist('persist::property::deeds::namezip');

// output(dAssetsNameZipDeedsMatchInfo,named('NameZip_search_deeds_match'));

// Search8 - Business Name, City and State only
dAssetsBusNameCityStMatch	:=	join(	dSearch(cname	!=	''),
																		dAssetsCleanNameAddr(pBusNameCityStSearch),
																		business_header.CompanyCleanFields(left.cname,true).indicative	=	business_header.CompanyCleanFields(right.Business_Name,true).indicative	and
																		business_header.CompanyCleanFields(left.cname,true).secondary		=	business_header.CompanyCleanFields(right.Business_Name,true).secondary	and
																		left.p_city_name																								=	right.p_city_name	and
																		left.st																													=	right.st,
																		tMatchOwnerFDS(left,right),
																		hash
																	);

// output(dAssetsBusNameCityStMatch,named('BusNameCityState_Match'));

dAssetsBusNameCityStNoMatch	:=	join(	dSearch(cname	!=	''),
																			dAssetsCleanNameAddr(pBusNameCityStSearch),
																			business_header.CompanyCleanFields(left.cname,true).indicative	=	business_header.CompanyCleanFields(right.Business_Name,true).indicative	and
																			business_header.CompanyCleanFields(left.cname,true).secondary		=	business_header.CompanyCleanFields(right.Business_Name,true).secondary	and
																			left.p_city_name																								=	right.p_city_name	and
																			left.st																													=	right.st,
																			tMatchOwnerFDS(left,right),
																			right only,
																			hash
																		) : persist('persist::property::busname_citystate_nomatch');

// output(dAssetsBusNameCityStNoMatch,named('BusNameCityState_NoMatch'));

// Get all the relevant records pertaining to the fares_id
dAssetsBusNameCityStAssesMatchInfo	:=	fnGetAllAssesFaresID(dAssetsBusNameCityStMatch)
																				:	persist('persist::property::asses::busname_citystate');

// output(dAssetsBusNameCityStAssesMatchInfo,named('BusNameCityState_search_asses_match'));

dAssetsBusNameCityStDeedsMatchInfo	:=	fnGetAllDeedsFaresID(dAssetsBusNameCityStMatch)
																				:	persist('persist::property::deeds::busname_citystate');

// output(dAssetsBusNameCityStDeedsMatchInfo,named('BusNameCityState_search_deeds_match'));

// Search9 - Phone only
// project it to the common search layout so as to easily add this dataset to the other searches
rAssetsSearchMatch_layout	tPhoneConvert2Search(dAssetsCleanNameAddr	pInput)	:=
transform
	self.assets_search	:=	pInput;
	self.search_result	:=	[];
	self.priorityInd		:=	'';
end;

dPhoneConvert2Search	:=	project(dAssetsCleanNameAddr(pPhoneSearch),tPhoneConvert2Search(left));

rAssetsAssesMatch_layout tPhoneAssesMatch(dAssesClean_dist le, dPhoneConvert2Search ri)	:=
transform
	self.assets_search	:=	ri.assets_search;
	self.assess_result	:=	le;
	self.priorityInd		:=	'PA';
end;

dAssetsPhoneAssesMatchInfo	:=	join(	dAssesClean_dist(assessee_phone_number	!=	''),
																			dPhoneConvert2Search,
																			left.assessee_phone_number	=	right.assets_search.phone_number,
																			tPhoneAssesMatch(left,right),
																			hash
																		)	:	persist('persist::property::asses::phone');

// output(dAssetsPhoneAssesMatchInfo,named('Phone_search_asses_match'));

dAssetsPhoneAssesNoMatchInfo	:=	join(	dAssesClean_dist(assessee_phone_number	!=	''),
																				dPhoneConvert2Search,
																				left.assessee_phone_number	=	right.assets_search.phone_number,
																				transform(	rAssetsSearchMatch_layout,
																										self.assets_search	:=	right.assets_search;
																										self.search_result	:=	[];
																										self.priorityInd		:=	'';
																									),
																				right only,
																				hash
																			);

// output(dAssetsPhoneAssesNoMatchInfo,named('Phone_search_asses_nomatch'));

rAssetsDeedsMatch_layout tPhoneDeedsMatch(dDeedsClean_dist le, dPhoneConvert2Search ri)	:=
transform
	self.assets_search	:=	ri.assets_search;
	self.deeds_result		:=	le;
	self.priorityInd		:=	'PD';
end;

dAssetsPhoneDeedsMatchInfo	:=	join(	dDeedsClean_dist(phone_number	!=	''),
																			dPhoneConvert2Search,
																			left.phone_number	=	right.assets_search.phone_number,
																			tPhoneDeedsMatch(left,right),
																			hash
																		)	:	persist('persist::property::deeds::phone');

// output(dAssetsPhoneDeedsMatchInfo,named('Phone_search_deeds_match'));

dAssetsPhoneDeedsNoMatchInfo	:=	join(	dDeedsClean_dist(phone_number	!=	''),
																				dPhoneConvert2Search,
																				left.phone_number	=	right.assets_search.phone_number,
																				transform(	rAssetsSearchMatch_layout,
																										self.assets_search	:=	right.assets_search;
																										self.search_result	:=	[];
																										self.priorityInd		:=	'';
																									),
																				right only,
																				hash
																			);

// output(dAssetsPhoneDeedsNoMatchInfo,named('Phone_search_deeds_nomatch'));

// Inner Join on phone numbers to get the records which didn't match on both assessments and deeds
dAssetsPhoneNoMatch	:=	join(	dAssetsPhoneAssesNoMatchInfo,
															dAssetsPhoneDeedsNoMatchInfo,
															left.assets_search.phone_number	=	right.assets_search.phone_number,
															transform(rAssetsSearchMatch_layout,self	:=	left),
															hash
														)	:	persist('persist::property::phone_nomatch');

// output(dAssetsPhoneNoMatch,named('Phone_NoMatch'));

// Combine all different searches
dAssetsNoMatch				:=		dAssetsSSNNoMatch
													+	dAssetsNamePartialSSNNoMatch
													+	dAssetsNameAddrNoMatch
													+	dAssetsBusNameAddrNoMatch
													+	dAssetsAddrNoMatch
													+	dAssetsNameStNoMatch
													+	dAssetsNameZipNoMatch
													+	dAssetsBusNameCityStNoMatch
													+	dAssetsPhoneNoMatch;

dAssetsAssesMatchInfo	:=		dAssetsSSNAssesMatchInfo
													+	dAssetsNamePartialSSNAssesMatchInfo
													+	dAssetsNameAddrAssesMatchInfo
													+	dAssetsBusNameAddrAssesMatchInfo
													+	dAssetsAddrAssesMatchInfo
													+	dAssetsNameStAssesMatchInfo
													+	dAssetsNameZipAssesMatchInfo
													+	dAssetsBusNameCityStAssesMatchInfo
													+	dAssetsPhoneAssesMatchInfo;

dAssetsDeedsMatchInfo	:=		dAssetsSSNDeedsMatchInfo
													+	dAssetsNamePartialSSNDeedsMatchInfo
													+	dAssetsNameAddrDeedsMatchInfo
													+	dAssetsBusNameAddrDeedsMatchInfo
													+	dAssetsAddrDeedsMatchInfo
													+	dAssetsNameStDeedsMatchInfo
													+	dAssetsNameZipDeedsMatchInfo
													+	dAssetsBusNameCityStDeedsMatchInfo
													+	dAssetsPhoneDeedsMatchInfo;


// Join assessment and deed records to convert to the resultant out layout
rMatchInfo_layout	:=
record,maxlength(8192)
	string12	asses_fares_id;
	string12	deeds_fares_id;
	string4		tax_year;
	string4		assessed_year;
	string8		recording_date;
	string2		priorityInd;
	
	layout_assets.response.rFDSProperty_layout;
end;

rMatchInfo_layout	tMatchInfo(dAssetsAssesMatchInfo le,dAssetsDeedsMatchInfo ri)	:=
transform
	asses_property_street_address		:=	trim(Address.Addr1FromComponents(	le.assess_result.property_prim_range,
																																				le.assess_result.property_predir,
																																				le.assess_result.property_prim_name,
																																				le.assess_result.property_addr_suffix,
																																				le.assess_result.property_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	asses_property_street_address2	:=	trim(Address.Addr1FromComponents(	le.assess_result.property_unit_desig,
																																				le.assess_result.property_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	deeds_property_street_address		:=	trim(Address.Addr1FromComponents(	ri.deeds_result.property_prim_range,
																																				ri.deeds_result.property_predir,
																																				ri.deeds_result.property_prim_name,
																																				ri.deeds_result.property_addr_suffix,
																																				ri.deeds_result.property_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	deeds_property_street_address2	:=	trim(Address.Addr1FromComponents(	ri.deeds_result.property_unit_desig,
																																				ri.deeds_result.property_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	prop_street_address							:=	if(	trim(le.assess_result.property_prim_range)	+
																					trim(le.assess_result.property_prim_name)
																					!=	'',
																					asses_property_street_address,
																					deeds_property_street_address
																				);
																				
	prop_street_address2						:=	if(	trim(le.assess_result.property_prim_range)	+
																					trim(le.assess_result.property_prim_name)
																					!=	'',
																					asses_property_street_address2,
																					deeds_property_street_address2
																				);

	asses_mailing_street_address		:=	trim(Address.Addr1FromComponents(	le.assess_result.mail_prim_range,
																																				le.assess_result.mail_predir,
																																				le.assess_result.mail_prim_name,
																																				le.assess_result.mail_addr_suffix,
																																				le.assess_result.mail_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	asses_mailing_street_address2		:=	trim(Address.Addr1FromComponents(	le.assess_result.mail_unit_desig,
																																				le.assess_result.mail_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	deeds_mailing_street_address		:=	trim(Address.Addr1FromComponents(	ri.deeds_result.mail_prim_range,
																																				ri.deeds_result.mail_predir,
																																				ri.deeds_result.mail_prim_name,
																																				ri.deeds_result.mail_addr_suffix,
																																				ri.deeds_result.mail_postdir,
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	deeds_mailing_street_address2		:=	trim(Address.Addr1FromComponents(	ri.deeds_result.mail_unit_desig,
																																				ri.deeds_result.mail_sec_range,
																																				'',
																																				'',
																																				'',
																																				'',
																																				''
																																			),
																						left,
																						right
																					);

	mail_street_address							:=	if(	trim(le.assess_result.mail_prim_range)	+
																					trim(le.assess_result.mail_prim_name)
																					!=	'',
																					asses_mailing_street_address,
																					deeds_mailing_street_address
																				);

	mail_street_address2						:=	if(	trim(le.assess_result.mail_prim_range)	+
																					trim(le.assess_result.mail_prim_name)
																					!=	'',
																					asses_mailing_street_address2,
																					deeds_mailing_street_address2
																				);

	self.asses_fares_id							:=	le.assess_result.ln_fares_id;
	self.deeds_fares_id							:=	ri.deeds_result.ln_fares_id;
	self.tax_year										:=	le.assess_result.tax_year;
	self.assessed_year							:=	le.assess_result.assessed_value_year;
	self.recording_date							:=	ri.deeds_result.recording_date;
	self.priorityInd								:=	if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	ri.priorityInd	!=	'')
																					or	(self.asses_fares_id	=		''	and	self.deeds_fares_id	!=	''	and	ri.priorityInd	!=	''),
																					'PD',
																					if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	le.priorityInd	!=	''	and ri.priorityInd	=	'')
																							or	(self.asses_fares_id	!=	''	and	self.deeds_fares_id	=		''	and	le.priorityInd	!=	''),
																							'PA',
																							if(			(self.asses_fares_id	!=	''	and	self.deeds_fares_id	!=	''	and	ri.priorityInd	=	''	and le.priorityInd	=	'')
																									or	(self.asses_fares_id	=		''	and	self.deeds_fares_id	!=	''	and	ri.priorityInd	=	''),
																									'D',
																									'A'
																								)
																						)
																				);

	self.record_id									:=	if(le.assets_search.record_id != '', le.assets_search.record_id, ri.assets_search.record_id);
	self.owner1_first_name					:=	if(le.assess_result.owner1_fname != '', le.assess_result.owner1_fname, ri.deeds_result.owner1_fname);
	self.owner1_last_name						:=	if(le.assess_result.owner1_lname != '', le.assess_result.owner1_lname, ri.deeds_result.owner1_lname);
	self.owner1_middle_name					:=	if(le.assess_result.owner1_mname != '', le.assess_result.owner1_mname, ri.deeds_result.owner1_mname);
	self.owner1_company_name				:=	if(le.assess_result.owner1_cname != '', le.assess_result.owner1_cname, ri.deeds_result.owner1_cname);
	self.owner2_first_name					:=	if(le.assess_result.owner2_fname != '', le.assess_result.owner2_fname, ri.deeds_result.owner2_fname);
	self.owner2_last_name						:=	if(le.assess_result.owner2_lname != '', le.assess_result.owner2_lname, ri.deeds_result.owner2_lname);
	self.owner2_middle_name					:=	if(le.assess_result.owner2_mname != '', le.assess_result.owner2_mname, ri.deeds_result.owner2_mname);
	self.owner2_company_name				:=	if(le.assess_result.owner2_cname != '', le.assess_result.owner2_cname, ri.deeds_result.owner2_cname);
	self.property_street_address		:=	prop_street_address;
	self.property_street_address2		:=	prop_street_address2;
	self.property_city							:=	if(le.assess_result.property_city_name != '', le.assess_result.property_city_name, ri.deeds_result.property_city_name);
	self.property_state							:=	if(le.assess_result.property_st != '', le.assess_result.property_st, ri.deeds_result.property_st);
	self.property_zip								:=	if(le.assess_result.property_zip != '', le.assess_result.property_zip, ri.deeds_result.property_zip);
	self.mailing_street_address			:=	mail_street_address;
	self.mailing_street_address2		:=	mail_street_address2;
	self.mailing_city								:=	if(le.assess_result.mail_city_name != '', le.assess_result.mail_city_name, ri.deeds_result.mail_city_name);
	self.mailing_state							:=	if(le.assess_result.mail_st != '', le.assess_result.mail_st, ri.deeds_result.mail_st);
	self.mailing_zip								:=	if(le.assess_result.mail_zip != '', le.assess_result.mail_zip, ri.deeds_result.mail_zip);
	self.indicator_addresses_same		:=	if(	trim(self.property_street_address)	+
																					trim(self.property_street_address2)	+
																					trim(self.property_city)						+
																					trim(self.property_state)						+
																					trim(self.property_zip)
																					=
																					trim(self.mailing_street_address)		+
																					trim(self.mailing_street_address2)	+
																					trim(self.mailing_city)							+
																					trim(self.mailing_state)						+
																					trim(self.mailing_zip),
																					'Y',
																					'N'
																				);
	self.phone											:=	if(le.assess_result.assessee_phone_number != '', le.assess_result.assessee_phone_number, ri.deeds_result.phone_number);
	self.business_indicator					:=	if(self.owner1_company_name != '' or self.owner2_company_name != '', 'Y', 'N');
	self.lender_name								:=	ri.deeds_result.lender_name;
	self.title_company							:=	ri.deeds_result.title_company_name;
	self.county											:=	if(le.assess_result.county_name != '', le.assess_result.county_name, ri.deeds_result.county_name);
	self.parcel_number							:=	if(le.assess_result.apna_or_pin_number != '', le.assess_result.apna_or_pin_number, ri.deeds_result.apnt_or_pin_number);
	self.assessed_value							:=	le.assess_result.assessed_total_value;
	self.homeowner_exempt						:=	le.assess_result.homestead_homeowner_exemption;
	self.tax_amount									:=	le.assess_result.tax_amount;
	self.improvement_value					:=	le.assess_result.assessed_improvement_value;
	self.sale_date									:=	ri.deeds_result.contract_date[5..8] + ri.deeds_result.contract_date[1..4];
	self.sale_amount								:=	ri.deeds_result.sales_price;
	self.first_loan_amount					:=	ri.deeds_result.first_td_loan_amount;
	self.loan_type									:=	ri.deeds_result.loan_type_description;
	self.seller_first_name					:=	ri.deeds_result.seller1_fname;
	self.seller_last_name						:=	ri.deeds_result.seller1_lname;
	self.seller_middle_name					:=	ri.deeds_result.seller1_mname;
	self.seller_company_name				:=	ri.deeds_result.seller1_cname;
	self.sale_doc_number						:=	ri.deeds_result.document_number;
	self.transaction								:=	ri.deeds_result.document_type_description;
	self.second_loan_amount					:=	ri.deeds_result.second_td_loan_amount;
	self.deed_description						:=	ri.deeds_result.legal_brief_description;
	self.mortgage_due_date					:=	ri.deeds_result.first_td_due_date[5..8] + ri.deeds_result.first_td_due_date[1..4];
	self.standard_use_description		:=	le.assess_result.standard_use_description;
	self.year_built									:=	le.assess_result.year_built;
	self.number_of_units						:=	le.assess_result.no_of_units;
	self.number_fireplaces					:=	le.assess_result.fireplace_number;
	self.garage											:=	le.assess_result.garage_description;
	self.number_of_garage_stalls		:=	le.assess_result.parking_no_of_cars;
	self.construction_desc					:=	le.assess_result.construction_description;
	self.effective_year_built				:=	le.assess_result.effective_year_built;
	self.number_of_stories					:=	le.assess_result.no_of_stories;
	self.number_of_bedrooms					:=	le.assess_result.no_of_bedrooms;
	self.roofing_description				:=	le.assess_result.roofing_description;
	self.garage_sq_feet							:=	map(le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area_indicator[1]		=	'G'	=>	le.assess_result.building_area,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area1_indicator[1]	=	'G'	=>	le.assess_result.building_area1,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area2_indicator[1]	=	'G'	=>	le.assess_result.building_area2,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area3_indicator[1]	=	'G'	=>	le.assess_result.building_area3,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area4_indicator[1]	=	'G'	=>	le.assess_result.building_area4,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area5_indicator[1]	=	'G'	=>	le.assess_result.building_area5,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area6_indicator[1]	=	'G'	=>	le.assess_result.building_area6,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area7_indicator[1]	=	'G'	=>	le.assess_result.building_area7,
																					''
																					);
	self.basement_sq_feet						:=	map(le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area_indicator[1]		=	'W'	=>	le.assess_result.building_area,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area1_indicator[1]	=	'W'	=>	le.assess_result.building_area1,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area2_indicator[1]	=	'W'	=>	le.assess_result.building_area2,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area3_indicator[1]	=	'W'	=>	le.assess_result.building_area3,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area4_indicator[1]	=	'W'	=>	le.assess_result.building_area4,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area5_indicator[1]	=	'W'	=>	le.assess_result.building_area5,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area6_indicator[1]	=	'W'	=>	le.assess_result.building_area6,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area7_indicator[1]	=	'W'	=>	le.assess_result.building_area7,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area_indicator[1]		=	'R'	=>	le.assess_result.building_area,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area1_indicator[1]	=	'R'	=>	le.assess_result.building_area1,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area2_indicator[1]	=	'R'	=>	le.assess_result.building_area2,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area3_indicator[1]	=	'R'	=>	le.assess_result.building_area3,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area4_indicator[1]	=	'R'	=>	le.assess_result.building_area4,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area5_indicator[1]	=	'R'	=>	le.assess_result.building_area5,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area6_indicator[1]	=	'R'	=>	le.assess_result.building_area6,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area7_indicator[1]	=	'R'	=>	le.assess_result.building_area7,
																					''
																					);
	self.total_sq_feet							:=	map(le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area_indicator[1]		=	'T'	=>	le.assess_result.building_area,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area1_indicator[1]	=	'T'	=>	le.assess_result.building_area1,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area2_indicator[1]	=	'T'	=>	le.assess_result.building_area2,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area3_indicator[1]	=	'T'	=>	le.assess_result.building_area3,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area4_indicator[1]	=	'T'	=>	le.assess_result.building_area4,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area5_indicator[1]	=	'T'	=>	le.assess_result.building_area5,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area6_indicator[1]	=	'T'	=>	le.assess_result.building_area6,
																					le.assess_result.vendor_source_flag	=	'OKCTY'	and	le.assess_result.building_area7_indicator[1]	=	'T'	=>	le.assess_result.building_area7,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area_indicator[1]		=	'B'	=>	le.assess_result.building_area,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area1_indicator[1]	=	'B'	=>	le.assess_result.building_area1,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area2_indicator[1]	=	'B'	=>	le.assess_result.building_area2,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area3_indicator[1]	=	'B'	=>	le.assess_result.building_area3,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area4_indicator[1]	=	'B'	=>	le.assess_result.building_area4,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area5_indicator[1]	=	'B'	=>	le.assess_result.building_area5,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area6_indicator[1]	=	'B'	=>	le.assess_result.building_area6,
																					le.assess_result.vendor_source_flag	=	'FAR_F'	and	le.assess_result.building_area7_indicator[1]	=	'B'	=>	le.assess_result.building_area7,
																					''
																					);
	self.pool_indicator							:=	if(le.assess_result.pool_code != '', 'Y', '');
	self.heating_detail							:=	le.assess_result.heating_description;
	self.number_of_rooms						:=	le.assess_result.no_of_rooms;
	self.number_of_baths						:=	le.assess_result.no_of_baths;
	self.cooling_detail							:=	le.assess_result.cooling_description;
	self.lot_size										:=	if(le.assess_result.lot_size != '', le.assess_result.lot_size, ri.deeds_result.land_lot_size);
	self.lot_depth									:=	le.assess_result.lot_size_depth_feet;
	self.tract_number								:=	if(le.assess_result.legal_tract_number != '', le.assess_result.legal_tract_number, ri.deeds_result.legal_tract_number);
	self.lot_number									:=	if(le.assess_result.legal_lot_number != '', le.assess_result.legal_lot_number, ri.deeds_result.legal_lot_number);
	self.township										:=	if(le.assess_result.legal_city_municipality_township != '', le.assess_result.legal_city_municipality_township, ri.deeds_result.legal_city_municipality_township);
	self.subdivision_name						:=	if(le.assess_result.legal_subdivision_name != '', le.assess_result.legal_subdivision_name, ri.deeds_result.legal_subdivision_name);
	self.lot_width									:=	le.assess_result.lot_size_frontage_feet;
	self.zoning											:=	le.assess_result.zoning;
	self.block_number								:=	if(le.assess_result.legal_block != '', le.assess_result.legal_block, ri.deeds_result.legal_block);
	self.district										:=	if(le.assess_result.legal_district != '', le.assess_result.legal_district, ri.deeds_result.legal_district);
	self.section										:=	if(le.assess_result.legal_section != '', le.assess_result.legal_section, ri.deeds_result.legal_section);
end;

// Distribute datasets so as to do a local join
dAssetsAssesMatchInfo_dist	:=	distribute(dAssetsAssesMatchInfo,hash	(	assets_search.record_id,
																																				assess_result.property_prim_range,
																																				assess_result.property_prim_name,
																																				assess_result.property_zip
																																			)
																					);

dAssetsDeedsMatchInfo_dist	:=	distribute(dAssetsDeedsMatchInfo,hash(	assets_search.record_id,
																																				deeds_result.property_prim_range,
																																				deeds_result.property_prim_name,
																																				deeds_result.property_zip
																																			)
																					);

dAssetsMatchInfo	:=	join(	dAssetsAssesMatchInfo_dist,
														dAssetsDeedsMatchInfo_dist,
														ut.NNEQ(left.assess_result.fares_unformatted_apn, right.deeds_result.fares_unformatted_apn)	and
														left.assets_search.record_id						=	right.assets_search.record_id											and
														left.assess_result.fips_code						=	right.deeds_result.fips_code											and
														left.assess_result.property_prim_name		=	right.deeds_result.property_prim_name							and
														left.assess_result.property_prim_range	=	right.deeds_result.property_prim_range						and
														left.assess_result.property_sec_range		=	right.deeds_result.property_sec_range							and
														left.assess_result.property_zip					=	right.deeds_result.property_zip										and
														(
															(	trim(left.assess_result.owner1_fname)	+ trim(left.assess_result.owner1_lname)	+ trim(left.assess_result.owner1_mname)
																=
																trim(right.deeds_result.owner1_fname)	+ trim(right.deeds_result.owner1_lname)	+ trim(right.deeds_result.owner1_mname)
															)
															or
															(	trim(left.assess_result.owner1_fname)	+ trim(left.assess_result.owner1_lname)	+ trim(left.assess_result.owner1_mname)
																=
																trim(right.deeds_result.owner2_fname)	+ trim(right.deeds_result.owner2_lname)	+ trim(right.deeds_result.owner2_mname)
															)
															or
															(	trim(left.assess_result.owner2_fname)	+ trim(left.assess_result.owner2_lname)	+ trim(left.assess_result.owner2_mname)
																=
																trim(right.deeds_result.owner1_fname)	+ trim(right.deeds_result.owner1_lname)	+ trim(right.deeds_result.owner1_mname)
															)
															or
															(	trim(left.assess_result.owner2_fname)	+ trim(left.assess_result.owner2_lname)	+ trim(left.assess_result.owner2_mname)
																=
																trim(right.deeds_result.owner2_fname)	+ trim(right.deeds_result.owner2_lname)	+ trim(right.deeds_result.owner2_mname)
															)
														),
														tMatchInfo(left,right),
														full outer,
														local
														)	:	persist('persist::property::append');

// output(dAssetsMatchInfo(record_id	in	['5001','5033']),named('test_sample'));
/*
dAssetsMatchInfo_dist		:=	distribute(	dAssetsMatchInfo(			owner1_last_name		!=	''
																													or	owner1_company_name	!=	''
																												),
																				hash(record_id)
																			);
*/
dAssetsMatchInfo_sort		:=	sort(	dAssetsMatchInfo,
																	record_id,
																	-priorityInd,
																	property_street_address,
																	property_street_address2,
																	property_city,
																	property_state,
																	property_zip,
																	-recording_date,
																	-(sale_date[4..8]+sale_date[1..4]),
																	-tax_year,
																	-assessed_year
																);

dAssetsMatchInfo_dedup	:=	dedup	(	dAssetsMatchInfo_sort,
																		record_id,
																		property_street_address,
																		property_street_address2,
																		property_city,
																		property_state,
																		property_zip,
																		recording_date,
																		sale_doc_number,
																		all
																	);

// Restrict to 5 records per record_id
dAssetsMatchInfo_final	:=	dedup(	sort(distribute(dAssetsMatchInfo_dedup,hash(record_id)),record_id,-priorityInd,local),
																		record_id,
																		keep 5,
																		local
																	);

output(choosen(dAssetsMatchInfo_final,1000),named('fds_matches'));

// Remove extraneous fields
dMatch	:=	project	(	dAssetsMatchInfo_final,
											transform(layout_assets.response.rFDSProperty_layout,self	:=	left)
										);

/*
// Project no matches file to the resultant out layout
layout_assets.response.rFDSProperty_layout	tConvertNoMatch2Out(dAssetsNoMatch	pInput)	:=
transform
	self.record_id	:=	pInput.assets_search.record_id;
	self						:=	[];
end;

dNoMatch	:=	project(dAssetsNoMatch,tConvertNoMatch2Out(left));

// Project no search file to the resultant out layout
layout_assets.response.rFDSProperty_layout	tConvertNoSearch2Out(dAssetsNoSearch	pInput)	:=
transform
	self.record_id	:=	pInput.record_id;
	self						:=	[];
end;

dNoSearch	:=	project(dAssetsNoSearch,tConvertNoSearch2Out(left));
*/

// Combine all the records and write to out file
dAll	:=	join(	dAssetsIn,
								dMatch,
								left.record_id	=	right.record_id,
								transform(layout_assets.response.rFDSProperty_layout,
													self.record_id	:=	left.record_id;
													self						:=	right;
													),
								left outer
							);

// counts total number of unique record id's in the outfile
dAll_sort	:=	sort(dAll,(integer)record_id);

cntUniqueRecIds	:=	count(dedup(dAll,record_id,all));

outPropertyAppend_fixed	:=	output(	dAll_sort,,
																			'~thor_data400::out::fds_test::assets::property_append_fixed',
																			__compressed__,
																			overwrite
																		);

outPropertyAppend				:=	output(	dAll_sort,,
																			'~thor_data400::out::fds_test::assets::property_append',
																			csv(heading(single),separator('|'),terminator('\n')),
																			__compressed__,
																			overwrite
																		);

// population counts for all fields
rStats_layout	:=
record
	string3	statGroup										:=	'ALL';
	cntTotal														:=	count(group);
	cntRecordID_CountNonBlank						:=	sum(group,if(dAll.Record_ID									!=	'',1,0));
	cntOwner1_FirstName_CountNonBlank		:=	sum(group,if(dAll.Owner1_First_Name					!=	'',1,0));
	cntOwner1_MiddleName_CountNonBlank	:=	sum(group,if(dAll.Owner1_Middle_Name				!=	'',1,0));
	cntOwner1_LastName_CountNonBlank		:=	sum(group,if(dAll.Owner1_Last_Name					!=	'',1,0));
	cntOwner1_CompanyName_CountNonBlank	:=	sum(group,if(dAll.Owner1_Company_Name				!=	'',1,0));
	cntOwner2_FirstName_CountNonBlank		:=	sum(group,if(dAll.Owner2_First_Name					!=	'',1,0));
	cntOwner2_MiddleName_CountNonBlank	:=	sum(group,if(dAll.Owner2_Middle_Name				!=	'',1,0));
	cntOwner2_LastName_CountNonBlank		:=	sum(group,if(dAll.Owner2_Last_Name					!=	'',1,0));
	cntOwner2_CompanyName_CountNonBlank	:=	sum(group,if(dAll.Owner2_Company_Name				!=	'',1,0));
	cntPropStAddr1_CountNonBlank				:=	sum(group,if(dAll.Property_Street_Address		!=	'',1,0));
	cntPropStAddr2_CountNonBlank				:=	sum(group,if(dAll.Property_Street_Address2	!=	'',1,0));
	cntPropCity_CountNonBlank						:=	sum(group,if(dAll.Property_City							!=	'',1,0));
	cntPropState_CountNonBlank					:=	sum(group,if(dAll.Property_State						!=	'',1,0));
	cntPropZip_CountNonBlank						:=	sum(group,if(dAll.Property_Zip							!=	'',1,0));
	cntMailStAddr1_CountNonBlank				:=	sum(group,if(dAll.Mailing_Street_Address		!=	'',1,0));
	cntMailStAddr2_CountNonBlank				:=	sum(group,if(dAll.Mailing_Street_Address2		!=	'',1,0));
	cntMailCity_CountNonBlank						:=	sum(group,if(dAll.Mailing_City							!=	'',1,0));
	cntMailState_CountNonBlank					:=	sum(group,if(dAll.Mailing_State							!=	'',1,0));
	cntMailZip_CountNonBlank						:=	sum(group,if(dAll.Mailing_Zip								!=	'',1,0));
	cntAddrSameInd_CountNonBlank				:=	sum(group,if(dAll.Indicator_Addresses_Same	!=	'',1,0));
	cntPhone_CountNonBlank							:=	sum(group,if(dAll.Phone											!=	'',1,0));
	cntBusInd_CountNonBlank							:=	sum(group,if(dAll.Business_Indicator				!=	'',1,0));
	cntLenderName_CountNonBlank					:=	sum(group,if(dAll.Lender_Name								!=	'',1,0));
	cntTitleCompany_CountNonBlank				:=	sum(group,if(dAll.Title_Company							!=	'',1,0));
	cntCounty_CountNonBlank							:=	sum(group,if(dAll.County										!=	'',1,0));
	cntParcelNumber_CountNonBlank				:=	sum(group,if(dAll.Parcel_Number							!=	'',1,0));
	cntAssesedVal_CountNonBlank					:=	sum(group,if(dAll.Assessed_Value						!=	'',1,0));
	cntHomeOwnerExempt_CountNonBlank		:=	sum(group,if(dAll.Homeowner_Exempt					!=	'',1,0));
	cntTaxAmt_CountNonBlank							:=	sum(group,if(dAll.Tax_Amount								!=	'',1,0));
	cntImprovementValue_CountNonBlank		:=	sum(group,if(dAll.Improvement_Value					!=	'',1,0));
	cntSaleDate_CountNonBlank						:=	sum(group,if(dAll.Sale_Date									!=	'',1,0));
	cntSaleAmt_CountNonBlank						:=	sum(group,if(dAll.Sale_Amount								!=	'',1,0));
	cntFirstLoanAmt_CountNonBlank				:=	sum(group,if(dAll.First_Loan_Amount					!=	'',1,0));
	cntLoanType_CountNonBlank						:=	sum(group,if(dAll.Loan_Type									!=	'',1,0));
	cntSellerFirstName_CountNonBlank		:=	sum(group,if(dAll.Seller_First_Name					!=	'',1,0));
	cntSellerMiddleName_CountNonBlank		:=	sum(group,if(dAll.Seller_Middle_Name				!=	'',1,0));
	cntSellerLastName_CountNonBlank			:=	sum(group,if(dAll.Seller_Last_Name					!=	'',1,0));
	cntSellerCompanyName_CountNonBlank	:=	sum(group,if(dAll.Seller_Company_Name				!=	'',1,0));
	cntSaleDocNum_CountNonBlank					:=	sum(group,if(dAll.Sale_Doc_Number						!=	'',1,0));
	cntTransaction_CountNonBlank				:=	sum(group,if(dAll.Transaction								!=	'',1,0));
	cntSecondLoanAmt_CountNonBlank			:=	sum(group,if(dAll.Second_Loan_Amount				!=	'',1,0));
	cntDeedDesc_CountNonBlank						:=	sum(group,if(dAll.Deed_Description					!=	'',1,0));
	cntMortDueDate_CountNonBlank				:=	sum(group,if(dAll.Mortgage_Due_Date					!=	'',1,0));
	cntStandarcUseDesc_CountNonBlank		:=	sum(group,if(dAll.Standard_Use_Description	!=	'',1,0));
	cntYearBuilt_CountNonBlank					:=	sum(group,if(dAll.Year_Built								!=	'',1,0));
	cntNumUnits_CountNonBlank						:=	sum(group,if(dAll.Number_of_Units						!=	'',1,0));
	cntNumFireplaces_CountNonBlank			:=	sum(group,if(dAll.Number_Fireplaces					!=	'',1,0));
	cntGarage_CountNonBlank							:=	sum(group,if(dAll.Garage										!=	'',1,0));
	cntNumGarages_CountNonBlank					:=	sum(group,if(dAll.Number_of_Garage_Stalls		!=	'',1,0));
	cntConstDesc_CountNonBlank					:=	sum(group,if(dAll.Construction_desc					!=	'',1,0));
	cntEffYearBuilt_CountNonBlank				:=	sum(group,if(dAll.Effective_Year_Built			!=	'',1,0));
	cntNumStories_CountNonBlank					:=	sum(group,if(dAll.Number_of_Stories					!=	'',1,0));
	cntPoolInd_CountNonBlank						:=	sum(group,if(dAll.Pool_Indicator						!=	'',1,0));
	cntNumBedrooms_CountNonBlank				:=	sum(group,if(dAll.Number_of_Bedrooms				!=	'',1,0));
	cntRoofingDesc_CountNonBlank				:=	sum(group,if(dAll.Roofing_Description				!=	'',1,0));
	cntGarageSqFeet_CountNonBlank				:=	sum(group,if(dAll.Garage_Sq_Feet						!=	'',1,0));
	cntBasementSqFeet_CountNonBlank			:=	sum(group,if(dAll.Basement_Sq_Feet					!=	'',1,0));
	cntTotalSqFeet_CountNonBlank				:=	sum(group,if(dAll.Total_Sq_Feet							!=	'',1,0));
	cntHeatingDeatail_CountNonBlank			:=	sum(group,if(dAll.Heating_Detail						!=	'',1,0));
	cntNumRooms_CountNonBlank						:=	sum(group,if(dAll.Number_of_Rooms						!=	'',1,0));
	cntNumBaths_CountNonBlank						:=	sum(group,if(dAll.Number_of_Baths						!=	'',1,0));
	cntCoolingDetail_CountNonBlank			:=	sum(group,if(dAll.Cooling_Detail						!=	'',1,0));
	cntLotSize_CountNonBlank						:=	sum(group,if(dAll.Lot_Size									!=	'',1,0));
	cntLotDepth_CountNonBlank						:=	sum(group,if(dAll.Lot_Depth									!=	'',1,0));
	cntTractNum_CountNonBlank						:=	sum(group,if(dAll.Tract_Number							!=	'',1,0));
	cntLotNum_CountNonBlank							:=	sum(group,if(dAll.Lot_Number								!=	'',1,0));
	cntTownship_CountNonBlank						:=	sum(group,if(dAll.Township									!=	'',1,0));
	cntSubdivName_CountNonBlank					:=	sum(group,if(dAll.Subdivision_Name					!=	'',1,0));
	cntLotWidth_CountNonBlank						:=	sum(group,if(dAll.Lot_Width									!=	'',1,0));
	cntZoning_CountNonBlank							:=	sum(group,if(dAll.Zoning										!=	'',1,0));
	cntBlockNumber_CountNonBlank				:=	sum(group,if(dAll.Block_Number							!=	'',1,0));
	cntDistrict_CountNonBlank						:=	sum(group,if(dAll.District									!=	'',1,0));
	cntSection_CountNonBlank						:=	sum(group,if(dAll.Section										!=	'',1,0));
end;

dPopulationStats			:=	table(dAll,rStats_layout,few);

outPopulationStats		:=	output(dPopulationStats,all,named('PropertyExtract_PopulationStats'));

// get total counts for all searches
cntTotalSSNSearch							:=	count(dAssetsCleanNameAddr(pSSNSearch));
cntTotalNamePartialSSNSearch	:=	count(dAssetsCleanNameAddr(pNamePartialSSNSearch));
cntTotalNameAddrSearch				:=	count(dAssetsCleanNameAddr(pNameAddrSearch));
cntTotalBusNameAddrSearch			:=	count(dAssetsCleanNameAddr(pBusNameAddrSearch));
cntTotalAddrSearch						:=	count(dAssetsCleanNameAddr(pAddrSearch));
cntTotalNameStSearch					:=	count(dAssetsCleanNameAddr(pNameStSearch));
cntTotalNameZipSearch					:=	count(dAssetsCleanNameAddr(pNameZipSearch));
cntTotalBusNameCityStSearch		:=	count(dAssetsCleanNameAddr(pBusNameCityStSearch));
cntTotalPhoneSearch						:=	count(dAssetsCleanNameAddr(pPhoneSearch));

cntTotalSearch								:=		cntTotalSSNSearch
																	+	cntTotalNamePartialSSNSearch
																	+	cntTotalNameAddrSearch
																	+	cntTotalBusNameAddrSearch
																	+	cntTotalAddrSearch
																	+	cntTotalNameStSearch
																	+	cntTotalNameZipSearch
																	+	cntTotalBusNameCityStSearch;
																	+	cntTotalPhoneSearch;

// counts for searches with no matches
cntSSNNoMatch							:=	count(dAssetsSSNNoMatch);
cntNamePartialSSNNoMatch	:=	count(dAssetsNamePartialSSNNoMatch);
cntNameAddrNoMatch				:=	count(dAssetsNameAddrNoMatch);
cntBusNameAddrNoMatch			:=	count(dAssetsBusNameAddrNoMatch);
cntAddrNoMatch						:=	count(dAssetsAddrNoMatch);
cntNameStNoMatch					:=	count(dAssetsNameStNoMatch);
cntNameZipNoMatch					:=	count(dAssetsNameZipNoMatch);
cntBusNameCityStNoMatch		:=	count(dAssetsBusNameCityStNoMatch);
cntPhoneNoMatch						:=	count(dAssetsPhoneNoMatch);

cntTotalNoMatch						:=		cntSSNNoMatch
															+	cntNamePartialSSNNoMatch
															+	cntNameAddrNoMatch
															+	cntBusNameAddrNoMatch
															+	cntAddrNoMatch
															+	cntNameStNoMatch
															+	cntNameZipNoMatch
															+	cntBusNameCityStNoMatch;
															+	cntPhoneNoMatch;

// match rates for searches
matchRateTotal								:=	(real8)((cntTotalSearch - cntTotalNoMatch)/cntTotalSearch)*100;
matchRateSSNSearch						:=	(real8)((cntTotalSSNSearch - CntSSNNoMatch)/cntTotalSSNSearch)*100;
matchRateNamePartialSSNSearch	:=	(real8)((cntTotalNamePartialSSNSearch - cntNamePartialSSNNoMatch)/cntTotalNamePartialSSNSearch)*100;
matchRateNameAddrSearch				:=	(real8)((cntTotalNameAddrSearch - cntNameAddrNoMatch)/cntTotalNameAddrSearch)*100;
matchRateBusNameAddrSearch		:=	(real8)((cntTotalBusNameAddrSearch - cntBusNameAddrNoMatch)/cntTotalBusNameAddrSearch)*100;
matchRateAddrSearch						:=	(real8)((cntTotalAddrSearch - cntAddrNoMatch)/cntTotalAddrSearch)*100;
matchRateNameStSearch					:=	(real8)((cntTotalNameStSearch - cntNameStNoMatch)/cntTotalNameStSearch)*100;
matchRateNameZipSearch				:=	(real8)((cntTotalNameZipSearch - cntNameZipNoMatch)/cntTotalNameZipSearch)*100;
matchRateBusNameCityStSearch	:=	(real8)((cntTotalBusNameCityStSearch - cntBusNameCityStNoMatch)/cntTotalBusNameCityStSearch)*100;
matchRatePhoneSearch					:=	(real8)((cntTotalPhoneSearch - cntPhoneNoMatch)/cntTotalPhoneSearch)*100;


export PropertyAppend :=	sequential(	outPropertyAppend_fixed,
																				outPropertyAppend,
																				outPopulationStats,
																				output(dMatch,													named('QA_Sample_Records')),
																				output(cntUniqueRecIds,								named('Cnt_Unique_RecID')),
																				output(cntSSNNoMatch,									named('Cnt_SSN_NoMatch')),
																				output(cntNamePartialSSNNoMatch,				named('Cnt_NamePartialSSN_NoMatch')),
																				output(cntNameAddrNoMatch,							named('Cnt_NameAddr_NoMatch')),
																				output(cntBusNameAddrNoMatch,					named('Cnt_BusNameAddr_NoMatch')),
																				output(cntAddrNoMatch,									named('Cnt_Addr_NoMatch')),
																				output(cntNameStNoMatch,								named('Cnt_NameState_NoMatch')),
																				output(cntNameZipNoMatch,							named('Cnt_NameZip_NoMatch')),
																				output(cntBusNameCityStNoMatch,				named('Cnt_BusNameCityState_NoMatch')),
																				output(cntPhoneNoMatch,								named('Cnt_Phone_NoMatch')),
																				output(matchRateTotal,									named('MatchRate_Total'));
																				output(matchRateSSNSearch,							named('MatchRate_SSN')),
																				output(matchRateNamePartialSSNSearch,	named('MatchRate_NamePartialSSN')),
																				output(matchRateNameAddrSearch,				named('MatchRate_NameAddr')),
																				output(matchRateBusNameAddrSearch,			named('MatchRate_BusNameAddr')),
																				output(matchRateAddrSearch,						named('MatchRate_Addr')),
																				output(matchRateNameStSearch,					named('MatchRate_NameState')),
																				output(matchRateNameZipSearch,					named('MatchRate_NameZip')),
																				output(matchRateBusNameCityStSearch,		named('MatchRate_BusNameCityState')),
																				output(matchRatePhoneSearch,						named('MatchRate_Phone'))
																			);