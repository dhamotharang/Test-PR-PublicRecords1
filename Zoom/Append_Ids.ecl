import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,Business_HeaderV2;

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
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueId l, unsigned2 cnt) :=
		transform
			
			phone := map(cnt = 1 and l.clean_phones.Phone					!= '' => l.clean_phones.Phone
									,cnt = 2 and l.clean_phones.Company_Phone != '' => l.clean_phones.Company_Phone
									,cnt = 1 and l.clean_phones.Phone				   = '' => l.clean_phones.Company_Phone
									,l.clean_phones.Phone
							);
			
			
			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.name_suffix	:= l.clean_contact_name.name_suffix			;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.zip5				 	:= l.Clean_Company_address.zip					;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= phone																;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self							:= l																		;
		end;
		
		choosey(string pPhone, string pCompany_Phone) := 
			map(			pPhone					!= ''
						and pCompany_Phone	!= '' => 2, 1);
										
		dSlimForDiding	:= normalize(dAddUniqueId
																,choosey(left.clean_phones.Phone, left.clean_phones.Company_Phone)
																,tSlimForDiding(left,counter)
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
			,dDidOut_orig								// output dataset			
		);                          

		Business_HeaderV2.macFix_Contact_DIDs(
			 dDidOut_orig
			,did
			,lname
			,true
			,did_score
			,false
			,false
			,ssn_notexist
			,dDidOut
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
	// -- Appends BDIDs and new BIPV2 xlink ids
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

			phone := map(cnt = 1 and l.clean_phones.Phone					!= '' => l.clean_phones.Phone
									,cnt = 2 and l.clean_phones.Company_Phone != '' => l.clean_phones.Company_Phone
									,cnt = 1 and l.clean_phones.Phone				   = '' => l.clean_phones.Company_Phone
									,l.clean_phones.Phone
							);

			self.unique_id		:= l.unique_id													;
			self.company_name	:= l.rawfields.Company_Name							;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.p_city_name	:= l.Clean_Company_address.p_city_name	;
			self.zip5					:= l.Clean_Company_address.zip					;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= phone																;
			self.bdid					:= 0																		;
			self.bdid_score		:= 0																		;
			self.lname				:= l.clean_contact_name.lname						;
			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.email				:= l.rawfields.email_address						;
			self.company_url	:= l.rawfields.company_domain_name			;

		end;   

		choosey(string pPhone, string pCompany_Phone) := 
			map(			pPhone					!= ''
						and pCompany_Phone	!= '' => 2, 1);
										
		dSlimForBdiding :=  normalize(dAddUniqueId
																,choosey(left.clean_phones.Phone, left.clean_phones.Company_Phone)
																,tSlimForBdiding(left,counter)
																);

		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex_BIPAlpha(
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
			,													 						// use prod version of superfiles
			,															 				// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set 							// Create BIP Keys only
			,company_url 								 					// Url
			,email					            					// Email
			,p_city_name							 						// City
			,fname							      						// fname
			,mname									 							// mname
			,lname						 										// lname
		);                                         
                                        
		dBDidOut_dist			:= distribute	(dBDidOut(bdid 		!= 0 or 
																							DotID 	!= 0 or 
																							EmpID 	!= 0 or
																							POWID 	!= 0 or
																							ProxID 	!= 0 or
																							SeleId	!= 0 or
																							OrgID 	!= 0 or
																							UltID 	!= 0)	,unique_id);
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score, -ProxScore	,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);

			 
		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
			self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.DotID			:= if(r.DotID 			<> 0, r.DotID				, 0);
			self.DotScore		:= if(r.DotScore		<> 0, r.DotScore		, 0);
			self.DotWeight	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
			self.EmpID			:= if(r.EmpID 			<> 0, r.EmpID				, 0);
			self.EmpScore		:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
			self.EmpWeight	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
			self.POWID			:= if(r.POWID 			<> 0, r.POWID				, 0);
			self.POWScore		:= if(r.POWScore		<> 0, r.POWScore		, 0);
			self.POWWeight	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
			self.ProxID			:= if(r.ProxID 			<> 0, r.ProxID			, 0);
			self.ProxScore	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
			self.SELEID			:= if(r.SELEID 			<> 0, r.SELEID			, 0);
			self.SELEScore	:= if(r.SELEScore		<> 0, r.SELEScore		, 0);
			self.SELEWeight	:= if(r.SELEWeight	<> 0, r.SELEWeight	, 0);
			self.OrgID			:= if(r.OrgID 			<> 0, r.OrgID				, 0);
			self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
			self.UltID			:= if(r.UltID 			<> 0, r.UltID				, 0);
			self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
			self 						:= l;
		end;

		dAssignBdids := join( dAddUniqueId_dist
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
	
		dAppendDid		:= fAppendDid		(pDataset		) : persist(Persistnames.AppendIdsDid	);
		dAppendBdid		:= fAppendBdid	(dAppendDid	) : persist(Persistnames.AppendIdsBdid);
		                                                              
		return dAppendBdid;
	
	end;


end;
