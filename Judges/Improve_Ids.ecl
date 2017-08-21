import header;

dhdr_nonGLB := dataset(header.Filename_Header,header.Layout_Header_v2,flat);

export Improve_Ids(

	 dataset(Layouts.Base										) pJudgeBase
	,dataset(header.Layout_Header_v2				) pHeaderBase 	= dhdr_nonGLB(header.isPreGLB(dhdr_nonGLB))
	,string																		pISLN_Filter	= ''

) :=
function
	//clean the records with only city and state so can get the cities and states standardized(for matching to header)

	dJudgeBasePrep := project(pJudgeBase, transform(layouts.temporary.redid,self.cnt := counter;self := left;self := [])) : global;

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
		layouts.temporary.layslimjudge	judge_fields;
		layouts.temporary.layhdrextra		hdr_fields;
		
	end;

	layextra := layouts.temporary.redid;

	dJudgeBase_clean_counter 	:= dJudgeBasePrep;

	dJudgeBase_clean_counter_slim := project(dJudgeBase_clean_counter,transform(layslim
	,self.hdr_fields 							 		:= []															;
	 self.judge_fields.lname					:= left.clean_contact_name.lname	;
	 self.judge_fields.fname 					:= left.clean_contact_name.fname	;
	 self.judge_fields.mname					:= left.clean_contact_name.mname	;
	 self.judge_fields.st							:= left.Clean_address.st					;
	 self.judge_fields.year_born			:= left.rawfields.year_born				;
	 self.judge_fields.city			 			:= left.Clean_address.v_city_name	;
	 self.judge_fields.ISLN			 		 	:= left.rawfields.ISLN						;
	 self.judge_fields.dob						:= (string8)left.clean_dates.dob	;
	 self.judge_fields.err_stat	 			:= left.clean_address.err_stat		;
	 self.did 										 		:= left.did												;
	 self.did_score								 		:= left.did_score									;
	 self.cnt											 		:= left.cnt												;
	 self.score										 		:= 0															;
	 self.mname_score							 		:= 0															;
	 self.dob_score								 		:= 0															;
	 self.city_score							 		:= 0															;
	 self.phone_score							 		:= 0															;
	 self.state_score							 		:= 0															;
	
	));

	filtwithdid := 			dJudgeBase_clean_counter_slim.did																	!= 0 
									or	dJudgeBase_clean_counter_slim.judge_fields.err_stat		 					 = 'E501' 
									;

	dJudgeBase_with_did						:= dJudgeBase_clean_counter_slim	(filtwithdid);
	dJudgeBase_without_did				:= dJudgeBase_clean_counter_slim	(not(filtwithdid));
	//most records without did don't have address line1 and consequently haven't been cleaned
	//but to compare the city and state, we need them to be cleaned


	//Start with most specific to less specific if no match
	djoingetcandidates := join(
		 distribute(pHeaderBase						,hash64(trim((string20)lname,left,right)	,trim((string20)fname					,left,right)))
		,distribute(dJudgeBase_without_did	,hash64(trim(judge_fields.lname,left,right)	,trim(judge_fields.fname					,left,right)))
		,			(string20)left.lname = right.judge_fields.lname
		 and 	(string20)left.fname = right.judge_fields.fname
		 and	 ((	(			left.st					= right.judge_fields.st
							) 
								and left.st != ''
						)	
					 or (string)trim(left.dob[1..4],left,right) = trim(right.judge_fields.year_born,left,right)
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
		 distribute(pHeaderBase				,hash64(trim((string20)lname		,left,right)	,trim((string20)fname					,left,right)))
		,distribute(djoinwithoutdids	,hash64(trim(judge_fields.mname	,left,right)	,trim(judge_fields.fname			,left,right)))
		,			(string20)left.lname	= right.judge_fields.mname
		 and 	(string20)left.fname	= right.judge_fields.fname
		 
		 and	 ((	(	left.st					= right.judge_fields.st
						) and left.st != ''
						
		 )
					 or (string)trim(left.dob[1..4],left,right) = trim(right.judge_fields.year_born,left,right)
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
											 left.hdr_fields.mname			= left.judge_fields.mname 		and left.hdr_fields.mname != '' 	=>	5
											,left.hdr_fields.mname[1]	= left.judge_fields.mname[1]	and left.hdr_fields.mname != '' 	=>	2
											,(left.hdr_fields.mname 		= '' 	and left.judge_fields.mname != '')
											or (left.hdr_fields.mname != '' and left.judge_fields.mname = '')								
											or (left.hdr_fields.mname = '' and left.judge_fields.mname = '')								=> 0
											,																																				 		-15
										);
		integer4 dob_score := map((string)left.hdr_fields.dob[1..4] = trim(left.judge_fields.year_born,left,right)
								and left.hdr_fields.dob != 0
								=> 7
								,(string)left.hdr_fields.dob[1..4] != trim(left.judge_fields.year_born,left,right)
								and left.hdr_fields.dob != 0 and trim(left.judge_fields.year_born,left,right) != ''
								=> -15
								,0
							);
		integer4 city_score := if(	left.hdr_fields.city_name != '' and 
																(			left.hdr_fields.city_name	= left.judge_fields.city
																)
															,5
															,0
														);
		integer4 state_score := if(	left.hdr_fields.st != '' and 
																(			left.hdr_fields.st	= left.judge_fields.st
																)
															,5
															,0
														);
	//max score = 23
	//cutoff score = 7
	//maybe lower score without any negatives if person is unique
		self.score				:= mname_score + dob_score + city_score + state_score;
		self.mname_score	:= mname_score																														;
		self.dob_score		:= dob_score																															;
		self.city_score		:= city_score																															;
		self.phone_score	:= 0																														;
		self.state_score	:= state_score																														;
		self.did					:= left.did;
		self							:= left;
	));
	
	//so, how many dids did we get per cnt(unique record)?
	//if more than one, can't be more than one for the same score.
	//take highest scoring did
	//get # of DIDs per cnt and score--can only be one.
	set_isln_cnts 		:= set(dJudgeBase_clean_counter_slim(judge_fields.isln	= pISLN_Filter), cnt);
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
//	dJudgeBase_with_did_proj := project(dJudgeBase_with_did, transform(layslim, self.score := left.did_score;self := left;));
	dconcat_layslims := djoinwithoutdids2 + djoin2 + dJudgeBase_with_did;
	dconcat_rejoin := join(
		 dJudgeBase_clean_counter
		,dconcat_layslims
		,left.cnt = right.cnt
		,transform(layextra,
			self.did 	:= right.did;
			self.hdr_fields			:= right.hdr_fields;
			self.judge_fields			:= right.judge_fields;
			self			:= right;
			self			:= left;
	));
	
	//now we have one record per cnt, and the correct dids appended
	//now need to propagate dids per isln
	dconcat 						:= dconcat_rejoin;
	dconcat_withisln 		:= dconcat(rawfields.isln != '');
	dconcat_withoutisln := dconcat(rawfields.isln  = '');
	
	diterate := iterate(group(sort(distribute(dconcat_withisln, hash64(rawfields.isln)), rawfields.isln, -did, -score,local), rawfields.isln, local),transform(
		 layextra
		,self.did := if(left.rawfields.isln = '', right.did,left.did);
		 self 		:= right;
	));
	
