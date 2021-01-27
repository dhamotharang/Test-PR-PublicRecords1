import DID_Add, Business_Header_SS;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendAffDid
	// -- Append DIDs to Affiliated individuals file
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendAffDid(dataset(Layouts.Base.Affiliated_Individuals) pDataset) :=
	function

		//Add unique id
		Layouts.Temporary.Affiliated_Individuals_uniqueid tAddUniqueId(Layouts.Base.Affiliated_Individuals l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self.did 					:= 0		;
			self.did_score		:= 0		;
			self							:= l		;

		end;

		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.Affiliated_Individuals_uniqueid l, unsigned2 cnt) :=
		transform

			lcnt := cnt - 1;

			phone := choose((lcnt % 5) + 1
				,l.rawfields.CONTACT_FAXS_FAX_NUMBER
				,l.rawfields.CONTACT_PHONES_PHONE_NUMBER
				,l.rawfields.HEADER_AFF_INDIV_INDIV_CELL_PHONE_NUMBER
				,l.rawfields.HEADER_AFF_INDIV_INDIV_FAX_FAX_NUMBER
				,l.rawfields.HEADER_AFF_INDIV_INDIV_PHONE_PHONE_NUMBER
			);

			mail_addr := l.Clean_contact_mailing_address	;
			loc_addr 	:= l.Clean_contact_location_address	;

			addrcnt := (unsigned8)(lcnt / 5) + 1;

			prim_range	:= choose(addrcnt	,mail_addr.prim_range	,loc_addr.prim_range);
			prim_name		:= choose(addrcnt	,mail_addr.prim_name	,loc_addr.prim_name	);
			sec_range		:= choose(addrcnt	,mail_addr.sec_range	,loc_addr.sec_range	);
			zip					:= choose(addrcnt	,mail_addr.zip				,loc_addr.zip				);
			st				 	:= choose(addrcnt	,mail_addr.st					,loc_addr.st				);

			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.name_suffix	:= l.clean_contact_name.name_suffix			;
			self.prim_range		:= prim_range														;
			self.prim_name		:= prim_name														;
			self.sec_range		:= sec_range														;
			self.zip5				 	:= zip																	;
			self.state				:= st																		;
			self.phone				:= phone																;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self.dob					:= ''																		;
			self							:= l																		;
		end;

		dSlimForDiding	:= normalize(dAddUniqueId
																,10
																,tSlimForDiding(left,counter)
																);
		dSlimForDiding_dedup := dedup(dSlimForDiding, hash64(unique_id,prim_range,prim_name,sec_range,zip5,state,phone),all);

		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A','P'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding_dedup				// Input Dataset
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


		Layouts.Base.Affiliated_Individuals tAssignDIDs(Layouts.Temporary.Affiliated_Individuals_uniqueid l, Layouts.Temporary.DidSlim r) :=
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
	// -- function: fAppendAffDid
	// -- Append DIDs to Affiliated individuals file
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendUnaffDid(dataset(Layouts.Base.Unaffiliated_Individuals) pDataset) :=
	function

		//Add unique id
		Layouts.Temporary.Unaffiliated_Individuals_uniqueid tAddUniqueId(Layouts.Base.Unaffiliated_Individuals l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self.did 					:= 0		;
			self.did_score		:= 0		;
			self							:= l		;

		end;

		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.Unaffiliated_Individuals_uniqueid l, unsigned2 cnt) :=
		transform

			mail_addr := l.Clean_contact_mailing_address	;
			loc_addr 	:= l.Clean_contact_location_address	;

			addrcnt := ((cnt - 1) % 2) + 1;

			prim_range	:= choose(addrcnt,mail_addr.prim_range,loc_addr.prim_range);
			prim_name		:= choose(addrcnt,mail_addr.prim_name	,loc_addr.prim_name	);
			sec_range		:= choose(addrcnt,mail_addr.sec_range	,loc_addr.sec_range	);
			zip					:= choose(addrcnt,mail_addr.zip				,loc_addr.zip				);
			st				 	:= choose(addrcnt,mail_addr.st				,loc_addr.st				);

			self.fname				:= l.clean_contact_name.fname						;
			self.mname				:= l.clean_contact_name.mname						;
			self.lname				:= l.clean_contact_name.lname						;
			self.name_suffix	:= l.clean_contact_name.name_suffix			;
			self.prim_range		:= prim_range														;
			self.prim_name		:= prim_name														;
			self.sec_range		:= sec_range														;
			self.zip5				 	:= zip																	;
			self.state				:= st																		;
			self.phone				:= ''																		;
			self.did					:= 0																		;
			self.did_score		:= 0																		;
			self.dob					:= ''																		;
			self							:= l																		;
		end;

		dSlimForDiding	:= normalize(dAddUniqueId
																,2
																,tSlimForDiding(left,counter)
																);
		dSlimForDiding_dedup := dedup(dSlimForDiding, hash64(unique_id,prim_range,prim_name,sec_range,zip5,state,phone),all);

		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding_dedup				// Input Dataset
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


		Layouts.Base.Unaffiliated_Individuals tAssignDIDs(Layouts.Temporary.Unaffiliated_Individuals_uniqueid l, Layouts.Temporary.DidSlim r) :=
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
	export fAppendBdid(dataset(Layouts.Base.Organizations) pDataset) :=
	function

		Layouts.Temporary.Organizations_uniqueid tAddUniqueId(Layouts.Base.Organizations l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;

		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.Organizations_uniqueid l, unsigned2 cnt) :=
		transform

			lcnt := cnt - 1;

			phone := choose((lcnt % 4) + 1
				,l.rawfields.CONTACT_FAXS_FAX_NUMBER
				,l.rawfields.CONTACT_PHONES_PHONE_NUMBER
				,l.rawfields.CONTACT_PHONES_PHONE_NUMBER
				,l.rawfields.CONTACT_FAXS_FAX_NUMBER
			);

			mail_addr 	:= l.Clean_mailing_address					;
			loc_addr 		:= l.Clean_location_address					;
			cmail_addr 	:= l.Clean_contact_mailing_address	;
			cloc_addr 	:= l.Clean_contact_location_address	;

			addrcnt := (unsigned8)(lcnt / 4) + 1;

			prim_range	:= choose(addrcnt	,mail_addr.prim_range	,loc_addr.prim_range,cmail_addr.prim_range,cloc_addr.prim_range	);
			prim_name		:= choose(addrcnt	,mail_addr.prim_name	,loc_addr.prim_name	,cmail_addr.prim_name	,cloc_addr.prim_name	);
			sec_range		:= choose(addrcnt	,mail_addr.sec_range	,loc_addr.sec_range	,cmail_addr.sec_range	,cloc_addr.sec_range	);
			zip					:= choose(addrcnt	,mail_addr.zip				,loc_addr.zip				,cmail_addr.zip				,cloc_addr.zip				);
			city			 	:= choose(addrcnt	,mail_addr.p_city_name,loc_addr.p_city_name,cmail_addr.p_city_name		,cloc_addr.p_city_name			);
			st				 	:= choose(addrcnt	,mail_addr.st					,loc_addr.st				,cmail_addr.st				,cloc_addr.st					);

			self.unique_id		:= l.unique_id																;
			self.company_name	:= l.rawfields.NAME_ORG_NAME									;
			self.prim_range		:= prim_range																	;
			self.prim_name		:= prim_name																	;
			self.zip5					:= zip																				;
			self.sec_range		:= sec_range																	;
			self.city					:= city																				;
			self.state				:= st																					;
			self.phone				:= phone																			;
			self.bdid					:= 0																					;
			self.bdid_score		:= 0																					;
			self.email 				:= l.rawfields.contact_emails_email_addr			;
			self.URL					:= l.rawfields.contact_urls_url_addr					;
			self.Contact_fname := l.clean_name.fname												;
			self.Contact_mname := l.clean_name.mname												;
			self.Contact_lname := l.clean_name.lname												;

		end;

		dSlimForBdiding :=  normalize(dAddUniqueId
																,16
																,tSlimForBdiding(left,counter)
																);
		dSlimForBdiding_dedup := dedup(dSlimForBdiding, hash64(unique_id,prim_range,prim_name,sec_range,zip5,state,phone),all);

		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimForBdiding_dedup								// Input Dataset
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
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.
			,BIPV2.xlink_version_set							// Create BID Keys only
			,URL																  // Url
			,email 			    											// Email
			,city       													// City
			,Contact_fname 												// fname
			,Contact_mname												// mname
			,Contact_lname 						);					// lname


	  dBDidOut_dist			:= distribute	(dBDidOut(bdid!=0 or dotid!=0 or empid!=0 or powid!=0 or proxid!=0 or seleid!=0 or orgid!=0 or ultid!=0) ,unique_id										);
		dBDidOut_sort			:= sort				(dBDidOut_dist	,unique_id, -bdid_score -dotscore	-empscore -powscore -proxscore -selescore -orgscore -ultscore,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort	,unique_id	,local);

		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id										);


		Layouts.Base.Organizations tAssignBdids(Layouts.Temporary.Organizations_uniqueid l, Layouts.Temporary.BdidSlim r) :=
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

end;
