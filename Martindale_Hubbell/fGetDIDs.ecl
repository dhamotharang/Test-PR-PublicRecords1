import header;

dhdr_nonGLB := dataset(header.Filename_Header,header.Layout_Header_v2,flat);

export fGetDIDs(

	 dataset(layouts.temporary.aff_redid				) pAffBase
	,dataset(header.Layout_Header_v2						) pHeaderBase = dhdr_nonGLB(header.isPreGLB(dhdr_nonGLB))
	,string																				pISLN_Filter	= ''
  ,set of string2																pFlags				= ['MA','LA','FN']	//'IA' = use indiv_audit_sortkey for name

) :=
function
	//clean the records with only city and state so can get the cities and states standardized(for matching to header)

	
	layslim := 
	record

		unsigned8		cnt;
		integer1		score;
		integer1		mname_score	;
		integer1		dob_score		;
		integer1		city_score	;
		integer1		phone_score	;
		integer1		state_score	;
		unsigned6		Did													:= 0;
		unsigned1		did_score										:= 0;
		layouts.temporary.afflayslimmh		mh_fields;
		layouts.temporary.afflayhdrextra	hdr_fields;
		
	end;

	layextra := layouts.temporary.aff_redid;

	daffbase_clean_counter 	:= Standardize_Line2s(paffBase,pFlags);

	daffbase_clean_counter_slim := project(daffbase_clean_counter,transform(layslim
	,self.hdr_fields 							 := [];
	 self.mh_fields.lname					 := left.clean_contact_name.lname																;
	 self.mh_fields.fname 				 := left.clean_contact_name.fname																;
	 self.mh_fields.mname					 := left.clean_contact_name.mname																;
	 self.mh_fields.mail_st				 := left.Clean_contact_mailing_address.st												;
	 self.mh_fields.loc_st 				 := left.Clean_contact_location_address.st											;
	 self.mh_fields.admit_st 			 := left.rawfields.HEADER_AFF_INDIV_INDIV_PP_ADMIT_STATE				;
	 self.mh_fields.born_year			 := left.rawfields.HEADER_AFF_INDIV_INDIV_PP_BORN_YEAR					;
	 self.mh_fields.mail_city			 := left.Clean_contact_mailing_address.v_city_name							;
	 self.mh_fields.loc_city			 := left.Clean_contact_location_address.v_city_name							;
	 self.mh_fields.country				 := left.rawfields.contact_country															;
	 self.mh_fields.contact_fax		 := left.clean_phones.CONTACT_FAXS_FAX_NUMBER										;
	 self.mh_fields.contact_phone	 := left.clean_phones.CONTACT_PHONES_PHONE_NUMBER								;
	 self.mh_fields.indiv_cell		 := left.clean_phones.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER	;
	 self.mh_fields.indiv_fax			 := left.clean_phones.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER			;
	 self.mh_fields.indiv_phone		 := left.clean_phones.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER	;
	 self.mh_fields.ISLN			 		 := left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN						;
	 self.mh_fields.attyno				 := left.rawfields.header_aff_indiv_indiv_audit_attyno					;
	 self.mh_fields.loc_err_stat	 := left.clean_contact_location_address.err_stat								;
	 self.mh_fields.mail_err_stat	 := left.clean_contact_mailing_address.err_stat									;
	 self.did 										 := left.did																										;
	 self.did_score								 := left.did_score																							;
	 self.cnt											 := left.cnt																										;
	 self.score										 := 0																														;
	 self.mname_score							 := 0																														;
	 self.dob_score								 := 0																														;
	 self.city_score							 := 0																														;
	 self.phone_score							 := 0																														;
	 self.state_score							 := 0																														;
	
	));

	filtwithdid := 			daffbase_clean_counter_slim.did																	!= 0 
									or	daffbase_clean_counter_slim.mh_fields.loc_err_stat		 					 = 'E501' 
									or	daffbase_clean_counter_slim.mh_fields.mail_err_stat 	 					 = 'E501' 
									or utilities.fisusa(daffbase_clean_counter_slim.mh_fields.country)	 = false
									;

	daffbase_with_did						:= daffbase_clean_counter_slim	(filtwithdid);
	daffbase_without_did				:= daffbase_clean_counter_slim	(not(filtwithdid));
	//most records without did don't have address line1 and consequently haven't been cleaned
	//but to compare the city and state, we need them to be cleaned


	//Start with most specific to less specific if no match
	djoingetcandidates := join(
		 distribute(pHeaderBase						,hash64(trim((string20)lname,left,right)	,trim((string20)fname					,left,right)))
		,distribute(daffbase_without_did	,hash64(trim(mh_fields.lname,left,right)	,trim(mh_fields.fname					,left,right)))
		,			(string20)left.lname = right.mh_fields.lname
		 and 	(string20)left.fname = right.mh_fields.fname
		 and	 ((	(			left.st					= right.mh_fields.mail_st
								or 	left.st					= right.mh_fields.loc_st
								or	left.st					= right.mh_fields.admit_st
							) 
								and left.st != ''
						)	
					 or (string)trim(left.dob[1..4],left,right) = trim(right.mh_fields.born_year,left,right)
					)
		,transform(layslim,
			self.did  								:= left.did				;
			self.hdr_fields.fname			:= left.fname			;
			self.hdr_fields.mname			:= left.mname			;
			self.hdr_fields.lname			:= left.lname			;
			self.hdr_fields.dob				:= left.dob				;
			self.hdr_fields.city_name	:= left.city_name	;
			self.hdr_fields.phone			:= left.phone			;
			self.hdr_fields.st				:= left.st				;
			self		 									:= right					;
		)
		,right outer
		,local
	);
	
	djoinredist := distribute(djoingetcandidates,random());
	
	djoinwithdids 		:= djoinredist(did != 0);
	djoinwithoutdids	:= djoinredist(did  = 0);

	//can pick up some more by using mname instead of lname(for maiden names)
	djoingetcandidates2 := join(
		 distribute(pHeaderBase				,hash64(trim((string20)lname,left,right)	,trim((string20)fname					,left,right)))
		,distribute(djoinwithoutdids	,hash64(trim(mh_fields.mname,left,right)	,trim(mh_fields.fname					,left,right)))
		,			(string20)left.lname	= right.mh_fields.mname
		 and 	(string20)left.fname	= right.mh_fields.fname
		 
		 and	 ((	(	left.st					= right.mh_fields.mail_st
						or 	left.st					= right.mh_fields.loc_st
						or	left.st					= right.mh_fields.admit_st
						) and left.st != ''
						
		 )
					 or (string)trim(left.dob[1..4],left,right) = trim(right.mh_fields.born_year,left,right)
		)
		,transform(layslim,
			self.did  								:= left.did				;
			self.hdr_fields.fname			:= left.fname			;
			self.hdr_fields.mname			:= left.mname			;
			self.hdr_fields.lname			:= left.lname			;
			self.hdr_fields.dob				:= left.dob				;
			self.hdr_fields.city_name	:= left.city_name	;
			self.hdr_fields.phone			:= left.phone			;
			self.hdr_fields.st				:= left.st				;
			self		 									:= right					;
		)
		,right outer
		,local
	);

	djoinredist2 := distribute(djoingetcandidates2,random());
	
	djoinwithdids2 		:= djoinredist2(did != 0);
	djoinwithoutdids2	:= djoinredist2(did  = 0);

	djoinwithdidsconcat := djoinwithdids + djoinwithdids2;

	dproj1 := project(djoinwithdidsconcat, transform(layslim,
		integer4 mname_score := map(
											 left.hdr_fields.mname			= left.mh_fields.mname 		and left.hdr_fields.mname != '' 	=>	5
											,left.hdr_fields.mname[1]	= left.mh_fields.mname[1]	and left.hdr_fields.mname != '' 	=>	2
											,(left.hdr_fields.mname 		= '' 	and left.mh_fields.mname != '')
											or (left.hdr_fields.mname != '' and left.mh_fields.mname = '')								
											or (left.hdr_fields.mname = '' and left.mh_fields.mname = '')								=> 0
											,																																				 		-15
										);
		integer4 dob_score := map((string)left.hdr_fields.dob[1..4] = trim(left.mh_fields.born_year,left,right)
								and left.hdr_fields.dob != 0
								=> 7
								,(string)left.hdr_fields.dob[1..4] != trim(left.mh_fields.born_year,left,right)
								and left.hdr_fields.dob != 0 and trim(left.mh_fields.born_year,left,right) != ''
								=> -15
								,0
							);
		integer4 city_score := if(	left.hdr_fields.city_name != '' and 
																(			left.hdr_fields.city_name	= left.mh_fields.mail_city
																	or	left.hdr_fields.city_name	= left.mh_fields.loc_city	
																)
															,5
															,0
														);
		integer4 phone_score := if(left.hdr_fields.phone != ''
						and (
											left.hdr_fields.phone = left.mh_fields.contact_fax									
									or	left.hdr_fields.phone = left.mh_fields.contact_phone							
									or	left.hdr_fields.phone = left.mh_fields.indiv_cell	
									or	left.hdr_fields.phone = left.mh_fields.indiv_fax		
									or	left.hdr_fields.phone = left.mh_fields.indiv_phone	
						)
							,7
							,0
						);
		integer4 state_score := if(	left.hdr_fields.st != '' and 
																(			left.hdr_fields.st	= left.mh_fields.mail_st
																	or	left.hdr_fields.st	= left.mh_fields.loc_st	
																	or	left.hdr_fields.st	= left.mh_fields.admit_st	
																)
															,5
															,0
														);
	//max score = 23
	//cutoff score = 7
	//maybe lower score without any negatives if person is unique
		self.score				:= mname_score + dob_score + city_score + phone_score + state_score;
		self.mname_score	:= mname_score																														;
		self.dob_score		:= dob_score																															;
		self.city_score		:= city_score																															;
		self.phone_score	:= phone_score																														;
		self.state_score	:= state_score																														;
		self.did					:= left.did;
		self							:= left;
	));
	
	//so, how many dids did we get per cnt(unique record)?
	//if more than one, can't be more than one for the same score.
	//take highest scoring did
	//get # of DIDs per cnt and score--can only be one.
	set_isln_cnts 		:= set(daffbase_clean_counter_slim(mh_fields.isln	= pISLN_Filter or mh_fields.attyno = pISLN_Filter), cnt);
	dtable 					:= table(table(dproj1	, {cnt, score, did}, cnt, score, did), {cnt, score, unsigned8 cntuniquedids := count(group)}, cnt, score);
	dtable_scrub 		:= dedup(sort(distribute(dtable, cnt), cnt, -score,local), cnt,local);
	dtable_scrub_1 	:= dtable_scrub(cntuniquedids = 1,score > 2);
	
	djoin2 := join(
		 dedup(sort(distribute(dedup(sort(dproj1,cnt,-score,local),cnt,local), cnt), cnt, -score,local), cnt,local)
		,dtable_scrub_1
		,		left.cnt 		= right.cnt
		and left.score 	= right.score
		,transform(layslim,
			self.did 		:= if(right.cnt != 0	,left.did		, 0);
			self.score 	:= if(right.cnt != 0	,left.score	, 0);
			self				:= left;
		)
		,left outer
	);
	
	//dids from macro are priority
