import DID_Add, Business_Header_SS;


export Append_Ids :=	module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendDid
	// -- Append DID
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(Layouts.KeyBuild) pDataset) :=	function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Diding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.DidSlim tSlimForDiding(Layouts.KeyBuild l, unsigned2 cnt) :=transform
		self.unique_id		:= l.unique_id;
		self.prim_range		:= choose(cnt,l.p_prim_range,l.m_prim_range	);
		self.prim_name		:= choose(cnt,l.p_prim_name,l.m_prim_name			);
		self.zip					:= choose(cnt,l.p_zip,l.m_zip					);
		self.sec_range		:= choose(cnt,l.p_sec_range,l.m_sec_range			);
		self.st						:= choose(cnt,l.p_st,l.m_st	);
		self.fname				:= l.fname	;
		self.mname				:= l.mname	;
		self.lname				:= l.lname	;
		self.phone				:= l.phone	;
		self.suffix       := l.suffix	;
		self.did					:= 0		;
		self							:= l		;
	end;

	dSlimForDiding :=  normalize(pDataset, if(trim(left.m_p_city_name) <>'' and
																						trim(left.m_st)        	 <>'' and
																						trim(left.m_zip)         <>'',2,1),tSlimForDiding(left,counter));

	dSlimForDiding_Sort := dedup(SORT(dSlimForDiding, record), record);

	Did_Matchset := ['A','P'];

	DID_Add.MAC_Match_Flex( dSlimForDiding_Sort								 // Input Dataset
												 ,Did_Matchset                      // Did_Matchset  what fields to match on
												 ,''												       // ssn
												 ,''												      // dob
												 ,fname											     // fname
												 ,mname											    // mname
												 ,lname											   // lname
												 ,suffix										  // name_suffix
												 ,prim_range							   // prim_range
												 ,prim_name								  // prim_name
												 ,sec_range								 // sec_range
												 ,zip											// zip5
												 ,st										 // state
												 ,phone									// phone
												 ,did                  // Did
												 ,Layouts.DidSlim			// output layout
												 ,TRUE               // Does output record have the score
												 ,did_score         // did score field
												 ,75               // score threshold
												 ,dDidOut					// output dataset
											  );

	dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id										);
	dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
	dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id							,local);

	dAddUniqueId_dist := distribute	(pDataset				,unique_id	);

	Layouts.KeyBuild tAssignDids(Layouts.KeyBuild	 l, Layouts.DidSlim r) :=transform
		self.did					:= if(r.did 				<> 0, r.did				, 0);
		self 							:= l;
	end;

	dAssignDids := join(dAddUniqueId_dist
											,dDidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignDids(left, right)
											,left outer
											,local
											);

		return dAssignDids;

	end;

	export fAppendBdid(dataset(Layouts.KeyBuild) pDataset) :=	function

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Bdiding
	//////////////////////////////////////////////////////////////////////////////////////

	Layouts.BdidSlim tSlimForBdiding(Layouts.KeyBuild l, unsigned2 cnt) := transform
		self.unique_id		:= l.unique_id				;
		self.BusinessName	:= l.BusinessName			;
		self.prim_range		:= choose(cnt,l.p_prim_range,l.m_prim_range	);
		self.prim_name		:= choose(cnt,l.p_prim_name,l.m_prim_name			);
		self.zip					:= choose(cnt,l.p_zip,l.m_zip					);
		self.sec_range		:= choose(cnt,l.p_sec_range,l.m_sec_range			);
		self.p_city_name	:= choose(cnt,l.p_p_city_name,l.m_p_city_name		);
		self.st						:= choose(cnt,l.p_st,l.m_st	);
		self.phone				:= l.phone	;
		self.email				:= l.email	;
		self.bdid					:= 0	;
		self.bdid_score		:= 0 	;
		self							:= l	;
	end;

	dSlimForBdiding :=  normalize(pDataset, if(trim(left.m_p_city_name) <>'' and
																						 trim(left.m_st)        	<>'' and
																						 trim(left.m_zip)  				<>'',2,1),tSlimForBdiding(left,counter));

	dSlimForBdiding_Sort := dedup(SORT(dSlimForBdiding, record), record);
	BDID_Matchset 			 := ['A','P'];

	Business_Header_SS.MAC_Add_BDID_Flex(dSlimForBdiding_Sort								       // Input Dataset
																			,BDID_Matchset                            // BDID Matchset
																			,BusinessName       		             		 // company_name
																			,prim_range		                          // prim_range
																			,prim_name		                         // prim_name
																			,zip    				                      // zip5
																			,sec_range		                       // sec_range
																			,st				                          // state
																			,phone				                     // phone
																			,''                               // fein
																			,bdid											 			 // bdid
																			,Layouts.BdidSlim			 	    	  // Output Layout
																			,true                          // output layout has bdid score field?
																			,BDID_Score                   // bdid_score
																			,dBDidOut                    // Output Dataset
																			,														// deafult threscold
																			,													 // use prod version of superfiles
																			,													// default is to hit prod from dataland, and on prod hit prod.
																			,BIPV2.xlink_version_set // Create BIP Keys only
																			,					           		// Url  ("Website" or "Webpage1" or "webpage2" or "webpage3" fields are available in the data but they didn't contain the valid url's)
																			,Email								 // Email
																			,p_city_name					// City
																			,fname							 // fname
																			,mname						  // mname
																			,lname						 // lname
																			);

	dBdidOut_dist			:= distribute	(dBdidOut(bdid 		!= 0 or
																						Ultid 	!= 0 or
																						OrgID 	!= 0 or
																						ProxID 	!= 0 or
																						SELEID 	!= 0 or
																						POWID 	!= 0 or
																						EmpID 	!= 0 or
																						DotID 	!= 0)	,unique_id);

	dBdidOut_sort			:= sort(dBdidOut_dist, unique_id, -bdid_score, -proxscore,-selescore,-orgscore,-ultscore,-powscore,-empscore,-dotscore, local);
	dBdidOut_dedup		:= dedup(dBdidOut_sort, unique_id	, local);

	dAddUniqueId_dist := distribute	(pDataset ,unique_id);

	Layouts.KeyBuild tAssignBdids(Layouts.KeyBuild  l, Layouts.BdidSlim r) :=transform
		self.bdid					:= if(r.bdid 				<> 0, r.bdid				, 0);
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

	dAssignBdids := join( dAddUniqueId_dist
												,dBdidOut_dedup
												,left.unique_id = right.unique_id
												,tAssignBdids(left, right)
												,left outer
												,local
												);

		return dAssignBdids;
	end;

	export fAll(dataset(Layouts.KeyBuild)	pDataset) :=	function

		dAppendDid    	:= 	fAppendDid	(pDataset);
		dAppendBdid    	:= 	fAppendBdid (dAppendDid);

		return dAppendBdid ;
	end;

end;
