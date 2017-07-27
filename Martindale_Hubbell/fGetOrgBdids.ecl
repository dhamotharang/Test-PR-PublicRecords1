import business_header,mdr;

laybh := business_header.Layout_Business_Header_base;

export fGetOrgBdids(

	 dataset(layouts.Base.Organizations	) porgsBase			= Files().base.Organizations.qa
	,dataset(laybh											) pBHeaderBase	= business_header.files().base.business_headers.qa

) :=
function

	dbheader_mh := pBHeaderBase(mdr.sourceTools.SourceIsMartinDale_Hubbell(source));
	
	//clean the records with only city and state so can get the cities and states standardized(for matching to header)
	dorgsbase_clean 	:= Standardize_orgs_Line2s(porgsBase);

	//can match on company name, address, phone and vendor_id
	layslimmh := 
	record

		string120 company_name	;
		string2		mail_st				;
		string2 	loc_st 				;
		string25	mail_city			;
		string25	loc_city			;
		string10	fax_num				;
		string10 	phone_num			;
		string34  vendor_id 		;
	
	end;

	layhdrextra := 
	record
		qstring120 	company_name	;
		qstring34 	vendor_id 		:= ''; // Vendor key
		qstring25 	city					;
		string2   	state					;
		unsigned6 	phone					;
		string2   	source				;          // Source file type
	end;
	
	layslim := 
	record

		unsigned8		cnt;
		integer1		score;
		unsigned6		bdid													:= 0;
		unsigned1		bdid_score										:= 0;
		layslimmh		mh_fields;
		layhdrextra	hdr_fields;
		
	end;

	layextra := 
	record
		layouts.Base.Organizations;
		layhdrextra;
		unsigned8		cnt;
		integer1		score;
	end;

	dorgsbase_clean_counter := project(dorgsbase_clean, transform(layextra,self.cnt := counter;self := left;self := [])) : global;
	dorgsbase_clean_counter_slim := project(dorgsbase_clean_counter,transform(layslim
	,self.hdr_fields 							 := [];
	 self.mh_fields.company_name	 := left.rawfields.NAME_ORG_NAME																;
	 self.mh_fields.mail_st				 := left.Clean_mailing_address.st																;
	 self.mh_fields.loc_st 				 := left.Clean_location_address.st															;
	 self.mh_fields.mail_city			 := left.Clean_mailing_address.v_city_name											;
	 self.mh_fields.loc_city			 := left.Clean_location_address.v_city_name											;
	 self.mh_fields.fax_num				 := left.clean_phones.CONTACT_FAXS_FAX_NUMBER										;
	 self.mh_fields.phone_num			 := left.clean_phones.CONTACT_PHONES_PHONE_NUMBER								;
	 self.mh_fields.vendor_id 		 := trim(Left.rawfields.ORG_AUDIT_FIRMNO,left,right)						;
	 self.bdid 										 := left.bdid																										;
	 self.bdid_score							 := left.bdid_score																							;
	 self.cnt											 := left.cnt																										;
	 self.score										 := 0																														;
	
	));

	dorgsbase_with_bdid					:= dorgsbase_clean_counter_slim	(bdid != 0);
	dorgsbase_without_bdid			:= dorgsbase_clean_counter_slim	(bdid  = 0);

	//Start with most specific to less specific if no match
	djoingetcandidates1 := join(
		 distribute(dbheader_mh							,hash64(trim((string120)company_name,left,right)))
		,distribute(dorgsbase_without_bdid	,hash64(trim(mh_fields.company_name	,left,right)))
		,			left.vendor_id								= right.mh_fields.vendor_id
		,transform(layslim,
			self.bdid  										:= left.bdid				;
			self.hdr_fields.company_name	:= left.company_name;
			self.hdr_fields.vendor_id 		:= left.vendor_id 	;
			self.hdr_fields.city					:= left.city				;
			self.hdr_fields.state					:= left.state				;
			self.hdr_fields.phone					:= left.phone				;
			self.hdr_fields.source				:= left.source			;
			self		 											:= right						;
		)
		,right outer
		,local
	);

	djoingetcandidates1_w_bdid 	:= djoingetcandidates1(bdid != 0);
	djoingetcandidates1_wo_bdid := djoingetcandidates1(bdid  = 0);

	djoingetcandidates2 := join(
		 distribute(pBHeaderBase								,hash64(trim((string120)company_name,left,right)))
		,distribute(djoingetcandidates1_wo_bdid	,hash64(trim(mh_fields.company_name	,left,right)))
		,			(string120)left.company_name 	= right.mh_fields.company_name
		 and	 (		left.state							= right.mh_fields.mail_st
						or 	left.state							= right.mh_fields.loc_st
		 )
		,transform(layslim,
			self.bdid  										:= left.bdid				;
			self.hdr_fields.company_name	:= left.company_name;
			self.hdr_fields.vendor_id 		:= left.vendor_id 	;
			self.hdr_fields.city					:= left.city				;
			self.hdr_fields.state					:= left.state				;
			self.hdr_fields.phone					:= left.phone				;
			self.hdr_fields.source				:= left.source			;
			self		 											:= right						;
		)
		,right outer
		,local
	);
	dconcat_joins := djoingetcandidates1_w_bdid + djoingetcandidates2;
	
	djoinredist := distribute(dconcat_joins,random());
	
	djoinwithbdids 		:= djoinredist(bdid != 0);
	djoinwithoutbdids	:= djoinredist(bdid  = 0);

	dproj1 := project(djoinwithbdids, transform(layslim,
		integer4 vendor_id_score := if(			left.hdr_fields.vendor_id != ''
																		and left.hdr_fields.vendor_id	 = left.mh_fields.vendor_id
															,10
															,0
														);

		integer4 city_score := if(	left.hdr_fields.city != '' and 
																(			left.hdr_fields.city	= left.mh_fields.mail_city
																	or	left.hdr_fields.city	= left.mh_fields.loc_city	
																)
															,5
															,0
														);
		integer4 phone_score := if(	left.hdr_fields.phone != 0 and 
																(			left.hdr_fields.phone	= (unsigned6)left.mh_fields.fax_num		
																	or	left.hdr_fields.phone	= (unsigned6)left.mh_fields.phone_num	
																)
															,5
															,0
														);
	//cutoff score = 7
	//maybe lower score without any negatives if person is unique
		self.score				:= vendor_id_score + city_score + phone_score;
		self.bdid					:= left.bdid;
		self							:= left;
	));
	
	//so, how many bdids did we get per cnt(unique record)?
	//if more than one, can't be more than one for the same score.
	//take highest scoring bdid
	//get # of bdids per cnt and score--can only be one.
	dtable 	:= table(table(dproj1	, {cnt, score, bdid}, cnt, score, bdid), {cnt, score, unsigned8 cntuniquebdids := count(group)}, cnt, score);
	dtable_scrub := dedup(sort(distribute(dtable, cnt), cnt, -score,local), cnt,local);
	dtable_scrub_1 := dtable_scrub(cntuniquebdids = 1);
	
	djoin2 := join(
		 dedup(sort(distribute(dedup(sort(dproj1,cnt,-score,local),cnt,local), cnt), cnt, -score,local), cnt,local)
		,dtable_scrub_1
		,		left.cnt 		= right.cnt
		and left.score 	= right.score
		,transform(layslim,
			self.bdid 	:= if(right.cnt != 0	,left.bdid	, 0);
			self.score 	:= if(right.cnt != 0	,left.score	, 0);
			self				:= left;
		)
		,left outer
	);
	
	//bdids from macro are priority
