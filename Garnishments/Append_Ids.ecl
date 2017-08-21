import Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(Layouts.Base) pDataset) :=
	function
		
		//Add unique id
		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueId l) :=
		transform
			
			self.fname				:= l.clean_defendant_name.fname						;
			self.mname				:= l.clean_defendant_name.mname						;
			self.lname				:= l.clean_defendant_name.lname						;
			self.name_suffix	:= l.clean_defendant_name.name_suffix			;
			self.prim_range		:= l.Clean_Defendant_address.prim_range		;
			self.prim_name		:= l.Clean_Defendant_address.prim_name		;
			self.sec_range		:= l.Clean_Defendant_address.sec_range		;
			self.zip5				 	:= l.Clean_Defendant_address.zip					;
			self.state				:= l.Clean_Defendant_address.st						;
			self.phone				:= (string10)l.clean_phones.AttorneyPhone	;	//attorney phone contains defendant phone
			self.did					:= 0																			;
			self.did_score		:= 0																			;
			self							:= l																			;	

		end;
		
									
		dSlimForDiding	:= project(dAddUniqueId
																,tSlimForDiding(left)
																);
		
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A','P'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding							// Input Dataset
			,Did_Matchset             	// Did_Matchset  what fields to match on
			,ssn                				// ssn
			,dob                 				// dob
			,fname											// fname
			,mname			     						// mname
			,lname			     						// lname
			,name_suffix     						// name_suffix
			,prim_range	          			// prim_range
			,prim_name	          			// prim_name
			,sec_range	          			// sec_range
			,zip5				          			// zip5
			,state			          			// state
			,phone			          			// phone10
			,did                      	// Did
			,Layouts.Temporary.DidSlim  // output layout
			,TRUE                     	// Does output record have the score
			,did_score                	// did score field
			,75                       	// score threshold
			,dDidOut								  	// output dataset			
		);                          


		dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id										);
		dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id							,local);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id										);

			 
		Layouts.Base tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
		transform

			self.did				:= if(r.did 			<> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;

		dAssignDids := join(
											 dAddUniqueId_dist
											,dDidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignDIDs(left, right)
											,left outer
											,local
											);
		
		return dAssignDids;

	end;


	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	// -- Standardizes addresses
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(dataset(Layouts.Base) pDataset) :=
	function

		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.UniqueId l, unsigned2 cnt) :=
		transform

			self.unique_id		:= l.unique_id													;
			self.company_name	:= l.rawfields.AttorneyName							;
			self.prim_range		:= l.Clean_attorney_address.prim_range	;
			self.prim_name		:= l.Clean_attorney_address.prim_name		;
			self.zip5					:= l.Clean_attorney_address.zip					;
			self.sec_range		:= l.Clean_attorney_address.sec_range		;
			self.p_city_name	:= l.Clean_attorney_address.p_city_name	;
			self.state				:= l.Clean_attorney_address.st					;
			self.phone				:= ''																		;
			self.bdid					:= 0																		;
			self.bdid_score		:= 0																		;

		end;   

		dSlimForBdiding :=  project(dAddUniqueId
																,tSlimForBdiding(left,counter)
																);

		BDID_Matchset := ['A'];

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
			,																			// score_threshold
			,																			// file version (prod)
			,																			// use other environment?
			,BIPV2.xlink_version_set  						// BIP2 ids
			,																			// URL
			,																			// email
			,p_city_name													// city		
		);                                         
                                        
		dBDidOut_dist			:= distribute	(dBDidOut(bdid 		!= 0 or 
																							Ultid 	!= 0 or 
																							OrgID 	!= 0 or 
																							ProxID 	!= 0 or 
																							SeleID 	!= 0 or 																							
																							POWID 	!= 0 or 
																							EmpID 	!= 0 or 
																							DotID 	!= 0),unique_id									);	
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	, -Ultscore, -Orgscore, -Proxscore, -SELEscore, -POWscore, -Empscore, -Dotscore, local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);

			 
		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
			self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.Ultid			:= if(r.Ultid				<> 0, r.Ultid				, 0);
			self.Ultscore		:= if(r.Ultscore		<> 0, r.Ultscore		, 0);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
			self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
			self.Orgscore		:= if(r.Orgscore		<> 0, r.Orgscore		, 0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);			
			self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
			self.Proxscore	:= if(r.Proxscore		<> 0, r.Proxscore		, 0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);			
			self.SELEID			:= if(r.SELEID			<> 0, r.SELEID			, 0);
			self.SELEscore	:= if(r.SELEscore		<> 0, r.SELEscore		, 0);
			self.SELEWeight	:= if(r.SELEWeight	<> 0, r.SELEWeight	, 0);			
			self.POWID			:= if(r.POWID				<> 0, r.POWID				, 0);
			self.POWscore		:= if(r.POWscore		<> 0, r.POWscore		, 0);
			self.POWWeight	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);			
			self.EmpID			:= if(r.EmpID				<> 0, r.EmpID				, 0);
			self.Empscore		:= if(r.Empscore		<> 0, r.Empscore		, 0);
			self.EmpWeight	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);			
			self.DotID			:= if(r.DotID				<> 0, r.DotID				, 0);
			self.Dotscore		:= if(r.Dotscore		<> 0, r.Dotscore		, 0);
			self.DotWeight	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);						
			self 						:= l;

		end;

		dAssignBdids := join(
											 dAddUniqueId_dist
											,dBDidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignBdids(left, right)
											,left outer
											,local
											);
		
		return dAssignBdids;
		
	end;
	
	
	export fAll(
		dataset(Layouts.Base	)	pDataset
	) :=
	function
	
		dAppendDid		:= fAppendDid		(pDataset		) : persist(Persistnames().AppendIdsfAppendDid	);
		dAppendBdid		:= fAppendBdid	(dAppendDid	) : persist(Persistnames().AppendIdsfAppendBdid	);
		                                                              
		return dAppendBdid;
	
	end;


end;
