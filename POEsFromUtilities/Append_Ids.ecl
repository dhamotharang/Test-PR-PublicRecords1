//Assigns DIDs and BDIDs on the passed records
import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2;

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
			self.fname				:= l.subject_name.fname		    	;
			self.mname				:= l.subject_name.mname	 	    	;
			self.lname				:= l.subject_name.lname					;
			self.name_suffix	:= l.subject_name.name_suffix		;
			self.prim_range		:= l.subject_address.prim_range	;
			self.prim_name		:= l.subject_address.prim_name	;
			self.sec_range		:= l.subject_address.sec_range	;
			self.zip5		 			:= l.subject_address.zip				;
			self.state		    := l.subject_address.st					;
			self.phone				:= if(l.subject_phone != 0,(string10)l.subject_phone,'');
			self.dob					:= if(l.subject_dob		!= 0,(string8 )l.subject_dob	,'');
			self.ssn					:= if(l.subject_ssn		!= 0,(string9 )l.subject_ssn	,'');
			self.did					:= 0  													;
			self.did_score		:= 0  													;
			self		 	    		:= l  													;
		end;
			
		dSlimForDiding	:= project(dAddUniqueId,tSlimForDiding(left));
		
		// Match to Headers by subject Name and Address and phone
		Did_Matchset := ['A','P','S','D'];

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
			,Layouts.Temporary.DidSlim  								// output layout
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
			self.unique_id		:= l.unique_id																		;
			self.DotID				:= 0																							;
			self.DotScore			:= 0																							;
			self.DotWeight		:= 0																							;
			self.EmpID				:= 0																							;
			self.EmpScore			:= 0																							;
			self.EmpWeight		:= 0																							;
			self.POWID				:= 0																							;
			self.POWScore			:= 0																							;
			self.POWWeight		:= 0																							;
			self.ProxID				:= 0																							;
			self.ProxScore		:= 0																							;
			self.ProxWeight		:= 0																							;
			self.SELEID				:= 0																							;
			self.SELEScore		:= 0																							;
			self.SELEWeight		:= 0																							;	
			self.OrgID				:= 0																							;
			self.OrgScore			:= 0																							;
			self.OrgWeight		:= 0																							;
			self.UltID				:= 0																							;
			self.UltScore			:= 0																							;
			self.UltWeight		:= 0																							;			
			self.fname				:= l.subject_name.fname		    										;
			self.mname				:= l.subject_name.mname	 	    										;
			self.lname				:= l.subject_name.lname														;	
			self.ssn					:= if(l.subject_ssn	!= 0,(string9)l.subject_ssn,'');			
			self.company_name	:= stringlib.stringtouppercase(l.company_name) 		;
			self.prim_range		:= l.company_address.prim_range										;
			self.prim_name		:= l.company_address.prim_name										;
			self.zip5					:= l.company_address.zip			    								;
			self.sec_range		:= l.company_address.sec_range										;
			self.state				:= l.company_address.st														;
			self.city_name		:= l.company_address.city_name										;			
			self.phone				:= if(l.company_phone	!= 0	,(string10)l.company_phone	,'');
			self.fein					:= if(l.company_fein	!= 0	,(string9 )l.company_fein		,'');			
			self.bdid					:= 0																										;
			self.bdid_score		:= 0																										;
		end;   
    
	  dSlimForBdiding :=  project( dAddUniqueId
								    ,tSlimForBdiding(left)
								    );
        
		BDID_Matchset := ['A','P','F'];

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
			,fein					                    // fein                                   
			,bdid															// bdid												            
			,Layouts.Temporary.BdidSlim       // Output Layout                          
			,true                             // output layout has bdid score field?                       
			,bdid_score                       // bdid_score                             
			,dBdidOut                         // Output Dataset
			,																	// default threshold
			,																	// use prod version of superfiles
			,																	// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set					// create BIP keys only
			,																	// url
			,																	// email 
			,city_name												// city
			,fname														// fname
			,mname														// mname
			,lname														// lname
			,ssn															// contact_ssn
		);                                                                            																		

		dBDidOut_dist			:= distribute	(dBDidOut(bdid != 0)	,unique_id					  );
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -DotScore,-EmpScore,-POWScore,-ProxScore,-SELEScore,-OrgScore,-UltScore,-bdid_score,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);
		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id					  );

		Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform
			self.bdid				:= if(r.bdid 	   		<> 0	,r.bdid 			,0);
			self.bdid_score	:= if(r.bdid_score	<> 0	,r.bdid_score	,0);
			self.DotID			:= if(r.DotID				<> 0	,r.DotID			,0);
			self.DotScore		:= if(r.DotScore		<> 0	,r.DotScore		,0);
			self.DotWeight	:= if(r.DotWeight		<> 0	,r.DotWeight	,0);
			self.EmpID			:= if(r.EmpID				<> 0	,r.EmpID			,0);
			self.EmpScore		:= if(r.EmpScore		<> 0	,r.EmpScore		,0);
			self.EmpWeight	:= if(r.EmpWeight		<> 0	,r.EmpWeight	,0);
			self.POWID			:= if(r.POWID				<> 0	,r.POWID			,0);
			self.POWScore		:= if(r.POWScore		<> 0	,r.POWScore		,0);
			self.POWWeight	:= if(r.POWWeight		<> 0	,r.POWWeight	,0);
			self.ProxID			:= if(r.ProxID			<> 0	,r.ProxID			,0);
			self.ProxScore	:= if(r.ProxScore		<> 0	,r.ProxScore	,0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0	,r.ProxWeight	,0);
			self.SELEID			:= if(r.SELEID			<> 0	,r.SELEID			,0);
			self.SELEScore	:= if(r.SELEScore		<> 0	,r.SELEScore	,0);
			self.SELEWeight	:= if(r.SELEWeight	<> 0	,r.SELEWeight	,0);
			self.OrgID			:= if(r.OrgID				<> 0	,r.OrgID			,0);
			self.OrgScore		:= if(r.OrgScore		<> 0	,r.OrgScore		,0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0	,r.OrgWeight	,0);
			self.UltID			:= if(r.UltID				<> 0	,r.UltID			,0);
			self.UltScore		:= if(r.UltScore		<> 0	,r.UltScore		,0);
			self.UltWeight	:= if(r.UltWeight		<> 0	,r.UltWeight	,0);			
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

	export fAppendSSN(dataset(Layouts.Base) pDataset) :=
	function
	
		Watchdog.mac_Append_Ssn(pDataset,did,subject_ssn,out_dataset,false);
		
		return out_dataset;
		
	end;

	export fAppendFein(dataset(Layouts.Base) pDataset) :=
	function
	
		Business_Header_SS.MAC_Add_FEIN_By_BDID(pDataset,bdid,company_fein,out_dataset,false);
		
		return out_dataset;
		
	end;

	export fAll(

		 dataset(Layouts.Base)	pDataset
		,string 								pPersistdid		= Persistnames().AppendIdsfAppendDid	
		,string 								pPersistbdid	= Persistnames().AppendIdsfAppendBdid	
		,string 								pPersistssn		= Persistnames().AppendIdsfAppendSSN	
		,string 								pPersistFein	= Persistnames().AppendIdsfAppendFein	

	) :=
	function

		dAppendDid		:= fAppendDid	(pDataset		) : persist(pPersistdid	);
		dAppendBdid		:= fAppendBdid(dAppendDid	) : persist(pPersistbdid);
		dAppendSsn		:= fAppendSSN	(dAppendBdid) : persist(pPersistssn	);
		dAppendFein		:= fAppendFein(dAppendSsn	) : persist(pPersistFein);

		return dAppendFein;

	end;

end; 
