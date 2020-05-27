IMPORT business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2, MDR;

EXPORT Append_BDIds_Contacts := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendBDID
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendBDID(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pDataset) :=	FUNCTION
	
		Equifax_Business_Data.Layouts.Temp.UniqueIdContacts tAddUniqueId(Equifax_Business_Data.Layouts.Base_Contacts L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));
		
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for linkIDs
		//////////////////////////////////////////////////////////////////////////////////////
			
		Equifax_Business_Data.Layouts.Temp.BdidSlim tSlimForBDIDing(Equifax_Business_Data.Layouts.Temp.UniqueIdContacts L) := TRANSFORM
			SELF.unique_id     		:= L.unique_id;
			SELF.company_name     := L.company_name;
			SELF.prim_range       := L.clean_company_address.prim_range;
			SELF.prim_name        := L.clean_company_address.prim_name;
			SELF.sec_range        := L.clean_company_address.sec_range;
			SELF.zip5             := L.clean_company_address.zip;
			SELF.city             := L.clean_company_address.p_city_name;
			SELF.state            := L.clean_company_address.st;
      SELF.phone            := L.clean_company_phone; 
			SELF.rcid             := L.rcid;
			SELF.source           := MDR.sourceTools.src_Equifax_Business_Data;
			SELF.bdid             := 0;
			SELF.bdid_score       := 0;
			SELF							    := [];
		END;
		
    dSlimInput	:= project(dAddUniqueId(company_name <> '') ,tSlimForBDIDing(LEFT));
    
 		//*** Match set for BDIDing
		BDID_Matchset := ['A','P'];
		
		//**** External id macro that appends BIPV2 xlinkids
		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimInput     											// Input Dataset						
			,BDID_Matchset                        // BIP Matchset what fields to match on           
			,company_name      		             		// company_name	              
			,prim_range             		          // prim_range		              
			,prim_name            		            // prim_name		              
			,zip5             					          // zip5					              
			,sec_range            		            // sec_range		              
			,state            				            // state				              
			,phone                                // phone				              
			,fein_not_used                        // fein              
			,bdid         								        // bdid												
			,Equifax_Business_Data.Layouts.Temp.BdidSlim    // Output Layout 
			,FALSE                                // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset   
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_only_set                 // Create LinkID's only
			,																	    // Url
			,email																// Email
			,city                   							// City
			,fname           											// fname
			,mname         												// mname
			,lname           											// lname
		  ,
		  ,source
		  ,rcid
	    ,true
		  );
		
    dBDID_dist           := DISTRIBUTE(dBdidOut(
		                                          bdid    != 0 OR 
		                                          Ultid 	!= 0 OR 
																	            OrgID 	!= 0 OR 
																	            ProxID 	!= 0 OR
																            	SELEID 	!= 0 OR
																	            POWID 	!= 0 OR 
																	            EmpID 	!= 0 OR 
																	            DotID 	!= 0), unique_id);

    dBdidOut_sort      := SORT(dBDID_dist, unique_id, -bdid_score, -ProxScore, LOCAL);
    dBdidOut_dedup     := DEDUP(dBdidOut_sort, unique_id, LOCAL);																						
																							
		dInput             := DISTRIBUTE(dAddUniqueId, unique_id);

		Equifax_Business_Data.Layouts.Base_Contacts tAssignBDIDs(Equifax_Business_Data.Layouts.Temp.UniqueIdContacts L,Equifax_Business_Data.Layouts.Temp.BDIDSlim R) := TRANSFORM
		  SELF.bdid   			:= R.bdid;
			SELF.bdid_score		:= R.bdid_score;
			SELF.Ultid				:= R.Ultid;
			SELF.Ultscore			:= R.Ultscore;
			SELF.UltWeight		:= R.UltWeight;
			SELF.OrgID				:= R.OrgID;
			SELF.Orgscore			:= R.Orgscore;
			SELF.OrgWeight		:= R.OrgWeight;
			SELF.ProxID				:= R.ProxID;
			SELF.Proxscore		:= R.Proxscore;
			SELF.ProxWeight		:= R.ProxWeight;
			SELF.SELEID				:= R.SELEID;
			SELF.SELEScore		:= R.SELEScore;
			SELF.SELEWeight		:= R.SELEWeight;
			SELF.POWID				:= R.POWID;
			SELF.POWscore			:= R.POWscore;
			SELF.POWWeight		:= R.POWWeight;
			SELF.EmpID				:= R.EmpID;
			SELF.Empscore			:= R.Empscore;
			SELF.EmpWeight		:= R.EmpWeight;
			SELF.DotID				:= R.DotID;
			SELF.Dotscore			:= R.Dotscore;
			SELF.DotWeight		:= R.DotWeight;
			SELF 							:= L;
		END;

		full_update_BDID := JOIN(dInput
												    ,dBDIDOut_dedup
												    ,LEFT.unique_id = RIGHT.unique_id
												    ,tAssignBDIDs(LEFT, RIGHT)
												    ,LEFT OUTER
												    ,LOCAL);
		
		RETURN full_update_BDID;
				      
	END; // End fAppendBDID

	
	EXPORT fAll(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pDataset) := FUNCTION
    
		dAppendBDID    := fAppendBDID(pDataset)
    // : PERSIST(Equifax_Business_Data.Persistnames().AppendBDIdsContacts)		
		;
	
		RETURN dAppendBDID;
	
	END;

END;