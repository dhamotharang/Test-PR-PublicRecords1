import Business_Header_SS, Business_Header;

// Per Jill, the fips_code filter to throw out "crap records"  :-)
// Omitting "bad pairs" of name/address.  Namely, "OS" and "SO" (owner name, seller address and vice versa)
sGoodSource	:=	['OO','BB','SS'];
dAssessorIn	:=	LN_Property.Assessor_as_Source(length(trim(fips_code)) = 5);
dDeedIn		:=	LN_Property.Deed_as_Source;
dSearchIn	:=	LN_Property.File_Search(source_code in sGoodSource);


// Start getting one record per Search record when at least one record per fares_id has non-blank cname
rSearchWithCNameOnly
 :=
  record
	dSearchIn.ln_fares_id;
	dSearchIn.cname;
  end
 ;

dSearchWithoutBogusNames	:=	dSearchIn(length(trim(cname)) >= 5,
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
// End getting one record per Search record when at least one record per fares_id has non-blank cname:  dSearchWithNonBlankCName

// Start getting all search records that have at least one cname filled in the same fares_id
dSearchDist					:=	distribute(dSearchIn,hash(ln_fares_id));

typeof(dSearchDist)	tGetSearchIfCNameExists(dSearchDist pSearch, dSearchWithNonBlankCName pNonBlankCName)
 :=
  transform
	self	:=	pSearch;
  end
 ;

dSearchDistFiltered			:=	join(dSearchDist,dSearchWithNonBlankCName,
									 left.ln_fares_id = right.ln_fares_id,
									 tGetSearchIfCNameExists(left,right),
									 local
									);
// End getting all search records that have at least one cname filled in the same fares_id:  dSearchDistFiltered

rAssessorSlim
 :=
  record
	dAssessorIn.ln_fares_id;
	dAssessorIn.assessee_phone_number;
	dAssessorIn.tax_year;
	dAssessorIn.recording_date;
	dAssessorIn.sale_date;
	dAssessorIn.src;	
	dAssessorIn.uid;
  end
 ;

rDeedSlim
 :=
  record
	dDeedIn.ln_fares_id;
	dDeedIn.recording_date;
	dDeedIn.src;
	dDeedIn.uid;
	dDeedIn.partial_interest_transferred;
  end
 ;

dAssessorSlim		:=	table(dAssessorIn,rAssessorSlim);
dDeedSlim			:=	table(dDeedIn,rDeedSlim);
dAssessorSlimDist	:=	distribute(dAssessorSlim,hash(ln_fares_id));
dDeedSlimDist		:=	distribute(dDeedSlim,hash(ln_fares_id));

dBusinessPrepLayout
 :=
  record
	Business_header.Layout_Business_Header;
	string5		title;
	string20	fname;
	string20	mname;
	string20	lname;
	string5		name_suffix;
	string2		source_code;
	string3		partial_interest_transferred;
  end
 ;

dBusinessPrepLayout tJoinSearchAndAssessor(dSearchDistFiltered pSearch, dAssessorSlimDist pAssessor)
 :=
  transform
	self.source						:=	if(pSearch.vendor_source_flag[1..3] = 'FAR',	// would be "FAR_F" or "FAR_S"
										   'PR',	// Fares
										   'LP'		// Non-Fares
										  );
	self.dppa						:=	false;
	self.vendor_id					:=	pSearch.source_code[1..2] + pSearch.vendor_source_flag + pSearch.ln_fares_id[1..12];
	self.prim_range					:=	pSearch.prim_range;
	self.predir						:=	pSearch.predir;
	self.prim_name					:=	pSearch.prim_name;
	self.addr_suffix				:=	pSearch.suffix;
	self.postdir					:=	pSearch.postdir;
	self.unit_desig					:=	pSearch.unit_desig;
	self.sec_range					:=	pSearch.sec_range;
	self.city						:=	pSearch.p_city_name;
	self.state						:=	pSearch.st;
	self.zip						:=	(unsigned)pSearch.zip;
	self.zip4						:=	(unsigned)pSearch.zip4;
	self.county						:=	pSearch.county[3..5];
	self.msa						:=	pSearch.msa;
	self.geo_lat					:=	pSearch.geo_lat;
	self.geo_long					:=	pSearch.geo_long;
	self.phone						:=	0;
	self.dt_first_seen				:=	map(pSearch.source_code[2] = 'O'					=> (integer)(pAssessor.tax_year + '0000'),
											(integer)pAssessor.recording_date > 19000000	=> (integer)(pAssessor.recording_date), 
											(integer)pAssessor.sale_date >      19000000	=> (integer)(pAssessor.sale_date),
											(integer)(pAssessor.tax_year + '0000')
										   );
	self.dt_last_seen				:=	if(pSearch.source_code[1] = 'O',   
							 			   (integer)(pAssessor.tax_year + '0000'),
							 			   if((integer)pAssessor.recording_date > 19000000,
											  (integer)(pAssessor.recording_date),
											  (integer)(pAssessor.sale_date)
											 )
										  );
	self.dt_vendor_first_reported	:=	self.dt_last_seen;
	self.dt_vendor_last_reported	:=	self.dt_last_seen;
	self.current					:=	true;	//??
	self.company_name				:=	pSearch.cname;
	self.bdid						:=	0;		//Per Jill (email of 7/19) the BDID is not required--is actually ignored
	self.fein						:=	0;
	self.title						:=	pSearch.title;
	self.fname						:=	pSearch.fname;
	self.mname						:=	pSearch.mname;
	self.lname						:=	pSearch.lname;
	self.name_suffix				:=	pSearch.name_suffix;
	self.source_code				:=	pSearch.source_code;
	self.partial_interest_transferred	:=	'';
  end
 ;

dSearchAndAssessor	:=	join(dSearchDistFiltered, dAssessorSlimDist,
							 left.ln_fares_id = right.ln_fares_id,
							 tJoinSearchAndAssessor(left, right),
							 left outer,
							 local
							);

dBusinessPrepLayout tJoinSearchAssessorAndDeed(dSearchAndAssessor pSearchAssessor, dDeedSlimDist pDeed)
 :=
  transform
	self.dt_first_seen					:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_first_seen);
	self.dt_last_seen					:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_last_seen);
	self.dt_vendor_last_reported		:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_vendor_last_reported);
	self.dt_vendor_first_reported		:=	if(pDeed.ln_fares_id <> '', (integer)(pDeed.recording_date), pSearchAssessor.dt_vendor_first_reported);
	self.partial_interest_transferred	:=	pDeed.partial_interest_transferred;
	self								:=	pSearchAssessor;
end;

dSearchAndAssessorAndDeed	:=	join(dSearchAndAssessor, dDeedSlimDist,
									 left.vendor_id[1..12] = right.ln_fares_id,
									 tJoinSearchAssessorAndDeed(left, right),
									 left outer,
									 local
									);

dBusinessPrepLayout tAdjustDates(dSearchAndAssessorAndDeed pInput)
 :=
  transform
	self.dt_vendor_first_reported	:=	pInput.dt_first_seen;
	self.dt_last_seen				:=	if(pInput.dt_last_seen < pInput.dt_first_seen, pInput.dt_first_seen, pInput.dt_last_seen);
	self.dt_vendor_last_reported	:=	self.dt_last_seen;
	self							:=	pInput;
  end
 ;

export LN_Property_as_Business_Prep
 :=	project(dSearchAndAssessorAndDeed, tAdjustDates(left))
 :	persist('~thor_data400::persist::bushdr_ln_property_as_business_prep')
 ;