//	dorgsbase_with_bdid_proj := project(dorgsbase_with_bdid, transform(layslim, self.score := left.bdid_score;self := left;));
	dconcat_layslims := djoinwithoutbdids + djoin2 + dorgsbase_with_bdid;
	dconcat_rejoin := join(
		 dorgsbase_clean_counter
		,dconcat_layslims
		,left.cnt = right.cnt
		,transform(layextra,
			self.bdid 	:= right.bdid;
			self			:= right.hdr_fields;
			self			:= right;
			self			:= left;
	));
	
	//now we have one record per cnt, and the correct bdids appended
	//now need to propagate bdids per isln
	dconcat 						:= dconcat_rejoin;
	dconcat_withisln 		:= dconcat(rawfields.ORG_AUDIT_FIRMNO != '');
	dconcat_withoutisln := dconcat(rawfields.ORG_AUDIT_FIRMNO  = '');
	
	diterate := iterate(group(sort(distribute(dconcat_withisln, hash64(rawfields.ORG_AUDIT_FIRMNO)), rawfields.ORG_AUDIT_FIRMNO, -bdid, -score,local), rawfields.ORG_AUDIT_FIRMNO, local),transform(
		 layextra
		,self.bdid 	:= if(left.rawfields.ORG_AUDIT_FIRMNO = '', right.bdid,left.bdid);
		 self 			:= right;
	));
	
	return project(group(diterate) + dconcat_withoutisln,layouts.Base.Organizations);

end;