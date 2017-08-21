import business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2;

export Append_Ids :=
module

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
		
			phone := map( cnt = 1 and l.clean_phone						!= '' => l.clean_phone
									 ,cnt = 2 and l.clean_secondary_phone	!= '' => l.clean_secondary_phone
									 ,cnt = 1 and l.clean_phone	 					 = '' => l.clean_secondary_phone
									 ,l.clean_phone
									);
		
			self.unique_id		:= l.unique_id	;
			self.brand_name		:= l.brand_name	;
			self.prim_range		:= l.prim_range	;
			self.prim_name		:= l.prim_name	;
			self.zip5					:= l.zip			  ;
			self.sec_range		:= l.sec_range	;
			self.p_city_name	:= l.p_city_name;
			self.state				:= l.st					;
			self.phone				:= phone				;
			self.Website_Url	:= l.Website_Url;
			self.Email				:= l.Email			;
			self.fname				:= l.fname			;
			self.mname				:= l.mname			;
			self.lname				:= l.lname			;
			self.bdid					:= 0						;
			self.bdid_score		:= 0						;
			self							:= []						;
		end;   
    
		choosey(string pPhone, string pPhone2) := 
			map(			pPhone	!= ''
						and pPhone2		!= '' => 2, 1);
						
		dSlimForBdiding	:= normalize(dAddUniqueId
																,choosey(left.clean_phone, left.clean_secondary_phone)
																,tSlimForBDiding(left,counter)
																);

		//*** Match set for BDIDing
		BDID_Matchset := ['A','P'];
		
		//**** External id macro that appends BDID's and BIPV2 xlinkids
		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimForBdiding											// Input Dataset						
			,BDID_Matchset                        // BDID Matchset what fields to match on           
			,brand_name        		             		// company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip5 					                      // zip5					              
			,sec_range		                        // sec_range		              
			,state				                        // state				              
			,phone				                        // phone				              
			,fein_not_used                        // fein              
			,bdid													        // bdid												
			,Layouts.Temporary.BdidSlim	          // Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset   
			,																			// deafult threscold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// Create BID Keys only
			,Website_Url													// Url
			,Email																// Email
			,p_City_name													// City
			,fname																// fname
			,mname																// mname
			,lname																// lname
		);
		
		dBdidOut_dist			:= distribute	(dBdidOut(bdid 		!= 0 or 
																							Ultid 	!= 0 or 
																							OrgID 	!= 0 or 
																							ProxID 	!= 0 or
																							SELEID 	!= 0 or
																							POWID 	!= 0 or 
																							EmpID 	!= 0 or 
																							DotID 	!= 0)	,unique_id										);
		dBdidOut_sort			:= sort				(dBdidOut_dist				,unique_id, -bdid_score, -ProxScore, local);
		dBdidOut_dedup		:= dedup			(dBdidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);

			 
		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid					:= if(r.bdid 				<> 0, r.bdid				, 0);
			self.bdid_score		:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.Ultid				:= if(r.Ultid 			<> 0, r.Ultid				, 0);
			self.Ultscore			:= if(r.Ultscore		<> 0, r.Ultscore		, 0);
			self.UltWeight		:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
			self.OrgID				:= if(r.OrgID 			<> 0, r.OrgID				, 0);
			self.Orgscore			:= if(r.Orgscore		<> 0, r.Orgscore		, 0);
			self.OrgWeight		:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
			self.ProxID				:= if(r.ProxID 			<> 0, r.ProxID			, 0);
			self.Proxscore		:= if(r.Proxscore		<> 0, r.Proxscore		, 0);
			self.ProxWeight		:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
			self.SELEID				:= if(r.SELEID			<> 0, r.SELEID			,	0);
			self.SELEScore		:= if(r.SELEScore		<> 0, r.SELEScore		,	0);
			self.SELEWeight		:= if(r.SELEWeight	<> 0, r.SELEWeight	,	0);
			self.POWID				:= if(r.POWID 			<> 0, r.POWID				, 0);
			self.POWscore			:= if(r.POWscore		<> 0, r.POWscore		, 0);
			self.POWWeight		:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
			self.EmpID				:= if(r.EmpID 			<> 0, r.EmpID				, 0);
			self.Empscore			:= if(r.Empscore		<> 0, r.Empscore		, 0);
			self.EmpWeight		:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
			self.DotID				:= if(r.DotID 			<> 0, r.DotID				, 0);
			self.Dotscore			:= if(r.Dotscore		<> 0, r.Dotscore		, 0);
			self.DotWeight		:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
			self 							:= l;

		end;

		dAssignBdids := join(dAddUniqueId_dist
												,dBdidOut_dedup
												,left.unique_id = right.unique_id
												,tAssignBdids(left, right)
												,left outer
												,local
												);
		
		return dAssignBdids;
				
	end;
	
	
	export fAll(
			dataset(Layouts.Base	)													pDataset		 
	) :=
	function
	
		dAppendBdid		:= fAppendBdid	(pDataset	): persist(Persistnames().AppendIds);
				                                                              
		return dAppendBdid;
	
	end;


end;