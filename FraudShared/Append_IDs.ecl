import DID_Add, Business_Header_SS;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(Layouts.base.main) pDataset) :=
	function

		//Add unique id
		Layouts.Temp.UniqueId tAddUniqueId(Layouts.base.main l, unsigned8 cnt) :=
		transform
 		  self.unique_id	:= cnt;
			self            := L;

		end;

		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temp.DidSlim tSlimForDiding(Layouts.Temp.UniqueId l, unsigned2 cnt) :=
		transform
			self.fname				:= l.cleaned_name.fname		    	;
			self.mname				:= l.cleaned_name.mname	 	    	;
			self.lname				:= l.cleaned_name.lname					;
			self.name_suffix	:= l.cleaned_name.name_suffix		;
			self.prim_range		:= l.clean_address.prim_range		;
			self.prim_name		:= l.clean_address.prim_name			;
			self.sec_range		:= l.clean_address.sec_range			;
			self.zip5		 			:= l.clean_address.zip						;
			self.state		    := l.clean_address.st						;
			self.phone				:= choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
			self.ssn					:= l.ssn											;
			self.dob					:= l.dob											;
			self.did					:= 0  												;
			self.did_score		:= 0  												;
			self		 	    		:= l  												;
		end;

		dSlimForDiding	:= normalize(dAddUniqueId
																,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone != '',2,1)
																,tSlimForDiding(left,counter)
																);

		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['D','S','P','A'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding										// Input Dataset
			,Did_Matchset     					      // Did_Matchset  what fields to match on
			,ssn              					  	  // ssn
			,dob              					   		// dob
			,fname														// fname
			,mname			     									// mname
			,lname			     									// lname
			,name_suffix     									// name_suffix
			,prim_range	    					        // prim_range
			,prim_name	      						   	// prim_name
			,sec_range	    					      	// sec_range
			,zip5				        							// zip5
			,state			         						 	// state
			,phone			          						// phone10
			,did                      				// Did
			,FraudShared.Layouts.Temp.DidSlim  // output layout
			,TRUE                     				// Does output record have the score
			,did_score               				 	// did score field
			,75                     			  	// score threshold
			,dDidOut													// output dataset
		);


		dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id );
		dDidOut_sort			:= sort				(dDidOut_dist		,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort		,unique_id ,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId		,unique_id	);


		Layouts.Base.main tAssignDIDs(Layouts.Temp.UniqueId l, Layouts.Temp.DidSlim r) :=
		transform

			self.did				:= if(r.did <> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;

		dAssignDids := join( dAddUniqueId_dist
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
	export fAppendBdid(dataset(Layouts.Base.main) pDataset) :=
	function

		Layouts.Temp.UniqueId tAddUniqueId(Layouts.Base.main l, unsigned8 cnt) :=
		transform
			self.unique_id		:= cnt	;
			self							:= l		;
		end;

		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temp.BdidSlim tSlimForBdiding(Layouts.Temp.UniqueId l, unsigned2 cnt) :=
  	transform

			self.unique_id			:= l.unique_id	;
			self.business_name	:= l.business_name	;
			self.prim_range			:= l.clean_address.prim_range	;
			self.prim_name			:= l.clean_address.prim_name	;
			self.zip5						:= l.clean_address.zip			  ;
			self.sec_range			:= l.clean_address.sec_range	;
			self.p_city_name		:= l.clean_address.p_city_name;
			self.state					:= l.clean_address.st					;
			self.phone				  := choose(cnt,l.clean_phones.phone_number,l.clean_phones.cell_phone);
			self.fein					  := l.fein			                ;
			self.bdid						:= 0						              ;
			self.bdid_score			:= 0						              ;
			self								:= []						              ;
		end;


		dSlimForBdiding	:= normalize(dAddUniqueId
																,if(left.clean_phones.phone_number <>'' and left.clean_phones.cell_phone != '',2,1)
																,tSlimForBdiding(left,counter)
																);

		//*** Match set for BDIDing
		BDID_Matchset := ['A','F','P'];

		//**** External id macro that appends BDID's and BIPV2 xlinkids
		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimForBdiding											// Input Dataset
			,BDID_Matchset                        // BDID Matchset what fields to match on
			,business_name     		             		// company_name
			,prim_range		                        // prim_range
			,prim_name		                        // prim_name
			,zip5 					                      // zip5
			,sec_range		                        // sec_range
			,state				                        // state
			,phone				                        // phone
			,Fein               				          // fein
			,bdid													        // bdid
			,Layouts.Temp.BdidSlim	              // Output Layout
			,true                                 // output layout has bdid score field?
			,bdid_score                           // bdid_score
			,dBdidOut                             // Output Dataset
			,																			// deafult threscold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.
			,BIPV2.xlink_version_set							// Create BID Keys only
			,																			// Url
			,																			// Email
			,p_City_name													// City
		);

		dBdidOut_dist			:= distribute	(dBdidOut(bdid 		!= 0 or
																							Ultid 	!= 0 or
																							OrgID 	!= 0 or
																							ProxID 	!= 0 or
																							SeleID 	!= 0 or
																							POWID 	!= 0 or
																							EmpID 	!= 0 or
																							DotID 	!= 0)	,unique_id										);
		dBdidOut_sort			:= sort				(dBdidOut_dist				,unique_id, -bdid_score, -ProxScore, local);
		dBdidOut_dedup		:= dedup			(dBdidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);


		Layouts.Base.main tAssignBdids(Layouts.Temp.UniqueId l, Layouts.Temp.BdidSlim r) :=
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
			dataset(Layouts.base.main	)			pDataset
	) :=
	function

		dAppendDid		:= fAppendDid	(pDataset	): persist(Persistnames.AppendDIds);

		dAppendBdid		:= fAppendBdid(dAppendDid (trim(Business_Name,left,right) <> '')	): persist(Persistnames.AppendIds);

		return  dAppendDid (trim(Business_Name,left,right) = ''	) + dAppendBdid;

	end;


end;
