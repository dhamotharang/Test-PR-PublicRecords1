IMPORT business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2;

EXPORT Append_DIDs_Contacts := MODULE

	//////////////////////////////////////////////////////////////////////////////////////
	// -- FUNCTION: fAppendDid
	// -- Standardizes names
	//////////////////////////////////////////////////////////////////////////////////////
	EXPORT fAppendDid(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pDataset) :=	FUNCTION

		Equifax_Business_Data.Layouts.Temp.UniqueIdContacts tAddUniqueId(Equifax_Business_Data.Layouts.Base_Contacts L, UNSIGNED8 cnt) :=	TRANSFORM
			SELF.unique_id		:= cnt;
			SELF							:= L;
		END;   
		
		dAddUniqueId := PROJECT(pDataset, tAddUniqueId(LEFT,COUNTER));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Diding
	//////////////////////////////////////////////////////////////////////////////////////
	Equifax_Business_Data.Layouts.Temp.DidSlim tSlimForDiding(Equifax_Business_Data.Layouts.temp.UniqueIdContacts l) :=
	transform
		self.unique_id    := l.unique_id															;
		self.fname				:= l.clean_name.fname		    					;
		self.mname				:= l.clean_name.mname	 	    					;
		self.lname				:= l.clean_name.lname									;
		self.name_suffix	:= l.clean_name.name_suffix						;
		self.prim_range		:= l.clean_company_address.prim_range	;
		self.prim_name		:= l.clean_company_address.prim_name	;
		self.sec_range		:= l.clean_company_address.sec_range	;
		self.zip5		 			:= l.clean_company_address.zip				;
		self.state		    := l.clean_company_address.st					;
		self.phone				:= l.clean_company_phone  	  				;
		self.dob					:= ''																	;	
		self.ssn					:= ''																	;
		self.did					:= 0  																;
		self.did_score		:= 0  																;
		self		 	    		:= l  																;
  end;	
		
	dSlimForDiding	:= project(dAddUniqueId(clean_name.fname != '' OR clean_name.lname != ''),tSlimForDiding(left));
			
	// Match to Headers by subject Name and Address and phone
	Did_Matchset := ['A','P'];

	DID_Add.MAC_Match_Flex(
		 dSlimForDiding															// Input Dataset
		,Did_Matchset             									// Did_Matchset  what fields to match on
		,ssn                	    									// ssn
		,dob                 												// dob
		,fname																			// fname
		,mname 			     														// mname
		,lname			     														// lname
		,name_suffix     														// name_suffix
		,prim_range	          	    								// prim_range
		,prim_name	          											// prim_name
		,sec_range	          											// sec_range
		,zip5				        												// zip5
		,state			          											// state
		,phone			          											// phone10
		,did                      									// Did
		,Layouts.Temp.DidSlim  						      		// output layout
		,TRUE                     									// Does output record have the score
		,did_score                									// did score field
		,75                       									// score threshold
		,dDidOut																		// output dataset			
	);                         

    dGoodDIDs := DISTRIBUTE(dDidOut(did != 0), unique_id);
		dInput    := DISTRIBUTE(dAddUniqueId, unique_id);

		Equifax_Business_Data.Layouts.Base_Contacts tAssignDIDs(Equifax_Business_Data.Layouts.Temp.UniqueIdContacts L,Equifax_Business_Data.Layouts.Temp.DidSlim R) := TRANSFORM
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
	
	EXPORT fAll(DATASET(Equifax_Business_Data.Layouts.Base_Contacts) pDataset) := FUNCTION
    
		dAppendDid    := fAppendDid(pDataset)
		:PERSIST(Equifax_Business_Data.Persistnames().AppendDIDsContacts)
		;
	
		RETURN dAppendDid;
	
	END;

END;