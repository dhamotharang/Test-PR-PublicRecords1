import Address, Ut, lib_stringlib, _Control, business_header,_Validate,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS,watchdog,Business_HeaderV2;
export Append_DID(

	dataset(Layouts.Base.Contacts) pDataset

) :=
function
	
	//////////////////////////////////////////////////////////////////////////////////////
	// -- Slim record for Diding
	//////////////////////////////////////////////////////////////////////////////////////
	Layouts.Temporary.DidSlim tSlimForDiding(Layouts.Base.Contacts l) :=
	transform
		self.unique_id		:= l.rid															;
		self.fname				:= l.clean_name.fname		    					;
		self.mname				:= l.clean_name.mname	 	    					;
		self.lname				:= l.clean_name.lname									;
		self.name_suffix	:= l.clean_name.name_suffix						;
		self.prim_range		:= l.clean_company_address.prim_range	;
		self.prim_name		:= l.clean_company_address.prim_name	;
		self.sec_range		:= l.clean_company_address.sec_range	;
		self.zip5		 			:= l.clean_company_address.zip				;
		self.state		    := l.clean_company_address.st					;
		self.phone				:= l.company_phone10									;
		self.dob					:= ''																	;	
		self.ssn					:= ''																	;
		self.did					:= 0  																;
		self.did_score		:= 0  																;
		self		 	    		:= l  																;
	end;
		
	dSlimForDiding	:= project(pDataset,tSlimForDiding(left));
	
	// Match to Headers by subject Name and Address and phone
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
		,false
		,true
		,ssn
		,dDidOut_patched
	);

	dDidOut_dist			:= distribute	(dDidOut_patched(did != 0)	,unique_id );
	dDidOut_sort			:= sort				(dDidOut_dist				,unique_id, -did_score	,local);
	dDidOut_dedup			:= dedup			(dDidOut_sort				,unique_id ,local);
	
	dAddUniqueId_dist := distribute	(pDataset						,rid	);

		 
	Layouts.Base.Contacts tAssignDIDs(Layouts.Base.Contacts l, Layouts.Temporary.DidSlim r) :=
	transform

		self.did				:= if(r.did				<> 0	,r.did				,0);
//		self.did_score	:= if(r.did_score <> 0	,r.did_score	,0);
		self 						:= l;

	end;

	dAssignDids := join( 
								 dAddUniqueId_dist
								,dDidOut_dedup
								,left.rid = right.unique_id
								,tAssignDIDs(left, right)
								,left outer
								,local
						);
	
	return dAssignDids;

end;
