import address,business_header,canadianphones,ut;

dCanadianPhone	:=	canadianphones.file_CanadianWhitePagesBase;
dNewDataIn			:=	dataset	(	ut.foreign_prod+'~thor_data400::in::fds_test::20091223::newdata::canadianphones',
															FDS_Test.layout_newdata.input.canadianphone,
															CSV(HEADING(1),SEPARATOR(['|']), TERMINATOR(['\r\n', '\n']))
														);

rNewDataClean_layout	:=
record
	dNewDataIn;
	Address.layout_clean_canada109;
	Address.Layout_Clean_Name;
end;

rNewDataClean_layout	tNewDataCleanNameAddr(dNewDataIn pInput)	:=
transform
	clean_address			:=	Address.CleanCanadaAddress109	(	trim(pInput.address,left,right),
																												trim(pInput.city,left,right) 							+
																												' '																				+
																												trim(pInput.province,left,right)					+
																												' '																				+
																												trim(pInput.zip_code,left,right)
																											);

	clean_name				:=	Address.CleanPersonFML73_fields(trim(pInput.Name,left,right));
	
	self.prim_range 	:= clean_address[1..10];
	self.predir				:= clean_address[11..12];
	self.prim_name 		:= clean_address[13..40];
	self.addr_suffix 	:= clean_address[41..44];
	self.unit_desig 	:= clean_address[45..54];
	self.sec_range 		:= clean_address[55..62];
	self.p_city_name 	:= clean_address[63..92];
	self.st						:= clean_address[93..94];
	self.zip					:= clean_address[95..100];
	self.rec_type   	:= clean_address[101..102];
	self.language 		:= clean_address[103];
	self.err_stat			:= clean_address[104..109];
	
	self.title				:=	clean_name.title;
	self.fname				:=	clean_name.fname;
	self.mname				:=	clean_name.mname;
	self.lname				:=	clean_name.lname;
	self.name_suffix	:=	clean_name.name_suffix;
	self.name_score		:=	clean_name.name_score;
	
	self							:=	pInput;
end;

dNewDataCleanNameAddr	:=	project(dNewDataIn,tNewDataCleanNameAddr(left));


boolean	pNameSINSearch					:=			regexfind('^[0-9]{9}$',dNewDataCleanNameAddr.sin)
																		and	dNewDataCleanNameAddr.Name																!=	''
																		and	dNewDataCleanNameAddr.sin																	not in	['111111111','999999999'];

boolean	pNameAddrSearch					:=			dNewDataCleanNameAddr.Name																!=	''
																		and	dNewDataCleanNameAddr.Address															!=	'';
																	
boolean	pNameCityProvinceSearch	:=			dNewDataCleanNameAddr.Name																!=	''
																		and	dNewDataCleanNameAddr.Address															=		''
																		and	dNewDataCleanNameAddr.City																!=	''
																		and	dNewDataCleanNameAddr.Province														!=	'';

boolean	pNameZipSearch					:=			dNewDataCleanNameAddr.Name																!=	''
																		and	dNewDataCleanNameAddr.Address															=		''
																		and	dNewDataCleanNameAddr.City																=		''
																		and	dNewDataCleanNameAddr.Province														=		''
																		and	dNewDataCleanNameAddr.Zip_Code														!=	'';


boolean	pAddressSearch					:=			dNewDataCleanNameAddr.Name																 =	''
																		and	dNewDataCleanNameAddr.Address															!=	'';
																	
boolean	pSINSearch							:=			regexfind('^[0-9]{9}$',dNewDataCleanNameAddr.sin)
																		and	dNewDataCleanNameAddr.Name																=		''
																		and	dNewDataCleanNameAddr.sin																	not in	['111111111','999999999'];

// Common record layout for all the searches
rNewDataMatch_layout	:=
record
	recordof(dNewDataCleanNameAddr)	NewDataSearch;
	recordof(dCanadianPhone)				AppendCanadianPhoneSrchResults;
end;

// Common transform being used for all the searches
rNewDataMatch_layout	tGetMatches(CanadianPhones.layoutCanadianWhitepagesBase le, rNewDataClean_layout ri)	:=
transform
	self.AppendCanadianPhoneSrchResults	:=	le;
	self.NewDataSearch									:=	ri;
end;

// Search1 - Match on Name and Address
dCanadianPhoneNameAddr	:=	dCanadianPhone(			lname				!=	''
																						and	prim_range	!=	''
																						and	prim_name		!=	''
																						and	zip					!=	''
																					);

