import Address, BIPV2, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(busreg.Layout_BusReg_Contact) pDataset) :=
	function
		
		//Add unique id
		Layouts.Temporary.UniqueIdcontacts tAddUniqueId(busreg.Layout_BusReg_Contact l, unsigned8 cnt) :=
		transform

			self.unique_id		:= cnt	;
			self							:= l		;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueIdcontacts l) :=
		transform
			
			self.fname				:= l.name_first		;
			self.mname				:= l.name_middle	;
			self.lname				:= l.name_last		;
			self.name_suffix	:= l.name_suffix	;
			self.prim_range		:= l.prim_range		;
			self.prim_name		:= l.prim_name		;
			self.sec_range		:= l.sec_range		;
			self.zip5				 	:= l.zip					;
			self.state				:= l.st						;
			self.phone				:= l.phone				;
			self.did					:= 0							;
			self.did_score		:= 0							;
			self							:= l							;
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

			 
		Layout_BusReg_Contact tAssignDIDs(Layouts.Temporary.UniqueIdcontacts l, Layouts.Temporary.DidSlim r) :=
		transform

			self.did				:= if(r.did 			<> 0, r.did				, 0);
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
	export fAppendBdid(dataset(busReg.Layouts.Temporary.StandardizeInput) pDataset) :=
	function

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Normalize record on company address and map both into the Clean_mailing_address fields
		//////////////////////////////////////////////////////////////////////////////////////
		busReg.Layouts.Temporary.StandardizeInput tNormAddr(busReg.Layouts.Temporary.StandardizeInput l, unsigned2 cnt) :=
		transform

			self.Clean_mailing_address.prim_range		:= choose(cnt,l.Clean_mailing_address.prim_range,l.Clean_location_address.prim_range	);
			self.Clean_mailing_address.prim_name		:= choose(cnt,l.Clean_mailing_address.prim_name	,l.Clean_location_address.prim_name		);
			self.Clean_mailing_address.zip					:= choose(cnt,l.Clean_mailing_address.zip				,l.Clean_location_address.zip					);
			self.Clean_mailing_address.sec_range		:= choose(cnt,l.Clean_mailing_address.sec_range	,l.Clean_location_address.sec_range		);
			self.Clean_mailing_address.p_city_name	:= choose(cnt,l.Clean_mailing_address.p_city_name,l.Clean_location_address.p_city_name);
			self.Clean_mailing_address.st						:= choose(cnt,l.Clean_mailing_address.st				,l.Clean_location_address.st					);
			self																		:= l;
		end;   
		
		dNormAddr					  :=  normalize(pDataset
																,if((trim(left.Clean_mailing_address.prim_range)  = trim(left.Clean_location_address.prim_range) 	and
                                     trim(left.Clean_mailing_address.prim_name)   = trim(left.Clean_location_address.prim_name) 	and
                                     trim(left.Clean_mailing_address.p_city_name) = trim(left.Clean_location_address.p_city_name) and
                                     trim(left.Clean_mailing_address.st)          = trim(left.Clean_location_address.st) 					and
										                 trim(left.Clean_mailing_address.zip)         = trim(left.Clean_location_address.zip)) 				or
										                (trim(left.Clean_location_address.p_city_name) + trim(left.Clean_location_address.st) + trim(left.Clean_location_address.zip) = '')
                                    ,1,2)
																,tNormAddr(left,counter)
																);
																
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Normalize record on contact name and map all into the clean_officer1_name fields
		//////////////////////////////////////////////////////////////////////////////////////
		busReg.Layouts.Temporary.StandardizeInput tNormName(busReg.Layouts.Temporary.StandardizeInput l, unsigned2 cnt) :=
		transform, skip(	 (cnt = 2 and trim(l.clean_officer2_name.lname) = '') or
											 (cnt = 3 and trim(l.clean_officer3_name.lname) = '') or
											 (cnt = 4 and trim(l.clean_officer4_name.lname) = '') or
											 (cnt = 5 and trim(l.clean_officer5_name.lname) = '') or
											 (cnt = 6 and trim(l.clean_officer6_name.lname) = ''))
			self.clean_officer1_name.fname				:= choose(cnt,l.clean_officer1_name.fname,l.clean_officer2_name.fname,l.clean_officer3_name.fname,l.clean_officer4_name.fname,l.clean_officer5_name.fname,l.clean_officer6_name.fname);
			self.clean_officer1_name.mname				:= choose(cnt,l.clean_officer1_name.mname,l.clean_officer2_name.mname,l.clean_officer3_name.mname,l.clean_officer4_name.mname,l.clean_officer5_name.mname,l.clean_officer6_name.mname);
			self.clean_officer1_name.lname				:= choose(cnt,l.clean_officer1_name.lname,l.clean_officer2_name.lname,l.clean_officer3_name.lname,l.clean_officer4_name.lname,l.clean_officer5_name.lname,l.clean_officer6_name.lname);
			self																	:= l																		;
		end;   
	
		dNormName					 :=  normalize(dNormAddr
																,6
																,tNormName(left,counter)
																);
																
		dNormNameDedup		 := dedup(sort(distribute(dNormName,unique_id),record,local),record,local);

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Take normalized input and slim down mapping to Layouts.Temporary.BdidSlim layout
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(busReg.Layouts.Temporary.StandardizeInput L) := TRANSFORM
			self.unique_id												:= l.unique_id													;
			self.company_name											:= l.rawfields.company									;
			self.prim_range												:= l.Clean_mailing_address.prim_range	 	;
			self.prim_name												:= l.Clean_mailing_address.prim_name		;
			self.zip5															:= l.Clean_mailing_address.zip					;
			self.sec_range												:= l.Clean_mailing_address.sec_range		;
			self.p_city_name											:= l.Clean_mailing_address.p_city_name	;
			self.state														:= l.Clean_mailing_address.st						;
			self.phone														:= l.Clean_phones.biz_phone							;                   
			self.bdid															:= 0																		;
			self.bdid_score												:= 0																		;
			self.fname 														:= l.clean_officer1_name.fname					;	
			self.mname 														:= l.clean_officer1_name.mname					;
			self.lname														:= l.clean_officer1_name.lname					;
			self.source														:= mdr.sourceTools.src_Business_Registration;
			self.source_rec_id										:= l.source_rec_id											;
			self																	:= l																		;		
		end;  

		dSlimForBdiding := project(dNormNameDedup, tSlimForBdiding(LEFT));
																
		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_FLEX(
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
			,BIPV2.xlink_version_set							// BIP2 ids
			,																			// URL
			,														          // email
			,p_city_name													// city
			,fname																// contact's first name
			,mname																// contact's middle name
			,lname																// contact's last name
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,false	 															// does MAC_Source_Match exist before Flex macro			
		);                                         
                                 
		dBDidOut_dist			:= distribute	(dBdidOut(bdid 		!= 0 or 
																							Ultid 	!= 0 or 
																							OrgID 	!= 0 or 
																							ProxID 	!= 0 or 
																							SeleID 	!= 0 or 																							
																							POWID 	!= 0 or 
																							EmpID 	!= 0 or 
																							DotID 	!= 0)	,unique_id										);				
		
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	, -proxscore, local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);

		dAddUniqueId_dist := distribute	(pDataset							,unique_id										);


		Layouts.Base.AID tAssignBdids(busReg.Layouts.Temporary.StandardizeInput l, Layouts.Temporary.BdidSlim r) :=
		transform

			self.bdid				:= r.bdid;
			self.bdid_score	:= r.bdid_score;
			self.Ultid			:= r.Ultid;
			self.Ultscore		:= r.Ultscore;
			self.UltWeight	:= r.UltWeight;			
			self.OrgID			:= r.OrgID;
			self.Orgscore		:= r.Orgscore;
			self.OrgWeight	:= r.OrgWeight;			
			self.ProxID			:= r.ProxID;
			self.Proxscore	:= r.Proxscore;
			self.ProxWeight	:= r.ProxWeight;			
			self.SELEID			:= r.SELEID;
			self.SELEscore	:= r.SELEscore;
			self.SELEWeight	:= r.SELEWeight;			
			self.POWID			:= r.POWID;
			self.POWscore		:= r.POWscore;
			self.POWWeight	:= r.POWWeight;			
			self.EmpID			:= r.EmpID;
			self.Empscore		:= r.Empscore;
			self.EmpWeight	:= r.EmpWeight;			
			self.DotID			:= r.DotID;
			self.Dotscore		:= r.Dotscore;
			self.DotWeight	:= r.DotWeight;			
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
