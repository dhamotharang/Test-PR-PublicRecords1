import canadianphones,ut;

dCanadianPhones	:=	canadianphones.file_CanadianWhitePagesBase;
dCanadianZips		:=	fds_test.CanadianZipCodes;

rFDSCanadianPhoneTemp_layout	:=
record
	layout_consumer.response.rFDSCanadianPhone_layout	and not Record_ID;
	string	fsa;
	string	city_name;
end;

rFDSCanadianPhoneTemp_layout	tCandianPhoneZip(dCanadianPhones le, dCanadianZips ri)	:=
transform
	self.fsa						:=	ri.fsa;
	self.city_name			:=	ri.city;
	self.First_Name			:=	le.fname;
	self.Middle_Name		:=	le.mname;
	self.Last_Name			:=	le.lname;
	self.Company_Name		:=	le.company_name;
	self.Address_Line1	:=	trim(	if(trim(le.prim_range)	!=	'',trim(le.prim_range)	+	' ','')	+
																if(trim(le.predir)			!=	'',trim(le.predir)			+	' ','')	+
																if(trim(le.prim_name)		!=	'',trim(le.prim_name)		+	' ','')	+
																trim(le.addr_suffix)
															);
	self.Address_Line2	:=	trim(	if(trim(le.unit_desig)	!=	'',trim(le.unit_desig)	+	' ','')	+
																trim(le.sec_range)
															);
	self.City						:=	le.p_city_name;
	self.State					:=	le.state;
	self.Zip						:=	le.zip;
	self.Phone_Number		:=	le.phonenumber;
	self.Publish_Date		:=	le.pub_date;
end;

dCanadianExtract	:=	join(	dCanadianPhones,
														dCanadianZips,
														left.zip[1..3]		=	right.fsa	and
														left.p_city_name	=	right.city,
														tCandianPhoneZip(left,right),
														lookup
													);

dCanadianExtract_dist	:=	distribute(	dCanadianExtract,
																				hash(	last_name,
																							company_name,
																							address_line1,
																							zip
																						)
																			);

dCanadianExtract_sort		:=	sort(	dCanadianExtract_dist,
																	first_name,
																	middle_name,
																	last_name,
																	company_name,
																	address_line1,
																	address_line2,
																	city,
																	state,
																	zip,
																	phone_number,
																	-publish_date,
																	local
																);

dCanadianExtract_dedup	:=	dedup(dCanadianExtract_sort,
																	first_name,
																	middle_name,
																	last_name,
																	company_name,
																	address_line1,
																	address_line2,
																	city,
																	state,
																	zip,
																	phone_number,
																	local
																);

// Sort on zip and append sequence number
dCanadianExtract_final	:=	sort(dCanadianExtract_dedup,zip);

output(choosen(dCanadianExtract_final,1000),named('CanadianPhone_ZipExtractTest'));

layout_consumer.response.rFDSCanadianPhone_layout	tConvert2Out(dCanadianExtract_final pInput,integer cnt)	:=
transform
	self.Record_ID		:=	(string)cnt;
	self.publish_date	:=	pInput.publish_date[5..6]	+	pInput.publish_date[1..4];
	self							:=	pInput;
end;

dCanadianPhoneExtract	:=	project(dCanadianExtract_final,tConvert2Out(left,counter));

output(choosen(dCanadianPhoneExtract,1000),named('CanadianPhone_ZipExtract'));

// Run population stats
rPPlStats_layout	:=
record
	string3	strGrp						:=	'ALL';
	cntTotalGrp								:=	count(group);
	cntRecordID_NonBlank			:=	sum(group,if(dCanadianPhoneExtract.Record_ID			!=	'',1,0));
	cntFirstName_NonBlank			:=	sum(group,if(dCanadianPhoneExtract.First_Name			!=	'',1,0));
	cntMiddleName_NonBlank		:=	sum(group,if(dCanadianPhoneExtract.Middle_Name		!=	'',1,0));
	cntLastName_NonBlank			:=	sum(group,if(dCanadianPhoneExtract.Last_Name			!=	'',1,0));
	cntCompanyName_NonBlank		:=	sum(group,if(dCanadianPhoneExtract.Company_Name		!=	'',1,0));
	cntAddressLine1_NonBlank	:=	sum(group,if(dCanadianPhoneExtract.Address_Line1	!=	'',1,0));
	cntAddressLine2_NonBlank	:=	sum(group,if(dCanadianPhoneExtract.Address_Line2	!=	'',1,0));
	cntCity_NonBlank					:=	sum(group,if(dCanadianPhoneExtract.City						!=	'',1,0));
	cntState_NonBlank					:=	sum(group,if(dCanadianPhoneExtract.State					!=	'',1,0));
	cntZip_NonBlank						:=	sum(group,if(dCanadianPhoneExtract.Zip						!=	'',1,0));
	cntPhoneNumber_NonBlank		:=	sum(group,if(dCanadianPhoneExtract.Phone_Number		!=	'',1,0));
	cntPublishDate_NonBlank		:=	sum(group,if(dCanadianPhoneExtract.Publish_Date		!=	'',1,0));
end;

dPopulationStats							:=	table(dCanadianPhoneExtract,rPPlStats_layout,few);
outPopulationStats						:=	output(dPopulationStats,named('CanadianPhoneExtract_PopulationStats'));

outCanadianPhoneExtractFixed	:=	output(	dCanadianPhoneExtract,,
																						'~thor_data400::out::fds_test::consumer::canadianphone_extract_fixed',
																						overwrite,
																						__compressed__
																					);

outCanadianPhoneExtract				:=	output(	dCanadianPhoneExtract,,
																						'~thor_data400::out::fds_test::consumer::canadianphone_extract',
																						csv(separator('|'),terminator('\n'),heading(single)),
																						overwrite,
																						__compressed__
																					);

export CanadianPhoneExtract := sequential(outCanadianPhoneExtractFixed,outCanadianPhoneExtract,outPopulationStats);