dNameAddrMatch			:=	join(	dCanadianPhoneNameAddr,
															dNewDataCleanNameAddr(pNameAddrSearch),
															left.fname				=	right.fname				and
															left.lname				=	right.lname				and
															left.prim_range		=	right.prim_range	and
															left.prim_name		=	right.prim_name		and
															left.predir				=	right.predir			and
															left.sec_range		=	right.sec_range		and
															left.p_city_name	=	right.p_city_name	and
															left.state				=	right.st					and
															left.zip					=	right.zip,
															tGetMatches(left,right)
														);

dNameAddrNoMatch		:=	join(	dCanadianPhoneNameAddr,
															dNewDataCleanNameAddr(pNameAddrSearch),
															left.fname				=	right.fname				and
															left.lname				=	right.lname				and
															left.prim_range		=	right.prim_range	and
															left.prim_name		=	right.prim_name		and
															left.predir				=	right.predir			and
															left.sec_range		=	right.sec_range		and
															left.p_city_name	=	right.p_city_name	and
															left.state				=	right.st					and
															left.zip					=	right.zip,
															tGetMatches(left,right),
															right only
														);

// output(sort(dNameAddrMatch,(integer)NewDataSearch.record_id),named('NameAddr_Match'));
// output(sort(dNameAddrNoMatch,(integer)NewDataSearch.record_id),named('NameAddr_NoMatch'));

// Search2 - Match on name, city and province
dCanadianPhoneNameCityProvince	:=	dCanadianPhone(			lname				!=	''
																										and	prim_range	!=	''
																										and	prim_name		!=	''
																										and	p_city_name	!=	''
																										and	state				!=	''
																									);

dNameCityProvinceMatch			:=	join(	dCanadianPhoneNameCityProvince,
																			dNewDataCleanNameAddr(pNameCityProvinceSearch),
																			left.fname				=	right.fname				and
																			left.lname				=	right.lname				and
																			left.p_city_name	=	right.p_city_name	and
																			left.state				=	right.st,
																			tGetMatches(left,right)
																		);

dNameCityProvinceNoMatch		:=	join(	dCanadianPhoneNameCityProvince,
																			dNewDataCleanNameAddr(pNameCityProvinceSearch),
																			left.fname				=	right.fname				and
																			left.lname				=	right.lname				and
																			left.p_city_name	=	right.p_city_name	and
																			left.state				=	right.st,
																			tGetMatches(left,right),
																			right only
																		);

// output(sort(dNameCityProvinceMatch,(integer)NewDataSearch.record_id),named('NameCityProvince_Match'));
// output(sort(dNameCityProvinceNoMatch,(integer)NewDataSearch.record_id),named('NameCityProvince_NoMatch'));

// Search3 - Name and Zip Search
dCanadianPhoneNameZip	:=	dCanadianPhone(lname 	!=	''	and	zip	!=	'');

dNameZipMatch		:=	join(	dCanadianPhoneNameZip,
													dNewDataCleanNameAddr(pNameZipSearch),
													left.lname	=	right.lname	and
													left.fname	=	right.fname	and
													left.mname	=	right.mname	and
													left.zip		=	right.zip,
													tGetMatches(left,right)
												);

dNameZipNoMatch	:=	join(	dCanadianPhoneNameZip,
													dNewDataCleanNameAddr(pNameZipSearch),
													left.lname	=	right.lname	and
													left.fname	=	right.fname	and
													left.mname	=	right.mname	and
													left.zip		=	right.zip,
													tGetMatches(left,right),
													right only
												);

// output(sort(dNameZipMatch,(integer)NewDataSearch.record_id),named('NameZip_Match'));
// output(sort(dNameZipNoMatch,(integer)NewDataSearch.record_id),named('NameZip_NoMatch'));

// Search4 - Address Search
dCanadianPhoneAddr	:=	dCanadianPhone(			prim_range	!=	''
																				and	prim_name		!=	''
																				and	zip					!=	''
																			);

dAddrMatch			:=	join(	dCanadianPhoneAddr,
													dNewDataCleanNameAddr(pAddressSearch),
													left.prim_range		=	right.prim_range	and
													left.prim_name		=	right.prim_name		and
													left.predir				=	right.predir			and
													left.sec_range		=	right.sec_range		and
													left.p_city_name	=	right.p_city_name	and
													left.state				=	right.st					and
													left.zip					=	right.zip,
													tGetMatches(left,right)
												);

