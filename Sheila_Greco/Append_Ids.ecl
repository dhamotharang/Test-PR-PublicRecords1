import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,bipv2, mdr;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendDid
	// -- Appends Dids
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(Layouts.Base.Contacts) pDataset) :=
	function
		
		//Add unique id
		Layouts.Temporary.Contacts.UniqueId tAddUniqueId(Layouts.Base.Contacts l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.Contacts.DidSlim tSlimForDiding(Layouts.Temporary.Contacts.UniqueId l, unsigned2 cnt) :=
		transform

			cnt1 := map(	 l.clean_phones.OfficePhone != '' =>	l.clean_phones.OfficePhone
										,l.clean_phones.DirectDial	!= '' =>	l.clean_phones.DirectDial
										,																			l.clean_phones.MobilePhone
							);
							
			cnt2 := map(	 l.clean_phones.DirectDial	!= '' =>	l.clean_phones.DirectDial
										,																			l.clean_phones.MobilePhone
							);

			phone := choose(cnt	,cnt1
													,cnt2
													,l.clean_phones.MobilePhone
							);
			
			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.name_suffix	:= l.clean_contact_name.name_suffix			;
			self.prim_range		:= l.Clean_Contact_address.prim_range		;
			self.prim_name		:= l.Clean_Contact_address.prim_name		;
			self.sec_range		:= l.Clean_Contact_address.sec_range		;
			self.zip5				 	:= l.Clean_Contact_address.zip					;
			self.state				:= l.Clean_Contact_address.st						;
			self.phone				:= phone																;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self							:= l																		;
		end;
		
		choosey(
			 string pOfficePhone
			,string pDirectDial	
			,string pMobilePhone
		) :=       
		function
		
			OfficePhone_cnt := if(pOfficePhone != '', 1, 0);
			DirectDial_cnt	:= if(pDirectDial	 != '', 1, 0);
			MobilePhone_cnt := if(pMobilePhone != '', 1, 0);

			total := OfficePhone_cnt + DirectDial_cnt + MobilePhone_cnt;
			
			return if(total = 0, 1, total);
			
		end;
		
		dSlimForDiding	:= normalize(dAddUniqueId
																,choosey(left.clean_phones.OfficePhone, left.clean_phones.DirectDial, left.clean_phones.MobilePhone)
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
			,Layouts.Temporary.Contacts.DidSlim  // output layout
			,TRUE                     	// Does output record have the score
			,did_score                	// did score field
			,75                       	// score threshold
			,dDidOut								  	// output dataset			
		);                          


		dDidOut_dist			:= distribute	(dDidOut(did != 0)	,unique_id										);
		dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id							,local);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id										);

			 
		Layouts.Base.Contacts tAssignDIDs(Layouts.Temporary.Contacts.UniqueId l, Layouts.Temporary.Contacts.DidSlim r) :=
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
	// -- Appends Bdids
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(dataset(Layouts.Base.Companies) pCompanies, 
										 dataset(Layouts.temporary.Slim_Contacts)  pContacts) :=
	function
		
		pCompanies_dist := sort(distribute(pCompanies,hash(rawfields.MainCompanyID)),rawfields.MainCompanyID, local);
		pContacts_dist := sort(distribute(pContacts,hash(MainCompanyID)),record, local); 
		pContacts_sort := dedup(pContacts_dist, whole record, local );		
		
		Layouts.Temporary.Companies.UniqueId tAddUniqueId(Layouts.Base.Companies l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pCompanies_dist, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.Companies.BDidSlim tSlimForBdiding(Layouts.Temporary.Companies.UniqueId l) :=
		transform

			self.unique_id		:= l.unique_id									;
			self.MainCompanyID := l.rawfields.MainCompanyID   ;
			self.url          := l.rawfields.WebURL           ;
			self.source_rec_id:= l.source_rec_id              ;
			self.source       := MDR.sourceTools.src_Sheila_Greco;
			self.company_name	:= l.rawfields.CompanyName			;
			self.prim_range		:= l.Clean_address.prim_range		;
			self.prim_name		:= l.Clean_address.prim_name		;
			self.zip5					:= l.Clean_address.zip					;
			self.sec_range		:= l.Clean_address.sec_range		;
			self.city         := l.Clean_address.p_city_name  ;
			self.state				:= l.Clean_address.st						;
			self.phone				:= l.clean_phones.phone					;
			self.bdid					:= 0														;
			self.bdid_score		:= 0														;
		end;   

		dSlimForBdiding :=  project(dAddUniqueId,tSlimForBdiding(left));

		//Join Companies and Contacts file to get the first,middle,last names and email
		Layouts.Temporary.Companies.BDidSlim JoinRecs(Layouts.Temporary.Companies.BDidSlim L, Layouts.temporary.Slim_Contacts R) := transform
					self.firstname:=r.fname;
					self.middinit	:=r.mname;
					self.lastname	:=r.lname;
					self.email		:=r.email;
					self :=	l;
		 end;
		dJoinCompAndCont:= join( dSlimForBdiding, pContacts_sort
															,left.MainCompanyID=right.MainCompanyID 
															,JoinRecs(left,right) ,left outer, local );

		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex(
			 dJoinCompAndCont											// Input Dataset						
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
			,Layouts.Temporary.Companies.BDidSlim // Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset     
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// Create BID Keys only
			,url																  // Url
			,email 			    											// Email
			,city       													// City
			,firstname 														// fname
			,middinit 														// mname
			,lastname 														// lname
			,                                     // contact ssn
			,source                               // source 
			,source_rec_id                        // source_rec_id
			,                      );             // src_matching_is_priority default FALSE 


		dBDidOut_dist			:= distribute	(dBDidOut(bdid!=0 or dotid!=0 or empid!=0 or powid!=0 or proxid!=0 or seleid!=0 or orgid!=0 or ultid!=0) ,unique_id										);
		dBDidOut_sort			:= sort				(dBDidOut_dist	,unique_id, -bdid_score -dotscore	-empscore -powscore -proxscore -selescore -orgscore -ultscore,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort	,unique_id	,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId		,unique_id										);

			 
		Layouts.Base.Companies tAssignBdids(Layouts.Temporary.Companies.UniqueId l, Layouts.Temporary.Companies.BDidSlim r) :=
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
	
/*	
	export fAll(
		dataset(Layouts.Base	)	pDataset
	) :=
	function
	
		dAppendDid		:= fAppendDid		(pDataset		) : persist(Persistnames.AppendIdsDid	);
		dAppendBdid		:= fAppendBdid	(dAppendDid	) : persist(Persistnames.AppendIdsBdid);
		                                                              
		return dAppendBdid;
	
	end;
*/

end;