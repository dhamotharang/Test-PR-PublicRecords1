IMPORT business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2;

EXPORT Append_Ids := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendSrcRec
	// -- Add Source Rec
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendSrcRec(DATASET(QA_Data.Layouts.Base) pDataset) :=	FUNCTION

		QA_Data.Layouts.Base tAddSrcRec(QA_Data.Layouts.Base L) :=	TRANSFORM
	    SELF.source_rec_id := HASH64(				 L.rawAddr.MasterAddressId
	                              + '~1~'  + L.rawAddr.Company
	                              + '~2~'  + L.rawAddr.AddressOne
	                              + '~3~'  + L.rawAddr.FirstName
	                              + '~4~'  + L.rawAddr.AddressTwo
	                              + '~5~'  + L.rawAddr.LastName
	                              + '~6~'  + L.rawAddr.MiddleInitial
	                              + '~7~'  + L.rawTrans.AddressOne
	                              + '~8~'  + L.rawAddr.PostDirection
	                              + '~9~'  + L.rawTrans.Date
	                              + '~10~' + L.rawAddr.StreetType
	                              + '~11~' + L.rawTrans.Name
	                              + '~12~' + L.rawAddr.DatabaseMatchCode
	                              + '~13~' + L.rawTrans.Category
	                              + '~14~' + L.rawAddr.HomeBusinessFlag
	                              + '~15~' + L.rawTrans.Subcategory
	                              + '~16~' + L.rawAddr.PreDirection
	                              + '~17~' + L.rawTrans.Company
	                              + '~17~' + L.rawAddr.Phone
	                              + '~18~' + L.rawTrans.AddressTwo
	                              + '~19~' + L.rawAddr.Other
	                              + '~20~' + L.rawTrans.City
	                              + '~21~' + L.rawTrans.State
	                              + '~22~' + L.rawAddr.StreetNumber
	                              + '~23~' + L.rawAddr.StreetName
	                              + '~24~' + L.rawTrans.PostalCode
	                              + '~25~' + L.rawAddr.Extension
	                              + '~26~' + L.rawAddr.BlockGroup
	                              + '~27~' + L.rawAddr.StateNumber
	                              + '~28~' + L.rawAddr.CongressDistrict
	                              + '~29~' + L.rawAddr.CountyNumber
	                              + '~30~' + L.rawAddr.Longitude
	                              + '~31~' + L.rawAddr.ExtensionNumber
	                              + '~32~' + L.rawAddr.Village
	                              + '~33~' + L.rawAddr.DPVFootnote
	                              + '~34~' + L.rawAddr.City
	                              + '~35~' + L.rawAddr.DPV
	                              + '~36~' + L.rawAddr.County
	                              + '~37~' + L.rawAddr.CensusTract
	                              + '~38~' + L.rawAddr.CMRA
	                              + '~39~' + L.rawAddr.State
	                              + '~40~' + L.rawAddr.DeliveryPointCheckDigit
	                              + '~41~' + L.rawAddr.ZipPlus4
	                              + '~42~' + L.rawAddr.DeliveryPoint
	                              + '~43~' + L.rawAddr.ZipCode
	                              + '~44~' + L.rawAddr.PMBDesignator
	                              + '~45~' + L.rawAddr.ZipAddOn
	                              + '~46~' + L.rawAddr.Latitude
	                              + '~47~' + L.rawAddr.CarrierRoute
	                              + '~48~' + L.rawAddr.BlockNumber
	                              + '~49~' + L.rawAddr.PMB);	
			SELF							    := L;
		END;   
		
		dAddSrcRec := PROJECT(pDataset, tAddSrcRec(LEFT));

		RETURN dAddSrcRec;			
        
	END;  // End fAppendSrcRec

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendDid
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendDid(DATASET(QA_Data.Layouts.Base) pDataset) :=	FUNCTION

		QA_Data.Layouts.Temporary.UniqueId tAddUniqueId(QA_Data.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));

    QA_Data.Layouts.Temporary.DidSlim taddDID(QA_Data.Layouts.Temporary.UniqueId L) :=  TRANSFORM
	    SELF.fname            := L.clean_person_name.fname;
	    SELF.mname            := L.clean_person_name.mname;
	    SELF.lname            := L.clean_person_name.lname;
	    SELF.name_suffix      := L.clean_person_name.name_suffix;
			SELF.prim_range       := L.Addr_address.prim_range;
			SELF.prim_name        := L.Addr_address.prim_name;
			SELF.sec_range        := L.Addr_address.sec_range;
			SELF.zip5             := L.Addr_address.zip;
			SELF.state            := L.Addr_address.st;
      SELF.phone            := L.clean_phone;      
			SELF.did              := 0;
			SELF.did_score		    := 0;
			SELF			            := L;
			SELF							    := [];
		END;

    dSlimInput	:= project(dAddUniqueId(clean_person_name.fname != '' OR clean_person_name.lname != ''),taddDID(LEFT));
    
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
	    QA_Data.Layouts.Temporary.DidSlim,   //Output rec layout
	    TRUE,                                //Output record has did score field
			did_score,	                         //DID score field
	    75,	                                 //DIDs with a score below here will be dropped 	
	    postDID);	                           //Outfile


    dGoodDIDs := DISTRIBUTE(postDID(did != 0), unique_id);
		dInput    := DISTRIBUTE(dAddUniqueId, unique_id);

		QA_Data.Layouts.Base tAssignDIDs(QA_Data.Layouts.Temporary.UniqueId L,QA_Data.Layouts.Temporary.DidSlim R) := TRANSFORM
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
	EXPORT fAppendBIP(DATASET(QA_Data.Layouts.Base) pDataset) :=	FUNCTION

		QA_Data.Layouts.Temporary.UniqueId tAddUniqueId(QA_Data.Layouts.Base L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));
		
		//////////////////////////////////////////////////////////////////////////////////////
		// -- Slim record for linkIDs
		//////////////////////////////////////////////////////////////////////////////////////
		QA_Data.Layouts.Temporary.BIPSlim tSlimForBIPing(QA_Data.Layouts.Temporary.UniqueId L) := TRANSFORM
			SELF.unique_id		    := L.unique_id;
			SELF.company  		    := L.clean_company;
	    SELF.fname            := L.clean_person_name.fname;
	    SELF.mname            := L.clean_person_name.mname;
	    SELF.lname            := L.clean_person_name.lname;
			SELF.prim_range       := L.Addr_address.prim_range;
			SELF.prim_name        := L.Addr_address.prim_name;
			SELF.sec_range        := L.Addr_address.sec_range;
			SELF.city       	    := L.Addr_address.p_city_name;
			SELF.zip5             := L.Addr_address.zip;
			SELF.state            := L.Addr_address.st;
      SELF.phone            := L.clean_phone;      
			SELF							    := [];
		END;
		
    dSlimInput	:= project(dAddUniqueId(clean_company <> '') ,tSlimForBIPing(LEFT));
    
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
			,bdid_not_used								        // bdid												
			,QA_Data.Layouts.Temporary.BIPSlim    // Output Layout 
			,FALSE                                // output layout has bdid score field?                       
			,bdid_score_not_used                  // bdid_score                 
			,dBIPOut                              // Output Dataset   
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_only_set                 // Create LinkID's only
			,Website_Url_not_used									// Url
			,Email_not_used												// Email
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

		QA_Data.Layouts.Base tAssignLinkids(QA_Data.Layouts.Temporary.UniqueId L,QA_Data.Layouts.Temporary.BIPSlim R) := TRANSFORM
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

	
	EXPORT fAll(DATASET(QA_Data.Layouts.Base) pDataset, STRING pversion) := FUNCTION
    
		dAppendSrcRec := fAppendSrcRec(pDataset);

		dAppendDid    := fAppendDid(dAppendSrcRec);
	
		dAppendLinkID	:= fAppendBIP(dAppendDid) : PERSIST(Persistnames().AppendIds);
		
		RETURN dAppendLinkID;
	
	END;

END;