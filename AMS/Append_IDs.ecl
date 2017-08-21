import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,Business_HeaderV2,Watchdog,Health_Provider_Services;

export Append_IDs :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(Layouts.Base.Main) pDataset) :=
	function
		
		//Add unique id
		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base.Main l, unsigned8 cnt) :=
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
			
			phone := map(cnt = 1 and l.clean_phones.Phone	!= '' => l.clean_phones.Phone
									,cnt = 2 and l.clean_phones.Fax		!= '' => l.clean_phones.Fax
									,cnt = 1 and l.clean_phones.Phone	 = '' => l.clean_phones.Fax
									,l.clean_phones.Phone
							);
			
			
			self.fname				:= l.clean_name.fname						;
			self.mname				:= l.clean_name.mname						;
			self.lname				:= l.clean_name.lname						;
			self.name_suffix	:= l.clean_name.name_suffix			;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.zip5				 	:= l.Clean_Company_address.zip					;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= phone																;
			self.dob					:= (unsigned)l.rawdemographicsfields.DOB_DATE;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self							:= l																		;
		end;
		
		choosey(string pPhone, string pFax) := 
			map(			pPhone	!= ''
						and pFax		!= '' => 2, 1);
										
		dSlimForDiding	:= normalize(dAddUniqueId
																,choosey(left.clean_phones.Phone, left.clean_phones.Fax)
																,tSlimForDiding(left,counter)
																);
		
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A','P','D'];

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
		
		Layouts.Temporary.DidSlim tAssignDidWatchdog(Layouts.Temporary.DidSlim l, RECORDOF(Watchdog.File_Best) r)	:=
		TRANSFORM
			SELF.did				:= IF(l.dob > 0 AND r.dob > 0 AND l.dob DIV 10000 <> r.dob DIV 10000, 0, l.did);
			SELF.did_score	:= IF(self.did=0, 0, l.did_score);
			SELF						:= l;
		END;
		
		dDidWatchdogOut		:= JOIN(DISTRIBUTE(dDidOut_dedup,HASH(did)), Watchdog.File_Best(did != 0),
															LEFT.did = RIGHT.did,
															tAssignDidWatchdog(LEFT,RIGHT),
															LEFT OUTER, LOCAL);
		dDidWatchdogOut_dist	:= DISTRIBUTE	(dDidWatchdogOut(did != 0)	,unique_id										);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id										);
		
		Layouts.Base.Main tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
		transform
			self.did				:= if(r.did 			<> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;

		dAssignDids := join(
											 dAddUniqueId_dist
											,dDidWatchdogOut_dist
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
	export fAppendBdid(dataset(Layouts.Base.Main) pDataset) :=
	function

		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base.Main l, unsigned8 cnt) :=
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

			phone := map(cnt = 1 and l.clean_phones.Phone	!= '' => l.clean_phones.Phone
									,cnt = 2 and l.clean_phones.Fax		!= '' => l.clean_phones.Fax
									,cnt = 1 and l.clean_phones.Phone	 = '' => l.clean_phones.Fax
									,l.clean_phones.Phone
							);

			self.unique_id		:= l.unique_id													;
			self.company_name	:= l.rawdemographicsfields.ACCT_NAME		;
			self.prim_range		:= l.Clean_Company_address.prim_range		;
			self.prim_name		:= l.Clean_Company_address.prim_name		;
			self.zip5					:= l.Clean_Company_address.zip					;
			self.sec_range		:= l.Clean_Company_address.sec_range		;
			self.state				:= l.Clean_Company_address.st						;
			self.phone				:= phone									;
			self.fein					:= l.rawdemographicsfields.TAX_ID				;
			self.bdid					:= 0																		;
			self.bdid_score		:= 0																		;
			self.source_rec_id:= l.source_rec_id                      ;
			self.source				:= mdr.sourceTools.src_AMS							;
			self.city					:= l.Clean_Company_address.p_city_name	;
			self.email 				:= l.rawaddressfields.email		        	;
			self.URL					:= l.rawaddressfields.url   			    	;
			self.fname				:= l.clean_name.fname										;
			self.mname				:= l.clean_name.mname										;
			self.lname				:= l.clean_name.lname										;

		end;   

		choosey(string pPhone, string pFax) := 
			map(			pPhone	!= ''
						and pFax		!= '' => 2, 1);
										
		dSlimForBdiding :=  normalize(dAddUniqueId
																,choosey(left.clean_phones.Phone, left.clean_phones.Fax)
																,tSlimForBdiding(left,counter)
																);

		BDID_Matchset := ['A','P','F'];

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
			,fein					                        // fein              
			,bdid													        // bdid												
			,Layouts.Temporary.BdidSlim           // Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset   
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// Create BID Keys only
			,URL																	// Url
			,email 			    											// Email
			,city       													// City
			,fname				 												// fname
			,mname  															// mname
			,lname																// lname
			,                                 		// contact ssn
			,source 		                          // source 
			,source_rec_id 						            // source_rec_id
			,                      );         		// src_matching_is_priority default FALSE 
		                                          
   		
	  dBDidOut_dist		:= distribute	(dBDidOut(bdid!=0 or dotid!=0 or empid!=0 or powid!=0 or proxid!=0 or seleid!=0 or orgid!=0 or ultid!=0) ,unique_id	 );
		dBDidOut_sort		:= sort				(dBDidOut_dist	,unique_id, -bdid_score -dotscore	-empscore -powscore -proxscore -selescore -orgscore -ultscore,local);
		dBDidOut_dedup	:= dedup			(dBDidOut_sort	,unique_id	,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);

			 
		Layouts.Base.Main tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid				:= if(r.bdid 				<> 0, r.bdid				, 0);
			self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.DotID		 	:= if(r.DotID				<> 0, r.DotID				, 0);
			self.DotScore	 	:= if(r.DotScore		<> 0, r.DotScore		, 0);
			self.DotWeight 	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
			self.EmpID		 	:= if(r.EmpID				<> 0, r.EmpID				, 0);
			self.EmpScore	 	:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
			self.EmpWeight 	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
			self.POWID		 	:= if(r.POWID				<> 0, r.POWID				, 0);
			self.POWScore	 	:= if(r.POWScore		<> 0, r.POWScore		, 0);
			self.POWWeight 	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
			self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
			self.ProxScore 	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
			self.SeleID		 	:= if(r.SeleID			<> 0, r.SeleID			, 0);
			self.SeleScore 	:= if(r.SeleScore		<> 0, r.SeleScore		, 0);
			self.SeleWeight	:= if(r.SeleWeight	<> 0, r.SeleWeight	, 0);
			self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
			self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
			self.UltID			:= if(r.UltID				<> 0, r.UltID				, 0);
			self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);
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
	
  export fAppendlnpid(dataset(Layouts.Base.Main) pDataset) :=
	function
		
		Health_Provider_Services.mac_get_best_lnpid_on_thor (
      			pDataset
      			,LNPID
      			,clean_name.FNAME
      			,clean_name.MNAME
      			,clean_name.LNAME
      			,clean_name.name_suffix
      			,//GENDER
      			,clean_company_address.PRIM_Range
      			,clean_company_address.PRIM_Name
      			,clean_company_address.SEC_RANGE
      			,clean_company_address.p_city_name
      			,clean_company_address.ST
      			,clean_company_address.ZIP
      			,//clean_SSN
      			,rawdemographicsfields.dob_date
      			,clean_phones.Phone
      			,//LIC_STATE
      			,//LIC_Num_in
      			,rawdemographicsfields.TAX_ID
			      ,rawaddressfields.DEA_NUM
            ,AMS_ID
      			,//NPI_NUM
      			,//UPIN
      			,DID
      			,BDID
      			,//SRC
      			,//SOURCE_RID
      			,dAssignlnpid,false,38
      			);
		
		return dAssignlnpid;
	end;
	
	export fAll(
		dataset(Layouts.Base.Main	)	pDataset
	) :=
	function
	
		dAppendDid		:= fAppendDid	  (pDataset		) : persist(Persistnames.AppendIdsDid	);
		dAppendBdid		:= fAppendBdid	(dAppendDid	) : persist(Persistnames.AppendIdsBdid);
		dAssignlnpid	:= fAppendLnpid	(dAppendBdid) ;
				
		return dAssignlnpid;
	
	end;


end;
