import marketing_list, ut; 

export Build_List(
										dataset(Marketing_Suite_List_Gen.Layouts.Layout_Valid_ParmFile)	inParmFile,
										string	JobID
									)	:= module;
																
	MktBusBase			:=	Marketing_List.Files().business_information.built;
	MktBusLayout		:=	Marketing_List.layouts.business_information;
	MktContactBase	:=	Marketing_List.Files().business_contact.built;
	MktContactLayout:=	Marketing_List.layouts.business_contact;	
	TempBusLayout		:=	Marketing_Suite_List_Gen.Layouts.Layout_TempBus;
	TempFullLayout	:=	Marketing_Suite_List_Gen.Layouts.Layout_TempFull;
	TempNormLayout	:=	Marketing_Suite_List_Gen.Layouts.Layout_NormTemp;	
	
	string ParmFilterType_Location							:= 'SEARCHTYPE';

  /*=======================================================================================================================================
  | Filter the parameter file by individual filter values (1 rec per value), then execute function to validate values and format into set.
  |======================================================================================================================================*/
  rs_record_SearchType												:=	inParmFile(ut.CleanSpacesAndUpper(filter_name) = ParmFilterType_Location);
	
  set of string filter_SearchType  						:= 	IF(COUNT(rs_record_SearchType) > 0, rs_record_SearchType[1].set_filter_values, ['']);
	
	SeleSearch	:=	'S';
	
	string1 SearchType	:=	if(SeleSearch in filter_SearchType,
															'S',
															'P'
														 );	
	
	ExtractBusinessFileSearchFields( String1 pSearchType) := FUNCTION
		
	TempBusLayout	trfSeleidFields(MktBusLayout l)	:= transform
			self.seleid																:=	l.seleid;
			self.proxid																:=	l.proxid;
			self.ultid																:=	l.ultid;
			self.orgid																:=	l.orgid;
			self.business_name												:=	l.seleid_level.business_name;
			self.address															:=	l.seleid_level.business_address;
			self.city																	:=	l.seleid_level.city;
			self.state																:=	l.seleid_level.state;
			self.zip_code															:=	l.seleid_level.zip5;
			self.county																:=	l.seleid_level.county;
			self.county_name													:=	l.seleid_level.county_name;
			self.age																	:=	l.seleid_level.age_of_company;
			self.phone																:=	l.seleid_level.business_phone;
			self.email																:=	l.seleid_level.business_email;
			self.annual_revenue												:=	l.seleid_level.annual_revenue;
			self.num_employees												:=	l.seleid_level.number_of_employees;
			self.sic_primary													:=	l.seleid_level.sic_primary;
			self.sic2																	:=	l.seleid_level.sic2;
			self.sic3																	:=	l.seleid_level.sic3;
			self.sic4																	:=	l.seleid_level.sic4;
			self.sic5																	:=	l.seleid_level.sic5;
			self.naics_primary												:=	l.seleid_level.naics_primary;
			self.naics2																:=	l.seleid_level.naics2;
			self.naics3																:=	l.seleid_level.naics3;
			self.naics4																:=	l.seleid_level.naics4;
			self.naics5																:=	l.seleid_level.naics5;
			self																			:=	l;
			self																			:= 	[];			
		end;		
	
		CompanySearchSlim	:= project(MktBusBase, trfSeleidFields(left));
	
		TempBusLayout	trfProxidFields(MktBusLayout l)	:= transform
			self.seleid																:=	l.seleid;
			self.proxid																:=	l.proxid;
			self.ultid																:=	l.ultid;
			self.orgid																:=	l.orgid;
			self.business_name												:=	l.seleid_level.business_name;
			self.address															:=	l.proxid_level.business_address;
			self.city																	:=	l.proxid_level.city;
			self.state																:=	l.proxid_level.state;
			self.zip_code															:=	l.proxid_level.zip5;
			self.county																:=	l.proxid_level.county;
			self.age																	:=	l.proxid_level.age_of_company;
			self.phone																:=	l.proxid_level.business_phone;
			self.email																:=	l.seleid_level.business_email;
			self.annual_revenue												:=	l.seleid_level.annual_revenue;
			self.num_employees												:=	l.seleid_level.number_of_employees;
			self.sic_primary													:=	l.seleid_level.sic_primary;
			self.sic2																	:=	l.seleid_level.sic2;
			self.sic3																	:=	l.seleid_level.sic3;
			self.sic4																	:=	l.seleid_level.sic4;
			self.sic5																	:=	l.seleid_level.sic5;
			self.naics_primary												:=	l.seleid_level.naics_primary;
			self.naics2																:=	l.seleid_level.naics2;
			self.naics3																:=	l.seleid_level.naics3;
			self.naics4																:=	l.seleid_level.naics4;
			self.naics5																:=	l.seleid_level.naics5;
			self																			:=	l;
			self																			:= 	[];			
		end;
	
		locationSearchSlim	:= project(MktBusBase, trfProxidFields(left));
														
		SlimBusinessFile		:=	if (pSearchType = 'S',
																	CompanySearchSlim,
																	LocationSearchSlim
																);
															
		return SlimBusinessFile;
	end;
	
	GetSlim							:=	ExtractBusinessFileSearchFields(SearchType);
	
	PhoneList						:=	if (count(Marketing_Suite_List_Gen.MakePhoneList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakePhoneList(inParmFile,GetSlim),
																GetSlim
															);
															
	GeoList							:=	if (count(Marketing_Suite_List_Gen.MakeGeographyList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeGeographyList(inParmFile,GetSlim),
																GetSlim
															);
															
	RevenueList					:=	if (count(Marketing_Suite_List_Gen.MakeRevenueList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeRevenueList(inParmFile,GetSlim),
																GetSlim
															);
	
	IndustryList				:=	if (count(Marketing_Suite_List_Gen.MakeIndustryList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeIndustryList(inParmFile,GetSlim),
																GetSlim
															);	
															
	EmployeeList				:=	if (count(Marketing_Suite_List_Gen.MakeEmployeeList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeEmployeeList(inParmFile,GetSlim),
																GetSlim
															);
															
	YearsInBusinessList	:=	if (count(Marketing_Suite_List_Gen.MakeYearsInBusinessList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeYearsInBusinessList(inParmFile,GetSlim),
																GetSlim
															);	
															
	BusEmailList				:=	if (count(Marketing_Suite_List_Gen.MakeBusEmailList(inParmFile,GetSlim)) <> 0,
																Marketing_Suite_List_Gen.MakeBusEmailList(inParmFile,GetSlim),
																GetSlim
															);
															
	distPhoneList						:=	distribute(PhoneList, 					hash(seleid,proxid));
	distGeoList							:=	distribute(GeoList, 						hash(seleid,proxid));
	distRevenueList					:=	distribute(RevenueList, 				hash(seleid,proxid));
	distIndustryList				:=	distribute(IndustryList, 				hash(seleid,proxid));
	distEmployeeList				:=	distribute(EmployeeList, 				hash(seleid,proxid));
	distYearsInBusinessList	:=	distribute(YearsInBusinessList, hash(seleid,proxid));
	distBusEmailList				:=	distribute(BusEmailList, 				hash(seleid,proxid));															
		
	//---------------------------------------------------------------------------------------------
	// Make the list
	//---------------------------------------------------------------------------------------------	
	
	TempBusLayout trfMakeBusList(TempBusLayout l, TempBusLayout r)	:=	transform
		self	:=	l;
	end;
	
	BusList1			:=	Join(	distPhoneList,
													distGeoList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);	
													
	BusList2			:=	Join(	BusList1,
													distRevenueList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);

	BusList3			:=	Join(	BusList2,
													distIndustryList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);

	BusList4			:=	Join(	BusList3,
													distEmployeeList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);	

	BusList5			:=	Join(	BusList4,
													distYearsInBusinessList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);		

	BusList6			:=	Join(	BusList5,
													distBusEmailList,
													left.seleid = right.seleid and 
													left.proxid=right.proxid,
													trfMakeBusList(left,right),
													local);	
													
	BusList				:=	dedup(sort(BusList6, record, local), record, local);

	TempBusLayout AddSequence(TempBusLayout l, unsigned8 c) := transform
			self.unique_id			:=	c;
			self								:=	l;
			self								:=	[];
		end;
	
	SeqFile := 	project(BusList, AddSequence(left,counter));
	
	TempNormLayout NormalizeIndustry(TempBusLayout l, unsigned1 c) := transform,
		skip(	c=1 and (ut.CleanSpacesAndUpper(l.sic_primary + l.naics_primary) = '') or
					c=2 and (ut.CleanSpacesAndUpper(l.sic2 + l.naics2) = '') or
					c=3 and (ut.CleanSpacesAndUpper(l.sic3 + l.naics3) = '') or
					c=4 and (ut.CleanSpacesAndUpper(l.sic4 + l.naics4) = '') or
					c=5 and (ut.CleanSpacesAndUpper(l.sic5 + l.naics5) = ''))
		self.unique_id			:= 	l.unique_id;
		self.IndustryType		:=	c;
		self.sic_code				:= 	choose(c,l.sic_primary,l.sic2,l.sic3,l.sic4,l.sic5);
		self.naics_code			:= 	choose(c,l.naics_primary,l.naics2,l.naics3,l.naics4,l.naics5);
		self.sic_desc				:= 	'';
		self.naics_desc			:=	'';		
		self								:= 	l;
	end;
	
	NormalizeIndustryFields := normalize(SeqFile,5,NormalizeIndustry(left, counter));
		
	NormList				:=	dedup(sort(NormalizeIndustryFields, record), record);
	
	ExplodeIndustry	:=	Marketing_Suite_List_Gen.fnGetIndustryDesc(NormList);
	
	dSeqFile_dist 	:= 	distribute(SeqFile,hash(unique_id));
	dExploded_dist	:=	distribute(ExplodeIndustry,hash(unique_id));
	
	TempBusLayout	trfGetIndustryDesc(TempBusLayout l, TempNormLayout r)	:=	transform
		self.sic_primary				:= 	if(r.IndustryType = 1	,r.sic_code,		l.sic_primary);
		self.naics_primary			:=	if(r.IndustryType = 1	,r.naics_code,	l.naics_primary);	
		self.sic_primary_desc		:=	if(r.IndustryType = 1	,r.sic_desc,		l.sic_primary_desc);	
		self.naics_primary_desc	:=	if(r.IndustryType = 1	,r.naics_desc,	l.naics_primary_desc);	
		
		self.sic2								:= 	if(r.IndustryType = 2	,r.sic_code,		l.sic2);
		self.naics2							:=	if(r.IndustryType = 2	,r.naics_code,	l.naics2);	
		self.sic2_desc					:=	if(r.IndustryType = 2	,r.sic_desc,		l.sic2_desc);	
		self.naics2_desc				:=	if(r.IndustryType = 2	,r.naics_desc,	l.naics2_desc);	

		self.sic3								:= 	if(r.IndustryType = 3	,r.sic_code,		l.sic3);
		self.naics3							:=	if(r.IndustryType = 3	,r.naics_code,	l.naics3);	
		self.sic3_desc					:=	if(r.IndustryType = 3	,r.sic_desc,		l.sic3_desc);	
		self.naics3_desc				:=	if(r.IndustryType = 3	,r.naics_desc,	l.naics3_desc);	
		
		self.sic4								:= 	if(r.IndustryType = 4	,r.sic_code,		l.sic4);
		self.naics4							:=	if(r.IndustryType = 4	,r.naics_code,	l.naics4);	
		self.sic4_desc					:=	if(r.IndustryType = 4	,r.sic_desc,		l.sic4_desc);	
		self.naics4_desc				:=	if(r.IndustryType = 4	,r.naics_desc,	l.naics4_desc);	
		
		self.sic5								:= 	if(r.IndustryType = 5	,r.sic_code,		l.sic5);
		self.naics5							:=	if(r.IndustryType = 5	,r.naics_code,	l.naics5);	
		self.sic5_desc					:=	if(r.IndustryType = 5	,r.sic_desc,		l.sic5_desc);	
		self.naics5_desc				:=	if(r.IndustryType = 5	,r.naics_desc,	l.naics5_desc);	
		self										:= 	l;
		self										:= 	[];
	end;
	
	dIndustry1								:= join(dSeqFile_dist
																		,dExploded_dist(IndustryType = 1)
																		,left.unique_id = right.unique_id
																		,trfGetIndustryDesc(left,right)
																		,local
																		,left outer
																		);
		
	dIndustry2								:= join(dIndustry1
																		,dExploded_dist(IndustryType = 2)
																		,left.unique_id = right.unique_id
																		,trfGetIndustryDesc(left,right)
																		,local
																		,left outer
																		);
																				
	dIndustry3								:= join(dIndustry2
																		,dExploded_dist(IndustryType = 3)
																		,left.unique_id = right.unique_id
																		,trfGetIndustryDesc(left,right)
																		,local
																		,left outer
																		);
																			
	dIndustry4								:= join(dIndustry3
																		,dExploded_dist(IndustryType = 4)
																		,left.unique_id = right.unique_id
																		,trfGetIndustryDesc(left,right)
																		,local
																		,left outer
																		);
																		
	dIndustry5								:= join(dIndustry4
																		,dExploded_dist(IndustryType = 5)
																		,left.unique_id = right.unique_id
																		,trfGetIndustryDesc(left,right)
																		,local
																		,left outer
																		);
	
	dIndustry									:=	distribute(dIndustry5,hash(seleid,proxid));
	
	//---------------------------------------------------------------------------------------------
	// Make the contact list
	//---------------------------------------------------------------------------------------------	
	
	ContactList					:=	if (count(Marketing_Suite_List_Gen.MakeContactList(inParmFile,MktContactBase)) <> 0,
																Marketing_Suite_List_Gen.MakeContactList(inParmFile,MktContactBase),
																MktContactBase
															);
		
	ExecContactList			:=	if (count(Marketing_Suite_List_Gen.MakeExecContactList(inParmFile,MktContactBase)) <> 0,
																Marketing_Suite_List_Gen.MakeExecContactList(inParmFile,MktContactBase),
																MktContactBase
															);
															
	distContactList			:=	distribute(ContactList, hash(seleid,proxid));
	distExecContactList	:=	distribute(ContactList, hash(seleid,proxid));
	
	MktContactLayout trfMakeContactList(MktContactLayout l, MktContactLayout r)	:=	transform
		self	:=	l;
	end;
	
	ContList1						:=	Join(	distContactList,
																distExecContactList,
																left.seleid = right.seleid and 
																left.proxid=right.proxid and
																ut.CleanSpacesAndUpper(left.fname)=ut.CleanSpacesAndUpper(right.fname) and
																ut.CleanSpacesAndUpper(left.lname)=ut.CleanSpacesAndUpper(right.lname),
																trfMakeContactList(left,right),
																local);	
																
	distAllContactList	:=	distribute(ContList1, hash(seleid,proxid));

	TempFullLayout trfJoinMkt(MktContactLayout l,  TempBusLayout r)	:=	transform
		self.contact_city						:=	l.city;
		self.contact_state					:=	l.state;
		self.contact_zip5						:=	l.zip5;
		self.contact_county					:=	l.county;
		self.contact_county_name		:=	l.county_name;
		self	:=	r;
		self	:=	l;
		self	:=	[];
	end;
	
	MarketingFile		:=	Join(	distAllContactList,
														dIndustry,
														left.seleid = right.seleid and
														left.proxid = right.proxid,
														trfJoinMkt(left,right),
														right outer,
														local);
														
	doStats					:=	Marketing_Suite_List_Gen.CreateStats(MarketingFile,JobID).all;
	
	BasicFile				:=	Dedup(sort(MarketingFile,seleid,proxid,person_hierarchy,local),seleid,proxid,local, keep 3);
								
	Marketing_Suite_List_Gen.Layouts.Layout_CompanySearch	trfBusiness(TempFullLayout pInput)	:=	transform
    self.company_business_address	:=	pInput.address;
    self.company_city							:=	pInput.city;
    self.company_state						:=	pInput.state;
    self.company_zip_code					:=	pInput.zip_code;
    self.company_county						:=	pInput.county_name;
		self.age_of_company						:=	pInput.age;
    self.company_phone						:=	pInput.phone;
		self.first_name								:=	pInput.fname;
		self.last_name								:=	pInput.lname;
		self.title										:=	pInput.title;
		self.title_var2								:=	pInput.title2;
		self.title_var3								:=	pInput.title3;
		self.title_var4								:=	pInput.title4;
		self.title_var5								:=	pInput.title5;
		self.contact_street_address		:=	pInput.contact_address;
		self.contact_zip_code					:=	pInput.contact_zip5;
		self.contact_county						:=	pInput.contact_county_name;
		self.contact_email						:=	pInput.contact_email_address;
		self													:= 	pInput;
	end;

	Marketing_Suite_List_Gen.Layouts.Layout_CompanySearchBasic	trfBusinessBasic(TempFullLayout pInput)	:=	transform
    self.company_business_address	:=	pInput.address;
    self.company_city							:=	pInput.city;
    self.company_state						:=	pInput.state;
    self.company_zip_code					:=	pInput.zip_code;
    self.company_county						:=	pInput.county_name;
		self.first_name								:=	pInput.fname;
		self.last_name								:=	pInput.lname;
		self.title										:=	pInput.title;
		self.title_var2								:=	pInput.title2;
		self.title_var3								:=	pInput.title3;
		self.title_var4								:=	pInput.title4;
		self.title_var5								:=	pInput.title5;
		self.contact_street_address		:=	pInput.contact_address;
		self.contact_zip_code					:=	pInput.contact_zip5;
		self.contact_county						:=	pInput.contact_county_name;		
		self													:= 	pInput;
	end;
	
	Marketing_Suite_List_Gen.Layouts.Layout_LocationSearch	trfLocation(TempFullLayout pInput)	:=	transform
    self.location_business_address:=	pInput.address;
    self.location_city						:=	pInput.city;
    self.location_state						:=	pInput.state;
    self.location_zip_code				:=	pInput.zip_code;
    self.location_county					:=	pInput.county_name;
		self.age_of_location					:=	pInput.age;
    self.location_phone						:=	pInput.phone;
		self.first_name								:=	pInput.fname;
		self.last_name								:=	pInput.lname;
		self.title										:=	pInput.title;
		self.title_var2								:=	pInput.title2;
		self.title_var3								:=	pInput.title3;
		self.title_var4								:=	pInput.title4;
		self.title_var5								:=	pInput.title5;
		self.contact_street_address		:=	pInput.contact_address;
		self.contact_zip_code					:=	pInput.contact_zip5;
		self.contact_county						:=	pInput.contact_county_name;
		self.contact_email						:=	pInput.contact_email_address;		
		self													:= 	pInput;
	end;
	
	Marketing_Suite_List_Gen.Layouts.Layout_LocationSearchBasic	trfLocationBasic(TempFullLayout pInput)	:=	transform
    self.location_business_address:=	pInput.address;
    self.location_city						:=	pInput.city;
    self.location_state						:=	pInput.state;
    self.location_zip_code				:=	pInput.zip_code;
    self.location_county					:=	pInput.county_name;
		self.first_name								:=	pInput.fname;
		self.last_name								:=	pInput.lname;
		self.title										:=	pInput.title;
		self.title_var2								:=	pInput.title2;
		self.title_var3								:=	pInput.title3;
		self.title_var4								:=	pInput.title4;
		self.title_var5								:=	pInput.title5;
		self.contact_street_address		:=	pInput.contact_address;
		self.contact_zip_code					:=	pInput.contact_zip5;
		self.contact_county						:=	pInput.contact_county_name;
		self													:= 	pInput;
	end;	

	FormatBusinessFile	:=	Sequential(
																			output(project(MarketingFile, trfBusiness(left))			,,'~thor_data400::marketing_suite_list_gen::premium::'+jobID,CSV(SEPARATOR(['|'])),overwrite,__compressed__, expire (20)),
																			output(project(BasicFile,			trfBusinessBasic(left))	,,'~thor_data400::marketing_suite_list_gen::basic::'+jobID,CSV(SEPARATOR(['|'])),overwrite,__compressed__, expire (20))
																		 );
	FormatLocationFile	:=	Sequential(
																			output(project(MarketingFile, trfLocation(left))			,,'~thor_data400::marketing_suite_list_gen::premium::'+jobID,CSV(SEPARATOR(['|'])),overwrite,__compressed__, expire (20)),
																			output(project(BasicFile,			trfLocationBasic(left))	,,'~thor_data400::marketing_suite_list_gen::basic::'+jobID,CSV(SEPARATOR(['|'])),overwrite,__compressed__, expire (20))
																		 );

	export All := 
	
		parallel(
							if (SearchType = 'S', 
									FormatBusinessFile, 
									FormatLocationFile
									),
							doStats
						);
						
end;