dAddrNoMatch		:=	join(	dCanadianPhoneAddr,
													dNewDataCleanNameAddr(pAddressSearch),
													left.prim_range		=	right.prim_range	and
													left.prim_name		=	right.prim_name		and
													left.predir				=	right.predir			and
													left.sec_range		=	right.sec_range		and
													left.p_city_name	=	right.p_city_name	and
													left.state				=	right.st					and
													left.zip					=	right.zip,
													tGetMatches(left,right),
													right only
												);

// output(sort(dAddrMatch,(integer)NewDataSearch.record_id),named('Address_Match'));
// output(sort(dAddrNoMatch,(integer)NewDataSearch.record_id),named('Address_NoMatch'));

// FDS Resultset
dCanadianPhoneMatches		:=		dNameAddrMatch
														+	dAddrMatch
														+	dNameZipMatch
														+	dNameCityProvinceMatch;

dCanadianPhoneNoMatches	:=		dNameAddrNoMatch
														+	dAddrNoMatch
														+	dNameZipNoMatch
														+	dNameCityProvinceNoMatch;

// Convert to FDS layout
layout_NewData.response.rFDSCanadianPhone_layout	tConvert2Out(dCanadianPhoneMatches pInput)	:=
transform
	self.Record_ID			:=	pInput.NewDataSearch.Record_ID;
	self.First_Name			:=	pInput.AppendCanadianPhoneSrchResults.fname;
	self.Middle_Name		:=	pInput.AppendCanadianPhoneSrchResults.mname;
	self.Last_Name			:=	pInput.AppendCanadianPhoneSrchResults.lname;
	self.Company_Name		:=	pInput.AppendCanadianPhoneSrchResults.company_name;
	self.Address_Line1	:=	trim(	if(trim(pInput.AppendCanadianPhoneSrchResults.prim_range)	!=	'',trim(pInput.AppendCanadianPhoneSrchResults.prim_range)	+	' ','')	+
																if(trim(pInput.AppendCanadianPhoneSrchResults.predir)			!=	'',trim(pInput.AppendCanadianPhoneSrchResults.predir)			+	' ','')	+
																if(trim(pInput.AppendCanadianPhoneSrchResults.prim_name)	!=	'',trim(pInput.AppendCanadianPhoneSrchResults.prim_name)	+	' ','')	+
																trim(pInput.AppendCanadianPhoneSrchResults.addr_suffix)
															);
	self.Address_Line2	:=	trim(	if(trim(pInput.AppendCanadianPhoneSrchResults.unit_desig)	!=	'',trim(pInput.AppendCanadianPhoneSrchResults.unit_desig)	+	' ','')	+
																trim(pInput.AppendCanadianPhoneSrchResults.sec_range)
															);
	self.City						:=	pInput.AppendCanadianPhoneSrchResults.p_city_name;
	self.State					:=	pInput.AppendCanadianPhoneSrchResults.state;
	self.Zip						:=	pInput.AppendCanadianPhoneSrchResults.zip;
	self.Phone_Number		:=	pInput.AppendCanadianPhoneSrchResults.phonenumber;
	self.Publish_Date		:=	if(	pInput.AppendCanadianPhoneSrchResults.pub_date	=	'',
															'',
															pInput.AppendCanadianPhoneSrchResults.pub_date[5..6]+'00'+pInput.AppendCanadianPhoneSrchResults.pub_date[1..4]
														);
end;

dFDSCanadianPhoneMatches	:=	project(dCanadianPhoneMatches,tConvert2Out(left));

dAll	:=	join(	dNewDataIn,
								dFDSCanadianPhoneMatches,
								left.record_id	=	right.record_id,
								transform(	layout_NewData.response.rFDSCanadianPhone_layout,
														self.record_id	:=	left.record_id;
														self	:=	right;
														self	:=	[];
													),
								left outer
							);

// Remove duplicate records
dAll_dist		:=	distribute(	dAll,
														hash(record_id)
													);

dAll_sort		:=	sort(	dAll_dist,
											record_id,
											first_name,
											last_name,
											address_line1,
											address_line2,
											city,
											state,
											zip,
											Phone_Number,
											-publish_date,
											local
										);

dAll_dedup	:=	dedup(	dAll_sort,
												record_id,
												first_name,
												last_name,
												address_line1,
												address_line2,
												city,
												state,
												zip,
												Phone_Number,
												local
											);

dOut	:=	sort(dedup(dAll_dedup,record_id,keep(5),local),(integer)record_id);

