import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,aid,corp2;

export Dell_Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendAid(
	
		dataset(Layouts.Temporary.StandardizeInput) pDataset
	
	) :=
	function
	
		HasAddress		:= 		trim(pDataset.address1, left,right) != ''
										and trim(pDataset.address2, left,right) != '';
									
		dWith_address			:= pDataset(HasAddress);
		dWithout_address	:= pDataset(not(HasAddress));

		unsigned4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.ACECacheRecords;
		
		dwith_address_rawaid := project(dWith_address	,transform({unsigned8 raw_aid,Layouts.Temporary.StandardizeInput}, self.raw_aid := 0;self := left));
		
		AID.MacAppendFromRaw_2Line(dwith_address_rawaid, Address1, Address2, Raw_AID, dwithAID, lFlags);
		
		dAID := project(
			dwithAID
			,transform(
				Layouts.Temporary.StandardizeInput
				,self.ace_aid										:= left.aidwork_acecache.aid;
				 self.Clean_address.fips_state	:= left.aidwork_acecache.county[1..2];
				 self.Clean_address.fips_county := left.aidwork_acecache.county[3..];
				 self.Clean_address							:= left.aidwork_acecache;
				 self														:= left;
			)
		)
		+ dWithout_address
		;	

		return dAID;
	
	
	end;
	
	lay_corpv2 := Corp2.Layout_Corporate_Direct_Corp_Base;
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(
	
		 dataset(Layouts.Temporary.StandardizeInput	) pDataset
		,dataset(lay_corpv2													)	pCorpV2						= Prep_CorpV2.fCorp()
		,dataset(Layouts.laybus											) pBusinessSummary	= files().business_summary.built
	
	) :=
	function

		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Temporary.StandardizeInput l) :=
		transform

			self.unique_id		:= l.unique_id	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.UniqueId l) :=
		transform

			self.unique_id		:= l.unique_id									;
			self.company_name	:= l.rawfields.LEGAL_NAME				;
			self.prim_range		:= l.Clean_address.prim_range		;
			self.prim_name		:= l.Clean_address.prim_name		;
			self.city					:= l.Clean_address.v_city_name	;
			self.zip5					:= l.Clean_address.zip					;
			self.sec_range		:= l.Clean_address.sec_range		;
			self.state				:= l.Clean_address.st						;
			self.phone				:= l.clean_phones.phone					;
			self.bdid					:= 0														;
			self.bdid_score		:= 0														;
			self.match_criteria		:= ''														;
			self.ace_aid			:= l.ace_aid										;
			self.App_ref_key	:= l.rawfields.App_ref_key;

		end;   

		dSlimForBdiding :=  project(dAddUniqueId
																,tSlimForBdiding(left)
																);
		
		/////////////////////////////////////////////////////////////////////////////////////
		// -- Run through bdid macro first
		/////////////////////////////////////////////////////////////////////////////////////
		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimForBdiding											// Input Dataset						
			,BDID_Matchset                        // BDID Matchset what fields to match on           
			,company_name	                        // company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip5					                        // zip5					              
			,sec_range		                        // sec_range		              
			,state				                        // state				              
			,phone				                        // phone				              
			,fein_not_used                        // fein              
			,bdid													        // bdid												
			,Layouts.Temporary.BdidSlim           // Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset                   
		);                                         

		dBdidOut_withBdid			:= dBDidOut(bdid != 0);
		dBDidOut_withoutbdid	:= dBDidOut(bdid = 0); 
		
		dBusinessSummary_bdids := table(pBusinessSummary(bdid != 0)	,{bdid},bdid);
		//join to biz summary to make sure bdid is in there, otherwise, try NCS match
		
		dBdid_in_BizSumm := join(
			 distribute(dBdidOut_withBdid				,bdid)
			,distribute(dBusinessSummary_bdids	,bdid)
			,left.bdid = right.bdid
			,transform(
				recordof(dBdidOut_withBdid)
				,self := left;
			)
			,local
		)
		 : persist(Persistnames().DellAppendIdsBdid_dBdid_in_BizSumm);
		
		dBdid_Not_in_BizSumm := join(
			 distribute(dBdidOut_withBdid				,bdid)
			,distribute(dBusinessSummary_bdids	,bdid)
			,left.bdid = right.bdid
			,transform(
				recordof(dBdidOut_withBdid)
				,self := left;
			)
			,local
			,left only
		)
		 : persist(Persistnames().DellAppendIdsBdid_dBdid_Not_in_BizSumm);

		dBdidOut_withoutbdid_all := dBDidOut_withoutbdid + dBdid_Not_in_BizSumm
		 : persist(Persistnames().DellAppendIdsBdid_dBdidOut_withoutbdid_all);
		
		dBDidOut_withGoodbdid			:= project(dBdid_in_BizSumm,transform(Layouts.Temporary.BdidSlim
			,self.match_criteria := 'LinkID';self := left));
		
		/////////////////////////////////////////////////////////////////////////////////////
		// -- ones without bdid need to run through name, city, state match
		/////////////////////////////////////////////////////////////////////////////////////
		
		// -- get unique name, city,state records from corpV2 so can match against them
		dCorpV2_Unique_Name_City_State := fCorpV2_Unique_Name_City_State(pCorpV2);
		
		djoinCityState := join(
			 distribute(dBdidOut_withoutbdid_all				,hash64(company_name,city,state))
			,distribute(dCorpV2_Unique_Name_City_State	,hash64(corp_legal_name,city,state))
			,		left.company_name = right.corp_legal_name
			and left.city					= right.city
			and left.state				= right.state
			,transform(
				recordof(dBDidOut_withoutbdid)
				,self.bdid := right.bdid;
				 self.match_criteria := 'NCS';
				 self := left;
			)
			,local
			,keep(1)
		)
		 : persist(Persistnames().DellAppendIdsBdid_djoinCityState);
		

		djoinCityState_nomatches := join(
			 distribute(dBdid_Not_in_BizSumm						,hash64(company_name,city,state))
			,distribute(dCorpV2_Unique_Name_City_State	,hash64(corp_legal_name,city,state))
			,		left.company_name = right.corp_legal_name
			and left.city					= right.city
			and left.state				= right.state
			,transform(
				recordof(dBDidOut_withoutbdid)
				,self.bdid := left.bdid;
				 self.match_criteria := 'LinkID';
				 self := left;
			)
			,local
			,left only
		)
		 : persist(Persistnames().DellAppendIdsBdid_djoinCityState_nomatches);

		/////////////////////////////////////////////////////////////////////////////////////
		// -- Concatenate datasets, join back to populate bdid field
		/////////////////////////////////////////////////////////////////////////////////////
		dall_matches := dBDidOut_withGoodbdid + djoinCityState + djoinCityState_nomatches;
		dBDidOut_dist			:= distribute	(dall_matches(bdid != 0)	,unique_id										);
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	,local)
		 : persist(Persistnames().DellAppendIdsBdid_dBDidOut_sort);
		
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local)
		 : persist(Persistnames().DellAppendIdsBdid_dBDidOut_dedup);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);

			 
		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid																:= if(r.bdid 				<> 0	,r.bdid						,0	);
			self.bdid_score													:= if(r.bdid_score	<> 0	,r.bdid_score			,0	);
			self.appended_fields.filing_match 			:= '';
			self.appended_fields.filing_type_match	:= '';
			self.appended_fields.match_criteria			:= if(r.bdid 				<> 0	,r.match_criteria	,''	);
			self 						:= l;

		end;

		dAssignBdids := join(
											 dAddUniqueId_dist
											,dBDidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignBdids(left, right)
											,left outer
											,local
											)
		 : persist(Persistnames().DellAppendIdsBdid_dAssignBdids);
		
		return dAssignBdids;
		
	end;
	
	
	export fAll(
		
		dataset(Layouts.Temporary.StandardizeInput	)	pDataset
	
	) :=
	function
	
		dAppendAid			:= fAppendAid		(pDataset		)	: persist(Persistnames().DellAppendIdsAid	);
		dAppendAid_dec	:= if(_Dataset().ShouldRecaculatePersist,dAppendAid, Persists().DellAppendIdsAid);
		dAppendBdid			:= fAppendBdid	(dAppendAid_dec	) : persist(Persistnames().DellAppendIdsBdid);
		                                                              
		return dAppendBdid;
	
	end;


end;
