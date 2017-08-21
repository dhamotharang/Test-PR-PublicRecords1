import Business_Header_SS, Business_Header,Business_HeaderV2, ut, mdr;

export as_Business_Prep(
	 dataset(Layouts.Layout_DID_Out	 ) pLNPropertySearch 
	,dataset(Layouts.layout_deed_mortgage_common_model_base) pLNPropertyDeed
	,dataset(Layouts.layout_property_common_model_base) pLNPropertyTax
	,dataset(Layouts.layout_addl_fares_deed) pLNPropertyAddlDeed 
	,dataset(Layouts.layout_addl_fares_tax) pLNPropertyAddlTax
	) := function
	asbussource := as_Business_source(
										 pLNPropertySearch  
										,pLNPropertyDeed		
										,pLNPropertyTax			
										,pLNPropertyAddlDeed
										,pLNPropertyAddlTax	
									);
	sGoodSource	:=	['OO','BB','SS'];
	dAssessorIn	:=	asbussource.ln_propertyv2_tax_as_business_source(length(trim(fips_code)) = 5);
	dDeedIn		:=	asbussource.ln_propertyv2_deed_as_business_source;
	searchwprop := asbussource.p3(source_code in sGoodSource);
	dSearchIn	:= searchwprop(~(is_true));

	rSearchWithCNameOnly := 	record
		dSearchIn.ln_fares_id;
		dSearchIn.cname;
	end;

	dSearchWithoutBogusNames	:=	dSearchIn(
								ln_fares_id != '',
								length(trim(cname)) >= 5,
								~((integer)zip = 0 and prim_name = ''),
								stringlib.stringfind(cname,'00000',1) = 0,
								stringlib.stringfilterout(cname,'1234567890-') != '',
								stringlib.stringfilterout(cname,'1234567890- ') != 'TU',
								(stringlib.stringfind(cname,' TRUST',1) = 0 or stringlib.stringfind(cname,' BANK',1) != 0),
								stringlib.stringfind(cname,'FAMILY',1) <= 1
							 );

	dSearchWithCNameOnly		:=	table(dSearchWithoutBogusNames,rSearchWithCNameOnly);
	dSearchWithCNameDist		:=	distribute(dSearchWithCNameOnly,hash(ln_fares_id));
	dSearchWithCNameSort		:=	sort(dSearchWithCNameDist,ln_fares_id,-cname,local);	// if there is a cname, one of them will be first
	dSearchWithCNameDedup		:=	dedup(dSearchWithCNameSort,ln_fares_id,local);
	dSearchWithNonBlankCName	:=	dSearchWithCNameDedup;
	dSearchDist					:=	distribute(dSearchIn,hash(ln_fares_id));

	typeof(dSearchDist)	tGetSearchIfCNameExists(dSearchDist pSearch, dSearchWithNonBlankCName pNonBlankCName)
	 := transform
		self	:=	pSearch;
	end;

	dSearchDistFiltered			:=	join(dSearchDist,dSearchWithNonBlankCName,
										 left.ln_fares_id = right.ln_fares_id,
										 tGetSearchIfCNameExists(left,right),
										 local
										);

	rAssessorSlim	 :=		record
		dAssessorIn.ln_fares_id;
		dAssessorIn.assessee_phone_number;
		dAssessorIn.tax_year;
		dAssessorIn.recording_date;
		dAssessorIn.sale_date;
		dAssessorIn.src;	
		dAssessorIn.uid;
	end;

	rDeedSlim := record
		dDeedIn.ln_fares_id;
		dDeedIn.recording_date;
		dDeedIn.src;
		dDeedIn.uid;
		dDeedIn.partial_interest_transferred;
	end;

	dAssessorSlim		:=	table(dAssessorIn,rAssessorSlim);
	dDeedSlim			:=	table(dDeedIn,rDeedSlim);
	dAssessorSlimDist	:=	distribute(dAssessorSlim,hash(ln_fares_id));
	dDeedSlimDist		:=	distribute(dDeedSlim,hash(ln_fares_id));

	Layouts.layout_business_prep tJoinSearchAndAssessor(dSearchDistFiltered pSearch, dAssessorSlimDist pAssessor)
	 := transform
		self.source						:=	MDR.sourceTools.fProperty(pSearch.ln_fares_id);
		self.dppa						:=	false;
		self.vendor_id					:=	pSearch.source_code[1..2] + pSearch.vendor_source_flag + pSearch.ln_fares_id[1..12];
		self.prim_range					:=	pSearch.prim_range;
		self.predir						:=	pSearch.predir;
		self.prim_name					:=	pSearch.prim_name;
		self.addr_suffix				:=	pSearch.suffix;
		self.postdir					:=	pSearch.postdir;
		self.unit_desig					:=	pSearch.unit_desig;
		self.sec_range					:=	pSearch.sec_range;
		self.city						:=	pSearch.v_city_name;
		self.state						:=	pSearch.st;
		self.zip						:=	(unsigned)pSearch.zip;
		self.zip4						:=	(unsigned)pSearch.zip4;
		self.county						:=	pSearch.county[3..5];
		self.msa						:=	pSearch.msa;
		self.geo_lat					:=	pSearch.geo_lat;
		self.geo_long					:=	pSearch.geo_long;
		self.phone						:=	(unsigned6)pSearch.phone_number;
		self.dt_first_seen				:=	pSearch.dt_first_seen;
		self.dt_last_seen				:=	pSearch.dt_last_seen;
		self.dt_vendor_first_reported	:=	pSearch.dt_vendor_last_reported;	// sometimes first reported uses dt_xxx_seen date, so use last reported since it is always the process date
		self.dt_vendor_last_reported	:=	pSearch.dt_vendor_last_reported; 
		self.current					:=	true;	//??
		self.company_name				:=	if(trim(pSearch.old_cname) <> '', ut.fnTrim2Upper(pSearch.old_cname), ut.fnTrim2Upper(pSearch.cname));
		self.bdid						:=	pSearch.bdid;		//Per Jill (email of 7/19) the BDID is not required--is actually ignored
		self.fein						:=	0;
		self.title						:=	pSearch.title;
		self.fname						:=	pSearch.fname;
		self.mname						:=	pSearch.mname;
		self.lname						:=	pSearch.lname;
		self.name_suffix				:=	pSearch.name_suffix;
		self.source_code				:=	pSearch.source_code;
		self.partial_interest_transferred	:=	'';
     end;

	dSearchAndAssessor	:=	join(dSearchDistFiltered, dAssessorSlimDist,
								 left.ln_fares_id = right.ln_fares_id,
								 tJoinSearchAndAssessor(left, right),
								 left outer,
								 local
								);

	Layouts.layout_business_prep tJoinSearchAssessorAndDeed(dSearchAndAssessor pSearchAssessor, dDeedSlimDist pDeed) := transform
		self.dt_first_seen				:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_first_seen);
		self.dt_last_seen				:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_last_seen);
		self.dt_vendor_last_reported		:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_vendor_last_reported);
		self.dt_vendor_first_reported		:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_vendor_first_reported); 
		self.partial_interest_transferred	:=	pDeed.partial_interest_transferred;
		self							:=	pSearchAssessor;
	end;

	dSearchAndAssessorAndDeed	:=	join(dSearchAndAssessor, dDeedSlimDist,
										 left.vendor_id[1..12] = right.ln_fares_id,
										 tJoinSearchAssessorAndDeed(left, right),
										 left outer,
										 local
										);

	Layouts.layout_business_prep tAdjustDates(dSearchAndAssessorAndDeed pInput):= transform
		self.dt_vendor_first_reported	:=	pInput.dt_first_seen;
		self.dt_last_seen				:=	if(pInput.dt_last_seen < pInput.dt_first_seen, pInput.dt_first_seen, pInput.dt_last_seen);
		self.dt_vendor_last_reported	:=	self.dt_last_seen;
		self							:=	pInput;
	end;

	LN_Propertyv2_as_Business_Preparation := project(dSearchAndAssessorAndDeed, tAdjustDates(left));

	return LN_Propertyv2_as_Business_Preparation;

end;