//	daffbase_with_did_proj := project(daffbase_with_did, transform(layslim, self.score := left.did_score;self := left;));
	dconcat_layslims := djoinwithoutdids2 + djoin2 + daffbase_with_did;
	dconcat_rejoin := join(
		 daffbase_clean_counter
		,dconcat_layslims
		,left.cnt = right.cnt
		,transform(layextra,
			self.did 	:= right.did;
			self.hdr_fields			:= right.hdr_fields;
			self.mh_fields			:= right.mh_fields;
			self			:= right;
			self			:= left;
	));
	
	//now we have one record per cnt, and the correct dids appended
	//now need to propagate dids per isln
	dconcat 						:= dconcat_rejoin;
	dconcat_withisln 		:= dconcat(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN != '');
	dconcat_withoutisln := dconcat(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN  = '');
	
	diterate := iterate(group(sort(distribute(dconcat_withisln, hash64(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN)), rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN, -did, -score,local), rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN, local),transform(
		 layextra
		,self.did := if(left.rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = '', right.did,left.did);
		 self 		:= right;
	));
	
	diterate2 := iterate(group(sort(distribute(dconcat_withoutisln, hash64(rawfields.header_aff_indiv_indiv_audit_attyno)), rawfields.header_aff_indiv_indiv_audit_attyno, -did, -score,local), rawfields.header_aff_indiv_indiv_audit_attyno, local),transform(
		 layextra
		,self.did := if(left.rawfields.header_aff_indiv_indiv_audit_attyno = '', right.did,left.did);
		 self 		:= right;
	));

	returndataset := group(diterate) + group(diterate2);

	returnactions := parallel(
		 output(pISLN_Filter																													 ,named('pISLN_Filter'								),all)
		,output(set_isln_cnts																													 ,named('set_isln_cnts'								),all)
		,output(pAffBase									(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('paffBase'									),all)
//		,output(daffbase_counter						(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter),named('daffbase_counter'							),all)
		,output(daffbase_clean_counter			(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('daffbase_clean_counter'			),all)
		,output(daffbase_clean_counter_slim	(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('daffbase_clean_counter_slim'	),all)
		,output(daffbase_with_did						(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('daffbase_with_did'						),all)
		,output(daffbase_without_did				(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('daffbase_without_did'				),all)
		,output(djoingetcandidates					(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('djoingetcandidates'					),all)
		,output(djoinredist									(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('djoinredist'									),all)
		,output(djoinwithdids 							(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('djoinwithdids' 							),all)
		,output(djoinwithoutdids						(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('djoinwithoutdids'						),all)
		,output(dproj1											(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('dproj1'											),all)
		,output(dtable 											(cnt 											in set_isln_cnts),named('dtable' 											),all)
		,output(dtable_scrub 								(cnt 											in set_isln_cnts),named('dtable_scrub' 								),all)
		,output(dtable_scrub_1							(cnt 											in set_isln_cnts),named('dtable_scrub_1'							),all)
		,output(djoin2											(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('djoin2'											),all)
		,output(dconcat_layslims						(mh_fields.isln							= pISLN_Filter or mh_fields.attyno							= pISLN_Filter),named('dconcat_layslims'						),all)
		,output(dconcat_rejoin							(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('dconcat_rejoin'							),all)
		,output(dconcat 										(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('dconcat' 										),all)
		,output(dconcat_withisln 						(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('dconcat_withisln' 						),all)
		,output(dconcat_withoutisln 				(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('dconcat_withoutisln' 				),all)
		,output(diterate 										(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('diterate' 										),all)
		,output(returndataset 							(rawfields.HEADER_AFF_INDIV_INDIV_AUDIT_ISLN = pISLN_Filter or rawfields.header_aff_indiv_indiv_audit_attyno = pISLN_Filter),named('returndataset' 							),all)
	);

	return 
//		returnactions;
		returndataset;

end;