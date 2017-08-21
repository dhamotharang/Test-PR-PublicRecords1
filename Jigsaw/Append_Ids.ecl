//Assigns DIDs and BDIDs on the passed records
import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS,Business_HeaderV2,MDR, BIPV2;

export Append_Ids :=
module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fStandardizeName
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendDid(dataset(layouts.base) pDataset,boolean pShouldApplyPatch = true) :=
	function
		
		//Add unique id
		Layouts.Temporary.Jigsaw_UniqueId tAddUniqueId(layouts.base l,unsigned8 cnt) :=
		transform
 		  self.unique_id	:= cnt;
			self            := L;

		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Diding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.Jigsaw_UniqueId l) :=
		transform
			self.fname				:= l.clean_name.fname		    ;
			self.mname				:= l.clean_name.mname	 	    ;
			self.lname				:= l.clean_name.lname			;
			self.name_suffix	:= l.clean_name.name_suffix			;
			self.prim_range		:= l.Clean_address.prim_range		;
			self.prim_name		:= l.Clean_address.prim_name		;
			self.sec_range		:= l.Clean_address.sec_range		;
			self.zip5		 			:= l.Clean_address.zip				;
			self.state		    := l.Clean_address.st				;
			self.phone				:= l.rawfields.phone ;
			self.did					:= 0  ;
			self.did_score		:= 0  ;
			self		 	    		:= l  ;
		end;
			
		dSlimForDiding	:= project(dAddUniqueId,tSlimForDiding(left));
		
		// Match to Headers by Contact Name and Address and phone
		Did_Matchset := ['A','P'];

		DID_Add.MAC_Match_Flex(
			 dSlimForDiding				// Input Dataset
			,Did_Matchset         // Did_Matchset what fields to match on
			,ssn                	// ssn
			,dob                 	// dob
			,fname						    // fname
			,mname			     		  // mname
			,lname			     		  // lname
			,name_suffix     			// name_suffix
			,prim_range	          // prim_range
			,prim_name	          // prim_name
			,sec_range	          // sec_range
			,zip5				          // zip5
			,state			          // state
			,phone			          // phone10
			,did                  // Did
			,Jigsaw.Layouts.Temporary.DidSlim  // output layout
			,TRUE                 // Does output record have the score
			,did_score            // did score field
			,75                   // score threshold
			,dDidOut					    // output dataset			
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

		dDidOut_					:= if(pShouldApplyPatch, dDidOut_patched, dDidOut);

		dDidOut_dist			:= distribute	(dDidOut_(did != 0)	,unique_id );
		dDidOut_sort			:= sort			(dDidOut_dist		,unique_id, -did_score	,local);
		dDidOut_dedup			:= dedup		(dDidOut_sort		,unique_id ,local);
		
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id	);

 			 
		Layouts.Base tAssignDIDs(Layouts.Temporary.Jigsaw_UniqueId l, Layouts.Temporary.DidSlim r) :=
		transform

			self.did				:= if(r.did <> 0, r.did				, 0);
			self.did_score	:= if(r.did_score <> 0, r.did_score	, 0);
			self 						:= l;

		end;
 
		dAssignDids := join(  dAddUniqueId_dist
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
  // -- Modified for BIPV2 4/3/2013
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(dataset(Layouts.Base) pDataset) :=
	function

		Layouts.Temporary.Jigsaw_UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
		transform
			self.unique_id	   := cnt	;
			self.source_rec_id := HASH64(StringLib.StringToUpperCase(TRIM(l.rawfields.CompanyID)) + StringLib.StringToUpperCase(TRIM(l.rawfields.ContactID))  + StringLib.StringToUpperCase(TRIM(l.rawfields.firstname))+ 
			                             StringLib.StringToUpperCase(TRIM(l.rawfields.lastname)) + StringLib.StringToUpperCase(TRIM(l.rawfields.CompanyName)) + StringLib.StringToUpperCase(TRIM(l.rawfields.CompanyStreetAddress)) + 
																	 StringLib.StringToUpperCase(TRIM(l.rawfields.phone)) +	StringLib.StringToUpperCase(TRIM(l.rawfields.CompanyURL)) + StringLib.StringToUpperCase(TRIM(l.rawfields.status)));
			self				       := l	;
		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Bdiding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.Jigsaw_UniqueId l) :=
  	    transform
			self.unique_id		 := l.unique_id																					;
			self.company_name	 := stringlib.stringtouppercase(l.rawfields.CompanyName);
			self.prim_range		 := l.Clean_address.prim_range													;
			self.prim_name		 := l.Clean_address.prim_name														;
			self.zip5					 := l.Clean_address.zip			    												;
			self.sec_range		 := l.Clean_address.sec_range														;
			self.state				 := l.Clean_address.st																	;
			self.phone				 := l.rawfields.phone		    														;
			self.bdid					 := 0																										;
			self.bdid_score		 := 0																										;
      self.p_city_name	 := l.Clean_address.p_city_name                         ;
      self.fname				 := l.clean_name.fname                                  ;
      self.mname				 := l.clean_name.mname                                  ;
      self.lname				 := l.clean_name.lname                                  ;
			self.source_rec_id := l.source_rec_id                                     ;
			self.source				 := mdr.sourceTools.src_Jigsaw                          ;
			self.CompanyURL    := l.rawfields.CompanyURL                              ;
			self.email         := l.rawfields.email                                   ;
      self      				 := l                                                   ;
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
	    ,                                 // score_threshold
	    ,     														// pFileVersion - default to use prod version of superfiles
	    ,                                 // pUseOtherEnvironment - default is to hit prod from dataland, and on prod hit prod.
	    ,BIPV2.xlink_version_set          // BIPV2 IDs	
	    ,CompanyURL                       // URL
	    ,email                            // Email
	    ,p_city_name			            		// City
	    ,fname                  		      // fname
      ,mname                  	      	// mname
	    ,lname                  	        // lname
  		,                                 // contact_ssn
			,source                           // source - MDR.sourceTools
			,source_rec_id                    // source_record_id
			,FALSE                            // src_matching_is_priority
      );                              			
                                        
		dBDidOut_dist			:= distribute	(dBDidOut(bdid != 0 OR ultid != 0 OR orgid != 0 OR seleid != 0 OR 
		                                          proxid != 0 OR powid != 0 OR empid != 0 OR dotid != 0)	,unique_id);
		dBDidOut_sort			:= sort				(dBDidOut_dist				,unique_id, -bdid_score,-ultscore,-orgscore,-selescore,-proxscore,-powscore,-empscore,-dotscore,local);
		dBDidOut_dedup		:= dedup			(dBDidOut_sort				,unique_id							,local);
		dAddUniqueId_dist := distribute	(dAddUniqueId					,unique_id					  );

		Layouts.Base tAssignBdids(Layouts.Temporary.Jigsaw_UniqueId l, Layouts.Temporary.BdidSlim r) :=
		transform
			self.bdid				    := if(r.bdid 	   		<> 0, r.bdid 		  , 0);
			self.bdid_score   	:= if(r.bdid_score	<> 0, r.bdid_score, 0);
			self.ultid          := if(r.ultid     	<> 0, r.ultid  		, 0);
      self.orgid          := if(r.orgid	      <> 0, r.orgid  		, 0);
      self.seleid         := if(r.seleid	    <> 0, r.seleid  	, 0);
      self.proxid         := if(r.proxid    	<> 0, r.proxid  	, 0);
      self.powid          := if(r.powid	      <> 0, r.powid 		, 0);
      self.empid          := if(r.empid	      <> 0, r.empid 		, 0);
      self.dotid          := if(r.dotid	      <> 0, r.dotid 		, 0);
      self.ultscore       := if(r.ultscore	  <> 0, r.ultscore  , 0);
      self.orgscore       := if(r.orgscore	  <> 0, r.orgscore 	, 0);
      self.selescore      := if(r.selescore	  <> 0, r.selescore	, 0);
      self.proxscore      := if(r.proxscore	  <> 0, r.proxscore , 0);
      self.powscore       := if(r.powscore	  <> 0, r.powscore 	, 0);
      self.empscore       := if(r.empscore	  <> 0, r.empscore 	, 0);
      self.dotscore       := if(r.dotscore	  <> 0, r.dotscore 	, 0);
      self.ultweight      := if(r.ultweight	  <> 0, r.ultweight , 0);
      self.orgweight      := if(r.orgweight	  <> 0, r.orgweight , 0);
      self.seleweight     := if(r.seleweight	<> 0, r.seleweight, 0);
      self.proxweight     := if(r.proxweight	<> 0, r.proxweight, 0);
      self.powweight      := if(r.powweight	  <> 0, r.powweight	, 0);
      self.empweight      := if(r.empweight  	<> 0, r.empweight	, 0);
      self.dotweight      := if(r.dotweight 	<> 0, r.dotweight , 0);
			self 					    	:= l;
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
