import Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,Business_HeaderV2, MDR;

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

			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.name_suffix	:= l.clean_contact_name.name_suffix			;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.zip5				 	:= l.Clean_Company_address.zip					;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= l.clean_phones.Company_Phone_Number	;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self							:= l																		;
		end;   
		
		dSlimForDiding := project(dAddUniqueId, tSlimForDiding(left));
		
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

		Business_HeaderV2.macFix_Contact_DIDs(
			 dDidOut
			,did
			,lname
			,true
			,did_score
			,false
			,true
			,ssn
			,dDidOut_patched
		);

		dDidOut_dist			:= distribute(dDidOut_patched		, hash(unique_id));
		dAddUniqueId_dist := distribute(dAddUniqueId			, hash(unique_id));

			 
		Layouts.Base tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
		transform

			self.did				:= if(r.did 			<> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;

		dAssignDids := join(
											 dAddUniqueId_dist
											,dDidOut_dist
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
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.UniqueId l) :=
		transform

			self.unique_id		:= l.unique_id													;
			self.company_name	:= l.rawfields.Company_Name							;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.zip5					:= l.Clean_Company_address.zip					;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= l.clean_phones.Company_Phone_Number	;
			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.p_city_name	:= l.clean_company_address.p_city_name	;			
			self.bdid					:= 0																		;	// Initializing the BDIDs to zero, so they get refreshed below MAC_Add_BDID_Flex call.
			self.bdid_score		:= 0																		;
			self							:= []																		;	// Jira# DF-27417, All the BdidSlim layout fields are mapped above except BIP fields 
																																	// that are getting initialized to zero with this statement, so they get refreshed below MAC_Add_BDID_Flex call.
																				
		end;   
		
		dSlimForBdiding := project(dAddUniqueId, tSlimForBdiding(left));

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
			,																			// deafult threscold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,bipv2.xlink_version_set							// boolean indicator set to create bdid's & xlinkids
			,																			// url
			,																			// email 
			,p_city_name													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname				
		);                                         
                                        
		dBdidOut_dist			:= distribute(dBdidOut		, hash(unique_id));
		dAddUniqueId_dist := distribute(dAddUniqueId, hash(unique_id));

			 
		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
			self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.DotID			:= if(r.DotID				<> 0, r.DotID				, l.DotID);
			self.DotScore		:= if(r.DotScore		<> 0, r.DotScore		, l.DotScore);
			self.DotWeight	:= if(r.DotWeight		<> 0, r.DotWeight		, l.DotWeight);
			self.EmpID			:= if(r.EmpID				<> 0, r.EmpID				, l.EmpID);
			self.EmpScore		:= if(r.EmpScore		<> 0, r.EmpScore		, l.EmpScore);
			self.EmpWeight	:= if(r.EmpWeight		<> 0, r.EmpWeight		, l.EmpWeight);
			self.POWID			:= if(r.POWID				<> 0, r.POWID				, l.POWID);
			self.POWScore		:= if(r.POWScore		<> 0, r.POWScore		, l.POWScore);
			self.POWWeight	:= if(r.POWWeight		<> 0, r.POWWeight		, l.POWWeight);
			self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, l.ProxID);
			self.ProxScore	:= if(r.ProxScore		<> 0, r.ProxScore		, l.ProxScore);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, l.ProxWeight);
			self.SELEID			:= if(r.SELEID			<> 0, r.SELEID			, l.SELEID);
			self.SELEScore	:= if(r.SELEScore		<> 0, r.SELEScore		, l.SELEScore);
			self.SELEWeight	:= if(r.SELEWeight	<> 0, r.SELEWeight	, l.SELEWeight);	
			self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, l.OrgID);
			self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, l.OrgScore);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, l.OrgWeight);
			self.UltID			:= if(r.UltID				<> 0, r.UltID				, l.UltID);
			self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, l.UltScore);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, l.UltWeight);				
			self 						:= l;

		end;

		dAssignBdids := join(
											 dAddUniqueId_dist
											,dBdidOut_dist
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
	
		dAppendDid		:= fAppendDid		(pDataset		) : persist(Persistnames().AppendIdsDid	);
		dAppendBdid		:= fAppendBdid	(dAppendDid	) : persist(Persistnames().AppendIdsBdid);
	                                                              
		return dAppendBdid;
	
	end;


end;
