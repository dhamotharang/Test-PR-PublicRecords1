import business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2;

export Append_Ids :=module

	//////////////////////////////////////////////////////////////////////////////////////
	// -- function: fAppendBdid
	//////////////////////////////////////////////////////////////////////////////////////
	export fAppendBdid(dataset(layouts_input.cleaned_inspection) pDataset) :=function
	
	//*** Match set for BDIDing
	BDID_Matchset 		:= 	['A'];
	
	//**** External id macro that appends BDID's and BIPV2 xlinkids
	Business_Header_SS.MAC_Add_BDID_Flex( pDataset       		       											 // Input Dataset
																				,BDID_Matchset           											// BDID Matchset
																				,cname                   										 // company_name
																				,prim_range              										// prim_range
																				,prim_name              									 // prim_name
																				,zip5                    						      // zip5
																				,sec_range               						     // sec_range
																				,st                      						    // state
																				,''                      						   // phone
																				,fein_append             						  // fein
																				,bdid                    						 // bdid
																				,layouts_input.cleaned_inspection   // Output Layout
																				,TRUE                    					 // output layout has bdid score field?
																				,BDID_Score             				  // bdid_score
																				,OSHAIR_bdid_match      			   // Output Dataset   
																				,														    // deafult threscold
																				,											         // use prod version of superfiles
																				,												      // default is to hit prod from dataland, and on prod hit prod.		
																				,BIPV2.xlink_version_set     // Create BIP Keys only
																				,           					    	// Url
																				,								           // Email
																				,p_city_name			        // City
																				,              		       // fname
																				,              	        // mname
																				,              	       // lname
																				,                     // contact_ssn
																				,source					     // source - MDR.sourceTools
																				,source_rec_id      // source_record_id
																				,FALSE             // src_matching_is_priority
																		 );
							 
	Business_Header_SS.MAC_Add_FEIN_By_BDID(OSHAIR_bdid_match
																					,BDID
																					,FEIN_append
																					,OSHAIR_out_add_fein);
									
	dBdidOut_dist			:= dedup(sort(distribute(OSHAIR_out_add_fein,hash32(Activity_Number))
														 ,record,local),record,local);

	OSHAIR.layout_OSHAIR_inspection_clean_BIP tbase_bip(layouts_input.cleaned_inspection  l) :=transform
	
		self.bdid					:=  l.bdid;
		self.bdid_score		:=  l.bdid_score	;
		self.Ultid				:=  l.Ultid				;
		self.Ultscore			:=  l.Ultscore		;
		self.UltWeight		:=  l.UltWeight		;
		self.OrgID				:=  l.OrgID				;
		self.Orgscore			:=  l.Orgscore		;
		self.OrgWeight		:=  l.OrgWeight		;
		self.ProxID				:=  l.ProxID			;
		self.Proxscore		:=  l.Proxscore		;
		self.ProxWeight		:=  l.ProxWeight	;
		self.SELEID				:=  l.SELEID			;
		self.SELEScore		:=  l.SELEScore		;
		self.SELEWeight		:=  l.SELEWeight	;
		self.POWID				:=  l.POWID				;
		self.POWscore			:=  l.POWscore		;
		self.POWWeight		:=  l.POWWeight		;
		self.EmpID				:=  l.EmpID				;
		self.Empscore			:=  l.Empscore		;
		self.EmpWeight		:=  l.EmpWeight		;
		self.DotID				:=  l.DotID				;
		self.Dotscore			:=  l.Dotscore		;
		self.DotWeight		:=  l.DotWeight		;
		self 							:=  l;

		end;

		dAssignBdids := project(dBdidOut_dist, tbase_bip(left));

		return dAssignBdids;

	end;


	export fAll(dataset(layouts_input.cleaned_inspection) pDataset) :=	function

		dAppendBdid	:= fAppendBdid	(pDataset	): persist(Persistnames().AppendIds);
									  
		return dAppendBdid;

	end;
	
end;