/*	diterate2 := iterate(group(sort(distribute(dconcat_withoutisln, hash64(rawfields.header_aff_indiv_indiv_audit_attyno)), rawfields.header_aff_indiv_indiv_audit_attyno, -did, -score,local), rawfields.header_aff_indiv_indiv_audit_attyno, local),transform(
		 layextra
		,self.did := if(left.rawfields.header_aff_indiv_indiv_audit_attyno = '', right.did,left.did);
		 self 		:= right;
	));
*/
	returndataset := group(diterate) + dconcat_withoutisln;

	returnactions := parallel(
		 output(pISLN_Filter																													 ,named('pISLN_Filter'								),all)
		,output(set_isln_cnts																													 ,named('set_isln_cnts'								),all)
		,output(pJudgeBase									(rawfields.isln = pISLN_Filter),named('pJudgeBase'									),all)
//		,output(dJudgeBase_counter						(rawfields.isln = pISLN_Filter),named('dJudgeBase_counter'							),all)
		,output(dJudgeBase_clean_counter			(rawfields.isln = pISLN_Filter),named('dJudgeBase_clean_counter'			),all)
		,output(dJudgeBase_clean_counter_slim	(judge_fields.isln							= pISLN_Filter),named('dJudgeBase_clean_counter_slim'	),all)
		,output(dJudgeBase_with_did						(judge_fields.isln							= pISLN_Filter),named('dJudgeBase_with_did'						),all)
		,output(dJudgeBase_without_did				(judge_fields.isln							= pISLN_Filter),named('dJudgeBase_without_did'				),all)
		,output(djoingetcandidates					(judge_fields.isln							= pISLN_Filter),named('djoingetcandidates'					),all)
		,output(djoinredist									(judge_fields.isln							= pISLN_Filter),named('djoinredist'									),all)
		,output(djoinwithdids 							(judge_fields.isln							= pISLN_Filter),named('djoinwithdids' 							),all)
		,output(djoinwithoutdids						(judge_fields.isln							= pISLN_Filter),named('djoinwithoutdids'						),all)
		,output(dproj1											(judge_fields.isln							= pISLN_Filter),named('dproj1'											),all)
		,output(dtable 											(cnt 											in set_isln_cnts),named('dtable' 											),all)
		,output(dtable_scrub 								(cnt 											in set_isln_cnts),named('dtable_scrub' 								),all)
		,output(dtable_scrub_1							(cnt 											in set_isln_cnts),named('dtable_scrub_1'							),all)
		,output(djoin2											(judge_fields.isln							= pISLN_Filter),named('djoin2'											),all)
		,output(dconcat_layslims						(judge_fields.isln							= pISLN_Filter),named('dconcat_layslims'						),all)
		,output(dconcat_rejoin							(rawfields.isln = pISLN_Filter),named('dconcat_rejoin'							),all)
		,output(dconcat 										(rawfields.isln = pISLN_Filter),named('dconcat' 										),all)
		,output(dconcat_withisln 						(rawfields.isln = pISLN_Filter),named('dconcat_withisln' 						),all)
		,output(dconcat_withoutisln 				(rawfields.isln = pISLN_Filter),named('dconcat_withoutisln' 				),all)
		,output(diterate 										(rawfields.isln = pISLN_Filter),named('diterate' 										),all)
		,output(returndataset 							(rawfields.isln = pISLN_Filter),named('returndataset' 							),all)
	);

	return 
//		returnactions;
		returndataset;

end;