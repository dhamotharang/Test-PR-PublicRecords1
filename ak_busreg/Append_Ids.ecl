import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, TopBusiness_External, MDR;
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
         self.unique_id    := cnt   ;
         self                    := l     ;
      end;   
      
      dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
      //////////////////////////////////////////////////////////////////////////////////////
      // -- Slim record for Diding
      //////////////////////////////////////////////////////////////////////////////////////
      Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Temporary.UniqueId l) :=
      transform
         self.fname           := l.clean_contact_name.fname                ;
         self.mname           := l.clean_contact_name.mname                ;
         self.lname           := l.clean_contact_name.lname                ;
         self.name_suffix  := l.clean_contact_name.name_suffix       ;
         self.prim_range      := l.Clean_Company_address.prim_range     ;
         self.prim_name    := l.Clean_Company_address.prim_name      ;
         self.sec_range    := l.Clean_Company_address.sec_range      ;
         self.zip5               := l.Clean_Company_address.zip               ;
         self.state           := l.Clean_Company_address.st                ;
         self.phone           := '';
         self.did             := 0                                                     ;
         self.did_score    := 0                                                     ;
         self                    := l                                                     ;
      end;   
      
      dSlimForDiding := project(dAddUniqueId, tSlimForDiding(left));
      
      // Match to Headers by Contact Name and Address and phone
      Did_Matchset := ['A'];
      DID_Add.MAC_Match_Flex(
          dSlimForDiding                     // Input Dataset
         ,Did_Matchset              // Did_Matchset  what fields to match on
         ,ssn                          // ssn
         ,dob                             // dob
         ,fname                                 // fname
         ,mname                              // mname
         ,lname                              // lname
         ,name_suffix                     // name_suffix
         ,prim_range                   // prim_range
         ,prim_name                    // prim_name
         ,sec_range                    // sec_range
         ,zip5                            // zip5
         ,state                           // state
         ,phone                           // phone10
         ,did                       // Did
         ,Layouts.Temporary.DidSlim  // output layout
         ,TRUE                      // Does output record have the score
         ,did_score                 // did score field
         ,75                        // score threshold
         ,dDidOut                         // output dataset       
      );                          
      dDidOut_dist         := distribute(dDidOut         , hash(unique_id));
      dAddUniqueId_dist := distribute(dAddUniqueId, hash(unique_id));
          
      Layouts.Base tAssignDIDs(Layouts.Temporary.UniqueId l, Layouts.Temporary.DidSlim r) :=
      transform
         self.did          := if(r.did          <> 0, r.did          , 0);
         self.did_score := if(r.did_score <> 0, r.did_score , 0);
         self                 := l;
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
         self.unique_id    := cnt   ;
         self                    := l     ;
      end;   
      
      dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));
      //////////////////////////////////////////////////////////////////////////////////////
      // -- Slim record for Diding
      //////////////////////////////////////////////////////////////////////////////////////
      Layouts.Temporary.BdidSlim tSlimForBdiding(Layouts.Temporary.UniqueId l) :=
      transform
         self.unique_id    := l.unique_id                                     ;
         self.company_name := l.rawfields.BusinessName                     ;
         self.prim_range      := l.Clean_Company_address.prim_range     ;
         self.prim_name    := l.Clean_Company_address.prim_name      ;
         self.zip5               := l.Clean_Company_address.zip               ;
         self.sec_range    := l.Clean_Company_address.sec_range      ;
         self.state           := l.Clean_Company_address.st                ;
         self.phone           := '';
         self.bdid               := 0                                                     ;
         self.bdid_score      := 0                                                     ;
      end;   
      
      dSlimForBdiding := project(dAddUniqueId, tSlimForBdiding(left));
      BDID_Matchset := ['A'];
      Business_Header_SS.MAC_Add_BDID_Flex(
          dSlimForBdiding                                // Input Dataset                 
         ,BDID_Matchset                        // BDID Matchset what fields to match on           
         ,company_name                          // company_name                 
         ,prim_range                            // prim_range                   
         ,prim_name                             // prim_name                    
         ,zip5                                     // zip5                            
         ,sec_range                             // sec_range                    
         ,state                                    // state                        
         ,phone                                    // phone                        
         ,fein_not_used                        // fein              
         ,bdid                                             // bdid                                    
         ,Layouts.Temporary.BdidSlim           // Output Layout 
         ,true                                 // output layout has bdid score field?                       
         ,bdid_score                           // bdid_score                 
         ,dBdidOut                             // Output Dataset                   
      );                                         
                                        
      dBdidOut_dist        := distribute(dBdidOut     , hash(unique_id));
      dAddUniqueId_dist := distribute(dAddUniqueId, hash(unique_id));
          
      Layouts.Base tAssignBdids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BdidSlim r) :=
      transform
         self.bdid            := if(r.bdid            <> 0, r.bdid            , 0);
         self.bdid_score   := if(r.bdid_score   <> 0, r.bdid_score   , 0);
         self                 := l;
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
   
	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBid
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBid(dataset(Layouts.Base) pDataset) :=
	function

		Layouts.Temporary.UniqueId tAddUniqueId(Layouts.Base l, unsigned8 cnt) :=
		transform
			self.unique_id		:= cnt	;
			self				:= l	;
		end;   
		
		dAddUniqueId := project(pDataset, tAddUniqueId(left,counter));

		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for Biding
		//////////////////////////////////////////////////////////////////////////////////////
		Layouts.Temporary.BidSlim tSlimForBiding(Layouts.Temporary.UniqueId l) :=
  	    transform
			self.unique_id		:= l.unique_id																					;
			self.company_name	:= stringlib.stringtouppercase(l.rawfields.BusinessName);
			self.prim_range		:= l.Clean_Company_address.prim_range										;
			self.prim_name		:= l.Clean_Company_address.prim_name										;
			self.zip5					:= l.Clean_Company_address.zip			    								;
			self.sec_range		:= l.Clean_Company_address.sec_range										;
			self.state				:= l.Clean_Company_address.st														;
			self.phone				:= ''										    														;
			self.bid					:= 0																										;
			self.bid_score		:= 0																										;
			self.source_party := l.rawfields.LicenseNumber                            ;
		end;   
    
	  dSlimForBiding :=  project( dAddUniqueId
								    ,tSlimForBiding(left)
								    );
        
		//** Append BIDs
		//**
		TopBusiness_External.MAC_External_BID(
			dSlimForBiding,  // infile
			dBidOut,  // outfile
			bid,    // bid_field	
			bid_score,  // bdid_score_field
			MDR.sourceTools.src_AK_Busreg,  //	source_field
			,  // source_docid_field
			source_party,	 // source_party_field
			company_name,  // company_name_field
			zip5,    // zip_field
			prim_name, // prim_name_field
			prim_range, // prim_range_field
			, // fein_field
			  // phone_field
		);
		                                  			
                                        
		dBidOut_dist			:= distribute	(dBidOut(bid != 0)	,unique_id					  );
		dBidOut_sort			:= sort				(dBidOut_dist				,unique_id, -bid_score	,local);
		dBidOut_dedup			:= dedup			(dBidOut_sort				,unique_id							,local);
		dAddUniqueId_dist := distribute	(dAddUniqueId				,unique_id					  );

		Layouts.Base tAssignBids(Layouts.Temporary.UniqueId l, Layouts.Temporary.BidSlim r) :=
		transform
			self.bid				:= if(r.bid 	   	<> 0, r.bid 		, 0);
			self.bid_score	:= if(r.bid_score	<> 0, r.bid_score	, 0);
			self 						:= l;
		end;

		dAssignBids := join(
											 dAddUniqueId_dist
											,dBidOut_dedup
											,left.unique_id = right.unique_id
											,tAssignBids(left, right)
											,left outer
											,local
											);
		
		return dAssignBids;
		
	end;
   
   export fAll(
      dataset(Layouts.Base )  pDataset
   ) :=
   function
   
      dAppendDid     := fAppendDid     (pDataset      ) : persist(Persistnames.AppendIdsDid  );
      dAppendBdid    := fAppendBdid (dAppendDid ) : persist(Persistnames.AppendIdsBdid);
		  dAppendBid		 := fAppendBid (dAppendBdid) : persist(Persistnames.AppendIdsBid);
                                                                    
      return dAppendBid;
   
   end;
end;
