//Assigns DIDs and BDIDs on the passed records
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
 		    self.unique_id	:= cnt;
			self            := L;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueId l) :=
		transform
			self.fname				:= l.clean_name.fname		    				;
			self.mname				:= l.clean_name.mname	 	    				;
			self.lname				:= l.clean_name.lname								;
			self.name_suffix	:= l.clean_name.name_suffix					;
			self.prim_range		:= l.Clean_contact_address.prim_range	;
			self.prim_name		:= l.Clean_contact_address.prim_name		;
			self.sec_range		:= l.Clean_contact_address.sec_range		;
			self.zip5		 			:= l.Clean_contact_address.zip					;
			self.state		    := l.Clean_contact_address.st					;
			self.phone				:= l.rawfields.Main_Phone_Number;
			self.dob					:= '';
			self.ssn					:= '';
			self.did					:= 0  												;
			self.did_score		:= 0  												;
			self		 	    		:= l  												;
		end;
			
		dSlimForDiding	:= project(dAddUniqueId,tSlimForDiding(left));
		
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A','P'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding															// Input Dataset
			,Did_Matchset             									// Did_Matchset  what fields to match on
			,ssn                	    									// ssn
			,dob                 												// dob
			,fname																			// fname
			,mname			     														// mname
			,lname			     														// lname
			,name_suffix     														// name_suffix
			,prim_range	          	    								// prim_range
			,prim_name	          											// prim_name
			,sec_range	          											// sec_range
			,zip5				        												// zip5
			,state			          											// state
			,phone			          											// phone10
			,did                      									// Did
			,lbentley_test.Layouts.Temporary.DidSlim  	// output layout
			,TRUE                     									// Does output record have the score
			,did_score                									// did score field
			,75                       									// score threshold
			,dDidOut																		// output dataset			
		);                          
		Business_HeaderV2.macFix_Contact_DIDs(
			 dDidOut
			,did
			,lname
			,true
			,did_score
			,true
			,true
			,ssn
			,dDidOut_patched
		);


		dDidOut_dist			:= distribute	(dDidOut_patched(did != 0)	,unique_id );
		dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id ,local);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id	);

 			 
		Layouts.Base tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
		transform

			self.did				:= if(r.did				<> 0	,r.did				,0);
			self.did_score	:= if(r.did_score <> 0	,r.did_score	,0);
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
			self				:= l	;
		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.UniqueId l) :=
  	    transform
			self.unique_id		:= l.unique_id																					;
			self.company_name	:= stringlib.stringtouppercase(l.rawfields.Company_Name) 		;
			self.prim_range		:= l.Clean_company_address.prim_range											;
			self.prim_name		:= l.Clean_company_address.prim_name												;
			self.zip5					:= l.Clean_company_address.zip			    										;
			self.sec_range		:= l.Clean_company_address.sec_range												;
			self.state				:= l.Clean_company_address.st															;
			self.phone				:= l.rawfields.Phone_Number;
			self.bdid					:= 0																										;
			self.bdid_score		:= 0																										;
		end;   
    
	  dSlimForBdiding :=  project( dAddUniqueId
								    ,tSlimForBdiding(left)
								    );
        
		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex(																						
			 dSlimForBdiding									// Input Dataset													
			,BDID_Matchset                    // BDID Matchset what fields to match on  
			,company_name	                    // company_name	                          
			,prim_range		                    // prim_range		                          
			,prim_name		                    // prim_name		                          
			,zip5					            				// zip5					                          
			,sec_range		                    // sec_range		                          
			,state				                		// state				                          
			,phone				               			// phone				                          
			,fein_not_used                    // fein                                   
			,bdid															// bdid												            
			,Layouts.Temporary.BdidSlim       // Output Layout                          
			,true                             // output layout has bdid score field?                       
			,bdid_score                       // bdid_score                             
			,dBdidOut                         // Output Dataset                         
		);                                                                            			
                                        
		dBDidOut_dist			:= distribute	(dBDidOut(bdid != 0)	,unique_id					  );
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score	,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);
		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id					  );

		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform
			self.bdid				:= if(r.bdid 	   		<> 0	,r.bdid 			,0);
			self.bdid_score	:= if(r.bdid_score	<> 0	,r.bdid_score	,0);
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
	
	export fAll(dataset(Layouts.Base)	pDataset) :=
	function
		dAppendDid		:= fAppendDid	(pDataset		) : persist(Persistnames().AppendIdsfAppendDid);
		dAppendBdid		:= fAppendBdid(dAppendDid	) : persist(Persistnames().AppendIdsfAppendBdid);
		return dAppendBdid;
	end;


end; 
