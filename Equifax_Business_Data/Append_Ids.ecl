IMPORT business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2;

EXPORT Append_Ids := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendDid
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendDid(DATASET(Equifax_Business_Data.Layouts.Base) pDataset) :=	FUNCTION

		Equifax_Business_Data.Layouts.Temp.UniqueId tAddUniqueId(Equifax_Business_Data.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));

    Equifax_Business_Data.Layouts.Temp.DidSlim taddDID(Equifax_Business_Data.Layouts.Temp.UniqueId L) :=  TRANSFORM
	    SELF.fname            := L.fname;
	    SELF.mname            := L.mname;
	    SELF.lname            := L.lname;
	    SELF.name_suffix      := L.name_suffix;
			SELF.prim_range       := L.prim_range;
			SELF.prim_name        := L.prim_name;
			SELF.sec_range        := L.sec_range;
			SELF.zip5             := L.zip;
			SELF.state            := L.st;
      SELF.phone            := L.clean_phone;      
			SELF.did              := 0;
			SELF.did_score		    := 0;
			SELF			            := L;
			SELF							    := [];
		END;

    dSlimInput	:= project(dAddUniqueId(fname != '' OR lname != ''),taddDID(LEFT));
    
    //append DID
    matchset :=['A', 'Z', 'P'];

    did_Add.MAC_Match_Flex(
		  dSlimInput, 	                       //Infile
			matchset,	                           //Set of char1's indicating matchfields
	    '', 	                               //SSN
			'', 	                               //DOB
			fname,                               //Fname 
			mname,                               //Mname 
			lname,                               //Lname  
			name_suffix,                         //Name Suffix 
	    prim_range,                          //Prim_range  
			prim_name,                           //Prim_name  
			sec_range,                           //Sec_range 
			zip5,                                //Zip
			state,                               //State
			phone,                               //Phone
	    did,   			                         //DID
	    Equifax_Business_Data.Layouts.Temp.DidSlim,   //Output rec layout
	    TRUE,                                //Output record has did score field
			did_score,	                         //DID score field
	    75,	                                 //DIDs with a score below here will be dropped 	
	    postDID);	                           //Outfile


    dGoodDIDs := DISTRIBUTE(postDID(did != 0), unique_id);
		dInput    := DISTRIBUTE(dAddUniqueId, unique_id);

		Equifax_Business_Data.Layouts.Base tAssignDIDs(Equifax_Business_Data.Layouts.Temp.UniqueId L,Equifax_Business_Data.Layouts.Temp.DidSlim R) := TRANSFORM
			SELF.did          := R.did;
			SELF.did_score    := R.did_score;
			SELF 							:= L;
		END;

		full_update_DID := JOIN(dInput
												   ,dGoodDIDs
												   ,LEFT.unique_id = RIGHT.unique_id
												   ,tAssignDIDs(LEFT, RIGHT)
												   ,LEFT OUTER
												   ,LOCAL);

		RETURN full_update_DID;			
        
	END;  // End fAppendDid

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendBIP
	// -- Creates the linkIDs
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendBIP(DATASET(Equifax_Business_Data.Layouts.Base) pDataset) :=	FUNCTION

		Equifax_Business_Data.Layouts.Temp.UniqueId tAddUniqueId(Equifax_Business_Data.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));
		
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for linkIDs
		//////////////////////////////////////////////////////////////////////////////////////
		Equifax_Business_Data.Layouts.Temp.BIPSlim tSlimForBIPing(Equifax_Business_Data.Layouts.Temp.UniqueId L) := TRANSFORM
			SELF.unique_id		    := L.unique_id;
			SELF.company  		    := L.clean_company_name;
	    SELF.fname            := L.fname;
	    SELF.mname            := L.mname;
	    SELF.lname            := L.lname;
			SELF.prim_range       := L.prim_range;
			SELF.prim_name        := L.prim_name;
			SELF.sec_range        := L.sec_range;
			SELF.city       	    := L.p_city_name;
			SELF.zip5             := L.zip;
			SELF.state            := L.st;
      SELF.phone            := L.clean_phone;     
			SELF.url              := L.EFX_WEB;
			SELF.email            := '';
			SELF							    := [];
		END;
		
    dSlimInput	:= project(dAddUniqueId(clean_company_name <> '') ,tSlimForBIPing(LEFT));
    
 		//*** Match set for BIPing
		BIP_Matchset := ['A','P'];
		
		//**** External id macro that appends BIPV2 xlinkids
		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimInput     											// Input Dataset						
			,BIP_Matchset                         // BIP Matchset what fields to match on           
			,company          		             		// company_name	              
			,prim_range             		          // prim_range		              
			,prim_name            		            // prim_name		              
			,zip5             					          // zip5					              
			,sec_range            		            // sec_range		              
			,state            				            // state				              
			,phone                                // phone				              
			,fein_not_used                        // fein              
			,bdid_not_used 								        // bdid												
			,Equifax_Business_Data.Layouts.Temp.BIPSlim    // Output Layout 
			,FALSE                                // output layout has bdid score field?                       
			,bdid_score_not_used                  // bdid_score                 
			,dBIPOut                              // Output Dataset   
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_only_set                 // Create LinkID's only
			,url																	// Url
			,email																// Email
			,city                   							// City
			,fname           											// fname
			,mname         												// mname
			,lname           											// lname
		);
		
    dBIP_dist           := DISTRIBUTE(dBIPOut(Ultid 	!= 0 OR 
																	            OrgID 	!= 0 OR 
																	            ProxID 	!= 0 OR
																            	SELEID 	!= 0 OR
																	            POWID 	!= 0 OR 
																	            EmpID 	!= 0 OR 
																	            DotID 	!= 0), unique_id);
		dInput             := DISTRIBUTE(dAddUniqueId, unique_id);

		Equifax_Business_Data.Layouts.Base tAssignLinkids(Equifax_Business_Data.Layouts.Temp.UniqueId L,Equifax_Business_Data.Layouts.Temp.BIPSlim R) := TRANSFORM
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

		full_update_LinkID := JOIN(dInput
												    ,dBIP_dist
												    ,LEFT.unique_id = RIGHT.unique_id
												    ,tAssignLinkids(LEFT, RIGHT)
												    ,LEFT OUTER
												    ,LOCAL);
		
		RETURN full_update_LinkID;
				      
	END; // End fAppendBIP

	
	EXPORT fAll(DATASET(Equifax_Business_Data.Layouts.Base) pDataset) := FUNCTION
    
		dAppendDid    := fAppendDid(pDataset);
	
		dAppendLinkID	:= fAppendBIP(dAppendDid) : PERSIST(Persistnames().AppendIds);
		
		RETURN dAppendLinkID;
	
	END;

END;