// Population Stats
rPPlStats_layout	:=
record
	string3	strGrp						:=	'ALL';
	cntTotalGrp								:=	count(group);
	cntRecordID_NonBlank			:=	sum(group,if(dAll_dedup.Record_ID			!=	'',1,0));
	cntFirstName_NonBlank			:=	sum(group,if(dAll_dedup.First_Name		!=	'',1,0));
	cntMiddleName_NonBlank		:=	sum(group,if(dAll_dedup.Middle_Name		!=	'',1,0));
	cntLastName_NonBlank			:=	sum(group,if(dAll_dedup.Last_Name			!=	'',1,0));
	cntCompanyName_NonBlank		:=	sum(group,if(dAll_dedup.Company_Name	!=	'',1,0));
	cntAddressLine1_NonBlank	:=	sum(group,if(dAll_dedup.Address_Line1	!=	'',1,0));
	cntAddressLine2_NonBlank	:=	sum(group,if(dAll_dedup.Address_Line2	!=	'',1,0));
	cntCity_NonBlank					:=	sum(group,if(dAll_dedup.City					!=	'',1,0));
	cntState_NonBlank					:=	sum(group,if(dAll_dedup.State					!=	'',1,0));
	cntZip_NonBlank						:=	sum(group,if(dAll_dedup.Zip						!=	'',1,0));
	cntPhoneNumber_NonBlank		:=	sum(group,if(dAll_dedup.Phone_Number	!=	'',1,0));
	cntPublishDate_NonBlank		:=	sum(group,if(dAll_dedup.Publish_Date	!=	'',1,0));
end;

dPopulationStats						:=	table(dOut,rPPlStats_layout,few);
outPopulationStats					:=	output(dPopulationStats,named('CanadianPhoneAppend_PopulationStats'));

outCanadianPhoneAppendFixed	:=	output(	dOut,,
																				'~thor_data400::out::fds_test::NewData::canadianphone_append_fixed',
																				overwrite,
																				__compressed__
																			);

outCanadianPhoneAppend			:=	output(	dOut,,
																				'~thor_data400::out::fds_test::NewData::canadianphone_append',
																				CSV(HEADING(single),SEPARATOR('|'), TERMINATOR('\n')),
																				overwrite,
																				__compressed__
																			);

// Counts for different search criteria for NewData file
cntTotalNameAddrSearch					:=	count(dNewDataCleanNameAddr(pNameAddrSearch));
cntTotalAddrSearch							:=	count(dNewDataCleanNameAddr(pAddressSearch));
cntTotalNameZipSearch						:=	count(dNewDataCleanNameAddr(pNameZipSearch));
cntTotalNameCityProvinceSearch	:=	count(dNewDataCleanNameAddr(pNameCityProvinceSearch));

cntTotalSearch								:=		cntTotalNameAddrSearch
																	+	cntTotalAddrSearch
																	+	cntTotalNameZipSearch
																	+	cntTotalNameCityProvinceSearch;

// counts for searches with no matches
cntNameAddrNoMatch					:=	count(dNameAddrNoMatch);
cntAddrNoMatch							:=	count(dAddrNoMatch);
cntNameZipNoMatch						:=	count(dNameZipNoMatch);
cntNameCityProvinceNoMatch	:=	count(dNameCityProvinceNoMatch);

cntTotalNoMatch						:=		cntNameAddrNoMatch
															+	cntAddrNoMatch
															+	cntNameZipNoMatch
															+	cntNameCityProvinceNoMatch;

// match rates for searches
matchRateTotal									:=	(real4)((cntTotalSearch - cntTotalNoMatch)/cntTotalSearch)*100;
matchRateNameAddrSearch					:=	(real4)((cntTotalNameAddrSearch - cntNameAddrNoMatch)/cntTotalNameAddrSearch)*100;
matchRateAddrSearch							:=	(real4)((cntTotalAddrSearch - cntAddrNoMatch)/cntTotalAddrSearch)*100;
matchRateNameZipSearch					:=	(real4)((cntTotalNameZipSearch - cntNameZipNoMatch)/cntTotalNameZipSearch)*100;
matchRateNameCityProvinceSearch	:=	(real4)((cntTotalNameCityProvinceSearch - cntNameCityProvinceNoMatch)/cntTotalNameCityProvinceSearch)*100;

export CanadianPhoneAppend := sequential(	outCanadianPhoneAppendFixed,
																					outCanadianPhoneAppend,
																					outPopulationStats,
																					output(matchRateTotal									,named('MatchRate_Total')),
																					output(matchRateNameAddrSearch				,named('MatchRate_NameAddr')),
																					output(matchRateAddrSearch						,named('MatchRate_Addr')),
																					output(matchRateNameZipSearch					,named('MatchRate_NameZip')),
																					output(matchRateNameCityProvinceSearch,named('MatchRate_NameCityProvinceState'))
																				);